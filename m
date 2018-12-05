Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0DAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B6020879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XkhnWwL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B6020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeLEWoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:44:38 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41338 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEWoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:44:38 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so19036100oii.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 14:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H5hNIsE+vi31DoIW4zfBtZTjXbV1Bwzu9KSl0XAsVUw=;
        b=XkhnWwL4SWUbaTr//vN/MOVQaFsIh+4Ox4ibOkfqnrPbKbUFLyQimoXiapkxVD/Cg/
         5/UL7wlFB+tE4QJuwP/PhpgFkGdGbXorHoUr9gSZpBUM5tKSOEOfmEDr7sOD5Pg8E2gc
         +0v1NWh1etykEPsudz679SK3LWdq3A2j+Vb4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H5hNIsE+vi31DoIW4zfBtZTjXbV1Bwzu9KSl0XAsVUw=;
        b=bjG5IEGXKPt1kCnuoLqfuO6aanEBI1WIjcBpMlKF+Lsf7L2SN1Hek/6ODxNYwyGuXr
         SC0sQXUP7sgtQSa5mp4Sqhq/SWgYFFi6b1cET7NsoIlAQdaNeJ9AR3ZaHvDWBVLtgHJV
         yUhN53Ne+qIMLmkCQ8YH9Hm1/vtn7Ep9JSB1KEfvohrdIMoiQ4avjiVU79smGzeas700
         M85+MZkLbHrlhCyNjqMAaahTkbnijnK5FIrV+8YGxwZ6ZxKwR5J9CKLoMP97qLMLZlM2
         Gfh+ZQmM4V5VpgtgaQqVGbEDUhu/dYuboljmG+lgQ83ZvgtFjgzDi/D7gCLl2EPa0JBs
         YVJQ==
X-Gm-Message-State: AA+aEWZ9a1k7+PO6cGOF6tYOenMEtEx5h5+hTHQGFClgxSp8ggijW5Qu
        kDt05/6OQ9WgtoMvL9RYa/jsRg==
X-Google-Smtp-Source: AFSGD/USnyKKRohiPVsGGczGPm/P7mShXNY0ymr2eBv7n7ZaF5QGPyUwPVIeZkMi4zobvw/0YOyydw==
X-Received: by 2002:aca:6a02:: with SMTP id f2mr16909627oic.260.1544049877270;
        Wed, 05 Dec 2018 14:44:37 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:1524:ebd:d530:a61b])
        by smtp.gmail.com with ESMTPSA id s66sm8343266otb.74.2018.12.05.14.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 14:44:35 -0800 (PST)
Date:   Wed, 5 Dec 2018 16:44:34 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jonathan Marek <jonathan@marek.ca>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Govind Singh <govinds@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom: scm: fix compilation error when disabled
Message-ID: <20181205224434.GC5497@hector.attlocal.net>
References: <20181122023226.1074-1-jonathan@marek.ca>
 <20181205173721.GA5232@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205173721.GA5232@tuxbook-pro>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 09:37:21AM -0800, Bjorn Andersson wrote:
> + linux-arm-msm
> 
> On Wed 21 Nov 18:32 PST 2018, Jonathan Marek wrote:
> 
> > This fixes the case when CONFIG_QCOM_SCM is not enabled, and linux/errno.h
> > has not been included previously.
> > 
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>


Got it queued.

Andy
