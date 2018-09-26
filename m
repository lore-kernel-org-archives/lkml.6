Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C197C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1589421531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUStCvub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1589421531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeIZXMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:12:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39349 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeIZXMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:12:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id w21-v6so9871598lff.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8CDYY88wS5pqDRjpxTt226fETzlWS39lNRgwIYkq8+c=;
        b=XUStCvubUqzHTZnt2FIekUxpj8FphpuhsoQ6EZHbnHbM7fcC6axC6jzvIRIz+R4Njt
         jYYtsuaEh1riGguHQyHzhiiJM8eFSGnTZnQ4ofmKJmhWTFRdSmUdhJ0nl0y4T8ppcgUy
         GF6eEaq1+E8uAKqCgtT/Aj4j8w5Lr9J8wL5JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8CDYY88wS5pqDRjpxTt226fETzlWS39lNRgwIYkq8+c=;
        b=qloumFkxCLp5z6oq5/QK26O79tfLqYQaWZ1LxirBWny6t6U+/954/SZgqA9/WeYRIx
         J2Qc6iLDeu0xke2KCnfwujDdMZ5NoZQBBMfty9WbnQE4hFO6WGKbUMMRWUEmkQLX7r8h
         H9H+8bPMKX991W9v3nVfWKUBOWUaAlWY6DZTbbGJIJYavh/UUGifmTaRclk0cfZwz2MD
         Oy7zbN4r29xViuR1tIuMA/r6z76mjXY2wbrGukT1KIUdW6ac/lcR+jLcfvJKYnSErPvd
         s09djPKhc+Oc6uwGV4t7v9DcCAYayBB8YNBBNn5M9ghC3DtEDlsqBxQpWgC7OBJmctet
         4QIA==
X-Gm-Message-State: ABuFfojJcDddc2uxLGTHzFRkS+eHFbVjeduLsb/znL0yMnNEUt8QJ7OP
        Y3LFE0EyMwAGZPnwVkc87uKd7A==
X-Google-Smtp-Source: ACcGV61JxVLiNrrnFA1C36xjWFOMR7184BBa9nKiLOXJKkpu0vdx4he+UHTQetIsll4PqW23oyrecQ==
X-Received: by 2002:a19:dc42:: with SMTP id f2-v6mr5106650lfj.48.1537981141719;
        Wed, 26 Sep 2018 09:59:01 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id b132-v6sm1107659lfe.56.2018.09.26.09.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 09:59:01 -0700 (PDT)
Date:   Wed, 26 Sep 2018 18:58:59 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] remoteproc: qcom: Rename Hexagon v5 modem driver
Message-ID: <20180926165859.GB1773@centauri.lan>
References: <20180924234526.22916-1-bjorn.andersson@linaro.org>
 <20180924234526.22916-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924234526.22916-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 04:45:26PM -0700, Bjorn Andersson wrote:
> The qcom_q6v5_pil implements support for the self-authenticating modem
> subsystem. With the introduction of other q6v5 based non-TZ based
> remoteproc driver the current name is cause for confusion, so rename it
> to be more specific.
> 
> No functional change.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Chances since v2:
> - Updated module description, driver name and header comment
> 
>  drivers/remoteproc/Kconfig                         | 14 +++++++-------
>  drivers/remoteproc/Makefile                        |  2 +-
>  .../{qcom_q6v5_pil.c => qcom_q6v5_mss.c}           |  6 +++---
>  3 files changed, 11 insertions(+), 11 deletions(-)
>  rename drivers/remoteproc/{qcom_q6v5_pil.c => qcom_q6v5_mss.c} (99%)
> 

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
