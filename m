Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C992C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8DB205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WDUnVbJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8DB205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932747AbeGCP2G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:28:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752745AbeGCP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GQ5rpmU5DQJ3Wke4Z+vF7+q6DpMwRy53GSjNlqz+6Dc=; b=WDUnVbJVUxAGaLNUuf18lfFqy
        SzcUbiWOsZtVYzwScEhaU2oo4l7cuMjfTuC2L55/aKmgBBVsjYfLIui7SVSpDFqhw8DhB/mC1Y2NF
        H01Z8qiwToUi2G8ExGG9E8726kLP0WyHRIDZ8t75WNMIH908t316Vr4vZfkjkDLnrMMfIM7tj1Xr0
        LRvaIoSzr40YbaXHhG8cDXJW/vAI6FLAp8nyNJkj4dOV6Te+l0XbZ4O4LtOYPPfvjtlfojTAUhTQ2
        8cjQI5oA6OeS4gd0hn+gKgiclb9NplSvxXz5enbl0XJj73+sWD3d7iXhVSOJrW3lNygB6JTgggxC7
        XF8+09S3g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faND9-0000vb-SG; Tue, 03 Jul 2018 15:27:23 +0000
Date:   Tue, 3 Jul 2018 08:27:23 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lirongqing@baidu.com, aryabinin@virtuozzo.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v8 03/17] mm: Assign id to every memcg-aware shrinker
Message-ID: <20180703152723.GB21590@bombadil.infradead.org>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 06:09:05PM +0300, Kirill Tkhai wrote:
> +++ b/mm/vmscan.c
> @@ -169,6 +169,49 @@ unsigned long vm_total_pages;
>  static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +static DEFINE_IDR(shrinker_idr);
> +static int shrinker_nr_max;

So ... we've now got a list_head (shrinker_list) which contains all of
the shrinkers, plus a shrinker_idr which contains the memcg-aware shrinkers?

Why not replace the shrinker_list with the shrinker_idr?  It's only used
twice in vmscan.c:

void register_shrinker_prepared(struct shrinker *shrinker)
{
        down_write(&shrinker_rwsem);
        list_add_tail(&shrinker->list, &shrinker_list);
        up_write(&shrinker_rwsem);
}

        list_for_each_entry(shrinker, &shrinker_list, list) {
...

The first is simply idr_alloc() and the second is

	idr_for_each_entry(&shrinker_idr, shrinker, id) {

I understand there's a difference between allocating the shrinker's ID and
adding it to the list.  You can do this by calling idr_alloc with NULL
as the pointer, and then using idr_replace() when you want to add the
shrinker to the list.  idr_for_each_entry() skips over NULL entries.

This will actually reduce the size of each shrinker and be more
cache-efficient when calling the shrinkers.  I think we can also get
rid of the shrinker_rwsem eventually, but let's leave it for now.
