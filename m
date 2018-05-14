Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeENL0J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:26:09 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35802 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeENLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:25:42 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, goliath@sigma-star.at,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/5] ubinize: Add fastmap support
Date: Mon, 14 May 2018 13:25:28 +0200
Message-Id: <20180514112528.24092-6-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112528.24092-1-richard@nod.at>
References: <20180514112528.24092-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the "-F" parameter, ubinize can now create ubinized images
with a preseeded fastmap on it.
You need a recent kernel with UBI_FM_SB_PRESEEDED_FLG support to
attach from such a fastmap.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/libubigen.h   |  17 +++-
 lib/libubigen.c       | 224 ++++++++++++++++++++++++++++++++++++++++++++++----
 ubi-utils/ubiformat.c |   6 +-
 ubi-utils/ubinize.c   |  76 +++++++++++++----
 4 files changed, 283 insertions(+), 40 deletions(-)

diff --git a/include/libubigen.h b/include/libubigen.h
index 6073a2d72e05..7b50d903300c 100644
--- a/include/libubigen.h
+++ b/include/libubigen.h
@@ -110,6 +110,10 @@ void ubigen_info_init(struct ubigen_info *ui, int peb_size, int min_io_size,
 		      int subpage_size, int vid_hdr_offs, int ubi_ver,
 		      uint32_t image_seq);
 
+int ubigen_fastmap_size(struct ubigen_info *ui,
+			struct ubigen_vol_info *vols[], int vol_count,
+			struct ubigen_vol_info *layout_vol);
+
 /**
  * ubigen_create_empty_vtbl - creates empty volume table.
  * @ui: libubigen information
@@ -171,13 +175,18 @@ int ubigen_add_volume(const struct ubigen_info *ui,
  * writes the UBI volume to the output file @out. Returns zero on success and
  * %-1 on failure.
  */
-int ubigen_write_volume(const struct ubigen_info *ui,
+int ubigen_write_volume(struct ubigen_info *ui,
 			const struct ubigen_vol_info *vi, long long ec,
 			int in, int out);
 
+int ubigen_write_fastmap(struct ubigen_info *ui,
+			 struct ubigen_vol_info *layout_vi,
+			 int vol_count, struct ubigen_vol_info *vols[],
+			 int ec, int out_fd);
 /**
  * ubigen_write_layout_vol - write UBI layout volume
  * @ui: libubigen information
+ * @vi: volume information
  * @peb1: physical eraseblock number to write the first volume table copy
  * @peb2: physical eraseblock number to write the second volume table copy
  * @ec1: erase counter value for @peb1
@@ -188,10 +197,12 @@ int ubigen_write_volume(const struct ubigen_info *ui,
  * This function creates the UBI layout volume which contains 2 copies of the
  * volume table. Returns zero in case of success and %-1 in case of failure.
  */
-int ubigen_write_layout_vol(const struct ubigen_info *ui, int peb1, int peb2,
-			    long long ec1, long long ec2,
+int ubigen_write_layout_vol(struct ubigen_info *ui, struct ubigen_vol_info *vi,
+			    int peb1, int peb2, long long ec1, long long ec2,
 			    struct ubi_vtbl_record *vtbl, int fd);
 
+struct ubigen_vol_info *ubigen_init_layout_vi(const struct ubigen_info *ui);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/libubigen.c b/lib/libubigen.c
index f509d4d072bd..05a27e639a49 100644
--- a/lib/libubigen.c
+++ b/lib/libubigen.c
@@ -30,13 +30,31 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <string.h>
+#include <sys/param.h> /* roundup() */
 
 #include <mtd/ubi-media.h>
+#include <mtd/ubi-user.h>
 #include <mtd_swab.h>
 #include <libubigen.h>
 #include <crc32.h>
 #include "common.h"
 
+static size_t calc_fastmap_size(struct ubigen_info *ui, int peb_count)
+{
+	size_t size;
+
+	size = sizeof(struct ubi_fm_sb) +
+		sizeof(struct ubi_fm_hdr) +
+		sizeof(struct ubi_fm_scan_pool) +
+		sizeof(struct ubi_fm_scan_pool) +
+		(peb_count * sizeof(struct ubi_fm_ec)) +
+		(sizeof(struct ubi_fm_eba) +
+		(peb_count * sizeof(__be32))) +
+		sizeof(struct ubi_fm_volhdr) * UBI_MAX_VOLUMES;
+
+	return roundup(size, ui->leb_size);
+}
+
 void ubigen_info_init(struct ubigen_info *ui, int peb_size, int min_io_size,
 		      int subpage_size, int vid_hdr_offs, int ubi_ver,
 		      uint32_t image_seq)
@@ -63,6 +81,19 @@ void ubigen_info_init(struct ubigen_info *ui, int peb_size, int min_io_size,
 	ui->vtbl_size = ui->max_volumes * UBI_VTBL_RECORD_SIZE;
 }
 
+int ubigen_fastmap_size(struct ubigen_info *ui,
+			struct ubigen_vol_info *vols[], int vol_count,
+			struct ubigen_vol_info *layout_vol)
+{
+	int i;
+	int vol_pebs = layout_vol->used_ebs;
+
+	for (i = 0; i < vol_count; i++)
+		vol_pebs += vols[i]->used_ebs;
+
+	return calc_fastmap_size(ui, vol_pebs + UBI_FM_MAX_BLOCKS);
+}
+
 struct ubi_vtbl_record *ubigen_create_empty_vtbl(const struct ubigen_info *ui)
 {
 	struct ubi_vtbl_record *vtbl;
@@ -168,11 +199,31 @@ void ubigen_init_vid_hdr(const struct ubigen_info *ui,
 	hdr->hdr_crc = cpu_to_be32(crc);
 }
 
-int ubigen_write_volume(const struct ubigen_info *ui,
+static void ubigen_init_fm_vid_hdr(const struct ubigen_info *ui,
+				   struct ubi_vid_hdr *hdr, int vol_id,
+				   int lnum)
+{
+	uint32_t crc;
+
+	memset(hdr, 0, sizeof(struct ubi_vid_hdr));
+
+	hdr->magic = cpu_to_be32(UBI_VID_HDR_MAGIC);
+	hdr->version = ui->ubi_ver;
+	hdr->vol_type = UBI_VID_DYNAMIC;
+	hdr->vol_id = cpu_to_be32(vol_id);
+	hdr->lnum = cpu_to_be32(lnum);
+	hdr->compat = UBI_COMPAT_DELETE;
+	hdr->sqnum = cpu_to_be64(1);
+
+	crc = mtd_crc32(UBI_CRC32_INIT, hdr, UBI_VID_HDR_SIZE_CRC);
+	hdr->hdr_crc = cpu_to_be32(crc);
+}
+
+int ubigen_write_volume(struct ubigen_info *ui,
 			const struct ubigen_vol_info *vi, long long ec,
 			int in, int out)
 {
-	int len = vi->usable_leb_size, rd, lnum = 0;
+	int len = vi->usable_leb_size, rd, lnum;
 	long long bytes = vi->image_file_len;
 	char *inbuf, *outbuf;
 
@@ -259,27 +310,144 @@ out_free:
 	return -1;
 }
 
-int ubigen_write_layout_vol(const struct ubigen_info *ui, int peb1, int peb2,
-			    long long ec1, long long ec2,
+int ubigen_write_fastmap(struct ubigen_info *ui,
+			 struct ubigen_vol_info *layout_vi,
+			 int vol_count, struct ubigen_vol_info *vols[],
+			 int ec, int out_fd)
+{
+	int i, j, ret;
+	struct ubi_fm_sb *fmsb;
+	struct ubi_fm_hdr *fmh;
+	struct ubi_fm_scan_pool *fmpl, *fmpl_wl;
+	struct ubi_fm_ec *fec;
+	struct ubi_fm_volhdr *fvh;
+	struct ubi_fm_eba *feba;
+	struct ubigen_vol_info *vi;
+	size_t fm_pos = 0;
+	size_t fm_size = ubigen_fastmap_size(ui, vols, vol_count, layout_vi);
+	char *fm_raw = xcalloc(1, fm_size);
+	char *peb_buf = xmalloc(ui->peb_size);
+	int fm_pebs = fm_size / ui->leb_size;
+	int pebs_used = 0;
+
+
+	fmsb = (struct ubi_fm_sb *)fm_raw;
+	fm_pos += sizeof(*fmsb);
+
+	fmsb->magic = cpu_to_be32(UBI_FM_SB_MAGIC);
+	fmsb->version = 2;
+	fmsb->used_blocks = cpu_to_be32(fm_pebs);
+	fmsb->sqnum = 0;
+	fmsb->data_crc = 0;
+	fmsb->flags = cpu_to_be32(UBI_FM_SB_PRESEEDED_FLG);
+
+	for (i = 0; i < fm_pebs; i++) {
+		fmsb->block_loc[i] = cpu_to_be32(layout_vi->used_ebs + i);
+		fmsb->block_ec[i] = cpu_to_be32(ec);
+	}
+
+	fmh = (struct ubi_fm_hdr *)(fm_raw + fm_pos);
+	fm_pos += sizeof(*fmh);
+
+	fmh->magic = cpu_to_be32(UBI_FM_HDR_MAGIC);
+	fmh->vol_count = cpu_to_be32(vol_count + 1);
+	fmh->free_peb_count = 0;
+	fmh->scrub_peb_count = 0;
+	fmh->erase_peb_count = 0;
+	fmh->bad_peb_count = 0;
+
+	fmpl = (struct ubi_fm_scan_pool *)(fm_raw + fm_pos);
+	fm_pos += sizeof(*fmpl);
+
+	fmpl->magic = cpu_to_be32(UBI_FM_POOL_MAGIC);
+	fmpl->size = 0;
+	fmpl->max_size = 0;
+
+	fmpl_wl = (struct ubi_fm_scan_pool *)(fm_raw + fm_pos);
+	fm_pos += sizeof(*fmpl_wl);
+
+	fmpl_wl->magic = cpu_to_be32(UBI_FM_POOL_MAGIC);
+        fmpl_wl->size = 0;
+        fmpl_wl->max_size = 0;
+
+	for (i = 0; i < vol_count + 1; i++) {
+		if (i == vol_count)
+			vi = layout_vi;
+		else
+			vi = vols[i];
+
+		for (j = 0; j < vi->used_ebs; j++) {
+			fec = (struct ubi_fm_ec *)(fm_raw + fm_pos);
+
+			if (vi->eba[j] > -1) {
+				fec->pnum = cpu_to_be32(vi->eba[j]);
+				fec->ec = cpu_to_be32(ec);
+				pebs_used++;
+				fm_pos += sizeof(*fec);
+			}
+		}
+	}
+
+	fmh->used_peb_count = cpu_to_be32(pebs_used);
+
+	for (i = 0; i < vol_count + 1; i++) {
+		if (i == vol_count)
+			vi = layout_vi;
+		else
+			vi = vols[i];
+
+		fvh = (struct ubi_fm_volhdr *)(fm_raw + fm_pos);
+		fm_pos += sizeof(*fvh);
+
+		fvh->magic = cpu_to_be32(UBI_FM_VHDR_MAGIC);
+		fvh->vol_id = cpu_to_be32(vi->id);
+		fvh->vol_type = vi->type == UBI_VID_DYNAMIC ? UBI_DYNAMIC_VOLUME : UBI_STATIC_VOLUME;
+		fvh->used_ebs = cpu_to_be32(vi->used_ebs);
+		fvh->data_pad = cpu_to_be32(vi->data_pad);
+		fvh->last_eb_bytes = cpu_to_be32(vi->bytes % vi->usable_leb_size);
+
+		feba = (struct ubi_fm_eba *)(fm_raw + fm_pos);
+		fm_pos += sizeof(*feba) + (sizeof(__be32) * vi->used_ebs);
+
+		feba->magic = cpu_to_be32(UBI_FM_EBA_MAGIC);
+		feba->reserved_pebs = cpu_to_be32(vi->used_ebs);
+		for (j = 0; j < vi->used_ebs; j++)
+			feba->pnum[j] = cpu_to_be32(vi->eba[j]);
+	}
+
+	fmsb->data_crc = cpu_to_be32(mtd_crc32(UBI_CRC32_INIT, fm_raw, fm_size));
+
+	for (i = 0; i < fm_pebs; i++) {
+		int vol_id = i == 0 ? UBI_FM_SB_VOLUME_ID : UBI_FM_DATA_VOLUME_ID;
+
+		memset(peb_buf, 0xff, ui->peb_size);
+
+		ubigen_init_ec_hdr(ui, (struct ubi_ec_hdr *)peb_buf, ec);
+		ubigen_init_fm_vid_hdr(ui, (struct ubi_vid_hdr *)(peb_buf + ui->vid_hdr_offs), vol_id, i);
+		memcpy(peb_buf + ui->data_offs, fm_raw + ui->leb_size * i, ui->leb_size);
+		ret = write(out_fd, peb_buf, ui->peb_size);
+		if (ret != ui->peb_size) {
+			sys_errmsg("cannot write %d bytes", ui->peb_size);
+			goto out;
+		}
+	}
+
+	ret = 0;
+out:
+	free(fm_raw);
+	free(peb_buf);
+	return ret;
+}
+
+int ubigen_write_layout_vol(struct ubigen_info *ui, struct ubigen_vol_info *vi,
+			    int peb1, int peb2, long long ec1, long long ec2,
 			    struct ubi_vtbl_record *vtbl, int fd)
 {
 	int ret;
-	struct ubigen_vol_info vi;
 	char *outbuf;
 	struct ubi_vid_hdr *vid_hdr;
 	off_t seek;
 
-	vi.bytes = ui->leb_size * UBI_LAYOUT_VOLUME_EBS;
-	vi.id = UBI_LAYOUT_VOLUME_ID;
-	vi.alignment = UBI_LAYOUT_VOLUME_ALIGN;
-	vi.data_pad = ui->leb_size % UBI_LAYOUT_VOLUME_ALIGN;
-	vi.usable_leb_size = ui->leb_size - vi.data_pad;
-	vi.data_pad = ui->leb_size - vi.usable_leb_size;
-	vi.type = UBI_LAYOUT_VOLUME_TYPE;
-	vi.name = UBI_LAYOUT_VOLUME_NAME;
-	vi.name_len = strlen(UBI_LAYOUT_VOLUME_NAME);
-	vi.compat = UBI_LAYOUT_VOLUME_COMPAT;
-
 	outbuf = malloc(ui->peb_size);
 	if (!outbuf)
 		return sys_errmsg("failed to allocate %d bytes",
@@ -299,7 +467,7 @@ int ubigen_write_layout_vol(const struct ubigen_info *ui, int peb1, int peb2,
 	vi->eba[0] = peb1;
 
 	ubigen_init_ec_hdr(ui, (struct ubi_ec_hdr *)outbuf, ec1);
-	ubigen_init_vid_hdr(ui, &vi, vid_hdr, 0, NULL, 0);
+	ubigen_init_vid_hdr(ui, vi, vid_hdr, 0, NULL, 0);
 	ret = write(fd, outbuf, ui->peb_size);
 	if (ret != ui->peb_size) {
 		sys_errmsg("cannot write %d bytes", ui->peb_size);
@@ -314,7 +482,7 @@ int ubigen_write_layout_vol(const struct ubigen_info *ui, int peb1, int peb2,
 	vi->eba[1] = peb2;
 
 	ubigen_init_ec_hdr(ui, (struct ubi_ec_hdr *)outbuf, ec2);
-	ubigen_init_vid_hdr(ui, &vi, vid_hdr, 1, NULL, 0);
+	ubigen_init_vid_hdr(ui, vi, vid_hdr, 1, NULL, 0);
 	ret = write(fd, outbuf, ui->peb_size);
 	if (ret != ui->peb_size) {
 		sys_errmsg("cannot write %d bytes", ui->peb_size);
@@ -328,3 +496,23 @@ out_free:
 	free(outbuf);
 	return -1;
 }
+
+struct ubigen_vol_info *ubigen_init_layout_vi(const struct ubigen_info *ui)
+{
+	struct ubigen_vol_info *vi = xmalloc(sizeof(*vi));
+
+	vi->bytes = ui->leb_size * UBI_LAYOUT_VOLUME_EBS;
+	vi->id = UBI_LAYOUT_VOLUME_ID;
+	vi->alignment = UBI_LAYOUT_VOLUME_ALIGN;
+	vi->data_pad = ui->leb_size % UBI_LAYOUT_VOLUME_ALIGN;
+	vi->usable_leb_size = ui->leb_size - vi->data_pad;
+	vi->data_pad = ui->leb_size - vi->usable_leb_size;
+	vi->type = UBI_LAYOUT_VOLUME_TYPE;
+	vi->name = UBI_LAYOUT_VOLUME_NAME;
+	vi->name_len = strlen(UBI_LAYOUT_VOLUME_NAME);
+	vi->compat = UBI_LAYOUT_VOLUME_COMPAT;
+	vi->used_ebs = 2;
+	vi->eba = xcalloc(vi->used_ebs, sizeof(int));
+
+	return vi;
+}
diff --git a/ubi-utils/ubiformat.c b/ubi-utils/ubiformat.c
index c38b9b4abb16..a333246ecf77 100644
--- a/ubi-utils/ubiformat.c
+++ b/ubi-utils/ubiformat.c
@@ -553,7 +553,7 @@ out_close:
 }
 
 static int format(libmtd_t libmtd, const struct mtd_dev_info *mtd,
-		  const struct ubigen_info *ui, struct ubi_scan_info *si,
+		  struct ubigen_info *ui, struct ubi_scan_info *si,
 		  int start_eb, int novtbl)
 {
 	int eb, err, write_size;
@@ -655,6 +655,8 @@ static int format(libmtd_t libmtd, const struct mtd_dev_info *mtd,
 		printf("\n");
 
 	if (!novtbl) {
+		struct ubigen_vol_info *layout_vi = ubigen_init_layout_vi(ui);
+
 		if (eb1 == -1 || eb2 == -1) {
 			errmsg("no eraseblocks for volume table");
 			goto out_free;
@@ -665,7 +667,7 @@ static int format(libmtd_t libmtd, const struct mtd_dev_info *mtd,
 		if (!vtbl)
 			goto out_free;
 
-		err = ubigen_write_layout_vol(ui, eb1, eb2, ec1,  ec2, vtbl,
+		err = ubigen_write_layout_vol(ui, layout_vi, eb1, eb2, ec1,  ec2, vtbl,
 					      args.node_fd);
 		free(vtbl);
 		if (err) {
diff --git a/ubi-utils/ubinize.c b/ubi-utils/ubinize.c
index 62ddd7b85296..08048eceb33a 100644
--- a/ubi-utils/ubinize.c
+++ b/ubi-utils/ubinize.c
@@ -82,6 +82,7 @@ static const struct option long_options[] = {
 	{ .name = "verbose",        .has_arg = 0, .flag = NULL, .val = 'v' },
 	{ .name = "help",           .has_arg = 0, .flag = NULL, .val = 'h' },
 	{ .name = "version",        .has_arg = 0, .flag = NULL, .val = 'V' },
+	{ .name = "fastmap",        .has_arg = 0, .flag = NULL, .val = 'F' },
 	{ NULL, 0, NULL, 0}
 };
 
@@ -97,6 +98,7 @@ struct args {
 	int ubi_ver;
 	uint32_t image_seq;
 	int verbose;
+	int fastmap;
 	dictionary *dict;
 };
 
@@ -116,7 +118,7 @@ static int parse_opt(int argc, char * const argv[])
 		int key, error = 0;
 		unsigned long int image_seq;
 
-		key = getopt_long(argc, argv, "o:p:m:s:O:e:x:Q:vhV", long_options, NULL);
+		key = getopt_long(argc, argv, "o:p:m:s:O:e:x:Q:vhVF", long_options, NULL);
 		if (key == -1)
 			break;
 
@@ -180,6 +182,10 @@ static int parse_opt(int argc, char * const argv[])
 			args.verbose = 1;
 			break;
 
+		case 'F':
+			args.fastmap = 1;
+			break;
+
 		case 'h':
 			fputs(usage, stdout);
 			fputs(optionsstr, stdout);
@@ -408,6 +414,7 @@ int main(int argc, char * const argv[])
 	struct ubigen_info ui;
 	struct ubi_vtbl_record *vtbl;
 	struct ubigen_vol_info *vi;
+	struct ubigen_vol_info *layout_vi;
 	off_t seek;
 
 	err = parse_opt(argc, argv);
@@ -465,20 +472,11 @@ int main(int argc, char * const argv[])
 		goto out_dict;
 	}
 
-	/*
-	 * Skip 2 PEBs at the beginning of the file for the volume table which
-	 * will be written later.
-	 */
-	seek = ui.peb_size * 2;
-	if (lseek(args.out_fd, seek, SEEK_SET) != seek) {
-		err = -1;
-		sys_errmsg("cannot seek file \"%s\"", args.f_out);
-		goto out_free;
-	}
+	layout_vi = ubigen_init_layout_vi(&ui);
 
 	for (i = 0; i < sects; i++) {
 		const char *sname = iniparser_getsecname(args.dict, i);
-		int fd, j;
+		int j;
 
 		if (!sname) {
 			err = -1;
@@ -531,8 +529,33 @@ int main(int argc, char * const argv[])
 			goto out_free;
 		}
 
+		if (args.verbose)
+			printf("\n");
+	}
+
+	/*
+	 * Skip 2 PEBs at the beginning of the file for the volume table which
+	 * will be written later.
+	 */
+	seek = 2;
+
+	/*
+	 * If Fastmap is enabled we need also some PEBs for it at the beginning.
+	 */
+	if (args.fastmap)
+		seek += ubigen_fastmap_size(&ui, &vi, sects, layout_vi) / ui.leb_size;
+
+	seek *= ui.peb_size;
+
+	if (lseek(args.out_fd, seek, SEEK_SET) != seek) {
+		err = -1;
+		sys_errmsg("cannot seek file \"%s\"", args.f_out);
+		goto out_free;
+	}
+
+	for (i = 0; i < sects; i++) {
 		if (vi[i].image_file) {
-			fd = open(vi[i].image_file, O_RDONLY);
+			int fd = open(vi[i].image_file, O_RDONLY);
 			if (fd == -1) {
 				err = fd;
 				sys_errmsg("cannot open \"%s\"", vi[i].image_file);
@@ -545,27 +568,44 @@ int main(int argc, char * const argv[])
 			err = ubigen_write_volume(&ui, &vi[i], args.ec, fd, args.out_fd);
 			close(fd);
 			if (err) {
-				errmsg("cannot write volume for section \"%s\"", sname);
+				errmsg("cannot write volume \"%s\"", vi[i].name);
 				goto out_free;
 			}
 		}
 
-		if (args.verbose)
-			printf("\n");
 	}
 
 	verbose(args.verbose, "writing layout volume");
 
-	err = ubigen_write_layout_vol(&ui, 0, 1, args.ec, args.ec, vtbl, args.out_fd);
+	err = ubigen_write_layout_vol(&ui, layout_vi, 0, 1, args.ec, args.ec, vtbl, args.out_fd);
 	if (err) {
 		errmsg("cannot write layout volume");
 		goto out_free;
 	}
 
+	if (args.fastmap) {
+		verbose(args.verbose, "writing fastmap");
+
+		if (lseek(args.out_fd, 2 * ui.peb_size, SEEK_SET) != 2 * ui.peb_size) {
+			err = -1;
+			sys_errmsg("cannot seek file \"%s\"", args.f_out);
+			goto out_free;
+		}
+
+		err = ubigen_write_fastmap(&ui, layout_vi, sects, &vi, args.ec, args.out_fd);
+		if (err) {
+			errmsg("cannot write fastmap");
+			goto out_free;
+		}
+	}
+
+
 	verbose(args.verbose, "done");
 
 	free(vi->eba);
 	free(vi);
+	free(layout_vi->eba);
+	free(layout_vi);
 	iniparser_freedict(args.dict);
 	free(vtbl);
 	close(args.out_fd);
@@ -573,6 +613,8 @@ int main(int argc, char * const argv[])
 
 out_free:
 	free(vi);
+	free(layout_vi);
+	free(layout_vi->eba);
 out_dict:
 	iniparser_freedict(args.dict);
 out_vtbl:
-- 
2.13.6
