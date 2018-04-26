Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AB8JxZoD1tN4xYhnMfDS1zZYNsyLkWU2Gnbl/DYlPQFi8swbxfYRZ+ELu9+A0i/OFLaAbUBTmGg/
ARC-Seal: i=1; a=rsa-sha256; t=1524720654; cv=none;
        d=google.com; s=arc-20160816;
        b=FQMaZG5+uUEbmlC5OLCNQd4Ymh6dcsIFUxB+1AVVBQru+b4Db/PTRFKsq+xryOjz8L
         LuCzp5p/CbC2Q+jAMTVr/LcFzIfHw1SiZ9dB4vJKZ1lJ4Pb4PWG/vslwS/yS8CjuDh/n
         j3f8Fy5c7Jku+O/fIiiWSJ/Z3QmW/9oFmIr4Inek6kpz1Og5rPoeJDHMP0d+MMmZUAWN
         YP05lb/6W406yljrLyx3Tuu18zlSoN5mrxuYqFkNB/rLQfo4a3rUaUkctAAs2h/FRCKS
         7DfV9XmQujCR79fgb8x6pCbGRFpAIUQgeKhlZeaOzrI5eGZah1pp56bH6kXNdkP8xCjc
         71TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:to:from:date
         :content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=Jz8XiEO2B2XTltJYmy419yr+f4QHe+foSP0XTEz0MS8=;
        b=ngDI0VhUoVd9LlQ1aywINFAnDTy1XCjCjQlhUvPYZWpscteBPROQqPyv0jmjomtwBJ
         uBdvfEMRgpKU4QVouAmX8VOVkv2ToTbkCzkW24LMIrSDM7938tfct8m3UMhoLkSK3mnB
         pCD+yl3GDppX3IMFBtVIxH5aQ/txNpb6S3Vk/vaYfkQfZyeCZ5KpFbbZY6cNLMQSm7Mp
         4ciFI+U4YhCdub+TsMXx2WxzPml7wyM7eCvGOILOdpfJnn2Uxbo5qvdG37xdXzi7pYkr
         3mhtHbIbckLI0kR0kZbXlXITAnuy83ljdmp7AKu02KLGY3fm0BdRS7ZLb9RM4lxQ3clU
         Rfow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VjvqQwfB;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YiPlhahF;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=VjvqQwfB;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YiPlhahF;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Apr 2018 11:00:52 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v14 0/9] Address error and recovery for AER and DPC
In-Reply-To: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
Message-ID: <f97676e307fe7a02f1f2059a140a5e32@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550963799959493?=
X-GMAIL-MSGID: =?utf-8?q?1598785484961255771?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-23 20:53, Oza Pawandeep wrote:
> This patch set brings in error handling support for DPC
> 
> The current implementation of AER and error message broadcasting to the
> EP driver is tightly coupled and limited to AER service driver.
> It is important to factor out broadcasting and other link handling
> callbacks. So that not only when AER gets triggered, but also when DPC 
> get
> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
> 
> The goal of the patch-set is:
> DPC should handle the error handling and recovery similar to AER, 
> because
> finally both are attempting recovery in some or the other way,
> and for that error handling and recovery framework has to be loosely
> coupled.
> 
> It achieves uniformity and transparency to the error handling agents 
> such
> as AER, DPC, with respect to recovery and error handling.
> 
> So, this patch-set tries to unify lot of things between error agents 
> and
> make them behave in a well defined way. (be it error (FATAL, NON_FATAL)
> handling or recovery).
> 
> The FATAL error handling is handled with remove/reset_link/re-enumerate
> sequence while the NON_FATAL follows the default path.
> Documentation/PCI/pci-error-recovery.txt talks more on that.
> 
> Changes since v13:
>     Bjorn's comments addressed
>     > handke FATAL errors with remove devices followed by 
> re-enumeration.
>     > changes in AER and DPC along with required Documentation.
> Changes since v12:
>     Bjorn's and Keith's Comments addressed.
>     > Made DPC and AER error handling identical <aligned err.c>
>     > hanldled cases for hotplug enabled system differently.
> Changes since v11:
>     Bjorn's comments addressed.
>     > rename pcie-err.c to err.c
>     > removed EXPORT_SYMBOL
>     > made generic find_serivce function in port driver.
>     > removed mutex patch as no need to have mutex in pcie_do_recovery
>     > brough in DPC_FATAL in aer.h
>     > so now all the error codes (AER and DPC) are unified in aer.h
> Changes since v10:
>     Christoph Hellwig's, David Laight's and Randy Dunlap's
>     comments addressed.
>         > renamed pci_do_recovery to pcie_do_recovery
>         > removed inner braces in conditional statements.
>         > restrctured the code in pci_wait_for_link
>         > EXPORT_SYMBOL_GPL
> Changes since v9:
>     Sinan's comments addressed.
>         > bool active = true; unnecessary variable removed.
> Changes since v8:
>     Fixed Kbuild errors.
> Changes since v7:
>     Rebased the code on pci master
>         > 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/helgaas/pci
> Changes since v6:
>     Sinan's and Stefan's comments implemented.
>         > reordered patch 6 and 7
>         > cleaned up
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
> Oza Pawandeep (9):
>   PCI/AER: Rename error recovery to generic PCI naming
>   PCI/AER: Factor out error reporting from AER
>   PCI/PORTDRV: Implement generic find service
>   PCI/PORTDRV: Implement generic find device
>   PCI/DPC: Unify and plumb error handling into DPC
>   PCI: Unify wait for link active into generic PCI
>   PCI/DPC: Disable ERR_NONFATAL for DPC
>   PCI/AER/DPC: Align FATAL error handling for AER and DPC
>   pci-error-recovery: Add AER_FATAL handling
> 
>  Documentation/PCI/pci-error-recovery.txt |  35 ++-
>  drivers/pci/hotplug/pciehp_hpc.c         |  20 +-
>  drivers/pci/pci.c                        |  30 +++
>  drivers/pci/pci.h                        |   5 +
>  drivers/pci/pcie/Makefile                |   2 +-
>  drivers/pci/pcie/aer/aerdrv.c            |   2 +
>  drivers/pci/pcie/aer/aerdrv.h            |  30 ---
>  drivers/pci/pcie/aer/aerdrv_core.c       | 317 
> +-------------------------
>  drivers/pci/pcie/err.c                   | 374 
> +++++++++++++++++++++++++++++++
>  drivers/pci/pcie/pcie-dpc.c              |  63 +++---
>  drivers/pci/pcie/portdrv.h               |   4 +
>  drivers/pci/pcie/portdrv_core.c          |  69 ++++++
>  include/linux/aer.h                      |   2 +
>  include/uapi/linux/pci_regs.h            |   3 +-
>  14 files changed, 552 insertions(+), 404 deletions(-)
>  create mode 100644 drivers/pci/pcie/err.c

Hi Bjorn,

I know I need to rebase this whole patch-set to 4.17 now.

But before I do that, can you please help to comment.

Regards,
Oza.
