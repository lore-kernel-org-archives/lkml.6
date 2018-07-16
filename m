Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05A9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A28208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A28208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeGPLbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:31:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56968 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbeGPLbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:31:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F75118A;
        Mon, 16 Jul 2018 04:04:14 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BD073F589;
        Mon, 16 Jul 2018 04:04:11 -0700 (PDT)
Subject: Re: [PATCH v11 03/15] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
To:     Dave Young <dyoung@redhat.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-4-takahiro.akashi@linaro.org>
 <20180714015223.GA2745@dhcp-128-65.nay.redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <2a4ec965-5258-5835-3022-8f403a2f6bdd@arm.com>
Date:   Mon, 16 Jul 2018 12:04:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180714015223.GA2745@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 14/07/18 02:52, Dave Young wrote:
> On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
>> Memblock list is another source for usable system memory layout.
>> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
>> other memblock-based architectures, particularly arm64, can also utilise
>> it. A moved function is now renamed to kexec_walk_memblock() and merged
>> into the existing arch_kexec_walk_mem() for general use, either resource
>> list or memblock list.
>>
>> A consequent function will not work for kdump with memblock list, but
>> this will be fixed in the next patch.

>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c

>> @@ -513,6 +563,10 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
>>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
>>  			       int (*func)(struct resource *, void *))
>>  {
>> +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
>> +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
>> +		return kexec_walk_memblock(kbuf, func);
> 
> AKASHI, I'm not sure if this works on all arches, for example I chekced
> the .config on my Nokia N900 kernel tree, there is HAVE_MEMBLOCK=y and
> no CONFIG_ARCH_DISCARD_MEMBLOCK, in 32bit arm code no arch_kexec_walk_mem()
By doesn't work you mean it's a change in behaviour?
I think this is fine because 32bit arm doesn't support KEXEC_FILE, (this file is
kexec_file specific right?).

It only affects architectures with MEMBLOCK and KEXEC_FILE: powerpc, s390 and
soon arm64. s390 keeps its behaviour because it provides arch_kexec_walk_mem(),
and powerpc's is copied in here as its generic 'memblock describes my memory'
stuff. The implementation would be the same on arm64, so we're doing this to
avoid duplicating otherwise generic arch code. I think 32bit arm should be able
to use this too if it gets KEXEC_FILE support. (32bit arms' KEXEC already
depends on MEMBLOCK).


Thanks,

James
