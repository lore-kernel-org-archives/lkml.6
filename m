Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B2D64C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6703A208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6703A208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933778AbeFLABM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:01:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:39121 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932688AbeFLABL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:01:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5C017Sg021903;
        Mon, 11 Jun 2018 19:01:08 -0500
Message-ID: <22064afa92ed2e4b33a93685aabb1d07c7c8846d.camel@kernel.crashing.org>
Subject: [PATCH] drivers/of: Make of_io_request_and_map() "name" argument
 optional
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 12 Jun 2018 10:01:07 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These days of_address_to_resource() puts a reasonable name
in the resource struct, thus make the "name" argument an
optional override.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Just something I noticed ... we should probably update the
callers to stop passing stupid names..

 drivers/of/address.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 580bbf6ca2b1..cf83c05f5650 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -774,7 +774,7 @@ EXPORT_SYMBOL(of_iomap);
  *			   for a given device_node
  * @device:	the device whose io range will be mapped
  * @index:	index of the io range
- * @name:	name of the resource
+ * @name:	name "override" for the memory region request or NULL
  *
  * Returns a pointer to the requested and mapped memory or an ERR_PTR() encoded
  * error code on failure. Usage example:
@@ -784,7 +784,7 @@ EXPORT_SYMBOL(of_iomap);
  *		return PTR_ERR(base);
  */
 void __iomem *of_io_request_and_map(struct device_node *np, int index,
-					const char *name)
+				    const char *name)
 {
 	struct resource res;
 	void __iomem *mem;
@@ -792,6 +792,8 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
 	if (of_address_to_resource(np, index, &res))
 		return IOMEM_ERR_PTR(-EINVAL);
 
+	if (!name)
+		name = res.name;
 	if (!request_mem_region(res.start, resource_size(&res), name))
 		return IOMEM_ERR_PTR(-EBUSY);
 

