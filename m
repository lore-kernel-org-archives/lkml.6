Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051B516256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B184720894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR9dlmno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B184720894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbeG3Rz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:55:27 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38254 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeG3Rz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:55:26 -0400
Received: by mail-ua0-f193.google.com with SMTP id o11-v6so8217087uak.5;
        Mon, 30 Jul 2018 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m7PhWWsCMr3LfMYRn2R6wNnfvgyjxDga/VgsO+HL+0E=;
        b=oR9dlmno03HmCTIaDvEcPTrq0qwXRLsv0lP+u8rokfI1Qh2HQVETHIRYMFrZCKrxr/
         roEhDCaW90dXmY4frlSPcbiy+yJZGtiJH8wyDY4n1+AMnpVfeEhHguwcLVD9pWE9laM3
         ZnXpwZFM2sH7ByDFWpr7IMQl/HD62hnIUogGLJ5GOCheNSR9ZpI+Hgc7Pnm4Uyzzb30f
         HszydAm9ZAitSEfztIvW57ghs8QP28WMoDGHYRFp9xZ31XScrEQe4g+SwDZkfDHLax7m
         Aj0+R1ETqGHAqX4uay3cilvKAsY1HWdqG7vXHJxOtvvBzItW2rH5uPeBw04MdZqscguA
         HyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m7PhWWsCMr3LfMYRn2R6wNnfvgyjxDga/VgsO+HL+0E=;
        b=ZpmaXaMt75EQEiwqYoTeZnCfVa9gOTFnte56KAHSlnd5sZdkaeZJYGHO6O1gas8f2E
         81ASayS4kyHsLcjqizVk7JcJgpOrsFFo2FS8un7kNJ4yvFj0Z7GoTinGUOBdZ05XWhuJ
         mz9Eomh9EB+k43ziyiBuK9zAs7ZxwyVlWa5KreGBXIIFLCURpPoD/SLcwEeCylETlLau
         4y7L/zPzyKrJaGiHzKB9oqJjy30qt+tciVOubrKTFNdJy16tjubSKsP+7d9dJ9eiqW8V
         +X7hZDZhLMTDtVBREPs89hjK9DL8zf3HrE50hqB2m8lePLATLcEZ2mEoRxnwhZSSUdgO
         nL7A==
X-Gm-Message-State: AOUpUlHOczDfBnKZYhxyL3webicFoDnQawCzSug30Dir3O+c+ulbjx7C
        dIXEg440IjRqPKGP68VCdOgISI4xwkx1Y02fAXo=
X-Google-Smtp-Source: AAOMgpd3/op3dOa5HLFQd653G+bxhsDOfxUB/gtA8TKNIbEHvMw1LAjgC7ovbAQ9bXR/tZIcFISFS+Px4eQrhsEYbXg=
X-Received: by 2002:a9f:3242:: with SMTP id y2-v6mr12565653uad.85.1532967583359;
 Mon, 30 Jul 2018 09:19:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:7cc8:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 09:19:22
 -0700 (PDT)
In-Reply-To: <87effy9gfz.fsf@xmission.com>
References: <1531935483-30784-1-git-send-email-s.mesoraca16@gmail.com>
 <CAGXu5jK4q6HLDZ6jokTeDABbzVasY85Jo0HFNKYeaKWZYPjPKg@mail.gmail.com> <87effy9gfz.fsf@xmission.com>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Mon, 30 Jul 2018 18:19:22 +0200
Message-ID: <CAJHCu1JkX+7bsh2c2GG1LbH4HW_tQ+kJAXzvWY-rVKBtpDL_4g@mail.gmail.com>
Subject: Re: [RFC] kconfig: add hardened defconfig helpers
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-20 15:37 GMT+02:00 Eric W. Biederman <ebiederm@xmission.com>:
> Kees Cook <keescook@chromium.org> writes:
>
>>> +CONFIG_USER_NS=n
>>> +~~~~~~~~~~~~~~~~
>>> +
>>> +**Negative side effects level:** Medium
>>
>> Unfortunately I think this is High or Extreme. USER_NS gets a lot of use.
>>
>>> +**- Protection type:** Attack surface reduction
>>> +
>>> +This allows containers to use user namespaces to provide different
>>> +user info for different servers.
>>> +User namespaces have been abused in the past for privilege
>>> +escalation.
>
> This is not a particularly good description.

You are right, I've been a bit shallow...
Thank you for pointing it out.
I didn't mean to say that user namespaces are bad for security in general.
I'll make this less ambiguous in the next revision.

> User namespaces do indeed increase the attack surface of programs that
> don't use them.
>
> User namespaces when used to build ``unprivileged containers'' remove or
> at least drastically reduce the need to run as root when setting up
> containers.  Which is attack surface reduction.
>
> User namespaces make available tools that are commonly used to build
> sandboxes.  Chrome for example uses users namespaces if they are
> available as part of setting up it's sandbox.
>
> User namespaces are not limited to containers.
>
> The bugs in the attack surface that user namespaces expose that have
> been used for privilege escalation have to the best of my knowledge
> closed.  So while there is some danger in the increased attack surface
> we are looking at implementation defects rather than design defects.
>
> Eric
