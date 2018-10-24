Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CA7ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F29205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YHPG67L2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F29205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeJYFzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:55:52 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38147 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeJYFzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:55:51 -0400
Received: by mail-yb1-f194.google.com with SMTP id v92-v6so2781878ybi.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 14:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u3MMUBgs+lsDZG/eqkLJuq8RYjlBeGZiaHE/yxUCnxI=;
        b=YHPG67L2fs6lMYJJ84UmE/Ootbj9PMAkfGP35hu5wykOjfCCDeSGZyM31GpMZ5CESf
         kwjBR9aAuqE7WhfORbng3AE+67rNFvvteCRmcNhvTOT/VZso4obNtZ7NTeLxw464CQB7
         ZwJ1Rb9nfNHJU/xsp0HQMrpDjk1sr9b2w58qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u3MMUBgs+lsDZG/eqkLJuq8RYjlBeGZiaHE/yxUCnxI=;
        b=tTH12c1NwZcqs2TOWK8kknnhQVvxIVMm8soVnmz+xDEWySJGJ7JcA5gM2bsRE3wGjD
         6NunfnmYejb+czTstU2RAN6gUAW7mbnSYuVzqdoELzXQY3ZJqaBjYIXaKjeNYAXhWm38
         VSDg+WlHCBKAv5ys6xzf88oljUWDGQuEogPU8pKLLzWuuNZzViMkSqJIGKTAsm1K7dkz
         HIkn629hlbQeXUfeymQorP0HQvB7zhzSdbkjmonE3F8w6ITOpRb6BHD3cqdmpmQOyjve
         i1p46v/DZftlo5f2WELq7aYBdfjv1PhAJDSCiDKVRDICrM74LSiO8u4hByMBNv/LqyRI
         TuLw==
X-Gm-Message-State: AGRZ1gJI6LvBZh2Q1lB5Q7G9QD042WLyjc2IyBJn12vXlEWfeIiZbA8W
        loJ3idV11rzWrIWKIiCwGuIPXK/VfzU=
X-Google-Smtp-Source: AJdET5dMIzpnjVygfa5Earn+ZCAqX6kRsbLOCJV/8OLp1/Om+vtaTs62caQRsRwpWq2nrIsIVdwLRA==
X-Received: by 2002:a5b:787:: with SMTP id b7-v6mr3904846ybq.167.1540416368589;
        Wed, 24 Oct 2018 14:26:08 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id x185-v6sm5319835ywd.40.2018.10.24.14.26.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 14:26:06 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id j9-v6so2781744ybj.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 14:26:06 -0700 (PDT)
X-Received: by 2002:a25:ac8e:: with SMTP id x14-v6mr4134609ybi.141.1540416365577;
 Wed, 24 Oct 2018 14:26:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 14:26:05
 -0700 (PDT)
In-Reply-To: <20181024204036.8799-2-palmer@sifive.com>
References: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
 <20181024204036.8799-1-palmer@sifive.com> <20181024204036.8799-2-palmer@sifive.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Oct 2018 14:26:05 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJxPKcivD6PtK0WwGVphU6Uzj4QAFXrAw52UjUDTZSupw@mail.gmail.com>
Message-ID: <CAGXu5jJxPKcivD6PtK0WwGVphU6Uzj4QAFXrAw52UjUDTZSupw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Move EM_RISCV into elf-em.h
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Wesley Terpstra <wesley@sifive.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Audit <linux-audit@redhat.com>,
        david.abdurachmanov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:40 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
> This should never have been inside our arch port to begin with, it's
> just a relic from when we were maintaining out of tree patches.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/riscv/include/asm/elf.h | 3 ---
>  include/uapi/linux/elf-em.h  | 1 +
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index a1ef503d616e..697fc23b0d5a 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -16,9 +16,6 @@
>  #include <asm/auxvec.h>
>  #include <asm/byteorder.h>
>
> -/* TODO: Move definition into include/uapi/linux/elf-em.h */
> -#define EM_RISCV       0xF3
> -
>  /*
>   * These are used to set parameters in the core dumps.
>   */
> diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
> index 31aa10178335..93722e60204c 100644
> --- a/include/uapi/linux/elf-em.h
> +++ b/include/uapi/linux/elf-em.h
> @@ -41,6 +41,7 @@
>  #define EM_TILEPRO     188     /* Tilera TILEPro */
>  #define EM_MICROBLAZE  189     /* Xilinx MicroBlaze */
>  #define EM_TILEGX      191     /* Tilera TILE-Gx */
> +#define EM_RISCV       243     /* RISC-V */
>  #define EM_BPF         247     /* Linux BPF - in-kernel virtual machine */
>  #define EM_FRV         0x5441  /* Fujitsu FR-V */
>
> --
> 2.18.1
>



-- 
Kees Cook
