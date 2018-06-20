Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D83C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE11620693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE11620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754979AbeFTJfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:35:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:19734 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754825AbeFTJfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:35:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 02:35:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,246,1526367600"; 
   d="scan'208";a="234090119"
Received: from sandybridge-desktop.sh.intel.com ([10.239.160.116])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2018 02:35:05 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 2/3][RFC] PM / Hibernate: Encrypt the snapshot pages before submitted to the block device
Date:   Wed, 20 Jun 2018 17:40:32 +0800
Message-Id: <5a1cc6bff40ff9a3e023392c69b881e91b16837a.1529486870.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1529486870.git.yu.c.chen@intel.com>
References: <cover.1529486870.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper functions introduced previously to encrypt
the page data before they are submitted to the block device.
Besides, for the case of hibernation compression, the data
are firstly compressed and then encrypted, and vice versa
for the resume process.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "Lee, Chun-Yi" <jlee@suse.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/power.h |   1 +
 kernel/power/swap.c  | 215 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 205 insertions(+), 11 deletions(-)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index 660aac3..637695c 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -207,6 +207,7 @@ extern int swsusp_swap_in_use(void);
 #define SF_PLATFORM_MODE	1
 #define SF_NOCOMPRESS_MODE	2
 #define SF_CRC32_MODE	        4
+#define SF_ENCRYPT_MODE		8
 
 /* kernel/power/hibernate.c */
 extern int swsusp_check(void);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c2bcf97..2b6b3d0 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -102,14 +102,16 @@ struct swap_map_handle {
 	unsigned int k;
 	unsigned long reqd_free_pages;
 	u32 crc32;
+	bool crypto;
 };
 
 struct swsusp_header {
 	char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int) -
-	              sizeof(u32)];
+			sizeof(u32) - HIBERNATE_SALT_BYTES];
 	u32	crc32;
 	sector_t image;
 	unsigned int flags;	/* Flags to pass to the "boot" kernel */
+	char salt[HIBERNATE_SALT_BYTES];
 	char	orig_sig[10];
 	char	sig[10];
 } __packed;
@@ -127,6 +129,53 @@ struct swsusp_extent {
 	unsigned long end;
 };
 
+/* For encryption/decryption. */
+static struct hibernation_crypto *hibernation_crypto_ops;
+
+void set_hibernation_ops(struct hibernation_crypto *ops)
+{
+	hibernation_crypto_ops = ops;
+}
+EXPORT_SYMBOL_GPL(set_hibernation_ops);
+
+static int crypto_data(const char *inbuf,
+			    int inlen,
+			    char *outbuf,
+			    int outlen,
+			    bool encrypt,
+			    int page_idx)
+{
+	if (hibernation_crypto_ops &&
+	    hibernation_crypto_ops->crypto_data)
+		return hibernation_crypto_ops->crypto_data(inbuf,
+			inlen, outbuf, outlen, encrypt, page_idx);
+	else
+		return -EINVAL;
+}
+
+static void crypto_save(void *outbuf)
+{
+	if (hibernation_crypto_ops &&
+	    hibernation_crypto_ops->save)
+		hibernation_crypto_ops->save(outbuf);
+}
+
+static void crypto_restore(void *inbuf)
+{
+	if (hibernation_crypto_ops &&
+	    hibernation_crypto_ops->restore)
+		hibernation_crypto_ops->restore(inbuf);
+}
+
+static int crypto_init(bool suspend)
+{
+	if (hibernation_crypto_ops &&
+	    hibernation_crypto_ops->init)
+		return hibernation_crypto_ops->init(suspend);
+	else
+		return -EINVAL;
+}
+
 static struct rb_root swsusp_extents = RB_ROOT;
 
 static int swsusp_extents_insert(unsigned long swap_offset)
@@ -318,6 +367,10 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 		swsusp_header->flags = flags;
 		if (flags & SF_CRC32_MODE)
 			swsusp_header->crc32 = handle->crc32;
+		if (handle->crypto) {
+			swsusp_header->flags |= SF_ENCRYPT_MODE;
+			crypto_save((void *)swsusp_header->salt);
+		}
 		error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
 				      swsusp_resume_block, swsusp_header, NULL);
 	} else {
@@ -535,11 +588,12 @@ static int save_image(struct swap_map_handle *handle,
 {
 	unsigned int m;
 	int ret;
-	int nr_pages;
+	int nr_pages, crypto_page_idx;
 	int err2;
 	struct hib_bio_batch hb;
 	ktime_t start;
 	ktime_t stop;
+	void *tmp = NULL, *crypt_buf = NULL;
 
 	hib_init_batch(&hb);
 
@@ -549,12 +603,33 @@ static int save_image(struct swap_map_handle *handle,
 	if (!m)
 		m = 1;
 	nr_pages = 0;
+	crypto_page_idx = 0;
+	if (handle->crypto) {
+		crypt_buf = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!crypt_buf)
+			return -ENOMEM;
+	}
+
 	start = ktime_get();
 	while (1) {
 		ret = snapshot_read_next(snapshot);
 		if (ret <= 0)
 			break;
-		ret = swap_write_page(handle, data_of(*snapshot), &hb);
+		tmp = data_of(*snapshot);
+		if (handle->crypto) {
+			/* Encryption before submit_io.*/
+			ret = crypto_data(data_of(*snapshot),
+					  PAGE_SIZE,
+					  crypt_buf,
+					  PAGE_SIZE,
+					  true,
+					  crypto_page_idx);
+			if (ret)
+				goto out;
+			crypto_page_idx++;
+			tmp = crypt_buf;
+		}
+		ret = swap_write_page(handle, tmp, &hb);
 		if (ret)
 			break;
 		if (!(nr_pages % m))
@@ -569,6 +644,9 @@ static int save_image(struct swap_map_handle *handle,
 	if (!ret)
 		pr_info("Image saving done\n");
 	swsusp_show_speed(start, stop, nr_to_write, "Wrote");
+ out:
+	if (crypt_buf)
+		free_page((unsigned long)crypt_buf);
 	return ret;
 }
 
@@ -671,7 +749,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 {
 	unsigned int m;
 	int ret = 0;
-	int nr_pages;
+	int nr_pages, crypto_page_idx;
 	int err2;
 	struct hib_bio_batch hb;
 	ktime_t start;
@@ -767,6 +845,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 	if (!m)
 		m = 1;
 	nr_pages = 0;
+	crypto_page_idx = 0;
 	start = ktime_get();
 	for (;;) {
 		for (thr = 0; thr < nr_threads; thr++) {
@@ -835,7 +914,25 @@ static int save_image_lzo(struct swap_map_handle *handle,
 			for (off = 0;
 			     off < LZO_HEADER + data[thr].cmp_len;
 			     off += PAGE_SIZE) {
-				memcpy(page, data[thr].cmp + off, PAGE_SIZE);
+				if (handle->crypto) {
+					/*
+					 * Encrypt the compressed data
+					 * before we write them to the
+					 * block device.
+					 */
+					ret = crypto_data(data[thr].cmp + off,
+							  PAGE_SIZE,
+							  page,
+							  PAGE_SIZE,
+							  true,
+							  crypto_page_idx);
+					if (ret)
+						goto out_finish;
+					crypto_page_idx++;
+				} else {
+					memcpy(page, data[thr].cmp + off,
+						PAGE_SIZE);
+				}
 
 				ret = swap_write_page(handle, page, &hb);
 				if (ret)
@@ -909,6 +1006,7 @@ int swsusp_write(unsigned int flags)
 	int error;
 
 	pages = snapshot_get_image_size();
+	memset(&handle, 0, sizeof(struct swap_map_handle));
 	error = get_swap_writer(&handle);
 	if (error) {
 		pr_err("Cannot get swap writer\n");
@@ -922,6 +1020,9 @@ int swsusp_write(unsigned int flags)
 		}
 	}
 	memset(&snapshot, 0, sizeof(struct snapshot_handle));
+	if (!crypto_init(true))
+		/* The image needs to be encrypted. */
+		handle.crypto = true;
 	error = snapshot_read_next(&snapshot);
 	if (error < PAGE_SIZE) {
 		if (error >= 0)
@@ -1059,7 +1160,8 @@ static int load_image(struct swap_map_handle *handle,
 	ktime_t stop;
 	struct hib_bio_batch hb;
 	int err2;
-	unsigned nr_pages;
+	unsigned nr_pages, crypto_page_idx;
+	void *crypt_buf = NULL;
 
 	hib_init_batch(&hb);
 
@@ -1069,18 +1171,42 @@ static int load_image(struct swap_map_handle *handle,
 	if (!m)
 		m = 1;
 	nr_pages = 0;
+	crypto_page_idx = 0;
+	if (handle->crypto) {
+		crypt_buf = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!crypt_buf)
+			return -ENOMEM;
+	}
 	start = ktime_get();
 	for ( ; ; ) {
 		ret = snapshot_write_next(snapshot);
 		if (ret <= 0)
 			break;
-		ret = swap_read_page(handle, data_of(*snapshot), &hb);
+		if (handle->crypto)
+			ret = swap_read_page(handle, crypt_buf, &hb);
+		else
+			ret = swap_read_page(handle, data_of(*snapshot), &hb);
 		if (ret)
 			break;
 		if (snapshot->sync_read)
 			ret = hib_wait_io(&hb);
 		if (ret)
 			break;
+		if (handle->crypto) {
+			/*
+			 * Need a decryption for the
+			 * data read from the block
+			 * device.
+			 */
+			ret = crypto_data(crypt_buf, PAGE_SIZE,
+					  data_of(*snapshot),
+					  PAGE_SIZE,
+					  false,
+					  crypto_page_idx);
+			if (ret)
+				break;
+			crypto_page_idx++;
+		}
 		if (!(nr_pages % m))
 			pr_info("Image loading progress: %3d%%\n",
 				nr_pages / m * 10);
@@ -1097,6 +1223,8 @@ static int load_image(struct swap_map_handle *handle,
 			ret = -ENODATA;
 	}
 	swsusp_show_speed(start, stop, nr_to_read, "Read");
+	if (crypt_buf)
+		free_page((unsigned long)crypt_buf);
 	return ret;
 }
 
@@ -1164,7 +1292,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	struct hib_bio_batch hb;
 	ktime_t start;
 	ktime_t stop;
-	unsigned nr_pages;
+	unsigned nr_pages, crypto_page_idx;
 	size_t off;
 	unsigned i, thr, run_threads, nr_threads;
 	unsigned ring = 0, pg = 0, ring_size = 0,
@@ -1173,6 +1301,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	unsigned char **page = NULL;
 	struct dec_data *data = NULL;
 	struct crc_data *crc = NULL;
+	void *first_page = NULL;
 
 	hib_init_batch(&hb);
 
@@ -1278,6 +1407,18 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	}
 	want = ring_size = i;
 
+	/*
+	 * The first page of data[thr] contains the length of
+	 * compressed data, this page should not mess up the
+	 * read buffer, so we allocate a separate page for it.
+	 */
+	if (handle->crypto) {
+		first_page = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!first_page) {
+			ret = -ENOMEM;
+			goto out_clean;
+		}
+	}
 	pr_info("Using %u thread(s) for decompression\n", nr_threads);
 	pr_info("Loading and decompressing image data (%u pages)...\n",
 		nr_to_read);
@@ -1285,6 +1426,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	if (!m)
 		m = 1;
 	nr_pages = 0;
+	crypto_page_idx = 0;
 	start = ktime_get();
 
 	ret = snapshot_write_next(snapshot);
@@ -1336,7 +1478,24 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		}
 
 		for (thr = 0; have && thr < nr_threads; thr++) {
-			data[thr].cmp_len = *(size_t *)page[pg];
+			if (handle->crypto) {
+				/*
+				 * Need to decrypt the first page
+				 * of each data[thr], which contains
+				 * the compressed data length.
+				 */
+				ret = crypto_data(page[pg],
+						  PAGE_SIZE,
+						  first_page,
+						  PAGE_SIZE,
+						  false,
+						  crypto_page_idx);
+				if (ret)
+					goto out_finish;
+				data[thr].cmp_len = *(size_t *)first_page;
+			} else {
+				data[thr].cmp_len = *(size_t *)page[pg];
+			}
 			if (unlikely(!data[thr].cmp_len ||
 			             data[thr].cmp_len >
 			             lzo1x_worst_compress(LZO_UNC_SIZE))) {
@@ -1358,8 +1517,26 @@ static int load_image_lzo(struct swap_map_handle *handle,
 			for (off = 0;
 			     off < LZO_HEADER + data[thr].cmp_len;
 			     off += PAGE_SIZE) {
-				memcpy(data[thr].cmp + off,
-				       page[pg], PAGE_SIZE);
+				if (handle->crypto) {
+					/*
+					 * Decrypt the compressed data
+					 * and leverage the decompression
+					 * threads to get it done.
+					 */
+					ret = crypto_data(page[pg],
+							  PAGE_SIZE,
+							  data[thr].cmp + off,
+							  PAGE_SIZE,
+							  false,
+							  crypto_page_idx);
+					if (ret)
+						goto out_finish;
+					crypto_page_idx++;
+				} else {
+					memcpy(data[thr].cmp + off,
+						page[pg], PAGE_SIZE);
+
+				}
 				have--;
 				want++;
 				if (++pg >= ring_size)
@@ -1452,6 +1629,8 @@ static int load_image_lzo(struct swap_map_handle *handle,
 out_clean:
 	for (i = 0; i < ring_size; i++)
 		free_page((unsigned long)page[i]);
+	if (first_page)
+		free_page((unsigned long)first_page);
 	if (crc) {
 		if (crc->thr)
 			kthread_stop(crc->thr);
@@ -1482,6 +1661,7 @@ int swsusp_read(unsigned int *flags_p)
 	struct swsusp_info *header;
 
 	memset(&snapshot, 0, sizeof(struct snapshot_handle));
+	memset(&handle, 0, sizeof(struct swap_map_handle));
 	error = snapshot_write_next(&snapshot);
 	if (error < PAGE_SIZE)
 		return error < 0 ? error : -EFAULT;
@@ -1489,6 +1669,16 @@ int swsusp_read(unsigned int *flags_p)
 	error = get_swap_reader(&handle, flags_p);
 	if (error)
 		goto end;
+	if (*flags_p & SF_ENCRYPT_MODE) {
+		error = crypto_init(false);
+		if (!error) {
+			/* The image has been encrypted. */
+			handle.crypto = true;
+		} else {
+			pr_err("Failed to init cipher during resume.\n");
+			goto end;
+		}
+	}
 	if (!error)
 		error = swap_read_page(&handle, header, NULL);
 	if (!error) {
@@ -1526,6 +1716,9 @@ int swsusp_check(void)
 
 		if (!memcmp(HIBERNATE_SIG, swsusp_header->sig, 10)) {
 			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
+			/* Read salt passed from previous kernel. */
+			if (swsusp_header->flags & SF_ENCRYPT_MODE)
+				crypto_restore((void *)&swsusp_header->salt);
 			/* Reset swap signature now */
 			error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
 						swsusp_resume_block,
-- 
2.7.4

