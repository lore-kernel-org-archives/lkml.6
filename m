Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x226qggi12zuWHaiPU2N2GOZ9LbIXM4MRnhHMXKH+TTkPgLwh3P0F7z8PWhKSaW+qWwDvjWRq
ARC-Seal: i=1; a=rsa-sha256; t=1519250624; cv=none;
        d=google.com; s=arc-20160816;
        b=zHuAhwVt5rnVMoAq5i3tXrQ78HfQI2b11yxQV1ihN2jwF8uQvU3wgzsyfsHk3RjSFR
         yOvyOkHvKyrWJxKIMzJM1ATVX3sjQ6sD10B1jqZshi3x6QfYRJbMxJMivdW951nil4ql
         xjIXR5WvH0JN0SccGTsQgmQYkDByA3C7cuUZ+sMn2MJdB8Ak0kFSkykknvuqt5meDBR1
         ijotChIV6z2HffCGpd10Cjpob3+ukHSDqthhDTGUACV7kbwizNrJasz29GBzOFzET2Nu
         zVdO6ACR0oJfLVwbaDpDVET+k0FCMc9OrtJ8Ta2/9o84oNCSGOF90aeRCiNJt2/uCSF2
         sDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=OQLF9yMr5Uy4RbQC8CgWDRBFTIEexQzolAq8tHIVvqY=;
        b=KjU4QTklBwkechit2VI8R9xVtNyUVutoqydM5PFghYG0xYeYAdFHDrbdZUNeFv5Kb6
         SN2zzFNGEVFRAvFXi7EjDdhAQ28/HBcDCDVDE1s08/MLMvwHlNdsEFhBvOvfiKQL9JVV
         xARdb1rZ0gBz8c6DtPG+pCNCD3f/S76B5AXTOxaIuHWk2wewB7y7vdz/vsrB2T4w+hc/
         yCjEETrEnTDqj84xzSM2mzFetdPcsoExTsTaepVzwoiooZmckktn7kmrqjChEz3cObuF
         fFh3d/rqwKn+13xVT1hOeIXuYfwEeCv+TN8oCakL5E4JiuL1OSCJtF7MBTOObBtEpIn/
         BtRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,376,1515484800";
   d="scan'208";a="206015903"
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
 <650488e8-8516-1329-b35b-88d628d21cc2@linux.intel.com>
 <20180221215133.GA9056@lunn.ch>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <6c67978c-9283-6c8d-95b4-9900b3b9a810@linux.intel.com>
Date: Wed, 21 Feb 2018 14:03:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180221215133.GA9056@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027882449244386?=
X-GMAIL-MSGID: =?utf-8?q?1593049743246417179?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2/21/2018 1:51 PM, Andrew Lunn wrote:
>>> Is there a real need to do transfers in atomic context, or with
>>> interrupts disabled?
>>>
>>
>> Actually, no. Generally, this function will be called in sleep-able context
>> so this code is for an exceptional case handling.
>>
>> I'll rewrite this code like below:
>> 	if (in_atomic() || irqs_disabled()) {
>> 		dev_dbg(&adapter->dev,
>> 			"xfer in non-sleepable context is not supported\n");
>> 		return -EWOULDBLOCK;
>> 	}
> 
> I would not even do that. Just add a call to
> might_sleep(). CONFIG_DEBUG_ATOMIC_SLEEP will then find bad calls.
> 

Thanks for the suggestion. I've learned one thing. :)

>>>> +static int peci_ioctl_get_temp(struct peci_adapter *adapter, void *vmsg)
>>>> +{
>>>> +	struct peci_get_temp_msg *umsg = vmsg;
>>>> +	struct peci_xfer_msg msg;
>>>> +	int rc;
>>>> +
>>>
>>> Is this getting the temperature?
>>>
>>
>> Yes, this is getting the 'die' temperature of a processor package.
>   
> So the hwmon driver provides this. No need to have both.
> 

This this common API in core driver of PECI bus. The hwmon is also uses 
it through peci_command call.

>>>> +static long peci_ioctl(struct file *file, unsigned int iocmd, unsigned long arg)
>>>> +{
>>>> +	struct peci_adapter *adapter = file->private_data;
>>>> +	void __user *argp = (void __user *)arg;
>>>> +	unsigned int msg_len;
>>>> +	enum peci_cmd cmd;
>>>> +	u8 *msg;
>>>> +	int rc = 0;
>>>> +
>>>> +	dev_dbg(&adapter->dev, "ioctl, cmd=0x%x, arg=0x%lx\n", iocmd, arg);
>>>> +
>>>> +	switch (iocmd) {
>>>> +	case PECI_IOC_PING:
>>>> +	case PECI_IOC_GET_DIB:
>>>> +	case PECI_IOC_GET_TEMP:
>>>> +	case PECI_IOC_RD_PKG_CFG:
>>>> +	case PECI_IOC_WR_PKG_CFG:
>>>> +	case PECI_IOC_RD_IA_MSR:
>>>> +	case PECI_IOC_RD_PCI_CFG:
>>>> +	case PECI_IOC_RD_PCI_CFG_LOCAL:
>>>> +	case PECI_IOC_WR_PCI_CFG_LOCAL:
>>>> +		cmd = _IOC_TYPE(iocmd) - PECI_IOC_BASE;
>>>> +		msg_len = _IOC_SIZE(iocmd);
>>>> +		break;
>>>
>>> Adding new ioctl calls is pretty frowned up. Can you export this info
>>> via /sysfs?
>>>
>>
>> Most of these are not simple IOs so ioctl is better suited, I think.
> 
> Lets see what other reviewers say, but i think ioctls are
> wrong.
> 
>       Andrew
> 
