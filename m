Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x227j1gwdCeJ6PS6N4uVleUgN3NATN/oICRPZyMKbq+YZove0qwjA6G1U8KyxC68rZFJuFQDZ
ARC-Seal: i=1; a=rsa-sha256; t=1519363263; cv=none;
        d=google.com; s=arc-20160816;
        b=Nwu4au59tyN5bXZsHYMQVGJlswfVp7XJFlFWyXAsWH3+uHE91vPN6xO8qgqdho9MFp
         /vwjPPEY4jqw7TDzonF0hPJh+Muy3/jh7qGyd9yeLzxAp6hD5zEbSbHLtgZ/hY/tpmKT
         5raUsTHqZnsbzx/Q8J+VZP+Cv86x4rMbcEFL4t+9YNn4lGCiyNXioyTI24sFcpFHQoEA
         K3+L5ropVAs241gy+KxrTE0mLiUFonpxMsapmiImvdSrcoMQmjD5OzOfHcwrJajZaKh4
         IKxCFYocBY0VARkszte8h3TelQczuxBKoJVoyE48nKgBCbjx53vD3I9UyTHeXfv/Kb3y
         w/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=e4C2XdMN5ri+9xfxCKCCbpyK8m/hSqYinvWY2whq2+E=;
        b=Oqsc1t9LKz/SaEbW/rHUr9SbaTZvA39csGtzM9WmkWH6USeCDJnfAr/U4EAIHAZVGW
         Lgf3fCJsWw4W3JBG5OP5zs+PjhdtGtR23+8z0LDNNXdIAQYMedGp9l/uIyEnn23hCiIY
         YC4peZ4POMm5ap3P6mQlGE20jA9wR1v3D88aMA+jYva+oOgMPP13uDUfeAIJoRsWIHFo
         hMx8CF/3SN+Z3L7ni+oyrgQK6Fl+LGNiiEQaA8lNJBikc5dgUc2bC7TljzCOGuOSnZhG
         NxHykXc1flxXvfPSHrblANqRwTcaiFoVFoSTqC3F4RoFzOxTekCXuxzsvgYXhUtpKZZV
         iVsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HFu2BSux;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RGcbeUn8;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HFu2BSux;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RGcbeUn8;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Feb 2018 10:50:50 +0530
From: poza@codeaurora.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v9 4/7] PCI/DPC: Unify and plumb error handling into DPC
In-Reply-To: <fc5351ba-1310-5ccf-b0cb-8565679d4c22@infradead.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
 <1519285571-5634-5-git-send-email-poza@codeaurora.org>
 <fc5351ba-1310-5ccf-b0cb-8565679d4c22@infradead.org>
Message-ID: <5e3c1878229d1524a918b85d94b5bf82@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086415695868818?=
X-GMAIL-MSGID: =?utf-8?q?1593167853421933399?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-23 00:53, Randy Dunlap wrote:
> On 02/21/2018 11:46 PM, Oza Pawandeep wrote:
>> Current DPC driver does not do recovery, e.g. calling end-point's 
>> driver's
>> callbacks, which sanitize the sw.
>> 
>> DPC driver implements link_reset callback, and calls pci_do_recovery.
> 
> Hi,
> What does DPC mean?
> 

DPC (Downstream port containment) is PCIe RP or Switch feature, which if 
detects FATAL error messages
halts the outgoing traffic, and PCIe link reset and quiescence 
activities are taken care by HW, and recovery is made.
followed by that; normal operation can be resumed.

>> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
>> 
> 
>> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
>> index 38e40c6..208b427 100644
>> --- a/drivers/pci/pcie/pcie-dpc.c
>> +++ b/drivers/pci/pcie/pcie-dpc.c
> 
>> @@ -82,12 +137,25 @@ static void dpc_wait_link_inactive(struct dpc_dev 
>> *dpc)
>>  		dev_warn(dev, "Link state not disabled for DPC event\n");
>>  }
>> 
>> +/**
>> + * dpc_reset_link - reset link DPC  routine
>  + * @dev: pointer to Root Port's pci_dev data structure
> 
>    * @pdev: ...
> 
>> + *
>> + * Invoked by Port Bus driver when performing link reset at Root 
>> Port.
>> + */
>> +static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>>  {
> 
> You can use 'make W=1 ...' to find kernel-doc warnings like this.
> 

sure thanks for this tip.

ps: I am going to post v11 to address some comments.
> thanks,
