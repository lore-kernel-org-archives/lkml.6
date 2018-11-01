Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0593CC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1E520820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="S7P5NeUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1E520820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeKATAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:00:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43898 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKATAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:00:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id k9so17206507otl.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 02:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=ZepkorcyZiwyCOVkKDEV55KjUuM7/W2DRZbSVsNObeA=;
        b=S7P5NeUyymwf1szi59fFovvJQYSgOh6UrXLGmuCGeAOPDWNRqLuO2UK7iVVjlkJnLv
         NLmzfRzpo8yKI0t4f/YVw6STbQJ/nsbQFnYbgvCqjQn4A+47Sr7KKsm/EsewzV51Xt0g
         noYHU50NM8wNzkGXS36rLbudWgu5sQB0eQBg1u+ZIujlxM1ZRV/BGybN0vb6jdi26ovW
         ZgoJJmYzPyeHibKe36KKbNiexn8nd5j/OqewNJyAqJpMnwHFMJ5B7XwdJpzcED580JTp
         4B3PPKJxOqhugUN687UFsuNNU1lqlmhrjZJK86YKZs7RoZ9Qy0rb8ee17yHMx3EwTcrw
         MUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=ZepkorcyZiwyCOVkKDEV55KjUuM7/W2DRZbSVsNObeA=;
        b=cXrihkb8IuXGzM5W0NgS/fTLx2ysCsH+R0+eXx/Fe/Hct+Ohh8F4s3dW6Zb+twG/CJ
         a5NdW+TszE0k9hkCC9r+SIlj3qv55ayMLNBEOO3V4sroGnm59vXL4eWzkufujAbmXeg6
         C96L9+x0/MEDMm26HX1Mc5vLoPRDeCrkyfVAr39yB0QvfMSkT8SEbn/m3Zz7D3VN+mft
         mb+SCyc4+dae0aU7506yLa/xkrTld6uHrgIgffpT4FG+SedTlIK2+tfUF/ghDp4g5TnK
         M/Hd4ZgnF0w9Jd1jS8lx7ta7eoyCZ6MdCsCwX0lfuUzRJYoyx6bOJo1OsIWUyZZ0PvFT
         CJsg==
X-Gm-Message-State: AGRZ1gJemK+wwHEI0tuwk3qrI9+mnYHPJZynrPaqidOlMqwTqpE3uSs2
        jlrxJ3TJ7l7lUZ5+WfD+3rZ/+3THAZsRtw==
X-Google-Smtp-Source: AJdET5eVYaTveFIRw4jme2iVKqFWuon1EYbPFJ0Ka/DuNH9AcybiH9vtplABqsJQvMJV87h0efMjbg==
X-Received: by 2002:a9d:6a1a:: with SMTP id g26mr4402121otn.172.1541066295835;
        Thu, 01 Nov 2018 02:58:15 -0700 (PDT)
Received: from [100.146.196.109] ([172.56.6.91])
        by smtp.gmail.com with ESMTPSA id 96sm773549ota.28.2018.11.01.02.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 02:58:14 -0700 (PDT)
Date:   Thu, 01 Nov 2018 10:58:09 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20181101070652.jrc3jgdmykc27t4w@yavin>
References: <20181029175322.189042-1-dancol@google.com> <20181029192250.130551-1-dancol@google.com> <20181101070036.l24c2p432ohuwmqf@yavin> <20181101070652.jrc3jgdmykc27t4w@yavin>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2] Minimal non-child process exit notification support
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Colascione <dancol@google.com>
CC:     linux-kernel@vger.kernel.org, timmurray@google.com,
        joelaf@google.com, Joel Fernandes <joel@joelfernandes.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <09DBEEE6-57B8-4DA8-9C2B-4B19FDD53F04@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 1, 2018 8:06:52 AM GMT+01:00, Aleksa Sarai <cyphar@cyphar=2Ecom=
> wrote:
>On 2018-11-01, Aleksa Sarai <cyphar@cyphar=2Ecom> wrote:
>> On 2018-10-29, Daniel Colascione <dancol@google=2Ecom> wrote:
>> > This patch adds a new file under /proc/pid, /proc/pid/exithand=2E
>> > Attempting to read from an exithand file will block until the
>> > corresponding process exits, at which point the read will
>successfully
>> > complete with EOF=2E  The file descriptor supports both blocking
>> > operations and poll(2)=2E It's intended to be a minimal interface for
>> > allowing a program to wait for the exit of a process that is not
>one
>> > of its children=2E
>> >=20
>> > Why might we want this interface? Android's lmkd kills processes in
>> > order to free memory in response to various memory pressure
>> > signals=2E It's desirable to wait until a killed process actually
>exits
>> > before moving on (if needed) to killing the next process=2E Since the
>> > processes that lmkd kills are not lmkd's children, lmkd currently
>> > lacks a way to wait for a process to actually die after being sent
>> > SIGKILL; today, lmkd resorts to polling the proc filesystem pid
>> > entry=2E This interface allow lmkd to give up polling and instead
>block
>> > and wait for process death=2E
>>=20
>> I agree with the need for this interface (with a few caveats), but
>there
>> are a few points I'd like to make:
>>=20
>>  * I don't think that making a new procfile is necessary=2E When you
>open
>>    /proc/$pid you already have a handle for the underlying process,
>and
>>    you can already poll to check whether the process has died
>(fstatat
>>    fails for instance)=2E What if we just used an inotify event to tell
>>    userspace that the process has died -- to avoid userspace doing a
>>    poll loop?
>>=20
>>  * There is a fairly old interface called the proc_connector which
>gives
>>    you global fork+exec+exit events (similar to kevents from FreeBSD
>>    though much less full-featured)=2E I was working on some patches to
>>    extend proc_connector so that it could be used inside containers
>as
>>    well as unprivileged users=2E This would be another way we could
>>    implement this=2E
>>=20
>> I'm really not a huge fan of the "blocking read" semantic (though if
>we
>> have to have it, can we at least provide as much information as you
>get
>> from proc_connector -- such as the exit status?)=2E Also maybe we
>should
>> integrate this into the exit machinery instead of this loop=2E=2E=2E
>
>In addition, given that you've posted two patches in the similar vein
>but as separate patchsets -- would you mind re-sending them as a single
>patchset (with all the relevant folks added to Cc)?

Please make sure to run get_maintainers=2Epl against your patches
if you haven't already done so to make sure that the right people are=20
Cc'ed=2E
I would suggest to a least Cc Eric, Serge, Andy, Kees, and Oleg=2E

>
>If the idea is to extend /proc/$pid to allow for various
>fd-as-process-handle operations (which I agree with in principle), then
>they should be a single patchset=2E I'm also a bit cautious about how
>many procfiles the eventual goal is to add=2E

