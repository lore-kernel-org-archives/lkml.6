Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B02206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B02206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeIDIha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 04:37:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57011 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbeIDIha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 04:37:30 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w844Dx8c3550253
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 3 Sep 2018 21:13:59 -0700
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
 <20180904034414.GI1740@192.168.1.3>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
Date:   Mon, 3 Sep 2018 21:13:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904034414.GI1740@192.168.1.3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/18 20:44, Baoquan He wrote:
> 
> 1) in arch/x86/kernel/relocate_kernel_64.S, we set X86_CR4_LA57 into cr4
> if the 1st kernel is in 5-level mode. Then in
> arch/x86/boot/compressed/head_64.S, paging_prepare() is called to decide
> if 5-level mode will be enabled, and prepare the trampoline. If
> kexec/kdump kernel is expected to be in 4-level, e.g with 'nolv5'
> specified, it still can handle well. But for the old kernel w/o these
>  5-level codes, it will ignore the fact that X86_CR4_LA57 has been set
> in CR4 and proceed anyway, then #GP is triggered. That's why XLF_5LEVEL
> is used to mark. 
> 

That's what I'm saying, don't do that.  Always jump into the second kernel in
4-level mode, i.e. X86_CR4_LA57 unset.  That's the only sane thing.

	-hpa
