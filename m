Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC575C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB37A213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H7Xiqzra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB37A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeK3FA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:00:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43370 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725725AbeK3FA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:00:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id 83-v6so2538525ljf.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wh3IMmrsl0oP+FOdGXocY8q45FpJAhVqyz/wB2MNo44=;
        b=H7XiqzraIqKRMwpOMBs8EIrUB1rP7Cg2rlLyJh139rfCeUYstiPKQgMrEt33wiClDU
         N/xQLJzUNcR/+0aM1jyyAc8zi1uyHBneVXNwsO+h01dpupBXP7NSF9YVbiEibOjagXue
         Nn1/3VDv4sxfr70ayvNkanHSi5S2M+T52ZiO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wh3IMmrsl0oP+FOdGXocY8q45FpJAhVqyz/wB2MNo44=;
        b=mWu2UNijEngK0Tfk5jpGeGNQo+OA3UPW5aXe1wcwxaI/ceYZ+GaaOGJ4MtA/sjE+MC
         koex334Z6tGeUPcqgHbY5MCKZWyDtH2MKnbL/hn5iAPMiC38Y19E6BKOT0xL+PMLz4+A
         p7hW8X3YxUNYaQrSZBCTe25ii34Bu1zdcs/BSb4EmjqkJco54sDsZIxeWRCp4p9NP2HW
         16Mm5CCMeTvkG1D38HA7YlkfctrfLlJHQbPBMIsonNtje75v4lQlzTPjpuMHJWnjRipi
         kC7NFNjDFKPiAw0y7vKU/3iBu6xiSZ32EJ+x59s71nElXltyl9GOn7aVe58DmFcpRg4N
         JvEg==
X-Gm-Message-State: AA+aEWan6eQ2JJ3I1AqJEOZzlY9zKf4nnJHrdCBLvLE7HxI97iy3iZNu
        p+I71NzXdLHXrS8BQ6u5C7ZHItBmlL0=
X-Google-Smtp-Source: AFSGD/X7FgkHEeeJWPuCqMJCY387rZPv+5k1VqUysPEpXeQ0TENaSz5xyJkmEs/n7pADemWWFmiVNw==
X-Received: by 2002:a2e:3803:: with SMTP id f3-v6mr1725114lja.169.1543514084005;
        Thu, 29 Nov 2018 09:54:44 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q11sm398751lfc.92.2018.11.29.09.54.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:54:43 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id t9-v6so2541929ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:54:43 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr1930249ljk.80.1543514082891;
 Thu, 29 Nov 2018 09:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble> <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
 <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
 <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129121307.12393c57@gandalf.local.home>
 <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 09:54:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNKuuhS9DTYx_ta_yDt4x2mLjtAgWgLE=gXEQrvz_vNg@mail.gmail.com>
Message-ID: <CAHk-=whNKuuhS9DTYx_ta_yDt4x2mLjtAgWgLE=gXEQrvz_vNg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 9:50 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  - corrupt random registers because we "know" they aren't in use

Just to clarify: I think that's a completely unacceptable model.

We already have lots of special calling conventions, including ones
that do not have any call-clobbered registers at all, because we have
special magic calls in inline asm.

Some of those might be prime material for doing static calls (ie PV-op
stuff, where the native model does *not* change any registers).

So no. Don't do ugly hacks like that.

               Linus
