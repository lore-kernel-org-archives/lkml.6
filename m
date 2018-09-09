Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B780DC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 06:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023E320857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 06:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="c82P5mGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023E320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeIILp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 07:45:57 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:22569 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeIILp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 07:45:56 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w896v7gO031414;
        Sun, 9 Sep 2018 15:57:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w896v7gO031414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536476227;
        bh=Xzx7VsIwZHeaHuHcbxdcMrbhrME9Foz4oSH1s6nVkL4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=c82P5mGZLGladWJSJ+XPGFyJRzHRJgfcIgUJB2pvw4Zq7ThUUiks+SbDpNzsw7Bxi
         YvarrjT5HrelbtVGIVemhNco+2wbGVoaTgjV8nu9dwhi8CpWsv5tZffxmR/ZHjfDiP
         M3/TYHmjnWtE30ghdszaSPEtmCzVtGDzmWL7zMP2ve6mGDdUZ9xRBqnaJ9XEqaxUQF
         SY6rLa1WO6IANhetIiPd5eQ0tus6F3IgyjPS0INffsC1VrmcW5M6h9uCvf+mvWjG9A
         +0IAqwsoG/gxz3nl99AgwZ1qkpZs22rpxEvE2o/IZ2kQBCN/C+HL+qszohH4wY/mJi
         V3CpPfPMiP9Ww==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id m26-v6so14984618uap.2;
        Sat, 08 Sep 2018 23:57:07 -0700 (PDT)
X-Gm-Message-State: APzg51A6nLwR5WFX3ZXdzhCFcLOUphEqI6jnJj82XzgkYmISKBISEzkS
        9b1fdQaGfQ4pKZMgwKe9U+C3KUxbI3StMvQqUoE=
X-Google-Smtp-Source: ANB0VdaVTCWt9GihvAjnxicmYxaom4Irsh0VmWq2sWUNqrDx+cwrlyaxk/DlKbKSbLFSXaQniPqGlNdcM2Gp4sVYKSc=
X-Received: by 2002:ab0:4ad7:: with SMTP id t23-v6mr4720618uae.35.1536476226591;
 Sat, 08 Sep 2018 23:57:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Sat, 8 Sep 2018 23:56:26 -0700 (PDT)
In-Reply-To: <dde798fd-9fef-6ac0-a3bc-6aa7193c5d89@infradead.org>
References: <dde798fd-9fef-6ac0-a3bc-6aa7193c5d89@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 9 Sep 2018 15:56:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRru9+9_EtNJAgYx-84R7qGt7hNuDqmta5Uk2dJo7CvQ@mail.gmail.com>
Message-ID: <CAK7LNAQRru9+9_EtNJAgYx-84R7qGt7hNuDqmta5Uk2dJo7CvQ@mail.gmail.com>
Subject: Re: [PATCH v2] modules_install: warn when missing System.map file
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-07 8:37 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> If there is no System.map file for "make modules_install",
> scripts/depmod.sh will silently exit with success, having done
> nothing.  Since this is an unexpected situation, change it to
> report a Warning for the missing file.  The behavior is not
> changed except for the Warning message.
>
> The (previous) silent success and new Warning can be reproduced
> by:
> $ make mrproper; make defconfig
> $ make modules; make modules_install
>
> and since System.map is produced by "make vmlinux", the steps
> above omit producing the System.map file.
>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: add Yamada-san's suggestions for >&2 and Skipping depmod.


Applied to linux-kbuild/fixes. Thanks!


>  scripts/depmod.sh |    1 +
>  1 file changed, 1 insertion(+)
>
> --- lnx-419-rc1.orig/scripts/depmod.sh
> +++ lnx-419-rc1/scripts/depmod.sh
> @@ -11,6 +11,7 @@ DEPMOD=$1
>  KERNELRELEASE=$2
>
>  if ! test -r System.map ; then
> +       echo "Warning: modules_install: missing 'System.map' file. Skipping depmod." >&2
>         exit 0
>  fi
>
>



-- 
Best Regards
Masahiro Yamada
