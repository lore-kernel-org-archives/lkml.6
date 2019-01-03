Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2292C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F47B21874
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LGza2vWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfACXut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:50:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39806 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfACXut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:50:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so16567089pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 15:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sP8rwTZwCQNqk6WbMpo3Rzykb4VpkSWtxKB0rRPwXo8=;
        b=LGza2vWXbohPt8Pw+wdRGJHW1MiDy6nsPoZHpITcdmMYXatR7mk3rEbTgBhhvJNUME
         88BODb14uvTpc2fQRO7vt1vLc0oVX2jTAxrwN1JT4rJqlge1rJ1rm2UgyNb/PkUolNpM
         BffJlax+gl6HWWp4uF0ieqCSyNw/v53piDvEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sP8rwTZwCQNqk6WbMpo3Rzykb4VpkSWtxKB0rRPwXo8=;
        b=HerPPwgbVJMSFYGw1YlJB1738/FBzwpTiwnODL9slw6tBGM9gfM2Gnqa2VKO4CTzEY
         CLdbyPcM7crbGZqDl342O8t3n9g7XqEa5ifXxwc395c3Du246rdtocjrf0EX+KAmcr9h
         m8fhCfS9u2wGtQg6w15+dNoEu/sWR6dDokX+GXnOrlSXoCO4l/Ji4sx6PhZFQK1EgibZ
         jERpq+ZsEi/L1AXYyIU3ZM/nPFIEwiwYZhT8PX/1KhmtWfwG873B6Wkz6YlYFaA/+xV1
         iITZtChOATP+KuObqeNi91XAaCmIZSBkbQ4Xcaczb/MXmvnLG83ZP/TMCQSzxSX4UIYt
         FUDw==
X-Gm-Message-State: AJcUukdn7fATj3k/FxovqY9n3owiVIzmI/TH2pjO9AGQBOH1bZW3RKjz
        HoAJJ+LDgRGnw+ICfc/K3FKGhw==
X-Google-Smtp-Source: ALg8bN5Or1i9IsblxGJRvjsW6ReX3naAJBPSdLYexclmqjtK819iMcCq1QGHTOnszS7ZKi3no8XOrA==
X-Received: by 2002:a17:902:a9c4:: with SMTP id b4mr48806592plr.298.1546559448544;
        Thu, 03 Jan 2019 15:50:48 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id q187sm95851528pfq.128.2019.01.03.15.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 15:50:47 -0800 (PST)
Date:   Thu, 3 Jan 2019 15:50:45 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add firmware
 bindings for Q6V5
Message-ID: <20190103235043.GA195759@google.com>
References: <20181228044819.5697-1-sibis@codeaurora.org>
 <20181228044819.5697-2-sibis@codeaurora.org>
 <20190103233014.GA181833@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103233014.GA181833@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 03:30:14PM -0800, Brian Norris wrote:
> On Fri, Dec 28, 2018 at 10:18:18AM +0530, Sibi Sankar wrote:
> > +- firmware-name:
> > +	Usage: optional
> > +	Value type: <string>
> > +	Definition: must list the relative firmware image path for the
> > +		    Hexagon Core.
> 
> Relative to what? I still think it's a terrible idea that your driver
> looks for files at the top-level /lib/firmware/ directory, but now
> you're leaking this into the device tree. This should at a bare minimum
> be namespaced to something like the qcom/ sub-directory. But ideally,
> the driver would automatically be deriving a further sub-directory of
> qcom/ based on the chipset or something, and then the only thing you'd
> describe here is some kind of variant string -- something akin to
> ath10k's qcom,ath10k-calibration-variant (see
> Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt), which
> doesn't require a full path-name or any hierarchy.

Oh, I see Rob actually recommended this binding in v1, and it's (sort
of) in use by a few other drivers. Is it really expected that we put
arbitrary pathnames in device tree? None of the binding documentation
seems very specific to me, and their implementations *do* allow
arbitrary text. As it stands today, this is a great recipe for name
collision -- e.g., how the driver today suggests "modem.XYZ" names; is
Qualcomm really the only one out there making modems? :D

So my natural instinct is to avoid this. But if that's what everybody
wants...

Brian
