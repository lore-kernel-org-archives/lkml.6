Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x227hh8wCo+E02ndr5K6Vj5ylJUSZ/WBZJApjdy2SFClpJo6e4rhLhcK+cgdTHOJ9mzENgFX1
ARC-Seal: i=1; a=rsa-sha256; t=1519245088; cv=none;
        d=google.com; s=arc-20160816;
        b=zT+3dzNEfm+UeaYnlkA7NglEjBnVzdMBwYgMHKCxtkIprCryMxv7kXGcnOGhdJVnuu
         6G9ySn8ukDB5W7veR8IHN0shGimgSWoIubK+ZtVTjIBQj9v0BRGBL5QVGH2Y6bFxv2ox
         eJspGIHsmQhB8PBwnFXuwW7cl/TUuiAuGh5HVviG2LkTR5A86f+J41KPTtkv+r1UWs89
         NI3ZeHGSzcdARBw08wzsAMniWhose4MoSXKEr8CoDKtw+JotmBA4UFf5ChhS0DldOMhK
         CLSsetwnJzxmy0lkmJne8UKqdo4XJ0KO1F6Ty7frfU/4CW7FMstPlC83wJQKew2AyyDD
         zzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=zIbiwq05DQdd7K/pYJrKpnNwn4k1GtdRD4AZL4YsgLs=;
        b=KGz6i5nAk9TTGQN/k7EIVH5hbTFguwBToqOJROOwS22rQnDdpNjGc/vIGA/I4BEvvd
         Ja62zQvm43ZQl1D6/OPW41I7i+M0xwn4dVN/JPvx54JuYSnqFiUAxLoOUQQZuDOpsmgp
         TU5hQOgrSeKLt3NVg7O6Pa70CL5nRnof3WtduIYgGFgXGyUhfk0gs8qYV3SwB/TrzgHj
         6btDahKizAL74YulGj3mV1IPr7ZmZgzHbaqt5e2T7CfTnS0jf54E8nzRBkMCswF1lYko
         5jGVkQZ6Ql8Mdtie0uaaMgMhXTFOywlKtJ6G3Zwz/fAsG4L8ZvU5K1H42Dz3UQSirwJ0
         rYIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,375,1515484800";
   d="scan'208";a="205995063"
Subject: Re: [PATCH v2 1/8] [PATCH 1/8] drivers/peci: Add support for PECI bus
 driver core
To: Andrew Lunn <andrew@lunn.ch>
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
 gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
 benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
 <20180221170434.GF29204@lunn.ch>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <650488e8-8516-1329-b35b-88d628d21cc2@linux.intel.com>
Date: Wed, 21 Feb 2018 12:31:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180221170434.GF29204@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027882449244386?=
X-GMAIL-MSGID: =?utf-8?q?1593043937981983589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andrew,

Thanks for sharing your time to review it. Please check my answers inline.

On 2/21/2018 9:04 AM, Andrew Lunn wrote:
>> +static int peci_locked_xfer(struct peci_adapter *adapter,
>> +			    struct peci_xfer_msg *msg,
>> +			    bool do_retry,
>> +			    bool has_aw_fcs)
>> +{
>> +	ktime_t start, end;
>> +	s64 elapsed_ms;
>> +	int rc = 0;
>> +
>> +	if (!adapter->xfer) {
>> +		dev_dbg(&adapter->dev, "PECI level transfers not supported\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (in_atomic() || irqs_disabled()) {
> 
> Hi Jae
> 
> Is there a real need to do transfers in atomic context, or with
> interrupts disabled?
> 

Actually, no. Generally, this function will be called in sleep-able 
context so this code is for an exceptional case handling.

I'll rewrite this code like below:
	if (in_atomic() || irqs_disabled()) {
		dev_dbg(&adapter->dev,
			"xfer in non-sleepable context is not supported\n");
		return -EWOULDBLOCK;
	}

And then, will add a sleep call into the below loop.

I know that in_atomic() call is not recommended in driver code but some 
driver codes still use it since there is no alternative way at this 
time, AFAIK. Please tell me if there is a better solution.

>> +		rt_mutex_trylock(&adapter->bus_lock);
>> +		if (!rc)
>> +			return -EAGAIN; /* PECI activity is ongoing */
>> +	} else {
>> +		rt_mutex_lock(&adapter->bus_lock);
>> +	}
>> +
>> +	if (do_retry)
>> +		start = ktime_get();
>> +
>> +	do {
>> +		rc = adapter->xfer(adapter, msg);
>> +
>> +		if (!do_retry)
>> +			break;
>> +
>> +		/* Per the PECI spec, need to retry commands that return 0x8x */
>> +		if (!(!rc && ((msg->rx_buf[0] & DEV_PECI_CC_RETRY_ERR_MASK) ==
>> +			      DEV_PECI_CC_TIMEOUT)))
>> +			break;
>> +
>> +		/* Set the retry bit to indicate a retry attempt */
>> +		msg->tx_buf[1] |= DEV_PECI_RETRY_BIT;
>> +
>> +		/* Recalculate the AW FCS if it has one */
>> +		if (has_aw_fcs)
>> +			msg->tx_buf[msg->tx_len - 1] = 0x80 ^
>> +						peci_aw_fcs((u8 *)msg,
>> +							    2 + msg->tx_len);
>> +
>> +		/* Retry for at least 250ms before returning an error */
>> +		end = ktime_get();
>> +		elapsed_ms = ktime_to_ms(ktime_sub(end, start));
>> +		if (elapsed_ms >= DEV_PECI_RETRY_TIME_MS) {
>> +			dev_dbg(&adapter->dev, "Timeout retrying xfer!\n");
>> +			break;
>> +		}
>> +	} while (true);
> 
> So you busy loop to 1/4 second? How about putting a sleep in here so
> other things can be done between each retry.
> 
> And should it not return -ETIMEDOUT after that 1/4 second?
> 

Yes, you are right. I'll rewrite this code like below after adding the 
above change:

		/**
		 * Retry for at least 250ms before returning an error.
		 * Retry interval guideline:
		 *   No minimum < Retry Interval < No maximum
		 *                (recommend 10ms)
		 */
		end = ktime_get();
		elapsed_ms = ktime_to_ms(ktime_sub(end, start));
		if (elapsed_ms >= DEV_PECI_RETRY_TIME_MS) {
			dev_dbg(&adapter->dev, "Timeout retrying xfer!\n");
			rc = -ETIMEDOUT;
			break;
		}

		usleep_range(DEV_PECI_RETRY_INTERVAL_MS * 1000,
			     (DEV_PECI_RETRY_INTERVAL_MS * 1000) + 1000);

>> +static int peci_scan_cmd_mask(struct peci_adapter *adapter)
>> +{
>> +	struct peci_xfer_msg msg;
>> +	u32 dib;
>> +	int rc = 0;
>> +
>> +	/* Update command mask just once */
>> +	if (adapter->cmd_mask & BIT(PECI_CMD_PING))
>> +		return 0;
>> +
>> +	msg.addr      = PECI_BASE_ADDR;
>> +	msg.tx_len    = GET_DIB_WR_LEN;
>> +	msg.rx_len    = GET_DIB_RD_LEN;
>> +	msg.tx_buf[0] = GET_DIB_PECI_CMD;
>> +
>> +	rc = peci_xfer(adapter, &msg);
>> +	if (rc < 0) {
>> +		dev_dbg(&adapter->dev, "PECI xfer error, rc : %d\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	dib = msg.rx_buf[0] | (msg.rx_buf[1] << 8) |
>> +	      (msg.rx_buf[2] << 16) | (msg.rx_buf[3] << 24);
>> +
>> +	/* Check special case for Get DIB command */
>> +	if (dib == 0x00) {
>> +		dev_dbg(&adapter->dev, "DIB read as 0x00\n");
>> +		return -1;
>> +	}
>> +
>> +	if (!rc) {
>> +		/**
>> +		 * setting up the supporting commands based on minor rev#
>> +		 * see PECI Spec Table 3-1
>> +		 */
>> +		dib = (dib >> 8) & 0xF;
>> +
>> +		if (dib >= 0x1) {
>> +			adapter->cmd_mask |= BIT(PECI_CMD_RD_PKG_CFG);
>> +			adapter->cmd_mask |= BIT(PECI_CMD_WR_PKG_CFG);
>> +		}
>> +
>> +		if (dib >= 0x2)
>> +			adapter->cmd_mask |= BIT(PECI_CMD_RD_IA_MSR);
>> +
>> +		if (dib >= 0x3) {
>> +			adapter->cmd_mask |= BIT(PECI_CMD_RD_PCI_CFG_LOCAL);
>> +			adapter->cmd_mask |= BIT(PECI_CMD_WR_PCI_CFG_LOCAL);
>> +		}
>> +
>> +		if (dib >= 0x4)
>> +			adapter->cmd_mask |= BIT(PECI_CMD_RD_PCI_CFG);
>> +
>> +		if (dib >= 0x5)
>> +			adapter->cmd_mask |= BIT(PECI_CMD_WR_PCI_CFG);
>> +
>> +		if (dib >= 0x6)
>> +			adapter->cmd_mask |= BIT(PECI_CMD_WR_IA_MSR);
> 
> Lots of magic numbers here. Can they be replaced with #defines.  Also,
> it looks like a switch statement could be used, with fall through.
> 

I agree. Will rewrite it.

>> +
>> +		adapter->cmd_mask |= BIT(PECI_CMD_GET_TEMP);
>> +		adapter->cmd_mask |= BIT(PECI_CMD_GET_DIB);
>> +		adapter->cmd_mask |= BIT(PECI_CMD_PING);
>> +	} else {
>> +		dev_dbg(&adapter->dev, "Error reading DIB, rc : %d\n", rc);
>> +	}
>> +
>> +	return rc;
>> +}
>> +
> 
>> +static int peci_ioctl_get_temp(struct peci_adapter *adapter, void *vmsg)
>> +{
>> +	struct peci_get_temp_msg *umsg = vmsg;
>> +	struct peci_xfer_msg msg;
>> +	int rc;
>> +
> 
> Is this getting the temperature?
> 

Yes, this is getting the 'die' temperature of a processor package.

>> +	rc = peci_cmd_support(adapter, PECI_CMD_GET_TEMP);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	msg.addr      = umsg->addr;
>> +	msg.tx_len    = GET_TEMP_WR_LEN;
>> +	msg.rx_len    = GET_TEMP_RD_LEN;
>> +	msg.tx_buf[0] = GET_TEMP_PECI_CMD;
>> +
>> +	rc = peci_xfer(adapter, &msg);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	umsg->temp_raw = msg.rx_buf[0] | (msg.rx_buf[1] << 8);
>> +
>> +	return 0;
>> +}
> 
> 
> 
>> +static long peci_ioctl(struct file *file, unsigned int iocmd, unsigned long arg)
>> +{
>> +	struct peci_adapter *adapter = file->private_data;
>> +	void __user *argp = (void __user *)arg;
>> +	unsigned int msg_len;
>> +	enum peci_cmd cmd;
>> +	u8 *msg;
>> +	int rc = 0;
>> +
>> +	dev_dbg(&adapter->dev, "ioctl, cmd=0x%x, arg=0x%lx\n", iocmd, arg);
>> +
>> +	switch (iocmd) {
>> +	case PECI_IOC_PING:
>> +	case PECI_IOC_GET_DIB:
>> +	case PECI_IOC_GET_TEMP:
>> +	case PECI_IOC_RD_PKG_CFG:
>> +	case PECI_IOC_WR_PKG_CFG:
>> +	case PECI_IOC_RD_IA_MSR:
>> +	case PECI_IOC_RD_PCI_CFG:
>> +	case PECI_IOC_RD_PCI_CFG_LOCAL:
>> +	case PECI_IOC_WR_PCI_CFG_LOCAL:
>> +		cmd = _IOC_TYPE(iocmd) - PECI_IOC_BASE;
>> +		msg_len = _IOC_SIZE(iocmd);
>> +		break;
> 
> Adding new ioctl calls is pretty frowned up. Can you export this info
> via /sysfs?
> 

Most of these are not simple IOs so ioctl is better suited, I think.

> Also, should there be some permission checks here? Or is any user
> allowed to call these ioctls?
> 

I agree. I will add some permission checks here.

> 	Andrew
> 

Thanks a lot,
Jae
