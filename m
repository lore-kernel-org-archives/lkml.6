Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B172C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DF220664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EjfGd5dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DF220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbeJaXl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:41:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41629 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbeJaXl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:41:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so9012450ljb.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/TxP1yzwS9JKT/Ffr9q+gerXPK3mw3wPeLnkm/RcNtc=;
        b=EjfGd5dtlN1TJvN4s7A2+CljT+7l8I9arV+J3SEl8HrG1r2QkggzVzIYwBpjwGbRN+
         uCxCPO248IeerJQwPE5ibW8PXvNgYRn7kd8uH+4rP7XX8GlS3SO/KbFi7v5Zvc11ShGV
         dWBeiRKlKDDIZ7Ud533lKgtdB1X2MaZDBIlrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/TxP1yzwS9JKT/Ffr9q+gerXPK3mw3wPeLnkm/RcNtc=;
        b=Onb9lL7hhhLXvY9C/0G8ccq3qahJ09cRGQKkciXH486lPCC9QANYTdVxcJ1+/ugQA7
         Y4eKYzzWIqCc95wD3uDL7NyUpub+FcwxncNklDfABMIC2pp/E9fbYogVUJ99yRbBgxMJ
         RtRjmFpQUgJ89nCldqyyUZU9mjK07OuMTxtc28ZXomRVdXMVDDAA5tjBqTqVzemXpF6H
         7ZqP2kWbrK3fc971Ahg4roFXJbJVhOENLGuHRfGVegozf1vIGmSKcjTTF/VJs2ftVDy1
         1/1rpmfuAQvVGAhLJNtnWeVuhkrICkjEhCHyUlIEhi3EXpAynpuoOyNu6l+2dat4bWw+
         ybEg==
X-Gm-Message-State: AGRZ1gKt8thHHoKf/K6lD1lZaWWQjitKR0jKEBObMGOmo/76s2eBSGG5
        +2L5bCEcuMXhap3ZRFaMG2wEjGY0+2+bC/zVWejy6Q==
X-Google-Smtp-Source: AJdET5eS2WlJetVhKJ5mg/nos7uv1eaXbPqljZ6QirwDhBOISw3xY+8oFrHviwLMpzj1PCpNPqjVsn0AC0rKPoxKN1w=
X-Received: by 2002:a2e:4811:: with SMTP id v17-v6mr2213899lja.151.1540997015482;
 Wed, 31 Oct 2018 07:43:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:650a:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 07:43:34
 -0700 (PDT)
In-Reply-To: <CAEXW_YS-nTccFtuE9DMkFYA7wXAfeRHt7v4KSZcXMWVYKm+Uyg@mail.gmail.com>
References: <20181029175322.189042-1-dancol@google.com> <4beaaae77bea4cc5b4cc15504331c9a9@AcuMS.aculab.com>
 <CAKOZuetR6_ztfJOe4TMVCX2J5sfuP8XBtG66hmsDkx-KH=CpJw@mail.gmail.com>
 <4ed9af67cf4a46708905d3f392344bcb@AcuMS.aculab.com> <CAEXW_YS-nTccFtuE9DMkFYA7wXAfeRHt7v4KSZcXMWVYKm+Uyg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 31 Oct 2018 07:43:34 -0700
Message-ID: <CAEXW_YQkVZ3w1oJ+sgmR_YZSHh2gKzAZ=euirHirqz4WxMWt9A@mail.gmail.com>
Subject: Re: [RFC PATCH] Minimal non-child process exit notification support
To:     David Laight <David.Laight@aculab.com>
Cc:     Daniel Colascione <dancol@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "timmurray@google.com" <timmurray@google.com>,
        "joelaf@google.com" <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 7:41 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
[...]
>>> > Indeed, to avoid killing the wrong process you need to have opened
>>> > some node of /proc/pid/* (maybe cmdline) before sending the kill
>>> > signal.
>>>
>>> The kernel really needs better documentation of the semantics of
>>> procfs file descriptors. You're not the only person to think,
>>> mistakenly, that keeping a reference to a /proc/$PID/something FD
>>> reserves $PID and prevents it being used for another process. Procfs
>>> FDs do no such thing. kill(2) is unsafe whether or not
>>> /proc/pid/cmdline or any other /proc file is open.
>>
>> Interesting.
>> Linux 'fixed' the problem of pid reuse in the kernel by adding (IIRC)
>> 'struct pid' that reference counts the pid stopping reuse.
>
> This is incorrect if you mean numeric pids. See the end of these
> comments in include/linux/pid.h . A pid value can be reused, it just
> works Ok because it causes a new struct pid allocation. That doesn't
> mean there isn't a numeric reuse. There's also no where in pid_alloc()
> where we prevent the numeric reuse AFAICT.

Bleh, I mean alloc_pid().
