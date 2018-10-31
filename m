Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99663C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583E820657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FbB1Bj4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583E820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeKAERy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:17:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKAERy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YT1CPto2P7xaR5NIYHiAT6+LdF03KA0o7+l66u7gHmA=; b=FbB1Bj4z7iJu/0EVFkXApXLpx
        UuM49MCjnpIpRdoKlPS9+g/hLEEeDR3bQ0Rq897YCu1g9ll2bFSXF979TJ1H0YWieqeXz6HGr8IPk
        zIR6j7Ear4kvR209ysKDG02DL2rOLHUaidWikUH/05w0r01l0veGZ2BHaeaYnmZwWI84+gz92VIgS
        Ncy15WM5BDKoKZghKZZR1lX5OKxSd/0HzoXfTWkLtgnX9wUEVFA698s037K9UuWr/jcagkRe1jvNU
        dCJ+yWWNbqUkTeTL2FALi8wywLLEYabJlnqzzqqGV6V4tYI29tneMWhMaH6yGCqZS5BufRyResRZC
        50XovTeOg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHw0Z-0004S9-Hn; Wed, 31 Oct 2018 19:18:27 +0000
Date:   Wed, 31 Oct 2018 12:18:27 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+4fd0c066d82852499145@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        zwisler@kernel.org
Subject: Re: WARNING in get_unlocked_entry
Message-ID: <20181031191827.GN10491@bombadil.infradead.org>
References: <000000000000c9000f05797370e4@google.com>
 <20181031031842.GI10491@bombadil.infradead.org>
 <CACT4Y+YAUKABCr3T6ryPSR_wygCQ5ab=o-Ouv+D9zwdffFfiMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YAUKABCr3T6ryPSR_wygCQ5ab=o-Ouv+D9zwdffFfiMA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:46:19AM +0100, Dmitry Vyukov wrote:
> On Wed, Oct 31, 2018 at 4:18 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > On Tue, Oct 30, 2018 at 08:00:03AM -0700, syzbot wrote:
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    4b42745211af Merge tag 'armsoc-soc' of git://git.kernel.or..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1187d06d400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=93932074d01b4a5
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=4fd0c066d82852499145
> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >>
> >> Unfortunately, I don't have any reproducer for this crash yet.
> >
> > Hmmpf.  Would have been nice if syzbot had caught this during its tests
> > of the -next tree ...
> 
> What -next tree do you mean? If it satisfies the criteria we can add it:
> https://github.com/google/syzkaller/issues/592

I meant linux-next, as in the merge of everybody's -next trees.  Reading
that bug, it seems outside your scope for now ;-(

