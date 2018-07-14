Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8A8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 18:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549372083D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 18:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549372083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbeGNSyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 14:54:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36248 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeGNSyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 14:54:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fePNV-0004C0-9E; Sat, 14 Jul 2018 18:34:45 +0000
Date:   Sat, 14 Jul 2018 19:34:45 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
Message-ID: <20180714183445.GJ30522@ZenIV.linux.org.uk>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
 <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
 <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
 <1530570880.3179.9.camel@HansenPartnership.com>
 <20180702161925.1c717283dd2bd4a221bc987c@linux-foundation.org>
 <20180703091821.oiywpdxd6rhtxl4p@quack2.suse.cz>
 <20180714173516.uumlhs4wgfgrlc32@devuan>
 <CA+55aFw1vrsTjJyoq4Q3jBwv1nXaTkkmSbHO6vozWZuTc7_6Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw1vrsTjJyoq4Q3jBwv1nXaTkkmSbHO6vozWZuTc7_6Kg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 11:00:32AM -0700, Linus Torvalds wrote:
> On Sat, Jul 14, 2018 at 10:35 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Could we allocate -ve entries from separate slab?
> 
> No, because negative dentrires don't stay negative.
> 
> Every single positive dentry starts out as a negative dentry that is
> passed in to "lookup()" to maybe be made positive.
> 
> And most of the time they <i>do</i> turn positive, because most of the
> time people actually open files that exist.
> 
> But then occasionally you don't, because you're just blindly opening a
> filename whether it exists or not (to _check_ whether it's there).

BTW, one point that might not be realized by everyone: negative dentries
are *not* the hard case.
mount -t tmpfs none /mnt
touch /mnt/a
for i in `seq 100000`; do ln /mnt/a /mnt/$i; done

and you've got 100000 *unevictable* dentries, with the time per iteration
being not all that high (especially if you just call link(2) in a loop).
They are all positive and all pinned.  And you've got only one inode
there and no persistently opened files, so rlimit and quota won't help
any.
