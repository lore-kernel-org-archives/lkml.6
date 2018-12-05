Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F6FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A24206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A24206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeLEPEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:04:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeLEPEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:04:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDB2137E8E;
        Wed,  5 Dec 2018 15:04:30 +0000 (UTC)
Received: from treble (ovpn-123-135.rdu2.redhat.com [10.10.123.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E99918B95;
        Wed,  5 Dec 2018 15:04:28 +0000 (UTC)
Date:   Wed, 5 Dec 2018 09:04:22 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 0/4] Static calls
Message-ID: <20181205150422.mlrjcm5rm26ozg5j@treble>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <20181204180835.29f9aa03@vmware.local.home>
 <EE66E7C9-5735-48B3-A001-E9FCDA46E177@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EE66E7C9-5735-48B3-A001-E9FCDA46E177@amacapital.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 05 Dec 2018 15:04:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 03:41:01PM -0800, Andy Lutomirski wrote:
> 
> 
> > On Dec 4, 2018, at 3:08 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > 
> > Where did this end up BTW?
> > 
> > I know that there's controversy about the
> > CONFIG_HAVE_STATIC_CALL_OPTIMIZED option, but I don't think the 
> > CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED version was controversial. From the
> > v1 patch 0 description:
> > 
> > There are three separate implementations, depending on what the arch
> > supports:
> > 
> >  1) CONFIG_HAVE_STATIC_CALL_OPTIMIZED: patched call sites - requires
> >     objtool and a small amount of arch code
> > 
> >  2) CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED: patched trampolines - requires
> >     a small amount of arch code
> > 
> >  3) If no arch support, fall back to regular function pointers
> > 
> > My benchmarks showed the best improvements with the
> > STATIC_CALL_OPTIMIZED, but it still showed improvement with the
> > UNOPTIMIZED version as well. Can we at least apply 2 and 3 from the
> > above (which happen to be the first part of the patch set. 1 comes in
> > at the end).
> 
> Sounds good to me.
> 
> > 
> > I would also just call it CONFIG_STATIC_CALL. If we every agree on the
> > optimized version, then we can call it CONFIG_STATIC_CALL_OPTIMIZED.
> > Have an option called UNOPTIMIZED just seems wrong.

(Poking my head up for a bit, soon to disappear again until next week)

Ard had already objected to "unoptimized", which was why for v2 I
renamed them to CONFIG_STATIC_CALL_OUTLINE and CONFIG_STATIC_CALL_INLINE.

I could rename it to CONFIG_STATIC_CALL and CONFIG_STATIC_CALL_INLINE if
you prefer.  I don't have much of an opinion either way.

I'll post a v3 next week or so, with the controversial bits more fully
separated from the non-controversial bits.  So at least the out-of-line
implementation can get merged.

> My objection to all the bike shed colors so far is that we *always*
> have static_call() — it’s just not always static.

Hm?  Do you mean you don't like that we have a generic function pointer
implementation?  or what?

> Anyway, I have a new objection to Josh’s create_gap proposal: what on
> Earth will kernel CET do to it?  Maybe my longjmp-like hack is
> actually better.

Does CET even care about iret?  I assumed it didn't.  If it does, your
proposal would have the same problem, no?

-- 
Josh
