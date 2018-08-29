Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78707C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C72220647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C7EEZ4ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C72220647
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeH2X4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:56:41 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:35842 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeH2X4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:56:41 -0400
Received: by mail-lf1-f50.google.com with SMTP id c21-v6so5306608lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 12:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ocNpYvIW2aDFz1byDBSZDx7KO5o6+L8WeI2DfwMye4=;
        b=C7EEZ4vehu9RafFvZyS482U8ree21uM4s1Sebi0Ln4PFWlbyccbVe6avb8PkrBcrTX
         PtzlycUsmHkSofVs/ViO9TJRVTmPjZeQ2nTNw69X4rIJvXjnBJE6rvg0vtBqKHWLGVx4
         5yZahQdsDSI98LWM9i7vry1dRgmfmONJH0CrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ocNpYvIW2aDFz1byDBSZDx7KO5o6+L8WeI2DfwMye4=;
        b=H1yNm69kOW2OyKdORQdd3RB8EhiG2bF0aV+v7shEnooqPron/BgK5S3+rNxrxEKszk
         aut7RIzo515guIDRL/dW723pbX6GID1XsvlMTP4OPhq7qj8pvkYmoffT8mNEimf0SFY+
         9SdPbAxbv4dnXlIHF1GLMNZWxq0Uu3AKPFDoTLKKu+XeqPp4MVMiRlTxCOebHzCK0lmO
         ERawnNa1tKCi0Nr37v4/EGXORDnndjHhfY9Wg3RB+D0ncqqmwEHe3gDtAvQ3bqzwR3/6
         9ezplI51QHtKcQF0jHYn/5W5vGOWWOq2iL4PYs9CFT45GHiG3IC6gOqg2yleyHYBbMk5
         c/7Q==
X-Gm-Message-State: APzg51DgtAnXUQ1OWKWNxzRyRfgjm0ecH09BymcXeBl8ATtt0+RaCzj5
        TrdAPpCIWh7Q6dXhuYeHluoNK8vSNp7V1x8dwNW2+A==
X-Google-Smtp-Source: ANB0VdbfbppLP4Yt9ZaER0kPBUlyU4vlcjqJ2GwMZwCQ+vQd5EQxw6hvZfArP+K150TF7QRvXjGpi2h6jRYymuibe/Y=
X-Received: by 2002:a19:2a91:: with SMTP id q17-v6mr5562736lfq.74.1535572693500;
 Wed, 29 Aug 2018 12:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20171215092305.994559179@linuxfoundation.org> <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com>
 <1535129126.2902.36.camel@codethink.co.uk> <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
 <20180824191749.GA15489@kroah.com> <CAL1RGDXUx-frpWuuYyc-VrAEoOU2+irGQPRWvoBzO2ZxEPGrww@mail.gmail.com>
 <35e0f79b-6fac-5027-6377-67dbe2a293b9@roeck-us.net> <20180825150723.GA10230@kroah.com>
 <c2e61e43-6cd5-567a-8c3c-3cc3ff456c31@roeck-us.net>
In-Reply-To: <c2e61e43-6cd5-567a-8c3c-3cc3ff456c31@roeck-us.net>
From:   Roland Dreier <roland@purestorage.com>
Date:   Wed, 29 Aug 2018 12:58:00 -0700
Message-ID: <CAL1RGDWKujPp-O5RnxBsBvEe8yf-bNXSN1fa4DtY4b5-fQH2rQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
To:     Guenter Roeck <linux@roeck-us.net>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Perhaps just the patch that Andi posted to the stable list helps out
> > here?
> >
>
> For reference:
>
> https://www.spinics.net/lists/stable/msg253357.html
>
> That would be the most straightforward and simple fix, so I would prefer
> to go with it if it works.

Sorry for being slow, it turned out to take a slightly bigger stack of
patches to get everything working.

I agree, Andi's simple fix is better anyway.

 - R.
