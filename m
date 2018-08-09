Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658A8C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B58D21E5D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P5xOExsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B58D21E5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeHIVXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:23:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40698 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeHIVXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:23:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so3161720pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u7qko/sdeAm+6MIIA1HuZcRZy8hHP1uv2MOXJBw056M=;
        b=P5xOExsP0kEQkZAExcKQHIWDQFsWln8x8+J1y8o1kTdCCtrCO3VX3Y6/qNVQhrTtPy
         qAxUDgGbKcyWbQTOdYRdxeqvFFDa3biIlX0B18v8dmEKIVIF76vYb+fozh1hmqgKm2lJ
         zGVpJvM8foQChu6bWMhES1wjDj5J+mCGBZK0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u7qko/sdeAm+6MIIA1HuZcRZy8hHP1uv2MOXJBw056M=;
        b=U/4uouTTZ+SuRFC+7zzQWS+le1P5Av6a2ik4gXgrVwNlphRDg+RNRkChG4OznRcEKL
         T+1PaUsy4eKHxbwZT4YPqn4jDM18zo1bkHxZr7319kM25VUEAAt3CXcMaXYYlIDLRx/v
         ZOwhazAUWT5Y6v3epsfHTmMYYbb3OMv9eMmqAacmmH3ozB/UH/tb+WFaSBvBz7Ai4EKe
         ilViYxxQenChRp2xh+Ox4Fc+GcLazarsbeGXso7piz0z7pcVV6lAat1BxJbVTqMAXtVI
         PCBdDaN7t0FAwfSCT3V1MNP4cfdUX+ESG+wdL1a538cIVjfLmHoGMXddwlfeTlFqdSne
         uJxg==
X-Gm-Message-State: AOUpUlHtzaIdA4WzW+tcgEY/KsfIhK/k0LOB6ZTxp/ts7o2Xir3nBP2F
        8tUiB6//zq6GEIoesVUQ7EJZpg==
X-Google-Smtp-Source: AA+uWPwjkswg28hrNWjn1KNJPbAins4M9NsLVPsSu54+og1Uyp6J7Z9uHvZfFNBXGV3uCI9w/OLvRg==
X-Received: by 2002:a63:e60c:: with SMTP id g12-v6mr3331218pgh.308.1533841058343;
        Thu, 09 Aug 2018 11:57:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id x25-v6sm7268855pgv.63.2018.08.09.11.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 11:57:37 -0700 (PDT)
Date:   Thu, 9 Aug 2018 11:57:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] scsi: ufs: Check workqueue exists before destroying it
Message-ID: <20180809185736.GH160295@google.com>
References: <20180802001435.116963-1-mka@chromium.org>
 <153370949062.220756.17724147096194635522@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <153370949062.220756.17724147096194635522@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 11:24:50PM -0700, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2018-08-01 17:14:35)
> > In ufshcd_hba_exit() the clock gating workqueue is always destroyed
> > when clock gating is supported. However the workqueue pointer is NULL
> > when ufshcd_init() fails before the workqueue is created. Only destroy
> > the workqueue if it exists.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Any sort of Fixes: tag?

I could add one, though it seems this patch is superseded by
https://patchwork.kernel.org/patch/10559013/
