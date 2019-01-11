Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30236C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DB720836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kwoesHTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbfAKNBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:01:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732534AbfAKNBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9iEdlVG4OtwVuTok1VoQsjsAtASdR3We9Xg3fpJ5lTQ=; b=kwoesHTw2J21ha69Hpuu2cYBW
        +ML10BARBhg3aEYlZb1nSox79H4W+gEvgb2Fe2d5I+3ho70AeO/OLXAdPq6W68CV286CqKbwjAFsL
        VrlijQ0S8co6j65+Z+KKikBQeKG8N/Bz6MeZcBNbDRJy7GyBy0XGDqsOBPAzps7qdByK0U8kvW+K4
        Gub5bhDhwcKgBXLMds5qSEZ/gxUKOG9EcHvbdYv/DoHwHMe/GcrhMoF69jDTsMKPH2SxIm7Iw3mnK
        /Xx8nebD6TVgh5xJvrJ0K/71ochETXJ5Net2T1hFtJBAkMdhXEFEsIcj8Jnon14nNL+1aSGQF0d5j
        7/r6KthpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghwRJ-0001fN-8m; Fri, 11 Jan 2019 13:01:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF3F8202A6058; Fri, 11 Jan 2019 14:01:30 +0100 (CET)
Date:   Fri, 11 Jan 2019 14:01:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, cai@gmx.us,
        daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
        longman@redhat.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        mingo@kernel.org, tglx@linutronix.de, dietmar.eggemann@arm.com
Subject: Re: [PATCH 0/2] System-wide mute of hotplug lockdep during init
Message-ID: <20190111130130.GA12917@hirez.programming.kicks-ass.net>
References: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
 <0f2b6cc8-ad2f-bd0b-fe51-c333a8033452@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f2b6cc8-ad2f-bd0b-fe51-c333a8033452@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 09:53:58AM +0000, Valentin Schneider wrote:
> Hi,
> 
> On 19/12/2018 18:23, Valentin Schneider wrote:
> > In [1] Peter had a suggestion to broadly mute hotplug lockdep warnings during
> > init instead of going after every single warning and wrapping them with
> > cpus_read_{lock, unlock}(). This is implemented in [PATCH 1/2].
> > 
> > [PATCH 2/2] is a logical follow-up as [PATCH 1/2] is the generalized version
> > of the reverted patch.
> > 
> > [1]: https://lore.kernel.org/lkml/1543877121-4098-1-git-send-email-cai@gmx.us/#t
> > 
> 
> Gentle ping - I suppose this flew under the holidays radar.

Indeed so... got them now. Thanks!
