Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AG47ELv84Gy06Uo7TstBzdVyVFub0HfC7+h5girX8D01z9/MavqkzAnaEydyYClNP8bTyHm7BVZz
ARC-Seal: i=1; a=rsa-sha256; t=1520873066; cv=none;
        d=google.com; s=arc-20160816;
        b=cbBsy0Dj+z40emMTenIiToMKNhxCSqV0jvD/sim8VKbNGWNiK/aVjcYtc9FjHie3ZZ
         TRljGmkLVSzUakhZS63O3fNN6BovXG6DNWZfuO36g2Vfd9iDRDv40NYmlbwVs3MdXUzU
         l3bN52Nwlry0AhjrRb5ul5XtUIz6f5Lt7A/YXrla1+np5XrCAnyM7MTcHnwGsxhIxROS
         3ZdxCMHslKDmMKTlaypS/NZs9WQ7gYH+jNRLLByfDOGeU0SVQsAg/kwwVuqC7oB5Adec
         PHNOFomS3AT/nOoP8mzRKtvLRLmQznc2FtfZm3+IpLjRMkHKDfrwOZG0bXyLHFiDko7C
         xOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=nyTGGf3OJL8Ay3kSSEqYsdjYbIaNsubdbWq4nFEgNcc=;
        b=GbHZDcs2QxXnthhBZ3exU6rG6KprAZjgXYLKGHsn9/A9MOTlg5fQ+MyJwRUl0/+j6y
         a0AaiUOmYheZp2/JnvhZ8b2lmn4oqgxirj/1WU4v/TiUa02Xb0jCyNWoaF6G6unWOYtm
         tYPLQngnGA8JI+6+MRf0CThxOY5J1O8wL+DNPJ94xQlR5yRnURFSl0rIJr4vVaA2Hb+f
         H6R0Z4e9ocCj4p3chrMFmU2TPjV7gHHWLy3U4xPunXWf8HNMbAi954iZpflkLP1IGtb+
         hlLmxdpW0BxMTEOl+EqPZYZ1l3IF9sjG0ee7i8atoL8tBwoF/7HhnJ+3YiaHFw3LB7rA
         hNDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jGlEM7dc;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jGlEM7dc;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jGlEM7dc;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jGlEM7dc;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E370600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus infrastructure
To: Nipun Gupta <nipun.gupta@nxp.com>, hch@lst.de, robin.murphy@arm.com,
 linux@armlinux.org.uk, gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
 bhelgaas@google.com
Cc: dmitry.torokhov@gmail.com, rafael.j.wysocki@intel.com,
 jarkko.sakkinen@linux.intel.com, linus.walleij@linaro.org, johan@kernel.org,
 msuchanek@suse.de, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <6a76df69-8c6c-52a6-0afd-fd0b8d2ff703@codeaurora.org>
Date: Mon, 12 Mar 2018 12:44:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1594750996273751393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/12/2018 11:24 AM, Nipun Gupta wrote:
> +	if (dma_dev->of_node) {
> +		ret = of_dma_configure(dev, dma_dev->of_node);
> +	} else if (has_acpi_companion(dma_dev)) {
> +		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
> +		if (attr != DEV_DMA_NOT_SUPPORTED)
> +			ret = acpi_dma_configure(dev, attr);
> +	}
> +
> +	pci_put_host_bridge_device(bridge);
> +
> +	return ret;
> +}
> +
> +void pci_dma_deconfigure(struct device *dev)
> +{
> +	of_dma_deconfigure(dev);
> +	acpi_dma_deconfigure(dev);
> +}

Isn't this one or the other one but not both?

Something like:

if (dev->of_node)
	of_dma_deconfigure(dev);
else
	acpi_dma_deconfigure(dev);

should work.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
