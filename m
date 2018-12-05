Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AC7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2CE2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hldhOlYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2CE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeLERh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:37:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44184 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeLERhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:37:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id k8so10388767pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AmzNhdc2uNUS1RR8BeK6upmAuUhAphSGk6FTB8MPKUg=;
        b=hldhOlYDzw/NguE+MLH0OEE91csNaCL7e9ZvkU7WYu/bTPiTdA8CXB3ecFH5Po1X3M
         VePKFsn+cKy0dqy3OxyNI/7CK2zEZ66ZwG2PUe1JlbjH8gW3Mhl3e7MTz5O7XMop2KMS
         0okwLkYHyPJF1L8pgs0gthsZFX235EH3xmNfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AmzNhdc2uNUS1RR8BeK6upmAuUhAphSGk6FTB8MPKUg=;
        b=IF/I8cN+dPeJH1BIxPVya7I61c1o4eEjuOp33n8RQSVcD6q+Be7LuKNv1pEbcd4sJk
         JaGmql1mN6VQooA8Aa9lymMlFEk3r++yWrcWiwO9UJY8zzTvetcltoQgayKAn5m31why
         j8hUNqjvMv8zQEUUciEhC1VTp6KDLwiSifItguLX8G+FlHDQJ8Y6L3096ufpYBX63cKU
         huJpnPqtBlzgjJXsIskeGEwSJk9MwHjD3/oH9GdzIT0HNFeRPSqFhQo1Dx4+uzUpY0qH
         KpjPrXksTYfROIT6CngYnZfGUptDqL+IRtz2B7G9wW8+l0ZaTTYxVe0jpVQ8qfDjmK6y
         fGiA==
X-Gm-Message-State: AA+aEWbR0ssTSZogHdpJPxtklfRAveULDwMxUu8/6fpuxqzTPLqqmLY8
        qIeKUDBEn9vcqnh852l758LlGA==
X-Google-Smtp-Source: AFSGD/XdKRjYEOVLvM1br9YlQv8cdsoVPL2o7Klz64nNEVwvPmKbri1AMSJmK/SHPi4N3UFzLX3s/w==
X-Received: by 2002:a17:902:ba89:: with SMTP id k9mr25424863pls.189.1544031444986;
        Wed, 05 Dec 2018 09:37:24 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f62sm24756143pgc.67.2018.12.05.09.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 09:37:24 -0800 (PST)
Date:   Wed, 5 Dec 2018 09:37:21 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Govind Singh <govinds@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom: scm: fix compilation error when disabled
Message-ID: <20181205173721.GA5232@tuxbook-pro>
References: <20181122023226.1074-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122023226.1074-1-jonathan@marek.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-arm-msm

On Wed 21 Nov 18:32 PST 2018, Jonathan Marek wrote:

> This fixes the case when CONFIG_QCOM_SCM is not enabled, and linux/errno.h
> has not been included previously.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> drm/msm includes qcom_scm.h, but can be used with non-qcom hw (IMX5)
> 
>  include/linux/qcom_scm.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index 06996ad4f2bc..1637385bcc17 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -67,6 +67,9 @@ extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
>  extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>  extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
>  #else
> +
> +#include <linux/errno.h>
> +
>  static inline
>  int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
>  {
> -- 
> 2.17.1
> 
