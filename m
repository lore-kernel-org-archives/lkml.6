Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB11FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ED1217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="I5RQQ4jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfBTBZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:25:27 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33245 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfBTBZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:25:27 -0500
Received: by mail-qt1-f194.google.com with SMTP id z39so25625207qtz.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EzXMHb0jok8WxAlTUk6ar/YYMCxASn/aXK0q1EzjWjg=;
        b=I5RQQ4jwK/smikxAnhSsaUNBuJyr3ZGIgKUWfa0163VNRAeLsRECwp57whOpzAXqOW
         zGUuv2t4Qe35+XfGrTew49rxUuM7afy6IuHqg3XiFte4bHxxh4HyPjP5c9ROqYjUz2TJ
         AHM+bgSPPerIVgRLlY39li+raWOo6Q3QxjiOvhP+6ov6tecVaCoNkKVgxSI9r95NnUvU
         CRbQWF5YroFMKUJ2akFiOITndL6rXRetK4wgwIgtWFF/X7sshLEjiFHGh42FENd2Qbe+
         nmZlvZxcdiXoTOvu0g8ZvpM4aGYWeehLYV6p/p2NXkem1fvPmgoeirvjjPB1OIFN0RQy
         ijVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EzXMHb0jok8WxAlTUk6ar/YYMCxASn/aXK0q1EzjWjg=;
        b=NMciN5UmQTvBNzo30BN8J7SjBXtmGmbboemAsTu1KfIy3o7tsl0GQv+SQKiqZwRUyk
         JjRwKogLiCILk9Q+qz0uQepsvoEZ7J1+B2EODSBAURxI+MjRbpHfg1bTGwixXrUT6X26
         u9verWOSepw29royf9J/NWFe/kxxXBii3lbQs8VLzPoQ1TMO6vXonh0er+HkO1+fhHWh
         hdha9fwZQ/PrtXZYYhldnOrIjLVzJqrmQBqrSsw+p2PS5ORv4B2tdCCDpSaWUE8nSUuD
         Jooy1woiUTHImzkMOvOSG/cPNK6lQdbNyaU9oR7v/rCJ+kZXfgyI1iXZ8yMCJBw48JZM
         UWsg==
X-Gm-Message-State: AHQUAuYVBTXl5+eKBfGaBfbov12xeRetvrRjBBoZC5I2CdEZbn9sLtdw
        urhDWPCieA41qs+uQrMqA5v/Tg==
X-Google-Smtp-Source: AHgI3IY+iieQmamUUglq2g56lOkqB4iQF/MuYuyEL+6L603qQYeY/mL21zoox9EieQHMDkwC9qgg9A==
X-Received: by 2002:ac8:160d:: with SMTP id p13mr25294686qtj.20.1550625925552;
        Tue, 19 Feb 2019 17:25:25 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i126sm9324469qkc.78.2019.02.19.17.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:25:24 -0800 (PST)
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Kostya Serebryany <kcc@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Brown <broonie@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Evgenii Stepanov <eugenis@google.com>
References: <20190219214940.391081-1-arnd@arndb.de>
 <1550614664.6911.45.camel@lca.pw>
 <CAKwvOdn+MJxYc+ykvyf-WhEzzDn0zEusjpQuksknnf8bPb=Q6g@mail.gmail.com>
 <CAN=P9pgC8EzawtxMzp6d3AsMPkSpTd0Ry6j+Jn+YgC_XP2Fd_w@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <d925ca37-ff0d-adba-6e1e-a7eaa47404b0@lca.pw>
Date:   Tue, 19 Feb 2019 20:25:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAN=P9pgC8EzawtxMzp6d3AsMPkSpTd0Ry6j+Jn+YgC_XP2Fd_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/19 7:33 PM, Kostya Serebryany wrote:
>>> Well, I am using clang 8.0 on arm64 and running the kernel just fine for a few
>>> weeks now and never trigger a single stack overflow (THREAD_SHIFT = 15) because
>>> I never use any of those drivers you mentioned above. I don't think it is a good
>>> idea to blankly remove the testing coverage here and affect people don't use all
>>> those offensive functions at all.
>>
>> Thanks for the patch, Arnd!  Hopefully we can fix that up in Clang
>> soon.  Qian, I guess the alternative would be to add `-mllvm
>> -asan-stack=0` on potentially up to 140 Makefiles?

Depends on the exact stack consumption of those 140 functions. For example, I
don't care if you turn-off -asan-stack if the current stack size is < 32k.

For those functions always consume like a lot of stack like 8k or more, fix them
in Makefile if not too many of them.
