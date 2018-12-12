Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB32C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A7C2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A7C2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeLLX0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:26:54 -0500
Received: from mail.us.es ([193.147.175.20]:41744 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbeLLX0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:26:53 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4FFFEFF2CF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 00:26:51 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3DEA8DA7A5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 00:26:51 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2D4C3DA79C; Thu, 13 Dec 2018 00:26:51 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 43E63DA738;
        Thu, 13 Dec 2018 00:26:49 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 13 Dec 2018 00:26:49 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1C0924265A4C;
        Thu, 13 Dec 2018 00:26:49 +0100 (CET)
Date:   Thu, 13 Dec 2018 00:26:48 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] netfilter: fix missed NULL check in
 nf_conntrack_proto_pernet_init()
Message-ID: <20181212232648.qsvyuc3g2jj5v2ej@salvia>
References: <1544014590-14429-1-git-send-email-laoar.shao@gmail.com>
 <1544014590-14429-4-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544014590-14429-4-git-send-email-laoar.shao@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 08:56:29PM +0800, Yafang Shao wrote:
> nf_ct_l4proto_net() may return NULL.
> That may happens if some module forget to set both l4proto->get_net_proto
> and l4proto->net_id.
> We'd check the return value here, in case crash happens.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  net/netfilter/nf_conntrack_proto.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/netfilter/nf_conntrack_proto.c b/net/netfilter/nf_conntrack_proto.c
> index 154e8c0..316fef3 100644
> --- a/net/netfilter/nf_conntrack_proto.c
> +++ b/net/netfilter/nf_conntrack_proto.c
> @@ -946,6 +946,9 @@ int nf_conntrack_proto_pernet_init(struct net *net)
>  	struct nf_proto_net *pn = nf_ct_l4proto_net(net,
>  					&nf_conntrack_l4proto_generic);

There is another spot missing in this file that is missing the check
for NULL.

We can probably simplify all this is we place the gre conntracker in
the conntrack core, as it's been suggested already. It's the only one
remaining as a module and it now supports for IPv6, so it's probably
better follow that path.
