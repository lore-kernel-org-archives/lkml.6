Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AH8x227NnW2BBb8PLFObDLugGiTpHvngBem2iLMWmSBvdaLY7LHM3PstCy9nV22y/kH0Y3hn98Z9
ARC-Seal: i=1; a=rsa-sha256; t=1519853058; cv=none;
        d=google.com; s=arc-20160816;
        b=dF8+PrKF1jh6Eqarfus0KAYC6rxpxbcZVySIoiHPqgLOLLi9BzKdsioO1qGjifRQAJ
         4+orfQc8SIebL1HByRF4Nx4/QqE+n91h/lqOPi6MOKhF51nq1sEGo8cwrEmbfwi5lQnK
         PO0oBMV+Fu69Nw/dm8uSeuMRMAYGF2qDCblzzsb2vlYlFGY/Fii8LdgWLkZOH9FuMCTU
         cEU3+u6e55VCJ0SINwAdvVUQSlz7noG6WJXI/AjBCc2N3TlnXskLSq0P7LDW8lCLc6rG
         KjTpCl+iRa7zSnPovMHyZTWpNNyGWr4UgGHM6lF6fJyI0zNKDI1N1wkg7pWrB0Y9pWJ1
         p0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=5JlSGn1wMF4M8N4F1qD6nRWbYgtJXn44Q98BAF/hCbQ=;
        b=EfZ0sptpBx40Jn9dQmKPm2yQTsuOtb3sc3r+B85s4g/gt+hOXjYevthm0DsYruUB6f
         1PIPTAtYma/75zQc/smLhSyMYwU9cckCkAJeA4TQJbLVWJhOpmqxyO/S0nfvwUudnw8h
         7xkbNjJfGus9jxcrYoYMEAfm8kuiR8PhpgewEomJJcqyV8eRcUmV5zrxEIsN2sCwxshH
         ewrzT3etDV/ZzqZCkH2i79PO9Ssm8lTiE798m+2lmkP90YpOgAztkkTH5c2+np4BAyOH
         8sAAJqt4u9Efzckdd/dm2fMQthmNO5uLkU9vXAMPrdnMiDCpbbHtBcFWvBLSLxnQZYQd
         NdRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D312133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Wed, 28 Feb 2018 15:24:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
	Kees Cook <keescook@chromium.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>, Yinghai Lu <yinghai@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2] PCI/ASPM: Suppress common clock mode setting failure
Message-ID: <20180228212417.GM127842@bhelgaas-glaptop.roam.corp.google.com>
References: <1516651924-21820-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516651924-21820-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590324818171191002?=
X-GMAIL-MSGID: =?utf-8?q?1593681440750515144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jan 22, 2018 at 03:12:01PM -0500, Sinan Kaya wrote:
> Code is emitting warnings when it tries to set the common clock mode for
> ASPM and ASPM is already configured to common clock mode by the UEFI BIOS.
> Let's bail out silently in such a case.
> 
> pci 0004:00:00.0: ASPM: Could not configure common clock
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied to pci/aspm for v4.17, thanks!

> ---
>  drivers/pci/pcie/aspm.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 9783e10..913b90d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -240,6 +240,24 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>  	if (!(reg16 & PCI_EXP_LNKSTA_SLC))
>  		same_clock = 0;
>  
> +	/* Port might be already in common clock mode */
> +	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> +	if (same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
> +		bool consistent = true;
> +
> +		list_for_each_entry(child, &linkbus->devices, bus_list) {
> +			pcie_capability_read_word(child, PCI_EXP_LNKCTL,
> +						  &reg16);
> +			if (!(reg16 & PCI_EXP_LNKCTL_CCC)) {
> +				consistent = false;
> +				break;
> +			}
> +		}
> +		if (consistent)
> +			return;
> +		dev_warn(&parent->dev, "ASPM: current common clock configuration is broken, reconfiguring\n");
> +	}
> +
>  	/* Configure downstream component, all functions */
>  	list_for_each_entry(child, &linkbus->devices, bus_list) {
>  		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
