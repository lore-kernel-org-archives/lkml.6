Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D949C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67952077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PTcAWV+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67952077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJLF7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:59:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41036 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeJLF7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:59:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so11344835wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 15:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=qrbJZLRnDoHnNhqD78d+/mxxQv7Wgd2DBrHwNKsUl3I=;
        b=PTcAWV+Gb3XKl6FzeUh190UGL5EzV4nu3CNWSVm6T6IVlli7xaVunF1MmcbDL4cuun
         Z1C+9sFcMtCk8jgiJleVFHsLQnWUMpP9jODQu9/zZlp95X1YsVWhPLsHLSJSDFuGfr36
         qrLNVaASeXejcgcFGhQq9oWd6bnLtY7eIYBThCou8YyLB1XRPj/IZ9jaxbrZnn0d/W9t
         Xc3QjtrOhoz0D6+OlUmLso0l2D3rn/HhFZoZVzPtZZJuc2ZQrVcTo7ESFoxST6BhPZLh
         hNr17TrXwKOMunWV3zM1C+YlWs8Ppr765899xAq7PP/tpByn7TNye9eojqhHdyDjEsXa
         qEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=qrbJZLRnDoHnNhqD78d+/mxxQv7Wgd2DBrHwNKsUl3I=;
        b=DbbPGx+r+dnmaDlN+GxmJZZyij+qPFZVyuDWnLLo26AlHJsZldnLdkyR+1LeGS6g5d
         YCENnY/6MsLysFP4h8F51Mcjdm/5x4vkzxsU2MI3cVFROcnGZFc7y69VGTP/S+7YSECY
         Bd+Rd3d4+fGwCOlJaVX4hgV3kGZCHrQVvZtvQT2StMzb2bNxgtaRB7IoHYqfu2LntZpy
         ZOFK2cS5DYktei05zfjPayZRBy3CyDCGblZeSucqfOX0IR7iblsWLXV9ce5nKjDQwHWc
         vAwA6aZkoqifyAcHKwIB909tkIYwsTwXUbJ+x1t0/iGb/oUQN/rWdjlWYS+nsdHZ5voT
         1FfQ==
X-Gm-Message-State: ABuFfojlxSh1akXPZK9HrirKnGXkj5aWqceCken9KLxSRi4aKGEYxq6q
        clSX+/SoOm8+ZIwcnRC4FM0vjA==
X-Google-Smtp-Source: ACcGV63Bru7sFgAkeASuqCdjk2FXj6wsaeVu1BB6cD1STJx83KDk5aOnEVZGoQSkGMHsDJ1fufhmzw==
X-Received: by 2002:adf:a781:: with SMTP id j1-v6mr3147473wrc.277.1539296979043;
        Thu, 11 Oct 2018 15:29:39 -0700 (PDT)
Received: from ?IPv6:2a02:8070:8895:9700:ad73:df60:fbb0:6de7? ([2a02:8070:8895:9700:ad73:df60:fbb0:6de7])
        by smtp.gmail.com with ESMTPSA id l11-v6sm19885562wrn.61.2018.10.11.15.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 15:29:38 -0700 (PDT)
Date:   Fri, 12 Oct 2018 00:29:35 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGXu5jK0nbBrJF4Vp3yzhwBgGo3vKh8FVo2ZQJMA+Ph3NaGh+Q@mail.gmail.com>
References: <20181011141014.4big6jogmsnx25z5@brauner.io> <CAGXu5jK0nbBrJF4Vp3yzhwBgGo3vKh8FVo2ZQJMA+Ph3NaGh+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: overflow on proc_nr_files
To:     Kees Cook <keescook@chromium.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <B6E895DC-7425-43F4-BB4B-1F8499CCD952@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 11, 2018 7:18:15 PM GMT+02:00, Kees Cook <keescook@chromium=2Eor=
g> wrote:
>On Thu, Oct 11, 2018 at 7:10 AM, Christian Brauner
><christian@brauner=2Eio> wrote:
>> Hey,
>>
>> I've just got pinged by Lennart who discovered that you can get your
>> system into an unuseable state by writing something that exceeds a
>s64
>> into /proc/sys/fs/file-max=2E Say,
>>
>> echo 20000000000000000000 > /proc/sys/fs/file-max
>>
>> which will trigger an overflow and percpu_counter_read_positive()
>will
>> return 0 and cat /proc/sys/fs/file-max will return 0=2E
>>
>> That effectively means you write that number and it succeeds and all
>is
>> well and a few seconds/minutes later your system just dies or gets
>into
>> an unuseable state pretty quickly
>>
>> I wonder if we shouldn't accept overflows or - if we have no way in
>this
>> codepath to detect them - set it to some pre-defined hard-coded
>value=2E
>>
>> Or maybe this is even a known issue and by design but before I work
>on a
>> patch here I just wanted to check=2E
>
>There was work done recently to keep proc_dointvec_minmax from
>wrapping, but it seems that the problem here is that file-max uses
>proc_doulongvec_minmax, so it explicitly thinks it can be larger than
>s64=2E (And max_files itself is unsigned long=2E=2E=2E)
>
>It looks like the counter is expected to be a long, not unsigned:
>
>static long get_nr_files(void)
>{
>        return percpu_counter_read_positive(&nr_files);
>}
>
>And there are places where this goes weird:
>
>                if (percpu_counter_sum_positive(&nr_files) >=3D
>files_stat=2Emax_files)
>
>etc=2E
>
>It seems like maybe the sysctl needs to be explicitly capped in
>kernel/sysctl=2Ec to S64_MAX?

Yeah, either that or (I need to look at the
code again though if that's possible=2E)=20
return EOVERFLOW but provide a way=20
(macro) for userspace to know what the=20
maximum value is that this can be set to=2E

I can send a patch and we can take it=20
from there=2E

