Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45ADC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844FB206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865291;
	bh=hIGqcqvl3KqmUkYcSlqCqX8fiakG8eR57bOjyEZ9jtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=01vKHIQIq53eNpAuu6jm8DwSDNdjuH7vhK6rFWSm56zxeYWt9aVLzZf/Kp3ctKppM
	 l1D7B+h9Mqq+nx/nyRpdWWCayFM1t2DQTbbjTd5D477g1DtDb/REW17d+YhjLdOXos
	 so5sJ8dG5lcZTQNWyeG4GbZhkXUlx/jOIQxcY8+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfAGMsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728875AbfAGMsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52B49206BB;
        Mon,  7 Jan 2019 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865286;
        bh=hIGqcqvl3KqmUkYcSlqCqX8fiakG8eR57bOjyEZ9jtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBm3a3zy8Po6eWZNqai+zFezbCsOZZ5p0xEM74/a/8Ah7p54fNf1g36jiJ3ec4POW
         shsyHBcPxmHMq49eq3c7LltAw4yHjDAvV8Ez1Q/XiIjCrHAZLbGEG+1qkQPiGnz3AR
         3drulQV0rnQnaz9XxIMV/lWLzeKCpPx0o41bxNnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiumei Mu <xmu@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 044/170] ipv6: frags: Fix bogus skb->sk in reassembled packets
Date:   Mon,  7 Jan 2019 13:31:11 +0100
Message-Id: <20190107104458.439410173@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit d15f5ac8deea936d3adf629421a66a88b42b8a2f ]

It was reported that IPsec would crash when it encounters an IPv6
reassembled packet because skb->sk is non-zero and not a valid
pointer.

This is because skb->sk is now a union with ip_defrag_offset.

This patch fixes this by resetting skb->sk when exiting from
the reassembly code.

Reported-by: Xiumei Mu <xmu@redhat.com>
Fixes: 219badfaade9 ("ipv6: frags: get rid of ip6frag_skb_cb/...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/reassembly.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -384,6 +384,7 @@ static int ip6_frag_reasm(struct frag_qu
 		if (skb_try_coalesce(head, fp, &headstolen, &delta)) {
 			kfree_skb_partial(fp, headstolen);
 		} else {
+			fp->sk = NULL;
 			if (!skb_shinfo(head)->frag_list)
 				skb_shinfo(head)->frag_list = fp;
 			head->data_len += fp->len;


