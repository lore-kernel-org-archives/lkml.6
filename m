Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79AFC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 03:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752BA2070B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 03:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tvpcKDdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBIDlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 22:41:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBIDlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 22:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QaE7Zu+8gweRAP8duRl/JZNe/5/26RIXjEsLTjotRlk=; b=tvpcKDdSHodP1uwtNjW6PwDSq
        iT/72/zCrS6XhPO8YYiSyfYjAPTzVK2K3HjxJ9PsPibqLrac3yErDHEnQ0lPIUShyOzxJvQyZpgzb
        8fIwvYGdQwIvysTg+KO/tkId3KxN39VCt0qZid86WjtqKDN3beAycRHtbbWT91tisgzA8KXUxaEMR
        U37L0Y9zcwv2tcu6BFxtRimkpoHBU/3YFJuNYZTh4fdrKb/0C6k1/9K8Rc2TEvmAKt0HsOUtNHY0T
        w20q9oCAcoY9Ja1k+ePY7DpgAlk1g0lmhQFabjbnzKeDXBVoowM1eYbEQZgqlVl55jDFXO/cOpGP9
        wSiARRvWA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gsJW1-00046C-CA; Sat, 09 Feb 2019 03:41:17 +0000
Date:   Fri, 8 Feb 2019 19:41:17 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch V2 1/2] genriq: Avoid summation loops for /proc/stat
Message-ID: <20190209034117.GC21860@bombadil.infradead.org>
References: <20190208134802.218483159@linutronix.de>
 <20190208135020.925487496@linutronix.de>
 <20190208143255.9dec696b15f03bf00f4c60c2@linux-foundation.org>
 <c40b7b94-00e3-9b59-fd66-904b54fc69b4@redhat.com>
 <20190208152151.ed4cf0c52e5970fc7a7911f1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208152151.ed4cf0c52e5970fc7a7911f1@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 03:21:51PM -0800, Andrew Morton wrote:
> It sounds like it.  A 10khz interrupt will overflow in 4 days...

If you've got a 10kHz interrupt, you have a bigger problem.  Anything
happening 10,000 times a second is going to need interrupt mitigation
to perform acceptably.

More importantly, userspace can (and must) cope with wrapping.  This isn't
anything new from Thomas' patch.  As long as userspace is polling more
often than once a day, it's going to see a wrapped value before it wraps
again, so it won't miss 4 billion interrupts.
