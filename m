Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD20C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC62621533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0Em/lR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC62621533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeIZXMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:12:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45287 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeIZXMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:12:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id m80-v6so13321962lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KxVkBFt0Ix9hLwph/0DAvvOX+EuZetLr03JPVMZWZ5Q=;
        b=N0Em/lR7KHX18PsiB3ZqAFUWx0Bk4e2eAnpvamxmmzhioKNgmmWHWlPgkuDVefk1FR
         DFN9I7PRTcg73HUdM0U1winVryHHOQ4dG0qJCUSkWEfFIkjCL9AI788ni/ZW9u/w0h6u
         2cRE3Ow9LlZjrjmeLI3+2sWVuBm+Jsk1A9Jj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KxVkBFt0Ix9hLwph/0DAvvOX+EuZetLr03JPVMZWZ5Q=;
        b=pEZWrr1g93B92X1H+m7miCjmt0gwfumPGr0Pmj7knihHjZVbhldHePYs7PUdbIPAGV
         em/AxF7jaswNlb8zzoxg2f+2/C3np14rpkoUOQeFAdwL2KJLkvzzI5BDVoxS0I6bgahK
         Padtp4Jr9PgCQacKFj9NWCLBLb3KkeV0JlSnE0N/n+vXgL2B7JhasbJY92Ol+4TvxHLI
         JLLvWLfsgEh7Q7JsK7Crv8VBUqrfinlnDwHizp8ls22fkKfnYieoxoRrF8/l/KSp2/fY
         HVeHbkeZhe793oiyTA3QEp3YUQWhl1PO/qmGkn+NP/bMSnhCS+Zg34ulV1YXxYSNGl1J
         TBAA==
X-Gm-Message-State: ABuFfogkqtiASAF7bP5aS3fSa9sC732k7MQ/yJvC2NkjeaHc6bjOfcgy
        KwyI4ukUNqPuLicmmyK5yKGvXg==
X-Google-Smtp-Source: ACcGV60AIK4eI9LmMotWjRFCic+QqlpjiEnIab0iCsliNUm7V11CsIysC5Ti/e3HizVPRHga4eGmZw==
X-Received: by 2002:a19:8fc7:: with SMTP id s68-v6mr4556343lfk.75.1537981119851;
        Wed, 26 Sep 2018 09:58:39 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id r83-v6sm1113260lfi.60.2018.09.26.09.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 09:58:39 -0700 (PDT)
Date:   Wed, 26 Sep 2018 18:58:37 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v3 1/2] remoteproc: qcom: Rename Hexagon v5 PAS driver
Message-ID: <20180926165837.GA1773@centauri.lan>
References: <20180924234526.22916-1-bjorn.andersson@linaro.org>
 <20180924234526.22916-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924234526.22916-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 04:45:25PM -0700, Bjorn Andersson wrote:
> The Hexagon v5 ADSP driver is used for more than only the ADSP and
> there's an upcoming non-PAS ADSP PIL for SDM845, so rename the driver to
> qcom_q6v5_pas in order to better suite this.
> 
> Cc: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v2:
> - Move the rename of qcom_q6v5_pil to the 2nd patch, where it belongs.
> 
>  drivers/remoteproc/Kconfig                    | 27 ++++++++++---------
>  drivers/remoteproc/Makefile                   |  2 +-
>  .../{qcom_adsp_pil.c => qcom_q6v5_pas.c}      |  4 +--
>  3 files changed, 17 insertions(+), 16 deletions(-)
>  rename drivers/remoteproc/{qcom_adsp_pil.c => qcom_q6v5_pas.c} (98%)
> 

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
