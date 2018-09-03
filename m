Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C7FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A8220868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A8220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeICVNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:13:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37944 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbeICVNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:13:44 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7EB02CF5;
        Mon,  3 Sep 2018 16:52:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Calvin Walton <calvin.walton@kepstin.ca>,
        Len Brown <len.brown@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 27/56] tools/power turbostat: Read extended processor family from CPUID
Date:   Mon,  3 Sep 2018 18:49:17 +0200
Message-Id: <20180903164925.442941866@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Calvin Walton <calvin.walton@kepstin.ca>

[ Upstream commit 5aa3d1a20a233d4a5f1ec3d62da3f19d9afea682 ]

This fixes the reported family on modern AMD processors (e.g. Ryzen,
which is family 0x17). Previously these processors all showed up as
family 0xf.

See the document
https://support.amd.com/TechDocs/56255_OSRR.pdf
section CPUID_Fn00000001_EAX for how to calculate the family
from the BaseFamily and ExtFamily values.

This matches the code in arch/x86/lib/cpu.c

Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/power/x86/turbostat/turbostat.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2009,7 +2009,9 @@ void check_cpuid()
 	family = (fms >> 8) & 0xf;
 	model = (fms >> 4) & 0xf;
 	stepping = fms & 0xf;
-	if (family == 6 || family == 0xf)
+	if (family == 0xf)
+		family += (fms >> 20) & 0xff;
+	if (family >= 6)
 		model += ((fms >> 16) & 0xf) << 4;
 
 	if (verbose)


