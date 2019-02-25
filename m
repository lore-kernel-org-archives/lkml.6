Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C283C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529B22146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551132134;
	bh=cDB0m4P7sX9dDfb2Jv2K2h6Cb9SEt0HFFxsWzNLeMgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EaL2EbJR+v91BS8bW1630A+pvecAPGeGhPdNiBVP9BvT2gqMdrff8Pj0m3cfMF1Vb
	 l508pf9cGEV1vrpLgVap/ZZ7bnOoPUnUiQjskbB2Ei2Rx5U16OEiAXm75DBVA7nLNt
	 Um63Zlu5wpVsk8jbe2W2PiNTZhIOyqgYT9sIT6wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfBYWCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfBYVQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:16:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D78692173C;
        Mon, 25 Feb 2019 21:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129361;
        bh=cDB0m4P7sX9dDfb2Jv2K2h6Cb9SEt0HFFxsWzNLeMgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EY52I5MvTtXUDbO73Iw6/HsGxZUy9gQTUPqW5uPTo+eg1AyrUUXGnsNf94FUP8AIT
         wwDyjf19KQZZ9oJJNcRz9k0WR7I1CXKjkx4Mkw4B0LKUcm/ZAnJOwXj4ZWu+E9Qxl+
         a8K5N0CJu5x1u0/FECE4Ukfq8XP31u/jrKe3znk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 59/63] netfilter: nf_tables: fix flush after rule deletion in the same batch
Date:   Mon, 25 Feb 2019 22:11:59 +0100
Message-Id: <20190225195040.334073125@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 23b7ca4f745f21c2b9cfcb67fdd33733b3ae7e66 upstream.

Flush after rule deletion bogusly hits -ENOENT. Skip rules that have
been already from nft_delrule_by_chain() which is always called from the
flush path.

Fixes: cf9dc09d0949 ("netfilter: nf_tables: fix missing rules flushing per table")
Reported-by: Phil Sutter <phil@nwl.cc>
Acked-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_tables_api.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -263,6 +263,9 @@ static int nft_delrule_by_chain(struct n
 	int err;
 
 	list_for_each_entry(rule, &ctx->chain->rules, list) {
+		if (!nft_is_active_next(ctx->net, rule))
+			continue;
+
 		err = nft_delrule(ctx, rule);
 		if (err < 0)
 			return err;


