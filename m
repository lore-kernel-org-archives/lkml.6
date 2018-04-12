Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AIpwx49UXFH77RsfjBIz9pyv0RJL+/dgIBk2wCLNh1xYBps4zH/Y6jL1AfPo5Ajmv6FvuqW3dtYG
ARC-Seal: i=1; a=rsa-sha256; t=1523522458; cv=none;
        d=google.com; s=arc-20160816;
        b=Cbm5dDud+3p0XdQ5gcKL53V361AkuNQ2d2JJv3ixZACQS4bjy/6XkCTzxTz7eEzMFd
         70+aTJ+hsC7MaLZeA7zw47BVyWhhz3cxTevkBzCQs2lLWHSNscXPJN8qQcIYkan8F5RX
         oBc5TGITTA82yK44rBwMotTQc71Plfjkh9EUKf1iYpK8SBaYbC3vasZnCiFa/HXam7lb
         FlWEZSD+Lhb6YEDxUj+K7APNMQbsDGeGT9mxKzdok9Ie43//BW0iChDk7KiV5t2VSpeh
         DEGsq2O4YE9fdOtqhyOyGmvVUSTbTqy5Wns+pZ9uqzgqtCNmYUOextPXUV1Vtpw77eLx
         v6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=14IfLXyaNKS9uKP4oDuSyLhCm2InPE7FLa+lf+dkBlQ=;
        b=K9vPkOgEDnc3juRvH7qCwrjIESfz52Zvu9UFvxDRLGduVp6ddyLxLvkQMZeDhuOj9V
         uOfqnrQDlXmj/EgQtrN8HuOSGlBVZiToXDW/Zr8PVmj5NH2iCJFZu9egVS/QuxR0qvf+
         zbX7O5mO9OxXRC3gsNBPdsgPUSsmAW8E4TOQ9nULdkbKwo1bIqZg/e3e7O74o4WENOjW
         5hP4h4Ku5a1Vn7/WJUzLFw8B9rnwfQ9gQc9tQ53/csjVlZZPLwyLb6KSyG0t07SrZF3T
         TU9C9xv59XeMdgWpN7dG5/6Mw/aD0XnGRbNeX6L5GXXOtyyNOr5aGdPNmuWijwXDKWCx
         uWgw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XqutqXPy;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eRGDx9Zc;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XqutqXPy;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eRGDx9Zc;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Apr 2018 14:10:57 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Wei
 Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>, Timur Tabi
 <timur@codeaurora.org>
Subject: Re: [PATCH v13 5/6] PCI: Unify wait for link active into generic PCI
In-Reply-To: <20180409232528.GE6283@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-6-git-send-email-poza@codeaurora.org>
 <20180409232528.GE6283@localhost.localdomain>
Message-ID: <ce67a10c0626f9ef27aae056fe5dd286@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280028398870927?=
X-GMAIL-MSGID: =?utf-8?q?1597529085519478560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-10 04:55, Keith Busch wrote:
> On Mon, Apr 09, 2018 at 10:41:53AM -0400, Oza Pawandeep wrote:
>> +/**
>> + * pcie_wait_for_link - Wait for link till it's active/inactive
>> + * @pdev: Bridge device
>> + * @active: waiting for active or inactive ?
>> + *
>> + * Use this to wait till link becomes active or inactive.
>> + */
>> +bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
>> +{
>> +	int timeout = 1000;
>> +	bool ret;
>> +	u16 lnk_status;
>> +
>> +	for (;;) {
>> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> +		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
>> +		if (ret == active)
>> +			return true;
>> +		if (timeout <= 0)
>> +			break;
>> +		timeout -= 10;
>> +	}
> 
> This is missing an msleep(10) at each iteration.

will take care.

> 
>> +
>> +	pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
>> +		 active ? "set" : "cleared");
>> +
>> +	return false;
>> +}
