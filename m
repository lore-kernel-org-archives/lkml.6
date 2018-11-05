Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC6EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9E12086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6sG0Pfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9E12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeKETn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:43:57 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36630 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKETn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:43:57 -0500
Received: by mail-io1-f65.google.com with SMTP id o19-v6so6095379iod.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 02:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w15E3c8SMZsJ/F1WinT2KEMQjbVb5mAroRknBXRBWbc=;
        b=R6sG0PfcQtuEhl7dzff/oz1/UVaZ9Uk8aB40riW3bsTDn9/vi27l71ppr3m12B7nsD
         TEn0AoeDtt9W6XhkNiJbLRHp8w+PxMg9YFl4IO3+Tg/z2Gc6czgXAHoku4HzhxhwJ0dU
         mmulsyUnDJD7912VwAZnDYrwS6Ge+7KT5ntsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w15E3c8SMZsJ/F1WinT2KEMQjbVb5mAroRknBXRBWbc=;
        b=IldCOdJF/BHHvwN/yiS8hWupJC8ms8d4471fJtjrhOgUa1WQdzBxejfJHrOmV0w12L
         E9vGRusef0UVSSc9jt4sAgWfZFgOEzDBkqvKRo3XbgdyVUrOuqWwUzFLwbJ92nq9s1lh
         pILRsiquUA4zScLvGmaXdwCxlHPy870eaWXEM+tejjoLW0Ra8iBXnnc0TZSdTR1LGDy/
         Z/pR0RiVJd+C2Hbid7bEZbzHhs3SSBaLApI9XjVX7DLyn5GXj0o2CJceQ2f6L0qmYMJR
         kYqSOAALgCjWlKdkHcmMYgNMNiD2UJEen47QP8cr3t9+9G6Wk0/2gvHZ34iffNl+uVqB
         Kd5A==
X-Gm-Message-State: AGRZ1gIYKvjW/CDeWHD9QANwNtnF4yp5a6zf2x78LRgv47TsZY0NZXOs
        AxbxJ7yfderXUnsS1F5zQD6/NW9VP7jDSPxZ1KmKKg==
X-Google-Smtp-Source: AJdET5fIIOigEkin1WOcYg7Pgq77oryicsjKMGi1NyY88KzIkOg4I9G0p+0awvRv7fqcOkBGNt3lC6uifLqg/+ZM2Ck=
X-Received: by 2002:a6b:5d18:: with SMTP id r24-v6mr16722224iob.170.1541413496182;
 Mon, 05 Nov 2018 02:24:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 02:24:55 -0800 (PST)
In-Reply-To: <CAK7LNASzscQaUYh=ved3UHajsyOWHJwFp8fVS3aOQn_n+WBybg@mail.gmail.com>
References: <20181103201504.29413-1-ard.biesheuvel@linaro.org> <CAK7LNASzscQaUYh=ved3UHajsyOWHJwFp8fVS3aOQn_n+WBybg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 11:24:55 +0100
Message-ID: <CAKv+Gu-k7Qy-HuEb9jGuC-Aq1TO7aO8NCwMDLgpK99uaah-msQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "kbuild: add --include-dir flag only for
 out-of-tree build"
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Riku Voipio <riku.voipio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 November 2018 at 08:57, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Ard,
>
>
> On Sun, Nov 4, 2018 at 5:15 AM Ard Biesheuvel <ard.biesheuvel@linaro.org>=
 wrote:
>>
>> This reverts commit 80463f1b7bf9f822fd3495139bcf3ef254fdca10, because
>> it breaks the bindeb-pkg build target in the following way:
>>
>>   ...
>>     LD [M]  sound/soc/rockchip/snd-soc-rk3399-gru-sound.ko
>>     LD [M]  sound/soc/rockchip/snd-soc-rockchip-pcm.ko
>>     LD [M]  sound/soc/rockchip/snd-soc-rockchip-rt5645.ko
>>     LD [M]  sound/soc/rockchip/snd-soc-rockchip-spdif.ko
>>     LD [M]  sound/soc/sh/rcar/snd-soc-rcar.ko
>>    fakeroot -u debian/rules binary
>>   make KERNELRELEASE=3D4.19.0-12677-g19beffaf7a99-dirty ARCH=3Darm64 KBU=
ILD_SRC=3D intdeb-pkg
>>   /bin/bash /home/ard/linux/scripts/package/builddeb
>>   Makefile:600: include/config/auto.conf: No such file or directory
>>   ***
>>   *** Configuration file ".config" not found!
>>   ***
>>   *** Please run some configurator (e.g. "make oldconfig" or
>>   *** "make menuconfig" or "make xconfig").
>>   ***
>>   make[12]: *** [syncconfig] Error 1
>>   make[11]: *** [syncconfig] Error 2
>>   make[10]: *** [include/config/auto.conf] Error 2
>>   make[9]: *** [__sub-make] Error 2
>>   cp: cannot stat '/home/ard/linux/scripts/kconfig/Makefile:69: recipe f=
or target '\''syncconfig'\'' failed'$'\n''/home/ard/linux/Makefile:544: rec=
ipe for target '\''syncconfig'\'' failed'$'\n''Makefile:640: recipe for tar=
get '\''include/config/auto.conf'\'' failed'$'\n''Makefile:15: recipe for t=
arget '\''__sub-make'\'' failed': No such file or directory
>>   /home/ard/linux/scripts/package/Makefile:83: recipe for target 'intdeb=
-pkg' failed
>>   make[8]: *** [intdeb-pkg] Error 1
>>   /home/ard/linux/Makefile:1399: recipe for target 'intdeb-pkg' failed
>>   make[7]: *** [intdeb-pkg] Error 2
>>   Makefile:152: recipe for target 'sub-make' failed
>>   make[6]: *** [sub-make] Error 2
>>   Makefile:15: recipe for target '__sub-make' failed
>>   make[5]: *** [__sub-make] Error 2
>>   debian/rules:7: recipe for target 'binary-arch' failed
>>   make[4]: *** [binary-arch] Error 2
>>   dpkg-buildpackage: error: fakeroot -u debian/rules binary gave error e=
xit status 2
>>   /home/ard/linux/scripts/package/Makefile:79: recipe for target 'bindeb=
-pkg' failed
>>   make[3]: *** [bindeb-pkg] Error 2
>>   /home/ard/linux/Makefile:1399: recipe for target 'bindeb-pkg' failed
>>   make[2]: *** [bindeb-pkg] Error 2
>>   Makefile:152: recipe for target 'sub-make' failed
>>   make[1]: *** [sub-make] Error 2
>>   Makefile:15: recipe for target '__sub-make' failed
>>   make: *** [__sub-make] Error 2
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
>
>
> Sorry for the breakage, and thanks for your report.
>
> I'd like to fix the root cause in the builddeb script
> instead of the revert.
>

Sure, that makes sense. I don't understand Kbuild well enough to argue
that, it's just that the reverted patch stated that the --include-dir
argument was apparently unneeded, and I concluded that perhaps that
statement was inaccurate.
