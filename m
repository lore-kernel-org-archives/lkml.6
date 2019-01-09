Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC526C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9999A20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AN3mZJFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfAISw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:52:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfAISw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U2tJOKmfBfUUwyh8MJKfpx+dnOTnMFtidJcdpk03Bxo=; b=AN3mZJFLUXP+w9IHfF9qJ7PVv
        sW1t6n68/86Y80b/wyfDLVpC7z4+F8Le7rElrKuUfEtDC4EpJZjNt0wbgo62XGDEoFMeeZtESkkhp
        Ly4MzYmaJA1O5y6HL4eJBDsKQsdqf3vfEBeG4st8ADg/AxRvmS+9MxLMtZMrv/MzPtRLJnqon62j+
        Uz/jadhf5+k6SdsC1bqIVt5sSHxCi8BVfBpH8nrWoc1kY40nPQTaohrlio2uZ//Lx6Q3aPVEGhD7B
        akm/yzVdeIhsp9PfELxWM6vkIU0YZq5ZKrYCP1R8i7gQi4dQAo6E3Yn2l1tqugB+HBXxumgktsB3I
        kQg4kpMYQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghIxm-0003Vg-Ma; Wed, 09 Jan 2019 18:52:26 +0000
Date:   Wed, 9 Jan 2019 10:52:26 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 0/4] /proc/stat: Reduce irqs counting performance
 overhead
Message-ID: <20190109185226.GP6310@bombadil.infradead.org>
References: <1547054628-12703-1-git-send-email-longman@redhat.com>
 <20190109174403.GN6310@bombadil.infradead.org>
 <f6302369-9eda-ef58-4f18-3dc9ffbc31f1@redhat.com>
 <20190109182417.GO6310@bombadil.infradead.org>
 <f0ae7bd8-5c5b-aefd-aff8-2719fc0edbaa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0ae7bd8-5c5b-aefd-aff8-2719fc0edbaa@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:37:23PM -0500, Waiman Long wrote:
> On 01/09/2019 01:24 PM, Matthew Wilcox wrote:
> > Did you even try just using the general purpose infrastructure that's
> > in place?  If that shows a performance problem _then_ it's time to make
> > this special snowflake just a little more special.  Not before.
> 
> I have looked into the percpu counter code. There are two aspects that I
> don't like to introduce to the interrupt handler's code path for
> updating the counts.
> 
> 1) There is a raw spinlock in the percpu_counter structure that may need
> to be acquired in the update path. This can be a performance drag
> especially if lockdep is enabled.
> 
> 2) The percpu_counter structure is 40 bytes in size on 64-bit systems
> compared with just 8 bytes for the percpu count pointer and an
> additional 4 bytes that I introduced in patch 2. With thousands of irq
> descriptors, it can consume quite a lot more memory. Memory consumption
> was a point that you brought up in one of your previous mails.

Then _argue that_.  Don't just go off and do something random without
explaining to the rest of us why we're wrong.
