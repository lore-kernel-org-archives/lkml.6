Return-Path: <BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AH8x226xMBchDj5qppj4RDjVupY8S79KLClyQi61MA2hhQ66JMdKdinf9R/7Ld0xG2i+hdBvGoDc
ARC-Seal: i=1; a=rsa-sha256; t=1519324797; cv=none;
        d=google.com; s=arc-20160816;
        b=L1QaSmL2LS9+mz2Coqfk7UyYcLByJlLWv0wFWnGQgRjh3hNtBEVrLPS6eKY+fMdpEu
         jB9T5pV1Il5bolH3MSkeUdcF406S8dOvDvaZbW7xpoF62L7aK+4Kk9L2PxhNd2WUKKNR
         itfra6VgzZfDB1Tnpx1TqZlthCSB5WPNxO9rdgJT9A/tIu33qjoGZIvT+hoIc2YbuLwn
         9pYvr1chK4ePbtf1pkYk1h3wfa9iIpzNQ5Rj1iX0YkLAsM9L8OqxgtnTOfZCPGgtF/yp
         c2uMLv0UavbwIDDmofJyZjpKuQq+lRSKHR79lnugQv3HlYCMn4qbp6M96e67bMgpXEZL
         72Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=KE6hqGOW/JqVQmwPivA52ePK84SGNU0eP8bcPU7aPiI=;
        b=V8oWlzBjzcZVhYOJkzGzRrkmotQpN3n0Lk/htcEIDkbxsidCQrPDZyKK1/CRlL4Hs5
         pEzvLq6GtHLdk7xwAPq/9HxIajtw7TkmcwRWnSFYfY+de5JD1rTmLFWJ2n14WLA5HaWY
         bR13uzmf+Y1YEVDJ/o1lWHL60r33LrquNfBocGBVwV/G9nNOVHmLwHj0TUOWpy/0D9v1
         6weBb/k6ivMsMWk0UiQq7lTOvzGSJpt4/X/LJR0LNNdkTm4NQ9uTByWg1n54dlh87YWF
         s9oSHtD6gr9YBDZcrtgnkjZabdqwKAy8g6oWIduf+6p4TRbxMMAQ8THy/yb+uTtEQh1x
         Gn9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=O4Nls3vD;
       spf=pass (google.com: best guess record for domain of batv+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=O4Nls3vD;
       spf=pass (google.com: best guess record for domain of batv+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+abca9b65bfc9abb1c9ae+5296+infradead.org+hch@bombadil.srs.infradead.org
Date: Thu, 22 Feb 2018 10:39:54 -0800
From: Christoph Hellwig <hch@infradead.org>
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
Subject: Re: [PATCH v10 4/7] PCI/DPC: Unify and plumb error handling into DPC
Message-ID: <20180222183954.GD6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-5-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519315332-26852-5-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086415695868818?=
X-GMAIL-MSGID: =?utf-8?q?1593127518775186829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 09:32:09PM +0530, Oza Pawandeep wrote:
> Current DPC driver does not do recovery, e.g. calling end-point's driver's
> callbacks, which sanitize the sw.
> 
> DPC driver implements link_reset callback, and calls pci_do_recovery.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a5a79f0..124f42e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -343,6 +343,8 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
>  void pci_enable_acs(struct pci_dev *dev);
>  
>  /* PCI error reporting and recovery */
> +#define DPC_FATAL	4
> +
>  void pci_do_recovery(struct pci_dev *dev, int severity);
>  
>  #ifdef CONFIG_PCIEASPM
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index 38e40c6..208b427 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -13,6 +13,7 @@
>  #include <linux/pcieport_if.h>
>  #include "../pci.h"
>  #include "aer/aerdrv.h"
> +#include "portdrv.h"
>  
>  struct dpc_dev {
>  	struct pcie_device	*dev;
> @@ -45,6 +46,60 @@ struct dpc_dev {
>  	"Memory Request Completion Timeout",		 /* Bit Position 18 */
>  };
>  
> +static int find_dpc_dev_iter(struct device *device, void *data)
> +{
> +	struct pcie_port_service_driver *service_driver;
> +	struct device **dev;
> +
> +	dev = (struct device **) data;
> +
> +	if (device->bus == &pcie_port_bus_type && device->driver) {
> +		service_driver = to_service_driver(device->driver);

Please move the initial assignment to the declaration line to
clean this up a bit:

	struct device **dev = (struct device **)data;

Same thing happens a couple more times in this patch.

> +EXPORT_SYMBOL(pci_find_dpc_service);

EXPORT_SYMBOL_GPL for PCI layer internals again - and ditto for
probably about everything in this series.

>  #if IS_ENABLED(CONFIG_PCIEAER)
> -	/* Use the aer driver of the component firstly */
> -	driver = pci_find_aer_service(udev);
> +	if ((severity == AER_FATAL) ||
> +	    (severity == AER_NONFATAL) ||
> +	    (severity == AER_CORRECTABLE))
> +		driver = pci_find_aer_service(udev);
>  #endif

No need for the inner braces here.

> -	if (severity == AER_FATAL)
> +	if ((severity == AER_FATAL) ||
> +	    (severity == DPC_FATAL))
>  		state = pci_channel_io_frozen;
>  	else
>  		state = pci_channel_io_normal;

Same here and a few more times below.
