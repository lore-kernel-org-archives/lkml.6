Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE4CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4CD2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIcfjktT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4CD2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeHXXmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:42:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43766 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHXXmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:42:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id v66-v6so4749792pgb.10;
        Fri, 24 Aug 2018 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vd6ddKIiDn7Wxc81DAU/CU1ZzdkNr6/YfvtOpLX6/Cg=;
        b=qIcfjktTnB1TQzksJXK/ZxYzK0EEsNY3cXawAWGr6L8oeyR+v/H0t4OID3VyG89o/F
         yZrWyTatnFgTq/Sy0t+mGPlT36sJpFD8o38qL/Cas3l7on6UrQEPsfViifGZOgFuRNFb
         xw25WryNFYrSDmZsgxFZkNzcvRl4ZvvhiYtO1UtqZqPf4rdK+OYSH/csWdBv38Zl+wjS
         YoeOQl7i8BALEvEdjdvatyBXCgeWiBANpSBxUT631XeR30pcxxU51mUfJaOMU5z0CfAH
         7lYVcQWuVD6HnFaI/qIEXFbgi0z1w1LmZcdW06mxmFbyATkFqmtpxWszKxwQjyHrxu8H
         +5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vd6ddKIiDn7Wxc81DAU/CU1ZzdkNr6/YfvtOpLX6/Cg=;
        b=E8jIXwkvwB/52ThaDjZrFB0B8qZxA+WEtK7H9WMuN3pEl1lMSbGTZ1Pne+gTpUy0oI
         A8k5zYa50KpqmgHtMVaeFUzm0VqqCk4S3vm+0kJVT6mWb2om1YQXfLfE07V5cQOjuPi9
         RUksrzXYovHlegeExIKO0+VjkC2OH6uiLVMqsFIxEaMZbs1FRYVYnQ8C/o14lf1ADrKB
         Q1gDtWUid1nGMwNLgXcGDihUj35cQkLECOeMQeDsUhE7/gTJmTlopLYsZb+auZfjlL8J
         grcLWCphW6nPWBBZ08M86hg2jJNh+/iYK81U3/TI6bHYYE22ijanSHS/RWFH8rcgnN3O
         Lbrw==
X-Gm-Message-State: APzg51AHf9tvuYcg6O831sZMZl9AK4DuhBnwarM/O4Sjo6DLAx9y6tD/
        q4DAy+NsKTa098Ggp9bqR98=
X-Google-Smtp-Source: ANB0Vdatl16XSfO/y2HfhZ3EN/IT9yjBX1A3ngzdWSD3yZU/ClpYoeJvyzm4n0xNsW286Ykl1qTesw==
X-Received: by 2002:a63:fa17:: with SMTP id y23-v6mr3006541pgh.177.1535141169483;
        Fri, 24 Aug 2018 13:06:09 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o3-v6sm8835446pgv.53.2018.08.24.13.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 13:06:08 -0700 (PDT)
Date:   Fri, 24 Aug 2018 13:06:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Roland Dreier <roland@purestorage.com>,
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
Message-ID: <20180824200607.GA18715@roeck-us.net>
References: <20171215092305.994559179@linuxfoundation.org>
 <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
 <1535129126.2902.36.camel@codethink.co.uk>
 <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
 <20180824191749.GA15489@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824191749.GA15489@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 09:17:49PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 24, 2018 at 10:08:28AM -0700, Roland Dreier wrote:
> > > See
> > > <https://lore.kernel.org/lkml/1512686629.18523.217.camel@codethink.co.uk/T/#u>.
> > 
> > Thanks!  I'm not using SGI UV and I'm not using kexec, so I guess I
> > sidestepped most of those issues.  Greg, I think we need to unrevert
> > the cpa->pfn change (otherwise the L1TF fix probably gets pretty
> > messy) and I guess pull in the other patches that Ben mentions.
> 
> Ok, so what patch should be reverted?  I'm seeing other reports of
> problems all around this same area, but I can't figure out exactly what
> to do.
> 
> Guenter, any ideas?
> 
I think we'll need to reapply 87e2bd898d3a ("x86/mm/pat: Ensure cpa->pfn only
contains page frame numbers"), and possibly apply d367cef0a7f0 ("x86/mm/pat:
Fix boot crash when 1GB pages are not supported by the CPU"). Both require
conflict resolutions, but they are quite straightforward. I am not sure
about the other EFI patches.

I am going to send the backports as RFT in a minute. Problem is that I don't
have an EFI system at hand and can not test if this fixes the problem
(or maybe introduces a new one), so someone will need to step in and do
those tests.

Guenter
