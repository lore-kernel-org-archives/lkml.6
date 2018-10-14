Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE9FC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A9520645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A9520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbeJNXX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:23:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36934 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbeJNXXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:23:25 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMC-0004cW-28; Sun, 14 Oct 2018 16:31:04 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000EZ-Pp; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "Martin Kelly" <mkelly@xevo.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.847023624@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 074/366] iio:buffer: make length types match kfifo types
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kelly <mkelly@xevo.com>

commit c043ec1ca5baae63726aae32abbe003192bc6eec upstream.

Currently, we use int for buffer length and bytes_per_datum. However,
kfifo uses unsigned int for length and size_t for element size. We need
to make sure these matches or we will have bugs related to overflow (in
the range between INT_MAX and UINT_MAX for length, for example).

In addition, set_bytes_per_datum uses size_t while bytes_per_datum is an
int, which would cause bugs for large values of bytes_per_datum.

Change buffer length to use unsigned int and bytes_per_datum to use
size_t.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[bwh: Backported to 3.16:
 - Drop change in iio_dma_buffer_set_length()
 - Adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -19,7 +19,7 @@ struct iio_kfifo {
 #define iio_to_kfifo(r) container_of(r, struct iio_kfifo, buffer)
 
 static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
-				int bytes_per_datum, int length)
+			size_t bytes_per_datum, unsigned int length)
 {
 	if ((length == 0) || (bytes_per_datum == 0))
 		return -EINVAL;
@@ -87,7 +87,7 @@ static int iio_set_bytes_per_datum_kfifo
 	return 0;
 }
 
-static int iio_set_length_kfifo(struct iio_buffer *r, int length)
+static int iio_set_length_kfifo(struct iio_buffer *r, unsigned int length)
 {
 	/* Avoid an invalid state */
 	if (length < 2)
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -52,7 +52,7 @@ struct iio_buffer_access_funcs {
 	int (*get_bytes_per_datum)(struct iio_buffer *buffer);
 	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
 	int (*get_length)(struct iio_buffer *buffer);
-	int (*set_length)(struct iio_buffer *buffer, int length);
+	int (*set_length)(struct iio_buffer *buffer, unsigned int length);
 
 	void (*release)(struct iio_buffer *buffer);
 };
@@ -78,8 +78,8 @@ struct iio_buffer_access_funcs {
  * @ref:		[INTERN] reference count of the buffer.
  */
 struct iio_buffer {
-	int					length;
-	int					bytes_per_datum;
+	unsigned int				length;
+	size_t					bytes_per_datum;
 	struct attribute_group			*scan_el_attrs;
 	long					*scan_mask;
 	bool					scan_timestamp;

