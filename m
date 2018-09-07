Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB00C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3F820645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3F820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbeIHCLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:11:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48782 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbeIHCLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:11:09 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4F28EDBC;
        Fri,  7 Sep 2018 21:28:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rafael David Tinoco <rafael.tinoco@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.14 50/89] mfd: hi655x: Fix regmap area declared size for hi655x
Date:   Fri,  7 Sep 2018 23:09:44 +0200
Message-Id: <20180907210858.481084300@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael David Tinoco <rafael.tinoco@linaro.org>

commit 6afebb70ee7a4bde106dc1a875e7ac7997248f84 upstream.

Fixes https://bugs.linaro.org/show_bug.cgi?id=3903

LTP Functional tests have caused a bad paging request when triggering
the regmap_read_debugfs() logic of the device PMIC Hi6553 (reading
regmap/f8000000.pmic/registers file during read_all test):

Unable to handle kernel paging request at virtual address ffff0
[ffff00000984e000] pgd=0000000077ffe803, pud=0000000077ffd803,0
Internal error: Oops: 96000007 [#1] SMP
...
Hardware name: HiKey Development Board (DT)
...
Call trace:
 regmap_mmio_read8+0x24/0x40
 regmap_mmio_read+0x48/0x70
 _regmap_bus_reg_read+0x38/0x48
 _regmap_read+0x68/0x170
 regmap_read+0x50/0x78
 regmap_read_debugfs+0x1a0/0x308
 regmap_map_read_file+0x48/0x58
 full_proxy_read+0x68/0x98
 __vfs_read+0x48/0x80
 vfs_read+0x94/0x150
 SyS_read+0x6c/0xd8
 el0_svc_naked+0x30/0x34
Code: aa1e03e0 d503201f f9400280 8b334000 (39400000)

Investigations have showed that, when triggered by debugfs read()
handler, the mmio regmap logic was reading a bigger (16k) register area
than the one mapped by devm_ioremap_resource() during hi655x-pmic probe
time (4k).

This commit changes hi655x's max register, according to HW specs, to be
the same as the one declared in the pmic device in hi6220's dts, fixing
the issue.

Cc: <stable@vger.kernel.org> #v4.9 #v4.14 #v4.16 #v4.17
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mfd/hi655x-pmic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -49,7 +49,7 @@ static struct regmap_config hi655x_regma
 	.reg_bits = 32,
 	.reg_stride = HI655X_STRIDE,
 	.val_bits = 8,
-	.max_register = HI655X_BUS_ADDR(0xFFF),
+	.max_register = HI655X_BUS_ADDR(0x400) - HI655X_STRIDE,
 };
 
 static struct resource pwrkey_resources[] = {


