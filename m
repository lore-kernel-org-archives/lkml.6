Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x224q9L7SU76mharmxQO2BksIW/xA7eOK07jWqm8lDeXr6vpwh+sfGpu3tdKn02qvEwOw0VWx
ARC-Seal: i=1; a=rsa-sha256; t=1519327429; cv=none;
        d=google.com; s=arc-20160816;
        b=rnYjWh/J7Thf+q3hrwcUM0lg8+2+ZPm74iR3aQ66sBLV+9LsFufGPk2qRgAKLBu0sp
         tOr3dv0FguMAWoSQSvRrvlndPvnIsJjlMm5V26wgDzSW5w1ER3PT3Iq3SBVktFEsIGUl
         PP3axZ17A2VhKwRh6HLEHuL+lgOIASXDzlVomqktBdB0mu4eNWPClBUgXsGh3IOd0Fc2
         RKFRS4U5hoKMFniRXfetNEQMg5zUKzhA5agtXUNuhnAHizB6qaQg32hQhoFPRb6F4qOu
         dmOOTI4IVHXfPMtOQapgk1FRdLEsgyoskqYpxR2ZGRZ0D54VFzZcWdxRU1scRoWRD/kF
         Gz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :dkim-signature:arc-authentication-results;
        bh=5cxyGfsZrurJEeQgMIhCYxBkY2R90RgL01hKbAuFOpw=;
        b=W/7PmrPz4fDO0QGisMRGou4fV3mbI5UUwNwEgl1QPrW/ztDNF4KyKEA2QKIHdvXBDw
         G95246/ruahGJ9Nj03t1+mx8Bv8UHG7DYWKr4w2qQyMLyGwYxgwSuX2lxjiRE9gaeEQq
         AYp7VFAAgSbroN+zYbxevLooakaxu2532t4zvACav3nEOqDfUytcSniZsYBJ8XH2HCtc
         hPls+QxeMlWjCfGwyrqzwC9+d5c9nUcSFVaj7cr8zoAf9Tf28K5rA5w2RRQokJ9PKJ7O
         FjHZMf1BpmwG2Vnz3HzYa4m+AYIosZmv8Q4+hEGNKEQoj47obiul8NfuQOvuswfDr3iK
         fyxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=IvJnuaC9;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=IvJnuaC9;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH v9 7/7] PCI/DPC: Enumerate the devices after DPC trigger
 event
To: Oza Pawandeep <poza@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
 Sinan Kaya <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
 <1519285571-5634-8-git-send-email-poza@codeaurora.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d8da89bf-aaa1-c6ed-d21a-4cd51265d4a2@infradead.org>
Date: Thu, 22 Feb 2018 11:23:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519285571-5634-8-git-send-email-poza@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086428728217914?=
X-GMAIL-MSGID: =?utf-8?q?1593130278211293171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 11:46 PM, Oza Pawandeep wrote:
> Implement error_resume callback in DPC so, after DPC trigger event
> enumerates the devices beneath.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index fce4518..59c01c7 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -129,6 +129,23 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
>  }
>  
>  /**
> + * dpc_error_resume - enumerate the devices beneath
> + * @dev: pointer to Root Port's pci_dev data structure

    * @pdev: ...

> + *
> + * Invoked by Port Bus driver during nonfatal recovery.
> + */
> +static void dpc_error_resume(struct pci_dev *pdev)
> +{
> +	bool active = true;
> +
> +	if (pci_wait_for_link(pdev, active)) {
> +		pci_lock_rescan_remove();
> +		pci_rescan_bus(pdev->bus);
> +		pci_unlock_rescan_remove();
> +	}
> +}
> +
> +/**
>   * dpc_reset_link - reset link DPC  routine
>   * @dev: pointer to Root Port's pci_dev data structure
>   *
> diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
> index 6844347..4950f49 100644
> --- a/drivers/pci/pcie/pcie-err.c
> +++ b/drivers/pci/pcie/pcie-err.c
> @@ -256,6 +258,15 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
>  		result_data.result = PCI_ERS_RESULT_RECOVERED;
>  
>  	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +		/* If DPC is triggered, call resume error hanlder

		                                          handler

Kernel multi-line comment style is:
		/*
		 * Begin comment here.
		 * foo bar blah
		 */

> +		 * because, at this point we can safely assume that
> +		 * link recovery has happened.
> +		 */
> +		if ((severity == DPC_FATAL) &&
> +			(cb == report_resume)) {
> +			cb(dev, NULL);
> +			return PCI_ERS_RESULT_RECOVERED;
> +		}
>  		/*
>  		 * If the error is reported by a bridge, we think this error
>  		 * is related to the downstream link of the bridge, so we

thanks,
-- 
~Randy
