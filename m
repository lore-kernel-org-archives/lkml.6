Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28AEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DE321471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=makelinux.com header.i=@makelinux.com header.b="Sz1Zpft2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DE321471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=MakeLinux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeGLGKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:10:37 -0400
Received: from bosmailout07.eigbox.net ([66.96.186.7]:54639 "EHLO
        bosmailout07.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeGLGKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:10:37 -0400
X-Greylist: delayed 1822 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2018 02:10:36 EDT
Received: from bosmailscan13.eigbox.net ([10.20.15.13])
        by bosmailout07.eigbox.net with esmtp (Exim)
        id 1fdUDD-0005YD-Hs; Thu, 12 Jul 2018 01:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=makelinux.com; s=dkim; h=Sender:Message-Id:Date:Subject:To:From:Reply-To:Cc
        :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y5QzUSmMTJy0VgfX59qX91zd4ki3gNGhQxdJLaW1+Mk=; b=Sz1Zpft220P8jj9jUSb186nbb3
        zabiXkG3+yZzj/q+CavZjbdpR58xGUY3vZ5s7NGjvSgDwW5Qxq2ot8mgj9L4v+liMyPlzRLLrY2sY
        F55QagUigBtzKFdZcnHq3fHYLh5/F0z4BeTa3d7CHBs9mHiLpqGNGqDrpbtGPdd2tFdLYWq0u7S4P
        hMdWxGT+OlDO/H/D83SEslaBt1RZPdYCR6GptYyeNHcKN/VgsLxQ/8ljdFUjxEfM5hJC7Kk1dOdFB
        FNyxv8gl6q+ziskJsW6EDKhpTSVU1PASZxvyD/ms8CGjFmQMN5lpqSpE0ihtGJdFTJjZR6Cwtl676
        fJXu6iCQ==;
Received: from [10.115.3.32] (helo=bosimpout12)
        by bosmailscan13.eigbox.net with esmtp (Exim)
        id 1fdUDD-0007AO-EZ; Thu, 12 Jul 2018 01:32:19 -0400
Received: from bosauthsmtp17.yourhostingaccount.com ([10.20.18.17])
        by bosimpout12 with 
        id 9hYC1y0090N5uqq01hYFqE; Thu, 12 Jul 2018 01:32:19 -0400
X-Authority-Analysis: v=2.2 cv=UN2tJGXy c=1 sm=1 tr=0
 a=f4kFLigMKr8AH7rIJ//qJA==:117 a=Dlu3QSMc4l9Ye4MXzL7CyA==:17
 a=R9QF1RCXAYgA:10 a=c2dxBoeyqOUA:10 a=dSbym95GAAAA:8 a=LctjhZXQU1kGAagAwoEA:9
 a=eg0O5KPjxGrMl0Mu5AXQ:22
Received: from [37.142.20.114] (port=12124 helo=localhost.localdomain)
        by bosauthsmtp17.eigbox.net with esmtpa (Exim)
        id 1fdUD6-0000dg-7T; Thu, 12 Jul 2018 01:32:12 -0400
From:   Constantine Shulyupin <const@MakeLinux.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Constantine Shulyupin <const@MakeLinux.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scripts/tags.sh: Add BPF_CALL
Date:   Thu, 12 Jul 2018 08:28:46 +0300
Message-Id: <20180712052850.28396-1-const@MakeLinux.com>
X-Mailer: git-send-email 2.17.1
X-EN-UserInfo: 49eb4aefa70c42fb849786903cdd8376:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: smtp@makelinux.net
X-EN-OrigIP: 37.142.20.114
X-EN-OrigHost: unknown
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 scripts/tags.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 66f08bb1cce9..db0d56ebe9b9 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -152,6 +152,7 @@ regex_asm=(
 )
 regex_c=(
 	'/^SYSCALL_DEFINE[0-9](\([[:alnum:]_]*\).*/sys_\1/'
+	'/^BPF_CALL_[0-9](\([[:alnum:]_]*\).*/\1/'
 	'/^COMPAT_SYSCALL_DEFINE[0-9](\([[:alnum:]_]*\).*/compat_sys_\1/'
 	'/^TRACE_EVENT(\([[:alnum:]_]*\).*/trace_\1/'
 	'/^TRACE_EVENT(\([[:alnum:]_]*\).*/trace_\1_rcuidle/'
-- 
2.17.1

