Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15217C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3736204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Utd1j63T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3736204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeK1LiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:38:02 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39453 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1LiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:38:02 -0500
Received: by mail-yb1-f195.google.com with SMTP id w17-v6so9905347ybl.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PQsHGbA5NWVnXDPjlAV1PqxNrT/3zqLPuYa2ECk7n0A=;
        b=Utd1j63TPUw8k2ychCf0XbqroL+hgGcmfQggSiAIWrM9JJ08zKkWnRP42QUEPYnnBS
         gT3Bfypwsi1dRdh/cTFm2eJp26D6OwBOqOIV7Z+Htl7h4owZ0GIgJyjUYIfcQ7If86mc
         F0Fj0h5Y9VFXocwaz8gpZDhIB/bxHDCtnWYFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PQsHGbA5NWVnXDPjlAV1PqxNrT/3zqLPuYa2ECk7n0A=;
        b=croHE3BMoycPozg0Yz1dwYo75IxTthAc2zaxCfdDij3nmj+RO5iGpMRIyYO4HLVlOz
         R10WPBPipBYLZr3EepBB9TLnfnQVVhxeuWBjVdLlfCo929eUHCUdgJnhM8Fz4AVWRGjo
         51pMVUtdIswf2Z1HvBUGU9G4XQG71MbF0xF3oETlOPg8dfgAagv041HTJgkjqkuZYkut
         bZVAhKSh1TBc7CdGkB9IpMuJkCAoCbC2Yh1eO9p3kXzmEV0eie1V7SY+LK5DpLU4foYg
         TcTS3uhJf0cngRVj/JWve8JTzGChlYpTyiZS3/a5XmEodzYrVTucs1lPgHAgUPfSmevT
         /0Zw==
X-Gm-Message-State: AA+aEWbmMsYFMGtxj5SAlv4CypDfZuE6u4DcjFypKXj1aReGAO3XuqP4
        P9tsUO2GHotrmvkPoH/RACCXTPkZPx8=
X-Google-Smtp-Source: AFSGD/USU3nkS8tj26P3w3eupuOTKp0snWVoj+R7RC70Hys9z9v7OqtDEbTGiEXvOgPF9zi7fpg5kw==
X-Received: by 2002:a25:e64b:: with SMTP id d72-v6mr35262128ybh.268.1543365501179;
        Tue, 27 Nov 2018 16:38:21 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id c127sm1374071ywb.67.2018.11.27.16.38.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 16:38:20 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id z2-v6so9916235ybj.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:38:19 -0800 (PST)
X-Received: by 2002:a25:a22a:: with SMTP id b39-v6mr22337077ybi.209.1543365499517;
 Tue, 27 Nov 2018 16:38:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 16:38:18
 -0800 (PST)
In-Reply-To: <20181127232126.GA23658@cisco>
References: <20181112171144.GI3645@cisco> <87efbqi1xa.fsf@xmission.com>
 <20181112185538.GK3645@cisco> <20181112192443.GL3645@cisco> <20181127232126.GA23658@cisco>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 16:38:18 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
Message-ID: <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
Subject: Re: siginfo pid not populated from ptrace?
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 3:21 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Mon, Nov 12, 2018 at 12:24:43PM -0700, Tycho Andersen wrote:
>> On Mon, Nov 12, 2018 at 11:55:38AM -0700, Tycho Andersen wrote:
>> > I haven't manage to reproduce it on stock v4.20-rc2, unfortunately.
>>
>> Ok, now I have,
>>
>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1493) == info._sifields._kill.si_pid (0)
>> global.syscall_restart: Test failed at step #22
>
> Seems like this is still happening on v4.20-rc4,
>
> [ RUN      ] global.syscall_restart
> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1901) == info._sifields._kill.si_pid (0)
> global.syscall_restart: Test failed at step #22

This fails every time for me -- is it still racey for you?

I'm attempting a bisect, hoping it doesn't _become_ racey for me. ;)

-- 
Kees Cook
