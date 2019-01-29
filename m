Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F507C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D584520881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763564;
	bh=LoTLdVYZZ6CzLYrCs1Tj+bzbjoq0cFt5mu9RQWrgfRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hyeYyZ0OQBS4gfglaplLMw605pOETj1nS1CxKlOaBLL7WdvpWDPenUwpukgfKpyI+
	 jYKPpvhsJlpJYAScF6Ru1htpfTFUQEWV5XwxXIr+sCzTl1dkwmPauUNUngMqAjsRO9
	 1lUctmch1xTMb4U35cBg5RMu9M405xdLuWZNcy4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfA2MGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:06:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbfA2Lld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:41:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35678214DA;
        Tue, 29 Jan 2019 11:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762092;
        bh=LoTLdVYZZ6CzLYrCs1Tj+bzbjoq0cFt5mu9RQWrgfRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l59DnfgUDTj4hvqUiyyKIqPROuecLCbcTo7SXBYucYtfF/g4PRYZlPqTfbcN/tjUM
         F1N1uok2Vqt8ZckDfKLif5MfJJmBTRY5W2YfrnfUWgMFW+KiUAqAbp6Rwb0+GmW65Z
         jGTb99M9JcqkcjiYwR/koKCoYRMHZSUg1tOt83Xc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 107/117] vmbus: fix subchannel removal
Date:   Tue, 29 Jan 2019 12:35:58 +0100
Message-Id: <20190129113212.717196889@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b5679cebf780c6f1c2451a73bf1842a4409840e7 ]

The changes to split ring allocation from open/close, broke
the cleanup of subchannels. This resulted in problems using
uio on network devices because the subchannel was left behind
when the network device was unbound.

The cause was in the disconnect logic which used list splice
to move the subchannel list into a local variable. This won't
work because the subchannel list is needed later during the
process of the rescind messages (relid2channel).

The fix is to just leave the subchannel list in place
which is what the original code did. The list is cleaned
up later when the host rescind is processed.

Without the fix, we have a lot of "hang" issues in netvsc when we
try to change the NIC's MTU, set the number of channels, etc.

Fixes: ae6935ed7d42 ("vmbus: split ring buffer allocation from open")
Cc: stable@vger.kernel.org
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/channel.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index ce0ba2062723..bea4c9850247 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -701,19 +701,12 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
 int vmbus_disconnect_ring(struct vmbus_channel *channel)
 {
 	struct vmbus_channel *cur_channel, *tmp;
-	unsigned long flags;
-	LIST_HEAD(list);
 	int ret;
 
 	if (channel->primary_channel != NULL)
 		return -EINVAL;
 
-	/* Snapshot the list of subchannels */
-	spin_lock_irqsave(&channel->lock, flags);
-	list_splice_init(&channel->sc_list, &list);
-	spin_unlock_irqrestore(&channel->lock, flags);
-
-	list_for_each_entry_safe(cur_channel, tmp, &list, sc_list) {
+	list_for_each_entry_safe(cur_channel, tmp, &channel->sc_list, sc_list) {
 		if (cur_channel->rescind)
 			wait_for_completion(&cur_channel->rescind_event);
 
-- 
2.19.1



