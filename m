Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62987C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17146240E3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFNBpkJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17146240E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbeGEHDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:03:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56210 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeGEHDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:03:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so9153886wmv.5;
        Thu, 05 Jul 2018 00:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iKU9aZLNyvt1TodJW6RHLcxFYr9UzhUWijR0l1E3qas=;
        b=PFNBpkJ6xQ8aOjEqStcnpKVh0G3tM8jITGppa/JI1tdILM6vAKtTMPMjAvOaMN4MU/
         r/b1HKKpRAqh/8uSD5gfEzrgZHFR+X1KA5KQKHL25XA2GpnbEYbs+0YP8+LlGj8YETyP
         dZQjhQinrC+42nkc684Ly0UVfVB9QAeId3D2WlEgFAmTj7/BTJaxbYR1WivW23oDChCN
         Xk83o/h3ZT+LMn59/D8DoneF5s+RxNXIoOUDYjo0wD586v8iYxqQDTBWlRNV0k1jhiUz
         0OeOjhEjqLlwnZ3k57jxUyto+hcxJ09P5tiy+w329mOPiwruUOFF/FneV/f6dhE5fjX6
         krQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iKU9aZLNyvt1TodJW6RHLcxFYr9UzhUWijR0l1E3qas=;
        b=UtaK/WzvEdppvmCIaBbeWRTaKWztcWwccWQfxDQj/h9hZo8tes0sySBqCT7yq4ycep
         Pg+Aw4EvVDSB+01MZw4krKuFSrp9auQaEP6CE4UIp8a4/tsa8yTZIa2dnTmfyx9ZKhau
         m5P5qKhvjsjS25dGWOhxYK/deWRmrx/lRPAQbrWMhHQDk4KT5EHIFHpaUybzrua/zD4P
         DXLuL9SnAj7GRMCJ3Pw4/C1LJruo2BMj57HzBXIp2l1kdBlgM28cB/UY50Only/brbeZ
         3UmP8ngFKm/ca0jD3hQVMhcPkqGk7SFxE4kyNmo5coxD94s3BBOSmBbV2wfet93oG7HI
         yedw==
X-Gm-Message-State: APt69E1xbzYYAQJME4TjeRIdvhWiy0MQxB1T0nZ1IF+7KRIUfpQ/NTwe
        QwvkhnagdD0TSfCCFMke1FA=
X-Google-Smtp-Source: AAOMgperaW7t9eMWw64yU08J/alz3UeQI+4iLGd57K+mwd+gB18zqAeReUpClt49Be2dh4lzfZI7kA==
X-Received: by 2002:a1c:854c:: with SMTP id h73-v6mr2441807wmd.56.1530774179355;
        Thu, 05 Jul 2018 00:02:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 24-v6sm14418746wrz.94.2018.07.05.00.02.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 00:02:58 -0700 (PDT)
Date:   Thu, 5 Jul 2018 09:02:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH] x86/asm/memcpy_mcsafe: Fix copy_to_user_mcsafe()
 exception handling
Message-ID: <20180705070256.GA27603@gmail.com>
References: <20180702165803.GB19488@linux.intel.com>
 <153056565378.3420.295180898468362039.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180703083040.GB971@gmail.com>
 <20180704223825.GZ30522@ZenIV.linux.org.uk>
 <CAPcyv4hFL4qE1n9jjJa_wuw6nOGQR5vtyqg-vvvbLw9X=9_RvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hFL4qE1n9jjJa_wuw6nOGQR5vtyqg-vvvbLw9X=9_RvA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, Jul 4, 2018 at 3:38 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Jul 03, 2018 at 10:30:40AM +0200, Ingo Molnar wrote:
> >>
> >> * Dan Williams <dan.j.williams@intel.com> wrote:
> >>
> >> > Hi Ingo,
> >> >
> >> > Here is an additional copy_to_iter_mcsafe() fix to address the crash
> >> > reported by Ross. This now passes xfstests:generic/323 on my system.
> >>
> >> The lib/iov_iter fix would need an Acked-by from Al.
> >
> > I can live with that; I would really like to see some documentation on
> > the copy_to_iter_mcsafe(), but that's a separate story.  Incidentally,
> > are there any expectations of other callers appearing, or is that
> > (and copy_from_iter_flushcache()) YASingleConsumerAPI?
> 
> The current cpu architectural detail preventing conversion of the
> standard copy_to_iter() path to use the mcsafe flavor is that we can't
> use REP MOV for fast copies and instead need to use a software loop so
> that any exceptions are recoverable. When / if that is addressed, and
> there is no performance difference between the two, it might make
> sense to convert more users.
> 
> The _flushcache flavor, however, will likely stay limited to a single
> consumer for the persistent memory use case.

Could you please add the API documentation Al asked for, and update the changlog 
with the acks and tested-by's that people gave, and send out a v2 series?

Thanks!

	Ingo
