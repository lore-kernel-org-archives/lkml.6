Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53412C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B51A2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfAGjXld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B51A2174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeHMVej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:34:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38855 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbeHMVej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:34:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so7930811pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v05XecxKaneX5JmfGAB8PKgvBKqn8Kau5A0uKb1N9LM=;
        b=YfAGjXldTJClX9VhXWZi9zPpx5VlhzGuZ5HdR4/3WpMQy4GGddrrJ2jiT/+YUv78uV
         T4Ch7Fp6WJUCbGG5242tCR1YZtgyookWBteK/Lz6Rus3JyDn9agmRFZgf39wCy9wZO2/
         8ubPW1+zJE4JEsJQJcVa7+K03T1EiqwbXkYuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v05XecxKaneX5JmfGAB8PKgvBKqn8Kau5A0uKb1N9LM=;
        b=WkpY7t+/KKIqCAAro5zhxqG85+zHippL6NDvhP9AuIj62HAlixwLaUbjI/2Xue0UC5
         8VV2oue+lwtP+vYXVrdwWOcZ0xLBoG/KI+5cdL7JdkbFnW9z1SfJJcyWfjZdMyvTF62Q
         gaCvNUwmX64lSqNxcyFgl7Gcxv1ZRBKH3LlhdP85SruYJKlu5GUPsuhxfe+JSNEEzU/q
         VGYArHHVwbhVRlrpenZqX5HCXbu32uyuvDjx9iQIM9jEY9e7GplrV/Vbkaulm6uTtjAy
         0MlZIQQtlxPD2cxeOluSegOATBsRRnA6dnLC7Fy51FTdRw9rosheRRpAVDlhqIbj7MZ7
         9Opw==
X-Gm-Message-State: AOUpUlFSugBMSrns8LH3Dxhgosn9SeRZpfEBEzOYFUVmzj2HRnsNWLHB
        Wox3jU8Utpsghpb3hKrQUCDasA==
X-Google-Smtp-Source: AA+uWPwCuJ1T7OR6VerkwDUzGymjUAwd7M4TWPws3tDuQdnELFZv/acb5FJgXA4Qo6SKLP1OtxkBAQ==
X-Received: by 2002:a65:4587:: with SMTP id o7-v6mr18377350pgq.317.1534186272353;
        Mon, 13 Aug 2018 11:51:12 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h130-v6sm68804144pgc.88.2018.08.13.11.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 11:51:11 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:52:24 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     linux-remoteproc@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc/davinci: Mark error recovery as disabled
Message-ID: <20180813185224.GG5090@builder>
References: <20180723232757.9147-1-s-anna@ti.com>
 <0550997f-8e32-fb56-2a70-74235b969ce2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0550997f-8e32-fb56-2a70-74235b969ce2@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13 Aug 08:11 PDT 2018, Suman Anna wrote:

> Hi Bjorn,
> 
> On 07/23/2018 06:27 PM, Suman Anna wrote:
> > The Davinci remoteproc driver does not support error recovery at
> > present, so mark the corresponding remoteproc flag appropriately
> > so that the debugfs flag shows the value as 'disabled' by default.
> > 
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> 
> Can you pick up this minor patch for 4.19 please, I do not see this in
> your rproc-next branch?
> 

Of course, the patch is applied now, will send my pull request in a few
days.

Regards,
Bjorn

> Thanks,
> Suman
> 
> > ---
> >  drivers/remoteproc/da8xx_remoteproc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> > index b668e32996e2..53160d5ed543 100644
> > --- a/drivers/remoteproc/da8xx_remoteproc.c
> > +++ b/drivers/remoteproc/da8xx_remoteproc.c
> > @@ -284,6 +284,9 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
> >  		goto free_mem;
> >  	}
> >  
> > +	/* error recovery is not supported at present */
> > +	rproc->recovery_disabled = true;
> > +
> >  	drproc = rproc->priv;
> >  	drproc->rproc = rproc;
> >  	drproc->dsp_clk = dsp_clk;
> > 
> 
