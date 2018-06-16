Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44D3C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E51320896
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E51320896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754075AbeFPHwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 03:52:36 -0400
Received: from www.osadl.org ([62.245.132.105]:60448 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753776AbeFPHwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 03:52:35 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w5G7oH4S025952;
        Sat, 16 Jun 2018 09:50:17 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] MIPS: Octeon: add missing of_node_put()
Date:   Sat, 16 Jun 2018 09:49:56 +0200
Message-Id: <1529135396-16728-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 The call to of_find_node_by_name inside the do-while-loop is returning
node with refcount incremented thus it must be explicitly decremented
here after usage.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
commit 93e502b3c2d4 ("MIPS: OCTEON: Platform support for OCTEON III USB controller")
---
Problem located by an experimental coccinelle script

Patch was compile tested with: cavium_octeon_defconfig (implies
CONFIG_USB=y)
(with a number of sparse warnings - not related to the proposed change)

Patch is against 4.17.0 (localversion-next is next-20180614)

 arch/mips/cavium-octeon/octeon-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
index bfdfaf3..76e06b4 100644
--- a/arch/mips/cavium-octeon/octeon-usb.c
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -512,6 +512,7 @@ static int __init dwc3_octeon_device_init(void)
 
 		if (of_device_is_compatible(node, compat_node_name)) {
 			pdev = of_find_device_by_node(node);
+			of_node_put(node);
 			if (!pdev)
 				return -ENODEV;
 
-- 
2.1.4

