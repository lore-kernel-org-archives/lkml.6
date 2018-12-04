Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ABEC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F8320850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLnYTrV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F8320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeLDAbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:31:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36797 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeLDAbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:31:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id u3so14060001wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 16:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gYmMpe+dwKX9iz1wS/BSQY7uYIuWc/jRARr3zggRsk0=;
        b=OLnYTrV2D85Kh9KZ5rsrNjZGW9oTQyq1cWre87kiESIJtMx8bj/HKMqYeKN+ynSm2D
         NDyZaoq8TUrg2PgIrFzp8ep2y+sZzLd9ZCuAa7HwCe6id9kIQSgtt+C2eEo2/XZLuzrH
         ari84Pp8Ltd4/P6uFXrKtTgNYpfZx7Th9/rUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gYmMpe+dwKX9iz1wS/BSQY7uYIuWc/jRARr3zggRsk0=;
        b=n1zCDXKKBnSLM6jmTBnXYCS2zgNjL9e7woMTDHGEFx4epiOI5yHRYS1xVblyQf09EB
         RI5XcUtIIj0YgPnbPW9058NOAa88LqZWfsP6C+xi5WUXWEsjButb4ht40KaitQjGd/nj
         w7EroiZzwVvJDVBOIuUFV+Gqr0nh+9gfcVx7tbaO9Eh70vaNDLJTwb31jOWb7GUM6Di1
         HbRH1SevEla14MUFY+dAhG1Xa6wUJvQevx2zw54IjbU5Y5jVEwuL6kEy9hXOFrbYpSUj
         qwHTOC/66fVV5a7ZAOtKkUvXDXoLsxB4Vm3cDH+bEq9j7iCJA1eKeM7qwnDpC8rieEIP
         qabw==
X-Gm-Message-State: AA+aEWYkl75gxx98+t3UU/U5/lHdm3z5reksbGNCeI0W9CNKwP9TvU/e
        1/jHjQO4aNaPiLl9YpdWXerWRw==
X-Google-Smtp-Source: AFSGD/Wdq/gqhVUMh/CK75JdE/P1cWEpNU2nueN2B4WtA99hSzxRGWM06bCzY9MCgJc8Q/7Ql5EXbQ==
X-Received: by 2002:a5d:444a:: with SMTP id x10mr16759111wrr.162.1543883502249;
        Mon, 03 Dec 2018 16:31:42 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id q12sm6741201wmf.2.2018.12.03.16.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 16:31:41 -0800 (PST)
Date:   Tue, 4 Dec 2018 08:31:35 +0800
From:   leo.yan@linaro.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] coresight: cpu-debug: Support for CA73 CPUs
Message-ID: <20181204003135.GC22447@leoy-ThinkPad-X240s>
References: <1543540924-16321-1-git-send-email-leo.yan@linaro.org>
 <CANLsYkxc21RbNft+k_oBA=4ZPCBr_rhYSV2vxiHceyJH3M6jVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkxc21RbNft+k_oBA=4ZPCBr_rhYSV2vxiHceyJH3M6jVw@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 10:34:07AM -0700, Mathieu Poirier wrote:
> On Thu, 29 Nov 2018 at 18:22, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > This patch is to add the AMBA device ID for CA73 CPU, so that CPU debug
> > module can be initialized successfully when a SoC contain CA73 CPUs.
> >
> > This patch has been verified on 96boards Hikey960.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> > index 45b2460..e8819d7 100644
> > --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> > +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> > @@ -668,6 +668,10 @@ static const struct amba_id debug_ids[] = {
> >                 .id     = 0x000bbd08,
> >                 .mask   = 0x000fffff,
> >         },
> > +       {       /* Debug for Cortex-A73 */
> > +               .id     = 0x000bbd09,
> > +               .mask   = 0x000fffff,
> > +       },
> >         { 0, 0 },
> >  };
> >
> 
> I have picked this up - thanks.

Thanks, Mathieu.
