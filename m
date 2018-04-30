Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrXr+UZSlTw+j2ZZEwjI0f8utXOEF2pcRcOqIdBwCiM7uy+fVNmrOUieoz1mx+/tEU6uYWx
ARC-Seal: i=1; a=rsa-sha256; t=1525114338; cv=none;
        d=google.com; s=arc-20160816;
        b=oIhQxRas8iyEV6175R5j48P+pQ+xbDc/3JYVN2l3Q7i8iCA6iZb+8FiEVsWuhm7h6W
         ChUUEj70YmvOf35O+a64zskvboa0ph+3+asWNTiT13dd4wdZU33PAhd71oFLr7e0QPMt
         YeRkEAhr3cVvKeclIHmVFp2SGblPqBir9ZY9DPebQ2prdhN1EjDtG5Q46LD5Lik9FYhn
         ybb7Ip8pzVcJYk+SyytYlxrQt1DYlTmc774hK5eXkkhjrGyGPY3Lh8bNwlGQUm4OXoDs
         rGRdC0Q5n2x1XYS11attwUlAliXxIvcraKNjYRjXjNfAvC9w18SF1Wvy5HWvOdHsvcXz
         kdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=47+XyXwSm8ZhseBZ7m2G32agWfZVzuqkBXV5CsF289s=;
        b=gx0cbLwdbIB8BASQlXvlynafgYz9ql7IkBWj5H3yU68hRsO7rT4Md/vGTNJr6P2AcJ
         ZF9k58YozPREfl4xrcAlESH326PQBmAiGmdc/c9N7rhzoFaQJd6MNDUrNCrOeIQlCFnH
         66EPEdw/b+rH1gkZaK168JzFpwfpYxGfmdVWmJqKjO3LXCwht2namTYRBnFMsEix3oDJ
         caiqMuwU1oofczkUl5WqMdD8Eq5gWVVYO3ah2ZBaTVtUJYOXUXuGDxg8RCtl/T96kOnZ
         omgxw8w0ZE+sibY25rQ+nBvcS9q9x0ZM79B56u09OZI5lyPQIvP3DcbykXAjqeQSFml6
         B3PQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,348,1520924400";
   d="scan'208";a="38202704"
Date: Mon, 30 Apr 2018 11:54:56 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David
 Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>,
 Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok
 <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 12/22] iommu: introduce device fault report API
Message-ID: <20180430115456.54a4b22e@jacob-builder>
In-Reply-To: <b9175586-e638-c807-3ef0-f0e0bc1b8243@arm.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-13-git-send-email-jacob.jun.pan@linux.intel.com>
	<b9175586-e638-c807-3ef0-f0e0bc1b8243@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910650455321?=
X-GMAIL-MSGID: =?utf-8?q?1599198293325011715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 30 Apr 2018 17:53:52 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Hi,
> 
> I noticed a couple issues when testing
> 
> On 16/04/18 22:49, Jacob Pan wrote:
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
> 
> Should this be inside the param lock? We probably don't expect
> concurrent register/unregister but it seems cleaner
agreed, same as corrections below. Thanks!
> 
>  [...]  
> 
> We should return EINVAL here, if fault_param is NULL. That way users
> can call unregister_fault_handler unconditionally in their cleanup
> paths
> 
> > +	/* we cannot unregister handler if there are pending
> > faults */
> > +	if (list_empty(&param->fault_param->faults)) {  
> 
> if (!list_empty(...))
> 
> > +		ret = -EBUSY;
> > +		goto unlock;
> > +	}
> > +
> > +	list_del(&param->fault_param->faults);  
> 
> faults is the list head, no need for list_del
> 
> > +	kfree(param->fault_param);
> > +	param->fault_param = NULL;
> > +	put_device(dev);
> > +
> > +unlock:
> > +	mutex_unlock(&param->lock);
> > +
> > +	return 0;  
> 
> return ret
> 
> Thanks,
> Jean

[Jacob Pan]
