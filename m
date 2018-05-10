Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZr1TU18u7peEgReB9XuUQTq17DeBwdNaN2tmJz0gXXc7vYufuQZfQOlszXlwhi3DjNPqelS
ARC-Seal: i=1; a=rsa-sha256; t=1525958764; cv=none;
        d=google.com; s=arc-20160816;
        b=nwArr6mGmFG8gIUCeYtgpt4+uH1EFlx1kActdGsFtIStJRiwjZszorJ+LClh4iXGHA
         qf95rFaLAWfJyqdCWraAHLBEN1zx8J8KzR1kAb7Y4DmIbLlkF3MWKjwS9EPIvcznCxB3
         d4wKcbsyQ/y+Ir+FSsllq1LWVflq5AbG3TjpGg4azWZMG7ODT68c9PvMojTy4CuZD8b6
         6JGfYxUWE/2kxoEojLEIEQ7S//JfGSFA09GbGfCJn3iDESVngcjNFcurbR2LtgfxKGgT
         4i0y8+S4/kHUNkB+roniol+NW3nXEtCoE7CvtWQ0anDveoHCgpNnmFoD0EgCM7zcumBq
         ahYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=xXLckK4L5qa5cLKjC/fhHtVEjy0yoa+o3lbmWle2N50=;
        b=p620v0xQpseoOQCRqjsBkkx+AwwJmlwAV8M6G0/a5iLnDoMBNY4J1vgYf5HzNGyogy
         W0U9dHMwwxQJ0TF7GZRwMXhlxj1KYRzXNswmZZ3t6JtXgtYQRzxQYT8acUOiBUQRkCFr
         YO1VR9YJviy5hzMdi6saOsQwf/9C/+3SHmLVRRETWGChXS+4TwUQx4kpe5MEIbVDzR7h
         n0uU+zRFht3sOB4hMNn9ronHBF1O/z9EKK4tc0GuAUKlK3HHKOG2rKykutaVCuD443KZ
         qJMbACDOdJ3UzJxO+orJ6/IvEmY6SI1fos6aweQ1bVEfKITpRVRAIhfDbZ+GHoqqK+a3
         8hDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xBwUWn6h;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xBwUWn6h;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 10 May 2018 08:26:02 -0500
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
Subject: Re: [PATCH v15 9/9] PCI/DPC: Disable ERR_NONFATAL and enable
 ERR_FATAL for DPC
Message-ID: <20180510132602.GF173327@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-10-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525323838-1735-10-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417977949532596?=
X-GMAIL-MSGID: =?utf-8?q?1600083737644155003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 01:03:58AM -0400, Oza Pawandeep wrote:
> This patch disables ERR_NONFATAL trigger for DPC, so now DPC
> handles only ERR_FATAL.
> ...

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 103ba79..86f1cc2 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -981,6 +981,7 @@
>  #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
>  
>  #define PCI_EXP_DPC_CTL			6	/* DPC control */
> +#define	 PCI_EXP_DPC_CTL_EN_FATAL	0x0001	/* Enable trigger on ERR_FATAL message */

There's a tab instead of a space after the #define.  The other #defines use
a space.  Looks the same in the end, but makes the patch look funny.

>  #define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
>  #define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
>  
> -- 
> 2.7.4
> 
