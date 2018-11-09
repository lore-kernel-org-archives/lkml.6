Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCF8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50110208A3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y/OjEtzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50110208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeKJA5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbeKJA5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:57:32 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E62C208E3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Nov 2018 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541776591;
        bh=WaBlzxzS+GDCiqnZ0/Mh6MnWrYZN9nBbL8DUB34u2Ck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y/OjEtzQcVq39oINKXhslHiHYL1wpab30/AyJIeBdkmRyo47TmviWGY92UruxOQG6
         qI3C+MfeqAMClpE+V61qkeQ2RilMXAJ02E6sWX1qmKdzo7F++19dHtUHWPqrac7mSc
         LCFLhvhsbdCGKx7u92Bk+2jR3VxkEK/9hUjUqplI=
Received: by mail-wm1-f53.google.com with SMTP id r63-v6so2357354wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 07:16:31 -0800 (PST)
X-Gm-Message-State: AGRZ1gItmBqJQxulMyVRNltQFsUox1GDj24m0a1/yePOPrVpgkij47je
        6YJbhtKzpp7NnAiUY4zP4t/CfVrt6VdPsqwJLiCxXw==
X-Google-Smtp-Source: AJdET5cqL1y1ZJrXzH8QRaJ3J3MvSbs1Tg4+ib+LZSzb+nN9SVxNpPY6djSzEYGJlwEH5XdVKiH0XuFT5P0symjevf4=
X-Received: by 2002:a1c:ccb:: with SMTP id 194-v6mr5452105wmm.102.1541776589693;
 Fri, 09 Nov 2018 07:16:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541711457.git.jpoimboe@redhat.com> <20181109072811.GB86700@gmail.com>
In-Reply-To: <20181109072811.GB86700@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 9 Nov 2018 07:16:17 -0800
X-Gmail-Original-Message-ID: <CALCETrU3tPPOiuTaLqUy-L4sPvZRU8BLYML-BgQH_LZhA4bzSQ@mail.gmail.com>
Message-ID: <CALCETrU3tPPOiuTaLqUy-L4sPvZRU8BLYML-BgQH_LZhA4bzSQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Static calls
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 11:28 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> All other usecases are bonus, but it would certainly be interesting to
> investigate the impact of using these APIs for tracing: that too is a
> feature enabled everywhere but utilized only by a small fraction of Linux
> users - so literally every single cycle or instruction saved or hot-path
> shortened is a major win.

For tracing, we'd want static_call_set_to_nop() or something like that, right?

--Andy
