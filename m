Return-Path: <kishon@ti.com>
X-Google-Smtp-Source: AG47ELuPI4HLgGvVLSjU9OI1ZX9n01gXrj6KGHXRswoWU4E3iPe9Y/FV3UapzdMd9Ce+U4Xnbti7
ARC-Seal: i=1; a=rsa-sha256; t=1521611753; cv=none;
        d=google.com; s=arc-20160816;
        b=R7afyq0tSyZ1SdyHmvShm5g0iVWpzyRNuvGoHuErMLyBhYbvsWCw2fwmvUCCMxzsFy
         qHrWmbOap+vo1sguyOuO0qV55p3QQIv+cXN57jguXFBwvNfbZhYywRQuXVwKFaAaH4rU
         /BVYQRbB4zxFOHroKOfCNAf+fjR+9iRtr0QJYYFqitj9sDLfNH0V1i2NsPBCBqMiVSSv
         7bkOgw77d8R+3vXtnEYzUnDcdFXoWTIRssTlAJW65TG+yciMJ5CyW2MMJEF/pqncFtpJ
         bC+bHfjsNRllez3ha4j5KYPrFmibBG6+ZngFaxhYBWKBIUryZUDnEHM/CkpCLlZImLRC
         bUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=Kc56Ywe/voGS2NVOZENs9phgBI5/M9VKV8eUHbhcib8=;
        b=JrRQbXz9QSiI4QFnIPvDGvQxdgAxCx+vpFeQImWAIb6fTTplhN8Ylm08v4EVSdkV2u
         +2dQjmoeMy2jqCodL5GfPN1Qk1xwRKX0FNkX1t3HDPaDYYt42UiftQCKyDrvqAcfPwde
         daX5CFrqQTbkoMhCIY0I0U/IYC0lHn2dXbnZfM6yqQQqELMxH3W9Yy0zgmnb1FqbxKY0
         yID9IorqfC4szzkCgNRwzjMOC5UyRZ/tlDwTDeqh0x2+TG6p5s1DvFLaiVXtiBMa0aFh
         mwpzngGjWiP1i7y0jeDd1rMs+PQRZFV24XDtDkd+R5dWbgR5iL7JhKrn2gwhsbI/DDLv
         r9Cw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=VoGaxj9w;
       spf=pass (google.com: domain of kishon@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=kishon@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=VoGaxj9w;
       spf=pass (google.com: domain of kishon@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=kishon@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH v4 5/5] misc: pci_endpoint_test: Handle 64-bit BARs
 properly
To: Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-6-niklas.cassel@axis.com>
CC: Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <35df3d85-4a75-8b17-c32f-1a00b4b6cae6@ti.com>
Date: Wed, 21 Mar 2018 11:25:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20180308133331.19464-6-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594376627258900258?=
X-GMAIL-MSGID: =?utf-8?q?1595525565867327085?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Thursday 08 March 2018 07:03 PM, Niklas Cassel wrote:
> A 64-bit BAR consists of a BAR pair, where the second BAR has the
> upper bits, so we cannot simply call pci_ioremap_bar() on every single
> BAR index.
> 
> The second BAR in a BAR pair will not have the IORESOURCE_MEM resource
> flag set. Only call ioremap on BARs that have the IORESOURCE_MEM
> resource flag set.
> 
> pci 0000:01:00.0: BAR 4: assigned [mem 0xc0300000-0xc031ffff 64bit]
> pci 0000:01:00.0: BAR 2: assigned [mem 0xc0320000-0xc03203ff 64bit]
> pci 0000:01:00.0: BAR 0: assigned [mem 0xc0320400-0xc03204ff 64bit]
> pci-endpoint-test 0000:01:00.0: can't ioremap BAR 1: [??? 0x00000000 flags 0x0]
> pci-endpoint-test 0000:01:00.0: failed to read BAR1
> pci-endpoint-test 0000:01:00.0: can't ioremap BAR 3: [??? 0x00000000 flags 0x0]
> pci-endpoint-test 0000:01:00.0: failed to read BAR3
> pci-endpoint-test 0000:01:00.0: can't ioremap BAR 5: [??? 0x00000000 flags 0x0]
> pci-endpoint-test 0000:01:00.0: failed to read BAR5
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 320276f42653..fe8897e64635 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -534,12 +534,14 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	}
>  
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
> -		base = pci_ioremap_bar(pdev, bar);
> -		if (!base) {
> -			dev_err(dev, "failed to read BAR%d\n", bar);
> -			WARN_ON(bar == test_reg_bar);
> +		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
> +			base = pci_ioremap_bar(pdev, bar);
> +			if (!base) {
> +				dev_err(dev, "failed to read BAR%d\n", bar);
> +				WARN_ON(bar == test_reg_bar);
> +			}
> +			test->bar[bar] = base;
>  		}
> -		test->bar[bar] = base;
>  	}
>  
>  	test->base = test->bar[test_reg_bar];
> 
