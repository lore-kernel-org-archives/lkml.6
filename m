Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A31ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DEB208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxetmRxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DEB208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeJRFOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:14:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40538 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeJRFOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:14:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so13118321pgm.7;
        Wed, 17 Oct 2018 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sXhjC/rCeJpbrfpVT51O5F3INgb0s/dqkq5GUvPgaYw=;
        b=WxetmRxST2MHmEEsBdQefCPDjWgki7Z7GyxOqzpCH5RsfyYQ4mP5nlCrebwIDekzUV
         2opL29x47dHLn/jpdJuy5A1SC/Xnj9uQDd2z9pxCGo/qHph5WfXCpSj3rYoU+6ftoJoJ
         plYfJgo2ruR60ZXNdUlMIsjGwKXCmSo36+iEo/CM+xUEA90mmOE4BFV6oUa2sPWdEGaD
         11FbepUCmmDvlbk5SsxSca1Fjoc9ka/KBFAgBfRlxP9+xMooqwoR+e8qr2aNg8treZ8c
         zh5aO2g+Mole0hN7AlKXBT5pnydt92JFSQfhjQ3sRagfEySDGdSdd/jkjE+nlig5HWae
         nutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sXhjC/rCeJpbrfpVT51O5F3INgb0s/dqkq5GUvPgaYw=;
        b=YIZZJDB28SE76Z+GSlkO+XqPbdviM0FkmGkhGe9E8O2FsLZbtAyGr/8qRXR3dXuWHB
         P0XUX8H2CHpRgChr7/SXsRXNAU0BT0mH0ihJ0H/XVk2SyzUFNG9+5qZrfZCaUPVXetCt
         whpK3B3oYYj62nnQmo9LyS4iK0PZ8Ew8yWIyTn/0R3W5cn/uhMQa4nmFpZyRywsC79Pt
         Lnva/D+wcbaU5RxnqELRPGBCg/jFcvLuUzIflyiDMnRWlxkT5Hz2OPyhGryJiGINY+oC
         UHnvI3AAnGSOETl6neiQzAt4SXtPgs0e1CijoDiq/egvII1L7qnsaHkl2GKIkqMe6F4w
         TvRw==
X-Gm-Message-State: ABuFfohDeHWZAOByH4yUQJ4x3Ks/3rsDmUq1QAbxBPKeBgxOw+ceG92C
        +HrXzFp8+vyzw5HbNdqeo9day6Mh
X-Google-Smtp-Source: ACcGV60v3yQoQq3L9bpLSGtcxd7vHvQJpyXqMgVmp6tVFxq5pLOmTGAn/6Dv44O8tLmZ4tqBGXr9XA==
X-Received: by 2002:a65:5188:: with SMTP id h8-v6mr25811708pgq.288.1539811035593;
        Wed, 17 Oct 2018 14:17:15 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id w66-v6sm13014038pfb.51.2018.10.17.14.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 14:17:14 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:17:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] hwmon: (ina3221) Make sure data is ready after
 channel enabling
Message-ID: <20181017211714.GB10990@roeck-us.net>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
 <20181017012426.26958-5-nicoleotsuka@gmail.com>
 <20181017165543.GA22822@roeck-us.net>
 <20181017205348.GC15941@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017205348.GC15941@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 01:53:48PM -0700, Nicolin Chen wrote:
> Hello Guenter,
> 
> On Wed, Oct 17, 2018 at 09:55:43AM -0700, Guenter Roeck wrote:
> > > @@ -676,6 +701,13 @@ static int __maybe_unused ina3221_resume(struct device *dev)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	/* Make sure data conversion is finished */
> > > +	ret = ina3221_wait_for_data_if_active(ina);
> > 
> > This is quite expensive and would delay resume (and enable, for that matter).
> > A less expensive solution would be to save the enable time here and in
> > ina3221_write_enable(). ina3221_wait_for_data_if_active() can then be called
> > from read functions and would wait if not enough time has expired.
> > 
> > 	if (time_before(...))
> > 		usleep_range(missing wait time, missing_wait_time * 2);
> > 
> > or something like that. This could be done per channel or, to keep
> > things simple, just using a single time for all channels.
> 
> I was thinking something that'd fit one-shot mode too so decided
> to add a polling. But you are right. It does make sense to skip
> polling until an actual read happens, though it also feels a bit
> reasonable to me that putting a polling to the enabling routine.
> 
> The wait time would be sightly more complicated than the polling
> actually, as it needs to involve total conversion time which may
> vary depending on the number of enabled channels. I will see what
> would be safer and easier and apply that in v2.
> 
It isn't that complex; we have done it in other drivers. It is less
costly and has less overhead than extra i2c read operation(s).

Thanks,
Guenter
