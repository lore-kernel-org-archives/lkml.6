Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CCC04EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD0D223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XGD3vavP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD0D223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeKOI1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45046 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeKOI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id b81-v6so8110795pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9z/89ftI7AtVKGGllB4sgq8NOCFJq85o9PpaTDweimw=;
        b=XGD3vavPkVdHk6HkQESRP5og8buMuRwVPDj8+s33WhXzTg/2v6bNyLsQAauLD/cZim
         QZYoZ3Wu9fuXF4SbN29l4yM2S2gGFnN6fRFzbnQZHHlWNOZBPucjElnhSLs893+gAAaa
         k3bcd8QngNzTx8rigkxTPQDrre5E0l4nMtZdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9z/89ftI7AtVKGGllB4sgq8NOCFJq85o9PpaTDweimw=;
        b=lB5RNvDaDigUqoiFvmkyosk9sZVsFBmHHNNOY1dflre3gpxc/7mYteYa3ajovy8OxJ
         wRM2DdIQF9T+Xgi0LaGECBUkHcHatrw4y84UuNbfxYmEb8j+6jXsrKovoWfEThsxv3yL
         4rIZo2Se6NIKi6botpt+iuTQZ1ZnBOBwCyXibYvZWn55sDkQvdAcwRRXAlQWUFPpvovj
         alICAwyOQ7hKq+CICahzPNoUfMJuUGBxqxJqnyNLt/Jccd57ncDdTOp0EYocBCgFcRff
         2klUsyV63DVw0OCMiVsNqCzZ5uhP2clLYj8I9PVUhw84c2IQQf3WOBBLqPhRio1Wsr8O
         recw==
X-Gm-Message-State: AGRZ1gIrNpCIn9OY5MY2gOLCJmEt68rsNSxFTYXIPpj8QexT8iSLHYyo
        q0TLp+uzxNXSmJunWD9sWPu1EA==
X-Google-Smtp-Source: AJdET5di88FOJauKaNsYII/WIc2+iJqlnL0FvNlZEfRUncNBjhVOua125+UJ8Su1ONfpchxO3W1MAA==
X-Received: by 2002:a63:6c4a:: with SMTP id h71-v6mr3443465pgc.326.1542234119313;
        Wed, 14 Nov 2018 14:21:59 -0800 (PST)
Received: from pure.paranoia.local ([172.83.40.72])
        by smtp.gmail.com with ESMTPSA id m3sm44817629pgl.69.2018.11.14.14.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 14:21:58 -0800 (PST)
Date:   Wed, 14 Nov 2018 17:21:54 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, pr-tracker-bot@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [GIT PULL] PCI fixes for v4.20
Message-ID: <20181114222154.GA22445@pure.paranoia.local>
Mail-Followup-To: Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <helgaas@kernel.org>, pr-tracker-bot@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20181114062010.GA189193@google.com>
 <20181114200003.14496.1490.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20181114201214.GM13926@zn.tnic>
 <20181114201658.GB25069@pure.paranoia.local>
 <20181114214601.GO13926@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114214601.GO13926@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 10:46:01PM +0100, Borislav Petkov wrote:
> > > that bot needs some parsing improvs: "None None".
> > 
> > Correct, this is because the original pull request was for an ssh://
> 
> You'd think Bjorn would know better... :-)))

For the record, there's nothing wrong with that, it's just a condition
that I didn't expect. I have a fix in place that should avoid this in
the future.

-K
