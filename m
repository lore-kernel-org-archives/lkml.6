Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE8CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8146D25B51
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cQA3grrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8146D25B51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755600AbeFYOVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:21:13 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:43983 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbeFYOVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:21:11 -0400
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com [209.85.213.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w5PEL8gH026766;
        Mon, 25 Jun 2018 23:21:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w5PEL8gH026766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529936469;
        bh=dZBGW/mK8IjWN5dlmdvJ3TH7SUX5POx3KJ6gi+ojWCY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cQA3grrtQw16VlQo4bIn2MXUENFRxOzER+Xgwr/ihiNqhD/5ssetDYLC7nYRug580
         uaV90rdu89S9xEHalYnUhg/2agnJR081r9W24PxpcNeOykHjHlsgUhGcy7o3tb4Ucl
         Z2s/NVX/W1I3Ki1dfhvLXiaxXiFj54djPxJaahs2YHGuakmgZFFOOYSk882/JqI51l
         aqqzvG0ZA14CH+WOwvkSl/Gspq0+xH/YcqKMLC6PDdtdl9hZwI62dSw9EJlYDY/UUB
         cuowhepAPV5dJiTfACZIhChcxLime8eL1DiU8X6boV2H7IuyEUl/4HhE2DdVAib2Az
         Hmh6jpDtWEy2Q==
X-Nifty-SrcIP: [209.85.213.50]
Received: by mail-vk0-f50.google.com with SMTP id f200-v6so591795vke.0;
        Mon, 25 Jun 2018 07:21:08 -0700 (PDT)
X-Gm-Message-State: APt69E0fFPo5LMf0kgJNEYnzpsAoXfkZGknFcr3CDn3gpywEYk0ivNE+
        Ia0BA+YeJIpemGSV2zrqaZlPuXtELJ72rA23H3I=
X-Google-Smtp-Source: ADUXVKKg2JauKTDGF3IxBSW5hdgsbbFhPfFNMgwwAbOtOrBOvUSW0Sl8Mwef7fXqfBuLXwAcXbwa7exdCWvWcpNdFXU=
X-Received: by 2002:a1f:a945:: with SMTP id s66-v6mr7882467vke.54.1529936467663;
 Mon, 25 Jun 2018 07:21:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 07:20:26
 -0700 (PDT)
In-Reply-To: <20180625101607.08db48ff@gandalf.local.home>
References: <20180608214746.136554-1-gthelen@google.com> <CAK7LNARngmBXa5w3XFfuA7pEv39vWjJVNJ+3XVLPYd9QLH+f-A@mail.gmail.com>
 <20180625101607.08db48ff@gandalf.local.home>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 25 Jun 2018 23:20:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNASiQztugmEGuTHmPg9vZY2b+btK+EzX-6o4NgCthHSpmg@mail.gmail.com>
Message-ID: <CAK7LNASiQztugmEGuTHmPg9vZY2b+btK+EzX-6o4NgCthHSpmg@mail.gmail.com>
Subject: Re: [PATCH] trace: fix SKIP_STACK_VALIDATION=1 build
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Thelen <gthelen@google.com>, Andi Kleen <andi@firstfloor.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-25 23:16 GMT+09:00 Steven Rostedt <rostedt@goodmis.org>:
> On Sat, 23 Jun 2018 02:42:26 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> 2018-06-09 6:47 GMT+09:00 Greg Thelen <gthelen@google.com>:
>> > Non gcc-5 builds with CONFIG_STACK_VALIDATION=y and
>> > SKIP_STACK_VALIDATION=1 fail.
>> > Example output:
>> >   /bin/sh: init/.tmp_main.o: Permission denied
>> >
>> > commit 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace"),
>> > added a mismatched endif.  This causes cmd_objtool to get mistakenly
>> > set.
>> >
>> > Relocate endif to balance the newly added -record-mcount check.
>> >
>> > Fixes: 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace")
>> > Signed-off-by: Greg Thelen <gthelen@google.com>
>> > ---
>>
>> Applied to linux-kbuild/fixes. Thanks!
>>
>>
>
> I already pushed this to Linus. As I was the one to mess it up in the
> first place ;-) (I think I applied it with some fuzz)
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed7d40bc67b8353c677b38c6cdddcdc310c0f452
>

OK.
I will drop this, then.

Thanks for the info.



> -- Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
