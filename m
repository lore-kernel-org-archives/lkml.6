Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D17C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F25020870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F25020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbeG3XUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:20:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54304 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbeG3XUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:20:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fkFwf-0007ko-Fw; Mon, 30 Jul 2018 21:43:13 +0000
Date:   Mon, 30 Jul 2018 22:43:13 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        rlove@google.com, ben@decadent.org.uk
Subject: Re: [PATCH 1/4] file: export __alloc_fd()
Message-ID: <20180730214313.GF30522@ZenIV.linux.org.uk>
References: <20180730143710.14413-1-christian@brauner.io>
 <20180730143710.14413-2-christian@brauner.io>
 <20180730163155.GA27761@infradead.org>
 <20180730203633.GC12962@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730203633.GC12962@bombadil.infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 01:36:33PM -0700, Matthew Wilcox wrote:
> On Mon, Jul 30, 2018 at 09:31:55AM -0700, Christoph Hellwig wrote:
> > On Mon, Jul 30, 2018 at 04:37:07PM +0200, Christian Brauner wrote:
> > > The Android binder driver will be turned into a module. Since it uses
> > > __alloc_fd() we need to export this function.
> > 
> > Err, hell no.
> > 
> > It should be using an anon fd probably.
> 
> I'm not entirely sure I understand the binder code (... does anyone?)
> but from what I can see, it intends to open a file descriptor in the
> process which is the target of the message being sent.  That strikes
> me as wrong-headed; it should be allocating a struct file and passing
> that file to the other process.  When that process receives the message,
> *it* allocates a file descriptor for itself.
> 
> But I think the binder user-space API relies on this.  The userspace API
> seems to rely on passing fd numbers around ... but I'm having trouble
> figuring most of this user API out.  Perhaps Martijn can help here.

... and there's a perfectly sane solution to that - it's called git rm.
