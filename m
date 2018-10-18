Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25452ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB35D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K32FGNLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB35D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeJRIWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:22:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36632 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJRIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:22:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id f18-v6so13323162pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 17:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EF63PHOqsqot2WwzV5xuJ1sWjkW68oS+F3aJ08W+6WI=;
        b=K32FGNLkM53O1S+uAUJH1MqaCLICNuipZDgCmeKaAyImN1UG5c2uyLkWjfR1qNi5cJ
         0Fn0VPe2TTiMzAYKaWpu62Pa7Bj4UCAoJIdV5H0k6RQp/noPvXM1yHwCqyIgb1aaVuto
         HeouzchDkqz+kitTP4rTnXnsBRhbT/maWhuJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EF63PHOqsqot2WwzV5xuJ1sWjkW68oS+F3aJ08W+6WI=;
        b=G3DDQGESs52+AkV5efJfcO/pjf0c71ePxszj25NRQAwOlaf24GfBPvnHVScj57V8qV
         qMbBSKsnx5oJbrEjs3Gv8eBjhfwOABl+U7we96SC71LjsU9F+uKQDnj3L212Iqt11Zmy
         mgD+zGGPLwJvNBt8om1FPKX+37sA00BRa6YHNPW1RiTghBHeNtn8N99W20R6frKbw9zB
         VtdAuSjsYL2/zobhXECe5L6t5929tmMvO2EXbFlJSzs8xVIG6aKuDRc31uBtyJSLFc/T
         Hhh5DLzQaQYlzb1oxnjCTgz4obo4e7iwqRtfhRUu08EMjdLrwoG2PCa0gUpYOW3T+5rv
         zkog==
X-Gm-Message-State: ABuFfoiKvvNCI93LAQFNCbzWuMOVR6N7QeqNA5LQX5aY1SH5dzOrZEkj
        DT/y9LEebU7DYjk7U1O6EI8pKQ==
X-Google-Smtp-Source: ACcGV61LB3KrINUPkwMnJ5WTVk1DUOxwoNYyF1rjRBGxRYm0YZCCn+uhDu3mPWLkwYAdokUBZGqhXw==
X-Received: by 2002:a63:8343:: with SMTP id h64-v6mr24979767pge.368.1539822243611;
        Wed, 17 Oct 2018 17:24:03 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id y144-v6sm28321384pfb.81.2018.10.17.17.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 17:24:01 -0700 (PDT)
Date:   Wed, 17 Oct 2018 17:23:59 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [RFC PATCH] soc: qcom: rmtfs_mem: Control remoteproc from
 rmtfs_mem
Message-ID: <20181018002350.GB179852@rodete-desktop-imager.corp.google.com>
References: <20180925080607.30565-1-bjorn.andersson@linaro.org>
 <20180925172943.GA118699@ban.mtv.corp.google.com>
 <37621d4fadff8e3a0bbe034119351d16@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37621d4fadff8e3a0bbe034119351d16@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Sun, Sep 30, 2018 at 08:58:49PM +0530, Sibi Sankar wrote:
> On 2018-09-25 22:59, Brian Norris wrote:
> > On Tue, Sep 25, 2018 at 01:06:07AM -0700, Bjorn Andersson wrote:
> > So rather than looking for open(), I think somebody needs to be looking
> > for the appearance and disappearance of the RMTFS_QMI_SERVICE. (Looking
> > for disappearance would resolve the daemon restart issue, no?) That
> > "somebody" could be the remoteproc driver I suppose (qmi_add_lookup()?),
> > or...couldn't it just be the modem itself? Do you actually need to
> > restart the entire modem when the RMTFS service goes away, or do you
> > just need to pause storage activity?
> > 
> 
> Hi Brian,
> 
> It might be more logical to make that "somebody" the rmtfs_mem driver
> itself, since
> the modem as such does not have any direct functional dependency on
> rmtfs_mem i.e
> the firmware can be configured to run on rmtfs_mem or internal fs. So in

How exactly is the firmware configured for this? Isn't this something
that's just determined at (firmware) build time? I seem to recall seeing
early firmware releases that booted OK without rmtfs (and therefore
probably had an internal FS?) and later ones that didn't.

Anyway, this sounds even more like an argument for:
(1) not describing this in the device tree; and
(2) as a result of (1), probably not handled in the kernel either

The reasoning for (1): this is purely a software configuration, and does
not really describe the hardware. There's nothing about the hardware
that says the modem won't have an internal FS; so you have to choose
whether to add a rmtfs-to-rproc phandle based on which firmware you're
building in.

On second thought, that might even be an argument for killing the entire
rmtfs_mem node in DT actually -- and as a matter of fact, I think you
have the same "configuration" (i.e., DT isn't just describing hardware)
problem with the rmtfs_mem node. AIUI, you may have to choose a
different memory region size based on the number of firmware features
a particular product supports. That's typically a Device Tree no-no.

But I don't know how far down that rabbit hole we should go...

> such cases
> where the modem is running on internal fs, it would be undesirable to have a
> hard
> coded dependency for rmtfs_mem in remoteproc modem itself.

OK, sure. But as per the above, the whole software-configuration-in-DT
thing is undesirable as well.

Anyway, I'll take a look at your v2.

> Wouldn't it be simpler/quicker to fix this in kernel than churning out new
> firmware
> releases. A fix in firmware will also mean that this becomes one-off fix for
> dragon
> boards diverging the firmware branch from whats used in android for
> 8916/8974/8996.

I'm not so sure. Well, sure, it's probably quicker. But this is a known
bug in Android that you've clearly added Android workarounds for. Fixing
it in later firmware doesn't preclude you also continuing to use your
hack on Android.

And can you explain: why can't this fix be applied on all new firmware?
Why does it have to be a "one-off" for dragon boards?

Brian
