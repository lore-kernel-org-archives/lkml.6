Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A583C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D62020685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfAJUxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:53:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40067 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbfAJUxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:53:11 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0AKpwOr355981
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 10 Jan 2019 12:51:59 -0800
Subject: Re: [PATCH v3 0/6] Static calls
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <CAHk-=wiP4Z5r6tdkuD2DYocxG0zx=Kh+Z2k_LQ4QFvehe1+9uw@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <faadced2-9343-8bbc-5bd6-8682382e7322@zytor.com>
Date:   Thu, 10 Jan 2019 12:51:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiP4Z5r6tdkuD2DYocxG0zx=Kh+Z2k_LQ4QFvehe1+9uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/19 9:31 AM, Linus Torvalds wrote:
> On Wed, Jan 9, 2019 at 2:59 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>
>> NOTE: At least experimentally, the call destination writes seem to be
>> atomic with respect to instruction fetching.  On Nehalem I can easily
>> trigger crashes when writing a call destination across cachelines while
>> reading the instruction on other CPU; but I get no such crashes when
>> respecting cacheline boundaries.
> 
> I still doubt ifetch is atomic on a cacheline boundary for the simple
> reason that the bus between the IU and the L1 I$ is narrower in older
> CPU's.
> 

As far as I understand, on P6+ (and possibly earlier, but I don't know) it is
atomic on a 16-byte fetch datum, at least for Intel CPUs.

However, single byte accesses are always going to be safe.

	-hpa

