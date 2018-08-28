Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3AFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111182089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPy1UOCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111182089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeH1MkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:40:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34855 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeH1MkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:40:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id q13-v6so714390lfc.2;
        Tue, 28 Aug 2018 01:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IAR6tFEcyh/+bOiWvrR54ntpMnCW7Gxlx9YoIuZ+FBU=;
        b=BPy1UOCvh+RwzrlSD7AMX5UaUSjBycb05g6Icv/Qury1U5rej+e6ObtKmZ4FU1J5jC
         PXO4nEv27xivDhRtbhHwu2bwYci38lsEjOyPr4VAjt3EPAt2idJb9ATp8txV2IGXOD21
         4MqCtvMDD4U3Xfpdote9eSLvR95QN8hI0ff1K05EQuW/wK7xhfjjDZ89MbirR0VGKOrC
         xkIFsqT8uZ53C5wLlHjqTZbIyb7lIFCu+3kHSgRxhfTyzoNRvEqcjOSflRnvjqDHcmza
         cYyWxioU9cRv1aYut7/o6Ec1HImfIXJvbqFSDd4uxsLgm+nFAp6Fy2sGG/XDc4V5rvjo
         BIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IAR6tFEcyh/+bOiWvrR54ntpMnCW7Gxlx9YoIuZ+FBU=;
        b=iMUY3ah7vXmL2htYzfz/PfCmGtmn1Y0/Y5Wqqt5lDAkZnDa0RL/pBFskeuQW0XTDv+
         t6UHcsjOCHrlTnylB15NkePfkwKjoW29sbSQTz6YQ8c5yCnxpFxoXUpKDFV/gZnIi8FQ
         f2xW8C7fMocVkBE9iqfsSnJLdPzPOqJWF3qUY+gMmkFCGndbSQTrH/IhvnGrTmPjl7lg
         yTjZ3mpMk3oYYzBFrgVvaKSfCugxjc1iqPCZLLPqg1030Mb6i8/RiV1uPyD2C0GyaJ9w
         T0KyFRgDbbJzZp6y1APEHKrnD8eXcm4ZEJ5K6egPqaKSOVNV9wU2jpGIe3DvjEdvl3Wo
         fIDQ==
X-Gm-Message-State: APzg51BZl7Cn79QeK1QL5y2AiNxokqeMDL8HxlQUj4GLlzbSyAouf3Jp
        RhxYqOqegJmyeuODNOKMlkU=
X-Google-Smtp-Source: ANB0VdaGsfOGu4qJDbdNH2RSMzu4hiuik2rS3d1aP/I6mIur9qDawM0qiVRKT7ZGphR06TfXZYUR7A==
X-Received: by 2002:a19:de50:: with SMTP id v77-v6mr590336lfg.14.1535446183602;
        Tue, 28 Aug 2018 01:49:43 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v10-v6sm97054ljg.12.2018.08.28.01.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 01:49:42 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fuZgy-0007ds-AZ; Tue, 28 Aug 2018 10:49:41 +0200
Date:   Tue, 28 Aug 2018 10:49:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, johan@kernel.org,
        j-keerthy@ti.com, a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-omap: Replace mdelay() with msleep() in
 omap_rtc_power_off()
Message-ID: <20180828084940.GA28861@localhost>
References: <20180730135314.9336-1-baijiaju1990@gmail.com>
 <20180827205517.GD24549@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827205517.GD24549@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:55:17PM +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 30/07/2018 21:53:14+0800, Jia-Ju Bai wrote:
> > omap_rtc_power_off() is never called in atomic context.
> > It calls mdelay() to busily wait, which is not necessary.
> > mdelay() can be replaced with msleep().
> > 
> > This is found by a static analysis tool named DCNS written by myself.
> > 
> > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> > ---
> >  drivers/rtc/rtc-omap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> > index 39086398833e..ef3d09525d0f 100644
> > --- a/drivers/rtc/rtc-omap.c
> > +++ b/drivers/rtc/rtc-omap.c
> > @@ -476,7 +476,7 @@ static void omap_rtc_power_off(void)
> >  	 * power off the system. Add a 500 ms margin for external latencies
> >  	 * (e.g. debounce circuits).
> >  	 */
> > -	mdelay(2500);
> > +	msleep(2500);
> 
> I'm not sure about that one because this is a poweroff function so it
> doesn't really make sense to sleep versus busy waiting (all the drivers
> in power/reset use mdelay())

This power-off handler is called with interrupts disabled (as mentioned
in the function header) and must not sleep.

Johan
