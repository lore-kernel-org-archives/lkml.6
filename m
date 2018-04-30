Return-Path: <jean-philippe.brucker@arm.com>
X-Google-Smtp-Source: AB8JxZq6rjMGi5CMQaKiyo5emoPXUPdIkdpV9mnL+zytzyug7dNpee5piBMFmYVGVUsg3B+bd/CB
ARC-Seal: i=1; a=rsa-sha256; t=1525107241; cv=none;
        d=google.com; s=arc-20160816;
        b=VmZRTwsqUzTbJbMvXL2jEDAXmIW5ubnicXaAP5hjFr4znTSwMmU0jfJPnwL6SiHPPn
         gbyEklJp4b/x2APloy1DnHpLsc9cf9dPJDEFT1lZitz7jdL+KvXUnbuLM4DIH9NvTcT4
         X7tUEP/G4qBqhkLqt0dKrtnFQ+6t2L4fHJZjf1XBGphHx2/KcVmqmsVy/VVUGnYnSXTK
         cHyD3K8DexMWPvzdgvd5wxGkNeK+LVSLPgoOi9V1sw8eQz7ay3ze98naNu0ZAMy4A1cL
         8R/+If0LA+Lp1zKSZTpGhVLLhXqHTAYQPv2aoFxETcuumioCg+ZqlarVjwic2vBtPTAT
         5nuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=PI8uWGK6klFUibVAWEK2lggyPwc6ecpcSgHwyBU4vtI=;
        b=XRHvSh4lGVg9EBEbrabOnVwDXlanvYyFQ5SU3ioSQ15BhklCxdCq7Y9USpiKaPlr5z
         9V1iAg1z7gEkv5Y2M1Mjo99E0WEW7DU4t/3tlkTqhU0GftHxnHR4uHbmADhjQsSirkZg
         uoVG1uny0MPjObv/5XlRTENM85fo2BAMBpwPctzRMVhu2JydL8g9exqtFyZoI71Dk4pz
         KH+vvrPxueIwRUpldGQ9WseG3oQegdDmwl22K50K8/5jTO3XljDPcgFKXSDS7iCE3q02
         tYv4uldevAfUH1U0oqTkAJIWnZOTCdIL8mRI74VW3xvZC4NXBdhNOiWFOo24IjmvdVil
         vK4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jean-philippe.brucker@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jean-philippe.brucker@arm.com
Subject: Re: [PATCH v4 12/22] iommu: introduce device fault report API
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-13-git-send-email-jacob.jun.pan@linux.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <b9175586-e638-c807-3ef0-f0e0bc1b8243@arm.com>
Date: Mon, 30 Apr 2018 17:53:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523915351-54415-13-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910650455321?=
X-GMAIL-MSGID: =?utf-8?q?1599190850837438886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

I noticed a couple issues when testing

On 16/04/18 22:49, Jacob Pan wrote:
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

Should this be inside the param lock? We probably don't expect
concurrent register/unregister but it seems cleaner

> +
> +	mutex_lock(&param->lock);
> +	get_device(dev);
> +	param->fault_param =
> +		kzalloc(sizeof(struct iommu_fault_param), GFP_ATOMIC);
> +	if (!param->fault_param) {
> +		put_device(dev);
> +		mutex_unlock(&param->lock);
> +		return -ENOMEM;
> +	}
> +	mutex_init(&param->fault_param->lock);
> +	param->fault_param->handler = handler;
> +	param->fault_param->data = data;
> +	INIT_LIST_HEAD(&param->fault_param->faults);
> +
> +	mutex_unlock(&param->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
> +
> +/**
> + * iommu_unregister_device_fault_handler() - Unregister the device fault handler
> + * @dev: the device
> + *
> + * Remove the device fault handler installed with
> + * iommu_register_device_fault_handler().
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_unregister_device_fault_handler(struct device *dev)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +	int ret = 0;
> +
> +	if (!param)
> +		return -EINVAL;
> +
> +	mutex_lock(&param->lock);

We should return EINVAL here, if fault_param is NULL. That way users can
call unregister_fault_handler unconditionally in their cleanup paths

> +	/* we cannot unregister handler if there are pending faults */
> +	if (list_empty(&param->fault_param->faults)) {

if (!list_empty(...))

> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	list_del(&param->fault_param->faults);

faults is the list head, no need for list_del

> +	kfree(param->fault_param);
> +	param->fault_param = NULL;
> +	put_device(dev);
> +
> +unlock:
> +	mutex_unlock(&param->lock);
> +
> +	return 0;

return ret

Thanks,
Jean
