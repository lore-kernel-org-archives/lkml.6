Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+FL4YX2cXPsDlQis4iW6ddaq89WC0jo1Wmz39cV2H+tP5lkAU1+3Kypgc05HgBZ7pe757i
ARC-Seal: i=1; a=rsa-sha256; t=1524594429; cv=none;
        d=google.com; s=arc-20160816;
        b=wJ0yWO1YP1+4Ux/66qJtUbHaeCsSo5olQNglPP/lVLomK3vM+KC7aqnsWrclqQcK9p
         /7eB6Pn8vxIICWiL83HVFlMlvsw5NdDB1TxCg0FaO/zYYoU3wumSUE591dS1FOvH8uLP
         x6Ury04WHil1+FQ53hxyzFMWTF5XuRKeAFl022DYZ6Ij6V73aR8H0+D//KPfPKjx13Ej
         O5RYd4zFS+j3+dtPAJSL3b93cyMtmHBC/S97o6t8L8y6yVtbTetMbW7P/pP7ST1OMVuH
         gvUIL37FblhyBdGP11ZOG+JLGCyVJL2o+JxZQlRbAyrkjmXomSPLcwka1SqUJ+K4exM5
         d3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=ugnFV3sR+V7ooTg//zxXK0RNfS58YF011G31uihA5pE=;
        b=BUopjuwMzFg3w8j2xzAzzIN6fMHRBF7mhlmBvSUAzvoVhasst7sQ+ATrYVstWWD5g8
         DL+7m7UFgolqpdd0oD7NRfARapnIS99/igd8OoRtV0z0+lF2ySnbHcoz3lQ+irmNj/uE
         VryTziMxdeENorHMRCOZ9JMponmEwaK1vyfGDqrfCUVTI+xD7dpkNQOB3dl25SVt2p9T
         q+2OvzVEwh5aZZAp31W23DN54xFI7XzrbYILLgaEOsIJZzGv568K26iB1r9Qk2cNGDts
         cI/uU7/KLOp98cyp9RP937tMsHykJ3u1UtmIX/bCUyTieFa0zzfCpbnecjXWh/Yuwl+t
         HmYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,324,1520924400";
   d="scan'208";a="194053115"
Date: Tue, 24 Apr 2018 11:29:43 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David
 Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>,
 Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok
 <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig
 <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 12/22] iommu: introduce device fault report API
Message-ID: <20180424112943.79af1c3f@jacob-builder>
In-Reply-To: <20180423113013.GB38106@ostrya.localdomain>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-13-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180423113013.GB38106@ostrya.localdomain>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910650455321?=
X-GMAIL-MSGID: =?utf-8?q?1598653128564795055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 23 Apr 2018 12:30:13 +0100
Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com> wrote:

> On Mon, Apr 16, 2018 at 10:49:01PM +0100, Jacob Pan wrote:
> [...]
> > +int iommu_register_device_fault_handler(struct device *dev,
> > +					iommu_dev_fault_handler_t
> > handler,
> > +					void *data)
> > +{
> > +	struct iommu_param *param = dev->iommu_param;
> > +
> > +	/*
> > +	 * Device iommu_param should have been allocated when
> > device is
> > +	 * added to its iommu_group.
> > +	 */
> > +	if (!param)
> > +		return -EINVAL;
> > +
> > +	/* Only allow one fault handler registered for each device
> > */
> > +	if (param->fault_param)
> > +		return -EBUSY;
> > +
> > +	mutex_lock(&param->lock);
> > +	get_device(dev);
> > +	param->fault_param =
> > +		kzalloc(sizeof(struct iommu_fault_param),
> > GFP_ATOMIC);  
> 
> This can be GFP_KERNEL
> 
yes, will change.
> [...]
> > +int iommu_report_device_fault(struct device *dev, struct
> > iommu_fault_event *evt) +{
> > +	int ret = 0;
> > +	struct iommu_fault_event *evt_pending;
> > +	struct iommu_fault_param *fparam;
> > +
> > +	/* iommu_param is allocated when device is added to group
> > */
> > +	if (!dev->iommu_param | !evt)
> > +		return -EINVAL;
> > +	/* we only report device fault if there is a handler
> > registered */
> > +	mutex_lock(&dev->iommu_param->lock);
> > +	if (!dev->iommu_param->fault_param ||
> > +		!dev->iommu_param->fault_param->handler) {
> > +		ret = -EINVAL;
> > +		goto done_unlock;
> > +	}
> > +	fparam = dev->iommu_param->fault_param;
> > +	if (evt->type == IOMMU_FAULT_PAGE_REQ && evt->last_req) {
> > +		evt_pending = kzalloc(sizeof(*evt_pending),
> > GFP_ATOMIC);  
> 
> We're expecting caller to be a thread at the moment, so this could be
> GFP_KERNEL too. You could also use kmemdup to remove the memcpy below
> 
good idea. will do.
> [...]
> > +static inline int iommu_register_device_fault_handler(struct
> > device *dev,
> > +
> > iommu_dev_fault_handler_t handler,
> > +						void *data)
> > +{
> > +	return 0;  
> 
> Should return -ENODEV
> 
right. thanks.
> Thanks,
> Jean

[Jacob Pan]
