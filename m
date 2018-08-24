Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DA7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEC120A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0vjn4Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEC120A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeHYAJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:09:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43251 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeHYAJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:09:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so5034336pfi.10;
        Fri, 24 Aug 2018 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d5/EeagCYp5yRsfBdWnmEMLlTzipxCg1f/U5p4y54jc=;
        b=G0vjn4RpPQAMkpi/X6Tn+szvYOV75wgOnNcaeTCtb76U3b6yrytsqAQ+Dlya5Hzdow
         k3MpM3+WL1w+/fJMzjLSw8Ue7gjGF3t9TbzaP2yMb7b865lACEdK0b4WkA0PfFzYANEI
         fkoUU1NQLqdEOBwR8gmGK/R5Q0S108R9kKvvmFqF4hugh7sAaW0DRUsVqdOnDeSTBXrU
         q9mIUV43jDQ3bpIBKQ52OHiebAW2JO7chrMNttziwd7S+NRwXFrU4aOoWdGZnN7daawN
         jZhTT0kWbbuiS5ouZuSaQBGiRHNSZuYmkTh0unCyTqNgKW2O393HQgMBFIBCpPZt3/2D
         q/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=d5/EeagCYp5yRsfBdWnmEMLlTzipxCg1f/U5p4y54jc=;
        b=OjFIrW6+XH8dnkTyyDxIrinyBhRvNPsLoTVVzZj+gGQH1l49t5F8TGivhnzvfBPFLN
         V21ck2eiTLQ4BgF6mX0FAAigpi7NK+ZHQSHK5gQ9UE5T1JSShcXN/5+yCDWWzlDuz+4y
         H1LsZQAM+rwVMPAPtrxxsA2TA1ZDzmK7hS/A2tlOhq+leuoISPIuEbtSyvATjljsr1MY
         3Ga1RPlLTt0qVuHt4K1fDq8o6wcrEtw4r2Y1+D0AwgUeeXkdTfzu87CZAnnY80xF4l0+
         vGvKmiqR0nem32mNuQZqU4Cwnwc3AIGSPDQ70xwwcH7pe2vqeW43+StDQe2Nft9df6lo
         8zoQ==
X-Gm-Message-State: APzg51Coavni9HTuCQaFpfWkeZtrb8ODTcdl306adcIjF0EyrDbu84so
        lnG9w45H1q40gh0gEzuKzv4=
X-Google-Smtp-Source: ANB0Vda/skoLS6ZuvvkeRA2yu+ChL+OUdgUK+6lKc+0MThHpxOvDpBebdW/qE49vdpvNNt6D3MtJzQ==
X-Received: by 2002:a63:e516:: with SMTP id r22-v6mr3112754pgh.170.1535142772530;
        Fri, 24 Aug 2018 13:32:52 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x23-v6sm8880391pff.9.2018.08.24.13.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 13:32:51 -0700 (PDT)
Date:   Fri, 24 Aug 2018 13:32:51 -0700
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
        Yazen.Ghannam@amd.com,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
Message-ID: <20180824203251.GD18715@roeck-us.net>
References: <20171215092305.994559179@linuxfoundation.org>
 <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
 <1535129126.2902.36.camel@codethink.co.uk>
 <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
 <20180824191749.GA15489@kroah.com>
 <CAL1RGDXUx-frpWuuYyc-VrAEoOU2+irGQPRWvoBzO2ZxEPGrww@mail.gmail.com>
 <20180824201025.GB18715@roeck-us.net>
 <CAL1RGDXa2POjmrr8UK-2oYyQtxYxiOs5t9BrpGUHRXqkDjMW5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1RGDXa2POjmrr8UK-2oYyQtxYxiOs5t9BrpGUHRXqkDjMW5w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 01:16:18PM -0700, Roland Dreier wrote:
> > Sounds great. I'll hold off with sending my RFT series and wait for your
> > test results. I think we'll also need d367cef0a7f0c6 ("x86/mm/pat: Fix
> > boot crash when 1GB pages are not supported by the CPU").
> 
> Sure, makes sense - I don't have any EFI systems with CPUs old enough
> not to support 1G pages but that looks reasonable.  I'll pull that
> into my tree as well.
> 
kernelci reported a crash on a CPU which doesn't support 1G pages.
See https://kernelci.org/boot/id/5b7d39ea59b514c03796ba9c/

Guenter
