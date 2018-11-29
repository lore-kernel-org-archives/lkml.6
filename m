Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCD0C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE932146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9clXkQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE932146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbeK3JnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:43:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44461 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbeK3JnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:43:05 -0500
Received: by mail-ot1-f67.google.com with SMTP id f18so3334598otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3JW6B3D98u4etHJO+8n/AZa4bWpPMV0p1A76//BfEnc=;
        b=d9clXkQRKp7Vxx9axZUxcicoVAl6MEaYkfSMF/x1IKHHzbcNKeuXzRa8RZAM2T9yJV
         +ls6MbY5CGWw668MPt8/WXvtagbWLQsQSI1ghdrjkOxl8Oua2R9qcly7u/ldiUDIzfB/
         A/k7Jf8NreyWYYofMNmQv/KZhFM83Z0AIj0mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3JW6B3D98u4etHJO+8n/AZa4bWpPMV0p1A76//BfEnc=;
        b=d7FC05pwLTGyPnTdwyFk6tNYUsEFNcO5I74x89pPMs1kwrgIHxydc/M/nVBTdLpzPL
         a/XHruCF3ta7hQhqvJrtGMqPPdXi2QtWYoWIrQfiqe4R6WX7xXHhuLCWNfwkx4pgJ2s6
         A7hEiEc8q34YrJtTn0Zp6KzscDYbVGtXT7LPmIPn6PHV8hu46h8AhEArcf9231hqZhyS
         5GDOjCyurHOC29pEts67jbza5Ybt3Z+tyIIS1O9prBDl5RhYuKkhWLVG/dJ9DzoRFjqo
         aaQzL6gRskfBa7494LEtSRbb3KFJMd2PetezpVWrWBSdrl0aiyUzBKX+CVCFl6zomSWU
         7q+g==
X-Gm-Message-State: AA+aEWbWFiHaiKF5kpJmol1xi99KTOmAi9FmI9LbrN79wNjHtsufEyUo
        3h3c7OVNqJ0NKtU7mjWYovslMw==
X-Google-Smtp-Source: AFSGD/WO2I8ekTpFCi7HsNadZ8gApVd7jCph+HE9wWDZas8Y0VsclympBnWaKsTZDjVgBFCml3UwLQ==
X-Received: by 2002:a9d:6287:: with SMTP id x7mr2177701otk.304.1543530961916;
        Thu, 29 Nov 2018 14:36:01 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:d408:b2c2:72bf:467a])
        by smtp.gmail.com with ESMTPSA id g138sm2698392oib.26.2018.11.29.14.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 14:36:01 -0800 (PST)
Date:   Thu, 29 Nov 2018 16:36:00 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kbuild test robot <lkp@intel.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm: msm: Check cmd_db_read_aux_data() for failure
Message-ID: <20181129223600.GC32306@hector.attlocal.net>
References: <20181129163826.178670-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129163826.178670-1-swboyd@chromium.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 08:38:26AM -0800, Stephen Boyd wrote:
> We need to check the call to cmd_db_read_aux_data() for the error case,
> so that we don't continue and use potentially uninitialized values for
> 'pri_count' and 'sec_count'. Otherwise, we get the following compiler
> warnings:
> 
>    drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_arc_votes_init.isra.12':
>    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count' is used uninitialized in this function [-Wuninitialized]
>      pri_count >>= 1;
>                ^~~
>    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
>      sec_count >>= 1;
>                ^~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Thanks for the patch.  Queueing this up.


Andy
