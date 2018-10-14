Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7E6C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779B920835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ5n0NAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779B920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJNQo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 12:44:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36796 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeJNQo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 12:44:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so16585327wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 02:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D5UIAQSb1AJiDZWUlBKOwysfrM3VeouL6tpMC/gHOYY=;
        b=JZ5n0NAvu7UrqhRZV3REX+3ejvK3khMPGnsLQjT/6U4T/VXEdX30C1ccSoIWEg4okB
         wCkjWEIJVT3BmfI8h246aubZz+uidjkIu+EWTvRehG4oX6JI7vf5lJmEuEAPLGQep4Uh
         h7VAFiFqpp7RPSQBWssO6Mt8XD9hl8tpu3uk2BZt9NCUVlaiUd4kkuRkjwjlbdFIhin/
         fpCkoP1k4rzpQsHf4JeulMjQgXsj4n0MkYUErt4agEAo5H+J+8kT5XL2ph9VZ5AdKWH+
         IKzUuyWn/TObaeTCsu6cI3kGHhUrhu+wV/2SweWhhgZsn77A0TGviMz6m0A58Jlf3ALt
         jG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D5UIAQSb1AJiDZWUlBKOwysfrM3VeouL6tpMC/gHOYY=;
        b=B6ASoC5auqhS51TzxoZEsoWD5ocOwSCT9NLmY0f0DF7izYIHkaqZppm7gcoZ+l5u5T
         siA2HafKojkBPOydvrHEN3TYd1MkL2fFJ7ShG9CIlIfBL9rZu9APMSjXrWvQYeWDYaE5
         VVfcL2K1+ns5eiQm8mUkX8ESb0SZ73BMcqcae2UEidyZGOGq/iWQ0j6KP+Ej5HK4Dq4Q
         UF2bxOZTVdkCLLjJZPuC2ih/RV/APN4r60s1YJ4YTJTAwrHxAHoo/CPv+gPveoAg7jAg
         8otJpPtrQEC0QNsLo9k2Op2EgliaeRsbJujSVT6NaBcvSwtToIXKxN78DLkqrbb6IZah
         Ns/g==
X-Gm-Message-State: ABuFfojQDFShblNyCGa9eReC3MZX41wMAz+InRWNf/A9csEDNpIWX82F
        hwMveRor2ebU78cOGdYeNNw=
X-Google-Smtp-Source: ACcGV62V68YEWkSm6V+9fUBSowVI1cDpwA8z5BZyfGrnnguHZ99xmjwFq1D0vXekFxx4hNB0F2SMXw==
X-Received: by 2002:a1c:cb05:: with SMTP id b5-v6mr9547626wmg.44.1539507876357;
        Sun, 14 Oct 2018 02:04:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r131-v6sm10088536wmb.32.2018.10.14.02.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 02:04:35 -0700 (PDT)
Date:   Sun, 14 Oct 2018 11:04:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        tedheadster@gmail.com, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: enable swiotlb for > 4GiG ram on 32-bit kernels
Message-ID: <20181014090433.GA28319@gmail.com>
References: <20181014075208.2715-1-hch@lst.de>
 <alpine.DEB.2.21.1810141012510.1438@nanos.tec.linutronix.de>
 <20181014081443.GA17889@lst.de>
 <alpine.DEB.2.21.1810141055440.1438@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810141055440.1438@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sun, 14 Oct 2018, Christoph Hellwig wrote:
> 
> > On Sun, Oct 14, 2018 at 10:13:31AM +0200, Thomas Gleixner wrote:
> > > On Sun, 14 Oct 2018, Christoph Hellwig wrote:
> > > 
> > > > We already build the swiotlb code for 32b-t kernels with PAE support,
> > > > but the code to actually use swiotlb has only been enabled for 64-bit
> > > > kernel for an unknown reason.
> > > > 
> > > > Before Linux 4.18 we papers over this fact because the networking code,
> > > > the scsi layer and some random block drivers implenented their own
> > > > bounce buffering scheme.
> > > > 
> > > > Fixes: 21e07dba ("scsi: reduce use of block bounce buffers")
> 
> Please use the first 12 characters of the commit SHA for fixes tags in the
> future, as documented. No need to resend, I fixed it up for you and added a
> Cc: stable as well

For those who have their ~/.gitconfig's from ancient Git history, this can be done via:

	git config --global core.abbrev 12

Thanks,

	Ingo
