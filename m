Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307D4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0921120833
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfACD2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:28:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:47082 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfACD2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:28:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x033RuaP009503;
        Wed, 2 Jan 2019 21:28:01 -0600
Message-ID: <fd0a4a0da544908204d8558895d469c6d87b6743.camel@kernel.crashing.org>
Subject: Re: [PATCH] fsi:fsi-sbefifo: Fix possible concurrency
 use-after-free bugs in sbefifo_user_release
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     David Howells <dhowells@redhat.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     joel@jms.id.au, eajames@linux.vnet.ibm.com, andrew@aj.id.au,
        linux-kernel@vger.kernel.org
Date:   Thu, 03 Jan 2019 14:27:56 +1100
In-Reply-To: <26864.1546421693@warthog.procyon.org.uk>
References: <20181226135618.12784-1-baijiaju1990@gmail.com>
         <26864.1546421693@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-02 at 09:34 +0000, David Howells wrote:
> Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> 
> > +	mutex_lock(&user->file_lock);
> >  	sbefifo_release_command(user);
> >  	free_page((unsigned long)user->cmd_page);
> > +	mutex_unlock(&user->file_lock);
> 
> It shouldn't be necessary to do the free_page() call inside the locked
> section.

True. However, I didn't realize read/write could be concurrent with
release so we have another problem.

I assume when release is called, no new read/write can be issued, I am
correct ? So all we have to protect against is a read/write that has
started prior to release being called, right ?

In that case, what can happen is that release() wins the race on the
mutex, frees everything, then read or write starts using feed stuff.

This is nasty to fix because the mutex is in the user structure,
so even looking at the mutex is racy if release is called.

The right fix, would be, I think, for "user" (pointed to by file-
>private_data) to be protected by a kref. That doesn't close it
completely as the free in release() can still lead to the structure
becoming re-used before read/write tries to get the kref but after it
has NULL checked the private data.

So to make that solid, I would also RCU-defer the actual freeing and
use RCU around dereferencing file->private_data

Now, I yet have to see other chardevs do any of the above, do that mean
they are all hopelessly racy ?

Cheers,
Ben.

