Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C02C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B918208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EE4D+wDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B918208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeJBBLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:11:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47006 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeJBBLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:11:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id a5-v6so1499967pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mdx2QaCA/V3pIaAAVa1il4XPojE1oXFXIaI6oUWb55o=;
        b=EE4D+wDowS1qHfRw5zY0awFyPg+zf7rJqIT1bkAU2lkxA7FcIALJSseztnP4fAHMP/
         T+3BQJSUvDIr3mjxJFupbEhUugfr39YsrVvakpgXEdZ4wrGYYLKPRrvEsRa8v0SKrR7h
         1C8bYuUDwTrk41D122KZOHOxus/bo9DLHDeHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mdx2QaCA/V3pIaAAVa1il4XPojE1oXFXIaI6oUWb55o=;
        b=VkK8OvDs+qNbv5me+1qQ+zDhRRHPq8t8PurnbO/09Kmvab5cYlc+JHIVsVi/0G2vBq
         sHVpdSXdxj0bjdWXv3eh0DqM95XsjXHksGte1el9VYOIuVTDBPfSV4G3ZXKEiaG+KaKU
         wPr5HuUhEFN3zA81eYwAkLmHJ/TkeqS+5oSu5K3s7TSrCDNbyjQFimT8dLut6FoD2Btw
         RR2IpzglrjdvDBp8J8nT36fvDTB/L0uY7AfVju9dUmJOrxMbuIhEtDGcOtyvgWDjpoGu
         0JACwQVzNkulVqeyxspHKuSvBu7tRZH8ow+lTvNAa5u3pL8BnFPynkff5E6lEsp4pFnJ
         HjZg==
X-Gm-Message-State: ABuFfoidWACi2C+7V/Xs/nZk6u4z/kh/0zkTSJEva2AQLFtyvk4MV34u
        A1+W4eC3SVfau99mKbJLaeY3Jg==
X-Google-Smtp-Source: ACcGV63cu4+AG3TstpyJ9GH0o4J+DbmGfeMxOitM3lg/doi8v2jUgSJm5DXssdXDA6czf6Uadfdr4w==
X-Received: by 2002:a63:c84c:: with SMTP id l12-v6mr11066680pgi.77.1538418738972;
        Mon, 01 Oct 2018 11:32:18 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q25-v6sm26637063pfk.154.2018.10.01.11.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 11:32:18 -0700 (PDT)
Date:   Mon, 1 Oct 2018 11:32:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH] firmware: Always initialize the fw_priv list object
Message-ID: <20181001183216.GM2523@minitux>
References: <20180920010938.10315-1-bjorn.andersson@linaro.org>
 <20180920052204.GA15695@kroah.com>
 <20180920073415.GC1367@tuxbook-pro>
 <20181001132703.GA12193@centauri.lan>
 <20181001181835.GG5238@garbanzo.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001181835.GG5238@garbanzo.do-not-panic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Oct 11:18 PDT 2018, Luis Chamberlain wrote:

> On Mon, Oct 01, 2018 at 03:27:03PM +0200, Niklas Cassel wrote:
> > On Thu, Sep 20, 2018 at 12:34:15AM -0700, Bjorn Andersson wrote:
> > > On Wed 19 Sep 22:22 PDT 2018, Greg Kroah-Hartman wrote:
> > > 
> > > > On Wed, Sep 19, 2018 at 06:09:38PM -0700, Bjorn Andersson wrote:
> > > > > When freeing the fw_priv the item is taken off the list. This causes an
> > > > > oops in the FW_OPT_NOCACHE case as the list object is not initialized.
> > > > > 
> > > > > Make sure to initialize the list object regardless of this flag.
> > > > > 
> > > > > Fixes: 422b3db2a503 ("firmware: Fix security issue with request_firmware_into_buf()")
> > > > > Cc: stable@vger.kernel.org
> > > > > Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > ---
> > > > >  drivers/base/firmware_loader/main.c | 7 +++++--
> > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > 
> > > > Is this being triggered by some hardware somewhere today?  Or is this
> > > > just a fix found by code inspection?
> > > > 
> > > 
> > > Hi Greg,
> > > 
> > > Yes, I found this issue while attempting to load the firmware and boot
> > > one of the DSPs on one of my Qualcomm dev boards after v4.19-rc4 and it
> > > can be reproduced on the upstream Dragonboard 820c.
> > 
> > I still see this issue on v4.19-rc6.
> > 
> > It would be nice if this fix gets merged before v4.19 gets released.
> 
> This is the first I hear of this and this patch, so you should re-send
> it and I can review it. Also please Cc Rishabh.
> 
> Rishabh, had you heard of this and can you confirm as well as
> 422b3db2a503 was your commit?
> 

Thanks Luis,

It seems like Greg did pick the patch yesterday [1], so hopefully he
sends himself a pull request this week for inclusion in v4.19-rc7.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/log/?h=char-misc-linus

Regards,
Bjorn
