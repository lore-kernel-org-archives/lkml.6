Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185E2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB4320890
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ferbN/fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB4320890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbeGXGch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388109AbeGXGch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:32:37 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DCE420890
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532410077;
        bh=l74CYvPbSmzxoLMKu6SIrKB+2JNio719e0WIeqwl6K4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ferbN/fs9xnp0Xh2OA0zB1ieWtyoL/tej0EyudVRyFfbG05+s6Vxet+oFiMsxlNnF
         m66ogOes+l2oq1VQ+LKmSC3dQ6gZbVKtby+DuCKndgv9RqqGNDDDbT8yfnpXxRaiRK
         3vBpt+S3BMtF3aq+c8sn8G+X5e87Zgdv3g8U0I5Q=
Received: by mail-wr1-f42.google.com with SMTP id j5-v6so2744428wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 22:27:56 -0700 (PDT)
X-Gm-Message-State: AOUpUlH074ZrZk4Z/xrUwsN7pgSFvThhZqHAJjxGqVPvHGmgLLIHLxSQ
        wOLnVAHuge0Abd+OvR7WIkSNzMP9ne8KJvLw3gvUOQ==
X-Google-Smtp-Source: AAOMgpf4ARt9SCl8EEQSe+nWrGoU2OF9OZ+aIJg65JYCcSVGrL92tcvik7NdJsif92xgYg0BD2B7ATiBl4WpG1azr/I=
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr10026372wrs.171.1532410075508;
 Mon, 23 Jul 2018 22:27:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 22:27:34
 -0700 (PDT)
In-Reply-To: <20180724034205.GA245659@romley-ivt3.sc.intel.com>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
 <1532350557-98388-6-git-send-email-fenghua.yu@intel.com> <10870309-993a-0abc-635a-92c05bbad140@kernel.org>
 <20180724034205.GA245659@romley-ivt3.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Jul 2018 22:27:34 -0700
X-Gmail-Original-Message-ID: <CALCETrX6oiYMvhsnttSFLuSSdOdG3+SyM0PQvBEVHHqZMXZGsQ@mail.gmail.com>
Message-ID: <CALCETrX6oiYMvhsnttSFLuSSdOdG3+SyM0PQvBEVHHqZMXZGsQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] x86/vdso: Add vDSO functions for direct store instructions
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 8:42 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
> On Mon, Jul 23, 2018 at 06:48:00PM -0700, Andy Lutomirski wrote:
>> On 07/23/2018 05:55 AM, Fenghua Yu wrote:
>> >The instructions can be implemented in intrinsic functions in future
>> >GCC. But the vDSO interfaces are available to user without the
>> I'm not convinced that any of this belongs in the vDSO at all.  You could
>> just add AT_HWCAP (or AT_HWCAP2) flags for the new instructions. Or user
>
> Thomas asked to use vDSO. Please see the discussion thread:
> https://lkml.org/lkml/2018/6/19/316

I think he meant that, if these helpers belong in the kernel at all,
then they belong in the vDSO.  But I think they mostly don't belong in
the kernel.

>
>> code could use CPUID just like for any other new instruction. But, if there
>> really is some compelling reason to add this to the vDSO, then see below:
>> >+notrace bool __vdso_movdiri_supported(void)
>> >+{
>> >+    return _vdso_funcs_data->movdiri_supported;
>> return static_cpu_has(X86_FEATURE_MOVDIRI);
>
> But boot_cpu_data (used in static_cpu_has) cannot be accessed by user
> unless mapped in VVAR. So this change cannot be compiled.

The underlying alternative infrastructure works in the vDSO.  You'd
need to introduce an alternate version of _static_cpu_has if
BUILD_VDSO that skips the boot_cpu_has fallback.
