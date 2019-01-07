Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4B8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DEF206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfAGUHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:07:02 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45639 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfAGUHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:07:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so1878040qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 12:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FpW4J+9AugFBweyXCbvKDycuXqPrDXzjbv5BTTnekyY=;
        b=cvycwREdLw5nsghRhCGhzWov+5yslrIa+jgcB7v/2ZON9ZGjg6BBTN9Qc3KgO/73X4
         tVUBQ6Vt1POTk5mCc0QflPGcQfiRGRWnbzFbginE7rGvPC7fiqC0XmrLilNFJ4vZrLZj
         NGqC4BWOM3/p5QEPbHlnUjWGavFx+AFE3efHZP+PJ74CzqIHPNFaf3+WZrzVCYSc/Sdi
         dHYuYcMssWTL1URoMRmhdoYQcsFIbMFvA2yORO/lBswk2SvbWNg//09Lv2wVuDVY/9W3
         NGWYIPXBY0q1p/9D4ddrjcpYRp0gzGr/ygUztQbiVciJNErUXmbkzS35kjCbtgsgRkY5
         a4rg==
X-Gm-Message-State: AJcUukdqJDo56KNnV0NMghNa1TDbjCYcrXhzlt+bn7JBZ8qScypfexSB
        o/22lRAZmMaDlU64854CYBmKmmF1fs0=
X-Google-Smtp-Source: ALg8bN452zUlrSdFN1k1H/1BbjPGYKLPrLU/k+0OpWRe891NTzlV3Tzf/IWRXf72eCgNq9GXzs8F2A==
X-Received: by 2002:a0c:b786:: with SMTP id l6mr62696330qve.244.1546891620641;
        Mon, 07 Jan 2019 12:07:00 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::bbd9? ([2601:602:9800:dae6::bbd9])
        by smtp.gmail.com with ESMTPSA id c49sm37718388qtc.94.2019.01.07.12.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 12:07:00 -0800 (PST)
Subject: Re: [PATCH] vfio_pci: Add local source directory as include
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190104195714.30045-1-labbott@redhat.com>
 <874lakc09x.fsf@concordia.ellerman.id.au>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <ee4ca932-36ea-73ba-5d96-6359dad1d114@redhat.com>
Date:   Mon, 7 Jan 2019 12:06:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <874lakc09x.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 12:58 AM, Michael Ellerman wrote:
> Laura Abbott <labbott@redhat.com> writes:
>> Commit 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
>> subdriver") introduced a trace.h file in the local directory but
>> missed adding the local include path, resulting in compilation
>> failures with tracepoints:
>>
>> In file included from drivers/vfio/pci/trace.h:102,
>>                   from drivers/vfio/pci/vfio_pci_nvlink2.c:29:
>> ./include/trace/define_trace.h:89:42: fatal error: ./trace.h: No such file or directory
>>   #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>>
>> Fix this by adjusting the include path.
>>
>> Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> I'd still like to echo my sentiment that this should not be a def_bool.
>> We hit this error on our internal testing and we couldn't even turn
>> off the driver until we fixed this.
> 
> I assume there's some reason you can't commit a patch to your tree to
> change it to bool, or turn it off entirely? That would change the SHA
> which is perhaps reason enough.
> 
> In general we have far too many options and most of them never get
> turned off (or on), so it just creates testing/bug surface for not much
> benefit. This is one that will probably be turned on in all distro
> kernels for example.
> 
> But I have no real objection to making it user configurable.
> 
> 
> Alex I assume you'll merge this fix via the vfio tree?
> 
> cheers
> 

Well now that everything is fixed, we will probably keep it on.
My gripe is that when things break like this it's difficult to
work around vs. the configuration option at least makes it possible
to work around in a fast way. This may also just be a strong
preference of mine for working around problems.

Thanks,
Laura

>> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
>> index 9662c063a6b1..08d4676a8495 100644
>> --- a/drivers/vfio/pci/Makefile
>> +++ b/drivers/vfio/pci/Makefile
>> @@ -1,3 +1,4 @@
>> +ccflags-y                               += -I$(src)
>>   
>>   vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>>   vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
>> -- 
>> 2.20.1

