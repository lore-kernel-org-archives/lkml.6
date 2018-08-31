Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53C0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F92D2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NngbsPov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F92D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeHaUc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:32:57 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:57118 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHaUc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:32:56 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7VGOGci030521;
        Sat, 1 Sep 2018 01:24:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7VGOGci030521
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535732657;
        bh=QWiNr12zqfdpo2P07IHMlYcFnR3sJrPYub0OXcYDKCU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=NngbsPovKlNUN/zQYkGQ4F++X3cC8MLvW3tY/IIhfQLX3IvWftgrrFuQdVNPoxxqS
         UoB22VC50+NkuCezM9wdy7a/aCJOvozpdeCgcop7ufMFlGooOcgHw/TsrJ/P+r3SZb
         TiHzJx20PV71nf5JZY2FnfR+QYmt0xUWz1TE9dFQIJT29/wZJq0P968QzHGubBE07K
         uGWFmkJDyJ4oq0kQjGRD508bdO4+LFFG8OTvoLOlP3d5ESchJgImE3V4vNkwcMpTKo
         X2QQ3Y9/Pp7GCYJBUzxx6ci92poCzt+wrqGFv5PmILVXvG3eBzc9BOVq9ftWmnPYAo
         KhRp7PFjsB7WA==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id c12-v6so8619764uan.3;
        Fri, 31 Aug 2018 09:24:17 -0700 (PDT)
X-Gm-Message-State: APzg51BPcKPQpViFOgFWpLB1JF+AqDm8GOcpyK2FdpIho2fWHuKnpAmH
        sXsOfCEdqDHrWxkfoOwbYQNnrktqCuvDHQZtu50=
X-Google-Smtp-Source: ANB0VdaKTWQizSztqoGpV1ZjICrO3YkiNuJxGhCDCn5y5YxoZZ+M9DLWdOOLXmR5GDSh94CcuP3UG7MuRxz5YUYQLkw=
X-Received: by 2002:ab0:6a6:: with SMTP id g35-v6mr10266428uag.16.1535732656238;
 Fri, 31 Aug 2018 09:24:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5155:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 09:23:35
 -0700 (PDT)
In-Reply-To: <07334982-98f0-561e-f8a1-ba42e36da80e@infradead.org>
References: <07334982-98f0-561e-f8a1-ba42e36da80e@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 1 Sep 2018 01:23:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNASetukWY0fV8zu06ECfwcdm7_u0xVVxA=Q0W0VM91hmug@mail.gmail.com>
Message-ID: <CAK7LNASetukWY0fV8zu06ECfwcdm7_u0xVVxA=Q0W0VM91hmug@mail.gmail.com>
Subject: Re: [PATCH v4] modules_install: make missing $DEPMOD a Warning
 instead of an Error
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        stable <stable@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-29 4:59 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> When $DEPMOD is not found, only print a warning instead of exiting
> with an error message and error status:
>
> Warning: 'make modules_install' requires /sbin/depmod. Please install it.
> This is probably in the kmod package.
>
> Change the Error to a Warning because "not all build hosts for cross
> compiling Linux are Linux systems and are able to provide a working
> port of depmod, especially at the file patch /sbin/depmod."
>
> I.e., "make modules_install" may be used to copy/install the
> loadable modules files to a target directory on a build system and
> then transferred to an embedded device where /sbin/depmod is run
> instead of it being run on the build system.
>
> Fixes: 934193a654c1 ("kbuild: verify that $DEPMOD is installed")
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: stable@vger.kernel.org
> Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
> Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> ---


Applied to linux-kbuild/fixes.  Thanks!


> v2: add missing "exit 0" and update the commit message (no Error).
> v3: add Fixes: and Cc: stable
> v4: add Reported-by: and more explanation for the patch.
>
>  scripts/depmod.sh |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- lnx-418.orig/scripts/depmod.sh
> +++ lnx-418/scripts/depmod.sh
> @@ -15,9 +15,9 @@ if ! test -r System.map ; then
>  fi
>
>  if [ -z $(command -v $DEPMOD) ]; then
> -       echo "'make modules_install' requires $DEPMOD. Please install it." >&2
> +       echo "Warning: 'make modules_install' requires $DEPMOD. Please install it." >&2
>         echo "This is probably in the kmod package." >&2
> -       exit 1
> +       exit 0
>  fi
>
>  # older versions of depmod require the version string to start with three
>
>



-- 
Best Regards
Masahiro Yamada
