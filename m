Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C45C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081C82073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081C82073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeH3NCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:02:06 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41135 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeH3NCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:02:06 -0400
Received: by mail-ua1-f66.google.com with SMTP id h1-v6so5034931uao.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 02:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7GdStdVZ61WQWNBEbsx78J9iJEIR/mwJ6ziO8EYMKjw=;
        b=PRXdzUtRGhJicsozzlNvGBqc5ceWdGz5btwNAWL2F12Zy1fFPTfVL/Tj6Qhbo90q7s
         U9MbuRkfDWSpNkU9M9i2G/wHCR7FvL0LHvYuMbxCccq/kJho9WyBKe9UT+8WmQqncr0w
         8wP7zuJOsEhUleNfseg6MUwqpLj0YkJT3RbffWXMD3pFVW56kJ2CTxZFNKgZz6BhsiyN
         8KZXZRzTRFoAUDNfUq9+m1GJCCgGQv7lUU5p4dobEVfRLdqj19gn95rOsPa6tnRzaX7H
         ox3W963K9+F6Pdph1oDaUq85g+o8LsQxlD5eWabjVKaUOKCzc17Cso8D08jX8y/o9QfN
         fqAQ==
X-Gm-Message-State: APzg51C4V2n07E4vDwDX7MQC6VLJ/w4nl932ae4MSXJwzpSpVSj8SalI
        eCIhXk9fe3a1vwJlsoHgAb49wd4hNwzNnfhin4c=
X-Google-Smtp-Source: ANB0VdZvwA9wCTDYrgDbvrtuxZ1zxzia4sJUjCJ5ZGeyZ7zPh3A1eWCZBYq31Fv/8No16DmjQ8Cl2D6Hq2Ts6BPw4V8=
X-Received: by 2002:a67:3481:: with SMTP id m1-v6mr33647vsi.52.1535619658867;
 Thu, 30 Aug 2018 02:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <1535502826-23856-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1535502826-23856-1-git-send-email-linux@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Aug 2018 11:00:47 +0200
Message-ID: <CAMuHMdV5_n=HqkBTZHZbpgzjoZD0_rmfxcT7GiGOpFxyZyiJ7A@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Do not overwrite initrd_start and initrd_end
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Wed, Aug 29, 2018 at 2:34 AM Guenter Roeck <linux@roeck-us.net> wrote:
> setup_initrd() overwrites initrd_start and initrd_end if __initramfs_size
> is larger than 0, which is always true even if there is no embedded
> initramfs. This prevents booting qemu with "-initrd" parameter.
> Overwriting initrd_start and initrd_end is not necessary since
> __initramfs_start and __initramfs_size are used directly in

... since commit df52092f3c977885 ("fastboot: remove duplicate
unpack_to_rootfs()")...

To avoid -stable backporting this beyond v2.6.30 ;-)

> populate_rootfs() to load the built-in initramfs, so just drop
> that code.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
