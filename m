Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31199C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E542173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RKlU/Fhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfAGQOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:14:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfAGQOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WC31PgMEZ4MAdDOy6MoXPli4cSxroS4xvF6ajnQwaXM=; b=RKlU/FhxnhsCP/eZSxAlD843D
        KYluvbucN08DMuW6x5s/LQC6J8+TW6CQqQQSn6ETab6a4Ce86f0Q21R39mHnbvZCAVm/Hfqm4l2uh
        ZUHwsr4dW9jY+ackdroVWgcoe2rw3WrWEBGsN6hfyiln/GB0wqQgbEc1SoRApWVihJ/no4K/TNiCQ
        y/rfsRXV2e0K9P4FNUyUU5fRaVDlG/qUlU/A4s+e36RLjOhX673lFMRuLib3/idDBfs7P2oGbBjGU
        nCFQI0CDsdJ29PAt4UnTV2dXjy/M3d2qbfRNjfSzNnCkX2zBW4nnCyIUuOypPYI/wRwrRZSg6QbxS
        eRM5dZE8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggXY2-0005X5-RB; Mon, 07 Jan 2019 16:14:42 +0000
Date:   Mon, 7 Jan 2019 08:14:42 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/2] /proc/stat: Add sysctl parameter to control irq
 counts latency
Message-ID: <20190107161442.GZ6310@bombadil.infradead.org>
References: <1546873978-27797-1-git-send-email-longman@redhat.com>
 <1546873978-27797-3-git-send-email-longman@redhat.com>
 <20190107155840.GY6310@bombadil.infradead.org>
 <c2ef7231-fe1f-9463-0b06-e88f990aa865@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2ef7231-fe1f-9463-0b06-e88f990aa865@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:07:47AM -0500, Waiman Long wrote:
> > Why are you caching the _output_ of calling sprintf(), rather than caching the
> > values of each interrupt?
> >
> It is just faster to dump the whole string buffer than redoing the
> number formatting each time when the values don't change. I can cache
> the individual sums instead if it is the preferred by most.

But it also consumes more memory.  Can you gather some measurements to
find out what the performance difference is if you cache the values
instead of the strings?
