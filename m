Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF330C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6043213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4W8mUEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6043213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbeK3Bga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729050AbeK3Bg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF90213A2;
        Thu, 29 Nov 2018 14:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501856;
        bh=yhbnbE7RLqbt4JtYoqni41jJwCK5Dn69rOGP3zfqtxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4W8mUEkQRPsniOF1H/r+DBLZb0BTIjGvpQeWdbGfydzGpJG9Mei+Nlx9Cku3zY0h
         F2rq6MqRtvVLp//0pxL7+F30zM+mIWsC+Jm9xQUgcJfQwuRD6AwAWJoBOj+MF1hMJc
         AhVFlEn2vMMMYQdgWe2lfvP3ra4Gnru1q9hRXmIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/110] tools/testing/nvdimm: Fix the array size for dimm devices.
Date:   Thu, 29 Nov 2018 15:12:41 +0100
Message-Id: <20181129135924.087990010@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit af31b04b67f4fd7f639fd465a507c154c46fc9fb ]

KASAN reports following global out of bounds access while
nfit_test is being loaded. The out of bound access happens
the following reference to dimm_fail_cmd_flags[dimm]. 'dimm' is
over than the index value, NUM_DCR (==5).

  static int override_return_code(int dimm, unsigned int func, int rc)
  {
          if ((1 << func) & dimm_fail_cmd_flags[dimm]) {

dimm_fail_cmd_flags[] definition:
  static unsigned long dimm_fail_cmd_flags[NUM_DCR];

'dimm' is the return value of get_dimm(), and get_dimm() returns
the index of handle[] array. The handle[] has 7 index. Let's use
ARRAY_SIZE(handle) as the array size.

KASAN report:

==================================================================
BUG: KASAN: global-out-of-bounds in nfit_test_ctl+0x47bb/0x55b0 [nfit_test]
Read of size 8 at addr ffffffffc10cbbe8 by task kworker/u41:0/8
...
Call Trace:
 dump_stack+0xea/0x1b0
 ? dump_stack_print_info.cold.0+0x1b/0x1b
 ? kmsg_dump_rewind_nolock+0xd9/0xd9
 print_address_description+0x65/0x22e
 ? nfit_test_ctl+0x47bb/0x55b0 [nfit_test]
 kasan_report.cold.6+0x92/0x1a6
 nfit_test_ctl+0x47bb/0x55b0 [nfit_test]
...
The buggy address belongs to the variable:
 dimm_fail_cmd_flags+0x28/0xffffffffffffa440 [nfit_test]
==================================================================

Fixes: 39611e83a28c ("tools/testing/nvdimm: Make DSM failure code injection...")
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/nvdimm/test/nfit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index cffc2c5a778d..ec50d2a95076 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -139,8 +139,8 @@ static u32 handle[] = {
 	[6] = NFIT_DIMM_HANDLE(1, 0, 0, 0, 1),
 };
 
-static unsigned long dimm_fail_cmd_flags[NUM_DCR];
-static int dimm_fail_cmd_code[NUM_DCR];
+static unsigned long dimm_fail_cmd_flags[ARRAY_SIZE(handle)];
+static int dimm_fail_cmd_code[ARRAY_SIZE(handle)];
 
 static const struct nd_intel_smart smart_def = {
 	.flags = ND_INTEL_SMART_HEALTH_VALID
@@ -203,7 +203,7 @@ struct nfit_test {
 		unsigned long deadline;
 		spinlock_t lock;
 	} ars_state;
-	struct device *dimm_dev[NUM_DCR];
+	struct device *dimm_dev[ARRAY_SIZE(handle)];
 	struct nd_intel_smart *smart;
 	struct nd_intel_smart_threshold *smart_threshold;
 	struct badrange badrange;
@@ -2678,7 +2678,7 @@ static int nfit_test_probe(struct platform_device *pdev)
 		u32 nfit_handle = __to_nfit_memdev(nfit_mem)->device_handle;
 		int i;
 
-		for (i = 0; i < NUM_DCR; i++)
+		for (i = 0; i < ARRAY_SIZE(handle); i++)
 			if (nfit_handle == handle[i])
 				dev_set_drvdata(nfit_test->dimm_dev[i],
 						nfit_mem);
-- 
2.17.1



