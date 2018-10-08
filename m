Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84084C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AF021479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKBGTU1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AF021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeJIEQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:16:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39052 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIEQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:16:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id e22-v6so15438128qto.6;
        Mon, 08 Oct 2018 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAQejBmhV/J63AbIu0NHADuMhG0c7IxLW0vdcXWmnEw=;
        b=VKBGTU1fTZmhMe0T9u8pLQk2E8h7ILEMBvFDHrPODR6fDPNHLOXqLSfz3jT8wnig9M
         3P3o6+KGo57eta01igJDjLAAD0HvXLeBkUFYrFW5OmYomwPS8NnqgsZ+hpURDISD8I2t
         KWrL9GUCVePBDcfQFvr14pqwPXz6xw69oqXSvFG98qXAfVQpZJ4XtrBckIiz9i4GpZX3
         MIULv93sCISBcv6OraiMKXbNI4de4Xv1ibkFBqLeb6HSXOdnduttca7HssAVafI+WFeH
         14X9osiM2JMl/pC0YR9rMY2SGwzmaS50SORuPGwoaxPH1pjwt36PueWvj+ywf3cXmvVa
         7WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAQejBmhV/J63AbIu0NHADuMhG0c7IxLW0vdcXWmnEw=;
        b=OKrAnzFouul4lUgfUszibdYJnqlj3dcmAhX4D4YLQd91deeIjTPK+jmKyH4xedx48t
         NYoZTW6Cj2bXvLlW0AnqfgHKx/VKHT3G/UnzkXOFWefqwIMxzDkr/kV2OsvKgXcDiMzD
         4GTZzhTl876mkcF6qQiU99NFmQbgR0etw8IcOtNpycZGVlt5bm7BrPEZSwNZECQjIpwp
         VHq0BA12SUrknu/dfgO2fZ/3/jmdv/hLKvpqzNTCV5i03JZ46h+VLIeCzWmK4KSVhNtd
         076kBDvn2fxw4O4F12t/1RdJ32m9kxbiZupPQsMUaZNcuBd9MmUph5AbIv8/NZg3I2rX
         NQzg==
X-Gm-Message-State: ABuFfoj3I5h9FiwBPv1U52Lh8j9JoyQgoJG3hX8Ppn1x08kcyz6NnTFL
        m4tFFL813O9KzorflzBHiUtYyPpxwwTuM0dhWQw=
X-Google-Smtp-Source: ACcGV61fn+gfTQt02CtEMAQHk7TtOrJcFwkQflKqBR3YTtZR7VFlZ+Sxilnlne7bzoPT+By0CC34Hg2E3CEahAtKtos=
X-Received: by 2002:ac8:1793:: with SMTP id o19-v6mr20751511qtj.98.1539032579304;
 Mon, 08 Oct 2018 14:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181008082259.26742-1-jolsa@kernel.org> <20181008082259.26742-2-jolsa@kernel.org>
In-Reply-To: <20181008082259.26742-2-jolsa@kernel.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 8 Oct 2018 14:02:48 -0700
Message-ID: <CAPhsuW5n5fFxgomF-HipYm9CYfoAJ1D2To2Q5yoYQuY6jPc-qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] bpftool: Allow add linker flags via EXTRA_LDFLAGS variable
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 1:23 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding EXTRA_LDFLAGS allowing user to specify extra flags
> for LD_FLAGS variable. Also adding LDFLAGS to build command
> line.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/bpf/bpftool/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 5bfa07e3f2f7..dac7eff4c7e5 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -49,6 +49,9 @@ CFLAGS += -DBPFTOOL_VERSION='"$(BPFTOOL_VERSION)"'
>  ifneq ($(EXTRA_CFLAGS),)
>  CFLAGS += $(EXTRA_CFLAGS)
>  endif
> +ifneq ($(EXTRA_LDFLAGS),)
> +LDFLAGS += $(EXTRA_LDFLAGS)
> +endif
>
>  LIBS = -lelf -lbfd -lopcodes $(LIBBPF)
>
> @@ -94,7 +97,7 @@ $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
>         $(QUIET_CC)$(COMPILE.c) -MMD -o $@ $<
>
>  $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
> -       $(QUIET_LINK)$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
> +       $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
>
>  $(OUTPUT)%.o: %.c
>         $(QUIET_CC)$(COMPILE.c) -MMD -o $@ $<
> --
> 2.17.2
>
