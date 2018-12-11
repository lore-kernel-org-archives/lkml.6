Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC0FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C0F2081F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jItdHyf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C0F2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeLKAKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:10:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36909 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbeLKAKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:10:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so6028453plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 16:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y3IP5Wrkr5uqRldbZYCDS+iJsMw6QUbs7xMpAd5rkjo=;
        b=jItdHyf3Cds/vgg5jMN273VcDz8jg8oKdMmwfQhNu0yBQXhq476wZa0pTEztf+laV8
         mXPSUgAZnxZQs65qGzj969lZeoTvLevsYVBHkyEA7a2VvBFKjSI4fBHGrrfiry1I6cHT
         YXklKaGN3Q90N/x0gOJ3oicTvkBW2jOxadr3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y3IP5Wrkr5uqRldbZYCDS+iJsMw6QUbs7xMpAd5rkjo=;
        b=R6uAtICBh8lS7Jgfiiu0Hx7iXkAr2b+M54zc36v6sItFvGnsF2TRP9Lbde7mKlupH3
         bzKiTa1p6VLt4tsxCuOa55/oAkgEpiZ4niysut8Qn2HTpkykDlRIYd44nF4AeMt2RqZr
         xWPgkK2xEEvBVuYZE73wnnRCwyWzTkJcwz6Cdg2GK6VN5HICtsI85oxUNtnPipUZzimb
         6RH8f/X2hChBzedoHq4x6QtaGiQM95eVMKBW4Eov5T+yBpKMeY0b9MKo/HOoO+VOqsGe
         5VvETdsnHTF8lmik2bUto/h5UDlwc+MBElSoFQ+2JU+zPIaByXMAPQKBvxW1G5WNfcsy
         UbLQ==
X-Gm-Message-State: AA+aEWYzRjDqTmM1oj2qBFvHaSmQ4GX+AvTlH2OPmAvpoBXa1BFWDRZ7
        VvuejrPJTVNhOsM8/btynjL22g==
X-Google-Smtp-Source: AFSGD/UxK+OQQqiw8kHWc5YnBZk/xEYEVPdzRkGz2Co+SUxT7xn1LGmBgxUp9ODDMyq1TRfBJ1hO/A==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9mr14167015plo.27.1544487053009;
        Mon, 10 Dec 2018 16:10:53 -0800 (PST)
Received: from tuxbook-pro (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id q187sm20123301pfq.128.2018.12.10.16.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 16:10:52 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:10:50 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org
Subject: Re: [PATCH v2 1/6] misc: dt-bindings: Add Qualcomm Fastrpc bindings
Message-ID: <20181211001050.GA1578@tuxbook-pro>
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
 <20181207163513.16412-2-srinivas.kandagatla@linaro.org>
 <20181207182327.64mtkfx6v4wlwccz@lakrids.cambridge.arm.com>
 <afdeecc4-4ee9-e933-9917-9930ece85b00@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afdeecc4-4ee9-e933-9917-9930ece85b00@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10 Dec 03:17 PST 2018, Srinivas Kandagatla wrote:
> On 07/12/18 18:23, Mark Rutland wrote:
> > On Fri, Dec 07, 2018 at 04:35:08PM +0000, Srinivas Kandagatla wrote:
> > > diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
[..]
> > > +- reg
> > > +	Usage: required
> > > +	Value type: <u32>
> > > +	Definition: DSP Processor ID.
> > > +	Possible values are :
> > > +			0 - ADSP
> > > +			1 - MDSP
> > > +			2 - SDSP
> > > +			3 - CDSP
> > 
> > Why is this in a reg?
> 
> This is to identify which type of dsp(Audio/Modem/Sensor/Compute) it is,
> This information is used to create device nodes for user-space access.
> 

But it does not represent FastRPC's address on the rpmsg bus. How about
replacing it with a "label" (or "qcom,domain" perhaps?) of type string?

Regards,
Bjorn
