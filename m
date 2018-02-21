Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AH8x225VvkAxYKkyNvs3SC39Klztnq0Rvh8HSN4vgqmqtFTNpsJC3hwQbUkNbECFp3+tI9eL5THz
ARC-Seal: i=1; a=rsa-sha256; t=1519249904; cv=none;
        d=google.com; s=arc-20160816;
        b=KipLOUtL0HdnbkwJ6b+SWFMYTyQQ9Aygh/uF6jsTuZgqv4eMm8bx83cumF6CD/2XW7
         EG1NJOLU2GpJgVa54OjXP5Bd24eW+bPmjWYDFp54jo/WG6zG2eksI3WaNgyRF8hzUU1X
         yxPwxNo4cw0tw1DHL1Jadav2s2oXNXOMuuQh0d1Lmwmm+Y9VRH9ia9lnYMwUeUyPTSw/
         AZdX7aayoEN1ysgO6b8QB2GJhwNxd7cy4U9eRc1cGKaLJxb4NyiF3ubBPJP87Uy9bKyh
         3fYIECmu7eOyDamXMy0jbsqqhNXQs+W6BoGrw+x8btlJDHBQ3haQB7bN1tTyFkiTH9Ym
         8jvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=r8TPYTs1rOkRZu+orI+C1rCg5uvWYtr1dh90MUMj8z0=;
        b=mjOAhRTWrgxX5emR514zu25Y+3/8n3TjtIkB0klyf++Yz1yFneg5gpuqSDPtQPke5y
         OPMRJQOBWisOgsHQTrwLCVHKj8p+LiE1iwkj+ctvJLqTlB0aXWUyPLvV9aZt6WST00bM
         4R7qO8/v27JXrus0u54aioNv/7avtmiOYeuja1ZBsKrr1gY3ffzAJxfj4jsNKDcXHXLF
         wixnlYr3IHgGFltYAiux7e9bE7VUhbs41GsUqMa+CFNVin/Egjdc6dijPOMBIQaY9woN
         tzxxsFg7dX1MkkKMJPFEkCxlfJEin5ViCyQNhpsYyxurniDPI1dXn2bUdhfbKVRN2lKY
         KftA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=dmycADH4;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=dmycADH4;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Wed, 21 Feb 2018 22:51:33 +0100
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
Message-ID: <20180221215133.GA9056@lunn.ch>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
 <20180221170434.GF29204@lunn.ch>
 <650488e8-8516-1329-b35b-88d628d21cc2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <650488e8-8516-1329-b35b-88d628d21cc2@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027882449244386?=
X-GMAIL-MSGID: =?utf-8?q?1593048987982720589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> >Is there a real need to do transfers in atomic context, or with
> >interrupts disabled?
> >
> 
> Actually, no. Generally, this function will be called in sleep-able context
> so this code is for an exceptional case handling.
> 
> I'll rewrite this code like below:
> 	if (in_atomic() || irqs_disabled()) {
> 		dev_dbg(&adapter->dev,
> 			"xfer in non-sleepable context is not supported\n");
> 		return -EWOULDBLOCK;
> 	}

I would not even do that. Just add a call to
might_sleep(). CONFIG_DEBUG_ATOMIC_SLEEP will then find bad calls.

> >>+static int peci_ioctl_get_temp(struct peci_adapter *adapter, void *vmsg)
> >>+{
> >>+	struct peci_get_temp_msg *umsg = vmsg;
> >>+	struct peci_xfer_msg msg;
> >>+	int rc;
> >>+
> >
> >Is this getting the temperature?
> >
> 
> Yes, this is getting the 'die' temperature of a processor package.
 
So the hwmon driver provides this. No need to have both.

> >>+static long peci_ioctl(struct file *file, unsigned int iocmd, unsigned long arg)
> >>+{
> >>+	struct peci_adapter *adapter = file->private_data;
> >>+	void __user *argp = (void __user *)arg;
> >>+	unsigned int msg_len;
> >>+	enum peci_cmd cmd;
> >>+	u8 *msg;
> >>+	int rc = 0;
> >>+
> >>+	dev_dbg(&adapter->dev, "ioctl, cmd=0x%x, arg=0x%lx\n", iocmd, arg);
> >>+
> >>+	switch (iocmd) {
> >>+	case PECI_IOC_PING:
> >>+	case PECI_IOC_GET_DIB:
> >>+	case PECI_IOC_GET_TEMP:
> >>+	case PECI_IOC_RD_PKG_CFG:
> >>+	case PECI_IOC_WR_PKG_CFG:
> >>+	case PECI_IOC_RD_IA_MSR:
> >>+	case PECI_IOC_RD_PCI_CFG:
> >>+	case PECI_IOC_RD_PCI_CFG_LOCAL:
> >>+	case PECI_IOC_WR_PCI_CFG_LOCAL:
> >>+		cmd = _IOC_TYPE(iocmd) - PECI_IOC_BASE;
> >>+		msg_len = _IOC_SIZE(iocmd);
> >>+		break;
> >
> >Adding new ioctl calls is pretty frowned up. Can you export this info
> >via /sysfs?
> >
> 
> Most of these are not simple IOs so ioctl is better suited, I think.

Lets see what other reviewers say, but i think ioctls are
wrong.

     Andrew
