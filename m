Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50603C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136902081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Be2D/DHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136902081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeLEDBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:01:22 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:47071 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLEDBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:01:21 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wB531Hbl020188
        for <linux-kernel@vger.kernel.org>; Wed, 5 Dec 2018 12:01:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wB531Hbl020188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543978878;
        bh=3xbLUf4w6f6M6ICBIgGYRry7weZGK/uBFoKKL8BU5ig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Be2D/DHKeXnTyNf0fmNb9QkWM4U4LQ1JrbbLvMCuLPe2EiRtPJX4UPfTvktRzD6TZ
         URnJfjZ/5RgkLTS1VvZLc3ZH5nKh9inREIJ6AbyW3EeV2rpofwDS3b46+2KUQugHRN
         /xl3uktxGdQpqsztRS6bM07dRKhs7DUHX3IC+IX00inlT/AKso5hHuknFyQ3I45rpc
         wP5zCLwzijggvpuxT5rjtN9tolPbScJFL4a12UEabb92+seUgGbSSOVsGgtlYMFYyj
         JBgn2SYhnMbJCdG6cE0WNo3Xi0bfq/xzo6IBqKHoWgVpYFpv8SA6ZGiRoIWIMiOHI2
         cnZh9oJVIvm/Q==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id x1so11168187vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 19:01:18 -0800 (PST)
X-Gm-Message-State: AA+aEWYV5qvh+C1HWTGkz+w9MKkmzN04OPGUEwv0mnCO2sh6oJ6sT1rB
        94oXnjUSBIshx4l3qdF7jb+1yjGkSpR6HUDm16s=
X-Google-Smtp-Source: AFSGD/XTrvDzFesIolCj4XI6ddFihNm9ooAWVOdR+kmR8lkaioFgO52V8AP1bh7I4B2cz2V525eF+XHUO0yS2SqxenA=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr9801784vsm.181.1543978877143;
 Tue, 04 Dec 2018 19:01:17 -0800 (PST)
MIME-Version: 1.0
References: <6eeee8da-82ac-f527-9278-7ebcc8756ea1@linux.ee> <3f72d5fa-cfed-e1a0-4f6c-90f8d1de1ace@oracle.com>
In-Reply-To: <3f72d5fa-cfed-e1a0-4f6c-90f8d1de1ace@oracle.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 5 Dec 2018 12:00:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASqynzpsrx1CCZmaSGK2K6owwkR0=FugkqDJVLDyQ7Q0w@mail.gmail.com>
Message-ID: <CAK7LNASqynzpsrx1CCZmaSGK2K6owwkR0=FugkqDJVLDyQ7Q0w@mail.gmail.com>
Subject: Re: Compiling with old gcc breaks when CONFIG_RETPOLINE is off
To:     zhenzhong.duan@oracle.com
Cc:     Meelis Roos <mroos@linux.ee>, Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 10:31 AM Zhenzhong Duan
<zhenzhong.duan@oracle.com> wrote:
>
> Hi Meelis,
>
> Could you try below change? It force syncconfig for  any 'make *config"
>
> so that autoconf.h and auto.conf are always updated.


NACK.

syncconfig should happen only when you are about to build something.

This patch let "make *config" touch include/config/* around
unnecessarily.




> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> index 98e0c7a..802875b 100644
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -38,7 +38,7 @@ enum input_mode {
>
>   static int indent = 1;
>   static int tty_stdio;
> -static int sync_kconfig;
> +static int sync_kconfig = 1;
>   static int conf_cnt;
>   static char line[PATH_MAX];
>   static struct menu *rootEntry;
> @@ -506,11 +506,11 @@ int main(int ac, char **av)
>                           * Suppress distracting "configuration written
> to ..."
>                           */
>                          conf_set_message_callback(NULL);
> -                       sync_kconfig = 1;
>                          break;
>                  case defconfig:
>                  case savedefconfig:
>                          defconfig_file = optarg;
> +                       sync_kconfig = 0;
>                          break;
>                  case randconfig:
>                  {
> @@ -537,13 +537,15 @@ int main(int ac, char **av)
>                          srand(seed);
>                          break;
>                  }
> +               case listnewconfig:
> +                       sync_kconfig = 0;
> +                       /* fall through */
>                  case oldaskconfig:
>                  case oldconfig:
>                  case allnoconfig:
>                  case allyesconfig:
>                  case allmodconfig:
>                  case alldefconfig:
> -               case listnewconfig:
>                  case olddefconfig:
>                          break;
>                  case '?':
>
> Thanks
>
> Zhenzhong
>
> On 2018/12/4 17:58, Meelis Roos wrote:
> > Just tried 4.20-rc5 on an old K6-2 PC with gcc 5.3.1, got an error
> > about non-retpoline compiler,
> > turned CONFIG_RETPOLINE off and retried.
> >
> > To my surprise, compilation still breaks with
> > arch/x86/Makefile:224: *** You are building kernel with non-retpoline
> > compiler, please update your compiler..  Stop.
> >
> > As I read the Makefile, it should error only when CONFIG_RETPOLINE is
> > enabled, but it still breaks.
> >
> > $ grep -r CONFIG_RETPOLINE .config
> > # CONFIG_RETPOLINE is not set
> >
> > $ grep -r CONFIG_RETPOLINE include/
> > include/generated/autoconf.h:#define CONFIG_RETPOLINE 1
> > include/config/auto.conf:CONFIG_RETPOLINE=y
> >
> > So the headers have not been updated yet, maybe?
> >



-- 
Best Regards
Masahiro Yamada
