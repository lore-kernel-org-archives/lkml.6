Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA31EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEE420828
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 12:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeLaMaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 07:30:04 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41248 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbeLaMaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 07:30:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so29127240qtf.8;
        Mon, 31 Dec 2018 04:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyBGgV7y89Nappfs2uMQN0NgbtoaB2ye+s9iy3PwtU0=;
        b=KUBewGfXLqjRygbUbvaf2qYTW9hr6ythFGJpADVltwARzL/r78FJ5RvmE93LgZLRFq
         6Za5RCAqDrSafSW40y+st7CiHs2NJaOsWcbKS8qusjGY19NUs+QL3K8YtF+8femiR50g
         g0Dp0VzaVwMR1SQDubG7KdzesqftjVV4DNeFZZJS0s2O83+X3ECi4Y4cYGUrvrcpWfX5
         bjaavypjQl+7pz8tBe5Ftc/D16XJ68INYUkw0jkmtux3iCbymliFiXILePnlL+my7SDN
         C/u9AsgX21W/xqLkzCfaY1bp/MW7bRnCF+frHNhEJbkkAGG2V6Qr7GHdo8PrMM0YAh47
         +1kg==
X-Gm-Message-State: AJcUukf8SNHpmB6+0nl6xlVMQ74PLlY+B2GdUfDyD7ps6qX0U51l+cTD
        XCn7rkc9eLJvhpidLtUkRunZQHy/TQgRm/XYUJQ=
X-Google-Smtp-Source: ALg8bN78nzpr6RAfn9K/xDHDkUTXDA60lmFIoF+U5fm48QizoiYb4CvGD9Nx9cJscaTquq2Gl/bPgkBR7DJoywRiZWc=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr8484244qtl.343.1546259402640;
 Mon, 31 Dec 2018 04:30:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <7e8eb87ea829c03941c895c968df2ebd0f80512f.1545784679.git.fthain@telegraphics.com.au>
 <20181229180236.Horde.idY3gOIzkSWywjIrqlXJMA1@messagerie.si.c-s.fr> <alpine.LNX.2.21.1812301024400.215@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812301024400.215@nippy.intranet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Dec 2018 13:29:46 +0100
Message-ID: <CAK8P3a3645im4aFDi2mNjwcCe=jvmDLkKK_ZSwG1POOLUq=+QQ@mail.gmail.com>
Subject: Re: [PATCH v8 20/25] powerpc, fbdev: Use arch_nvram_ops methods
 instead of nvram_read_byte() and nvram_write_byte()
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     LEROY Christophe <christophe.leroy@c-s.fr>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 12:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:

>
> Is there some benefit, or is that just personal taste?
>
> Avoiding changes to call sites avoids code review, but I think 1) the
> thinkpad_acpi changes have already been reviewed and 2) the fbdev changes
> need review anyway.
>
> Your suggesion would add several new entities and one extra layer of
> indirection.
>
> I think indirection harms readability because now the reader now has to go
> and look up the meaning of the new entities.
>
> It's not the case that we need to choose between definitions of
> nvram_read_byte() at compile time, or stub them out:
>
> #ifdef CONFIG_FOO
> static inline unsigned char nvram_read_byte(int addr)
> {
>         return arch_nvram_ops.read_byte(addr);
> }
> #else
> static inline unsigned char nvram_read_byte(int addr) { }
> #endif
>
> And I don't anticipate a need for a macro here either:
>
> #define nvram_read_byte(a) random_nvram_read_byte_impl(a)
>
> I think I've used the simplest solution.

Having the indirection would help if the inline function can
encapsulate the NULL pointer check, like

static inline unsigned char nvram_read_byte(loff_t addr)
{
       char data;

       if (!IS_ENABLED(CONFIG_NVRAM))
                 return 0xff;

       if (arch_nvram_ops.read_byte)
                 return arch_nvram_ops.read_byte(addr);

       if (arch_nvram_ops.read)
                 return arch_nvram_ops.read(char, 1, &addr);

      return 0xff;
}

(the above assumes no #ifdef in the structure definition, if you
keep the #ifdef there they have to be added here as well).

      Arnd
