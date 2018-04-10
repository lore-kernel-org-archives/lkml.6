Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx49Qgai/Tk/cFCGCPzd9Rboi9iv1yEmx2QPHQhmQdr1OgaN7h+XpyQ+mCiiHbSbQA8r4HstP
ARC-Seal: i=1; a=rsa-sha256; t=1523318703; cv=none;
        d=google.com; s=arc-20160816;
        b=lYK4kq2fuetpOC/sqGcntFKOt7+NRz4nf0euRoZDPRNa3Io4Rqa5V3SQe6Mng4rxUF
         GG13z24jew6kQVnZqEF0lL3im7wJ0ZYwxSwpS7hPdCvlug8l37wkCz0AzE7TBg9NbA/r
         WVyUYIuPP2M+feUKRgCTk4InjzSbjOiwPgiMCavmJM3TwFGq7/sgsWvqlzjqDbqFo5uw
         AM2QR1+mupp0ZwfBQqpRZys/nEZ1Qpj8JZyo+PjsruTLmCaeBC1baicWEsMkg9uz1JQ6
         jr3U3ByYb5rEpz6Dq+QkZX6csRh91b9l/8R2i404BnqPzVSr1qnWGugmvMvEm4wFBHLQ
         0dNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=LDgGlSllf4rLiSu/bel9pSy+0CgnCuzrRn5zr0c8/J4=;
        b=OvUqKIS1crdyUUslwiWGzHy6u1b7EthHJj1qddf3iW+gofeYM4TFXA12ezFIk4D64C
         l/hRpAL5dqokYRHiJZCxBwwGUL0eP2BYczTEDsRL0/M6omuGtZCaRKwRc8s3b1BLTwf4
         EDbKoDxz1cSc5CPzZcapEpK1S7KIDJf93F4Ui/GXeJTZ7QlpqMOF0Rz01ehNUcCdVylL
         NXY3lnu0dFVngq9nVYM4MFHfY0rFQxCvkRdH4QL01VgzbUNVeZh0r8FCLi0zbP+EGsFS
         z+y9AxMdkVg5XSQWqUodHbXel08mM2hcIsmgQYsMsRpRnuY9qDmuyrnWW2hKnomTA4ai
         ghDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n6L/vhR0;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n6L/vhR0;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n6L/vhR0;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n6L/vhR0;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A7F8601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v13 4/6] PCI/DPC: Unify and plumb error handling into DPC
To: Keith Busch <keith.busch@intel.com>, Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-5-git-send-email-poza@codeaurora.org>
 <20180409232957.GF6283@localhost.localdomain>
 <2c00f25e-9dac-7d75-8138-026ad4bcc7fa@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <632afd61-0013-64bd-0d19-fcd6f901804c@codeaurora.org>
Date: Mon, 9 Apr 2018 20:05:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2c00f25e-9dac-7d75-8138-026ad4bcc7fa@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027376446464?=
X-GMAIL-MSGID: =?utf-8?q?1597315432712755217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/9/2018 7:51 PM, Sinan Kaya wrote:
> On 4/9/2018 7:29 PM, Keith Busch wrote:
>> On Mon, Apr 09, 2018 at 10:41:52AM -0400, Oza Pawandeep wrote:
>>> +static int find_dpc_dev_iter(struct device *device, void *data)
>>> +{
>>> +	struct pcie_port_service_driver *service_driver;
>>> +	struct device **dev;
>>> +
>>> +	dev = (struct device **) data;
>>> +
>>> +	if (device->bus == &pcie_port_bus_type && device->driver) {
>>> +		service_driver = to_service_driver(device->driver);
>>> +		if (service_driver->service == PCIE_PORT_SERVICE_DPC) {
>>> +			*dev = device;
>>> +			return 1;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct device *pci_find_dpc_dev(struct pci_dev *pdev)
>>> +{
>>> +	struct device *dev = NULL;
>>> +
>>> +	device_for_each_child(&pdev->dev, &dev, find_dpc_dev_iter);
>>> +
>>> +	return dev;
>>> +}
>>
>> The only caller of this doesn't seem to care to use struct device. This
>> should probably just extract struct dpc_dev directly from in here.
>>
> 
> Bjorn wants to kill the port service driver infrastructure but that is a much
> bigger task. 
> 
> How do we obtain the DPC object from the parent object directly? Each port
> service driver object is a children.
> 

How about implementing pcie_port_find_service_dev() as a follow up patch
to "PCI/PORTDRV: Implement generic find service" similar to what was done for
pcie_port_find_service()?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
