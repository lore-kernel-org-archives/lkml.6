Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AH8x224kbNDJ+Jml3GYcUsE2pvHCxr+KOntcNgVxmyd1dD/DBBxsk2tyrNFDHd2SDlSYMGCsRx5a
ARC-Seal: i=1; a=rsa-sha256; t=1519429527; cv=none;
        d=google.com; s=arc-20160816;
        b=XbKqOxYjJpjbw10W403mDQvpNEhBe4qRULxnnpQvDGrwO9vm/8u0Rn8MGo22RvK12k
         MzHZ1B3RvfCaogp1sHj1fsG0v58YaDarFHR9PI/JnRp3bnGaZqkASTmgxodIve/Z+Bws
         nq5SL3pQRioPXqhEs0VJGVnyJIYLd02znFN9ZaMQT9ucFnOx1bOidJTDW7fYxyjwq+4r
         9JCnklsYZ8MMiko8OSIdOaWow7OOmgxhH+0vyIcATS7ldcJQATEDGlJLX0OXCk2f6+Vb
         FOIEoR1ij6BHOE3A8GO9LGCUmCHJ7o72/rtx4x0krBd8HFWW/WKrdMQZRO7pCBcunqjj
         uSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=o1fCnCG5bQcV+MOO5h2fRBZtx75aSK4Wg4pRWdf5Pds=;
        b=IXToriUsY/EoaSMf5fJccTdqVVEybnVIePttGipRhBEU9Vkdr6jnpDmxaV7QgSSpYY
         VdcakjLnkdkogLA3xioA5O5fNSFopLyspMfQFcQDHB3/qa22mwkfGVBfC4IRmUXJGEQT
         moEy2cqBa8mTUNL8+WvxVcjH2Ly4MqWI60rh2oVHdCGf3YMppoRZFMVsVZ36pQqJ4S61
         4OIw4b2mkMuttU8//8ART3hugtagXetXB1vB4KgAk422Qwjpcn8whSvtaT5eth0M6VXV
         /BRJQKtGDn7UOoFtrSUWAi+KzF0gn47EvO0lZ/3br3cKq6Wbf+l6WfFL5K+2OJc2OpOl
         Sh/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2E621784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Fri, 23 Feb 2018 17:45:25 -0600
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
Subject: Re: [PATCH v11 3/7] PCI/ERR: add mutex to synchronize recovery
Message-ID: <20180223234525.GQ14632@bhelgaas-glaptop.roam.corp.google.com>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
 <1519374244-20539-4-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519374244-20539-4-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086412177501980?=
X-GMAIL-MSGID: =?utf-8?q?1593237336442593707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 01:54:00PM +0530, Oza Pawandeep wrote:
> This patch protects pci_do_recovery with mutex.

pcie_do_recovery()

Please explain why the mutex is necessary.  What bad things happen
without the mutex?

You named (some) of the other things "pcie"; maybe use "pcie" in the
mutex name as well so they look the same.

> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
> index fcd5add..f830975 100644
> --- a/drivers/pci/pcie/pcie-err.c
> +++ b/drivers/pci/pcie/pcie-err.c
> @@ -20,6 +20,8 @@
>  #include <linux/pcieport_if.h>
>  #include "portdrv.h"
>  
> +static DEFINE_MUTEX(pci_err_recovery_lock);
> +
>  struct aer_broadcast_data {
>  	enum pci_channel_state state;
>  	enum pci_ers_result result;
> @@ -283,6 +285,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
>  	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
>  	enum pci_channel_state state;
>  
> +	mutex_lock(&pci_err_recovery_lock);
> +
>  	if (severity == AER_FATAL)
>  		state = pci_channel_io_frozen;
>  	else
> @@ -326,9 +330,11 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
>  				report_resume);
>  
>  	dev_info(&dev->dev, "Device recovery successful\n");
> +	mutex_unlock(&pci_err_recovery_lock);
>  	return;
>  
>  failed:
>  	/* TODO: Should kernel panic here? */
>  	dev_info(&dev->dev, "Device recovery failed\n");
> +	mutex_unlock(&pci_err_recovery_lock);
>  }
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
