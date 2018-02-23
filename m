Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x227K21Urd3AH0kjZEQ523EWyUnDwISgTNSgf4O8QZI4fIpy2mR1QN6s73mYb3y9H9aCr2GgX
ARC-Seal: i=1; a=rsa-sha256; t=1519368811; cv=none;
        d=google.com; s=arc-20160816;
        b=0JYljx7upNaXZUlvF8OkJMqx+7XslYP0X/6/p/D+oDRfUZP0zHW2Y7CtDeyzGDEkXi
         lUkP1sAsux4oRAWdPEB8wTg4WfFy87O9cbMz1YarhYve5NnTASChFBBWN29riJkQ38Zv
         0aYVYFBLH0cV5DcxTE3md1Vq9VnFJXOk/6iqUWC8ZqrwfF+CUGPUqZcN7H426vVBFa0z
         Pn8207T71pdnFzcVPrhZw35OyaU4g6wekHhDN2rO8aUdMnTLD6yH/DPYXKrOyY3utU3C
         GIBvEHZhm/xiV6iHKRHa2WY0fAHRMQrbOdaaPzIvPsvT+ayK+SDgYEaWyoBmHDy+SE7P
         dOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=UasjqQuZm8G7GlrryYhAWYtuAjR/vQiN23Wi8+YvFYE=;
        b=E1W2GSeuPOx8Cj+ZCBV1U2ikDGf9chnce3yPJ2cMlp7XnFHyNnP1xCLZbJrxeHhPUx
         YbMiFcgszPusKY62IUpNW72PFhyT/8ti809JmEsPRDR/w9lgwNGeWe0zcKBpGYN0oM+U
         ZRxNP9qhLMcZaGrBQTGq4P5SHK4AK4nG3AxN/ZzGyDj+Cx0FfxNby3h/MTyJp68C+d1g
         EJsXzVtH4VY+lu6Yt4KsBMmUm/Vv3wbaNNvwsYL6sR+MKgjiivf1rcHu5buQvjAHJYzA
         IIjx1HTcgQ1NnOdCKOHiPdEoyqAjlXOjQXRYx2kCaQnpSZD8P3GMRa4YyGWIJset3iGT
         /buQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MAOI4YkV;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=egqUAtmb;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MAOI4YkV;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=egqUAtmb;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Feb 2018 12:23:30 +0530
From: poza@codeaurora.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v10 6/7] PCI: Unify wait for link active into generic pci
In-Reply-To: <20180222184348.GE6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-7-git-send-email-poza@codeaurora.org>
 <20180222184348.GE6267@infradead.org>
Message-ID: <be1f86033845121116b35ad17ead9527@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086424372892434?=
X-GMAIL-MSGID: =?utf-8?q?1593173671228975357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-23 00:13, Christoph Hellwig wrote:
>> 
>> +/**
>> + * pci__wait_for_link - Wait for link till its active/inactive
> 
> typo - just wants a single underscore.
> 
>> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> +	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> 
> no need for the !! when assigning to a boolean.

bool is 8 bit, while
#define  PCI_EXP_LNKSTA_DLLLA	0x2000	/* Data Link Layer Link Active */
so I think we need it. otherwise it will treat lnk_status & 
PCI_EXP_LNKSTA_DLLLA as 0 even if 13th bit is set.

> 
>> +
>> +	while ((ret != active) && (timeout > 0)) {
> 
> No need for either pair of inner braces.
> 
>> +		msleep(10);
>> +		timeout -= 10;
>> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>> +		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> 
> Same as above.
> 
>> +	}
>> +
>> +	if (ret == active)
>> +		return true;
> 
> Seems like the structure is a bit odd.  Why not:
> 
> 	for (;;) {
> 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> 		if ((lnk_status & PCI_EXP_LNKSTA_DLLLA) == active)
> 			return true;
> 		if (timeout <= 0)
> 			break;
> 		timeout -= 10;
> 	}

Thanks for suggestion, will do this way. thanks.
Regards,
Oza.
