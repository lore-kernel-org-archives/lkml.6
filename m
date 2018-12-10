Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F7EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38D52084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38D52084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeLJLXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:23:33 -0500
Received: from mail.us.es ([193.147.175.20]:50350 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeLJLXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:23:33 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A5504443824
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:23:30 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5925ADA4D1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:23:30 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3BF61DA80D; Mon, 10 Dec 2018 12:23:30 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 75866DA4F6;
        Mon, 10 Dec 2018 12:23:23 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 10 Dec 2018 12:23:23 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 441EF4265A4C;
        Mon, 10 Dec 2018 12:23:23 +0100 (CET)
Date:   Mon, 10 Dec 2018 12:23:22 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc:     netfilter-devel@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S . Miller" <davem@davemloft.net>, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] netfilter: ebtables: avoid resetting limit
 rule state
Message-ID: <20181210112322.rxndlqmfckctbhjm@salvia>
References: <20181209061405.15112-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181209061405.15112-1-linus.luessing@c0d3.blue>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, Dec 09, 2018 at 07:14:05AM +0100, Linus Lüssing wrote:
> So far any changes with ebtables will reset the state of limit rules,
> leading to spikes in traffic. This is especially noticeable if changes
> are done frequently, for instance via a daemon.
> 
> This patch fixes this by bailing out from (re)setting if the limit
> rule was initialized before.
> 
> When sending packets every 250ms for 600s, with a
> "--limit 1/sec --limit-burst 50" rule and a command like this
> in the background:
> 
> $ ebtables -N VOIDCHAIN
> $ while true; do ebtables -F VOIDCHAIN; sleep 30; done
> 
> The results are:
> 
> Before: ~1600 packets
> After: 650 packets
> 
> This also aligns the behavior to "xtables-nft-multi ebtables" which uses
> nft_limit instead of ebt_limit. In tests nft_limit did not suffer from
> this issue and rate limited to 650 just fine.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> ---
> 
> Changelog v2:
> 
> - Adjusted commit message (adjusted title, added test results with
>   nft_limit for comparison)
> - Excluded rate limiting variables from zeroing when passed to userspace
>   by increasing .usersize. This became necessary with 4.11 /
>   commit ec2318904965 ("xtables: extend matches and targets with .usersize")
> - Retested with 4.20-rc4 and current net-next/master (83af01ba1c2d)
> 
> v1 was:
> 
> "[net-next] bridge: ebtables: Avoid resetting limit rule state"
> -> https://lore.kernel.org/patchwork/patch/854802/
> ---
>  net/bridge/netfilter/ebt_limit.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/netfilter/ebt_limit.c b/net/bridge/netfilter/ebt_limit.c
> index 165b9d678cf1..2cf9861c3bce 100644
> --- a/net/bridge/netfilter/ebt_limit.c
> +++ b/net/bridge/netfilter/ebt_limit.c
> @@ -69,6 +69,10 @@ static int ebt_limit_mt_check(const struct xt_mtchk_param *par)
>  {
>  	struct ebt_limit_info *info = par->matchinfo;
>  
> +	/* Do not reset state on unrelated table changes */
> +	if (info->prev)
> +		return 0;

Hm, still I don't think we can follow this path, even if it works.

This means we trust userspace in what it sets for info->prev.

Using ebtables-nft (instead of ebtables-legacy) fixes this problem,
without this patch.

> +
>  	/* Check for overflow. */
>  	if (info->burst == 0 ||
>  	    user2credits(info->avg * info->burst) < user2credits(info->avg)) {
> @@ -105,7 +109,7 @@ static struct xt_match ebt_limit_mt_reg __read_mostly = {
>  	.match		= ebt_limit_mt,
>  	.checkentry	= ebt_limit_mt_check,
>  	.matchsize	= sizeof(struct ebt_limit_info),
> -	.usersize	= offsetof(struct ebt_limit_info, prev),
> +	.usersize	= sizeof(struct ebt_limit_info),
>  #ifdef CONFIG_COMPAT
>  	.compatsize	= sizeof(struct ebt_compat_limit_info),
>  #endif
> -- 
> 2.11.0
> 
