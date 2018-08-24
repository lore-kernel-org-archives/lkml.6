Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD79C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FCA208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6kLkgss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FCA208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeHXXqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:46:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40163 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbeHXXqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:46:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id z25-v6so4761341pgu.7;
        Fri, 24 Aug 2018 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V7VL/RlaOCjJ+aW/rxVEpB1AVAamS8paKUyPYAD13B8=;
        b=n6kLkgssJvifnVGvfhXWVrUFFpypZcwcBxCpT8PTRdcNJ9Lj/HRCYFGTrAoZyYkQZf
         YoPaasxQjYJQFBMLxryd/3yyz/F3gSy73895efLsrDzDMAn2kiEZxXv9leFOn76sCWX9
         RmqPG1GKWqjdKN3qIY8Hp7linAjxDsTrJpAhrdLVZ/IoNUx8UcymNA3PYmcmkb9FU72S
         9x2zKiOGjmfIj/4WVBnnGaHTczu8AGRAKPmRcKn3qH3GOiFYuRlRFMOyC7SjT3msg5qZ
         Zbd60WPCWbpicC1E7FjjWrZ2Nri9SII1M101toxI/LNUde/UfTMrHLJ/TLRNUZHvAtpl
         cu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=V7VL/RlaOCjJ+aW/rxVEpB1AVAamS8paKUyPYAD13B8=;
        b=ROCx4HxMMUuW2XusR1cpuJoax9Qxcrr32xPIFwkdb/3BG6Voc7HxFUS/fRnyGtQwmz
         H2oEBvZ3hXurbXlNZgVCQYkz+KMq/VKiU3BoN78EruVySlFNNizKYAODvG1n0Xd4oauG
         ni+oCIf4ULz7geTe09NP18eXv7BzWhnmKH0aIy9v5me6PLXcNsV5V8Obm/yn9MrV3sRB
         ykUeuXnjeMLKskJBp7G4gtCAv8ga4poPqIQXtVVPXkW+8eidsbhJmrpTvlve/Q1od6h8
         N6QRBlhysGgJZdjQ6wj02abFRSX6DSO/Jebj9QtR668PhWXko7syhjQEPjpx0eONsZJW
         GWwA==
X-Gm-Message-State: APzg51BKwrp+FQzFWJZeRxuwEwuGKx7APFDoAh/qkUeQO8HY6WtlfZsw
        xlVAP3T0FPPTrKhKibb8854=
X-Google-Smtp-Source: ANB0VdYuYdhrJAzUBGscaB2inv6jqfQ+tAM/rR5m8c8lh0VI9Y97EiZ6H0++t/ABIiwGQfg0C6cwgg==
X-Received: by 2002:a62:d544:: with SMTP id d65-v6mr3391931pfg.107.1535141426443;
        Fri, 24 Aug 2018 13:10:26 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x2-v6sm14386132pfi.166.2018.08.24.13.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 13:10:25 -0700 (PDT)
Date:   Fri, 24 Aug 2018 13:10:25 -0700
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
        Yazen.Ghannam@amd.com
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
Message-ID: <20180824201025.GB18715@roeck-us.net>
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

Sounds great. I'll hold off with sending my RFT series and wait for your
test results. I think we'll also need d367cef0a7f0c6 ("x86/mm/pat: Fix
boot crash when 1GB pages are not supported by the CPU").

Thanks,
Guenter
