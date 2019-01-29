Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EBDC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D802217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfA2H0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:26:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35974 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfA2H0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:26:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so16484843wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 23:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RQvjdtxFs7m0nphzUIqAMWIG8Tw7TR+/aZi2b9zfUDo=;
        b=D5KnsYWwRkJqGjcROXCSWgNpZiZEkneWUHDORbu2gsDOw6tISlmQmc4LtKzX1JghsW
         jRIP0clyLTcfLmpBvvQRr2+Wp77uawN5hKDpMC5zyv3EvpTDjeWn/mMe+SJQ9eNPT6Jv
         +NfjybgMVSzKKepXZKj7tfpA5z0OSg+WQwNH/dqbBnOXzmFIIgZpQzYSHTICW1Jkk6Gu
         qgBHuGQ5XqivITraHdxkU7jAeNGcKb4sm/BULDE7ICUfbK5q9RF63YjZsjqzkPwRnUmU
         iqjwDcTv2Yic5oya1jurhmepm7M80pmD8JAQtWcMnuizqgYQzFH5eGfgUz9JdWmP6pub
         0Qsw==
X-Gm-Message-State: AJcUukd9kj7KtNuLcsa5sKWL9LgxVgUcQpyN6ZHARqthJcihR8qF107P
        yZvqIGtHbafoTIMtMxz8ScuWclYJsW9E+A==
X-Google-Smtp-Source: ALg8bN74fTR1aYgN4WDGZiM0aNgZAV4jOFFvdbEuBN0qf7/FeVN0jcast/3XdH5eRiVZvWpIB3eD2Q==
X-Received: by 2002:a1c:2382:: with SMTP id j124mr19874009wmj.14.1548746759851;
        Mon, 28 Jan 2019 23:25:59 -0800 (PST)
Received: from [10.200.137.150] (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id r9sm4047753wmb.27.2019.01.28.23.25.58
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 23:25:58 -0800 (PST)
Subject: Re: [PATCH] s390/jump_label: Correct asm contraint
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190123125513.20210-1-labbott@redhat.com>
 <20190123132401.GG3424@osiris>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <898d52cc-fa76-0888-429f-27446190653b@redhat.com>
Date:   Tue, 29 Jan 2019 08:25:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123132401.GG3424@osiris>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 5:24 AM, Heiko Carstens wrote:
> On Wed, Jan 23, 2019 at 01:55:13PM +0100, Laura Abbott wrote:
>> There's a build failure with gcc9:
>>
>>   ./arch/s390/include/asm/jump_label.h: Assembler messages:
>>   ./arch/s390/include/asm/jump_label.h:23: Error: bad expression
>>   ./arch/s390/include/asm/jump_label.h:23: Error: junk at end of line, first unrecognized character is `r'
>>   make[1]: *** [scripts/Makefile.build:277: init/main.o] Error 1
>>
>> According to the toolchain people, the actual issue is the use of
>> "X" constraint which is too permissive. Switch to using "i" instead.
>>
>> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1668703
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>   arch/s390/include/asm/jump_label.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
>> index e2d3e6c43395..41dabfd8518d 100644
>> --- a/arch/s390/include/asm/jump_label.h
>> +++ b/arch/s390/include/asm/jump_label.h
>> @@ -22,7 +22,7 @@ static inline bool arch_static_branch(struct static_key *key, bool branch)
>>   			  ".long	0b-.,%l[label]-.\n"
>>   			  ".quad	%0-.\n"
>>   			  ".popsection\n"
>> -			  : : "X" (&((char *)key)[branch]) : : label);
>> +			  : : "i" (&((char *)key)[branch]) : : label);
>>   	return false;
>>   label:
>>   	return true;
> 
> Hmmm, this works only for the kernel image, but not for modules, which
> we compile with "-fPIC", which again doesn't work as described in the
> referenced bugzilla:
> 
> In file included from ././include/linux/compiler_types.h:68,
>                   from <command-line>:
> ./arch/s390/include/asm/jump_label.h: In function 'kvm_vcpu_ioctl':
> ./include/linux/compiler-gcc.h:124:38: warning: asm operand 0 probably doesn't match constraints
>   #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
>                                        ^~~
> ./arch/s390/include/asm/jump_label.h:19:2: note: in expansion of macro 'asm_volatile_goto'
>    asm_volatile_goto("0: brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/compiler-gcc.h:124:38: error: impossible constraint in 'asm'
>   #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
>                                        ^~~
> ./arch/s390/include/asm/jump_label.h:19:2: note: in expansion of macro 'asm_volatile_goto'
>    asm_volatile_goto("0: brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
> 
> Andreas, Ilya, any idea how to fix this?
> 

I've had to turn off s390 in Fedora until this gets fixed :(

