Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D18C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336A8206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336A8206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbeJBUSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:18:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbeJBUSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:18:34 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B4B2C5AA;
        Tue,  2 Oct 2018 13:35:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 133/137] ARM: dts: omap4-droid4: Fix emmc errors seen on some devices
Date:   Tue,  2 Oct 2018 06:25:34 -0700
Message-Id: <20181002132507.807977068@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 2d59bb602314a4b2593fde267734266b5e872dd0 ]

Otherwise we can get the following errors occasionally on some devices:

mmc1: tried to HW reset card, got error -110
mmcblk1: error -110 requesting status
mmcblk1: recovery failed!
print_req_error: I/O error, dev mmcblk1, sector 14329
...

I have one device that hits this error almost on every boot, and another
one that hits it only rarely with the other ones I've used behave without
problems. I'm not sure if the issue is related to a particular eMMC card
model, but in case it is, both of the machines with issues have:

# cat /sys/class/mmc_host/mmc1/mmc1:0001/manfid \
/sys/class/mmc_host/mmc1/mmc1:0001/oemid \
/sys/class/mmc_host/mmc1/mmc1:0001/name
0x000045
0x0100
SEM16G

and the working ones have:

0x000011
0x0100
016G92

Note that "ti,non-removable" is different as omap_hsmmc_reg_get() does not
call omap_hsmmc_disable_boot_regulators() if no_regulator_off_init is set.
And currently we set no_regulator_off_init only for "ti,non-removable" and
not for "non-removable". It seems that we should have "non-removable" with
some other mmc generic property behave in the same way instead of having to
use a non-generic property. But let's fix the issue first.

Fixes: 7e2f8c0ae670 ("ARM: dts: Add minimal support for motorola droid 4
xt894")
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Michael Scott <hashcode0f@gmail.com>
Cc: NeKit <nekit1000@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -314,7 +314,7 @@
 &mmc2 {
 	vmmc-supply = <&vsdio>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 };
 
 &mmc3 {


