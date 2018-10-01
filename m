Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6995BC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319902089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iorbSBw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319902089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbeJAUE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:04:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47095 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbeJAUE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:04:57 -0400
Received: by mail-lf1-f67.google.com with SMTP id q2-v6so9795371lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+HMGxKITOXk3F1e3fNwynu4kSWVS6aRObk8kt+wAek4=;
        b=iorbSBw3GCi5iNdDqz5za4C/tUcKZenBOgii3Mqs8gDP0graKx9APk0RwhriWHqdO2
         wNSeTOD9AeAgalbkA5i1gcaEEZmfujSUk3otlhNj5/kccdPAymjEZpoT+BtYf+qctoKE
         lOTBtvcfwLcBArLUJoPhhdJsXJLq3QLpQgFH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+HMGxKITOXk3F1e3fNwynu4kSWVS6aRObk8kt+wAek4=;
        b=kSuT2Fs6Zvq3dPUsrjlEScj1lbIu+nbB2ALLpRDzFFMvqdSjr7pkIxVqAZWJ24Vgzi
         LKNphKgbCtFLRyQJGzhx33Ss/CrItGpCotyjYCGZKv+h4MQk8MGBnUb5z/VBwJcnFLXP
         6UaBcqCXkfm7PbspBDRLzZjBfTGeDbngpO0Kzg1zKPlAoBjhnYlKWh7l6cqFXS8veYzV
         RFEDtnmAMw+TeS7dwKjJFyKWv4huwrMT8Jo8k602uxa/euT60XWvhbjvG7Rp3Ezc33Oh
         aS1/IiJ0StYl/++1JOMO1bkyseiqohK6AXWSpvGTdQdfr2FQbu9gRcuDjfV0F2evZbvz
         4PrQ==
X-Gm-Message-State: ABuFfoiVDcb5ZsmMwAVfylhhpVJbOtKj6poUfXAjZyTjLIM0XoC+yIfr
        0nJnMEctB91vsmLbAwZe1s0DPg==
X-Google-Smtp-Source: ACcGV62NefP2qUE+w7riddkOW+nXHpmsuSikulK2pe6C0EaLhRDLYPwTeQhcdirx+KOn5lbmyI81Tg==
X-Received: by 2002:a19:6719:: with SMTP id b25-v6mr5428664lfc.54.1538400426125;
        Mon, 01 Oct 2018 06:27:06 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id p80-v6sm2729227ljb.19.2018.10.01.06.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 06:27:05 -0700 (PDT)
Date:   Mon, 1 Oct 2018 15:27:03 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH] firmware: Always initialize the fw_priv list object
Message-ID: <20181001132703.GA12193@centauri.lan>
References: <20180920010938.10315-1-bjorn.andersson@linaro.org>
 <20180920052204.GA15695@kroah.com>
 <20180920073415.GC1367@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920073415.GC1367@tuxbook-pro>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 12:34:15AM -0700, Bjorn Andersson wrote:
> On Wed 19 Sep 22:22 PDT 2018, Greg Kroah-Hartman wrote:
> 
> > On Wed, Sep 19, 2018 at 06:09:38PM -0700, Bjorn Andersson wrote:
> > > When freeing the fw_priv the item is taken off the list. This causes an
> > > oops in the FW_OPT_NOCACHE case as the list object is not initialized.
> > > 
> > > Make sure to initialize the list object regardless of this flag.
> > > 
> > > Fixes: 422b3db2a503 ("firmware: Fix security issue with request_firmware_into_buf()")
> > > Cc: stable@vger.kernel.org
> > > Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  drivers/base/firmware_loader/main.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > Is this being triggered by some hardware somewhere today?  Or is this
> > just a fix found by code inspection?
> > 
> 
> Hi Greg,
> 
> Yes, I found this issue while attempting to load the firmware and boot
> one of the DSPs on one of my Qualcomm dev boards after v4.19-rc4 and it
> can be reproduced on the upstream Dragonboard 820c.

I still see this issue on v4.19-rc6.

It would be nice if this fix gets merged before v4.19 gets released.

Kind regards,
Niklas
