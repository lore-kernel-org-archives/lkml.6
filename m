Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00AEECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A2C20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzZ6I3vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A2C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbeKIHgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbeKIHgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:14 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D96C20892;
        Thu,  8 Nov 2018 21:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714326;
        bh=TBY5Vv0NrMygxnTEvsyZ2cX1EpOkK7CdK2smcXJRuS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YzZ6I3vu9m4Nx6yEKHo6CONqhFotsHvJ4qOHPL1y0fvdCHnCPIvFUFurh/QECz9yL
         x1+9oG3puXjeOfjzU5sEUHWpHrNsuQ2e7gJi/y2tQZgFwbLDzymOQKPCksI3ljBG+Q
         VWMfj6A4MR6wL6sbgdutQxZhdtLxuWKbmsiZQD9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Tranchetti <stranche@codeaurora.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 006/114] xfrm: validate template mode
Date:   Thu,  8 Nov 2018 13:50:21 -0800
Message-Id: <20181108215059.533003683@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 32bf94fb5c2ec4ec842152d0e5937cd4bb6738fa ]

XFRM mode parameters passed as part of the user templates
in the IP_XFRM_POLICY are never properly validated. Passing
values other than valid XFRM modes can cause stack-out-of-bounds
reads to occur later in the XFRM processing:

[  140.535608] ================================================================
[  140.543058] BUG: KASAN: stack-out-of-bounds in xfrm_state_find+0x17e4/0x1cc4
[  140.550306] Read of size 4 at addr ffffffc0238a7a58 by task repro/5148
[  140.557369]
[  140.558927] Call trace:
[  140.558936] dump_backtrace+0x0/0x388
[  140.558940] show_stack+0x24/0x30
[  140.558946] __dump_stack+0x24/0x2c
[  140.558949] dump_stack+0x8c/0xd0
[  140.558956] print_address_description+0x74/0x234
[  140.558960] kasan_report+0x240/0x264
[  140.558963] __asan_report_load4_noabort+0x2c/0x38
[  140.558967] xfrm_state_find+0x17e4/0x1cc4
[  140.558971] xfrm_resolve_and_create_bundle+0x40c/0x1fb8
[  140.558975] xfrm_lookup+0x238/0x1444
[  140.558977] xfrm_lookup_route+0x48/0x11c
[  140.558984] ip_route_output_flow+0x88/0xc4
[  140.558991] raw_sendmsg+0xa74/0x266c
[  140.558996] inet_sendmsg+0x258/0x3b0
[  140.559002] sock_sendmsg+0xbc/0xec
[  140.559005] SyS_sendto+0x3a8/0x5a8
[  140.559008] el0_svc_naked+0x34/0x38
[  140.559009]
[  140.592245] page dumped because: kasan: bad access detected
[  140.597981] page_owner info is not active (free page?)
[  140.603267]
[  140.653503] ================================================================

Signed-off-by: Sean Tranchetti <stranche@codeaurora.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index c2e98dcba9fe..476f1fc6d655 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1408,6 +1408,9 @@ static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family)
 		    (ut[i].family != prev_family))
 			return -EINVAL;
 
+		if (ut[i].mode >= XFRM_MODE_MAX)
+			return -EINVAL;
+
 		prev_family = ut[i].family;
 
 		switch (ut[i].family) {
-- 
2.17.1



