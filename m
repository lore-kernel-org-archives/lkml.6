Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DDCC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 04:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6127D205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 04:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="R8716GPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6127D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeHXHx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 03:53:56 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:50711 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeHXHx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 03:53:56 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w7O4Kh6k015936;
        Fri, 24 Aug 2018 13:20:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w7O4Kh6k015936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535084443;
        bh=O44LmWhgEINUsVCQbgOe96iaXBwB9wmpKcH5cfTbcvo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=R8716GPolykLfhFRMTNC7AZUwK8NUXKodZ9tBB0AQ5T2nU3UglZIQpxtmPaVXz5Lj
         fa4k1IKYUeWl+VZJVVLuvDgGTr56i9HfwLNqFeCicQYx7SUlDUJ4I3jiRxA5n+JQ+p
         GKMUiAdvTehXAzYMJULd3uxDii6p0LGcrOpXSm3j53ndMmFFVX1vZaeS7dX32ED7ER
         3slyzdr3AgBYYWjJx4Hm3Zdg0ikjByerMm4SgMKiICPJbHbCA3J6qMFMqye49K6SSL
         j0VsOTD2TiJMsLVWZvnzEjNzpOcd3BmtSUsWzRTTzf878roqrFrk0TGQ6wLKGPWYqq
         KAjf8h3bFnvsw==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id m26-v6so3293538uap.2;
        Thu, 23 Aug 2018 21:20:43 -0700 (PDT)
X-Gm-Message-State: APzg51D23O8JC8Bwvi5+xu8IcyX6J0zYfPj4ZBqG3Z06KaA6OZ9CPlp2
        Or2/xOtUswLNTP5hx3IxkPJb8ny3Zf8lS6kek/k=
X-Google-Smtp-Source: ANB0VdbIeo5AyCCDrYcf3jAgjE17sKSa4zIJw40FPvMxr+SEhEZWTozsygF9epTBu7Xu468XGkR4rVW6F4yfwwkJ4/k=
X-Received: by 2002:ab0:1a89:: with SMTP id j9-v6mr3407578uai.19.1535084442348;
 Thu, 23 Aug 2018 21:20:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 21:20:02
 -0700 (PDT)
In-Reply-To: <4449cd91-fae5-caf1-a917-82e0c5f0aba8@infradead.org>
References: <4449cd91-fae5-caf1-a917-82e0c5f0aba8@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 24 Aug 2018 13:20:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyhKFp+AWQr-RWTRbMu78=G7Uj=350xrjq_Lht8MVYzQ@mail.gmail.com>
Message-ID: <CAK7LNASyhKFp+AWQr-RWTRbMu78=G7Uj=350xrjq_Lht8MVYzQ@mail.gmail.com>
Subject: Re: [PATCH v3] modules_install: make missing $DEPMOD a warning
 instead of an error
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,


2018-08-24 3:13 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> When $DEPMOD is not found, only print a warning instead of exiting
> with an error message and error status.


Could you add the motivation of this change
(as Nikolaus reported) ?

Without the reason recorded in git-log,
somebody may wonder why this commit is useful.





> Warning: 'make modules_install' requires /sbin/depmod. Please install it.
> This is probably in the kmod package.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 934193a654c1 ("kbuild: verify that $DEPMOD is installed")
> Cc: stable@vger.kernel.org
> Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
> Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
> Cc: H. Nikolaus Schaller <hns@goldelico.com>

Reported-by: H. Nikolaus Schaller <hns@goldelico.com>




> ---
> v2: add missing "exit 0" and update the commit message (no Error).
> v3: add Fixes: and Cc: stable
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



BTW, if System.map is missing, depmod is silently skipped.


I think if System.map is missing, a user is doing something wrong,
but you could do like this:

$ make mrproper
   [snip]
$ make defconfig
   [snip]
$ make modules
   [snip]
$ make modules_install
  INSTALL drivers/thermal/x86_pkg_temp_thermal.ko
  INSTALL fs/efivarfs/efivarfs.ko
  INSTALL net/ipv4/netfilter/ipt_MASQUERADE.ko
  INSTALL net/ipv4/netfilter/iptable_nat.ko
  INSTALL net/ipv4/netfilter/nf_log_arp.ko
  INSTALL net/ipv4/netfilter/nf_log_ipv4.ko
  INSTALL net/ipv4/netfilter/nf_nat_ipv4.ko
  INSTALL net/ipv6/netfilter/nf_log_ipv6.ko
  INSTALL net/netfilter/nf_log_common.ko
  INSTALL net/netfilter/nf_nat.ko
  INSTALL net/netfilter/nf_nat_ftp.ko
  INSTALL net/netfilter/nf_nat_irc.ko
  INSTALL net/netfilter/nf_nat_sip.ko
  INSTALL net/netfilter/xt_LOG.ko
  INSTALL net/netfilter/xt_addrtype.ko
  INSTALL net/netfilter/xt_mark.ko
  INSTALL net/netfilter/xt_nat.ko
  DEPMOD  4.18.0+


The log looks like all the process went well,
but depmod is actually skipped because System.map is
generated by "make vmlinux"


What do you think we should do about this case?

Skip depmod silently?
Make it fail?
Print noisy warning like missing depmod case?


-- 
Best Regards
Masahiro Yamada
