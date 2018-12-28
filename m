Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520C5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F742184B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999290;
	bh=LMpNKA5n6WUsb9nv1R3rDvPLz533YGjjRxoPFW3iCHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=swoUoRsDorQJ3XaL11ZWHUAbZSkJQh47iy30PFNtFbC0LVEy0mHmWWk82mkIbA7id
	 apJHIBfY756aC/+8m06PxkeGbmYqbcCAHhF+hx8ahxNgUPgdNtvoAdfmUOe3jFaH3z
	 QDWptPDWkSRVfBqbY/11YGakto2EbmbiqUbpEYkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbeL1MOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:14:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbeL1MOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C41A12148E;
        Fri, 28 Dec 2018 12:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999284;
        bh=LMpNKA5n6WUsb9nv1R3rDvPLz533YGjjRxoPFW3iCHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mz7b6kOeYXE/mtzngf24JyGC9jIuXpvjTGGqRppUJ1VPx9Trc/991Td4u2apMDDwO
         iTPbbu1s4VowbtWuUu06ypqsc9Qj4BDicm7HsiVg/8Hi6j4FGORq0NCsCP+XY3pS0T
         8KS+Qob3WzHEBlVPnt+sMNTaECFUrlZvAZxHiDu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Francisco=20Machado=20Magalh=C3=A3es=20Neto?= 
        <franmagneto@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.19 35/46] rtlwifi: Fix leak of skb when processing C2H_BT_INFO
Date:   Fri, 28 Dec 2018 12:52:29 +0100
Message-Id: <20181228113126.893246131@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 8cfa272b0d321160ebb5b45073e39ef0a6ad73f2 upstream.

With commit 0a9f8f0a1ba9 ("rtlwifi: fix btmpinfo timeout while processing
C2H_BT_INFO"), calling rtl_c2hcmd_enqueue() with rtl_c2h_fast_cmd() true,
the routine returns without freeing that skb, thereby leaking it.

This issue has been discussed at https://github.com/lwfinger/rtlwifi_new/issues/401
and the fix tested there.

Fixes: 0a9f8f0a1ba9 ("rtlwifi: fix btmpinfo timeout while processing C2H_BT_INFO")
Reported-and-tested-by: Francisco Machado Magalhães Neto <franmagneto@gmail.com>
Cc: Francisco Machado Magalhães Neto <franmagneto@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Stable <stable@vger.kernel.org> # 4.18+
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/base.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -2289,6 +2289,7 @@ void rtl_c2hcmd_enqueue(struct ieee80211
 
 	if (rtl_c2h_fast_cmd(hw, skb)) {
 		rtl_c2h_content_parsing(hw, skb);
+		kfree_skb(skb);
 		return;
 	}
 


