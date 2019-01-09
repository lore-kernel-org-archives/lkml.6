Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0656FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C737C214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FTTWKA3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfAISYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:24:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAISYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hl/E6OTbfUDCWrNXtNrojAg8mlkKgNjYPdSbJh0+gIo=; b=FTTWKA3bMyxzdygMiOVXhisnS
        SkPefX3UrEzfC1qjoSCawywq9vIE1LFOLCXXw4bXGKMtqdqI7vX/TAZh7g9us9xlXpZMLRK1tjRfD
        v0lKqwtYVNLNxJaQhSUUhG41orxQ9T8dyJerTSUCVjxrrEoQezVbkY1va5eEeC+EhRIci1/TavSrk
        vwS8TOTULqeK1mNqjWjWiNTpw6z1hcMuJKkgceBJ1HhCIwpbm3rejn7ezN6BNN7AAm0KOLhfh7DP6
        Mkd64hMoEUotAj6KhMEyDYXbiuV9Cyc0XA7XYfkk3ar/VUAlkcZLWMu2+BxvXzt0ebQ/xbX29kLVT
        hgE+SDKSA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghIWY-0006H6-4x; Wed, 09 Jan 2019 18:24:18 +0000
Date:   Wed, 9 Jan 2019 10:24:17 -0800
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
Message-ID: <20190109182417.GO6310@bombadil.infradead.org>
References: <1547054628-12703-1-git-send-email-longman@redhat.com>
 <20190109174403.GN6310@bombadil.infradead.org>
 <f6302369-9eda-ef58-4f18-3dc9ffbc31f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6302369-9eda-ef58-4f18-3dc9ffbc31f1@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:03:33PM -0500, Waiman Long wrote:
> The paragraph above may be a bit misleading. This v2 patch actually
> touches very little on percpu accounting aspect of the IRQ counts. See
> patches 2 and 3 for the relevant changes which is just a few line of new
> codes. Please review the individual patches before Nak'ing.
> 
> I could theoretically generalize them into a new set of percpu counting
> helpers, but the idea behind it is quite different from the use cases of
> percpu counter. So it may not be a good idea of adding it to there.

Did you even try just using the general purpose infrastructure that's
in place?  If that shows a performance problem _then_ it's time to make
this special snowflake just a little more special.  Not before.
