Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB22C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 01:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9825C219D2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 01:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z8wXhcKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9825C219D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeHRE2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 00:28:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeHRE2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 00:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s9lr5/rBgfnFNqAAxR0xbQmN+jsipj97rBqkDfrabn4=; b=Z8wXhcKJoJ9YyjTOQsDC63Rn1
        ik8aLgUyOR078ZkAkXiviZZtN+cZ9veJ0UKgw85OviJlSHhgpFfAqE7vOrgqW6vMNA0INOLgfgICs
        CCUB+G5jJXhhCfcdK3R8QS21TXjN6hqQ9srUxsa28d+WHeJjTB5E5a3DD6bRS2OWkglPoF2pK8X+N
        yDyud04Ua2KQWw34e40BCsRiBhpFwRwKxbUQgJpb0TgycNpM/tZbM9Q3CAU8GwrnWexJwA6ae5yVJ
        B3KHTrcZE6Zv28O6ADr/ZrQZhSqg+j2ZcmqAKiwmNbOfE5kectokJlGlgmj61XO1Adexoy0D+70ZR
        J/W+7IB2Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fqpwU-0005xi-3d; Sat, 18 Aug 2018 01:22:14 +0000
Date:   Fri, 17 Aug 2018 18:22:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [PATCH RFC] mm: don't miss the last page because of round-off
 error
Message-ID: <20180818012213.GA14115@bombadil.infradead.org>
References: <20180817231834.15959-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817231834.15959-1-guro@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 04:18:34PM -0700, Roman Gushchin wrote:
> -			scan = div64_u64(scan * fraction[file],
> -					 denominator);
> +			if (scan > 1)
> +				scan = div64_u64(scan * fraction[file],
> +						 denominator);

Wouldn't we be better off doing a div_round_up?  ie:

	scan = div64_u64(scan * fraction[file] + denominator - 1, denominator);

although i'd rather hide that in a new macro in math64.h than opencode it
here.
