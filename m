Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AG47ELsol8ScNOpzrngP26FYdHtsc0bJzf1IjNKtsYJ1mFMFONRQnqFFt1lwXyN24CBSehF57q4o
ARC-Seal: i=1; a=rsa-sha256; t=1519932417; cv=none;
        d=google.com; s=arc-20160816;
        b=FFBfmhCcMjlxq5BMmjGyVo15GL/df1HB5B4b73VSyeSk4XUq6f5uUTY8fAeMKHn88a
         zjUlAaRLEH0DDU6rxlYip6twMlspGTUbRLaQWJrpRpFqE+nVioZI1p/AgcPRdRarnNZF
         u8kyXxqhKZTVU51RUjl2ZfQB+9KPYHXW77CdXnNqLcisEegKw02Rywi3pP/N/FxFt2Bs
         nvJkGv5lyLnxwFYR+RZSEgS6LULYZuuBXokGoh/d7Y0J3p9X9omUYj1W0p6b8wnOWSXc
         bAlzmUUrrSIil3zOCSSK7Q7GCbXVS1T+d5IsZo5EJoocTmL1hBGRmY/zT90qKcy69edj
         LNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=E/5DVb4zp8bNegwP02jtxph4PFE7VCxvxpWM/LidNeA=;
        b=mt5BX5vsNVtvWHLvj5knv+U5aRGdFLS29cq2SACdS3he+SHOrrB5M6AUp/hqQU6h7x
         wkxBXWk4HaxR5uBWU/jfr6OzLxGlQFxvuVe9mjXRSI+V7CCwv0nZnzSchmdF5vPEcrYC
         +nbNMaVtBPa+qm+vxYUpDcn99K7i4Z6Bmos9Uf9qkWGpVYLCMq42JmK54cACYk7oFx90
         qWVUd4bD3pvW//i11jyIkDeKEKvA344AQA9nFju5aQtou2+WuecYSCJKlt7qocNygUY8
         1dGfYcVtvglbU9vGiOzRJUKBtxQO6titRkKwrQz8qa4RFT6CWXEPXEsQ/ykV/Y0pW09D
         dMRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="31724081"
Message-ID: <1519932408.10722.351.camel@linux.intel.com>
Subject: Re: [PATCH v15 6/9] HISI LPC: Support the LPC host on Hip06/Hip07
 with DT bindings
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>, mika.westerberg@linux.intel.com,
 rafael@kernel.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
 hanjun.guo@linaro.org, robh+dt@kernel.org, bhelgaas@google.com,
 arnd@arndb.de,  mark.rutland@arm.com, olof@lixom.net,
 dann.frazier@canonical.com,  andy.shevchenko@gmail.com, robh@kernel.org
Cc: joe@perches.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linuxarm@huawei.com,  minyard@acm.org, devicetree@vger.kernel.org,
 linux-arch@vger.kernel.org,  rdunlap@infradead.org,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 frowand.list@gmail.com, agraf@suse.de
Date: Thu, 01 Mar 2018 21:26:48 +0200
In-Reply-To: <1519663249-9850-7-git-send-email-john.garry@huawei.com>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
	 <1519663249-9850-7-git-send-email-john.garry@huawei.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593479230588912327?=
X-GMAIL-MSGID: =?utf-8?q?1593764654279493846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-02-27 at 00:40 +0800, John Garry wrote:

> The low-pin-count(LPC) interface of Hip06/Hip07 accesses the
> peripherals in
> I/O port addresses. This patch implements the LPC host controller
> driver
> which perform the I/O operations on the underlying hardware.
> We don't want to touch those existing peripherals' driver, such as
> ipmi-bt.
> So this driver applies the indirect-IO introduced in the previous
> patch
> after registering an indirect-IO node to the indirect-IO devices list
> which
> will be searched in the I/O accessors to retrieve the host-local I/O
> port.
> 
> The driver config is set as a bool instead of a trisate. The reason
> here is that, by the very nature of the driver providing a logical
> PIO range, it does not make sense to have this driver as a loadable
> module. Another more specific reason is that the Huawei D03 board
> which includes hip06 SoC requires the LPC bus for UART console, so
> should be built in.

Few minor comments below.

> +static inline int wait_lpc_idle(unsigned char *mbase,
> +				unsigned int waitcnt) {
> +	do {
> +		u32 status;
> +
> +		status = readl(mbase + LPC_REG_OP_STATUS);
> +		if (status & LPC_REG_OP_STATUS_IDLE)
> +			return (status & LPC_REG_OP_STATUS_FINISHED)
> ? 0 : -EIO;
> +		ndelay(LPC_NSEC_PERWAIT);

> +	} while (waitcnt--);

} while (--waitcnt);

> +
> +	return -ETIME;
> +}

> +
> +/*

If you would like to have a documentation you need to use proper syntax,
i.e.

/**

Check the rest of the series for it.

> + * hisi_lpc_target_in - trigger a series of LPC cycles for read
> operation
> + * @lpcdev: pointer to hisi lpc device
> + * @para: some parameters used to control the lpc I/O operations
> + * @addr: the lpc I/O target port address
> + * @buf: where the read back data is stored
> + * @opcnt: how many I/O operations required, i.e. data width
> + *
> + * Returns 0 on success, non-zero on fail.
> + */

> +	do {
> +		*buf++ = readb(lpcdev->membase + LPC_REG_RDATA);
> +	} while (--opcnt);

readsb() ?

> +	do {
> +		writeb(*buf++, lpcdev->membase + LPC_REG_WDATA);
> +	} while (--opcnt);

writesb() ?

> +static inline unsigned long
> +hisi_lpc_pio_to_addr(struct hisi_lpc_dev *lpcdev, unsigned long pio)
> +{
> +	return pio - lpcdev->io_host->io_start +
> +		lpcdev->io_host->hw_start;

I would rather put on one line.

> +}

> +	do {
> +		if (hisi_lpc_target_out(lpcdev, &iopara, addr, buf,
> +						dwidth))

Fancy indentation. Perhaps put to one line?

> +			break;
> +		buf += dwidth;
> +	} while (--count);


> +	int ret;
> +
> +	lpcdev = devm_kzalloc(dev, sizeof(struct hisi_lpc_dev),
> GFP_KERNEL);

sizeof(*lpcdev) ?

> +	if (!lpcdev)
> +		return -ENOMEM;

> +	dev_info(dev, "registered range[%pa - sz:%pa]\n",

This is rather non-standard. We provide for resources the pattern like
"... [start-end]\n"

> +		 &lpcdev->io_host->io_start,
> +		 &lpcdev->io_host->size);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
