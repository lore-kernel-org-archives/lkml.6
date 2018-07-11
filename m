Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3C2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDF720C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Uz8nVNnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDF720C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389193AbeGKSBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:01:30 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40132 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387738AbeGKSBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:01:30 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so14888029iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6MV4NRlR6o1m3V9DvTGCWIaIlrWrijl41JCxLbwDOb0=;
        b=Uz8nVNnMneDLKgijVy2h1tqej2/utMoCQ2egnFNfFxEt1t1gYGVCwAk0aiXfgO3Wtp
         GeYXEZClbPRmatldIjaMq1l6sAZLlyuyKmtJGUhU5UP0NmSpkLydmk4Z2FGyoLRcJNwt
         6QM/TOXXFN3wvOarQEzp5WPCGDuyeZ/1bBNIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6MV4NRlR6o1m3V9DvTGCWIaIlrWrijl41JCxLbwDOb0=;
        b=fV5fwAF06xRSLRn152YxTqKEpEUNGlFmAJwFy78mOb6+AerNMKequyUrKnkaRdzNvT
         3V8n3SULHQUpXfGwWc5cfCmcO8OcfB7DewT9bKI+q9fugkDEBVBop2b+Vbz1YbPXUMpf
         yScJ/zNkS36LN2HHWwJjr4bPJ61LBB4F1N2lBvUTOhnbU/Pq8g5T48onOPGcEWlkMOE+
         mufSonTi905z5Y7alIl4cm8a7lZxrTKe9b5/BoiOR278EfMaNfguk7iiFU+tsvkIcOsA
         hjMHQG7rGJopa0EyghSrjej4hadePmUp22FoN9Y8M00KYDxfe/6zOZZtCVUlYy5+Ntf/
         dCCw==
X-Gm-Message-State: AOUpUlEW2dl1Q/1/2QmqlDR2PtTQnJL35jedk5eHszq8QAS6Im+2x9WH
        r2T7DxtQ2NkuZikm/O26wQKv8j+GxJOkubsPlV0D9Q==
X-Google-Smtp-Source: AAOMgpdc0RMJvaPiopXbaloHfq8MEbQxUuT7aZFIGHS0Ub2yt/mAIu3C7NOp2ZfHITfkjChaxe7kDLcZw9L7LrocBac=
X-Received: by 2002:a6b:5503:: with SMTP id j3-v6mr23590330iob.96.1531331763562;
 Wed, 11 Jul 2018 10:56:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e492:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 10:56:02
 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:496f:7dc5:66d7:a057]
In-Reply-To: <2f37f47c-e28e-77fa-2383-96c7d3e77433@redhat.com>
References: <20180628090351.15581-1-hdegoede@redhat.com> <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de> <20180711105255.32803a3c@gandalf.local.home>
 <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de> <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
 <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
 <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com> <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
 <2f37f47c-e28e-77fa-2383-96c7d3e77433@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 11 Jul 2018 19:56:02 +0200
X-Google-Sender-Auth: qSSK4fXyNtmTY6EazgVWzXilFrg
Message-ID: <CAKMK7uFuZ6NJOKHG6PRNLUytE4m6ZUdMakwLx9Ns39OwvTneWQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 7:35 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 11-07-18 17:42, Daniel Vetter wrote:
>>
>> On Wed, Jul 11, 2018 at 5:35 PM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> On 11-07-18 17:28, Daniel Vetter wrote:
>>>>
>>>>
>>>> On Wed, Jul 11, 2018 at 5:14 PM, Hans de Goede <hdegoede@redhat.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 11-07-18 17:07, Thomas Zimmermann wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi
>>>>>>
>>>>>> Am 11.07.2018 um 16:52 schrieb Steven Rostedt:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> What if you make lockless_register_fb visible to fbcon, and then we
>>>>>>> can
>>>>>>> have a macro:
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> There are more of these macro invocations under drivers/tty/vt, which
>>>>>> also mess up the log during debugging.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Hmm, so this option is already broken (in a way) then, my first
>>>>> reaction
>>>>> to your mail was that we should just remove that option. But that
>>>>> seemed
>>>>> a bit harsh to me so I've been working on a fix for the last 10 minutes
>>>>> or so.
>>>>>
>>>>> But if it is already broken I'm tempted to just remove the option and
>>>>> be done with it.  We really need less cruft in the fbdev/fbcon code not
>>>>> more.
>>>>
>>>>
>>>>
>>>> Please don't remove it, it makes debugging kms driver issues on
>>>> initial modeset (which is usually run from framebuffer_register, while
>>>> hodling the console_lock) impossible.
>>>
>>>
>>>
>>> OK, so if we don't remove it, we should probably make it so that it
>>> can be used without triggering any WARN_ONs, which would require changing
>>> the existing WARN_CONSOLE_UNLOCKED() so that the calls from
>>> drivers/tty/vt/vt.c
>>> also do not trigger it ?
>>>
>>> I guess one can just ignore the oopses when debugging, but debugging
>>> surely
>>> would be easier if there are just no oopses ?
>>
>>
>> I'd say let's only bother with the ones in fbcon.c. Avoids the trouble
>> with having to expose the fb module option to vt.c somehow.
>
>
> The plan was actually do the things the other way around, add a flag to
> vt.c which when set disables the WARN_ON calls and then have fbdev[.ko]
> set that when the fb.lockless_fb_register option is set.
>
>> The ones
>> in vt.c are as old as the git history (from a quick check at least),
>> and in my debugging they never have been annoying (or I somehow didn't
>> ever hit them, not idea).
>
>
> There is a #if 1 #define #else #define empty around the
> WARN_CONSOLE_UNLOCKED()
> call in include/linux/console.h I've the feeling that is there as a hack
> to be able to quickly disable the WARN_ONs when debugging.
>
> Have you seen Steven's suggestion which he send about the same time
> as your mail I'm replying to here ? I personally think that doing
> something like that makes sense (for as long as we have the need
> for the lockless_fb_register debug hack).
>
> Note I've 2 patches ready to go to only fix this in fbcon.c, but I
> think a more thorough fix makes sense.

Yeah Steven's suggestion looks reasonable to fix this all for good.
The #if 1 predates git history, so no idea why it was added or by whom
:-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
