Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C45BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1591420850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="r4cOdXHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfAHNTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:19:11 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37563 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfAHNTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:19:10 -0500
Received: by mail-qk1-f193.google.com with SMTP id g125so2263027qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 05:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i/LKjvpf6BLPa3asEup3mQ52HQP7Vz8QBeRkG2BpFpY=;
        b=r4cOdXHt3tF6VI2mRaC96JXzm+LW8Fyq4fm3nTPZRAFSTkA9ZoEMe2CJpG2Uq0B6Xw
         f1xtgC31km0Tv3UF9Mc+rhfMUMr8vj0IHfjbMClWJEqSSorQCCh4r1KIeK6Xd+55BYaT
         Ory/Gf/0Odpx+McUNZuLbZqhS8OisH2IZ19r50IsOn9QHnrWC6sIohX3kSbFxH3jVG8l
         YW4rUohSU+k4fm6y2TZAIEX33WqdpqGITfyox3Ii/j6ScK1EOAad1r4u0QoyESH/nlsG
         XUorc19KwV8b+h5cHUlkv8lmFyWyvEsdm7c5JZnIy4o9AltMHsVgKcatea3rmCMe5UiK
         KBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/LKjvpf6BLPa3asEup3mQ52HQP7Vz8QBeRkG2BpFpY=;
        b=qZOSHhMEkRb6x5BV13IPWnI3aautcbBkTpszhjGaSJzEjRcmfDR3u5pGVvG3Ez9dNT
         sb77pGPnCqxqoL71sg2Q0IKHEM34ocOdaf7mlpKQs4AkA4QQuB4UCTzgSexdeOz1bBCm
         g68FAez7zwqn8rqSOaQDrQHnlVRIJtjy/lttdYXHX3xMrHdYQNAHyNgqIxXeo+x2iZzX
         VFh4eHjyy+xualNIULvESeEWqjOiv1JTS03amrOGVtF9crZEm9J1L2+eneJIMNy+RcUZ
         DD6F7cOCoTf4yoFqTjt3lV64ju4R0sarCD8HGDgCkEh/uXwIr0t9FEWQQqrBpNVARCix
         4QTg==
X-Gm-Message-State: AJcUukcYmaPEAcW67yeGC5WvzZ1Fzf73WYjf6aj+8UKBeDishR3af7eT
        BlyoJxWMlhGqdm9XySNYnsHJ+w==
X-Google-Smtp-Source: ALg8bN4EfDz/gH4Sx4+yauacZE3GN7ptChBDrlUda3BDiOk859i7j+25xadficCz1f6HR/IVwObZjQ==
X-Received: by 2002:a37:8b84:: with SMTP id n126mr1385998qkd.355.1546953549358;
        Tue, 08 Jan 2019 05:19:09 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c17sm46343462qtb.14.2019.01.08.05.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 05:19:08 -0800 (PST)
Message-ID: <1546953547.6911.1.camel@lca.pw>
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Jan 2019 08:19:07 -0500
In-Reply-To: <20190108082032.GP31793@dhcp22.suse.cz>
References: <20190103202235.GE31793@dhcp22.suse.cz>
         <a5666d82-b7ad-4b90-5f4e-fd22afc3e1dc@lca.pw>
         <20190104130906.GO31793@dhcp22.suse.cz>
         <e4ad9d12-387d-1cc6-f404-cae6d43ccf80@lca.pw>
         <20190104151737.GT31793@dhcp22.suse.cz>
         <c8faf7eb-d23f-4ef7-3432-0acc7165f883@lca.pw>
         <20190104153245.GV31793@dhcp22.suse.cz>
         <fa135cd8-32e5-86f7-14ee-30685bca91b5@lca.pw>
         <20190107184309.GM31793@dhcp22.suse.cz>
         <bfcd017d-dcf4-b687-1aef-ab0810b12c73@lca.pw>
         <20190108082032.GP31793@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 09:20 +0100, Michal Hocko wrote:
> On Mon 07-01-19 20:53:08, Qian Cai wrote:
> > 
> > 
> > On 1/7/19 1:43 PM, Michal Hocko wrote:
> > > On Fri 04-01-19 15:18:08, Qian Cai wrote:
> > > [...]
> > > > Though, I can't see any really benefit of this approach apart from
> > > > "beautify"
> > > 
> > > This is not about beautifying! This is about making the code long term
> > > maintainable. As you can see it is just too easy to break it with the
> > > current scheme. And that is bad especially when the code is broken
> > > because of an optimization.
> > > 
> > 
> > Understood, but the code is now fixed. If there is something fundamentally
> > broken in the future, it may be a good time then to create a looks like
> > hundred-line cleanup patch for long-term maintenance at the same time to fix
> > real bugs.
> 
> Yeah, so revert = fix and redisign the thing to make the code more
> robust longterm + allow to catch more allocation. I really fail to see
> why this has to be repeated several times in this thread. Really.
> 

Again, this will introduce a immediately regression (arguably small) that
existing page_owner users with DEFERRED_STRUCT_PAGE_INIT deselected that would
start to miss tens of thousands early page allocation call sites.

I think the disagreement comes from that you want to deal with this passively
rather than proactively that you said "I am pretty sure we will hear about that
when that happens. And act accordingly", but I think it is better to fix it now
rather than later with a 4-line ifdef which you don't like.

I suppose someone else needs to make a judgment call for this as we are in a
"you can't convince me and I can't convince you" situation right now.
