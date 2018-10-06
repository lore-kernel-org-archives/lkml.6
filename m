Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1F2C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C4A2086D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cj/6g9Go"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C4A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeJFNNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 09:13:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46559 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbeJFNNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 09:13:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id a5-v6so5596176pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 23:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0ksjS2PC0nIpT6aCGh5ZNcMl2T2Q2qkLQ74P02qGm54=;
        b=cj/6g9Gol2/Odho0aKpo6YIHlcu/GF3EiNZWBX43iFTJtVssgdieMdf2k6h723b77g
         c6YLkcOpczh6bFMpCLltr9ZU8QEh2vPRhm1XKHJxrkcc83FIZLK60j0FRbU72GtAh+FZ
         01y47CQ4n2V7Ogu0YOKNMFDx4doWlEufwOEck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0ksjS2PC0nIpT6aCGh5ZNcMl2T2Q2qkLQ74P02qGm54=;
        b=otXCLxgmjcs03l1atO5MnV4ZsU30J/MNMa88xpNx25YGrtF6lfO/fhcx99sQzzD5PR
         Dx5KNm249pIUmzgtMKgZPhYRdUGSS4rgx6obK+JQZG8olhexQiSO8JXweqc8hyszbjGi
         XrC3z9cBsOpjiTvwg3znUdtd+0Z3TkLJRoxVvLwt9qpsLEe6i1PB8rAepEvwNIJ2mE6z
         NFF8MR2wNpZ3+mPESJYmS83CMlplSYeheguSh4pfLu4xzlnG6q0RdjuU7Lz8rZJoX8K0
         rk8vYLldagUOXvKrFv+4dKjuHcnbP2XbXwXkMM1QcmZ0EtyHnwLCbzK/NMHsBSPrt+Tl
         VHtg==
X-Gm-Message-State: ABuFfohQ7/0Do75w7aITwDT6rP/ACtdMrKMEtH6nW6RoKcaQwUsmgdiL
        DWhRDCXTbk9njLUvE1uPFL90lQ==
X-Google-Smtp-Source: ACcGV61LlI5vcRj+r02oDVP6Gvha1Y3iUW6QOHagVJzGT0+Q630m18umQGJ7grk+ju5pTTvG/kmnAg==
X-Received: by 2002:a62:507:: with SMTP id 7-v6mr15250755pff.80.1538806278004;
        Fri, 05 Oct 2018 23:11:18 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y71-v6sm16304955pfk.70.2018.10.05.23.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 23:11:17 -0700 (PDT)
Date:   Fri, 5 Oct 2018 23:14:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] remoteproc: Check for NULL firmwares in sysfs
 interface
Message-ID: <20181006061403.GD12063@builder>
References: <20180915003725.17549-1-s-anna@ti.com>
 <20180915003725.17549-3-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180915003725.17549-3-s-anna@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14 Sep 17:37 PDT 2018, Suman Anna wrote:

> The remoteproc framework provides a sysfs file 'firmware'
> for modifying the firmware image name from userspace. Add
> an additional check to ensure NULL firmwares are errored
> out right away, rather than getting a delayed error while
> requesting a firmware during the start of a remoteproc
> later on.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Applied.

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_sysfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 2142b3ea726e..ce93f4d710f3 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -49,6 +49,11 @@ static ssize_t firmware_store(struct device *dev,
>  	}
>  
>  	len = strcspn(buf, "\n");
> +	if (!len) {
> +		dev_err(dev, "can't provide a NULL firmware\n");
> +		err = -EINVAL;
> +		goto out;
> +	}
>  
>  	p = kstrndup(buf, len, GFP_KERNEL);
>  	if (!p) {
> -- 
> 2.18.0
> 
