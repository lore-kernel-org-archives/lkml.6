Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AG47ELtVpMdcs6IYbbEYrws68QfgPu1TNicr2kJ6WeXB0B5aiOvk77C3KuQYZn6+vdhfNUXGpm3d
ARC-Seal: i=1; a=rsa-sha256; t=1520449407; cv=none;
        d=google.com; s=arc-20160816;
        b=JHRIvYk0pwn+uunWXtom2uI8cT1lMZtIoV03CfY0q7VProU7ocVSakomo4vj7dTXMo
         L0z4+IA6vfvl6gjsyQGwAmL0gq8f0gl6bInt4Dqdd4MQe6l0MIzBRUcJQ++XLL5fze0Z
         mKFWws2Sv2iTuNS5GDDpRVKfxH9MdhnINMs1WcU/ARh1oNYP1hHVPuvi46DGYuR6vP7K
         E6pkQi5mYQkbwqMy9xso9V0ubRjlxnFgR0tsAQXP0buVIPTeMRIr4ohwr8xm98qpgvC9
         FvVf0P+NgMiYFJbEI1iLIiyTwZ98CEv4ruU0BNs9f3ivJFnH2GzaYPH06y0yigSMiHQS
         xPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from
         :arc-authentication-results;
        bh=VEXf/7f26qfJH4PWzGMfR3InJl+3XBxILUaxtJPa0cw=;
        b=egvk58p1qt2HmdXsXn2M2Kf0jSfGyvjZA0c0GuDyRRfTbAevIygbPlhcCo7c0DFNDx
         6RB/f4KBCip5rgCfC21pn8eL3S3U3IloXiT7X+Knsv0ByMHNtRS83tBJF5TZ6dRBurnO
         6TeeS6jnwz41jwKlbnpIpExmGxFEOqNBHzhYQZTProswLSnIB4h+sw6d4O3ZcLiVt5pS
         GAX1+w4bADxNRTos4AoWPefluOcJ/QmmzF5mxxMRKVOBDwdUZCVwMdkGWkJfLCYmBAK7
         IzWRDYxdMURfKoOlhKN7EkmFT7l7BzTrArJkRYoi8GUJGpLI2SOjgWynxN5WfWyiyIFZ
         sNoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="26058637"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH v2 1/8] [PATCH 1/8] drivers/peci: Add support for PECI bus
 driver core
To: Julia Cartwright <juliac@eso.teric.us>
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
 gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
 benh@kernel.crashing.org, andrew@lunn.ch, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
 <20180307031907.GD1924@kryptos.localdomain>
Message-ID: <1bd83849-50f4-d857-d346-d5a5bd0ca569@linux.intel.com>
Date: Wed, 7 Mar 2018 11:03:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307031907.GD1924@kryptos.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027882449244386?=
X-GMAIL-MSGID: =?utf-8?q?1594306757455443959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Julia,

Thanks for sharing your time on reviewing it. Please see my inline answers.

Jae

On 3/6/2018 7:19 PM, Julia Cartwright wrote:
> On Wed, Feb 21, 2018 at 08:15:59AM -0800, Jae Hyun Yoo wrote:
>> This commit adds driver implementation for PECI bus into linux
>> driver framework.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
> [..]
>> +static int peci_locked_xfer(struct peci_adapter *adapter,
>> +			    struct peci_xfer_msg *msg,
>> +			    bool do_retry,
>> +			    bool has_aw_fcs)
> 
> _locked generally means that this function is invoked with some critical
> lock held, what lock does the caller need to acquire before invoking
> this function?
> 

I intended to show that this function has a mutex locking inside for 
serialization of PECI data transactions from multiple callers, but as 
you commented out below, the mutex protection scope should be adjusted 
to make that covers the peci_scan_cmd_mask() function too. I'll rewrite 
the mutex protection scope then this function will be in the locked scope.

>> +{
>> +	ktime_t start, end;
>> +	s64 elapsed_ms;
>> +	int rc = 0;
>> +
>> +	if (!adapter->xfer) {
> 
> Is this really an optional feature of an adapter?  If this is not
> optional, then this check should be in place when the adapter is
> registered, not here.  (And it should WARN_ON(), because it's a driver
> developer error).
> 

I agree with you. I'll move this code into the peci_register_adapter() 
function.

>> +		dev_dbg(&adapter->dev, "PECI level transfers not supported\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (in_atomic() || irqs_disabled()) {
> 
> As Andrew mentioned, this is broken.
> 
> You don't even need a might_sleep().  The locking functions you use here
> will already include a might_sleep() w/ CONFIG_DEBUG_ATOMIC_SLEEP.
> 

Thanks for letting me know that. I'll drop that checking code and 
might_sleep() too.

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
> 
> This is pretty difficult to parse.  Can you split it into two different
> conditions?
> 

Sure. I'll split it out.

>> +
>> +		/* Set the retry bit to indicate a retry attempt */
>> +		msg->tx_buf[1] |= DEV_PECI_RETRY_BIT;
> 
> Are you sure this bit is to be set in the _second_ byte of tx_buf?
> 

Yes, I'm pretty sure. The first byte contains a PECI command value and 
the second byte contains 'HostID[7:1] & Retry[0]' value.

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
>> +
>> +	rt_mutex_unlock(&adapter->bus_lock);
>> +
>> +	return rc;
>> +}
>> +
>> +static int peci_xfer(struct peci_adapter *adapter, struct peci_xfer_msg *msg)
>> +{
>> +	return peci_locked_xfer(adapter, msg, false, false);
>> +}
>> +
>> +static int peci_xfer_with_retries(struct peci_adapter *adapter,
>> +				  struct peci_xfer_msg *msg,
>> +				  bool has_aw_fcs)
>> +{
>> +	return peci_locked_xfer(adapter, msg, true, has_aw_fcs);
>> +}
>> +
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
> 
> You should change this to:
> 
> 	if (rc) {
> 		dev_dbg(&adapter->dev, "Error reading DIB, rc : %d\n", rc);
> 		return rc;
> 	}
> 
> And then leave the happy path below unindented.
> 

Agreed. That would be neater. Will rewrite it. Thanks!

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
>> +
>> +		adapter->cmd_mask |= BIT(PECI_CMD_GET_TEMP);
>> +		adapter->cmd_mask |= BIT(PECI_CMD_GET_DIB);
>> +		adapter->cmd_mask |= BIT(PECI_CMD_PING);
> 
> These cmd_mask updates are not done with any locking in mind.  Is this
> intentional?  Or: is synchronization not necessary because this is
> always done during enumeration prior to exposing the adapter to users?
> 

Thanks for the pointing it out. This function should be done in a locked 
scope as you said. I'll adjust mutex protection scope to make that 
covers this function as well.

>> +	} else {
>> +		dev_dbg(&adapter->dev, "Error reading DIB, rc : %d\n", rc);
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>> +static int peci_cmd_support(struct peci_adapter *adapter, enum peci_cmd cmd)
>> +{
>> +	if (!(adapter->cmd_mask & BIT(PECI_CMD_PING)) &&
>> +	    peci_scan_cmd_mask(adapter) < 0) {
>> +		dev_dbg(&adapter->dev, "Failed to scan command mask\n");
>> +		return -EIO;
>> +	}
>> +
>> +	if (!(adapter->cmd_mask & BIT(cmd))) {
>> +		dev_dbg(&adapter->dev, "Command %d is not supported\n", cmd);
>> +		return -EINVAL;
>> +	}
> 
> It would be nicer if you did this check prior to dispatching to the
> various subfunctions (peci_ioctl_ping, peci_ioctl_get_dib, etc.).  In
> that way, these functions could just assume the adapter supports them.
> 

Agreed. I'll drop all individual calls from subfunctions and will call 
it from peci_command().

> [..]
>> +static int peci_register_adapter(struct peci_adapter *adapter)
>> +{
>> +	int res = -EINVAL;
>> +
>> +	/* Can't register until after driver model init */
>> +	if (WARN_ON(!is_registered)) {
> 
> Is this solving a problem you actually ran into?
> 

Generally, an adapter driver registration will be happened after the 
PECI bus registration because peci_init uses postcore_initcall, but in 
case of incorrect implementation of an adapter driver which uses
a preceding postcore_initcall or a core_initcall as its module init, 
then an adapter registration would be prior to bus registration. This 
code is an exceptional case handling for that to warn the incorrect 
adapter driver implementation.

> [.. skipped review due to fatigue ..]
> 
>> +++ b/include/linux/peci.h
>> @@ -0,0 +1,97 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018 Intel Corporation
>> +
>> +#ifndef __LINUX_PECI_H
>> +#define __LINUX_PECI_H
>> +
>> +#include <linux/cdev.h>
>> +#include <linux/device.h>
>> +#include <linux/peci-ioctl.h>
>> +#include <linux/rtmutex.h>
>> +
>> +#define PECI_BUFFER_SIZE  32
>> +#define PECI_NAME_SIZE    32
>> +
>> +struct peci_xfer_msg {
>> +	u8	addr;
>> +	u8	tx_len;
>> +	u8	rx_len;
>> +	u8	tx_buf[PECI_BUFFER_SIZE];
>> +	u8	rx_buf[PECI_BUFFER_SIZE];
>> +} __attribute__((__packed__));
> 
> The packed attribute has historically caused gcc to emit atrocious code,
> as it seems to assume packed implies members might not be naturally
> aligned.  Seeing as you're only working with u8s in this case, though,
> this shouldn't be a problem.
> 

It should be a packed struct because it is also being used for CRC8 
calculation which is treating it as a contiguous byte array.

>> +struct peci_board_info {
>> +	char			type[PECI_NAME_SIZE];
>> +	u8			addr;	/* CPU client address */
>> +	struct device_node	*of_node;
>> +};
>> +
>> +struct peci_adapter {
>> +	struct module	*owner;
>> +	struct rt_mutex	bus_lock;
> 
> Why an rt_mutex, instead of a regular mutex.  Do you explicitly need PI
> in mainline?
> 

Currently this implementation has only a temperature monitoring sideband 
feature but other sideband features such as CPU error detection and 
crash dump will be implemented later, and those additional sideband 
features should have higher priority than the temperature monitoring 
feature so it is the reason why I used an rt_mutex.

>> +	struct device	dev;
>> +	struct cdev	cdev;
>> +	int		nr;
>> +	char		name[PECI_NAME_SIZE];
>> +	int		(*xfer)(struct peci_adapter *adapter,
>> +				struct peci_xfer_msg *msg);
>> +	uint		cmd_mask;
>> +};
>> +
>> +#define to_peci_adapter(d) container_of(d, struct peci_adapter, dev)
> 
> You can also do this with a static inline, which provides a marginally
> better error when screwed up.
> 

Agreed. That would be more helpful for debugging in debug build. I'll 
rewrite the macro to a static inline like below:

static inline struct peci_adapter *to_peci_adapter(void *d)
{
	return container_of(d, struct peci_adapter, dev);
}

>     Julia
> 
