Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D29BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E3F20657
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R5UJZGIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E3F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeIYXbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:31:55 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38704 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeIYXbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:31:55 -0400
Received: by mail-yb1-f195.google.com with SMTP id e190-v6so10103886ybb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MCW0baKYvvIhFuAyH5M6200iBGENP0X2GXDwli/f644=;
        b=R5UJZGIaGUjUzgkL5g7WUONTVvWKZ5pJjCQRJAZ5HeoLa7vTTrtoY05Km0sdVpa2nF
         FrSdU2Gp14R10kGdH5T7tRL9LFSb8Jfee8WyBL7H6ikMOLww/UwGGPB9OthC5hSPKyvA
         kkGkwsvVVQB/uWsl6vmR6/efzTgJ+8S5tb2ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MCW0baKYvvIhFuAyH5M6200iBGENP0X2GXDwli/f644=;
        b=QhL6yGnGt1t93fvH7JzWjc6oxJHyCpkrqobzsyefQ5OVuLRADlFMjKc2RajZRc8T1Q
         szpxvurshfkGoJbAvnIP6ERPsuTQZJyQ0F6IABNl8NzYmSobY2bwGYssFrcEinYd9HVQ
         zzVjg7PyP3SpXsCiJykOu4zimKso+8S6zB1JjhfYEvWfkD4OY61cJEc63JfXQNGQE+wU
         7IFK8dyySNGTJJ7h4E4Fyl3ZdPjPZCOSpbkXRE/pLEZmkPNAnD/B9J8kCFo4umnPKBlz
         8kLGnIkfkQT1moEXD2bu7i0+DSn/lVs9CK7zo5VkU67Cg78Nne+zSfgplZ4RrbjS5mOf
         9pLQ==
X-Gm-Message-State: ABuFfogUEwAOVxjw9F4hDpu+DYmq6yaJRib1q3xwgmi5pxOgqAom6DE9
        PL36soZjlO3qLYSU/WnfGBZY7yreshs=
X-Google-Smtp-Source: ACcGV63dFfeOWTQM5GYAcjUxYev99KSu8h8JK0c2Ow9IB2GJ8nwdUaqBndsp9yKAb+JFYjXiQT3gdA==
X-Received: by 2002:a25:3602:: with SMTP id d2-v6mr1175039yba.377.1537896204832;
        Tue, 25 Sep 2018 10:23:24 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id f194-v6sm3587310ywb.31.2018.09.25.10.23.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:23:22 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id k66-v6so4050656ywa.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:23:21 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr484181ywf.237.1537896201570;
 Tue, 25 Sep 2018 10:23:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 10:23:20
 -0700 (PDT)
In-Reply-To: <CAK8P3a3TMUbqLtde-wJyvF+H31VTPQwCKCqPjf41dwGMK-vbQg@mail.gmail.com>
References: <20180823024051.GC13343@shao2-debian> <20180823041434.GC3677@linux-r8p5>
 <20180824030920.GD3677@linux-r8p5> <CAK8P3a3TMUbqLtde-wJyvF+H31VTPQwCKCqPjf41dwGMK-vbQg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 25 Sep 2018 10:23:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKv_FHPOwy9q_3szHBz5XPPfLWCSwYax=cHU1nHze-U5A@mail.gmail.com>
Message-ID: <CAGXu5jKv_FHPOwy9q_3szHBz5XPPfLWCSwYax=cHU1nHze-U5A@mail.gmail.com>
Subject: Re: [PATCH] ipc/shm: properly return EIDRM in shm_lock()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, dbueso@suse.de,
        Manfred Spraul <manfred@colorfullife.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 5:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Aug 24, 2018 at 5:09 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>>
>> When getting rid of the general ipc_lock(), this was missed
>> furthermore, making the comment around the ipc object validity
>> check bogus. Under EIDRM conditions, callers will in turn not
>> see the error and continue with the operation.
>>
>> Fixes: 82061c57ce9 (ipc: drop ipc_lock())
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>> ---
>
> Oddly, this change introduces a gcc warning in some configurations
> (i.e. with randstruct enabled):
>
> ipc/shm.c: In function 'shm_lock':
> ipc/shm.c:209:9: note: randstruct: casting between randomized
> structure pointer types (ssa): 'struct shmid_kernel' and 'struct
> kern_ipc_perm'
>   return (void *)ipcp;
>          ^~~~~~~~~~~~
>
> Not sure why we didn't see that warning before, probably
> it ended up making its own thing when the return code
> was uninitialized.

The fix is already queued up in mmotm:

https://www.ozlabs.org/~akpm/mmotm/broken-out/ipc-shm-use-err_cast-for-shm_lock-error-return.patch

randstruct stays quiet about ERR_PTR-family casts since they're not
"real" casts to a functional struct.

-Kees

-Kees

-- 
Kees Cook
Pixel Security
