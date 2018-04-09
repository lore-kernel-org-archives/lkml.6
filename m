Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/pyW86eGICTMb6agvuwz+ZZ1iGV130DMTKJ1Ufn+GRTXgmqvJr7tbC9K0DVUepUiwVmFC6
ARC-Seal: i=1; a=rsa-sha256; t=1523317913; cv=none;
        d=google.com; s=arc-20160816;
        b=R4Mpwnnd0fxTDwmrnyZDkVWjhq0gWo46MGWxV3Sr99PvWTgBEmJTOrXDu0KJfdjMnS
         p9R48GYMJriJtZdA30a+EV6qPiuS6mg6OVTEk3PdIwWGhbrn05i/G0VuK62PAgf0bjQM
         mV0gZXo9kvluvLMNfJd5xU0Tv3yUgetS6Dj2IGLGxXvOeOvtzW+5xmeO34UjJ6KUFHOt
         U8QLq/Dk9TNRLtbe2nqrztT2NE63wB66mVwMqRxguVGaHFq9weHWORiv8YMBbr3vlwAd
         2yRAJnTIMVmvgkYswzOmByzETGG+WyuXcDYTdw7EMd5mEkVZE3vPBn57LQyt6LFC+aSj
         C6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=b8STDJ24IeL2t2yExvXW95Nga78dTXKmYUYtom8EvCA=;
        b=Lc2BNhPZkVgIHKFLX5DQ5dtLIYfQeZ2qY2U6N9G2PI6evea3myAs3hb7qfabRZwn5o
         AL8pZRuuxeWUEpc4qrkRjJsdi483KHWo2BeoLYtzhYWSY84xKNzXQkB5R9dc0RrYFJ6h
         IlYSITlN0smxNivjIayK7/Vu8W9ZzjEXaJNZ7rJLR4WcLsRb+NtYVcpkGg3aeoWTFLKW
         SXCFkNb63FSu0nuyZvrltyESyUhJPx2KOtA+TZqt8B4aj/H7rbhZBYinAodK6GhZzV7/
         HdzQXYstks09faauU2yqdMjnpcTF56HBPu5IkiIVGD3yOVlxQU4Zayq+2NmF4dUTuXGu
         OV/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=e10jW1B0;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kk2A59MD;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=e10jW1B0;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kk2A59MD;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 740C960386
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
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2c00f25e-9dac-7d75-8138-026ad4bcc7fa@codeaurora.org>
Date: Mon, 9 Apr 2018 19:51:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409232957.GF6283@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027376446464?=
X-GMAIL-MSGID: =?utf-8?q?1597314604939145083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/9/2018 7:29 PM, Keith Busch wrote:
> On Mon, Apr 09, 2018 at 10:41:52AM -0400, Oza Pawandeep wrote:
>> +static int find_dpc_dev_iter(struct device *device, void *data)
>> +{
>> +	struct pcie_port_service_driver *service_driver;
>> +	struct device **dev;
>> +
>> +	dev = (struct device **) data;
>> +
>> +	if (device->bus == &pcie_port_bus_type && device->driver) {
>> +		service_driver = to_service_driver(device->driver);
>> +		if (service_driver->service == PCIE_PORT_SERVICE_DPC) {
>> +			*dev = device;
>> +			return 1;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct device *pci_find_dpc_dev(struct pci_dev *pdev)
>> +{
>> +	struct device *dev = NULL;
>> +
>> +	device_for_each_child(&pdev->dev, &dev, find_dpc_dev_iter);
>> +
>> +	return dev;
>> +}
> 
> The only caller of this doesn't seem to care to use struct device. This
> should probably just extract struct dpc_dev directly from in here.
> 

Bjorn wants to kill the port service driver infrastructure but that is a much
bigger task. 

How do we obtain the DPC object from the parent object directly? Each port
service driver object is a children.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
