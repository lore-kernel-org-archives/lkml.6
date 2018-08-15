Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F669C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D7121527
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EOchf478"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D7121527
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeHOV2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:28:37 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42274 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeHOV2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:28:37 -0400
Received: by mail-yw1-f68.google.com with SMTP id y203-v6so1534171ywd.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xh/FUUEwxkp7nLrQJqr/J65SG4Lk4GU7hqKGMevo7vQ=;
        b=EOchf478fQS3XhRCZCkUXeg+SDahAlEIVtm3j/RqI6m4IAuglMXsXbO/+/+Dk2eldA
         gy8mhIx12vyQSmMELvRzjzCVyt5YFeAquvSszeJaCvI8KKU4qQNA+z3gtmqxj80wY+ND
         nX/rhxEPZJuTp6cpzNDvD+Q4DpYQO4XPwhOWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xh/FUUEwxkp7nLrQJqr/J65SG4Lk4GU7hqKGMevo7vQ=;
        b=b2HDrWTFe738jtFQONktF4VscE/Eg92XfPd8K1WkpRMGNs0GvIdrl9b18BrqX+8YO6
         paNhaONjnMQqNNKPVMegZmGWwsqOMGuMtILWZ5Wkw/+QDVrYcf3FuhQPG11FN0oUskcS
         eHfKQtGNXqUzZ3DfL+JpZp7x62NglKfzb6ighgVhVUCZzYqmNylGQweqKqvv7Zj06A6G
         /nrGCTAkXS1+aWaI6QOxv2zlRslIm5yRK4YZMcFqo7Q8jdItGU74r52bm6Ov3wh1ZbqF
         3UXBh2Sg1FEWjcaYGn6Yiz82/p9yF+ThoHLbqX3KtLKb6m40ljB7/X6OdjM8h3JU414c
         Xg/g==
X-Gm-Message-State: AOUpUlGZBFA0ftAr0BvQLennP+xB850GjgNMgV6G6rCz0nBIUsDp1dvM
        XyraEZoDxJS1vU3thkGiSbhSlV35aLw=
X-Google-Smtp-Source: AA+uWPxyKepsOoKckRItsKPsGiG1PPV9ZoG8qusRXeAAHcxHY37NND7NdGyY3zZpD0aKBtiHZJkx4Q==
X-Received: by 2002:a0d:ce81:: with SMTP id q123-v6mr13915478ywd.8.1534358119797;
        Wed, 15 Aug 2018 11:35:19 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id n3-v6sm12393671ywb.70.2018.08.15.11.35.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 11:35:18 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id e23-v6so1527922ywe.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 11:35:18 -0700 (PDT)
X-Received: by 2002:a25:15ca:: with SMTP id 193-v6mr15889455ybv.484.1534358117828;
 Wed, 15 Aug 2018 11:35:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5092:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 11:35:16
 -0700 (PDT)
In-Reply-To: <CA+55aFw5Tkn6DgkAZS-UGOjJpYp2R4rFAm9ixu_=FONeqRyofg@mail.gmail.com>
References: <20180813214328.GA15137@beast> <CA+55aFw5Tkn6DgkAZS-UGOjJpYp2R4rFAm9ixu_=FONeqRyofg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 15 Aug 2018 11:35:16 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK_w7JRywdQ78FfQxeLSMmXbvyDDnaYzj27=y8wnAzKxQ@mail.gmail.com>
Message-ID: <CAGXu5jK_w7JRywdQ78FfQxeLSMmXbvyDDnaYzj27=y8wnAzKxQ@mail.gmail.com>
Subject: Re: [GIT PULL] gcc-plugin updates for v4.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 9:41 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Aug 13, 2018 at 2:43 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> Please pull these gcc-plugin changes for v4.19-rc1.
>
> No.
>
> It adds yet another BUG_ON() without having been merged.
>
> I'm not pulling this. Dammit, have you learnt *nothing*?

I swear I'm doing my best. Are you speaking of
stackleak_check_alloca() or stackleak_erase()? These were both
discussed on the list, and we weren't able to come up with
alternatives: in both cases we're off the stack, and recovery is
seemingly impossible. What would you prefer in these cases? If I need
to take a hard line of "never BUG", how do I handle legitimate system
corruption? (i.e. I have interpreted this as different from narrowing
copy_*_user() usage: if we let execution continue, we'll just crash
somewhere else with likely less information on how to handle it.)

> I'm, disappointed in the whole feature, but I'm also tired of having
> to go and even look for these things.

I am trying to make these patches easier to review. I even made sure
to get Ingo's Ack and Alexander implemented additional features Ingo
suggested, before sending them your way, as Ingo has a very
conservative eye on.

> Then actually *finding* them makes me just pissed off.

I'm sorry we've disappointed you. I've been pushing back on patches
that use BUG (with, I think, good success), but there are cases where
our imagination fails us.

I'd really like to find a way for this plugin to be acceptable, given
the coverage is provides. Even if we solve stack initialization and
finish VLA removal, we still would benefit from something doing
post-syscall stack poisoning just to keep future cache attacks against
the stack minimized.

In the meantime, I will send the gcc-plugin cleanups separately...

-Kees

-- 
Kees Cook
Pixel Security
