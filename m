Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeENLZo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:25:44 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35782 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752720AbeENLZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:25:41 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, goliath@sigma-star.at,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/5] libubigen: Carry image path and size in volume info
Date: Mon, 14 May 2018 13:25:26 +0200
Message-Id: <20180514112528.24092-4-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112528.24092-1-richard@nod.at>
References: <20180514112528.24092-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...instead of passing them a extra parameters.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/libubigen.h |  7 +++++--
 lib/libubigen.c     |  3 ++-
 ubi-utils/ubinize.c | 41 ++++++++++++++++++++---------------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/include/libubigen.h b/include/libubigen.h
index c25ac20fbdc2..8084d0ecddb2 100644
--- a/include/libubigen.h
+++ b/include/libubigen.h
@@ -74,6 +74,8 @@ struct ubigen_info
  * @bytes: size of the volume contents in bytes (relevant for static volumes
  *         only)
  * @flags: volume flags (%UBI_VTBL_AUTORESIZE_FLG)
+ * @image_file: file to read volume contents from, can be NULL
+ * @image_file_len: length of %image_file in bytes
  */
 struct ubigen_vol_info
 {
@@ -88,6 +90,8 @@ struct ubigen_vol_info
 	int used_ebs;
 	long long bytes;
 	uint8_t flags;
+	const char *image_file;
+	size_t image_file_len;
 };
 
 /**
@@ -159,7 +163,6 @@ int ubigen_add_volume(const struct ubigen_info *ui,
  * @ui: libubigen information
  * @vi: volume information
  * @ec: erase counter value to put to EC headers
- * @bytes: volume size in bytes
  * @in: input file descriptor (has to be properly seeked)
  * @out: output file descriptor
  *
@@ -169,7 +172,7 @@ int ubigen_add_volume(const struct ubigen_info *ui,
  */
 int ubigen_write_volume(const struct ubigen_info *ui,
 			const struct ubigen_vol_info *vi, long long ec,
-			long long bytes, int in, int out);
+			int in, int out);
 
 /**
  * ubigen_write_layout_vol - write UBI layout volume
diff --git a/lib/libubigen.c b/lib/libubigen.c
index d2a949be90c2..900c984229fb 100644
--- a/lib/libubigen.c
+++ b/lib/libubigen.c
@@ -170,9 +170,10 @@ void ubigen_init_vid_hdr(const struct ubigen_info *ui,
 
 int ubigen_write_volume(const struct ubigen_info *ui,
 			const struct ubigen_vol_info *vi, long long ec,
-			long long bytes, int in, int out)
+			int in, int out)
 {
 	int len = vi->usable_leb_size, rd, lnum = 0;
+	long long bytes = vi->image_file_len;
 	char *inbuf, *outbuf;
 
 	if (vi->id >= ui->max_volumes) {
diff --git a/ubi-utils/ubinize.c b/ubi-utils/ubinize.c
index 3390d0d95305..bffb66ebcbd9 100644
--- a/ubi-utils/ubinize.c
+++ b/ubi-utils/ubinize.c
@@ -241,13 +241,13 @@ static int parse_opt(int argc, char * const argv[])
 }
 
 static int read_section(const struct ubigen_info *ui, const char *sname,
-			struct ubigen_vol_info *vi, const char **img,
-			struct stat *st)
+			struct ubigen_vol_info *vi)
 {
 	char buf[256];
 	const char *p;
+	struct stat st;
 
-	*img = NULL;
+	vi->image_file = NULL;
 
 	if (strlen(sname) > 128)
 		return errmsg("too long section name \"%s\"", sname);
@@ -294,13 +294,14 @@ static int read_section(const struct ubigen_info *ui, const char *sname,
 	sprintf(buf, "%s:image", sname);
 	p = iniparser_getstring(args.dict, buf, NULL);
 	if (p) {
-		*img = p;
-		if (stat(p, st))
+		vi->image_file = p;
+		if (stat(p, &st))
 			return sys_errmsg("cannot stat \"%s\" referred from section \"%s\"",
 					  p, sname);
-		if (st->st_size == 0)
+		if (st.st_size == 0)
 			return errmsg("empty file \"%s\" referred from section \"%s\"",
 				       p, sname);
+		vi->image_file_len = st.st_size;
 	} else if (vi->type == UBI_VID_STATIC)
 		return errmsg("image is not specified for static volume in section \"%s\"",
 			      sname);
@@ -329,24 +330,24 @@ static int read_section(const struct ubigen_info *ui, const char *sname,
 				      p, sname);
 
 		/* Make sure the image size is not larger than volume size */
-		if (*img && st->st_size > vi->bytes)
+		if (vi->image_file && st.st_size > vi->bytes)
 			return errmsg("error in section \"%s\": size of the image file "
 				      "\"%s\" is %lld, which is larger than volume size %lld",
-				      sname, *img, (long long)st->st_size, vi->bytes);
+				      sname, vi->image_file, (long long)st.st_size, vi->bytes);
 		verbose(args.verbose, "volume size: %lld bytes", vi->bytes);
 	} else {
-		if (!*img)
+		if (!vi->image_file)
 			return errmsg("neither image file (\"image=\") nor volume size "
 				      "(\"vol_size=\") specified in section \"%s\"", sname);
 
-		vi->bytes = st->st_size;
+		vi->bytes = st.st_size;
 
 		if (vi->bytes == 0)
 			return errmsg("file \"%s\" referred from section \"%s\" is empty",
-				      *img, sname);
+				      vi->image_file, sname);
 
 		normsg_cont("volume size was not specified in section \"%s\", assume"
-			    " minimum to fit image \"%s\"", sname, *img);
+			    " minimum to fit image \"%s\"", sname, vi->image_file);
 		util_print_bytes(vi->bytes, 1);
 		printf("\n");
 	}
@@ -395,7 +396,7 @@ static int read_section(const struct ubigen_info *ui, const char *sname,
 	if (vi->type == UBI_VID_DYNAMIC)
 		vi->used_ebs = (vi->bytes + vi->usable_leb_size - 1) / vi->usable_leb_size;
 	else
-		vi->used_ebs = (st->st_size + vi->usable_leb_size - 1) / vi->usable_leb_size;
+		vi->used_ebs = (st.st_size + vi->usable_leb_size - 1) / vi->usable_leb_size;
 	vi->compat = 0;
 	return 0;
 }
@@ -476,8 +477,6 @@ int main(int argc, char * const argv[])
 
 	for (i = 0; i < sects; i++) {
 		const char *sname = iniparser_getsecname(args.dict, i);
-		const char *img = NULL;
-		struct stat st;
 		int fd, j;
 
 		if (!sname) {
@@ -490,7 +489,7 @@ int main(int argc, char * const argv[])
 			printf("\n");
 		verbose(args.verbose, "parsing section \"%s\"", sname);
 
-		err = read_section(&ui, sname, &vi[i], &img, &st);
+		err = read_section(&ui, sname, &vi[i]);
 		if (err == -1)
 			goto out_free;
 
@@ -531,18 +530,18 @@ int main(int argc, char * const argv[])
 			goto out_free;
 		}
 
-		if (img) {
-			fd = open(img, O_RDONLY);
+		if (vi[i].image_file) {
+			fd = open(vi[i].image_file, O_RDONLY);
 			if (fd == -1) {
 				err = fd;
-				sys_errmsg("cannot open \"%s\"", img);
+				sys_errmsg("cannot open \"%s\"", vi[i].image_file);
 				goto out_free;
 			}
 
 			verbose(args.verbose, "writing volume %d", vi[i].id);
-			verbose(args.verbose, "image file: %s", img);
+			verbose(args.verbose, "image file: %s", vi[i].image_file);
 
-			err = ubigen_write_volume(&ui, &vi[i], args.ec, st.st_size, fd, args.out_fd);
+			err = ubigen_write_volume(&ui, &vi[i], args.ec, fd, args.out_fd);
 			close(fd);
 			if (err) {
 				errmsg("cannot write volume for section \"%s\"", sname);
-- 
2.13.6
