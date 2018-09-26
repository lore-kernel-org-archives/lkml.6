Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC93C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A422152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVyt9m8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A422152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeI0CAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:00:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40349 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbeI0CAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:00:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id s5-v6so94784pfj.7;
        Wed, 26 Sep 2018 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=grV1xbSczCoJ5FWtNxXxnLs+g1qxw6pdhV+8m+08uOA=;
        b=EVyt9m8ggs7Ka4quSkaA1ZCk8PAN81z+Jcss4y8G94vAnMecq/kQd9Yy7VvJwn4u/F
         z4cLhkjDGddJU+avYd6TOTrG5UNdOdDZBprgwHTq2rxHIqABEuRcoZ1cGHkT7vefv8uj
         tlDihUfenKop6dh8fnN8O8hILuVPLDeTs5hje9+tspKbfxKSimKOtqWT/8wuda8MC1oR
         cmCgsFf1vezEpVhOgVXeehE2Zgqvk/JI2KBYAz2D9yREKziYv3pVgBS5yBPaxkEO/a3V
         o9CLXfcShGIRl46LaNg+o2y+G4NLPKU+cohvPBLfRAY5F5uBjNjkE2rCRgUlYfw5N5XA
         oa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=grV1xbSczCoJ5FWtNxXxnLs+g1qxw6pdhV+8m+08uOA=;
        b=Wyxu4QQab1dKSU/QXjkGqCR3+w9Ki9epqiidhCMx1k4Bo55bIWSeWHOv7hrXipGy4O
         uSxxz7vlcOVVaTmP+bgSEAOze32Aa5bRsPABzDsfAXaYaiCJCQaHgKpqr4wazee7wcwZ
         LhNrlaiO0EiV15Xj4GSywXAaqhbh1JzL0yDtyB1QNT0apLqDfgpAjnXe1sQeW2yv0ygN
         AnGIVVNm2xhRHAdBS2H+y8LA/RLkTpthtnSsbMYZUwQ5NxpyDcy8qqHNTO4XUxUK/8wk
         NlXQ4J38PPHp/2FHuVXwtS/d3dPvNR4J12Gtf5YhO3qv6j/c7aPeODvzSv6fIPn6kw9Q
         U34w==
X-Gm-Message-State: ABuFfojlWj7WGhGcGJCbC/oL0cewVw3VEIB2Xg+Ka9a0/bLrtQ+nfMlp
        GsZ5TNvNDVYg4LmITSj8eG8=
X-Google-Smtp-Source: ACcGV63OLXwoYVVnGjxHLwur5/NdIDQTQdSm3iDxdYG2mynSWnOLE5FT5UcDfNWGXsTkNvaNp6+3pQ==
X-Received: by 2002:a17:902:5608:: with SMTP id h8-v6mr7524767pli.324.1537991136185;
        Wed, 26 Sep 2018 12:45:36 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m10-v6sm7186101pgp.94.2018.09.26.12.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:45:35 -0700 (PDT)
Date:   Wed, 26 Sep 2018 12:45:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: ina3221: Add power sysfs nodes
Message-ID: <20180926194534.GB18731@roeck-us.net>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-2-nicoleotsuka@gmail.com>
 <dbf77a33-ae5c-1ac7-c94f-fa5505074adb@roeck-us.net>
 <20180926182006.GB6329@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926182006.GB6329@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Wed, Sep 26, 2018 at 11:20:06AM -0700, Nicolin Chen wrote:
> On Wed, Sep 26, 2018 at 05:34:53AM -0700, Guenter Roeck wrote:
> > Hi Nicolin,
> > 
> > On 09/25/2018 11:42 PM, Nicolin Chen wrote:
> > > The hwmon sysfs ABI supports powerX_input and powerX_crit. This
> > > can ease user space programs who care more about power in total
> > > than voltage or current individually.
> > > 
> > > So this patch adds these two sysfs nodes for INA3221 driver.
> 
> > Ah, sorry, we can't do that. The sysfs nodes are for chips providing power
> > registers, not for kernel drivers to provide calculations based on voltage
> > and current measurements.
> 
> Hmm..I saw ina2xx.c and ltc4215.c are doing similar calculations...
> 

ina2xx.c doesn't; the chips supported by the driver do have a register
reporting the power (0x03). ltc4215.c was not reviewed by a hwmon
maintainer. I think I mentioned before that you can find anything you want
in the Linux kernel. That doesn't make it right.

> > Basic guideline is that we report what is there, not some calculation based
> > on it.
> 
> I could feel the back thoughts behind the guideline, but this does
> give user space programs some trouble -- I have a few programs that
> were used to read ina2xx driver which provides power nodes, but now
> those programs will have to implement another function to read the
> voltage and current separately to do further calculations.
> 
> Do you know any better solution for this situation?
> 

Userspace simply must not assume that power attributes exist and calculate
it from voltage and current attributes if needed.

> > This is even more true for power limits: We can not assume that the power limit
> > is (max voltage * max current). or (current voltage * max_current), or anything
> > else. We simply don't have the knowledge to make that assumption.
> 
> I agree that power limit is a bit tricky here as the voltage could
> change depending on the user space, Yes, I assumed that users who
> set_power() should be aware of it (whether fixed or dynamical) so
> as to decide to configure power limit or just current limit.
> 

You just can not make any such assumptions, sorry. Limit attributes
absolutely must be reflected in hardware. 

Thanks,
Guenter
