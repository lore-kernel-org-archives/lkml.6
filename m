Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6055EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2395C2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2395C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeGREDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:03:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725721AbeGREDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:03:38 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EAD6241C;
        Wed, 18 Jul 2018 03:27:54 +0000 (UTC)
Date:   Tue, 17 Jul 2018 20:27:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/7] proc/kcore: replace kclist_lock rwlock with
 rwsem
Message-Id: <20180717202753.d49795afde465d04b56efbfb@linux-foundation.org>
In-Reply-To: <20180718032405.GB29351@vader>
References: <cover.1531440458.git.osandov@fb.com>
        <783ba3becc424db45e5d5c93559fc40ef6173f01.1531440458.git.osandov@fb.com>
        <20180717193841.271d1c57b6f88d75c83892be@linux-foundation.org>
        <20180718032405.GB29351@vader>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 20:24:05 -0700 Omar Sandoval <osandov@osandov.com> wrote:

> > > --- a/fs/proc/kcore.c
> > > +++ b/fs/proc/kcore.c
> > > @@ -59,8 +59,8 @@ struct memelfnote
> > >  };
> > >  
> > >  static LIST_HEAD(kclist_head);
> > > -static DEFINE_RWLOCK(kclist_lock);
> > > -static int kcore_need_update = 1;
> > > +static DECLARE_RWSEM(kclist_lock);
> > > +static atomic_t kcore_need_update = ATOMIC_INIT(1);
> > 
> > It's unclear why kcore_need_update was changed to atomic_t - it's still
> > updated under kclist_lock?
> 
> Not in the hotplug notifier (kcore_callback()) anymore, so I need the
> atomic_cmpxchg() in __kcore_update_ram().

Well that's just

	kcore_need_update = 1;

and turning that into an atomic_set doesn't change anything(?).

It's not a harmful change of course, but a bit ... odd.

> That could use a mention in the commit message.

That never hurts ;)
