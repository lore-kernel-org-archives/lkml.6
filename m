Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FCAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0534620815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbfACPIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:08:55 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40724 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbfACPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:08:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so19798642qki.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 07:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yp3OyJCmLoJ2H9VEVePmDoxN+orEhnrhYzUQ3YvPNGM=;
        b=n5ZYblW13jhU02yWcOqtL8gQ4F0nPLTMECkHij0O7QPEWe0NEGGjc3QeP0hCnDEf9t
         sbE5nmzlf7ocnFqVmPu2/Aov6t+Oo2VtLYtYoDCCVxEsdLyQBcCkTYihx3w1MVxvU41n
         IRjLM0DE7MWDq1kebud9iOAxQKgcT5nfY66VfUz+5I5YVXeDVwRiSR9tqzgIeum5Hj/a
         GMhJ3zl2mZAMBCcO//cMOy6HKDjyXvehvgvbaTAusp3t79aY0QZkj+rlPxUMZR75apkD
         vwHIt7wKzZsqLJlQQxI0aMTPUC8MnVfuw5l3f32wCOpWOkNN5ZiXFkEdy9+/Csakp/Tm
         A7RQ==
X-Gm-Message-State: AJcUuke8O+UATlIw76V7xVWRdVduJDXa7U/anbB4AUS/D0whvId7I1ua
        CB16f75Qh6e2uKBwktvk1ZFob7GWA4w=
X-Google-Smtp-Source: ALg8bN6wedrH7aopOg0rY9fC3TCYh7ikLXX50kMd1dXgjTd4cXY3bi5lwBtlFL6XLqZw6aMwqJqxRw==
X-Received: by 2002:a37:9a89:: with SMTP id c131mr44688047qke.173.1546528133347;
        Thu, 03 Jan 2019 07:08:53 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::814b? ([2601:602:9800:dae6::814b])
        by smtp.gmail.com with ESMTPSA id n72sm27421211qki.26.2019.01.03.07.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 07:08:52 -0800 (PST)
Subject: Re: compilation failure with CONFIG_VFIO_PCI_NVLINK2
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <28d0ba1d-b116-178a-d6d0-8a8b569c7c02@redhat.com>
 <e74e0922-af2e-dac4-2260-8589afa2426b@ozlabs.ru>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <2e4484ae-06b7-0de3-db8e-3a6989fac1f7@redhat.com>
Date:   Thu, 3 Jan 2019 07:08:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <e74e0922-af2e-dac4-2260-8589afa2426b@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/19 5:49 AM, Alexey Kardashevskiy wrote:
> 
> 
> On 03/01/2019 03:37, Laura Abbott wrote:
>> Hi,
>>
>> I got a compilation failure when building with CONFIG_VFIO_PCI_NVLINK2
>> enabled:
>>
>> + make -s 'HOSTCFLAGS=-O2 -g -pipe -Wall -Werror=format-security
>> -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions
>> -fstack-protector-strong -grecord-gcc-switches
>> -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1
>> -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mcpu=power8
>> -mtune=power8 -fasynchronous-unwind-tables -fstack-clash-protection'
>> 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,now
>> -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -Wl,--build-id=uuid'
>> ARCH=powerpc -j4 modules
>> BUILDSTDERR: In file included from drivers/vfio/pci/trace.h:102,
>> BUILDSTDERR:                  from drivers/vfio/pci/vfio_pci_nvlink2.c:29:
>> BUILDSTDERR: ./include/trace/define_trace.h:89:42: fatal error:
>> ./trace.h: No such file or directory
>> BUILDSTDERR:  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>> BUILDSTDERR:                                           ^
>> BUILDSTDERR: compilation terminated.
>> BUILDSTDERR: make[3]: *** [scripts/Makefile.build:277:
>> drivers/vfio/pci/vfio_pci_nvlink2.o] Error 1
>> BUILDSTDERR: make[2]: *** [scripts/Makefile.build:492: drivers/vfio/pci]
>> Error 2
>> BUILDSTDERR: make[1]: *** [scripts/Makefile.build:492: drivers/vfio]
>> Error 2
>> BUILDSTDERR: make: *** [Makefile:1053: drivers] Error 2
>> BUILDSTDERR: make: *** Waiting for unfinished jobs....
>>
>> I don't know enough about ftrace building to make a guess here.
>> Config is attacked.
> 
> What gcc is this and what is the exact sha1 of the tree? gcc8 prints
> other error with your config in drivers/scsi/esas2r/esas2r_ioctl.c but
> not this one so I am curious.
> 

gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)

sha 8e143b90e4d45cca3dc53760d3cfab988bc74571

>>
>> Also, would it be possible to switch this option from def_bool to
>> bool? I can't turn it off directly when it's def_bool.
> 
> Why? Honestly I'd rather fix the compile error.
> 
> 

It's not just about this error, there may be other situations where
it would be good to have this turned off.

Thanks,
Luara
