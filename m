Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbeENLZq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:25:46 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35792 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752722AbeENLZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:25:41 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, goliath@sigma-star.at,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/5] libubigen: Maintain a eraseblock association table
Date: Mon, 14 May 2018 13:25:27 +0200
Message-Id: <20180514112528.24092-5-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112528.24092-1-richard@nod.at>
References: <20180514112528.24092-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EBA is needed later for preseeded fastmap support.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/libubigen.h |  1 +
 lib/libubigen.c     | 14 ++++++++++++++
 ubi-utils/ubinize.c |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/include/libubigen.h b/include/libubigen.h
index 8084d0ecddb2..6073a2d72e05 100644
--- a/include/libubigen.h
+++ b/include/libubigen.h
@@ -92,6 +92,7 @@ struct ubigen_vol_info
 	uint8_t flags;
 	const char *image_file;
 	size_t image_file_len;
+	int *eba;
 };
 
 /**
diff --git a/lib/libubigen.c b/lib/libubigen.c
index 900c984229fb..f509d4d072bd 100644
--- a/lib/libubigen.c
+++ b/lib/libubigen.c
@@ -176,6 +176,10 @@ int ubigen_write_volume(const struct ubigen_info *ui,
 	long long bytes = vi->image_file_len;
 	char *inbuf, *outbuf;
 
+	for (lnum = 0; lnum < vi->used_ebs; lnum++)
+		vi->eba[lnum] = -1;
+
+
 	if (vi->id >= ui->max_volumes) {
 		errmsg("too high volume id %d, max. volumes is %d",
 		       vi->id, ui->max_volumes);
@@ -203,6 +207,7 @@ int ubigen_write_volume(const struct ubigen_info *ui,
 	memset(outbuf, 0xFF, ui->data_offs);
 	ubigen_init_ec_hdr(ui, (struct ubi_ec_hdr *)outbuf, ec);
 
+	lnum = 0;
 	while (bytes) {
 		int l;
 		struct ubi_vid_hdr *vid_hdr;
@@ -229,6 +234,12 @@ int ubigen_write_volume(const struct ubigen_info *ui,
 		memset(outbuf + ui->data_offs + len, 0xFF,
 		       ui->peb_size - ui->data_offs - len);
 
+		vi->eba[lnum] = lseek(out, 0, SEEK_CUR) / ui->peb_size;
+		if (vi->eba[lnum] == -1) {
+			sys_errmsg("cannot get offset of output file");
+			goto out_free1;
+		}
+
 		if (write(out, outbuf, ui->peb_size) != ui->peb_size) {
 			sys_errmsg("cannot write %d bytes to the output file", ui->peb_size);
 			goto out_free1;
@@ -285,6 +296,7 @@ int ubigen_write_layout_vol(const struct ubigen_info *ui, int peb1, int peb2,
 		sys_errmsg("cannot seek output file");
 		goto out_free;
 	}
+	vi->eba[0] = peb1;
 
 	ubigen_init_ec_hdr(ui, (struct ubi_ec_hdr *)outbuf, ec1);
 	ubigen_init_vid_hdr(ui, &vi, vid_hdr, 0, NULL, 0);
@@ -299,6 +311,8 @@ int ubigen_write_layout_vol(const struct ubigen_info *ui, int peb1, int peb2,
 		sys_errmsg("cannot seek output file");
 		goto out_free;
 	}
+	vi->eba[1] = peb2;
+
 	ubigen_init_ec_hdr(ui, (struct ubi_ec_hdr *)outbuf, ec2);
 	ubigen_init_vid_hdr(ui, &vi, vid_hdr, 1, NULL, 0);
 	ret = write(fd, outbuf, ui->peb_size);
diff --git a/ubi-utils/ubinize.c b/ubi-utils/ubinize.c
index bffb66ebcbd9..62ddd7b85296 100644
--- a/ubi-utils/ubinize.c
+++ b/ubi-utils/ubinize.c
@@ -398,6 +398,7 @@ static int read_section(const struct ubigen_info *ui, const char *sname,
 	else
 		vi->used_ebs = (st.st_size + vi->usable_leb_size - 1) / vi->usable_leb_size;
 	vi->compat = 0;
+	vi->eba = xcalloc(vi->used_ebs, sizeof(int));
 	return 0;
 }
 
@@ -563,6 +564,7 @@ int main(int argc, char * const argv[])
 
 	verbose(args.verbose, "done");
 
+	free(vi->eba);
 	free(vi);
 	iniparser_freedict(args.dict);
 	free(vtbl);
-- 
2.13.6
