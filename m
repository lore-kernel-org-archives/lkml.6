Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66010C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD4F2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP2bKZb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD4F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeJYWsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbeJYWr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:59 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F3A92084A;
        Thu, 25 Oct 2018 14:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476903;
        bh=qnQJ5hsNho6Ag/ZvVtAJ28BwwYCSCa6S7y26aGX2KlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XP2bKZb/mGi8CaRyQ9ZE9uW3hM0Ne9nC4fZJYii+ANIcsbgZurO9F+YCV0kqZ01Xj
         pzXKMRg9oaZxNkVnHiYsi1+Is+h9UNWRoGVPbKGAGRp4kwNTEKAr8WNj0ssF46gBGt
         0JTPQX0Omlo59rjnqjW7vd4vy6mvWH/nkuf413fU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 25/98] ARM: dts: bcm283x: Reserve first page for firmware
Date:   Thu, 25 Oct 2018 10:13:10 -0400
Message-Id: <20181025141423.213774-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Elwell <phil@raspberrypi.org>

[ Upstream commit b0804ed0cadd7e38d94d2f15cdcc0d9695818856 ]

The Raspberry Pi startup stub files for multi-core BCM283X processors
make the secondary CPUs spin until the corresponding mailbox is
written. These stubs are loaded at physical address 0x00000xxx (as seen
by the ARMs), but this page will be reused by the kernel unless it is
explicitly reserved, causing the waiting cores to execute random code.

Use the /memreserve/ Device Tree directive to mark the first page as
off-limits to the kernel.

See: https://github.com/raspberrypi/linux/issues/1989
Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm283x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index c51b88ee3cec..31563007772c 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -3,6 +3,11 @@
 #include <dt-bindings/clock/bcm2835-aux.h>
 #include <dt-bindings/gpio/gpio.h>
 
+/* firmware-provided startup stubs live here, where the secondary CPUs are
+ * spinning.
+ */
+/memreserve/ 0x00000000 0x00001000;
+
 /* This include file covers the common peripherals and configuration between
  * bcm2835 and bcm2836 implementations, leaving the CPU configuration to
  * bcm2835.dtsi and bcm2836.dtsi.
-- 
2.17.1

