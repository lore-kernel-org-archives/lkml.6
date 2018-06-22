Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E920CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92933249A7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XS+XFZN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92933249A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754737AbeFVXRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:17:17 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44761 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754576AbeFVXRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:17:15 -0400
Received: by mail-pg0-f66.google.com with SMTP id g26-v6so3570551pgn.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FT+1Nv04SJ0jUXi8OeHnHbrEw29/JKq1HiupH1TfUS4=;
        b=XS+XFZN24LciDcjLyG0YYALt5DgjqRNO+Vzy4dEQKhONEqoSBxx3y+cK5d6DvaD8+e
         lU64s+jOtP+OVru1S5qyhNsOWtpY8G4lPHRG0iyw5XLuc/DFQ+VVRU/fcpHaczIqD2TE
         BZ6MQ8jt2dpvR9llR5nuvDOOqD12HzMKR9Qf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FT+1Nv04SJ0jUXi8OeHnHbrEw29/JKq1HiupH1TfUS4=;
        b=eS5eL9EXVc7/LtVCe0oNVmsKSgEARe17oNtsds8AW6e3bERAS0TpOjRsmqWUXjl7D4
         venj2po1ozTxPwAUF8HTXuPzzrlBNFE/xXXHUgStYhiyUVFY4n2yIJhG0tOu+iCY1jtQ
         PUcT8brNVnmYGQrM+UtthkpVrPpOApkW8nHMh8+55YU8x71U1Sw6AqM0/Bo+NiD2YMsE
         gCnkbsnva11ogHi3gaZsaLIOiuprtdDaT+AZRIQPSfr3c/knRZdJLxkuhoozy1tp6XWq
         1wO6e+NzB79beKXp5nuRJaUUibvlOxDdlONzezT9G5j+bkJMEzV8Zx+tV0W4TkG96ZtJ
         V1rA==
X-Gm-Message-State: APt69E2QC2JWU6Aa9AkgYHOrazdfRLjwzR6Xl9EJqfXV0Asf+sCeb3V1
        J0xEt5eyHEZF5qF4KrNoJmvCCg==
X-Google-Smtp-Source: ADUXVKIBvGSQ1RieMGRcOCuto1XAcbgwdkDJAykTFr9eNfE+Y1XxUO6t7OxRDHP/plcUJO+fNByn2w==
X-Received: by 2002:a62:e208:: with SMTP id a8-v6mr3623031pfi.6.1529709434604;
        Fri, 22 Jun 2018 16:17:14 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s22-v6sm9486037pgs.34.2018.06.22.16.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 16:17:13 -0700 (PDT)
Date:   Fri, 22 Jun 2018 16:19:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     vgarodia@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, andy.gross@linaro.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: Re: [PATCH v2 3/5] venus: add check to make scm calls
Message-ID: <20180622231934.GO3402@tuxbook-pro>
References: <1527884768-22392-1-git-send-email-vgarodia@codeaurora.org>
 <1527884768-22392-4-git-send-email-vgarodia@codeaurora.org>
 <CAAFQd5BSgB0OoqUFckJLXto9FNMYCTQ8ubDftaC-LvFm+A-gxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5BSgB0OoqUFckJLXto9FNMYCTQ8ubDftaC-LvFm+A-gxA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04 Jun 05:58 PDT 2018, Tomasz Figa wrote:

> Hi Vikash,
> 
> On Sat, Jun 2, 2018 at 5:27 AM Vikash Garodia <vgarodia@codeaurora.org> wrote:
> [snip]
> > +int venus_boot(struct venus_core *core)
> > +{
> > +       phys_addr_t mem_phys;
> > +       size_t mem_size;
> > +       int ret;
> > +       struct device *dev;
> > +
> > +       if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER))
> > +               return -EPROBE_DEFER;
> 
> Why are we deferring probe here? The option will not magically become
> enabled after probe is retried.
> 

The original code should have read:

	if (IS_ENABLED(CONFIG_QCOM_MDT_LOADER) && !qcom_scm_is_available())
		return -EPROBE_DEFER;

The code does depend on CONFIG_QCOM_MDT_LOADER regardless of it using
scm for firmware verification.

Regards,
Bjorn
