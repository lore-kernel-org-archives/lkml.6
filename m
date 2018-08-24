Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B32C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF3E21523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5AiRL54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF3E21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeHYAz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:55:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35315 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbeHYAz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:55:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9-v6so1586604plr.2;
        Fri, 24 Aug 2018 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cJIgrslQVTjNXtRxbiSfsFZHESHIzwRqZ7wChVAoI0o=;
        b=U5AiRL547FYjcy94c7hHHpXTDln1dSCvYxKCdYCqd5RiuafI0jMt9eBMb8RsIBISJM
         5ao3rdKtQdevkXfL/DFJeVG5THFeXUjg2MdxfA5T7UHFAXyw1s9DoVXZvU109a8OA7Oy
         LIBzh/urfzYlks04+vtXcuYWoE5e9mI+3OqWFg0pkXZ4wOB/f6p+YqFvmy1Hu8pJaw4I
         56bAHfHtaoQub4cFr8ERD0dRUkLjCejK2sLjkazt/p0C8Sw9obF/hOI/AgG/94XFl4I7
         GcCe+P0kPlbngemtnuHK+DlgWq0H+UBSSF6Nj2ozIoyPUqHwAz1EkK1oaMfIAqVGKaQj
         UulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJIgrslQVTjNXtRxbiSfsFZHESHIzwRqZ7wChVAoI0o=;
        b=TeNGFQZvmpR8Ip4PrsBtjkxnHNcQREpsPF7jwbWeDDg/B5srMn6amJdguUti0Hw5B0
         v7u+uOATQFoHGYF3ZGCqAg3lWdt0Apo25jeYPuY6XlZvYBhOUtIjUuWOwMFd+zGK3FSB
         XbR3c7EfFzRjpahzadk6QAXeoc0dBAEdTvykyH6F53iJjHD1b4XcHPjJmifUNbL1cbVm
         rhHTVbjD3IGwG3ZpLatpp1d4wq/kskewEq9xgaxXU4wKtSkLW4jNdCqt9A9FG02PVZod
         jOc6OLQP3o1eqMYsZ9lWyNvqLTdNYENwOs+lOAhqXTlBxjkoP8MwC1kFfoZhzWEAwktM
         fVew==
X-Gm-Message-State: APzg51DAIOsoJR+H+Rrp1+IeyzXS3wM+uAdQjkJ7QB1cb06rtU9Uruqy
        Qga2A5k8DjEShKtCwkiff5U=
X-Google-Smtp-Source: ANB0VdZhfjLAEDS7+AvjcXDGCLo84K20ROb6a0Ej8QZPq/dA9xO/Jf60Akd/bTkrmva/JjTrA9ROSg==
X-Received: by 2002:a17:902:e088:: with SMTP id cb8-v6mr3143533plb.189.1535145548496;
        Fri, 24 Aug 2018 14:19:08 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x10-v6sm12274823pge.23.2018.08.24.14.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 14:19:07 -0700 (PDT)
Date:   Fri, 24 Aug 2018 14:19:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Roland Dreier <roland@purestorage.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
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
        Yazen.Ghannam@amd.com, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
Message-ID: <20180824211907.GA9593@roeck-us.net>
References: <20171215092305.994559179@linuxfoundation.org>
 <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
 <1535129126.2902.36.camel@codethink.co.uk>
 <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
 <20180824191749.GA15489@kroah.com>
 <CAL1RGDXUx-frpWuuYyc-VrAEoOU2+irGQPRWvoBzO2ZxEPGrww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1RGDXUx-frpWuuYyc-VrAEoOU2+irGQPRWvoBzO2ZxEPGrww@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Andi Kleen <ak@linux.intel.com>

On Fri, Aug 24, 2018 at 01:04:09PM -0700, Roland Dreier wrote:
> > Ok, so what patch should be reverted?  I'm seeing other reports of
> > problems all around this same area, but I can't figure out exactly what
> > to do.
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
>  - R.
