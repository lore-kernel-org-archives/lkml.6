Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E132FC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF5E21885
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF5E21885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389091AbeHGSTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:19:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeHGSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:19:41 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61D35BC6;
        Tue,  7 Aug 2018 16:04:42 +0000 (UTC)
Date:   Tue, 7 Aug 2018 09:04:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] aio: allow direct aio poll comletions for keyed
 wakeups
Message-Id: <20180807090441.67f7e281f502ce448de849c1@linux-foundation.org>
In-Reply-To: <20180807072555.GA678@lst.de>
References: <20180806083058.14724-1-hch@lst.de>
        <20180806083058.14724-5-hch@lst.de>
        <20180806152705.37809e16c02543cc24626607@linux-foundation.org>
        <20180807072555.GA678@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2018 09:25:55 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Aug 06, 2018 at 03:27:05PM -0700, Andrew Morton wrote:
> > On Mon,  6 Aug 2018 10:30:58 +0200 Christoph Hellwig <hch@lst.de> wrote:
> > 
> > > If we get a keyed wakeup for a aio poll waitqueue and wake can acquire the
> > > ctx_lock without spinning we can just complete the iocb straight from the
> > > wakeup callback to avoid a context switch.
> > 
> > Why do we try to avoid spinning on the lock?
> 
> Because we are called with the lock on the waitqueue called, which
> nests inside it.

Ah.

> > > +		/* try to complete the iocb inline if we can: */
> > 
> > ie, this comment explains 'what" but not "why".
> > 
> > (There's a typo in Subject:, btw)
> 
> Because it is faster obviously.  I can update the comment.

I meant the comment could explain why it's a trylock instead of a
spin_lock().
