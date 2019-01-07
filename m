Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EA5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43292087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfAGXJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:09:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGXJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:09:06 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 46B6A5AA;
        Mon,  7 Jan 2019 23:09:05 +0000 (UTC)
Date:   Mon, 7 Jan 2019 15:09:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove redundant test from find_get_pages_contig
Message-Id: <20190107150904.09e56f51acaf417ed21f13a3@linux-foundation.org>
In-Reply-To: <20190107223935.GC6310@bombadil.infradead.org>
References: <20190107200224.13260-1-willy@infradead.org>
        <20190107143319.c74593a70c86441b80e7cccc@linux-foundation.org>
        <20190107223935.GC6310@bombadil.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 14:39:35 -0800 Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Jan 07, 2019 at 02:33:19PM -0800, Andrew Morton wrote:
> > On Mon,  7 Jan 2019 12:02:24 -0800 Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > > After we establish a reference on the page, we check the pointer continues
> > > to be in the correct position in i_pages.  There's no need to check the
> > > page->mapping or page->index afterwards; if those can change after we've
> > > got the reference, they can change after we return the page to the caller.
> > 
> > But that isn't what the comment says.
> 
> Right.  That patch from Nick moved the check from before taking the
> ref to after taking the ref.  It was racy to have it before.  But it's
> unnecessary to have it afterwards -- pages can't move once there's a
> ref on them.  Or if they can move, they can move after the ref is taken.

So Nick's patch was never necessary?  I wonder what inspired it.

Would it be excessively cautious to put a WARN_ON_ONCE() in there for a
while?
