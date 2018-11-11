Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF886C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865682084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkLwdbt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865682084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388848AbeKLIUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388834AbeKLIUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:33 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FBF4223CA;
        Sun, 11 Nov 2018 22:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975437;
        bh=GnR0KTixvcIvwbPHJ+gmga1blza7Q2d7N/d1SSi/n0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EkLwdbt5M6o/NU9/+Vk+g2x7pkvt1JPq3eoVgDWuyKnrkG5jR9z8lorLh0pvwdvwN
         J8jsrtsFK9ntCV5VA38fRQBfREcdUn84GgPaHrTABoJPRdHHFBAGFLMVNbybSZ7SlR
         xCUbcLe0Yu404qJM5nLoWTokWUXcl7H+yOVa+3Jg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 187/350] cpupower: Fix AMD Family 0x17 msr_pstate size
Date:   Sun, 11 Nov 2018 14:20:51 -0800
Message-Id: <20181111221715.855418147@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prarit Bhargava <prarit@redhat.com>

[ Upstream commit 8c22e2f695920ebd94f9a53bcf2a65eb36d4dba1 ]

The msr_pstate data is only 63 bits long and should be 64 bits.

Add in the missing bit from res1 for AMD Family 0x17.

Reference: https://www.amd.com/system/files/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf, page 138.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/power/cpupower/utils/helpers/amd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -33,7 +33,7 @@ union msr_pstate {
 		unsigned vid:8;
 		unsigned iddval:8;
 		unsigned idddiv:2;
-		unsigned res1:30;
+		unsigned res1:31;
 		unsigned en:1;
 	} fam17h_bits;
 	unsigned long long val;


