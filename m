Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40491C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A2B208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A2B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeK0JUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:20:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeK0JUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:20:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FD2334CC;
        Mon, 26 Nov 2018 22:24:25 +0000 (UTC)
Received: from treble (ovpn-121-105.rdu2.redhat.com [10.10.121.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38FAA5C6DC;
        Mon, 26 Nov 2018 22:24:22 +0000 (UTC)
Date:   Mon, 26 Nov 2018 16:24:20 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <20181126222420.7w2vxux7mtnfxu5r@treble>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <20181126155405.72b4f718@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181126155405.72b4f718@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 26 Nov 2018 22:24:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 03:54:05PM -0500, Steven Rostedt wrote:
> In summary, we had this:
> 
> No RETPOLINES:
>             1.4503 +- 0.0148 seconds time elapsed  ( +-  1.02% )
> 
> baseline RETPOLINES:
>             1.5120 +- 0.0133 seconds time elapsed  ( +-  0.88% )
> 
> Added direct calls for trace_events:
>             1.5239 +- 0.0139 seconds time elapsed  ( +-  0.91% )
> 
> With static calls:
>             1.5282 +- 0.0135 seconds time elapsed  ( +-  0.88% )
> 
> With static call trampolines:
>            1.48328 +- 0.00515 seconds time elapsed  ( +-  0.35% )
> 
> Full static calls:
>            1.47364 +- 0.00706 seconds time elapsed  ( +-  0.48% )
> 
> 
> Adding Retpolines caused a 1.5120 / 1.4503 = 1.0425 ( 4.25% ) slowdown
> 
> Trampolines made it into 1.48328 / 1.4503 = 1.0227 ( 2.27% ) slowdown
> 
> With full static calls 1.47364 / 1.4503 = 1.0160 ( 1.6% ) slowdown
> 
> Going from 4.25 to 1.6 isn't bad, and I think this is very much worth
> the effort. I did not expect it to go to 0% as there's a lot of other
> places that retpolines cause issues, but this shows that it does help
> the tracing code.
> 
> I originally did the tests with the development config, which has a
> bunch of debugging options enabled (hackbench usually takes over 9
> seconds, not the 1.5 that was done here), and the slowdown was closer
> to 9% with retpolines. If people want me to do this with that, or I can
> send them the config. Or better yet, the code is here, just use your
> own configs.

Thanks a lot for running these.  This looks like a nice speedup.  Also a
nice reduction in the standard deviation.

Should I add your tracepoint patch to the next version of my patches?

-- 
Josh
