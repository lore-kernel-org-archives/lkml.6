Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1786296-1520002699-2-13424423129750150352
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520002698; b=Ic385WAclHWcKjdLl5yJ02TclbZhRlHqzZzWI0E1SBWcToj
    qwsdmi98UK/1HA+jIBW4/vGjnFtauhzXD/yah9BSJfCw5MQtQH2g32ZD/FgGvvJE
    U3L1dvBmoMMPnbeb2JZBDk7cjnWsZSDpcoJS8FkzN+9KocKXWxUhVTNcj4/G4E78
    9VtuBNTbKhqaTSsQCZNRCJEFFuyXUOsUsR6Y9z1NMvGIB69DV8o/x5kBbxUfILy/
    8tIO8b4ZerU1pXu/L/HfLwMfgSGHHO4X06gdtjQbch0PB9WBOq3EQlxylhoAv/Hu
    GjLKM9zMtS38nlJc5OTD+P3e49PuQuEQOfPWylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520002698; bh=OVYGSiGfnJ2q/WQmh/AH/Tzv3T
    xjmSoAEAyD4UJbL0U=; b=b4/Vtw6XhxKI9wAZbJ8kvv/qEtIc0DZNvslnBJMvtZ
    c4rBstci4gRlg7/zhZOcanVEn6RRHW7vvQVQj/kT7RPVWrtnl4DlXvZDAWArS+CG
    CE+Hk5pmtl/9AyOp1z3MWpftqLplk0rJSvK9AO1aeC9177tcY3SeXpT50k3WfEZS
    s1/HDH+hDgBZC2akP2/PUoXX03LVPEKQPJdTd+78cFFaYx89cO+7v2ZXg576cs0E
    /cbdWB/sefPBL0cbiXOvPCHMNsCI7ecV3JRDGkOiN3eWeeoq0Lz8pLKJutVL/XB/
    Tx0iE7LXhS8XzEBnnBSipczF8/ZAbwR8v3TZO65SBtgQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428900AbeCBO5a (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 09:57:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34930 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1428884AbeCBO5U (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 09:57:20 -0500
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        mail.free-electrons.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        shortcircuit=ham autolearn=disabled version=3.4.0
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] spi: Fix scatterlist elements size in spi_map_buf
Date: Fri,  2 Mar 2018 15:55:09 +0100
Message-Id: <20180302145509.24563-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When SPI transfers can be offloaded using DMA, the SPI core need to
build a scatterlist to make sure that the buffer to be transferred is
dma-able.

This patch fixes the scatterlist entry size computation in the case
where the maximum acceptable scatterlist entry supported by the DMA
controller is less than PAGE_SIZE, when the buffer is vmalloced.

For each entry, the actual size is given by the minimum between the
desc_len (which is the max buffer size supported by the DMA controller)
and the remaining buffer length until we cross a page boundary.

Fixes: 65598c13fd66 ("spi: Fix per-page mapping of unaligned vmalloc-ed buffer")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/spi/spi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b33a727a0158..4153f959f28c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -779,8 +779,14 @@ static int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
 	for (i = 0; i < sgs; i++) {
 
 		if (vmalloced_buf || kmap_buf) {
-			min = min_t(size_t,
-				    len, desc_len - offset_in_page(buf));
+			/*
+			 * Next scatterlist entry size is the minimum between
+			 * the desc_len and the remaining buffer length that
+			 * fits in a page.
+			 */
+			min = min_t(size_t, desc_len,
+				    min_t(size_t, len,
+					  PAGE_SIZE - offset_in_page(buf)));
 			if (vmalloced_buf)
 				vm_page = vmalloc_to_page(buf);
 			else
-- 
2.11.0
