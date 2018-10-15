Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710F5C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394F1208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeqKDFx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394F1208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeJPCIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:08:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39935 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeJPCIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:08:11 -0400
Received: by mail-lf1-f68.google.com with SMTP id n14-v6so2970579lfe.6;
        Mon, 15 Oct 2018 11:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBr5XUqsXyas7yupfbyrP/dw/1Qz4703WnrB81alYbY=;
        b=SeqKDFx2JjfNUhoQ2iwGrXZqkah4uY4JZm0EI3M41YGdfGohvp1KwJjr9mqRZSw50U
         4P7vItJ+nIYuXATQKIAOU5MJSXHdrUcbTzzJCYh+nTV+84kggIB61D6zneWWlqn57mFc
         tuYTgK5rMH4+50WY7SjiDKh3cHNfA9kheS7R/QB8p9F35Y1Fp72mT4Oj1P7KVfH+qVlG
         a1yZ2XzQySO716QRCX154zKizQxJ/bFbhJE7rrTdHB34xr6RFgr0nlPTEjTb0J16gigb
         c/PUyKLdgdBkPhjctA9XXI8oU6fSGMu/j41rDB3a1GbmmPSed0b3afvuaAlYOr6PbGo1
         e7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBr5XUqsXyas7yupfbyrP/dw/1Qz4703WnrB81alYbY=;
        b=auBeyqn/PlOMJO6ji/jQZuokxIoX2b9bjA9kOgdz20SGjNP8/uLdmLegx2MLzXUfUc
         4DJxvfcP2TwHf7IYGNvIRajBEuuAMgsGR0IljlGYAz9aFTqrl27P/W0csH0ZueekhmTZ
         BgwzozAXaE6WBDNieTWL+9lzz1dbvKve8tvKK+nd3ZTNocZcJyLxjXwyvV+hdwouE42M
         uZ4hCtVZkYbcHYbK5Yy3EQgMq9bBO5r5PU0Cqg4miXz/7cQ4O+D9KeKtxrypFI+23W/8
         0jXfwBmcu37W+cIhKQsqIs8zwIgv3GpOMjsxelnx6BCFvlGnb7tKOMg2wTKwYy4BXZ8N
         /1bA==
X-Gm-Message-State: ABuFfoj6tZzfRtmQFelKEyVe5cZ/a4aPDFhaQsuBr2XZ5LKssgVL61RT
        /QV5p0Fg4122Sx2fWWCmNm89dOe6uXRJ66fQV0s=
X-Google-Smtp-Source: ACcGV63bp/NEuzVmmZXIlyUd0QyHzhiKbhyMogQVjQIYuVpDrBUvtF8QPvxcQANXzIgywVL0x3mTxlGikHsigyzpTH8=
X-Received: by 2002:a19:6b16:: with SMTP id d22-v6mr2030156lfa.49.1539627706933;
 Mon, 15 Oct 2018 11:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181015172221.35709-1-ndesaulniers@google.com>
In-Reply-To: <20181015172221.35709-1-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 15 Oct 2018 20:21:35 +0200
Message-ID: <CANiq72kLs-Z=ZDdWU_1JV-NG+D5yPEfgREny+nXQgPioyOB=mg@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: update definition of unreachable()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     luto@amacapital.net, Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 7:22 PM <ndesaulniers@google.com> wrote:
>
> Fixes the objtool warning seen with Clang:
> arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
> instruction
>
> Fixes commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
> mutually exclusive")
>
> Josh noted that the fallback definition was meant to work around a
> pre-gcc-4.6 bug. GCC still needs to work around
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365, so compiler-gcc.h
> defines its own version of unreachable().  Clang and ICC can use this
> shared definition.

Could we, at the same time, update the comment on compiler-gcc.h as
well? i.e. remove the 4.5 comment, add the link to the GCC PR.

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/204
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Miguel, would you mind taking this up in your new compiler attributes
> tree?

Sure, will do.

Thanks,

Cheers,
Miguel
