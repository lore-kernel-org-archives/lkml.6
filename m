Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0ADC7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7E12064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7E12064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJORlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:41:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40065 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJORlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:41:19 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=a3f-osx.local)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1gBzcE-0000Ze-IC; Mon, 15 Oct 2018 11:56:46 +0200
Subject: Re: [PATCH RFC] proc: Don't retain negative dentries
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20181008165009.21890-1-a.fatoum@pengutronix.de>
 <20181008165545.GE32577@ZenIV.linux.org.uk>
 <b10ac74f-1e70-aa4d-7aec-65cbea0a9d83@pengutronix.de>
 <20181008180115.GF32577@ZenIV.linux.org.uk>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <93e26435-985a-0a1e-9bd5-18f9bcc6142d@pengutronix.de>
Date:   Mon, 15 Oct 2018 11:56:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008180115.GF32577@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks very much for the elaboration!

On 8/10/18 20:01, Al Viro wrote:
> On Mon, Oct 08, 2018 at 07:02:09PM +0200, Ahmad Fatoum wrote:
> OK, to elaborate: where have you seen negative dentries on procfs in
> the first place?  I'm trying to find a way for such to happen, but
> I don't see any.  And in any case, these ->d_delete() and ->d_revalidate()
> instances would've been oopsing on such.

Sorry for the misunderstanding on my part. The referenced commit replaced
simple_dentry_operations whose only non-NULL member points at:

/*
 * Retaining negative dentries for an in-memory filesystem just wastes
 * memory and lookup time: arrange for them to be deleted immediately.
 */
int always_delete_dentry(const struct dentry *dentry)
{
	return 1;
}

which is what I based my rationale on.

> ->d_delete() is about retaining _unused_ dentries in hash for future lookups;
> nothing to do with positive/negative.  *And* ->d_delete() is called only when
> refcount hits zero.  If another process opens the damn thing and keeps it opened,
> ->d_delete() won't be called at all and your patch won't change the behaviour
> of the entire thing.

I see. Would that mean that previously it only worked by chance?

> If anything, you might want to have separate ->d_op for /proc/*/net, so
> that its ->d_revalidate() would return 0 if netns doesn't match.  Would
> need a way to keep some information allowing to detect the switchover, of
> course (either in PROC_I(inode) or in ->d_fsdata of that dentry - in the
> latter case you'd want to do whatever you need to dispose of that in
> ->d_release()).  Check in revalidate should be along the lines of "do what's
> currently done in get_proc_task_net(), compare the result with the memorized
> value, bugger off on mismatch", perhaps with memorized value being
> counted as a reference (in which case you'd want to do put_net() when
> disposing of the inode or dentry, whichever you use to keep it in).  In
> that case proc_tgid_net_lookup()/proc_tgid_net_getattr()/proc_tgid_net_readdir()
> would simply use the stored reference instead of messing with get_proc_task_net()
> and put_net().
> 
> You'd need separate dentry_operations for /proc/*/net and /proc/*/*/net,
> instead of using pid_dentry_operations.  That would need to be recognized
> in proc_pident_instantiate() (_without_ memcmp(p->name, "net", 4) on each
> call of that thing, preferably).  I'd put that new instance of dentry_operations
> (along with the methods in it, of course) into fs/proc/proc_net.c, where
> we already have the inode and file methods of /proc/*/net.
> 

I will need to understand why my patch seemed to fix it and would try to
find some time later this month to implement it properly (or if someone
finds that time now, I would appreciate that too!)


Thanks again
Ahmad

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
