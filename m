Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066ACC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA6C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9Qsl5Gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA6C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLDGvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:51:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37146 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLDGvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:51:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so7812427plr.4;
        Mon, 03 Dec 2018 22:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=m2bgCmm9oFGj+7a89CfW8WSKtMSZZzQPl2BTKevlZ38=;
        b=q9Qsl5GnjoKUDVPyQaDHIA0w7cY1yp0ZDagwuXQoGmJSSSQ9siAihfvZ5bT46t00BY
         OFtToLcKufzyMhdbBUI0c0moFJNdu4z7SGJqoosQ8wpQRDxumqF0sbI/UrIRJ5v65+NP
         l3vILYYt69168FoC9w9klBKs+d4Qrg0h5YfZgIKxwm1QozFIk6k5ytfY6zk2czUpLh49
         EFj3vHw7tzVBg37S4Fth03rwCvGKbRwkJ1O7iveAGCIo2fFbX6Tvl8ac65FhsrPEwErX
         nuqpLNcdeFtR93QtyYRlkKQfjxPU23q5eP4dXKyXObYzrWTxuCHWfwnCT5wIQU8hBBVK
         +vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m2bgCmm9oFGj+7a89CfW8WSKtMSZZzQPl2BTKevlZ38=;
        b=B8Rb6xllyXlRNBWLRJl8E0S3jns774tHoInRH/NyTCrVZ2yCZR5UeUw6IbHKMwwzCM
         fr1+dxMbISHTkYIADriV3Gj+CH7V0+ScC6Du1XvMwLLd21uZVIDSsc8EYAqMCJKlF3mD
         Gbw1MOpHidf88k92/2a7zZYZgVq6LEGtg8+NdGtWvw2waRDotflh7aFDAJvT+tSiHlmW
         d41S6qxud5FiS2Ee5/atDptRqwUorbM4eqF5VKDnM8eYC24lE5z0XtPNAOybEN0bPsHL
         JptzJ7S9Lsb/23h1zF1HG5Ey/eBaiPkMeKCg9S1/6+qFghRjqPvz3W/ZrE2Njdr7fO5a
         ck0w==
X-Gm-Message-State: AA+aEWbrTdlC8yxQn80PtrqwBbwFeuoh4Xd1ST3/RPArEQjLdvTvb7Hc
        T+91dMjQGybj9liMgZHM30nSFwo3
X-Google-Smtp-Source: AFSGD/V5P4x2zNuuorNpTPc2KCkSOwwHsIZbnaXtvXOJgtek5ntT9s4VzTfELikXfh4OAXAFuCbVgA==
X-Received: by 2002:a17:902:6ac5:: with SMTP id i5mr19095570plt.134.1543906272109;
        Mon, 03 Dec 2018 22:51:12 -0800 (PST)
Received: from leo.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 7sm63236968pfm.8.2018.12.03.22.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 22:51:11 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:51:01 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Sukumar Gopalakrishnan <sukumarg1973@gmail.com>
Cc:     davem@davemloft.net, karn@ka9q.net, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: hard-coded limit on unresolved multicast route cache in
 ipv4/ipmr.c causes slow, unreliable creation of multicast routes on busy
 networks
Message-ID: <20181204065100.GT24677@leo.usersys.redhat.com>
References: <147f730b-8cbf-b76d-f693-b3fdaf72a89c@ka9q.net>
 <20180721.220309.1193443933653884021.davem@davemloft.net>
 <20181120092321.GR24677@leo.usersys.redhat.com>
 <CADiZnkSy=rFq5xLs6RcgJDihQ1Vwo2WBBY9Fi_5jOHr8XupukQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiZnkSy=rFq5xLs6RcgJDihQ1Vwo2WBBY9Fi_5jOHr8XupukQ@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:44:49AM +0530, Sukumar Gopalakrishnan wrote:
> Hi,
> 
>  There is a patch to make this queue len configurable. Is below mentioned going
> to be applied ?
> 
> http://lkml.iu.edu/hypermail/linux/kernel/1810.3/02344.html

It looks this topic stuckd again..

> 
> Regards,
> Sukumar
> 
> On Tue, Nov 20, 2018 at 2:55 PM Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
>     Hi David,
> 
>     On Sat, Jul 21, 2018 at 10:03:09PM -0700, David Miller wrote:
>     > Yeah that limit is bogus for several reasons.
>     ...
>     >
>     > Therefore, it probably is safe and correct to remove this
>     > cache_resolve_queue_len altogether.
>     >
>     > Something like this:
>     >
>     > diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
>     > index d633f737b3c6..b166465d7c05 100644
>     > --- a/include/linux/mroute_base.h
>     > +++ b/include/linux/mroute_base.h
>     > @@ -234,7 +234,6 @@ struct mr_table_ops {
>     >   * @mfc_hash: Hash table of all resolved routes for easy lookup
>     >   * @mfc_cache_list: list of resovled routes for possible traversal
>     >   * @maxvif: Identifier of highest value vif currently in use
>     > - * @cache_resolve_queue_len: current size of unresolved queue
>     >   * @mroute_do_assert: Whether to inform userspace on wrong ingress
>     >   * @mroute_do_pim: Whether to receive IGMP PIMv1
>     >   * @mroute_reg_vif_num: PIM-device vif index
>     > @@ -251,7 +250,6 @@ struct mr_table {
>     >       struct rhltable         mfc_hash;
>     >       struct list_head        mfc_cache_list;
>     >       int                     maxvif;
>     > -     atomic_t                cache_resolve_queue_len;
>     >       bool                    mroute_do_assert;
>     >       bool                    mroute_do_pim;
>     >       int                     mroute_reg_vif_num;
>     > diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
>     > index 9f79b9803a16..c007cf9bfe82 100644
>     > --- a/net/ipv4/ipmr.c
>     > +++ b/net/ipv4/ipmr.c
>     > @@ -747,8 +747,6 @@ static void ipmr_destroy_unres(struct mr_table *mrt,
>     struct mfc_cache *c)
>     >       struct sk_buff *skb;
>     >       struct nlmsgerr *e;
>     > 
>     > -     atomic_dec(&mrt->cache_resolve_queue_len);
>     > -
>     >       while ((skb = skb_dequeue(&c->_c.mfc_un.unres.unresolved))) {
>     >               if (ip_hdr(skb)->version == 0) {
>     >                       struct nlmsghdr *nlh = skb_pull(skb,
>     > @@ -1135,9 +1133,11 @@ static int ipmr_cache_unresolved(struct mr_table
>     *mrt, vifi_t vifi,
>     >       }
>     > 
>     >       if (!found) {
>     > +             bool was_empty;
>     > +
>     >               /* Create a new entry if allowable */
>     > -             if (atomic_read(&mrt->cache_resolve_queue_len) >= 10 ||
>     > -                 (c = ipmr_cache_alloc_unres()) == NULL) {
>     > +             c = ipmr_cache_alloc_unres();
>     > +             if (!c) {
>     >                       spin_unlock_bh(&mfc_unres_lock);
>     > 
>     >                       kfree_skb(skb);
>     > @@ -1163,11 +1163,11 @@ static int ipmr_cache_unresolved(struct mr_table
>     *mrt, vifi_t vifi,
>     >                       return err;
>     >               }
>     > 
>     > -             atomic_inc(&mrt->cache_resolve_queue_len);
>     > +             was_empty = list_empty(&mrt->mfc_unres_queue);
>     >               list_add(&c->_c.list, &mrt->mfc_unres_queue);
>     >               mroute_netlink_event(mrt, c, RTM_NEWROUTE);
>     > 
>     > -             if (atomic_read(&mrt->cache_resolve_queue_len) == 1)
>     > +             if (was_empty)
>     >                       mod_timer(&mrt->ipmr_expire_timer,
>     >                                 c->_c.mfc_un.unres.expires);
> 
>     In ipmr_expire_process() and ipmr_do_expire_process(), they start mod_timer
>     when !list_empty(&mrt->mfc_unres_queue), should here also be !was_empty?
> 
>     BTW, do you have any plan to apply this patch in kernel?
> 
>     Regards
>     Hangbin
> 
>     >       }
>     > @@ -1274,7 +1274,6 @@ static int ipmr_mfc_add(struct net *net, struct
>     mr_table *mrt,
>     >               if (uc->mfc_origin == c->mfc_origin &&
>     >                   uc->mfc_mcastgrp == c->mfc_mcastgrp) {
>     >                       list_del(&_uc->list);
>     > -                     atomic_dec(&mrt->cache_resolve_queue_len);
>     >                       found = true;
>     >                       break;
>     >               }
>     > @@ -1322,7 +1321,7 @@ static void mroute_clean_tables(struct mr_table
>     *mrt, bool all)
>     >               mr_cache_put(c);
>     >       }
>     > 
>     > -     if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
>     > +     if (!list_empty(&mrt->mfc_unres_queue)) {
>     >               spin_lock_bh(&mfc_unres_lock);
>     >               list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue,
>     list) {
>     >                       list_del(&c->list);
>     > @@ -2648,9 +2647,19 @@ static int ipmr_rtm_route(struct sk_buff *skb,
>     struct nlmsghdr *nlh,
>     >               return ipmr_mfc_delete(tbl, &mfcc, parent);
>     >  }
>     > 
>     > +static int queue_count(struct mr_table *mrt)
>     > +{
>     > +     struct list_head *pos;
>     > +     int count = 0;
>     > +     
>     > +     list_for_each(pos, &mrt->mfc_unres_queue)
>     > +             count++;
>     > +     return count;
>     > +}
>     > +
>     >  static bool ipmr_fill_table(struct mr_table *mrt, struct sk_buff *skb)
>     >  {
>     > -     u32 queue_len = atomic_read(&mrt->cache_resolve_queue_len);
>     > +     u32 queue_len = queue_count(mrt);
>     > 
>     >       if (nla_put_u32(skb, IPMRA_TABLE_ID, mrt->id) ||
>     >           nla_put_u32(skb, IPMRA_TABLE_CACHE_RES_QUEUE_LEN, queue_len) ||
>     > diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
>     > index 0d0f0053bb11..75e9c5a3e7ea 100644
>     > --- a/net/ipv6/ip6mr.c
>     > +++ b/net/ipv6/ip6mr.c
>     > @@ -759,8 +759,6 @@ static void ip6mr_destroy_unres(struct mr_table *mrt,
>     struct mfc6_cache *c)
>     >       struct net *net = read_pnet(&mrt->net);
>     >       struct sk_buff *skb;
>     > 
>     > -     atomic_dec(&mrt->cache_resolve_queue_len);
>     > -
>     >       while ((skb = skb_dequeue(&c->_c.mfc_un.unres.unresolved)) != NULL)
>     {
>     >               if (ipv6_hdr(skb)->version == 0) {
>     >                       struct nlmsghdr *nlh = skb_pull(skb,
>     > @@ -1139,8 +1137,8 @@ static int ip6mr_cache_unresolved(struct mr_table
>     *mrt, mifi_t mifi,
>     >                *      Create a new entry if allowable
>     >                */
>     > 
>     > -             if (atomic_read(&mrt->cache_resolve_queue_len) >= 10 ||
>     > -                 (c = ip6mr_cache_alloc_unres()) == NULL) {
>     > +             c = ip6mr_cache_alloc_unres();
>     > +             if (!c) {
>     >                       spin_unlock_bh(&mfc_unres_lock);
>     > 
>     >                       kfree_skb(skb);
>     > @@ -1167,7 +1165,6 @@ static int ip6mr_cache_unresolved(struct mr_table
>     *mrt, mifi_t mifi,
>     >                       return err;
>     >               }
>     > 
>     > -             atomic_inc(&mrt->cache_resolve_queue_len);
>     >               list_add(&c->_c.list, &mrt->mfc_unres_queue);
>     >               mr6_netlink_event(mrt, c, RTM_NEWROUTE);
>     > 
>     > @@ -1455,7 +1452,6 @@ static int ip6mr_mfc_add(struct net *net, struct
>     mr_table *mrt,
>     >               if (ipv6_addr_equal(&uc->mf6c_origin, &c->mf6c_origin) &&
>     >                   ipv6_addr_equal(&uc->mf6c_mcastgrp, &c->mf6c_mcastgrp))
>     {
>     >                       list_del(&_uc->list);
>     > -                     atomic_dec(&mrt->cache_resolve_queue_len);
>     >                       found = true;
>     >                       break;
>     >               }
>     > @@ -1502,7 +1498,7 @@ static void mroute_clean_tables(struct mr_table
>     *mrt, bool all)
>     >               mr_cache_put(c);
>     >       }
>     > 
>     > -     if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
>     > +     if (!list_empty(&mrt->mfc_unres_queue)) {
>     >               spin_lock_bh(&mfc_unres_lock);
>     >               list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue,
>     list) {
>     >                       list_del(&c->list);
> 
