Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17111C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D659C2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130650;
	bh=vKlV9dpPXXLKH7nJ67kBohb6Y4fLqFDR4M6U9Qh42nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ejbQusxbeaj9mO8fhMuWdKP1y68fg4nu/ymgzkkSWMTYKUrHCp1AmLhBmIaUoGrVw
	 1FDvh8+U0CLLLQb4A9DQAG2kfZUqv1gMa+Rn4dyWsbNKrOxoExyX9wNxBaN1k1aViW
	 kP7ZZm3FV8mIBbET2jbdI/LVqHJv/JjqW+utBCQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbfBYVh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:37:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387437AbfBYVhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:37:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5FDA2184E;
        Mon, 25 Feb 2019 21:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130644;
        bh=vKlV9dpPXXLKH7nJ67kBohb6Y4fLqFDR4M6U9Qh42nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s2JRuFEc9IMnD4PW453l8QGY2yGIYyoWalqdkI4cTbjr+9DviSwreWs7WhSJOG1y9
         iUMTx474eHbjZe3I/3W+bcI/5/dyKFl6fOfvnY+82X5LHpovuAydGUageesixCPEIa
         7P59mHBEsB9o40nuLVUrZyj4+m7m23N9ANtKN0Ik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Oussama Ghorbel <ghorbel@pivasoftware.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 139/183] sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()
Date:   Mon, 25 Feb 2019 22:11:52 +0100
Message-Id: <20190225195118.311902893@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 173656accaf583698bac3f9e269884ba60d51ef4 ]

If we disabled IPv6 from the kernel command line (ipv6.disable=1), we should
not call ip6_err_gen_icmpv6_unreach(). This:

  ip link add sit1 type sit local 192.0.2.1 remote 192.0.2.2 ttl 1
  ip link set sit1 up
  ip addr add 198.51.100.1/24 dev sit1
  ping 198.51.100.2

if IPv6 is disabled at boot time, will crash the kernel.

v2: there's no need to use in6_dev_get(), use __in6_dev_get() instead,
    as we only need to check that idev exists and we are under
    rcu_read_lock() (from netif_receive_skb_internal()).

Reported-by: Jianlin Shi <jishi@redhat.com>
Fixes: ca15a078bd90 ("sit: generate icmpv6 error when receiving icmpv4 error")
Cc: Oussama Ghorbel <ghorbel@pivasoftware.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -546,7 +546,8 @@ static int ipip6_err(struct sk_buff *skb
 	}
 
 	err = 0;
-	if (!ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4, type, data_len))
+	if (__in6_dev_get(skb->dev) &&
+	    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4, type, data_len))
 		goto out;
 
 	if (t->parms.iph.daddr == 0)


