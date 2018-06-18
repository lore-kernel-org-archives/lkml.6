Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422B1C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83752075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTfdVyzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83752075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936815AbeFRWWS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:22:18 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37870 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935570AbeFRWWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:22:16 -0400
Received: by mail-ot0-f195.google.com with SMTP id 101-v6so20367520oth.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 15:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=veGlI0dob+fpOa3CwlGfeDHosNaAn6xPLG+6MGg4YyU=;
        b=UTfdVyzEBvokncBnq/iBz0VpPYJpmFuGdweS8aKNel6inJK7QW7tu9Dm8s87oxs41v
         CWD+BNK7U//mLxnr9EVrKF7DfT1J3cmy8UedhMfjF3Rs9wUpzQSYKOq3ZXgQgddPL8aG
         GFDiLPjde0uRrpqNPWIquBIsGnPkmDX5Q29Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=veGlI0dob+fpOa3CwlGfeDHosNaAn6xPLG+6MGg4YyU=;
        b=izwtEAamTk98izsaUT7LH0EgX4dgGhes4jUWCkWbut/0WzSTlohdebz8EXILKR/Lfy
         uphE8d+MwUUL3vk/0ZPU6nKE7MmdieXCEPaRO3qbnnEsIRZ62nPUeDCDide0i/Yg+8XT
         Wm6vKdSkFcfJwYjd0x0Fy9AVb1wIDEk1OWdj58BvktpavjkJFFNC8ceoYirhKQiV7IK0
         EoPrLdJTZijKbg2UnlPY4ot855uSR4uv42/Rsdngx2fafUFTRaOmPAzlFrA40m4nUv8/
         tCmIl+H8kYmR8AVlvZ9puftpKJTx0jFJlDHi8QZfhtIOYRttIyobN1IaeVOU7C7ouP4G
         XNgQ==
X-Gm-Message-State: APt69E09w25UK9UUThmMBb4ZdlvpIE7R4X1NU15m7d0AXFFcD8HtVxU3
        Z5NkF3QQRn+hxCtSCB2/vFX//Q==
X-Google-Smtp-Source: ADUXVKKh6elAtfVO4Vt6ZpKliXayrI+DEZ/+sW+xUMDnvMExANrL3P40LbKaELv5DFHOpvPupXjPkw==
X-Received: by 2002:a9d:1baf:: with SMTP id z44-v6mr9395077otd.17.1529360535522;
        Mon, 18 Jun 2018 15:22:15 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:88f5:ab30:e569:4ad6])
        by smtp.gmail.com with ESMTPSA id g8-v6sm8670385otc.68.2018.06.18.15.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 15:22:14 -0700 (PDT)
Date:   Mon, 18 Jun 2018 17:22:12 -0500
From:   Andy Gross <andy.gross@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] remoteproc: qcom: mdt_loader: Make the firmware
 authentication optional
Message-ID: <20180618222212.GA4689@hector.attlocal.net>
References: <20180604203038.14080-1-bjorn.andersson@linaro.org>
 <20180604203038.14080-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604203038.14080-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 01:30:35PM -0700, Bjorn Andersson wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> qcom_mdt_load function loads the mdt type firmware and
> initialises the secure memory as well. Make the initialisation only
> when requested by the caller, so that the function can be used
> by self-authenticating remoteproc as well.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

looks fine to me

Acked-by: Andy Gross <andy.gross@linaro.org>
