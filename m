Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AB8JxZrHCYcwov45SpTq11F3uMptwvtHHEjrjHxOm1brwMdxNBtx1+G1I0aSpIOmDebtR6uEAtR6
ARC-Seal: i=1; a=rsa-sha256; t=1525349944; cv=none;
        d=google.com; s=arc-20160816;
        b=Qii7TTAsepnxTle/UpqF1ItttV+ahtrMuF4PThb31bjt9obJX4WGuE1Fom85lrF/ia
         z/zP+ZYsFf0wDFP+rGO/Urhx0ve2NY2YeAbmujqSllgcHw5sryISTJf0u1jsrPM9Zkw0
         UqFGifjpThIhba5wILfZywJLpoZRwqjwIjKPFs/br2kZjJXsh8/RNBHCH269nzKnOD4J
         53YLyy1+W1wQxqYexLcn2Tvypq1Fm1sYkalkgkffnoTLtRy9YozeETvrwU9jbE0WqnFi
         Iu45AppbzDADrNeN4v1SPvSmpXIkW2MbsYLOgNkKPWi3YocOHz8IcigplS/YXP36yGW9
         h16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=L8VBDVEZrdrxVuB0+WcZjB+1iky8X1Z2nebBsUs4uwo=;
        b=QADd8D6u2QuZEP2hpsKWpsznIW5h24uXMIw2I9ShcTNX5Sr75w0bySLS3iQxqy88Vd
         PGOyCkrOCE1PvlosXiTvefCQ1gMoGZt0+4qcdEVwtgx+Lvh339/olqo6pjEYHr2NKtq5
         Iw0OZoJUhb6IF08jsT1/nDm/7o15ztVvb6+pg2UdYvwlBIhqmIk3LDbCfuu5LaOZ9Iht
         TsX2+QrFD60kzYPrbOKdKHWUlh5n5oAkc47RL4mbtrQ8wGU+Nr6zU1KP/jkSVmhaDtHH
         sy87Yn7YuvkCUzpVcHbWQ3+9jeNNneZYdqZml0dEE19fpfODWeL3N2K0+fQXBJ8/ozjs
         qtCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Thu, 3 May 2018 14:21:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Nipun Gupta <nipun.gupta@nxp.com>, robin.murphy@arm.com, hch@lst.de,
	linux@armlinux.org.uk, gregkh@linuxfoundation.org,
	m.szyprowski@samsung.com, bhelgaas@google.com, zajec5@gmail.com,
	andy.gross@linaro.org, david.brown@linaro.org,
	dan.j.williams@intel.com, vinod.koul@intel.com, robh+dt@kernel.org,
	frowand.list@gmail.com, jarkko.sakkinen@linux.intel.com,
	rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com,
	johan@kernel.org, msuchanek@suse.de, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, bharat.bhushan@nxp.com,
	leoyang.li@nxp.com
Subject: Re: [PATCH v4 1/2] dma-mapping: move dma configuration to bus
	infrastructure
Message-ID: <20180503122147.GB18590@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <1524883919-29484-1-git-send-email-nipun.gupta@nxp.com> <20180430104124.GE2476@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430104124.GE2476@ulmo>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1599445343796711576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 12:41:24PM +0200, Thierry Reding wrote:
> On Sat, Apr 28, 2018 at 08:21:58AM +0530, Nipun Gupta wrote:
> [...]
> > diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> > index 88a3558..a9ec99d 100644
> > --- a/drivers/gpu/host1x/bus.c
> > +++ b/drivers/gpu/host1x/bus.c
> > @@ -314,6 +314,13 @@ static int host1x_device_match(struct device *dev, struct device_driver *drv)
> >  	return strcmp(dev_name(dev), drv->name) == 0;
> >  }
> >  
> > +static int host1x_dma_configure(struct device *dev)
> > +{
> > +	if (dev->of_node)
> > +		return of_dma_configure(dev, dev->of_node);
> 
> The conditional here is somewhat pointless since the of_node should
> always be set. If it weren't it should be considered a bug and this
> function welcome to crash to make that very obvious.

Agreed.  Please remove the check for the resend.
