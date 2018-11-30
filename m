Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5055C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AAE20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="DZGNmONP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AAE20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLAKvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:51:03 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34709 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeLAKvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:51:01 -0500
Received: by mail-io1-f67.google.com with SMTP id f6so5946581iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=HeybjgHbpJipZ1Il1YROY2kgpa3unntVdKUfLQT23yQ=;
        b=DZGNmONPcTMUNS0/QPap0woXinmtxEsKXDyvBPpJuvf2K6pRlHCANy18YWwEFJrQ+Z
         w2Rl6Q7SMUCsz8zK9G4a+of6PoZ/i132QgDfDrgqL/wpSp+Tppj3kvlFqYaHW9jpRZoM
         tVmxRy8ilp6seRzpSszroXD6ljYBX5jTIPVXKSzmPTNoQU099oLJtrnkoeXo+7Dy8jAd
         sTbVga5WXtLAOr0XR6fOdMq5rKeW0T/406CTVdIkESWQTR52LJ9pb2uFvfLwgTCP3KMt
         XlzwnZBQK7rPjpyKuuNYDI4h/Xfff5yMz3Jwue9HUwkCAxB1keVxL/n68+QNMwH9glCs
         Q8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=HeybjgHbpJipZ1Il1YROY2kgpa3unntVdKUfLQT23yQ=;
        b=DNaOI9ZPBRjcH9Oc+XCA9qDz7N/ADE6iJtGU5lyfavytAjsWdhBgPdymcRsDB7J4fz
         GXDjoH45daHVMApq6Cq510necDkqIVg2lWxd5iDP9AFt+DBjxWsyPLmE+ybahsDULE2t
         4Wo6X0S4UPdVe0AjQ0GRYwAJs/jlcbXVt4BOsxnoFRkGLgm3e/5gukLGyR22hq6qh5Hr
         lOosAr4S/vKJD3UZBX0ZLipKE2zCNdw4yvlqV/glw/skaWk+8Ktn8yWX8eMXL9GTI0Zb
         3MoOh0Khp8lSI59m/E68iWag280xalJZ75fQAbiFkn6yiR8WUOjAmEP/Uy/sKQAgXXxI
         i5Qg==
X-Gm-Message-State: AA+aEWbmeTOC5wm+es8YeBS2WFikJuww/73J4Xd3z+n0i6kBK83Wi+ht
        P/37jlV75onERe3+HrliEcX+qQ==
X-Google-Smtp-Source: AFSGD/XfOzW60BZOGfmDnb36lGUB+TnW/f/5XWJx3rMVp9BEcUWhbgk2uXdYyXWXkikBSWqXblueRA==
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr6755815ioa.266.1543621202534;
        Fri, 30 Nov 2018 15:40:02 -0800 (PST)
Received: from [26.67.58.27] ([172.56.12.18])
        by smtp.gmail.com with ESMTPSA id r11sm2463740iog.46.2018.11.30.15.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 15:40:01 -0800 (PST)
Date:   Sat, 01 Dec 2018 12:37:57 +1300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAK8P3a2x3nQKKvLBSH8G9R6w+sv=09y3h7gWdFYUMNAsB8aj6g@mail.gmail.com>
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com> <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io> <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com> <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net> <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com> <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io> <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com> <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com> <CAK8P3a1isSRCd-OLJK15C+gSJdpeR=zEXghc8+AMM5QYYw3Tyg@mail.gmail.com> <EC87B1BE-BDD0-414F-85F8-806C3CC4DD07@brauner.io> <CAKOZuesEPFnkd7YGbu82TRQwhR=KPwNW8GpYTw=719_xmJx9FA@mail.gmail.com> <CAK8P3a2x3nQKKvLBSH8G9R6w+sv=09y3h7gWdFYUMNAsB8aj6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Colascione <dancol@google.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <7C5B4CBD-6364-4DCE-9EFD-3657C67DACEB@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 1, 2018 12:12:53 PM GMT+13:00, Arnd Bergmann <arnd@arndb=2Ede> =
wrote:
>On Sat, Dec 1, 2018 at 12:05 AM Daniel Colascione <dancol@google=2Ecom>
>wrote:
>> On Fri, Nov 30, 2018 at 2:26 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>> > On December 1, 2018 11:09:58 AM GMT+13:00, Arnd Bergmann
><arnd@arndb=2Ede> wrote:
>> >
>> > One humble point I would like to make is that what I care about
>most is a sensible way forward without having to redo essential parts
>of how syscalls work=2E
>> > I don't want to introduce a sane, small syscall that ends up
>breaking all over the place because we decided to fix past mistakes
>that technically have nothing to do with the patch itself=2E
>> > However, I do sympathize and understand these concerns=2E
>>
>> IMHO, it's fine to just replicate all the splits we have for the
>> existing signal system calls=2E It's ugly, but once it's done, it'll be
>> done for a long time=2E I can't see a need to add even more signal
>> system calls after this one=2E
>
>We definitely need waitid_time64() and rt_sigtimedwait_time64()
>in the very near future=2E

Right, I remember you pointing this out in a prior mail=2E
Thanks for working on this for such a long time now, Arnd!
Can we agree to move on with the procfd syscall given the current constrai=
nts?
I just don't want to see the syscall being=20
blocked by a generic problem whose
ultimate solution is to get rid of weird
architectural constraints=2E :)

