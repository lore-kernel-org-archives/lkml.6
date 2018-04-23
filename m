Return-Path: <Jean-Philippe.Brucker@arm.com>
X-Google-Smtp-Source: AIpwx4+quGsBWOnYwiVRsnuj33ssvqdZFeK0gDBUuobXH7o6G6rlVR1MHKIoNAMojQaSPH6LkbF9
ARC-Seal: i=1; a=rsa-sha256; t=1524483021; cv=none;
        d=google.com; s=arc-20160816;
        b=ABKvdUH/CSo+3Rmn2Na0E3F8ri5tzneFFbgUBS2YdIQbFVQLFEDHfjHY9riJkQw1KV
         //DSZbHjUpIc1UZdjsCjsxzuSnMhk/VYJnro/wQdCaq6KSmUsT4IlSauGWXtO5R0aVdY
         dxPVI7nSkSgF+NZxUEWqwcuOSwCY1UBu+aOuEDMpOb8w0y97bzPHhdUKDlNUa/pHL61y
         cbLRLmWqV25SLqsAExKSbh5HNNE9ut6PtDw2GoOE6CCuCC76FoLFVxLTK67KSXVTaoIY
         5oDABKtr6N0+HlqIjuPcafgGMS+xbExLtK7BQ2GfGW0iq2k512iXfm87VDvEMEHpI6d/
         wx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Z2gwjkmLndblddYo6dCLj8vdoqHRtVZ9DkRlHc7WaUs=;
        b=JVCD+JGlHc24NhC7wR71jesq8pWxYutCqAy6TKA9KNc2O854SW1jxczrEndqHukMyv
         F1ySeMo+sPuY779OV8FXIKZyu4C6RVuVuzS4v8S3qaQZ/j9KX2mWwEIIlkFMUonHGL/E
         8iM3WZTSXEgpdymssTZfaA3dT9L9H/Js8tWoaJMJMa3VFzJn33WRS5sleUTAISuCQpQh
         srfNNsBJi9FfL7+lEzxq7zMoOMDubWQo4wHRRy8hcDvtypb5hmdT+KFwgEZTPIwcObGj
         esxppJ4IhnDTbVEif2B8PagOxsVVVs9khlLlK5r1BM/T/RtJdkrIkV0KYXhB6kkrbNVq
         84Ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=Jean-Philippe.Brucker@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=Jean-Philippe.Brucker@arm.com
Date: Mon, 23 Apr 2018 12:30:13 +0100
From: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 12/22] iommu: introduce device fault report API
Message-ID: <20180423113013.GB38106@ostrya.localdomain>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-13-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523915351-54415-13-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910650455321?=
X-GMAIL-MSGID: =?utf-8?q?1598536308892560530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 10:49:01PM +0100, Jacob Pan wrote:
[...]
> +int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +
> +	/*
> +	 * Device iommu_param should have been allocated when device is
> +	 * added to its iommu_group.
> +	 */
> +	if (!param)
> +		return -EINVAL;
> +
> +	/* Only allow one fault handler registered for each device */
> +	if (param->fault_param)
> +		return -EBUSY;
> +
> +	mutex_lock(&param->lock);
> +	get_device(dev);
> +	param->fault_param =
> +		kzalloc(sizeof(struct iommu_fault_param), GFP_ATOMIC);

This can be GFP_KERNEL

[...]
> +int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
> +{
> +	int ret = 0;
> +	struct iommu_fault_event *evt_pending;
> +	struct iommu_fault_param *fparam;
> +
> +	/* iommu_param is allocated when device is added to group */
> +	if (!dev->iommu_param | !evt)
> +		return -EINVAL;
> +	/* we only report device fault if there is a handler registered */
> +	mutex_lock(&dev->iommu_param->lock);
> +	if (!dev->iommu_param->fault_param ||
> +		!dev->iommu_param->fault_param->handler) {
> +		ret = -EINVAL;
> +		goto done_unlock;
> +	}
> +	fparam = dev->iommu_param->fault_param;
> +	if (evt->type == IOMMU_FAULT_PAGE_REQ && evt->last_req) {
> +		evt_pending = kzalloc(sizeof(*evt_pending), GFP_ATOMIC);

We're expecting caller to be a thread at the moment, so this could be
GFP_KERNEL too. You could also use kmemdup to remove the memcpy below

[...]
> +static inline int iommu_register_device_fault_handler(struct device *dev,
> +						iommu_dev_fault_handler_t handler,
> +						void *data)
> +{
> +	return 0;

Should return -ENODEV

Thanks,
Jean
