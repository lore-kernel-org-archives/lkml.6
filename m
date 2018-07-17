Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F678ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161E8206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161E8206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbeGQTIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:08:43 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:37769 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbeGQTIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:08:42 -0400
Received: by mail-qt0-f182.google.com with SMTP id a18-v6so1786556qtj.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 11:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:mime-version
         :content-transfer-encoding;
        bh=KgSZ+wUDR+niCcbDUgET1kM/FqzPnPSu9gbv5UxiL4I=;
        b=rUgYUt8hjzDTrsvfs5Gg67YPBSFffQ980FjbVj2Z/iVXkinzGvifWJaowu1eJr+r9Z
         0A3xgvpmY9UkZ/KY9JC/vzTq5UfN8rbefrly/in2BFAbxm27Q97hy3AKml0XCJZ/PZ2R
         PO8Li+f9GSMKBfQFB4fnnDGFLFC/XC8jQ1+sPXutmmsPrIDRl8ZLOkK3P2lnvhA9BvPB
         ScVqVNXRgEPnm7PPIdoVfHCyaIdXkDepdxFM4UA+dy8hCRnw+wKvq9VGhjqRmri1fdYi
         yv/okKUO1qkd/4TnB9lkGOx6N5fIjVuRTciAWxNTUPLAzeCGQjJMHnr2OcfDTyx9URLO
         7zTw==
X-Gm-Message-State: AOUpUlHIrfvEUq7V1vWBFNE9JcqryiN7U9EXPurtzruCYpADfZtNJFGs
        h8raYg/s4+c/YGRMT0dY8UZCfg==
X-Google-Smtp-Source: AAOMgpeyOEVjx56zCmb4aBkh2IdCjevXhTNvyifx47aVoAsW040W73nmpN9Wsn8jWDaVT8eX0vBOgA==
X-Received: by 2002:a0c:a991:: with SMTP id a17-v6mr3058336qvb.83.1531852488826;
        Tue, 17 Jul 2018 11:34:48 -0700 (PDT)
Received: from whitewolf.lyude.net (pool-72-74-165-95.bstnma.fios.verizon.net. [72.74.165.95])
        by smtp.gmail.com with ESMTPSA id c21-v6sm522463qtj.22.2018.07.17.11.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 11:34:48 -0700 (PDT)
Message-ID: <2dbe75b1a83c025b9cddc229dbca9af6fb30111e.camel@redhat.com>
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback
 recursion in suspend/resume paths
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Lukas Wunner <lukas@wunner.de>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>, linux-pm@vger.kernel.org
Date:   Tue, 17 Jul 2018 14:34:47 -0400
In-Reply-To: <20180717183211.GB18363@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com>
         <20180716235936.11268-2-lyude@redhat.com> <20180717071641.GA5411@wunner.de>
         <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
         <20180717182041.GA18363@wunner.de>
         <cb5af1611622a080fdcbcf3bb794d8ebc39cae2a.camel@redhat.com>
         <20180717183211.GB18363@wunner.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 20:32 +0200, Lukas Wunner wrote:
> On Tue, Jul 17, 2018 at 02:24:31PM -0400, Lyude Paul wrote:
> > On Tue, 2018-07-17 at 20:20 +0200, Lukas Wunner wrote:
> > > Okay, the PCI device is suspending and the nvkm_i2c_aux_acquire()
> > > wants it in resumed state, so is waiting forever for the device to
> > > runtime suspend in order to resume it again immediately afterwards.
> > > 
> > > The deadlock in the stack trace you've posted could be resolved using
> > > the technique I used in d61a5c106351 by adding the following to
> > > include/linux/pm_runtime.h:
> > > 
> > > static inline bool pm_runtime_status_suspending(struct device *dev)
> > > {
> > > 	return dev->power.runtime_status == RPM_SUSPENDING;
> > > }
> > > 
> > > static inline bool is_pm_work(struct device *dev)
> > > {
> > > 	struct work_struct *work = current_work();
> > > 
> > > 	return work && work->func == dev->power.work;
> > > }
> > > 
> > > Then adding this to nvkm_i2c_aux_acquire():
> > > 
> > > 	struct device *dev = pad->i2c->subdev.device->dev;
> > > 
> > > 	if (!(is_pm_work(dev) && pm_runtime_status_suspending(dev))) {
> > > 		ret = pm_runtime_get_sync(dev);
> > > 		if (ret < 0 && ret != -EACCES)
> > > 			return ret;
> > > 	}
> > > 
> > > But here's the catch:  This only works for an *async* runtime suspend.
> > > It doesn't work for pm_runtime_put_sync(), pm_runtime_suspend() etc,
> > > because then the runtime suspend is executed in the context of the caller,
> > > not in the context of dev->power.work.
> > > 
> > > So it's not a full solution, but hopefully something that gets you
> > > going.  I'm not really familiar with the code paths leading to
> > > nvkm_i2c_aux_acquire() to come up with a full solution off the top
> > > of my head I'm afraid.
> > 
> > OK-I was considering doing something similar to that commit beforehand but I
> > wasn't sure if I was going to just be hacking around an actual issue. That
> > doesn't seem to be the case. This is very helpful and hopefully I should be
> > able
> > to figure something out from this, thanks!
> 
> In some cases, the function acquiring the runtime PM ref is only called
> from a couple of places and then it would be feasible and appropriate
> to add a bool parameter to the function telling it to acquire the ref
> or not.  So the function is told using a parameter which context it's
> running in:  In the runtime_suspend code path or some other code path.
> 
> The technique to use current_work() is an alternative approach to figure
> out the context if passing in an additional parameter is not feasible
> for some reason.  That was the case with d61a5c106351.  That approach
> only works for work items though.

Something I'm curious about. This isn't the first time I've hit a situation like
this (see: the improper disable_depth fix I added into amdgpu I now need to go
and fix), which makes me wonder: is there actually any reason Linux's runtime PM
core doesn't just turn get/puts() in the context of s/r callbacks into no-ops by
default? 

> 
> Lukas
