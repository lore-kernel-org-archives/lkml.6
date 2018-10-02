Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4760CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06CB2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b47QJMLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06CB2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJCCTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:19:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39743 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJCCTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:19:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so420299pgv.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 12:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7iGyGgzdXewbmBAm+1kuFzLOgYdsED2s7ZMCiihPT8E=;
        b=b47QJMLXr23RxEXWubLqVW3DGGoHQZCVMLkCa7dMfNgCnp173XIY22Z7R/TdOppAeG
         n0rYPig8ArPLqOT5JrNPGVugTG25e9dtcpqROwYPPA1bcHvN4cGcLdiifN2em5TKiCiE
         UXS2+8bRH8Ba4RMZqS36vJmrqoiK5kpFKls2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7iGyGgzdXewbmBAm+1kuFzLOgYdsED2s7ZMCiihPT8E=;
        b=mBmQMJ94raJfLsd6DB640bLxH+pM2RyoifCIrAkKcziBo3XqmaSOpsJhnQt1LWjnKi
         bZ3gB+vhDN1w/Qy94vrkh3vCvBkibYAuTWL89HJ1Yw7F5HSW4lv+wD35hD5WpWZLQSQT
         uUj1IzYbqbUv7EjIMkpBvfgqxi/bOKX77spQZZTo/0XAnEE6O8S4Qg1NBS2MWnO6v4nG
         Ma+CAoQy/OFnj3ikX21q8TnbP3K4T7HE0p743e4U+REPOklRlowpxZttnjvl95IQWfwI
         2AaRzxy6Y62SJQp2wvSLY2hwzxIoBOl4Zx5eVTMMTdW6obXb6cv3A7Nw56uIl9ab2j6A
         fJ/A==
X-Gm-Message-State: ABuFfoiEC0YUaTxvpUJORssHOwOOhTkpqTDhMzxcpipAmWeUZVR3jdef
        v1MsZ93heJP9T5g/eZ66axEHlw==
X-Google-Smtp-Source: ACcGV63sDVR5EW8AuKSgA+1yarKpt8LKsFJpH9erbH8fe6FLk2M7bMyU4+J7/kiSh5mtXfn2lkQHNw==
X-Received: by 2002:a63:1a5a:: with SMTP id a26-v6mr15856510pgm.9.1538508888293;
        Tue, 02 Oct 2018 12:34:48 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q21-v6sm19510734pfq.51.2018.10.02.12.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 12:34:47 -0700 (PDT)
Date:   Tue, 2 Oct 2018 12:34:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [RFC PATCH] soc: qcom: rmtfs_mem: Control remoteproc from
 rmtfs_mem
Message-ID: <20181002193445.GP2523@minitux>
References: <20180925080607.30565-1-bjorn.andersson@linaro.org>
 <20180925172943.GA118699@ban.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925172943.GA118699@ban.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Sep 10:29 PDT 2018, Brian Norris wrote:

> Hi Bjorn,
> 
> On Tue, Sep 25, 2018 at 01:06:07AM -0700, Bjorn Andersson wrote:
> > rmtfs_mem provides access to physical storage and is crucial for the
> > operation of the Qualcomm modem subsystem.
> > 
> > The rmtfs_mem implementation must be available before the modem
> > subsystem is booted and a solution where the modem remoteproc will
> > verify that the rmtfs_mem is available has been discussed in the past.
> > But this would not handle the case where the rmtfs_mem provider is
> > restarted, which would cause fatal loss of access to the storage device
> > for the modem.
> > 
> > The suggestion is therefor to link the rmtfs_mem to its associated
> > remote processor instance and control it based on the availability of
> > the rmtfs_mem implementation.
> 
> But what does "availability" mean? If I'm reading your rmtfs daemon
> properly, "availability" should mean that the daemon is up and has
> registered a RMTFS_QMI_SERVICE. But in this patch, you're keying off of
> the open() call, which sounds like you're introducing a race condition
> -- we might have open()ed the RMTFS memory but we're not actually
> completely ready to service requests.
> 

You're right. The modem will fail to load if the RMTFS_QMI_SERVICE is
not present, it doesn't care about this thing (rmtfs) has "opened"
rmtfs_mem.

> So rather than looking for open(), I think somebody needs to be looking
> for the appearance and disappearance of the RMTFS_QMI_SERVICE. (Looking
> for disappearance would resolve the daemon restart issue, no?) That
> "somebody" could be the remoteproc driver I suppose (qmi_add_lookup()?),
> or

Right, thinking about it some more we could make the remoteproc driver
start and stop itself as the RMTFS_QMI_SERVICE get
registered/unregistered.

> ...couldn't it just be the modem itself? Do you actually need to
> restart the entire modem when the RMTFS service goes away, or do you
> just need to pause storage activity?
> 

Unfortunately the protocol isn't stateless; a handle to the partition is
acquired by an "open" call and then read/write operations are performed
on that handle. So unless the modem explicitly reopens the partitions as
the rmtfs service is restarted this won't work - and I haven't observed
this behavior.


For the record; I did consider making the rmtfs implementation the one
driving the remoteproc state through /sys/class/remoteproc, but that
would not cope with abnormal termination of the rmtfs implementation.

I will work up a patch making the remoteproc driver observe the presence
of the RMTFS_QMI_SERVICE and see how that looks.

Thanks for your feedback!

Regards,
Bjorn

> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > The currently implemented workaround in the Linaro QCOMLT releases is to
> > blacklist the qcom_q6v5_pil kernel module and load this explicitly after rmtfs
> > has been started.
> > 
> > With this patch the modem module can be loaded automatically by the
> > platform_bus and will only be booted as the rmtfs becomes available. Performing
> > actions such as upgrading (and restarting) the rmtfs service will cause the
> > modem to automatically restart and hence continue to function after the
> > upgrade.
> > 
> >  .../reserved-memory/qcom,rmtfs-mem.txt        |  7 ++++++
> >  drivers/remoteproc/qcom_q6v5_pil.c            |  1 +
> >  drivers/soc/qcom/Kconfig                      |  1 +
> >  drivers/soc/qcom/rmtfs_mem.c                  | 23 ++++++++++++++++++-
> >  4 files changed, 31 insertions(+), 1 deletion(-)
> > 
> ...
> > diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> > index 8a3678c2e83c..8b08be310397 100644
> > --- a/drivers/soc/qcom/rmtfs_mem.c
> > +++ b/drivers/soc/qcom/rmtfs_mem.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/of.h>
> >  #include <linux/of_reserved_mem.h>
> > +#include <linux/remoteproc.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> > @@ -39,6 +40,8 @@ struct qcom_rmtfs_mem {
> >  	unsigned int client_id;
> >  
> >  	unsigned int perms;
> > +
> > +	struct rproc *rproc;
> >  };
> >  
> >  static ssize_t qcom_rmtfs_mem_show(struct device *dev,
> > @@ -80,11 +83,18 @@ static int qcom_rmtfs_mem_open(struct inode *inode, struct file *filp)
> >  	struct qcom_rmtfs_mem *rmtfs_mem = container_of(inode->i_cdev,
> >  							struct qcom_rmtfs_mem,
> >  							cdev);
> > +	int ret = 0;
> >  
> >  	get_device(&rmtfs_mem->dev);
> >  	filp->private_data = rmtfs_mem;
> >  
> > -	return 0;
> > +	if (rmtfs_mem->rproc) {
> > +		ret = rproc_boot(rmtfs_mem->rproc);
> > +		if (ret)
> > +			put_device(&rmtfs_mem->dev);
> > +	}
> > +
> > +	return ret;
> >  }
> >  static ssize_t qcom_rmtfs_mem_read(struct file *filp,
> >  			      char __user *buf, size_t count, loff_t *f_pos)
> > @@ -127,6 +137,9 @@ static int qcom_rmtfs_mem_release(struct inode *inode, struct file *filp)
> >  {
> >  	struct qcom_rmtfs_mem *rmtfs_mem = filp->private_data;
> >  
> > +	if (rmtfs_mem->rproc)
> > +		rproc_shutdown(rmtfs_mem->rproc);
> > +
> >  	put_device(&rmtfs_mem->dev);
> >  
> >  	return 0;
> > @@ -156,6 +169,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
> >  	struct qcom_scm_vmperm perms[2];
> >  	struct reserved_mem *rmem;
> >  	struct qcom_rmtfs_mem *rmtfs_mem;
> > +	phandle rproc_phandle;
> >  	u32 client_id;
> >  	u32 vmid;
> >  	int ret;
> > @@ -181,6 +195,13 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
> >  	rmtfs_mem->client_id = client_id;
> >  	rmtfs_mem->size = rmem->size;
> >  
> > +	ret = of_property_read_u32(node, "rproc", &rproc_phandle);
> > +	if (!ret) {
> > +		rmtfs_mem->rproc = rproc_get_by_phandle(rproc_phandle);
> 
> You're doing an rproc_get(), so you need to do a rproc_put() in
> remove().
> 
> Brian
> 
> > +		if (!rmtfs_mem->rproc)
> > +			return -EPROBE_DEFER;
> > +	}
> > +
> >  	device_initialize(&rmtfs_mem->dev);
> >  	rmtfs_mem->dev.parent = &pdev->dev;
> >  	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
