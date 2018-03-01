Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AG47ELtnR2UXJx1KkwtcUm+uXoDV2OVVQ7nKCTKOAHccJ7GeZTWppRaFxM0rzsDNfZWNbLkjE84G
ARC-Seal: i=1; a=rsa-sha256; t=1519919269; cv=none;
        d=google.com; s=arc-20160816;
        b=V8tdZ/4Vb6rJBBM5hUeZIkUwno5gBFQzNUx3Fy9geB3c7w2AycsPiClX9NEaZv5DbY
         cAZMpwo0XaIvhyo1qcWAqiGfyJ0dXFSU7H0jqa6jTKsgizOnUpHdQVziBbv0vWrLv2RG
         4mZuk4UZXbtriak0Lhjo89YSM0X3Bs+dSQRvvksQohf7f6SWGAvohAhawvvhgzRWCtCp
         ckSn6vxRvikhGWFfcq/+r1kDZpT0Wp+j1tXwWfJIiuzX3SsBDhvDpk3NhrhdkFJ3kcgX
         SzRBm6xlhD59deuiucspgFiCEHMLqygsMOacCLGWF8vK4nHCyG9gdqqjTrDs40dWplJu
         fRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=tXCaxfnu769KYVb9sAJfEhWTkUpYBPK0xn45galsqT8=;
        b=aSBiAluluPabNd5IAAAtE1ZG0P1RScJkHXh3UHvkrZwxeBRscXXB0bVD+016u5F6tB
         Dmqn/wq4Jo8gkJlqJHHHWynB7PEknJSLcvx6nOulNghQgdWu6LnmGEVevUUYYQs5NZWe
         iHRur5HQSSbu9JzTefowJ3kcDTd1BImFdhftb2+6X8TGGKgMw+v99ufaFEgx6Ij5JQRM
         NHMKXVtzGtaLb4Faf3RU5fjgvm4Z7uHHdy92Tm3zPGwnx5L9xiACXkFyG/RebW4XvGEL
         O3Zds1V3tUs4jX0Y+HVaUuhAqzQ9/0gBSY7BrCCZubRSHOfd3gZEY6gXxAqC+gMIXnV1
         pw0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=OW8QNYaf;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JZE3cjhL;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=OW8QNYaf;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JZE3cjhL;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Mar 2018 21:17:47 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] PCI/DPC: Fix INT legacy interrupt in dpc_irq
In-Reply-To: <20180301153802.GD13722@bhelgaas-glaptop.roam.corp.google.com>
References: <1517415535-21850-1-git-send-email-poza@codeaurora.org>
 <20180301153802.GD13722@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <d759fe9efb8e5ece4097375e97772565@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591125527357545721?=
X-GMAIL-MSGID: =?utf-8?q?1593750867601395648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-01 21:08, Bjorn Helgaas wrote:
> Hi Oza,
> 
> On Wed, Jan 31, 2018 at 09:48:55PM +0530, Oza Pawandeep wrote:
>> Current dpc driver acknowledge the interrupt in deferred work, which 
>> works
>> okay since LPI are edge triggered.
>> But when RP does not have MSI support, port service driver falls back 
>> to
>> legacy GIC SPI interrupts, and with current code we do not acknowledge 
>> the
>> interrupt and we get dpc interrupt storm.
>> This patch acknowledges the interrupt in interrupt handler.
> 
> Would you mind rephrasing this changelog in generic PCIe terms?  E.g.,
> "LPI" and "GIC SPI" are meaningless to me (I assume they're
> arm64-specific things), but I don't think it's any arm64-specific
> thing that motivates this change.  IIUC, the issue should occur any
> time we're not using MSI, so we should be able to describe it in
> purely PCIe terms.
> 
> s/dpc/DPC/ in text.
> 
> It looks like this changelog is intended to be multiple paragraphs; if
> so, please leave a blank line between them.  It's a little awkward to
> infer "this is a new paragraph" from the fact that "the previous line
> didn't look full" :)
> 
> Please rebase to my "master" branch (v4.16-rc1).  There was some minor
> change that made this not apply cleanly.
> 

sure will do these changes and re-post the same.

Regards,
Oza.

>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> 
>> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
>> index 2d976a6..570b561 100644
>> --- a/drivers/pci/pcie/pcie-dpc.c
>> +++ b/drivers/pci/pcie/pcie-dpc.c
>> @@ -134,7 +134,7 @@ static void interrupt_event_handler(struct 
>> work_struct *work)
>>  	}
>> 
>>  	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
>> -		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
>> +			      PCI_EXP_DPC_STATUS_TRIGGER);
>>  }
>> 
>>  static void dpc_rp_pio_print_tlp_header(struct device *dev,
>> @@ -277,6 +277,8 @@ static irqreturn_t dpc_irq(int irq, void *context)
>> 
>>  		schedule_work(&dpc->work);
>>  	}
>> +	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
>> +			      PCI_EXP_DPC_STATUS_INTERRUPT);
>>  	return IRQ_HANDLED;
>>  }
>> 
>> --
>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
>> Technologies, Inc.,
>> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
>> Linux Foundation Collaborative Project.
>> 
