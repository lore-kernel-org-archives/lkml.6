Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA0EC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 12:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531E7217C7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 12:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OIMgS20c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531E7217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeHEOyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 10:54:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeHEOyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 10:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TAq9xifJoa7eMv4El7o7rDnPwhNB1LnwshRzNjleeCw=; b=OIMgS20c7JIsavvgQTnuppHCN
        pnLUr/A16KcabcqKwRmZXUkqN1NCp6b5qi6OvCw8msmhsojzB277q52Xxjp5sC25aG/mzx8SYbJ/P
        rU8hLdT5fC1/rjHlvJudi7XqmQJVU4owzx93AnrxoS4fSUsEG+Dt7l7IDvgIunxhTLicCkMYoVSM+
        yN2MGd9mdf8Rbz5YaFZCA0H2nIjqHlHks9bH/e6X/nIQJrRCrVo6w1pr0iIOJmSOEwYhQwHC39foY
        22cW/8ennzpz7cr9J4wdMpwHXUu3F1VPi/7INe+KI7exWStyDFTrTmMeIZ2Ay8x1m1wYFebTJ30/b
        eX9b7btIw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmIU0-0001N3-77; Sun, 05 Aug 2018 12:50:04 +0000
Date:   Sun, 5 Aug 2018 05:50:04 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vdavydov.dev@gmail.com,
        mhocko@suse.com, aryabinin@virtuozzo.com, ying.huang@intel.com,
        penguin-kernel@I-love.SAKURA.ne.jp, shakeelb@google.com,
        jbacik@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Use special value SHRINKER_REGISTERING instead
 list_empty() check
Message-ID: <20180805125004.GD3183@bombadil.infradead.org>
References: <153331055842.22632.9290331685041037871.stgit@localhost.localdomain>
 <20180803155120.0d65511b46c100565b4f8a2c@linux-foundation.org>
 <843169c5-a47a-e6cd-7412-611e72eb20ba@virtuozzo.com>
 <20180805000305.GC3183@bombadil.infradead.org>
 <e5d67774-a006-e533-d928-64a4407cbb16@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d67774-a006-e533-d928-64a4407cbb16@virtuozzo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 08:30:43AM +0300, Kirill Tkhai wrote:
> On 05.08.2018 03:03, Matthew Wilcox wrote:
> > On Sat, Aug 04, 2018 at 09:42:05PM +0300, Kirill Tkhai wrote:
> >> This is exactly the thing the patch makes. Instead of inserting a shrinker pointer
> >> to idr, it inserts a fake value SHRINKER_REGISTERING there. The patch makes impossible
> >> to dereference a shrinker unless it's completely registered. 
> > 
> > -       id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
> > +       id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> > 
> > Instead:
> > 
> > +       id = idr_alloc(&shrinker_idr, NULL, 0, 0, GFP_KERNEL);
> > 
> > ... and the rest of your patch becomes even simpler.
> 
> The patch, we are discussing at the moment, does *exactly* this:
> 
> https://lkml.org/lkml/2018/8/3/588
> 
> It looks like you missed this hunk in the patch.

No, it does this:

+       id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);

I'm saying do this:

+       id = idr_alloc(&shrinker_idr, NULL, 0, 0, GFP_KERNEL);
