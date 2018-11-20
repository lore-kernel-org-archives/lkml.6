Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B676C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B234420671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm6YX6A0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B234420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeKTTvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:51:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43922 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeKTTvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:51:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so629894pgk.10;
        Tue, 20 Nov 2018 01:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J+loFHLIN/FpfsI3KCBtBQYTvBRNwHz945sVMVsirKM=;
        b=Mm6YX6A0OIp6lPhSTJ7SgQeH7eJJym1f9KEdkggcB49qT4HogYzT4VfNmI2bAYeQaw
         3iVyw3bASUR+HPH8RPp+5KoCbmOsYC5NZRuVIfhTlflao6wbiXqvVHJ46m1ZsYWV0oCb
         wNP8+/B8wH1rOXLrNVqYFYo6xM6JeKBesT2xdgOt48Bcc1jjRLh990LJD3MLTBiBio24
         TzokXYByj1ZAqtrP4byJkpy0+AfG5t7dJS89Uk4l+sMK9GXCR6k5fRNpsIE/vJ2idKvT
         ihftF86eYbRkaCc26vij7Jgcu45NVngBd5Cj5vRvYwvibLKtq3LIxLQfrB1r1cpIrn61
         ONYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J+loFHLIN/FpfsI3KCBtBQYTvBRNwHz945sVMVsirKM=;
        b=kwg4k6WR7k5Zgx2sqz9cO7hyoTPMbv+6//JG1Uei2pPpe0KpxkGzB/VW0fYugm/VDE
         1xZaOJbxnu54tjOvPTsqmT9v/UaR3fJg6rD728yQEMcZ7xFNx3EHVHdrKkKR6ByDmanZ
         Z/WvVPYlhyk6o/TLUlKtkgnGzI3WuKJltE1ve4gW1D+3gwwW/fOBTw5naMP9JEAGWsWB
         lia5UFEhc/XF0BPQhTw0qzCrp2um50kLwlbVEf0H97UnkeeSk7otbKQhUXKJR3cIxiWG
         KIK6NJ6HQcE3KNdjiz/pAFaEAwIxX+ylxkMkvj0WQ/9ZJGXoC1/pQH49AON3h4Xu7LOa
         4GXA==
X-Gm-Message-State: AA+aEWY3Mwp5IenWFc+FMQZZBn+m1oVX4K07MW1m1h1Z5OKeIAX6SYRV
        262VuXRG/d2KLkD7f35dm6o=
X-Google-Smtp-Source: AJdET5ei3u2dtBzIEIztlBGrLp3EiaXC8PKHlkGE6cjld6FrLuoNFWEsYJzrQx/4/lCOepoDO90RxA==
X-Received: by 2002:a63:ce08:: with SMTP id y8mr1196467pgf.388.1542705812650;
        Tue, 20 Nov 2018 01:23:32 -0800 (PST)
Received: from leo.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y89sm426896pfa.136.2018.11.20.01.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 01:23:32 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:23:21 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     karn@ka9q.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: hard-coded limit on unresolved multicast route cache in
 ipv4/ipmr.c causes slow, unreliable creation of multicast routes on busy
 networks
Message-ID: <20181120092321.GR24677@leo.usersys.redhat.com>
References: <147f730b-8cbf-b76d-f693-b3fdaf72a89c@ka9q.net>
 <20180721.220309.1193443933653884021.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721.220309.1193443933653884021.davem@davemloft.net>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sat, Jul 21, 2018 at 10:03:09PM -0700, David Miller wrote:
> Yeah that limit is bogus for several reasons.
...
> 
> Therefore, it probably is safe and correct to remove this
> cache_resolve_queue_len altogether.
> 
> Something like this:
> 
> diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
> index d633f737b3c6..b166465d7c05 100644
> --- a/include/linux/mroute_base.h
> +++ b/include/linux/mroute_base.h
> @@ -234,7 +234,6 @@ struct mr_table_ops {
>   * @mfc_hash: Hash table of all resolved routes for easy lookup
>   * @mfc_cache_list: list of resovled routes for possible traversal
>   * @maxvif: Identifier of highest value vif currently in use
> - * @cache_resolve_queue_len: current size of unresolved queue
>   * @mroute_do_assert: Whether to inform userspace on wrong ingress
>   * @mroute_do_pim: Whether to receive IGMP PIMv1
>   * @mroute_reg_vif_num: PIM-device vif index
> @@ -251,7 +250,6 @@ struct mr_table {
>  	struct rhltable		mfc_hash;
>  	struct list_head	mfc_cache_list;
>  	int			maxvif;
> -	atomic_t		cache_resolve_queue_len;
>  	bool			mroute_do_assert;
>  	bool			mroute_do_pim;
>  	int			mroute_reg_vif_num;
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 9f79b9803a16..c007cf9bfe82 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -747,8 +747,6 @@ static void ipmr_destroy_unres(struct mr_table *mrt, struct mfc_cache *c)
>  	struct sk_buff *skb;
>  	struct nlmsgerr *e;
>  
> -	atomic_dec(&mrt->cache_resolve_queue_len);
> -
>  	while ((skb = skb_dequeue(&c->_c.mfc_un.unres.unresolved))) {
>  		if (ip_hdr(skb)->version == 0) {
>  			struct nlmsghdr *nlh = skb_pull(skb,
> @@ -1135,9 +1133,11 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
>  	}
>  
>  	if (!found) {
> +		bool was_empty;
> +
>  		/* Create a new entry if allowable */
> -		if (atomic_read(&mrt->cache_resolve_queue_len) >= 10 ||
> -		    (c = ipmr_cache_alloc_unres()) == NULL) {
> +		c = ipmr_cache_alloc_unres();
> +		if (!c) {
>  			spin_unlock_bh(&mfc_unres_lock);
>  
>  			kfree_skb(skb);
> @@ -1163,11 +1163,11 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
>  			return err;
>  		}
>  
> -		atomic_inc(&mrt->cache_resolve_queue_len);
> +		was_empty = list_empty(&mrt->mfc_unres_queue);
>  		list_add(&c->_c.list, &mrt->mfc_unres_queue);
>  		mroute_netlink_event(mrt, c, RTM_NEWROUTE);
>  
> -		if (atomic_read(&mrt->cache_resolve_queue_len) == 1)
> +		if (was_empty)
>  			mod_timer(&mrt->ipmr_expire_timer,
>  				  c->_c.mfc_un.unres.expires);

In ipmr_expire_process() and ipmr_do_expire_process(), they start mod_timer
when !list_empty(&mrt->mfc_unres_queue), should here also be !was_empty?

BTW, do you have any plan to apply this patch in kernel?

Regards
Hangbin

>  	}
> @@ -1274,7 +1274,6 @@ static int ipmr_mfc_add(struct net *net, struct mr_table *mrt,
>  		if (uc->mfc_origin == c->mfc_origin &&
>  		    uc->mfc_mcastgrp == c->mfc_mcastgrp) {
>  			list_del(&_uc->list);
> -			atomic_dec(&mrt->cache_resolve_queue_len);
>  			found = true;
>  			break;
>  		}
> @@ -1322,7 +1321,7 @@ static void mroute_clean_tables(struct mr_table *mrt, bool all)
>  		mr_cache_put(c);
>  	}
>  
> -	if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
> +	if (!list_empty(&mrt->mfc_unres_queue)) {
>  		spin_lock_bh(&mfc_unres_lock);
>  		list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
>  			list_del(&c->list);
> @@ -2648,9 +2647,19 @@ static int ipmr_rtm_route(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		return ipmr_mfc_delete(tbl, &mfcc, parent);
>  }
>  
> +static int queue_count(struct mr_table *mrt)
> +{
> +	struct list_head *pos;
> +	int count = 0;
> +	
> +	list_for_each(pos, &mrt->mfc_unres_queue)
> +		count++;
> +	return count;
> +}
> +
>  static bool ipmr_fill_table(struct mr_table *mrt, struct sk_buff *skb)
>  {
> -	u32 queue_len = atomic_read(&mrt->cache_resolve_queue_len);
> +	u32 queue_len = queue_count(mrt);
>  
>  	if (nla_put_u32(skb, IPMRA_TABLE_ID, mrt->id) ||
>  	    nla_put_u32(skb, IPMRA_TABLE_CACHE_RES_QUEUE_LEN, queue_len) ||
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index 0d0f0053bb11..75e9c5a3e7ea 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -759,8 +759,6 @@ static void ip6mr_destroy_unres(struct mr_table *mrt, struct mfc6_cache *c)
>  	struct net *net = read_pnet(&mrt->net);
>  	struct sk_buff *skb;
>  
> -	atomic_dec(&mrt->cache_resolve_queue_len);
> -
>  	while ((skb = skb_dequeue(&c->_c.mfc_un.unres.unresolved)) != NULL) {
>  		if (ipv6_hdr(skb)->version == 0) {
>  			struct nlmsghdr *nlh = skb_pull(skb,
> @@ -1139,8 +1137,8 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
>  		 *	Create a new entry if allowable
>  		 */
>  
> -		if (atomic_read(&mrt->cache_resolve_queue_len) >= 10 ||
> -		    (c = ip6mr_cache_alloc_unres()) == NULL) {
> +		c = ip6mr_cache_alloc_unres();
> +		if (!c) {
>  			spin_unlock_bh(&mfc_unres_lock);
>  
>  			kfree_skb(skb);
> @@ -1167,7 +1165,6 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
>  			return err;
>  		}
>  
> -		atomic_inc(&mrt->cache_resolve_queue_len);
>  		list_add(&c->_c.list, &mrt->mfc_unres_queue);
>  		mr6_netlink_event(mrt, c, RTM_NEWROUTE);
>  
> @@ -1455,7 +1452,6 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
>  		if (ipv6_addr_equal(&uc->mf6c_origin, &c->mf6c_origin) &&
>  		    ipv6_addr_equal(&uc->mf6c_mcastgrp, &c->mf6c_mcastgrp)) {
>  			list_del(&_uc->list);
> -			atomic_dec(&mrt->cache_resolve_queue_len);
>  			found = true;
>  			break;
>  		}
> @@ -1502,7 +1498,7 @@ static void mroute_clean_tables(struct mr_table *mrt, bool all)
>  		mr_cache_put(c);
>  	}
>  
> -	if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
> +	if (!list_empty(&mrt->mfc_unres_queue)) {
>  		spin_lock_bh(&mfc_unres_lock);
>  		list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
>  			list_del(&c->list);
