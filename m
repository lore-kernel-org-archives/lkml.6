Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B6DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786DA2064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786DA2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJIBON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:14:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53362 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbeJIBON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:14:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9ZqF-0000or-LO; Mon, 08 Oct 2018 18:01:15 +0000
Date:   Mon, 8 Oct 2018 19:01:15 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH RFC] proc: Don't retain negative dentries
Message-ID: <20181008180115.GF32577@ZenIV.linux.org.uk>
References: <20181008165009.21890-1-a.fatoum@pengutronix.de>
 <20181008165545.GE32577@ZenIV.linux.org.uk>
 <b10ac74f-1e70-aa4d-7aec-65cbea0a9d83@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b10ac74f-1e70-aa4d-7aec-65cbea0a9d83@pengutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 07:02:09PM +0200, Ahmad Fatoum wrote:
> Hello,
> 
> On 10/8/18 6:55 PM, Al Viro wrote:
> > 
> > What the hell does that have to do with negative dentries anywhere???
> 
> It's possible that this needs fixing at another place. I don't know,
> but this seems to work for me, that's why I prefixed with RFC.

OK, to elaborate: where have you seen negative dentries on procfs in
the first place?  I'm trying to find a way for such to happen, but
I don't see any.  And in any case, these ->d_delete() and ->d_revalidate()
instances would've been oopsing on such.

->d_delete() is about retaining _unused_ dentries in hash for future lookups;
nothing to do with positive/negative.  *And* ->d_delete() is called only when
refcount hits zero.  If another process opens the damn thing and keeps it opened,
->d_delete() won't be called at all and your patch won't change the behaviour
of the entire thing.

If anything, you might want to have separate ->d_op for /proc/*/net, so
that its ->d_revalidate() would return 0 if netns doesn't match.  Would
need a way to keep some information allowing to detect the switchover, of
course (either in PROC_I(inode) or in ->d_fsdata of that dentry - in the
latter case you'd want to do whatever you need to dispose of that in
->d_release()).  Check in revalidate should be along the lines of "do what's
currently done in get_proc_task_net(), compare the result with the memorized
value, bugger off on mismatch", perhaps with memorized value being
counted as a reference (in which case you'd want to do put_net() when
disposing of the inode or dentry, whichever you use to keep it in).  In
that case proc_tgid_net_lookup()/proc_tgid_net_getattr()/proc_tgid_net_readdir()
would simply use the stored reference instead of messing with get_proc_task_net()
and put_net().

You'd need separate dentry_operations for /proc/*/net and /proc/*/*/net,
instead of using pid_dentry_operations.  That would need to be recognized
in proc_pident_instantiate() (_without_ memcmp(p->name, "net", 4) on each
call of that thing, preferably).  I'd put that new instance of dentry_operations
(along with the methods in it, of course) into fs/proc/proc_net.c, where
we already have the inode and file methods of /proc/*/net.
