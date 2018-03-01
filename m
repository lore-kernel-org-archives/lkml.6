Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AG47ELvS4wlbGMcYmlTXtiu76Mf4UlUe21ER7Hkf0r8w9D5BLznJmHBOZXPo+tbCLWW+nZ3FFY++
ARC-Seal: i=1; a=rsa-sha256; t=1519918684; cv=none;
        d=google.com; s=arc-20160816;
        b=Fk/3879FKQUz/T7+sVcEsRGFzKplC1IJADvJJa8lYycbBmVD65FWc45ktoFaHj1nN8
         gUZWEGZzuJhpExURXwd5lH8wCWVe75pWMrcTYdM5AWMZ2UclKoFIqr4oX6VrHEO6UEC1
         VBfMcdwqzHT5hKHss6lktmocYWKBA9elYn4d51Sl43o5JTC1XQqcEhOGGEInvtpgdNfP
         Fdam7f4GmBfBDs+Rgrku+YQg3oGghIYp8sj0gSI4f5Rz0ADI+1V1dkPwTtS2z84Xr/DO
         PngmkM4MVaVVfltJvsrguQKB0zfTYdVOxJoA5/joJXFBjT6h9tQdQr3o6G4MeF2xuIBu
         SH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=yTSlMspq68DzprtlG2JJ+djWoyt+05wYTK6NCT3eu58=;
        b=pDGl1WdPdpTjHdcNvJq6sMZi2qoQBojO6GZ7fnVunFNHG6zTMkap3IkUgTHKxofrSo
         vEsSIsIJVsnFcZF8n+JjW2AvCg3xE4acRJBRc1nq6bpvGaoCFpQsX1h4Eb/I5dd8Hofn
         7WMmy/dz8/yntq8/3qi3lpE91JzP+P4tO5OEK4JB0B/TJwJ6S1d/e2wF8CkardyMAZ2+
         UuVFn+M9kCwydlt5mPpPnPE1V2XHotWyCDiKk24uvswBOa8BxLTJTDOsBsWaGFmO/iSg
         Ur7utMxk5+cccesgauzbF0eIPJY92K7+A8aYhiJjiuFY3t0nlTqdQ5dXBBjx/PQVHHok
         Z8eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FB920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Thu, 1 Mar 2018 09:38:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] PCI/DPC: Fix INT legacy interrupt in dpc_irq
Message-ID: <20180301153802.GD13722@bhelgaas-glaptop.roam.corp.google.com>
References: <1517415535-21850-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517415535-21850-1-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591125527357545721?=
X-GMAIL-MSGID: =?utf-8?q?1593750254557354281?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Oza,

On Wed, Jan 31, 2018 at 09:48:55PM +0530, Oza Pawandeep wrote:
> Current dpc driver acknowledge the interrupt in deferred work, which works
> okay since LPI are edge triggered.
> But when RP does not have MSI support, port service driver falls back to
> legacy GIC SPI interrupts, and with current code we do not acknowledge the
> interrupt and we get dpc interrupt storm.
> This patch acknowledges the interrupt in interrupt handler.

Would you mind rephrasing this changelog in generic PCIe terms?  E.g.,
"LPI" and "GIC SPI" are meaningless to me (I assume they're
arm64-specific things), but I don't think it's any arm64-specific
thing that motivates this change.  IIUC, the issue should occur any
time we're not using MSI, so we should be able to describe it in
purely PCIe terms.

s/dpc/DPC/ in text.

It looks like this changelog is intended to be multiple paragraphs; if
so, please leave a blank line between them.  It's a little awkward to
infer "this is a new paragraph" from the fact that "the previous line
didn't look full" :)

Please rebase to my "master" branch (v4.16-rc1).  There was some minor
change that made this not apply cleanly.

> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index 2d976a6..570b561 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -134,7 +134,7 @@ static void interrupt_event_handler(struct work_struct *work)
>  	}
>  
>  	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
> -		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
> +			      PCI_EXP_DPC_STATUS_TRIGGER);
>  }
>  
>  static void dpc_rp_pio_print_tlp_header(struct device *dev,
> @@ -277,6 +277,8 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  
>  		schedule_work(&dpc->work);
>  	}
> +	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
> +			      PCI_EXP_DPC_STATUS_INTERRUPT);
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
