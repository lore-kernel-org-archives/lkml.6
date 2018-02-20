Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AH8x225Tgru6+OybaZQ3uCHcPETaHeGSWEn1x2Kn0kNfxeLFOb/oWG53C3/Pz60HzMgYVGKpl45u
ARC-Seal: i=1; a=rsa-sha256; t=1519102624; cv=none;
        d=google.com; s=arc-20160816;
        b=jwC4vrfxzwd2/XI028E81lnTiMPm2HSfCEfjNENgL6bY8IqG0vJ54O9zfsXM9I2r1/
         eU4QPmOAYXGnDTUJU0nb+9blwZIqGnk6tH9qi0RClonLZ99P877oLxRUVXlCJk5mZi6q
         LOBK7+ANuEaVjbfnhZtqRx8Z/0HBoZZTBbImqRFqdKMoExzerq2L4YbA/OQuvwH9FL+N
         3FzMZ4V9mMvGPk9V0AmkHCG3ZL9v0Vsb0PEzvjKII5AEqVt/ujpYhXxpBGTJI+fZMG4U
         FCaCZYb39FXEPe/mPFColqqFp5j/2JDQZY3nDLxH7jHAEWVOWStSYdNAL9XaR43nMsnO
         lesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:to:from:date
         :content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=a4DIXkSrMo2oj2t5+qKIydhf8HgEO91XGNvd5D713Eg=;
        b=xtK1VdtLENXL5NsaItoDR+vflrTfDRwnMUHSL2fcyVCdOMAxzxQL4esei+3gqxgC40
         HkY5ThvPZxFkahPUs6fKMp5va2WJUfAuGmkEc0PifEj+W5FAOYLRwE+lmggN32Y0xJ8d
         +2AkhWmaV5GZcoSLLfMcAVj94cMmDuKciD7urxIMAgbW9DczYcoGUWy3YwWFIY9jUjpf
         LzUkN5a0hy4iXNx3FL+6vVooStXDUX78cs/A/PXqC14bc/1s+pGPHR5/8ZxOMRyNWLTf
         D8+9moVDunAD9reX3f2zs0xkO5U1buA6NjpZUHKrXlbHKrigJX5zyXPNNbwXsE3uG9uk
         jeqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=J02ZrgfT;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=J02ZrgfT;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=J02ZrgfT;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=J02ZrgfT;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Feb 2018 10:27:02 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v7 0/7] Address error and recovery for AER and DPC
In-Reply-To: <1516430119-3825-1-git-send-email-poza@codeaurora.org>
References: <1516430119-3825-1-git-send-email-poza@codeaurora.org>
Message-ID: <b667e39f9d16a90ff8745f90010871da@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590092241313961369?=
X-GMAIL-MSGID: =?utf-8?q?1592894554226498513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-01-20 12:05, Oza Pawandeep wrote:
> This patch set brings in error handling support for DPC
> 
> The current implementation of AER and error message broadcasting to the
> EP driver is tightly coupled and limited to AER service driver.
> It is important to factor out broadcasting and other link handling
> callbacks. So that not only when AER gets triggered, but also when DPC 
> get
> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
> 
> DPC should enumerate the devices after recovering the link, which is
> achieved by implementing error_resume callback.
> 
> Changes since v6:
>     Sinan's and Stefan's comments implemented.
> 	> reordered patch 6 and 7
> 	> cleaned up
> Changes since v5:
>     Sinan's and Keith's comments incorporated.
>         > made separate patch for mutex
>         > unified error repotting codes into driver/pci/pci.h
>         > got rid of wait link active/inactive and
>           made generic function in driver/pci/pci.c
> Changes since v4:
>     Bjorn's comments incorporated.
>         > Renamed only do_recovery.
>         > moved the things more locally to drivers/pci/pci.h
> Changes since v3:
>     Bjorn's comments incorporated.
>         > Made separate patch renaming generic pci_err.c
>         > Introduce pci_err.h to contain all the error types and 
> recovery
>         > removed all the dependencies on pci.h
> Changes since v2:
>     Based on feedback from Keith:
>     "
>     When DPC is triggered due to receipt of an uncorrectable error 
> Message,
>     the Requester ID from the Message is recorded in the DPC Error
>     Source ID register and that Message is discarded and not forwarded 
> Upstream.
>     "
>     Removed the patch where AER checks if DPC service is active
> Changes since v1:
>     Kbuild errors fixed:
>         > pci_find_dpc_dev made static
>         > ras_event.h updated
>         > pci_find_aer_service call with CONFIG check
>         > pci_find_dpc_service call with CONFIG check
> 
> Oza Pawandeep (7):
>   PCI/AER: Rename error recovery to generic pci naming
>   PCI/AER: factor out error reporting from AER
>   PCI/ERR: add mutex to synchronize recovery
>   PCI/DPC: Unify and plumb error handling into DPC
>   PCI/AER: Unify aer error defines at single space
>   PCI/DPC: Enumerate the devices after DPC trigger event
>   PCI: Unify wait for link active into generic pci
> 
>  drivers/acpi/apei/ghes.c               |   1 +
>  drivers/pci/hotplug/pciehp_hpc.c       |  21 +-
>  drivers/pci/pci.c                      |  39 +++-
>  drivers/pci/pci.h                      |  11 +
>  drivers/pci/pcie/Makefile              |   2 +-
>  drivers/pci/pcie/aer/aerdrv.h          |  30 ---
>  drivers/pci/pcie/aer/aerdrv_core.c     | 293 
> +-------------------------
>  drivers/pci/pcie/aer/aerdrv_errprint.c |   1 +
>  drivers/pci/pcie/pcie-dpc.c            | 115 ++++++++++-
>  drivers/pci/pcie/pcie-err.c            | 366 
> +++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h             |   2 +
>  include/linux/aer.h                    |   4 -
>  include/linux/pci.h                    |   1 +
>  13 files changed, 534 insertions(+), 352 deletions(-)
>  create mode 100644 drivers/pci/pcie/pcie-err.c

Hi Bjorn,

I will rebase this patch series on pci and post it again.
on
https://kernel.googlesource.com/pub/scm/linux/kernel/git/helgaas/pci

Regards,
Oza.
