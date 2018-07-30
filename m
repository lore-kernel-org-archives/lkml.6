Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDA0C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D323620870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D323620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbeG3XSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:18:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54256 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeG3XSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:18:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fkFuf-0007hp-5j; Mon, 30 Jul 2018 21:41:09 +0000
Date:   Mon, 30 Jul 2018 22:41:09 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        rlove@google.com, ben@decadent.org.uk
Subject: Re: [RFC PATCH 0/4] file: export functions for binder module
Message-ID: <20180730214108.GE30522@ZenIV.linux.org.uk>
References: <20180730143710.14413-1-christian@brauner.io>
 <20180730163452.GE27761@infradead.org>
 <20180730201224.GA1081@mailbox.org>
 <20180730201947.GB12962@bombadil.infradead.org>
 <20180730202840.GA14693@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730202840.GA14693@mailbox.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:28:40PM +0200, Christian Brauner wrote:
> On Mon, Jul 30, 2018 at 01:19:47PM -0700, Matthew Wilcox wrote:
> > On Mon, Jul 30, 2018 at 10:12:24PM +0200, Christian Brauner wrote:
> > > > I don't expect this patch to be mergeable but rather to kick-off a
> > > > discussion if we can either simply export them as they are or how we can
> > > > get supportable exports that allow access to struct files_struct.
> > > 
> > > Maybe that wasn't obvious from the first message. Is there any way we
> > > can come up with a way to have versions of these functions that you
> > > would be fine with exporting?
> > > The point is that otherwise we would have to either duplicate the code
> > > or come up with something way more complex. If you have any pointer that
> > > would already help.
> > 
> > He said in the first reply this should probably be using an anonfd.
> > If you do that, I think all four of these exports go away.
> 
> I try and see if that is possible.
> 
> > 
> > And there was really no reason to post each of the four exports as
> > separate patches.  That just makes review harder on everyone.
> 
> Sorry about that. It usually depends on the preferences of each
> maintainer how fine-grained such minor changes should be.

The fundamental problem here (besides "who the hell thought that this Fine Piece
Of Software belongs anywhere other than in /dev/null?") is that messing with
other's descriptor table is Fucking Wrong(tm).  It's not going to become
a general-purpose interface.  That kludge is just that - a kludge caused by
atrocious API design.

Exports NAKed, and if brought again they'll get NAKed with extreme prejudice
(sensu PTerry).
