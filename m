Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3174C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D4B20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="itN1jT9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D4B20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeLNFak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:30:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38852 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbeLNFaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:30:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so2185117plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 21:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FJWMHnE+f1N7VtA5gckashrUqqP/r697ZPMLxPpbIsg=;
        b=itN1jT9QiEXRp1GyFXciM8N7EeQyMNRoBGdaEtCRJk3uShftjASv/VktKROr5QvimA
         OA/GZXuc5YUZlzIsLqLD9iG10cV3L1ZQ19bhY0JyWm+F0YexJKJGz/TYdA7ifqOV46V0
         3aApOtaQzyzm04E/Ot7Uglg3FYeQtiMW1G32w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FJWMHnE+f1N7VtA5gckashrUqqP/r697ZPMLxPpbIsg=;
        b=unSSrhbL6Anr0IKi47UUOH6gz/5hG5EcA8VdIJ64JFX+j98miykUy1VOzSGwymnTMG
         i5UyHyQFclr1J0mG65OFYSnZD4uJDX9+z3jXIPEmPxi0pOFqaiahtPFJD3xotAb6Jmjc
         EYPcqDoq4+qSaeXPBvy3bLie/tyTUnbBDTrIN/RvNzkLRECjFwIQc9HjjLzNAQngZF6X
         qH7Mh9w1X7lqLLVB+VBbpoC675FRHJo1qncVALBtxu/bpiTho8zcLgcXA5Hj1f6WrEOY
         c4B4L7rx9PJNvn37LNUKsq9lV7nKENAq0ykPf2OGrMLTi8TfBWggtg7sT62vc9Q9bKDI
         B9Cw==
X-Gm-Message-State: AA+aEWZ2IJ+Ak8w1yV7csIzgg2vhaRXt3vYEwJxXCh98z8fhAWxYJuHz
        LvpC1tbOWUS1dZ2iNLNDKx1+uQ==
X-Google-Smtp-Source: AFSGD/V4pGkGEfX0GXDSvbndIhFh2TW3d4fTH7f+TKUb4FaWrl8iWicTCw3VoGXYtZ6HAPGB+ypmjA==
X-Received: by 2002:a17:902:4503:: with SMTP id m3mr1660615pld.23.1544765439082;
        Thu, 13 Dec 2018 21:30:39 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q5sm6059436pfi.165.2018.12.13.21.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 21:30:37 -0800 (PST)
Date:   Thu, 13 Dec 2018 21:30:35 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, sre@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] power: reset: msm: Add support for download-mode control
Message-ID: <20181214053035.GK1578@tuxbook-pro>
References: <1531977529-23304-1-git-send-email-rnayak@codeaurora.org>
 <20180719054200.GB30024@minitux>
 <ca74b7f4-3e60-2f3b-3d66-ac167c913c0e@codeaurora.org>
 <153210869376.48062.15842782379577271631@swboyd.mtv.corp.google.com>
 <154282479571.88331.5041132574563990889@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154282479571.88331.5041132574563990889@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21 Nov 10:26 PST 2018, Stephen Boyd wrote:

> Quoting Stephen Boyd (2018-07-20 10:44:53)
> > Quoting Rajendra Nayak (2018-07-18 23:59:20)
> > > On 7/19/2018 11:12 AM, Bjorn Andersson wrote:
> > > > On Wed 18 Jul 22:18 PDT 2018, Rajendra Nayak wrote:
> > > >> diff --git a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> > > >> index ce44ad3..9dd489f 100644
> > > >> --- a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> > > >> +++ b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> > > >> @@ -8,6 +8,9 @@ settings.
> > > >>   Required Properties:
> > > >>   -compatible: "qcom,pshold"
> > > >>   -reg: Specifies the physical address of the ps-hold register
> > > >> +Optional Properties:
> > > >> +-qcom,dload-mode: phandle to the TCSR hardware block and offset of the
> > > >> +             download mode control register
> > > >>   
> > > >>   Example:
> > > >>   
> > > >> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > > >> index df58fc8..0c97e34 100644
> > > >> --- a/drivers/power/reset/Kconfig
> > > >> +++ b/drivers/power/reset/Kconfig
> > > >> @@ -104,6 +104,17 @@ config POWER_RESET_MSM
> > > >>      help
> > > >>        Power off and restart support for Qualcomm boards.
> > > >>   
> > > >> +config POWER_RESET_MSM_DOWNLOAD_MODE
> > > > 
> > > > How about moving QCOM_SCM_DOWNLOAD_MODE_DEFAULT to
> > > > drivers/soc/qcom/Kconfig (and removing "SCM") and referencing this in
> > > > both drivers?
> > > 
> > > yes, thats possible, but I am not sure how to make the command line
> > > option common for both. One other option I thought was if we could handle it
> > > within the scm driver itself with an additional
> > > binding to specify the non-secure download mode address.
> > > something like qcom,dload-mode-ns?
> > 
> > Is the SCM device and driver always going to be present though? It may
> > be better to make a TCSR platform device driver on designs that would
> > configure the cookie with direct read/writes from Linux to break the
> > relationship with scm entirely. Then the different configurations could
> > flow from the DTS file either describing scm that has scm call, a
> > special scm_writel address for TCSR, or a specific TCSR node with the
> > address of the download mode cookie that triggers a TCSR driver to probe
> > and register a reboot handler.
> > 
> 
> Does my proposal work? I haven't seen anything new on the list since
> this email.
> 

Afaiu the SCM device is still there, even though we don't use all the
usual functionality.

I tested on qcs404 and sdm845-mtp (LA boot chain), and they both return
positive on:

  __qcom_scm_is_call_available(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE)

So how about we change qcom_scm_set_download_mode() to do:

  if (scm_call_avail(QCOM_SCM_SVC_BOOT, QCOM_SCM_SET_DLOAD_MODE))
  	__qcom_scm_set_dload_mode()
  else if (scm_call_avail(QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE) && dload_mode_addr)
  	__qcom_scm_io_writel();
  else if (dload_mode_addr)
  	writel()

This would also mean that we can put the dload addr in the sdm845.dtsi
and share that between LA and ATF.

Regards,
Bjorn
