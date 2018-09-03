Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA955C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A68020843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="v3TOZAcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A68020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeICOOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:14:30 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:52109 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeICOO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:14:29 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w839srb3031814;
        Mon, 3 Sep 2018 18:54:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w839srb3031814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535968494;
        bh=97e1G3gBe0EDbWBE35SawGqCFVc3JAfVyr7u4sNPhAQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=v3TOZAcskydQUUh70hbPt+AHnkhaCEC/9L+e+t6DZLRGslSfoegAv6oBQK8/w5tNX
         o4dkdUERlt0jcL3NKnS2KBOD7pipyW2inKraYZZVFOKGmUknwrWGGKmI6HIG7Bvg0L
         Ox/iDcYXIoxcnmgvbBw5RJM+tACET/GhAtmk7BtrV3JfgCxGyMPOQAYY/ji6a57zSd
         0Ahr9ogtFUbheJdlJFUXWAfv2I5ylSa0Yl4hP5tWkd7AENdEH3zzNPKYRscEzA6act
         hntv6qbFWIg1lmbPAWVaShtD5x7iAZQvUw3nLCiyLgOO/x+1MuHB9Zeyb39CfeU3rF
         xk6wnGr718taw==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id c12-v6so8343uan.3;
        Mon, 03 Sep 2018 02:54:54 -0700 (PDT)
X-Gm-Message-State: APzg51A0CeApq7OTWNvblzb8oN9H76k3Kg2DmqMNte4VDpGrq4zSxz71
        MGUo+FG5fUB4T7vQXBf+XYSukQk2qsu43H+1i+c=
X-Google-Smtp-Source: ANB0Vdard8pC4E2nckjKWLnO3yOofm9K2w+IRMws8iVZg1niuV6+uor7UEkO6Ffl28HvyVOPwnvINhvVRB63oqh0VCo=
X-Received: by 2002:ab0:30ea:: with SMTP id d10-v6mr15319475uam.58.1535968493029;
 Mon, 03 Sep 2018 02:54:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7103:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 02:54:12 -0700 (PDT)
In-Reply-To: <20180903093945.GA1195@zn.tnic>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
 <1532072796-7947-8-git-send-email-yamada.masahiro@socionext.com> <20180903093945.GA1195@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 3 Sep 2018 18:54:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQOd-QA6E7189q4K-p_9ReRtE88UbhtuXS9600nOQTgaA@mail.gmail.com>
Message-ID: <CAK7LNAQOd-QA6E7189q4K-p_9ReRtE88UbhtuXS9600nOQTgaA@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] kbuild: use 'include' directive to load
 auto.conf from top Makefile
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2018-09-03 18:39 GMT+09:00 Borislav Petkov <bp@alien8.de>:
> Hey,
>
> On Fri, Jul 20, 2018 at 04:46:32PM +0900, Masahiro Yamada wrote:
>> When you build targets that require the kernel configuration, dot-config
>> is set to 1, then the top-level Makefile includes auto.conf.  However,
>> Make considers its inclusion is optional because the '-include' directive
>> is used here.
>>
>> If a necessary configuration file is missing for the external module
>> building, the following error message is displayed:
>>
>>   ERROR: Kernel configuration is invalid.
>>          include/generated/autoconf.h or include/config/auto.conf are missing.
>>          Run 'make oldconfig && make prepare' on kernel src to fix it.
>>
>> However, Make still continues building; /bin/false let the creation of
>> 'include/config/auto.config' fail, but Make can ignore the error since
>> it is included by the '-include' directive.
>>
>> I guess the reason of using '-include' directive was to suppress
>> the warning when you build the kernel from a pristine source tree:
>>
>>   Makefile:605: include/config/auto.conf: No such file or directory
>>
>> The previous commit made sure include/config/auto.conf exists after
>> the 'make *config' stage.  Now, we can use the 'include' directive
>> without showing the warning.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v4: None
>>
>>  Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This complains here:
>
> [boris@zn: ~/kernel/linux> git clean -dqfx
> [boris@zn: ~/kernel/linux> cp ../configs/config-4.19-rc1 .config
> '../configs/config-4.19-rc1' -> '.config'
> [boris@zn: ~/kernel/linux> make
> Makefile:605: include/config/auto.conf: No such file or directory
>
> I guess because I'm skipping the "make oldconfig" step but that should
> not be necessary since it should do oldconfig automatically before
> building...
>
> It still works - it is just the warning that is new.


You are right - I missed this usecase,
but I still want to excuse "it is rare enough".


Thanks.

-- 
Best Regards
Masahiro Yamada
