Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x224kqBQuxiJRBsXTZXz8ENhB8MJ0OHFpiKHhkulmMq/eY4slFYEx4rIfOQrCxoLKUeh/ZD6N
ARC-Seal: i=1; a=rsa-sha256; t=1519327430; cv=none;
        d=google.com; s=arc-20160816;
        b=y/3NQJGnVL6UHtI8HE+HKDCwSkNpW90vd8LuOdsb5saUzh9y/4jdMhzGk0liInODHn
         5Kv7wA7lmutDk+Li5phcFtlTBrKjqZq1H6YdrYU1NolTH/dk+lbpzP/Y8hWnu1BHhY9Y
         etu/T5s5C/V0HtPqnlhYP3kMgSTOOwkTZFp2KSHNJtDJfDORvel2iXM4IyETERkf++nL
         M1F0Q5bGQfU5mkFsmgRt887ZNR/NoxG2ISgufEapF0+drmrlTm//Z7dSQ7U+Kg80swOk
         PKe2nBOPMmI0SB7ofNcLUGxBeF16tu/YRa7n9+oJ8y/uCwxd29zRj9VZiZMkegAXER4W
         boRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:subject:from
         :dkim-signature:arc-authentication-results;
        bh=A1wSrgvMqlqzM3pqBALY8s+AqpQtz80ARk0u9dcZ/bM=;
        b=pBVgsGzngckELuMma7SDfrNBuYRodDEcU2iPcdHv6e2of0xa6QvJXK1ZR+TIznURIg
         Zr65+7q8DMCBbB3ParbTjlNIX4MOH/YNdF+b9apT48jaSIoAivyJF14hRDCjxJ8POz+O
         3Pa15w2hpRB/SGhcxhtR46y36Rrn46i0OUJWAOlN3HBkZtT1wJi8M8cgDy47ejWRfTBg
         dNWHc4nA0Gy6iUphqIknehOG4YgvhMZcuHaYb9kvG8M/kMKnQevVPZSo0XrWqh1YqYAH
         jAF2ERmHkh/E1LcKohwA0IHzqH0YB8DwhtPYS767nZbJDk53yw7UxveCqB0JdtuVh11t
         qKIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=KbXk6isO;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=KbXk6isO;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v9 4/7] PCI/DPC: Unify and plumb error handling into DPC
To: Oza Pawandeep <poza@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
 Sinan Kaya <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
References: <1519285571-5634-1-git-send-email-poza@codeaurora.org>
 <1519285571-5634-5-git-send-email-poza@codeaurora.org>
Message-ID: <fc5351ba-1310-5ccf-b0cb-8565679d4c22@infradead.org>
Date: Thu, 22 Feb 2018 11:23:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519285571-5634-5-git-send-email-poza@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086415695868818?=
X-GMAIL-MSGID: =?utf-8?q?1593130277808865523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 11:46 PM, Oza Pawandeep wrote:
> Current DPC driver does not do recovery, e.g. calling end-point's driver's
> callbacks, which sanitize the sw.
> 
> DPC driver implements link_reset callback, and calls pci_do_recovery.

Hi,
What does DPC mean?

> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 

> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index 38e40c6..208b427 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c

> @@ -82,12 +137,25 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
>  		dev_warn(dev, "Link state not disabled for DPC event\n");
>  }
>  
> +/**
> + * dpc_reset_link - reset link DPC  routine
 + * @dev: pointer to Root Port's pci_dev data structure

   * @pdev: ...

> + *
> + * Invoked by Port Bus driver when performing link reset at Root Port.
> + */
> +static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  {

You can use 'make W=1 ...' to find kernel-doc warnings like this.

thanks,
-- 
~Randy
