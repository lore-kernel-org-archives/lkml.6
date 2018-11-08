Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4176AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15A120844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw++toYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15A120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbeKIHlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:41:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730305AbeKIHlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:41:47 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C636F208A3;
        Thu,  8 Nov 2018 22:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714656;
        bh=F3jrL2jwmsiLxXXIKCcJTywJZZ9z9376IycS1RLYVk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fw++toYZ5s7UV3C+QqoriYXXYAHwuf85lFaPh832vMe0dhTLVceE5OYi78F+IVJnY
         GHtQ3UYFnQ1y1pmO29H2f45DNGt9oppU3PT14023cYOjtTBNK9gDZe9upiHnsp+ITs
         KB4tCKVaQj4Lh7jtNfmQZYoHyeW2Mca6dG8sxJzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>,
        Eric Anholt <eric@anholt.net>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 056/171] ARM: dts: bcm283x: Reserve first page for firmware
Date:   Thu,  8 Nov 2018 13:50:26 -0800
Message-Id: <20181108215131.551748040@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



