Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E856CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5F82148E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5F82148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeHWLrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:47:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeHWLri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:47:38 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 25221C7B;
        Thu, 23 Aug 2018 08:19:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Feng <gfree.wind@vip.163.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 021/217] netfilter: nf_ct_helper: Fix possible panic after nf_conntrack_helper_unregister
Date:   Thu, 23 Aug 2018 09:52:14 +0200
Message-Id: <20180823075506.506080563@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Feng <gfree.wind@vip.163.com>

[ Upstream commit ad9852af97587b8abe8102f9ddcb05c9769656f6 ]

The helper module would be unloaded after nf_conntrack_helper_unregister,
so it may cause a possible panic caused by race.

nf_ct_iterate_destroy(unhelp, me) reset the helper of conntrack as NULL,
but maybe someone has gotten the helper pointer during this period. Then
it would panic, when it accesses the helper and the module was unloaded.

Take an example as following:
CPU0                                                   CPU1
ctnetlink_dump_helpinfo
helper = rcu_dereference(help->helper);
                                                       unhelp
                                                       set helper as NULL
                                                       unload helper module
helper->to_nlattr(skb, ct);

As above, the cpu0 tries to access the helper and its module is unloaded,
then the panic happens.

Signed-off-by: Gao Feng <gfree.wind@vip.163.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_conntrack_helper.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -465,6 +465,11 @@ void nf_conntrack_helper_unregister(stru
 
 	nf_ct_expect_iterate_destroy(expect_iter_me, NULL);
 	nf_ct_iterate_destroy(unhelp, me);
+
+	/* Maybe someone has gotten the helper already when unhelp above.
+	 * So need to wait it.
+	 */
+	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(nf_conntrack_helper_unregister);
 


