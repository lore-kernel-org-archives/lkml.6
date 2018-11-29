Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CE5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4732081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlVavSS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4732081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbeK3CDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:03:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730793AbeK3B0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:26:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4FA92133F;
        Thu, 29 Nov 2018 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501235;
        bh=iSlorhtqpqFlw/uvyMBbl75HVE7OrBj5J06vwFWYyzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlVavSS0QeFCEXTtqhW70GUZxT0d3ERRoe7xpbirPOzzVBJ6e50W7hGLlz7wDqUEB
         JA7DwOXEEuin217ZZ8zW+L0GGAUUt9AUgNYepC6V+LyL2dl8Mm2y5/vw1hb65sdC9T
         ACUiAX4uydyRsgrLLuPD7d7fqjoKmRaEbqDNvlZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dalegaard <dalegaard@gmail.com>,
        Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 72/86] netfilter: nf_tables: fix oops when inserting an element into a verdict map
Date:   Thu, 29 Nov 2018 15:12:37 +0100
Message-Id: <20181129140115.788351734@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
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

From: Liping Zhang <zlpnobody@gmail.com>

commit 58c78e104d937c1f560fb10ed9bb2dcde0db4fcf upstream.

Dalegaard says:
 The following ruleset, when loaded with 'nft -f bad.txt'
 ----snip----
 flush ruleset
 table ip inlinenat {
   map sourcemap {
     type ipv4_addr : verdict;
   }

   chain postrouting {
     ip saddr vmap @sourcemap accept
   }
 }
 add chain inlinenat test
 add element inlinenat sourcemap { 100.123.10.2 : jump test }
 ----snip----

 results in a kernel oops:
 BUG: unable to handle kernel paging request at 0000000000001344
 IP: [<ffffffffa07bf704>] nf_tables_check_loops+0x114/0x1f0 [nf_tables]
 [...]
 Call Trace:
  [<ffffffffa07c2aae>] ? nft_data_init+0x13e/0x1a0 [nf_tables]
  [<ffffffffa07c1950>] nft_validate_register_store+0x60/0xb0 [nf_tables]
  [<ffffffffa07c74b5>] nft_add_set_elem+0x545/0x5e0 [nf_tables]
  [<ffffffffa07bfdd0>] ? nft_table_lookup+0x30/0x60 [nf_tables]
  [<ffffffff8132c630>] ? nla_strcmp+0x40/0x50
  [<ffffffffa07c766e>] nf_tables_newsetelem+0x11e/0x210 [nf_tables]
  [<ffffffff8132c400>] ? nla_validate+0x60/0x80
  [<ffffffffa030d9b4>] nfnetlink_rcv+0x354/0x5a7 [nfnetlink]

Because we forget to fill the net pointer in bind_ctx, so dereferencing
it may cause kernel crash.

Reported-by: Dalegaard <dalegaard@gmail.com>
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_tables_api.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3452,6 +3452,7 @@ static int nft_add_set_elem(struct nft_c
 		dreg = nft_type_to_reg(set->dtype);
 		list_for_each_entry(binding, &set->bindings, list) {
 			struct nft_ctx bind_ctx = {
+				.net	= ctx->net,
 				.afi	= ctx->afi,
 				.table	= ctx->table,
 				.chain	= (struct nft_chain *)binding->chain,


