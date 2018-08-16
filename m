Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92995C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565AC21480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565AC21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbeHPVnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:43:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56322 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeHPVns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:43:48 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3098BCB7;
        Thu, 16 Aug 2018 18:43:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH 4.4 02/13] tcp: Fix missing range_truesize enlargement in the backport
Date:   Thu, 16 Aug 2018 20:41:49 +0200
Message-Id: <20180816171628.657931044@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171628.554317013@linuxfoundation.org>
References: <20180816171628.554317013@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

The 4.4.y stable backport dc6ae4dffd65 for the upstream commit
3d4bf93ac120 ("tcp: detect malicious patterns in
tcp_collapse_ofo_queue()") missed a line that enlarges the
range_truesize value, which broke the whole check.

Fixes: dc6ae4dffd65 ("tcp: detect malicious patterns in tcp_collapse_ofo_queue()")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Cc: Michal Kubecek <mkubecek@suse.cz>
---

Greg, this is a fix-up specific to 4.4.y stable backport that had a
slightly different form from upstream fix.  I haven't looked at the
older trees, but 4.9.y and later took the upstream fix as is, so this
patch isn't needed for them.

The patch hasn't been tested with the real test case, though; let me
know if the current code is intended.  Thanks!


 net/ipv4/tcp_input.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4835,6 +4835,7 @@ static void tcp_collapse_ofo_queue(struc
 			end = TCP_SKB_CB(skb)->end_seq;
 			range_truesize = skb->truesize;
 		} else {
+			range_truesize += skb->truesize;
 			if (before(TCP_SKB_CB(skb)->seq, start))
 				start = TCP_SKB_CB(skb)->seq;
 			if (after(TCP_SKB_CB(skb)->end_seq, end))


