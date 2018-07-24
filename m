Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA35C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F176720856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYVOskFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F176720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388760AbeGXWmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:42:03 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34737 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388538AbeGXWmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:42:02 -0400
Received: by mail-qk0-f193.google.com with SMTP id b66-v6so3639020qkj.1;
        Tue, 24 Jul 2018 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vtNwwvlGzR14dK9oaziGpYXgL4zdbZ8ZF9R+gE/fRhg=;
        b=kYVOskFY950BCN5NvCYvwhj/0kWSgtCMRtmjmpyP63ddGvO3eTRniDWzqbRlBaybVw
         soSPPyNIdT3VuRsVuFiM5ofdJSw3TK/Ocna7YGq/3P6aAf0RVZKva9uhNvfQptQbkrW0
         ScfHtk9WCV9QYGSflo2egluVpJKpGRl0wwi/4gsd7Kx4PEE1c9dbvg5ZPYnYlY0ZZomR
         w7MUdZr+1NISUgYsxe2p2qIM7LwV+Us6zA10tV83YqzoOLrlTgYVniNjy0VBSphCPOet
         WH+8Iv2XjwU/HPCRVzybpxYo+NujkqjPlkxjn+sopxXTQZAmUT95CyX31XkaskxEqZuY
         eR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vtNwwvlGzR14dK9oaziGpYXgL4zdbZ8ZF9R+gE/fRhg=;
        b=h+cjBVC1RS/qat2lvk3llMyP8CiuhqQeOxShhdTiMhZ4qD0ZkwevkXcwyD93e2LxoL
         YXZ2y4rl/jSq0MjfTQNsW+kS6IZnA/iQRhTUVKScxKQsztrtai4Vm7vmTj/q8WUgFt0A
         SWno2La1X4tTgwOkLQ43TC77DrNgQi8v7WMNOsV7qw/BQG61/OakDbx7H9fiIPP2LcCz
         4FAEtIVPATnlcBesJGshau/KkaFwps67Ia2FbBozWnKnBSHhbhJp8N8vuOY9JbdF1AiK
         FYiz5yS8D3GgrCnAhWmPU1GDpUnLKk/04csuLuny+0wM/WzZPqvU5LwfDb5WYbapPDOV
         s4xQ==
X-Gm-Message-State: AOUpUlHc1RWUnjv5Z1arl7QwRxrDbl95F4XPobtITaN4Dq1PAVuRw5Jo
        7caYEJ7/SBYgb8zm2dYZzCdKoXZ8nTUojl1j5Is=
X-Google-Smtp-Source: AAOMgpd+ffe9rFWqPUV8S7cT3yStwDen5gAthWlwligg3LzDiA6D0zFrNqi4lQ87KUh9BntjQkpYfQMRHhgk9lNuEqE=
X-Received: by 2002:a37:8786:: with SMTP id j128-v6mr16573692qkd.32.1532468017107;
 Tue, 24 Jul 2018 14:33:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 14:33:36
 -0700 (PDT)
In-Reply-To: <201807250052.6f8He2LR%fengguang.wu@intel.com>
References: <0ad306a7d410d3695c7869bf081efaa71e956ae4.1531826106.git.baolin.wang@linaro.org>
 <201807250052.6f8He2LR%fengguang.wu@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 23:33:36 +0200
X-Google-Sender-Auth: p83PVNVFNFT3uF4NZFGW0xMl37Y
Message-ID: <CAK8P3a0xYSaGbtxGWN=3NmcBnQ3Fd6rnHXp=0D0_MLXaJKfS+w@mail.gmail.com>
Subject: Re: [RESEND PATCH 4/4] sh: remove board_time_init() callback
To:     kbuild test robot <lkp@intel.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, kbuild-all@01.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 7:07 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Arnd,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on sof-driver-fuweitax/master]
> [also build test ERROR on v4.18-rc6 next-20180724]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/sh-dreamcast-rtc-push-down-rtc-class-ops-into-driver/20180719-041209
> base:   https://github.com/fuweitax/linux master
> config: sh-rsk7264_defconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sh
>
> All errors (new ones prefixed by >>):
>
>    arch/sh/kernel/time.c: In function 'time_init':
>>> arch/sh/kernel/time.c:42:2: error: implicit declaration of function 'timer_init'; did you mean 'time_init'? [-Werror=implicit-function-declaration]
>      timer_init();
>      ^~~~~~~~~~

Hmm, I fixed it locally, but Baolin forwarded the version from the
original submission that had the same bug (timer_init instead of timer_probe):

https://www.spinics.net/lists/linux-sh/msg52798.html

I'll just send the correct version once more.

      Arnd
