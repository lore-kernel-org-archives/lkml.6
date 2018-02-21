Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AH8x225+60xdPbDQajRaEbMB8hk54FuzAsm9cThahMVX1rN6B2SNY/w5iBwxHr/5KbKiljvvNv14
ARC-Seal: i=1; a=rsa-sha256; t=1519232687; cv=none;
        d=google.com; s=arc-20160816;
        b=f06y4Kew+RVtonWfQSZdWJnQnEufTL6BXeH/+7c+tzFojakiyAnpCiKhDZVJ2fU9hJ
         RW3TuBcO9uRgIFcp6jSoWA/+LLK+PNTqGnznT0/V1RVRwmr9wkSAmNEgEqWiw99D47RK
         wfsgr5+/rsLMm3B7f6VHmbaeFj4APSQ0NdRZVdLDmEWy9MZqUIOQr7E88qkZTogMS56f
         r64HOiIZDWSX8lMHUEuWuVCpcAi+G8jFYyiwJ3iPpSKTpgtmux634K0OiVvEAWDEZZry
         uLfLd6m3vawQVvgPU5rVAQoaU0u2q88E3lyQZzCa1FdYfWqM1Qd+uLcQ/F9xMWJqnCWx
         wiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=hqQ5PQnhxvfCctWMhVtfVudqlwUjMQuaCo2Y4WT3I2M=;
        b=YpSeRLt4KvapSoeOUe/xt0n9nY0uffNv3My3WOQT2enL4OdtblHhL3J9xR51Bu5EuT
         IgXmOQOrxgy0TyxL0EQyDb5d3hvfexXUo8m0oNMXd+3bJnQOpxpZEFb8F+9A5TFxawP7
         sP3aq6AybciMDZNXVlJWX4SRsQ0yMgO6/3w6BO36tu37apiDsZdAlUFHP/+K0Fjn7H4Y
         A2SwgDhLvzxpT8YPO6SQR+nlvSQAiVG1Qa/EJyiXgX7VHO2P8KvjYniKn8glg94TtOXH
         P1fSV2urrcIPDzdgTDWQ0eo9VLNBNkt60jrpIMR1Nrik1MXcAPKpe+ZiYecUmgzQeXQ7
         zriQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=iehK6BXQ;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=iehK6BXQ;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Wed, 21 Feb 2018 18:04:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
	gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
	benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 1/8] [PATCH 1/8] drivers/peci: Add support for PECI
 bus driver core
Message-ID: <20180221170434.GF29204@lunn.ch>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027882449244386?=
X-GMAIL-MSGID: =?utf-8?q?1593030934597592781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> +static int peci_locked_xfer(struct peci_adapter *adapter,
> +			    struct peci_xfer_msg *msg,
> +			    bool do_retry,
> +			    bool has_aw_fcs)
> +{
> +	ktime_t start, end;
> +	s64 elapsed_ms;
> +	int rc = 0;
> +
> +	if (!adapter->xfer) {
> +		dev_dbg(&adapter->dev, "PECI level transfers not supported\n");
> +		return -ENODEV;
> +	}
> +
> +	if (in_atomic() || irqs_disabled()) {

Hi Jae

Is there a real need to do transfers in atomic context, or with
interrupts disabled? 

> +		rt_mutex_trylock(&adapter->bus_lock);
> +		if (!rc)
> +			return -EAGAIN; /* PECI activity is ongoing */
> +	} else {
> +		rt_mutex_lock(&adapter->bus_lock);
> +	}
> +
> +	if (do_retry)
> +		start = ktime_get();
> +
> +	do {
> +		rc = adapter->xfer(adapter, msg);
> +
> +		if (!do_retry)
> +			break;
> +
> +		/* Per the PECI spec, need to retry commands that return 0x8x */
> +		if (!(!rc && ((msg->rx_buf[0] & DEV_PECI_CC_RETRY_ERR_MASK) ==
> +			      DEV_PECI_CC_TIMEOUT)))
> +			break;
> +
> +		/* Set the retry bit to indicate a retry attempt */
> +		msg->tx_buf[1] |= DEV_PECI_RETRY_BIT;
> +
> +		/* Recalculate the AW FCS if it has one */
> +		if (has_aw_fcs)
> +			msg->tx_buf[msg->tx_len - 1] = 0x80 ^
> +						peci_aw_fcs((u8 *)msg,
> +							    2 + msg->tx_len);
> +
> +		/* Retry for at least 250ms before returning an error */
> +		end = ktime_get();
> +		elapsed_ms = ktime_to_ms(ktime_sub(end, start));
> +		if (elapsed_ms >= DEV_PECI_RETRY_TIME_MS) {
> +			dev_dbg(&adapter->dev, "Timeout retrying xfer!\n");
> +			break;
> +		}
> +	} while (true);

So you busy loop to 1/4 second? How about putting a sleep in here so
other things can be done between each retry.

And should it not return -ETIMEDOUT after that 1/4 second?

> +static int peci_scan_cmd_mask(struct peci_adapter *adapter)
> +{
> +	struct peci_xfer_msg msg;
> +	u32 dib;
> +	int rc = 0;
> +
> +	/* Update command mask just once */
> +	if (adapter->cmd_mask & BIT(PECI_CMD_PING))
> +		return 0;
> +
> +	msg.addr      = PECI_BASE_ADDR;
> +	msg.tx_len    = GET_DIB_WR_LEN;
> +	msg.rx_len    = GET_DIB_RD_LEN;
> +	msg.tx_buf[0] = GET_DIB_PECI_CMD;
> +
> +	rc = peci_xfer(adapter, &msg);
> +	if (rc < 0) {
> +		dev_dbg(&adapter->dev, "PECI xfer error, rc : %d\n", rc);
> +		return rc;
> +	}
> +
> +	dib = msg.rx_buf[0] | (msg.rx_buf[1] << 8) |
> +	      (msg.rx_buf[2] << 16) | (msg.rx_buf[3] << 24);
> +
> +	/* Check special case for Get DIB command */
> +	if (dib == 0x00) {
> +		dev_dbg(&adapter->dev, "DIB read as 0x00\n");
> +		return -1;
> +	}
> +
> +	if (!rc) {
> +		/**
> +		 * setting up the supporting commands based on minor rev#
> +		 * see PECI Spec Table 3-1
> +		 */
> +		dib = (dib >> 8) & 0xF;
> +
> +		if (dib >= 0x1) {
> +			adapter->cmd_mask |= BIT(PECI_CMD_RD_PKG_CFG);
> +			adapter->cmd_mask |= BIT(PECI_CMD_WR_PKG_CFG);
> +		}
> +
> +		if (dib >= 0x2)
> +			adapter->cmd_mask |= BIT(PECI_CMD_RD_IA_MSR);
> +
> +		if (dib >= 0x3) {
> +			adapter->cmd_mask |= BIT(PECI_CMD_RD_PCI_CFG_LOCAL);
> +			adapter->cmd_mask |= BIT(PECI_CMD_WR_PCI_CFG_LOCAL);
> +		}
> +
> +		if (dib >= 0x4)
> +			adapter->cmd_mask |= BIT(PECI_CMD_RD_PCI_CFG);
> +
> +		if (dib >= 0x5)
> +			adapter->cmd_mask |= BIT(PECI_CMD_WR_PCI_CFG);
> +
> +		if (dib >= 0x6)
> +			adapter->cmd_mask |= BIT(PECI_CMD_WR_IA_MSR);

Lots of magic numbers here. Can they be replaced with #defines.  Also,
it looks like a switch statement could be used, with fall through.

> +
> +		adapter->cmd_mask |= BIT(PECI_CMD_GET_TEMP);
> +		adapter->cmd_mask |= BIT(PECI_CMD_GET_DIB);
> +		adapter->cmd_mask |= BIT(PECI_CMD_PING);
> +	} else {
> +		dev_dbg(&adapter->dev, "Error reading DIB, rc : %d\n", rc);
> +	}
> +
> +	return rc;
> +}
> +

> +static int peci_ioctl_get_temp(struct peci_adapter *adapter, void *vmsg)
> +{
> +	struct peci_get_temp_msg *umsg = vmsg;
> +	struct peci_xfer_msg msg;
> +	int rc;
> +

Is this getting the temperature?

> +	rc = peci_cmd_support(adapter, PECI_CMD_GET_TEMP);
> +	if (rc < 0)
> +		return rc;
> +
> +	msg.addr      = umsg->addr;
> +	msg.tx_len    = GET_TEMP_WR_LEN;
> +	msg.rx_len    = GET_TEMP_RD_LEN;
> +	msg.tx_buf[0] = GET_TEMP_PECI_CMD;
> +
> +	rc = peci_xfer(adapter, &msg);
> +	if (rc < 0)
> +		return rc;
> +
> +	umsg->temp_raw = msg.rx_buf[0] | (msg.rx_buf[1] << 8);
> +
> +	return 0;
> +}



> +static long peci_ioctl(struct file *file, unsigned int iocmd, unsigned long arg)
> +{
> +	struct peci_adapter *adapter = file->private_data;
> +	void __user *argp = (void __user *)arg;
> +	unsigned int msg_len;
> +	enum peci_cmd cmd;
> +	u8 *msg;
> +	int rc = 0;
> +
> +	dev_dbg(&adapter->dev, "ioctl, cmd=0x%x, arg=0x%lx\n", iocmd, arg);
> +
> +	switch (iocmd) {
> +	case PECI_IOC_PING:
> +	case PECI_IOC_GET_DIB:
> +	case PECI_IOC_GET_TEMP:
> +	case PECI_IOC_RD_PKG_CFG:
> +	case PECI_IOC_WR_PKG_CFG:
> +	case PECI_IOC_RD_IA_MSR:
> +	case PECI_IOC_RD_PCI_CFG:
> +	case PECI_IOC_RD_PCI_CFG_LOCAL:
> +	case PECI_IOC_WR_PCI_CFG_LOCAL:
> +		cmd = _IOC_TYPE(iocmd) - PECI_IOC_BASE;
> +		msg_len = _IOC_SIZE(iocmd);
> +		break;

Adding new ioctl calls is pretty frowned up. Can you export this info
via /sysfs?

Also, should there be some permission checks here? Or is any user
allowed to call these ioctls?

	Andrew
