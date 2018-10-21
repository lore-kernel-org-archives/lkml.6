Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CEFECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA2C2083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOQoimcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA2C2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeJVE2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:28:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42679 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeJVE2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:28:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id i4-v6so18003151pgq.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WAqAbzkvbVf1GKAS3Ui86lvNdkEnl1+NmtMZORicvIY=;
        b=XOQoimcH0IymDVmLtmne0ivJJc1M5RMqTgP1cZcbXzsipNOTaezev24GohygZTusOH
         jcCMvumgVQ+nQWzZqz5HII1cScVtdFayQ/4+aIyN9LtdSjDtE89gq1FdvudEHFYSo3eU
         FLWcRqTkActc3BrzOvOzvsHQcjaCLf8GMfaTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WAqAbzkvbVf1GKAS3Ui86lvNdkEnl1+NmtMZORicvIY=;
        b=IHcJIkufKKdKoTHv+xW7rQO8G/kC/38Qc2o72O1hZdPt3DcjgX3aTmmGwuz1k3fIP2
         1p7f4k7sQp6jILqVHKdfzpXVpF6NCFp12Fz+3+4f1GHPYjko8eiqdOAP71Cu6lUnJrOq
         EjERf6K2WADba3J3kyNuSZj7I2/SNeqo82HtVu0IKphAg8UD1S4CwXhCKNpo2G93lmu+
         sFj1PCtAc9FNzjvdviikalY5rqibkWTayeWCkbBBv1AGR4aoeryDJzQXp+5gWE2P2y2D
         EbHkiF+L/+Fxww3xblyaY3EY5j6HUfcwbFscP7cc74182/pKT2fOMW47VvrknkDqlLlf
         WWvA==
X-Gm-Message-State: ABuFfohjsdHhbYlsM9xeeCCW1VJwxKRcpUOAiOn/DiX208SG7+iu4BAA
        kZj5u8XKyfQpIFcHHZS9hQLWRw==
X-Google-Smtp-Source: ACcGV60XzUixWOIj7sVzKdCa1cwQmn0g07bvz5/PSRx2y39z9rcNEnAs7Sv+/ckza5EXrqiuM+Ln2w==
X-Received: by 2002:a62:85cb:: with SMTP id m72-v6mr42792242pfk.173.1540152791393;
        Sun, 21 Oct 2018 13:13:11 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t184-v6sm32675663pfd.14.2018.10.21.13.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 13:13:10 -0700 (PDT)
Date:   Sun, 21 Oct 2018 13:16:24 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     briannorris@chromium.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [RFC PATCH v2] soc: qcom: rmtfs_mem: Control remoteproc from
 rmtfs_mem
Message-ID: <20181021201624.GB1193@builder>
References: <20180930155646.20590-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930155646.20590-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 30 Sep 08:56 PDT 2018, Sibi Sankar wrote:

> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> rmtfs_mem provides access to physical storage and is crucial for the
> operation of the Qualcomm modem subsystem.
> 
> The rmtfs_mem implementation must be available before the modem
> subsystem is booted and a solution where the modem remoteproc will
> verify that the rmtfs_mem is available has been discussed in the past.
> But this would not handle the case where the rmtfs_mem provider is
> restarted, which would cause fatal loss of access to the storage device
> for the modem.
> 
> The suggestion is therefore to link the rmtfs_mem to its associated
> remote processor instance and control it based on the availability of
> the rmtfs_mem implementation.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> [sibis: Added qmi lookup for Remote file system service]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Thanks Sibi,

This looks clean and straight forward, but I think the logic should be
moved into the qcom_q6v5_mss driver itself - as we now only care about
the QMI service being present, not the rmtfs_memory driver.

There's nothing left of my original patch, so please credit yourself as
author of v3.

[..]
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
[..]
> @@ -181,6 +217,22 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  	rmtfs_mem->client_id = client_id;
>  	rmtfs_mem->size = rmem->size;
>  
> +	ret = of_property_read_u32(node, "rproc", &rproc_phandle);
> +	if (!ret) {
> +		rmtfs_mem->rproc = rproc_get_by_phandle(rproc_phandle);
> +		if (!rmtfs_mem->rproc)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	ret = qmi_handle_init(&rmtfs_mem->rmtfs_hdl, 0,
> +			      &rmtfs_lookup_ops, NULL);
> +	if (ret < 0)
> +		goto put_rproc;
> +
> +	ret = qmi_add_lookup(&rmtfs_mem->rmtfs_hdl, 14, 0, 0);

The 14 here deserves a define and the whole thing would benefit from a
comment describing the remoteproc's dependency on the RMTFS service
being present.

> +	if (ret < 0)
> +		goto err_release_qmi_handle;
> +
>  	device_initialize(&rmtfs_mem->dev);
>  	rmtfs_mem->dev.parent = &pdev->dev;
>  	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;

Looking forward to v3!

Regards,
Bjorn
