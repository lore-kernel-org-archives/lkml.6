Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC014C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D882086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfmReQx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D882086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJOOVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:21:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41950 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeJOOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 10:21:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23-v6so8666802pgc.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 23:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8BS5zb4g1oHpzkczXkEvEcwxoqFOGwG+SK0BxMMC0AA=;
        b=MfmReQx9GaIQ6gX2o7JNuB2lX2CDY3xdQ+zTgodvIUG9IjwGpcH6xvTjWzppGC4zRf
         VasqCEftW50kREgTub9+vqwIgCiSfi9FC1mMaq7ytkUx7434FnbA/T4Hje4oEunj+3KR
         39792J6patU9zJclDVGsDwxCtOCeSBFS0XR3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8BS5zb4g1oHpzkczXkEvEcwxoqFOGwG+SK0BxMMC0AA=;
        b=f8nAfxygwIzWsUKJ41o+t8xEwZR6ZNg+R0Aw+FD5kyfsmWCAkQRVJ6IE66wlE+3+P1
         wqzDY6DuBDiUz3uGhv2Zzfe2GHWWv3zfFjZ8YWm8VYIpg4xKag4CdN5u7dAs14FoMU8H
         rCCprvd0eApzhesd6vVjK9UtYHSdFiT1vDVyiH2rTx/gBEBB9PGPGoNrnXxx/6hknzrs
         2Q7Q25U/tf+HrpfcY2FTyTzYABrxJvRm6+vBZZvTfKrbrnSWdVKTRQwDvK3Z4vFqVCQ6
         IlAZko7e8/aZNNlHoZOOGprnrb+j3xH2DyaVp+nq4ytT5f2NerOBuTvtnPMXe9FwawLZ
         u/sA==
X-Gm-Message-State: ABuFfogGUBrPZ4VnidFVAMNc3Bziy99H3NyqFdHb25ypIAFSqXw6cfhQ
        zN2GSFUc5Zpwe0SMfFcfKX1LAw==
X-Google-Smtp-Source: ACcGV60xzr3okc8lTbQ/6CPrs/0APrUT5WYtWlXLIpaq9OhhhVM/rbgbQDDrBrehchCNvsAfOs5PDA==
X-Received: by 2002:a63:565d:: with SMTP id g29-v6mr14693980pgm.227.1539585459443;
        Sun, 14 Oct 2018 23:37:39 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d124-v6sm7559018pfa.163.2018.10.14.23.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 23:37:38 -0700 (PDT)
Date:   Sun, 14 Oct 2018 23:40:41 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Loic PALLARDY <loic.pallardy@st.com>
Cc:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "s-anna@ti.com" <s-anna@ti.com>
Subject: Re: [PATCH v4 12/17] remoteproc: modify vring allocation to rely on
 centralized carveout allocator
Message-ID: <20181015064040.GT12063@builder>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-13-git-send-email-loic.pallardy@st.com>
 <20181010053206.GA20016@builder>
 <89f3d4bbbc484c5fb5d85f03b1325103@SFHDAG7NODE2.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f3d4bbbc484c5fb5d85f03b1325103@SFHDAG7NODE2.st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10 Oct 11:58 PDT 2018, Loic PALLARDY wrote:

> 
> 
> > -----Original Message-----
> > From: Bjorn Andersson [mailto:bjorn.andersson@linaro.org]
> > Sent: mercredi 10 octobre 2018 07:32
> > To: Loic PALLARDY <loic.pallardy@st.com>
> > Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> > benjamin.gaignard@linaro.org; s-anna@ti.com
> > Subject: Re: [PATCH v4 12/17] remoteproc: modify vring allocation to rely on
> > centralized carveout allocator
> > 
> > On Fri 27 Jul 06:14 PDT 2018, Loic Pallardy wrote:
> > >  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
> > > diff --git a/drivers/remoteproc/remoteproc_virtio.c
> > b/drivers/remoteproc/remoteproc_virtio.c
> > [..]
> > > @@ -114,6 +122,10 @@ static struct virtqueue *rp_find_vq(struct
> > virtio_device *vdev,
> > >  	rvring->vq = vq;
> > >  	vq->priv = rvring;
> > >
> > > +	/* Update vring in resource table */
> > > +	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
> > > +	rsc->vring[id].da = mem->da;
> > > +
> > 
> > This would now happen after we've started the remoteproc. Don't we need
> > to do this in-between allocating the carveouts and booting the
> > remoteproc?
> 
> Yes da is updated after coprocessor boot, but before vdev status in resource table is set to DRIVER_OK and kick.
> Coprocessor should not parse this resource before as vrings not initialized yet.
> If coprocessor needs to get some information about vring carveout at boot time, carveout resources named vdev"x"vring"y" should be added to firmware resource table.
> In that case information will be filled before coprocessor boot.
> 

Makes sense, thanks for clarifying. Applied.

Regards,
Bjorn
