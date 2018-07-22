Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB62C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28D020875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28D020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeGVOq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 10:46:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49838 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbeGVOq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 10:46:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fhEkI-0005XB-Ks; Sun, 22 Jul 2018 13:49:58 +0000
Date:   Sun, 22 Jul 2018 14:49:58 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Theuns Verwoerd <Theuns.Verwoerd@alliedtelesis.co.nz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/2] jffs2: Provide jffs2_sync files to track gc POLL
 progress
Message-ID: <20180722134958.GE30522@ZenIV.linux.org.uk>
References: <cover.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
 <f1c6c3cc0c8850e143594afd57b50d30cd8bb5f8.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
 <20180720000431.GA30522@ZenIV.linux.org.uk>
 <b2b2e3e0-14b7-9f46-434d-2134d1d0cfad@alliedtelesis.co.nz>
 <CAFLxGvyTmz8JQVn-OJFSVdns74o49XgdWbhGpPsqYe5S2uahYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvyTmz8JQVn-OJFSVdns74o49XgdWbhGpPsqYe5S2uahYg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 03:17:07PM +0200, Richard Weinberger wrote:

> On Fri, Jul 20, 2018 at 2:54 AM, Theuns Verwoerd
> <Theuns.Verwoerd@alliedtelesis.co.nz> wrote:
> >
> > On 07/20/2018 12:04 PM, Al Viro wrote:
> >> On Fri, Jul 20, 2018 at 11:50:12AM +1200, Theuns Verwoerd wrote:
> >>
> >>> +ssize_t jffs2_sync_file_read(struct file *f,
> >>> +          char __user *b, size_t len, loff_t *ofs)
> >>> +{
> >>> +    struct jffs2_sb_info *c = file_inode(f)->i_private;
> >>> +
> >>> +    while (c->tidemark)
> >>> +            schedule();
> >>> +
> >>> +    return 0;
> >>> +}
> >> Brilliant.  So when that gets called with c->tidemark being true and
> >> need_resched() - false, we shall...
> > By my reading, schedule() will happily force a reschedule (once) when
> > need_resched() is false.  Every time the process is granted a time
> > slice, it'll check the condition and surrender if not ready.

Except that the task remains runnable (and not using its timeslice up).
It won't sleep; there's nothing to drive it into TASK_NOT_RUNNING
state.

Try it and watch what's going on when you trigger that loop.  That's
really not a good way to wait for something to happen.
