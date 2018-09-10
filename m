Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD53C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720DF20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXU/ngpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720DF20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeIJUqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:46:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45556 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbeIJUqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:46:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so22472529wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WK6TCfhZ3N+1uDrq89utKre5xwnBuPm6Hhr4gqQ91dk=;
        b=QXU/ngpK0FRepeda8jN6ppZd8AF1g0cNpFyVPir7f36XTb2Y0YfOl4Gtmdl5kbtegw
         Dd6uStwGnJ+tHxoO3YTneKYOadB+U1MhjqVcpDhh3tgid9SC3UfwKPXjwOJ68F1Bgowg
         pHgV5YQGPo3/D3wK0q145uAgFWwy6wYF3LlJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WK6TCfhZ3N+1uDrq89utKre5xwnBuPm6Hhr4gqQ91dk=;
        b=WX6FIFHqHpPgaWADwfrYfRDO8WIFTPg2d7UBTlsV4Fx1XEqbajNDoeeQlbYvtrVZ5/
         NTBIBEjqqX7tTo3pO779e6Y43vKM4cqEK0EhOGpcOCPH9nMsYc1sj6k6yq9WbG6p6zZC
         zvhNGYnzCyabMl6MtChToUL4kWqVrXgNB5HvOJcGRVwm/C8CKuMKTY4qYNUm3RNdFL1t
         uKRugx2i4uz+njshc4Jumf2o4fU3moupZ0e1gmJDpwttea5waK0YVWP6Yms3mnjwyrvo
         BTY0L3hSWowy/w3ElBfhNJIDHX4Swf9K3QjnH2H2AOEnpYcKWaUxF1UOOTHXwi4h4CjN
         piUw==
X-Gm-Message-State: APzg51AFtVjuyOj4KQJIfm96cmAimcH8NOkCPqtmA4YEe5slJQiVcrsU
        l83Ncd9kAhiZMOdyiWapTlFFEA==
X-Google-Smtp-Source: ANB0VdYj8Cl4in4ON5tRp/jiaHjEOvGfKIE1s4uNXJ0smD8Nb9g0sjgOBts3t6AXb1lN4tJPyNkH/w==
X-Received: by 2002:adf:a708:: with SMTP id c8-v6mr15694745wrd.56.1536594706605;
        Mon, 10 Sep 2018 08:51:46 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id y128-v6sm17362193wmy.26.2018.09.10.08.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:51:45 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:51:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 5/7] mfd: Sort headers alphabetically for Intel PMIC
 drivers
Message-ID: <20180910155144.GK28860@dell>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
 <20180830165255.43114-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830165255.43114-5-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Andy Shevchenko wrote:

> Sort headers alphabetically for better maintenance.
> 
> No functional change.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c |  5 +++--
>  drivers/mfd/intel_soc_pmic_core.c  | 13 +++++++------
>  drivers/mfd/intel_soc_pmic_crc.c   |  3 ++-
>  3 files changed, 12 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
