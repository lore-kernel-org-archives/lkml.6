Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6C3C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D2B20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D2B20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeLIWLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:11:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37700 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726975AbeLIWLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:11:31 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73C-0002iq-9o; Sun, 09 Dec 2018 21:55:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003P3-QH; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Florian Westphal" <fw@strlen.de>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.158413680@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 145/328] netfilter: nf_tables: fix register ordering
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit d209df3e7f7002d9099fdb0f6df0f972b4386a63 upstream.

We must register nfnetlink ops last, as that exposes nf_tables to
userspace.  Without this, we could theoretically get nfnetlink request
before net->nft state has been initialized.

Fixes: 99633ab29b213 ("netfilter: nf_tables: complete net namespace support")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[bwh: Backported to 3.16:
 - We don't call nft_chain_filter_{init,fini}() or
   {,un}register_netdevice_notifier()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4042,6 +4042,10 @@ static int __init nf_tables_module_init(
 {
 	int err;
 
+	err = register_pernet_subsys(&nf_tables_net_ops);
+	if (err < 0)
+		return err;
+
 	info = kmalloc(sizeof(struct nft_expr_info) * NFT_RULE_MAXEXPRS,
 		       GFP_KERNEL);
 	if (info == NULL) {
@@ -4053,17 +4057,19 @@ static int __init nf_tables_module_init(
 	if (err < 0)
 		goto err2;
 
+	/* must be last */
 	err = nfnetlink_subsys_register(&nf_tables_subsys);
 	if (err < 0)
 		goto err3;
 
 	pr_info("nf_tables: (c) 2007-2009 Patrick McHardy <kaber@trash.net>\n");
-	return register_pernet_subsys(&nf_tables_net_ops);
+	return err;
 err3:
 	nf_tables_core_module_exit();
 err2:
 	kfree(info);
 err1:
+	unregister_pernet_subsys(&nf_tables_net_ops);
 	return err;
 }
 

