Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF85ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F5A214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JuHVEL/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F5A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeJJAUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:20:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36611 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbeJJAUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:20:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so1129852plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t3OAjJai2fmHllx2d0oVumLq/gJDQJzgJsW0bivknE8=;
        b=JuHVEL/Yww7qWOLLLt7zoYg7Oy0YUWa1OiK53q9z+ewByUrg752BVmbN2kXJ+/ZMjP
         uHLBJZ9hptYSzTReu/Po+3/LMcvAWlpsMP7kfSP3UOB0VgsUiGufnXr8mqc6FW7cgpcT
         k8VUb8SgZGKn+c1LHauik+jTtkfEfjdk2DDmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t3OAjJai2fmHllx2d0oVumLq/gJDQJzgJsW0bivknE8=;
        b=scl7NqOaRaMYxeByCnspTSAwNWWwNHxe/lJ431GkY5iDxV5D7gjJM+yTp1cNGoi9Si
         N0NB7D7NsV1Z7UP8zzE2oGOXk85gJ8P7uDFRM0Muj+gBdtwwhXKLdfR1NDYcTSFc5FJU
         qmjZERR1vbaHHWwP+XTHGJMblfqJV6Ts2hLgSsYbClZV3o6yyvC8JpcD9Hu/HSkP8JAv
         zpCtpjiFBJ6KF0posMhG3dIe12eY5iL+yAkmSIA6c83oa+3w8GETf4amurpr4CvVJ6/1
         qQSPTwqDs8bghPoRgFykCrZvOo4F0LAQdznJjTyJkiFa7u2D4SaQcIXWubaiBiq0T9gn
         Bujw==
X-Gm-Message-State: ABuFfoh5X9vc24MqJGQuc+m+0U/B81jJDO3/IUYFMxzhSytby5SUtp25
        n0yagwUUhL9bboL5t1LwST6fug==
X-Google-Smtp-Source: ACcGV63JNYpc1IRxbG6t94DSGDV0GX65nlayQBH+Za9vUgZclp981z6bfQTa+DRTtFUQNECWeyNxEQ==
X-Received: by 2002:a17:902:694a:: with SMTP id k10-v6mr29272151plt.166.1539104557530;
        Tue, 09 Oct 2018 10:02:37 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id 3-v6sm33779591pga.12.2018.10.09.10.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 10:02:36 -0700 (PDT)
Date:   Tue, 9 Oct 2018 10:02:33 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5-pil: add SCM probe dependency
Message-ID: <20181009170232.GA86621@ban.mtv.corp.google.com>
References: <20181009020805.143982-1-briannorris@chromium.org>
 <20181009062125.GA2518@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009062125.GA2518@tuxbook-pro>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 11:21:25PM -0700, Bjorn Andersson wrote:
> On Mon 08 Oct 19:08 PDT 2018, Brian Norris wrote:
> 
> > Similar to qcom_q6v5_pas and qcom_wcnss drivers, probe will fail if SCM
> > is not up.
> > 
> 
> Thanks Brian, this dependency was introduced with the memory ownership
> support.

That's a good point. I'm actually not that familiar with this particular
driver--I was just trying to resolve an OOPS I saw while bringing this
driver up--but that does look correct.

> I applied it with an updated conditional to make it explicit that it
> related to need_mem_protection, updated the commit message to describe
> actual relationship to the memory protection mechanism and added a
> Fixes: tag.

Your version looks good, thanks.

> Don't we also need to add the ability to disable need_mem_protection
> when we're running ATF?

I'm not sure exactly, but FWIW I'm running some form of ATF on SDM845
and I'm running with 'needs_memory_protection' (hence, this patch).

Regards,
Brian
