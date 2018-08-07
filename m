Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548D2C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E87219CB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E87219CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbeHGJdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:33:37 -0400
Received: from verein.lst.de ([213.95.11.211]:59646 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbeHGJdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:33:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F0C6B68D62; Tue,  7 Aug 2018 09:25:55 +0200 (CEST)
Date:   Tue, 7 Aug 2018 09:25:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] aio: allow direct aio poll comletions for keyed
        wakeups
Message-ID: <20180807072555.GA678@lst.de>
References: <20180806083058.14724-1-hch@lst.de> <20180806083058.14724-5-hch@lst.de> <20180806152705.37809e16c02543cc24626607@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806152705.37809e16c02543cc24626607@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 03:27:05PM -0700, Andrew Morton wrote:
> On Mon,  6 Aug 2018 10:30:58 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
> > If we get a keyed wakeup for a aio poll waitqueue and wake can acquire the
> > ctx_lock without spinning we can just complete the iocb straight from the
> > wakeup callback to avoid a context switch.
> 
> Why do we try to avoid spinning on the lock?

Because we are called with the lock on the waitqueue called, which
nests inside it.

> > +		/* try to complete the iocb inline if we can: */
> 
> ie, this comment explains 'what" but not "why".
> 
> (There's a typo in Subject:, btw)

Because it is faster obviously.  I can update the comment.
