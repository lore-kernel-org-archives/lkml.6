Return-Path: <juliac@eso.teric.us>
X-Google-Smtp-Source: AG47ELu+/rw6XzioPWPFAJis0SZg3hzZ0yGl/22eqnpjAYKbEdBfvWExVuWCj6RlCbNfCMsR4HAG
ARC-Seal: i=1; a=rsa-sha256; t=1520392748; cv=none;
        d=google.com; s=arc-20160816;
        b=VuNRe0puUG8u03byZY64kQQvk+w7MsuZfaoTwO81VY4hYG+ZVgAMRaAKQryxXqb7rx
         E/+7BiDKu+C37jjvddycO7NkDReE8B6e6VKqH39pfHSamEL8C9a/IFmH2EHMQ2qVuB8x
         1cbKp4d/ZoZu4+a9lnlP+oXAzHEeYLE875mXp63quHYTGwTZajhWPCZVjY790p/+Hcwa
         s+4Gua7qcpVBUW+y3oPfml8uZlrl3w6MZz/Ndwyp9bIsj7CQfW93dP0BhXtBob6RQYhI
         FRW4vS2aMSrU34OO96DQE0/votyohNFTAoYe7YcEth+cjjuSxMUBEVtgeZk/r0n2r+HL
         zZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Z2iaNWMEV/QMHKOXx+FOlMxwzzW8YfyvqHBaPTTZ0kU=;
        b=hT1T4SS8LJZeAHk2piKTN2CQ3a3fj5UdcgxFS31kzXk7gBi0/rLbw1aW2D2hdegv3n
         LpuGRJi4yTidHmlm14qUiavGDf68BIYGuht0A2nZRxVHJ1F8V4ORAKC6E+R6zxBQLM6+
         wrMi7nyFWcKBiU656NeMUhkIPwa+8ORuQtoxCuqSm2k531G0avyJ4uEHjr+8LfVCOLi0
         B+0UBtmIl9fugsT8B/eWQh8BWqv91bDT/Qe7MtmGlBVFNkcpXK63ytuIrMIFqa2NZQM3
         H0RWwioPz11ebDoFI3uvUlDzos+JAS3nY1uXYl8BfGxVda+fPQFDZzH7ccgNbRpmqJH+
         BTQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@eso.teric.us header.s=mail header.b=e/AgaD+a;
       spf=pass (google.com: domain of juliac@eso.teric.us designates 69.164.192.171 as permitted sender) smtp.mailfrom=juliac@eso.teric.us
Authentication-Results: mx.google.com;
       dkim=pass header.i=@eso.teric.us header.s=mail header.b=e/AgaD+a;
       spf=pass (google.com: domain of juliac@eso.teric.us designates 69.164.192.171 as permitted sender) smtp.mailfrom=juliac@eso.teric.us
Date: Tue, 6 Mar 2018 21:19:07 -0600
From: Julia Cartwright <juliac@eso.teric.us>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
	gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
	benh@kernel.crashing.org, andrew@lunn.ch,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 1/8] [PATCH 1/8] drivers/peci: Add support for PECI
 bus driver core
Message-ID: <20180307031907.GD1924@kryptos.localdomain>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027882449244386?=
X-GMAIL-MSGID: =?utf-8?q?1594247346595885580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 08:15:59AM -0800, Jae Hyun Yoo wrote:
> This commit adds driver implementation for PECI bus into linux
> driver framework.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
[..]
> +static int peci_locked_xfer(struct peci_adapter *adapter,
> +			    struct peci_xfer_msg *msg,
> +			    bool do_retry,
> +			    bool has_aw_fcs)

_locked generally means that this function is invoked with some critical
lock held, what lock does the caller need to acquire before invoking
this function?

> +{
> +	ktime_t start, end;
> +	s64 elapsed_ms;
> +	int rc = 0;
> +
> +	if (!adapter->xfer) {

Is this really an optional feature of an adapter?  If this is not
optional, then this check should be in place when the adapter is
registered, not here.  (And it should WARN_ON(), because it's a driver
developer error).

> +		dev_dbg(&adapter->dev, "PECI level transfers not supported\n");
> +		return -ENODEV;
> +	}
> +
> +	if (in_atomic() || irqs_disabled()) {

As Andrew mentioned, this is broken.

You don't even need a might_sleep().  The locking functions you use here
will already include a might_sleep() w/ CONFIG_DEBUG_ATOMIC_SLEEP.

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

This is pretty difficult to parse.  Can you split it into two different
conditions?

> +
> +		/* Set the retry bit to indicate a retry attempt */
> +		msg->tx_buf[1] |= DEV_PECI_RETRY_BIT;

Are you sure this bit is to be set in the _second_ byte of tx_buf?

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
> +
> +	rt_mutex_unlock(&adapter->bus_lock);
> +
> +	return rc;
> +}
> +
> +static int peci_xfer(struct peci_adapter *adapter, struct peci_xfer_msg *msg)
> +{
> +	return peci_locked_xfer(adapter, msg, false, false);
> +}
> +
> +static int peci_xfer_with_retries(struct peci_adapter *adapter,
> +				  struct peci_xfer_msg *msg,
> +				  bool has_aw_fcs)
> +{
> +	return peci_locked_xfer(adapter, msg, true, has_aw_fcs);
> +}
> +
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

You should change this to:

	if (rc) {
		dev_dbg(&adapter->dev, "Error reading DIB, rc : %d\n", rc);
		return rc;
	}

And then leave the happy path below unindented.

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
> +
> +		adapter->cmd_mask |= BIT(PECI_CMD_GET_TEMP);
> +		adapter->cmd_mask |= BIT(PECI_CMD_GET_DIB);
> +		adapter->cmd_mask |= BIT(PECI_CMD_PING);

These cmd_mask updates are not done with any locking in mind.  Is this
intentional?  Or: is synchronization not necessary because this is
always done during enumeration prior to exposing the adapter to users?

> +	} else {
> +		dev_dbg(&adapter->dev, "Error reading DIB, rc : %d\n", rc);
> +	}
> +
> +	return rc;
> +}
> +
> +static int peci_cmd_support(struct peci_adapter *adapter, enum peci_cmd cmd)
> +{
> +	if (!(adapter->cmd_mask & BIT(PECI_CMD_PING)) &&
> +	    peci_scan_cmd_mask(adapter) < 0) {
> +		dev_dbg(&adapter->dev, "Failed to scan command mask\n");
> +		return -EIO;
> +	}
> +
> +	if (!(adapter->cmd_mask & BIT(cmd))) {
> +		dev_dbg(&adapter->dev, "Command %d is not supported\n", cmd);
> +		return -EINVAL;
> +	}

It would be nicer if you did this check prior to dispatching to the
various subfunctions (peci_ioctl_ping, peci_ioctl_get_dib, etc.).  In
that way, these functions could just assume the adapter supports them.

[..]
> +static int peci_register_adapter(struct peci_adapter *adapter)
> +{
> +	int res = -EINVAL;
> +
> +	/* Can't register until after driver model init */
> +	if (WARN_ON(!is_registered)) {

Is this solving a problem you actually ran into?

[.. skipped review due to fatigue ..]

> +++ b/include/linux/peci.h
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Intel Corporation
> +
> +#ifndef __LINUX_PECI_H
> +#define __LINUX_PECI_H
> +
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/peci-ioctl.h>
> +#include <linux/rtmutex.h>
> +
> +#define PECI_BUFFER_SIZE  32
> +#define PECI_NAME_SIZE    32
> +
> +struct peci_xfer_msg {
> +	u8	addr;
> +	u8	tx_len;
> +	u8	rx_len;
> +	u8	tx_buf[PECI_BUFFER_SIZE];
> +	u8	rx_buf[PECI_BUFFER_SIZE];
> +} __attribute__((__packed__));

The packed attribute has historically caused gcc to emit atrocious code,
as it seems to assume packed implies members might not be naturally
aligned.  Seeing as you're only working with u8s in this case, though,
this shouldn't be a problem.

> +struct peci_board_info {
> +	char			type[PECI_NAME_SIZE];
> +	u8			addr;	/* CPU client address */
> +	struct device_node	*of_node;
> +};
> +
> +struct peci_adapter {
> +	struct module	*owner;
> +	struct rt_mutex	bus_lock;

Why an rt_mutex, instead of a regular mutex.  Do you explicitly need PI
in mainline?

> +	struct device	dev;
> +	struct cdev	cdev;
> +	int		nr;
> +	char		name[PECI_NAME_SIZE];
> +	int		(*xfer)(struct peci_adapter *adapter,
> +				struct peci_xfer_msg *msg);
> +	uint		cmd_mask;
> +};
> +
> +#define to_peci_adapter(d) container_of(d, struct peci_adapter, dev)

You can also do this with a static inline, which provides a marginally
better error when screwed up.

   Julia
