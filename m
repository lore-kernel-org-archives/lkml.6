Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D12C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2472184A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="q43yr37d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfBRCrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:47:02 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:52579 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfBRCrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:47:01 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5EB858025D;
        Mon, 18 Feb 2019 15:46:59 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1550458019;
        bh=n1alTCC7WHm6zo9Ntn3rKKP6y1i5sw0ivAch/0Pk6pY=;
        h=From:To:Cc:Subject:Date;
        b=q43yr37d5ZEeKVh3FltxlV03mPzWYQfbuXlwrStnrGAt/8bur8wAx+nT3PQDMrhR6
         UssJFDNQLhP5gLUE7Xsbvr9tDRgxcXf/eZeZ1Ng8a84SHe/6IVJMaF8ysuxsgjpCoG
         XJSRHD5rZ1WreLUCMdiugOUup2gz/krrxkdfSHryckMi8OKgyNEta8AcoTCji3IViI
         h6QVL/XvsLi3VAHXAg2EQjimIkC2L8dqQK85dpPIv+m7nzaa7cDCIyYNA7MNxqKWIM
         ESZaDPBQFDWXa+bxhDo/I1EjevObbLnqoqTAi5/JAYvNp3IoFFfp0fL0+0bejSj+OM
         vEuWlChZPNgBQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c6a1ca10000>; Mon, 18 Feb 2019 15:46:59 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 7918A13EEFC;
        Mon, 18 Feb 2019 15:46:57 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 626091E111B; Mon, 18 Feb 2019 15:46:57 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, jason@lakedaemon.net, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM: mvebu: kirkwood: remove error message when retrieving mac address
Date:   Mon, 18 Feb 2019 15:46:45 +1300
Message-Id: <20190218024645.29059-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirkwood has always had the ability to retrieve the local-mac-address
from the hardware (usually this was configured by the bootloader). This
is particularly useful when dealing with a legacy non-DT aware
bootloader.

The "error" message just indicated that the board used an old bootloader
and in many cases users can't do anything about this. The message
probably should have been pr_info() to inform the user that the kernel
has been helpful but rather than than let's remove it entirely to make
the kernel less noisy.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/mach-mvebu/kirkwood.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwoo=
d.c
index 0aa88105d46e..bf3ff0f580c2 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -107,8 +107,6 @@ static void __init kirkwood_dt_eth_fixup(void)
 		clk_prepare_enable(clk);
=20
 		/* store MAC address register contents in local-mac-address */
-		pr_err(FW_INFO "%pOF: local-mac-address is not set\n", np);
-
 		pmac =3D kzalloc(sizeof(*pmac) + 6, GFP_KERNEL);
 		if (!pmac)
 			goto eth_fixup_no_mem;
--=20
2.20.1

