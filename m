Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D8CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCAB251AE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCAB251AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965389AbeGAQ0v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:26:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933572AbeGAQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:26:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 02347ACD;
        Sun,  1 Jul 2018 16:26:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Kelly <mkelly@xevo.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 055/101] iio:buffer: make length types match kfifo types
Date:   Sun,  1 Jul 2018 18:21:41 +0200
Message-Id: <20180701160759.341694677@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[bwh: Backported to 4.9:
 - Drop change to iio_dma_buffer_set_length()
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/buffer/kfifo_buf.c |    4 ++--
 include/linux/iio/buffer.h     |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -19,7 +19,7 @@ struct iio_kfifo {
 #define iio_to_kfifo(r) container_of(r, struct iio_kfifo, buffer)
 
 static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
-				int bytes_per_datum, int length)
+			size_t bytes_per_datum, unsigned int length)
 {
 	if ((length == 0) || (bytes_per_datum == 0))
 		return -EINVAL;
@@ -71,7 +71,7 @@ static int iio_set_bytes_per_datum_kfifo
 	return 0;
 }
 
-static int iio_set_length_kfifo(struct iio_buffer *r, int length)
+static int iio_set_length_kfifo(struct iio_buffer *r, unsigned int length)
 {
 	/* Avoid an invalid state */
 	if (length < 2)
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -61,7 +61,7 @@ struct iio_buffer_access_funcs {
 	int (*request_update)(struct iio_buffer *buffer);
 
 	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
-	int (*set_length)(struct iio_buffer *buffer, int length);
+	int (*set_length)(struct iio_buffer *buffer, unsigned int length);
 
 	int (*enable)(struct iio_buffer *buffer, struct iio_dev *indio_dev);
 	int (*disable)(struct iio_buffer *buffer, struct iio_dev *indio_dev);
@@ -96,8 +96,8 @@ struct iio_buffer_access_funcs {
  * @watermark:		[INTERN] number of datums to wait for poll/read.
  */
 struct iio_buffer {
-	int					length;
-	int					bytes_per_datum;
+	unsigned int				length;
+	size_t					bytes_per_datum;
 	struct attribute_group			*scan_el_attrs;
 	long					*scan_mask;
 	bool					scan_timestamp;


