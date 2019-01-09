Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11E0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85E32075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfAIWnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:43:41 -0500
Received: from mail.us.es ([193.147.175.20]:52916 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfAIWnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:43:41 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 59A6F19D8A7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 23:43:38 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 48F9DDA796
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 23:43:38 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 32A10DA867; Wed,  9 Jan 2019 23:43:38 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 19F54DA7F4;
        Wed,  9 Jan 2019 23:43:36 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 09 Jan 2019 23:43:36 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id DA6A74265A4C;
        Wed,  9 Jan 2019 23:43:35 +0100 (CET)
Date:   Wed, 9 Jan 2019 23:43:35 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipset: fix a missing check of nla_parse
Message-ID: <20190109224335.qe6f4x4722qz6x5p@salvia>
References: <20181226035002.73614-1-kjlu@umn.edu>
 <c462e7f4-6c41-78e8-26e9-8ce16ca26a5c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c462e7f4-6c41-78e8-26e9-8ce16ca26a5c@virtuozzo.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 12:16:25PM +0300, Kirill Tkhai wrote:
> On 26.12.2018 06:50, Kangjie Lu wrote:
> > When nla_parse fails, we should not use the results (the first
> > argument). The fix checks if it fails, and if so, returns its error code
> > upstream.
> > 
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> >  net/netfilter/ipset/ip_set_core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
> > index 1577f2f76060..4dc8057cff02 100644
> > --- a/net/netfilter/ipset/ip_set_core.c
> > +++ b/net/netfilter/ipset/ip_set_core.c
> > @@ -1531,8 +1531,10 @@ call_ad(struct sock *ctnl, struct sk_buff *skb, struct ip_set *set,
> >  		memcpy(&errmsg->msg, nlh, nlh->nlmsg_len);
> >  		cmdattr = (void *)&errmsg->msg + min_len;
> >  
> > -		nla_parse(cda, IPSET_ATTR_CMD_MAX, cmdattr,
> > +		ret = nla_parse(cda, IPSET_ATTR_CMD_MAX, cmdattr,
> >  			  nlh->nlmsg_len - min_len, ip_set_adt_policy, NULL);

@Kangjie: nitpick, could you align this line below? ie.

		ret = nla_parse(cda, IPSET_ATTR_CMD_MAX, cmdattr,
                                nlh->nlmsg_len - min_len, ip_set_adt_policy,
                                NULL);

> > +		if (ret)
> > +			return ret;
> 
> In this function above nlmsg_new() allocates skb2, but I don't see, where you free it here.

netlink_unicast() is responsible for releasing this skb2.

> >  		errline = nla_data(cda[IPSET_ATTR_LINENO]);
> >  
> > 
