Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C60C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5DF24D9F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bWcjg4p0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5DF24D9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964979AbeFYTtL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:49:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935141AbeFYTtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rs9qLEvNy4BlnxMzJ6Sj4/NTs6jKbRZhCgxQeKOe/9U=; b=bWcjg4p0iVGpIFXUbMjiWnbSa
        OZ5Gs4R7c1f3CsEjcmfEd6FqjJ2O9efLHcDUUW0O0hMBxXKX3RahouudmkdiINoT06mbuWSQ1Cb1W
        hQ7RcVzzdisQPkRoR/7gcrFyUxxOnCj45DA9Ip7ZAEY4rwuk+arIVKXC8o1DiBsTo9e1YnMVY3vSS
        hzidO5Y+Bg0EQkW2VS2wo1csqka4UL8AHyu6BznG+e1Ykgt58ZYmFAfSMWE/jNFRNgWIziL5Z+rUT
        9+MUgNlP/iocVtu2+3KOKYneddrsdE3kjEBCJkcXoYq1qgUrQuWazltYVtV1SEb2VvOZhl2G0LV9G
        I8zwC11Jg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXXU4-0002dS-7z; Mon, 25 Jun 2018 19:49:08 +0000
Subject: Re: [PATCH -next v2] cred: conditionally declare groups-related
 functions
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-audit@redhat.com
References: <20180625065532.7268-1-omosnace@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <72dc0303-3eda-b07d-9414-0702ff4e5fa6@infradead.org>
Date:   Mon, 25 Jun 2018 12:49:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625065532.7268-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/2018 11:55 PM, Ondrej Mosnacek wrote:
> The groups-related functions declared in include/linux/cred.h are
> defined in kernel/groups.c, which is compiled only when
> CONFIG_MULTIUSER=y. Move all these function declarations under #ifdef
> CONFIG_MULTIUSER to help avoid accidental usage in contexts where
> CONFIG_MULTIUSER might be disabled.
> 
> This patch also adds a fallback for groups_search(). Currently this
> function is only called from kernel/groups.c itself and
> keys/permissions.c, which depends on CONFIG_MULTIUSER. However, the
> audit subsystem (which does not depend on CONFIG_MULTIUSER) calls this
> function in -next, so the fallback will be needed to avoid compilation
> errors or ugly workarounds.
> 
> See also:
> https://lkml.org/lkml/2018/6/20/670
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git/commit/?h=next&id=af85d1772e31fed34165a1b3decef340cf4080c0
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/cred.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 631286535d0f..7eed6101c791 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -65,6 +65,12 @@ extern void groups_free(struct group_info *);
>  
>  extern int in_group_p(kgid_t);
>  extern int in_egroup_p(kgid_t);
> +extern int groups_search(const struct group_info *, kgid_t);
> +
> +extern int set_current_groups(struct group_info *);
> +extern void set_groups(struct cred *, struct group_info *);
> +extern bool may_setgroups(void);
> +extern void groups_sort(struct group_info *);
>  #else
>  static inline void groups_free(struct group_info *group_info)
>  {
> @@ -78,12 +84,11 @@ static inline int in_egroup_p(kgid_t grp)
>  {
>          return 1;
>  }
> +static inline int groups_search(const struct group_info *group_info, kgid_t grp)
> +{
> +	return 1;
> +}
>  #endif
> -extern int set_current_groups(struct group_info *);
> -extern void set_groups(struct cred *, struct group_info *);
> -extern int groups_search(const struct group_info *, kgid_t);
> -extern bool may_setgroups(void);
> -extern void groups_sort(struct group_info *);
>  
>  /*
>   * The security context of a task
> 


-- 
~Randy
