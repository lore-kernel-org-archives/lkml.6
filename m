Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09EEC070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4355B2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUeqgHFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4355B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeJOJ4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 05:56:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35924 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeJOJ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 05:56:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so8493001plt.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 19:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ymHkumwBfmXw1IdKgqrBRDHgkGkvVYtpf1I/XYkRfXw=;
        b=NUeqgHFOo1DEp6SPKhcPs5f82LZ21QDaNiL7SY5WQ7kY0cOCg/xTDW7rG2rpXJgE7I
         2CsLZdQJCzWKdxFtUQIPoDMBpKNEzDtGWWrEDz5J2nKX3pw+viKSg09vieqFQZHbxKU6
         ujAbfNUztirm9YBvxf8M7yASg2sjx8Xvjx8OAB07T+jAACL0/o+94ADGnPLWohSmuvgs
         ItZ1iuarrss035SZ1xUmm+P+6W0NPBDuhqRbPeAdQ9zyeOGAivE9gh76kB7yMuarvy4B
         wPlFjmqcefNNDkEYfQkgrw6Z2dA+uQ78MS63sHvSpmmOJAj/G715I532ib6i06V4A6TE
         hQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ymHkumwBfmXw1IdKgqrBRDHgkGkvVYtpf1I/XYkRfXw=;
        b=Mw8FBoNgdYGQ/ftac1pa+xyHid3SxhIwl5dlouovVrmo6VW78FPYjjeTdYCwciNA2R
         X8XNPZeNLLZkhzVxPPeSCULcDdlscdeVP82luzcwWt68k0oWjBXcL2uyEhnzfC0Gqq8w
         07Ui7UVQ1xe3FVEiI03YUCRfpia4HrHHoNFLtZ52iwipjoMEMIEsJBBvjtHojqghFa/1
         HYTztK9901jVce4tm2Pn82yFcuJ3PcmyQJaQ4PkZ9isl6KAQM7fvZFgYcs160zQqLB8y
         0HyNxslg1SWQngKVnfplPnfnykWFasVV77rLsNVF5/4TzfzeTN1IyILScksCsLdVUDP0
         c8gg==
X-Gm-Message-State: ABuFfohxMG+4UXwUZIXhFTdQ3eLvTQ2K8EGwAkfjw0H495ENcGzZ6xq8
        ilDUJ3xfDbmp1kfqweBFFgI=
X-Google-Smtp-Source: ACcGV62ywVHTbTtOqL7QyAb5COYIKb8Kq+f060IngduKuJZiTABpH9GuUgtwbI7vVoRJhxgSP1N9oA==
X-Received: by 2002:a17:902:a5cc:: with SMTP id t12-v6mr15564485plq.229.1539569611869;
        Sun, 14 Oct 2018 19:13:31 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s23-v6sm10930610pgg.67.2018.10.14.19.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 19:13:30 -0700 (PDT)
Subject: Re: [PATCH v8 3/5] Cleanup ISA string setting
To:     Alan Kao <alankao@andestech.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Greentime Hu <greentime@andestech.com>,
        Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>
References: <1539051514-3658-1-git-send-email-alankao@andestech.com>
 <1539051514-3658-4-git-send-email-alankao@andestech.com>
 <20181014000205.GA22333@roeck-us.net> <20181014234639.GA14835@andestech.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1867bb22-1858-0f14-e077-5cb4b2e50446@roeck-us.net>
Date:   Sun, 14 Oct 2018 19:13:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181014234639.GA14835@andestech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 10/14/2018 04:46 PM, Alan Kao wrote:
> Hi Guenter,
> 
> On Sat, Oct 13, 2018 at 05:02:05PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> With this patch in -next applied, I get the following error
>> when building riscv:defconfig.
> 
> I guess what you meant was this commit:
> commit 0a5bee05fc67ce2044b8d91a18abbf14042da531
> 

Yes, sorry, I just blindly assumed that the last version I found must have caused
the problem. You are right, v8 actually fixes it (as suggested below).

> The modification in Makefile was
> 
> -endif
> -
> -KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
> +# ISA string setting
> +riscv-march-$(CONFIG_ARCH_RV32I)       := rv32im
> +riscv-march-$(CONFIG_ARCH_RV64I)       := rv64im
> +riscv-march-$(CONFIG_RISCV_ISA_A)      := $(riscv-march-y)aj
> +riscv-march-y                          := fd
> +riscv-march-$(CONFIG_RISCV_ISA_C)      := $(riscv-march-y)c
> 
> and the ":= fd" line was wrong.  It should have been
> 
> +riscv-march-y                          := $(riscv-march-y)fd
> 
>>
>>
>> What am I missing ? Does RISC-V now require a new non-upstream compiler ?
>> Or a special version of make ? I am currently using GNU Make 4.1.
> 
> So I sent the v8 to fix this problem.
> Sorry for the inconvinience.
> 

No worries. At least this problem was (is going to be) easy to fix.
And, yes, I confirmed that the one-line change above fixes the problem.

Guenter

>>
>> Thanks,
>> Guenter
>>
>> ---
> 
> And Palmer, it seems that the patch that causes this build error has been
> pulled into linux-next.  Any idea how to fix that one?
> 
> Many thanks,
> Alan
> 

