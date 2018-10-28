Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4424C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EBE20873
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iC7Ybfpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47EBE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeJ2AbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 20:31:19 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44539 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJ2AbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 20:31:19 -0400
Received: by mail-yb1-f193.google.com with SMTP id p144-v6so2430359yba.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MlKoG8racC4nRmkkYfiWL7HuAIjG/6ZtHxnnrGoaoR0=;
        b=iC7YbfpjmdMzyfzv9T8U3aNMW9jFFBYEUiJl7qiTAFWTjvqlIsGKxuWP0Xgs6zpe2e
         X1TmKo6TVIOOFX+9IgdcBnu04/aGfaF9+EvSHcFJVCfDqb3vUqF0VcCC/+yIKH3avYtL
         WvE8tfStyF5JnVy3Fb4k7U36up9JeDz+PdnzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MlKoG8racC4nRmkkYfiWL7HuAIjG/6ZtHxnnrGoaoR0=;
        b=N/8UWEkVT7B9dFZ82OWqDo0e3t0/po6RVqT2W9ax/xZdHXkDyVcjRdtbs6DTdfa0cQ
         Dm9dIraLOUAUrZ9MID+F7PfLuQ4ohONIr1YWub8UvuC6JDRaPnk/DKcRkmAs+I4d/1p3
         8mrGr7iAjWLc25jQqo56/ckKwCHGzitn2BUSxPiwrE92zpPohV+0T8nVLHo7cxDjGOH5
         MV4zlPN3fmslxlkdB4kZxI7UcW9q4JPT+Gpuk9LLYNCtOMZ9vJ8vRLfOcW3c0A6zmXMP
         emxKTUFSJuXimDpB7BHtIyeW4sWpfRO+6gy4/XP2Z+n70vEoTuJNt7TWk5vXFj5vgFnd
         YWMQ==
X-Gm-Message-State: AGRZ1gJdArjBoRhDWz/x73QxLX29HjrcLxdQKWmYL3NJRTo88JA+CCtN
        GOQwgQj+KN6G4BNRW4pZuvUdVjT1UrQ=
X-Google-Smtp-Source: AJdET5eoVBRL5vRIK0BxS+oUU4LkY60Y2EXdg9PFXVRVGtqNhxkWnRQqvmcHMntTc5xoDSAkAWQxyQ==
X-Received: by 2002:a25:1f44:: with SMTP id f65-v6mr10473050ybf.6.1540741580417;
        Sun, 28 Oct 2018 08:46:20 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id z11-v6sm5434522ywl.36.2018.10.28.08.46.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 08:46:18 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id v1-v6so2391433ywv.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 08:46:18 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr11086819ywf.237.1540741577479;
 Sun, 28 Oct 2018 08:46:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Sun, 28 Oct 2018 08:46:15
 -0700 (PDT)
In-Reply-To: <1540630374669.30217@xiaomi.com>
References: <1540525277916.97809@xiaomi.com> <CAGXu5jJtwLgrMVvXR+C8oSKPus+iVdYsYn4Q2+8FjRbgpL+jNA@mail.gmail.com>
 <1540630374669.30217@xiaomi.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 28 Oct 2018 15:46:15 +0000
X-Gmail-Original-Message-ID: <CAGXu5jJcPh7sSEXNAZpeatqLnvsuySPyYpQvDeP6AXnsxCr_cg@mail.gmail.com>
Message-ID: <CAGXu5jJcPh7sSEXNAZpeatqLnvsuySPyYpQvDeP6AXnsxCr_cg@mail.gmail.com>
Subject: Re: [PATCH] pstore: Remove duplicate invoking of persistent_ram_zap()
To:     =?UTF-8?B?UGVuZzE1IFdhbmcg546L6bmP?= <wangpeng15@xiaomi.com>
Cc:     "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 9:52 AM, Peng15 Wang =E7=8E=8B=E9=B9=8F <wangpeng15=
@xiaomi.com> wrote:
>
>
> ________________________________________
>>From: Kees Cook <keescook@chromium.org>
>>Sent: Friday, October 26, 2018 17:44
>>To: Peng15 Wang =E7=8E=8B=E9=B9=8F
>>Cc: anton@enomsg.org; ccross@android.com; tony.luck@intel.com; linux-kern=
el@vger.kernel.org
>>Subject: Re: [PATCH] pstore: Remove duplicate invoking of persistent_ram_=
zap()
>
>>On Fri, Oct 26, 2018 at 4:41 AM, Peng15 Wang =E7=8E=8B=E9=B9=8F <wangpeng=
15@xiaomi.com> wrote:
>>> From: Peng Wang <wangpeng15@xiaomi.com>
>>>
>>> When initialing przs with invalid data in buffer(no PERSISTENT_RAM_SIG)=
,
>>> function call path is like this:
>>>
>>> ramoops_init_prz ->
>>> |
>>> |-> persistent_ram_new -> persistent_ram_post_init -> persistent_ram_za=
p
>>> |
>>> |--> persistent_ram_zap
>>
>>There does appear to be a duplicate call to persistent_ram_zap() in this =
case.
>>
>>> As we can see, persistent_ram_zap() is called twice.
>>> We can avoid this by removing it in ramoops_init_prz(),
>>>and only call it in persistent_ram_post_init().
>>
>>However, I think the proposed fix doesn't work the way it should.
>>
>>There are two prz init paths: ramoops_init_prz() (a single prz) and
>>ramoops_init_przs (multiple przs). The "dump" and "ftrace" cases use
>>the latter. In those, there is no call to persistent_ram_zap() if the
>>buffer is valid.
>>
>>In other words:
>>
>>ramoops_init_prz() unconditionally calls persistent_ram_zap(). (And
>>may call it twice if there is a mismatch of the magic header.)
>>
>>ramoops_init_przs() only calls persistent_ram_zap() when the magic
>>header is wrong.
>>
>>The proposed patch unconditionally zaps all regions, which means we'd
>>lose "dump" and "ftrace" across the next reboot.
>>
>>Perhaps we could make it an option to persistent_ram_new()?
>>
>>--
>>Kees Cook
>
> Thanks for your reply.
>
> You are right, this patch does zap regions unconditionally when it comes =
to "dump" and
> "ftrace". Sorry for the inconvenience owing to my previous mistake.

No problem at all! I'm glad you started this conversation, since it
was a subtle aspect of the code that I didn't understand until I took
a closer look at it. :)

> I have tried adding an option to persistent_ram_new() according to your a=
dvice and will send
> a V2 version patch later. Could you please kindly pay any attention to it=
? Thank you!

Yes, thanks! I've added Joel to CC as well, since he was doing clean
ups in a related area. I think we'll probably combine the efforts.

-kees

--=20
Kees Cook
