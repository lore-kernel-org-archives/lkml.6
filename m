Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E30C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 13:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9A1208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 13:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2M8rmo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9A1208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeHYRbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 13:31:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38518 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeHYRbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 13:31:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id e2-v6so89920pgv.5;
        Sat, 25 Aug 2018 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mXohX+ptvIA1npmQOpMpe2ZmFFcLD9yuKcxIdH6tHGE=;
        b=Z2M8rmo5223mjkkJzZ1W4DlBKXArMLYYLWXhZQxr0tAO5A5ZNmCLfWQJ5CNT3KwHJy
         6yWX6c0SdU975HR+wEgi98n34n14IKatpNAbqxDJn8WV0zRrqhYY4tNYy6NAIWsao+zY
         77XtAv0p4in+01CACsVazQMQMkkX9lAdruTxAeH7f5OwJFIRYqnYZLoHBDbS0lxmSs6A
         Cr0kJxr1d3Ha5n1N5FGmF69lmhKnvNM7YH0tG9RJIzNy1RZui313D83fzZAx7g5P8sQK
         gomT+vgPyXI6nJq5HR2r85jyv8FMcZZf3tctr2udDFcaj15ikgmav+wrTXdlTACbfP0f
         59RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mXohX+ptvIA1npmQOpMpe2ZmFFcLD9yuKcxIdH6tHGE=;
        b=TeubfqBGQWYHFqRJOVZzs3fwdGF7JoLJphlNL2DnEPsq5p+RMHyuKfiv/9Ff4LehoE
         igRj5u1EaxCk8WrkQGHrdVl7YC9Xx+IeU8acM7dXyBAp3+QV9cCAVsFKDYRHL1wEUl7M
         a3tACMT5SKHVQwDHGy/VUBPyyncJTKpSe+fvTHIyi2OMT99lveLvmXZo7epGp5kN9e9D
         9NyV3Dk2FzE+2N4Lnx8D3T0p+ydeXiEruB9KJZKEHiqlp9/eWx8KfPuW4d2Zrc7tG3/y
         xz1zWQl3ctjSTvg1y35TZu9aWgqFEh82dolzeAeMVs3bP84qfgKfthXnE2rKJvCo9a2X
         0MOw==
X-Gm-Message-State: APzg51Aj/J+LPAcPsbGHUEo8keFHP+WI+4C1xbUXTttptGfRTu6ZnrS7
        +5lfwn2e6aVt1AJP2+BrUoI=
X-Google-Smtp-Source: ANB0VdYAZzN1K+QAhrYbTZwiySBVnXqwlVE0CfgP8/eTbgp57Sqap298m9AC4vTOZmy2zDKl8VsMUw==
X-Received: by 2002:a62:7182:: with SMTP id m124-v6mr6317083pfc.73.1535205155958;
        Sat, 25 Aug 2018 06:52:35 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id w16-v6sm20595345pfi.101.2018.08.25.06.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Aug 2018 06:52:34 -0700 (PDT)
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
To:     Roland Dreier <roland@purestorage.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        matt@codeblueprint.co.uk, bp@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, luto@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, bp@alien8.de,
        brgerst@gmail.com, davej@codemonkey.org.uk, dvlasenk@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        sai.praneeth.prakhya@intel.com, sds@tycho.nsa.gov,
        Thomas Gleixner <tglx@linutronix.de>, toshi.kani@hp.com,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Yazen.Ghannam@amd.com
References: <20171215092305.994559179@linuxfoundation.org>
 <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
 <1535129126.2902.36.camel@codethink.co.uk>
 <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
 <20180824191749.GA15489@kroah.com>
 <CAL1RGDXUx-frpWuuYyc-VrAEoOU2+irGQPRWvoBzO2ZxEPGrww@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <35e0f79b-6fac-5027-6377-67dbe2a293b9@roeck-us.net>
Date:   Sat, 25 Aug 2018 06:52:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL1RGDXUx-frpWuuYyc-VrAEoOU2+irGQPRWvoBzO2ZxEPGrww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland,

On 08/24/2018 01:04 PM, Roland Dreier wrote:
>> Ok, so what patch should be reverted?  I'm seeing other reports of
>> problems all around this same area, but I can't figure out exactly what
>> to do.
> 
> Are any of those reports public?  If so can you point me at them, I'm
> curious if the symptoms match up.
> 
> I don't think we want to revert anything.  I think you should pull in
> edc3b9129cec and at least the first three patches that Ben listed:
> 
> 21cdb6b56843 x86/mm: Page align the '_end' symbol to avoid pfn conversion bugs
> b61a76f8850d x86/efi: Map RAM into the identity page table for mixed mode
> 753b11ef8e92 x86/efi: Setup separate EFI page tables in kexec paths
> 
> the first patch takes a bit of massaging (mostly because some of it is
> already touched by 02ff2769edbc, which keeps the changes from
> edc3b9129cec, and so we can drop a good bit when applying).  The other
> three apply cleanly.
> 
> I'm currently testing that and can send you the state of my tree in a bit.
> 

Have you made any progress ? On my side I am still out of luck since I can not
reproduce the problem.

Thanks,
Guenter
