Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050CDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6FF20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6FF20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405056AbeHATFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:05:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403937AbeHATFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:05:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 51DC6CE2;
        Wed,  1 Aug 2018 17:18:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 141/246] EDAC, altera: Fix ARM64 build warning
Date:   Wed,  1 Aug 2018 18:50:51 +0200
Message-Id: <20180801165018.483784176@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
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

From: Thor Thayer <thor.thayer@linux.intel.com>

[ Upstream commit 9ef20753e044f7468c4113e5aecd785419b0b3cc ]

The kbuild test robot reported the following warning:

  drivers/edac/altera_edac.c: In function 'ocram_free_mem':
  drivers/edac/altera_edac.c:1410:42: warning: cast from pointer to integer
	of different size [-Wpointer-to-int-cast]
    gen_pool_free((struct gen_pool *)other, (u32)p, size);
                                             ^

After adding support for ARM64 architectures, the unsigned long
parameter is 64 bits and causes a build warning on 64-bit configs. Fix
by casting to the correct size (unsigned long) instead of u32.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-edac <linux-edac@vger.kernel.org>
Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Link: http://lkml.kernel.org/r/1526317441-4996-1-git-send-email-thor.thayer@linux.intel.com
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/altera_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1106,7 +1106,7 @@ static void *ocram_alloc_mem(size_t size
 
 static void ocram_free_mem(void *p, size_t size, void *other)
 {
-	gen_pool_free((struct gen_pool *)other, (u32)p, size);
+	gen_pool_free((struct gen_pool *)other, (unsigned long)p, size);
 }
 
 static const struct edac_device_prv_data ocramecc_data = {


