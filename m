Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B69AC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E344320876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E344320876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeJNXTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:19:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36798 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728015AbeJNXTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:19:54 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMC-0004cY-0a; Sun, 14 Oct 2018 16:31:04 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000Ee-Qq; Sun, 14 Oct 2018 16:30:15 +0100
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
Message-ID: <lsq.1539530741.85075120@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 075/366] iio:kfifo_buf: check for uint overflow
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

commit 3d13de4b027d5f6276c0f9d3a264f518747d83f2 upstream.

Currently, the following causes a kernel OOPS in memcpy:

echo 1073741825 > buffer/length
echo 1 > buffer/enable

Note that using 1073741824 instead of 1073741825 causes "write error:
Cannot allocate memory" but no OOPS.

This is because 1073741824 == 2^30 and 1073741825 == 2^30+1. Since kfifo
rounds up to the nearest power of 2, it will actually call kmalloc with
roundup_pow_of_two(length) * bytes_per_datum.

Using length == 1073741825 and bytes_per_datum == 2, we get:

kmalloc(roundup_pow_of_two(1073741825) * 2
or kmalloc(2147483648 * 2)
or kmalloc(4294967296)
or kmalloc(UINT_MAX + 1)

so this overflows to 0, causing kmalloc to return ZERO_SIZE_PTR and
subsequent memcpy to fail once the device is enabled.

Fix this by checking for overflow prior to allocating a kfifo. With this
check added, the above code returns -EINVAL when enabling the buffer,
rather than causing an OOPS.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/iio/kfifo_buf.c | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -24,6 +24,13 @@ static inline int __iio_allocate_kfifo(s
 	if ((length == 0) || (bytes_per_datum == 0))
 		return -EINVAL;
 
+	/*
+	 * Make sure we don't overflow an unsigned int after kfifo rounds up to
+	 * the next power of 2.
+	 */
+	if (roundup_pow_of_two(length) > UINT_MAX / bytes_per_datum)
+		return -EINVAL;
+
 	return __kfifo_alloc((struct __kfifo *)&buf->kf, length,
 			     bytes_per_datum, GFP_KERNEL);
 }

