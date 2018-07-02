Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B24C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A61F22C99
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="sOh2uIsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A61F22C99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932518AbeGBWep (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:34:45 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42136 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932169AbeGBWen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:34:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6BB718EE212;
        Mon,  2 Jul 2018 15:34:42 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YTk494eEY-d8; Mon,  2 Jul 2018 15:34:42 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9CBE88EE01C;
        Mon,  2 Jul 2018 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1530570882;
        bh=feAuKWkmWjasJ6F/B0/Dyjz4Vu4nNzQzGl24sjNWStE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sOh2uIsCuYXait7i4tMrUl0ktwgC0SndZN++P/QaFSrv+lp54ZNaCkP4IJeoctfTa
         GDp08qcFZ/pQbrLNDdOYtfUlai3gTLMqsSskKR5b2+y6cH3+jOPJ/EDRsE2n3QsrBI
         j/2HJqOM4IR3ziJOTnddaLoDTBP/juUsSYPV8960=
Message-ID: <1530570880.3179.9.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>
Date:   Mon, 02 Jul 2018 15:34:40 -0700
In-Reply-To: <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
         <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
         <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 14:18 -0700, Andrew Morton wrote:
> On Mon, 2 Jul 2018 12:34:00 -0700 Linus Torvalds <torvalds@linux-foun
> dation.org> wrote:
> 
> > On Sun, Jul 1, 2018 at 10:52 PM Waiman Long <longman@redhat.com>
> > wrote:
> > > 
> > > A rogue application can potentially create a large number of
> > > negative
> > > dentries in the system consuming most of the memory available if
> > > it
> > > is not under the direct control of a memory controller that
> > > enforce
> > > kernel memory limit.
> > 
> > I certainly don't mind the patch series, but I would like it to be
> > accompanied with some actual example numbers, just to make it all a
> > bit more concrete.
> > 
> > Maybe even performance numbers showing "look, I've filled the
> > dentry
> > lists with nasty negative dentries, now it's all slower because we
> > walk those less interesting entries".
> > 
> 
> (Please cc linux-mm@kvack.org on this work)
> 
> Yup.  The description of the user-visible impact of current behavior
> is far too vague.
> 
> In the [5/6] changelog it is mentioned that a large number of -ve
> dentries can lead to oom-killings.  This sounds bad - -ve dentries
> should be trivially reclaimable and we shouldn't be oom-killing in
> such a situation.

If you're old enough, it's déjà vu; Andrea went on a negative dentry
rampage about 15 years ago:

https://lkml.org/lkml/2002/5/24/71

I think the summary of the thread is that it's not worth it because
dentries are a clean cache, so they're immediately shrinkable.

> Dumb question: do we know that negative dentries are actually
> worthwhile?  Has anyone checked in the past couple of
> decades?  Perhaps our lookups are so whizzy nowadays that we don't
> need them?

There are still a lot of applications that keep looking up non-existent 
files, so I think it's still beneficial to keep them.  Apparently
apache still looks for a .htaccess file in every directory it
traverses, for instance.  Round tripping every one of these to disk
instead of caching it as a negative dentry would seem to be a
performance loser here.

However, actually measuring this again might be useful.

James

