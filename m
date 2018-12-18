Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC9CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3743B21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeLRUcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeLRUcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:32:12 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D75C21871;
        Tue, 18 Dec 2018 20:32:10 +0000 (UTC)
Date:   Tue, 18 Dec 2018 15:32:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V2 9/9] jump_label: Batch up if arch supports it
Message-ID: <20181218153208.6f8bd858@gandalf.local.home>
In-Reply-To: <d8a417e9-eb0f-d087-f0c5-7405b030e51c@redhat.com>
References: <cover.1545149539.git.bristot@redhat.com>
        <3c212982833e3b27f8610c8389413b81ed5fb0e1.1545149539.git.bristot@redhat.com>
        <20181218123556.5257b1a7@gandalf.local.home>
        <d8a417e9-eb0f-d087-f0c5-7405b030e51c@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 20:33:48 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> >> +#else
> >> +static void __jump_label_update(struct static_key *key,
> >> +				struct jump_entry *entry,
> >> +				struct jump_entry *stop,
> >> +				bool init)
> >> +{
> >> +	for_each_label_entry(key, entry, stop) {
> >> +
> >> +		if (!jump_label_can_update_check(entry, init))
> >> +			continue;
> >> +
> >> +		if (arch_jump_label_transform_queue(entry,
> >> +						    jump_label_type(entry)))
> >> +			continue;
> >> +
> >> +		/*
> >> +		 * Queue's overflow: Apply the current queue, and then
> >> +		 * queue again. If it stills not possible to queue, BUG!
> >> +		 */
> >> +		arch_jump_label_transform_apply();
> >> +		if (!arch_jump_label_transform_queue(entry,
> >> +						     jump_label_type(entry))) {
> >> +			BUG();  
> > 
> > Why BUG()? Do you really want to crash Linus's machine?  
> 
> I am using BUG() because that is what I see in other part of jump_label code:
> 	If something goes wrong:
> 		BUG().

Where? Mostly we have BUILD_BUG_ON() which isn't bad at all.

The only other BUG I see in the jump label code is in the arch specific
code and that's from 2012. Lately, we are trying to get rid of BUG()
and panic() entirely, with a few exceptions (where there's really no
way to return. Like when the function graph stack is corrupted, and we
don't know where to go).

If there's a way to continue in a critical state, it's best to WARN()
and continue on. That way, the user can have a chance to see what
happened.

> 
> What I could do here is:
> 
> Add a "fallback" boll that is disabled by default.
> If I hit this case:
> 	WARN()
> 	turn "fallback" on, returning to the old mode (without batch)
> 
> Sound better?

Yes, please do.

Thanks!

-- Steve
