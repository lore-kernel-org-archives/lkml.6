Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1512C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0D4213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0tgJQdts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0D4213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeJLWFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbeJLWFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:05:43 -0400
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A5820835;
        Fri, 12 Oct 2018 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539354780;
        bh=5jXZlJ/dIGQIyx/TGvkuXSH4shejyurjFKIYiEAaWHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0tgJQdtsIQlm5EX9oqkDFhZGBp4uUusjg7pZXbiGskPo7Wbp2TnRXmVYkInLCN2G3
         QUdvr8o+AQIFTHIxbzZC8pL6XBhyzWdceosm2U/YOm0Yib0HU5g7pNV/NTS0JTeo3F
         EH20X8PXubW3NYhuhVLo3vxEf15pWXFL0SXWMbwA=
Date:   Fri, 12 Oct 2018 16:32:54 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        keescook@chromium.org, catalin.marinas@arm.com,
        will.deacon@arm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, kristen@linux.intel.com,
        arjan@linux.intel.com, deneen.t.dock@intel.com
Subject: Re: [PATCH v2 4/7] arm64/modules: Add rlimit checking for arm64
 modules
Message-ID: <20181012143254.idy65qbvaaw5k3ge@linux-8ccs>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-5-rick.p.edgecombe@intel.com>
 <25951d99-8ba7-5c9e-938e-baf92395f9e0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <25951d99-8ba7-5c9e-938e-baf92395f9e0@intel.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.16-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Dave Hansen [11/10/18 16:47 -0700]:
>On 10/11/2018 04:31 PM, Rick Edgecombe wrote:
>> +	if (check_inc_mod_rlimit(size))
>> +		return NULL;
>> +
>>  	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>>  				module_alloc_base + MODULES_VSIZE,
>>  				gfp_mask, PAGE_KERNEL_EXEC, 0,
>> @@ -65,6 +68,8 @@ void *module_alloc(unsigned long size)
>>  		return NULL;
>>  	}
>>
>> +	update_mod_rlimit(p, size);
>
>Is there a reason we couldn't just rename all of the existing per-arch
>module_alloc() calls to be called, say, "arch_module_alloc()", then put
>this new rlimit code in a generic helper that does:
>
>
>	if (check_inc_mod_rlimit(size))
>		return NULL;
>
>	p = arch_module_alloc(...);
>
>	...
>
>	update_mod_rlimit(p, size);
>

I second this suggestion. Just make module_{alloc,memfree} generic,
non-weak functions that call the rlimit helpers in addition to the
arch-specific arch_module_{alloc,memfree} functions.

Jessica
