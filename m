Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AG47ELtjsknRoErFSTNKCtrxT5gyUYjPGO/q9j5ZS0KkIrK4FDwUDUvkNQk5pF8X5Qi/SH70YCIm
ARC-Seal: i=1; a=rsa-sha256; t=1520344951; cv=none;
        d=google.com; s=arc-20160816;
        b=RdM6HckvCoiWVDjt5KgkrPTDi0N3tp7AaAddWE1xnp43ja/H7MOkgavHaHeIWojpK6
         k5CC6B78ulUttd5giHlIL9HX3kuraY/i8Qwi/RnWA994rAIfKLNlzCfZc/qXqiqD2tG6
         De5YtwSRKqyHUrrQD7dakQmWv4quG0PyfWhVTYIq4Z7uoIcnVuhDBFcaUh2N6GckIZHW
         tcJQy8GqIATKlp5ph2vrwJfc0ONkSHAMNurDgRwq1sJG5l7olt9n3ucudSiF6IWoMa07
         ImHeensUXTyMKUtmnSjdtWY4MYbmkN8/CLsn3dwviqnqPbTYUzZ9fbplUduWy+VayTfK
         z7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:dmarc-filter
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=w7Y5XZoZCTzE8zYKWqKFkcPQQOoBlpitkmrLvnWTLLA=;
        b=Wx814ERMqvqsIx+RnvbhrsYjGlGUkCVUf4qteagfiHKxAnEtchaVUIxUcGr0EbsYQ5
         GGC+EgESUrC2d5G2ZF/4c8IXt72inrVecFOz0GRH/t0JCPewERhUK4b9YX9a0wxcHdft
         vDWt6KOUKedGXd9pl/4g3b3mg6ajDypP9D05JvwAJ32PXwS3zZn6fwMQkVxN7OlC+anO
         mXecoywfWGj9/a8qMP1tip/grc3cza/xpzkESmp5T7wrr2wFOreUq2k0bq2nlKjXAIj6
         lLFOoJQFabPRnFuEGJ73kEhHvNvR5n9ZRmVyqs0aMSq1mH3hTnu8lSBem0tVCw2oD9fI
         B4Dw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BYEBMEI0;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Zso+Agjh;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BYEBMEI0;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Zso+Agjh;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84494600E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v12 3/6] PCI/PORTDRV: Implement generic find service
To: Oza Pawandeep <poza@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
 Timur Tabi <timur@codeaurora.org>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <1519837457-3596-4-git-send-email-poza@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ac53deae-8fad-b896-805f-36343253a34b@codeaurora.org>
Date: Tue, 6 Mar 2018 09:02:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519837457-3596-4-git-send-email-poza@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665114849236705?=
X-GMAIL-MSGID: =?utf-8?q?1594197227887116946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/28/2018 12:04 PM, Oza Pawandeep wrote:
> +struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
> +							u32 service)
> +{
> +	struct pcie_port_service_driver *drv = NULL;

Remove initialization

> +	struct portdrv_service_data pdrvs;
> +
> +	pdrvs.service = service;

initialize pdrvs.drv = NULL here.

> +	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
> +
> +	drv = pdrvs.drv;
> +	return drv;
> +}


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
