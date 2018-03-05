Return-Path: <b-liu@ti.com>
X-Google-Smtp-Source: AG47ELsMCQ8YpVyskdwtUQRN6vv6v9E9utKjAHftyi6liKJEVaQOOizYoohgRWH/t7Oa7/FCaclT
ARC-Seal: i=1; a=rsa-sha256; t=1520271487; cv=none;
        d=google.com; s=arc-20160816;
        b=WcqVAHA++F93xCNGWsbeb7X6s6/kEPZkaduTkXCJgXV5LSYbGf74DfdEkg4f4+aOef
         NZkVEh0iK6moIPObGHgcDBXtIOEq2U/dXaqNIbSa2Fr/zhYKEhPTp+GGdH6WCM1hmxEO
         WndVqU1xAEgpBN9NfnHGife/ooiAeX5WqTWGXe5CEapcuJSJih52zvFfPOiswP6UX9KP
         m9iqhacQDPwG0C0PsPjmmHAmXe07wp2wIedkrUOJy4/ek0h7SNsXg8WUYh3fuxWaUp5i
         cAeEuE7DmCbOUV3q8+AxtR1bZ2J71Umg1hk9L7cXGYVmI03C8yyt67F1BxJ/CeJOcEdY
         5maA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=uUabfIFfkH4wnwH7YyZKZfisqm8gtOK2yBLqVaQT4P4=;
        b=NtPTdntw/lKz8DC/1b53UrGVylq5U12G8E6HEPDDS0gJFbOSY+DxASgjAnV8SXv/rY
         rfqrUHuO14OXZ3P/7xaIlB9mlSwjWv5ILZtcU3Vw6QyVjUGY5fFI1Nyu+P6xNZFHXzlx
         tovQ7z40MWmSX0j6VuIoWRkAB5bat0197DpSH8IalbW80O2VRvrZTaPAMoSrIj5TBMS5
         m5BiZzo8kEi/X0PN/4+83iqIVO7Ea3JEQu0wPsl11qi6GILoIELjNGHSv7hfXbG2JDKv
         1uji52+rzOTwyNDKxhj6v2kJSyBNX4qnWyHAJ17WXy4URpOAMy2NzedLSI/uGXnqlB9X
         p0UQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=qCNDnEzI;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=qCNDnEzI;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Date: Mon, 5 Mar 2018 11:38:02 -0600
From: Bin Liu <b-liu@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: Merlijn Wajer <merlijn@wizzup.org>, <linux-omap@vger.kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] usb: musb: call pm_runtime_{get,put}_sync before
 reading vbus registers
Message-ID: <20180305173802.GB14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Tony Lindgren <tony@atomide.com>,
	Merlijn Wajer <merlijn@wizzup.org>, linux-omap@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180227222740.2150-1-merlijn@wizzup.org>
 <20180227222740.2150-2-merlijn@wizzup.org>
 <20180228215943.GI5448@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180228215943.GI5448@atomide.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593594893909061681?=
X-GMAIL-MSGID: =?utf-8?q?1594120195048172768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 01:59:43PM -0800, Tony Lindgren wrote:
> * Merlijn Wajer <merlijn@wizzup.org> [180227 22:29]:
> > Without pm_runtime_{get,put}_sync calls in place, reading
> > vbus status via /sys causes the following error:
> > 
> > Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
> > pgd = b333e822
> > [fa0ab060] *pgd=48011452(bad)
> > 
> > [<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x58/0xe4)
> > [<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x44)
> > [<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80/0xdc)
> > [<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x448)
> > [<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
> > [<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
> > [<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
> > [<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)
> > 
> > Solution was suggested by Tony Lindgren <tony@atomide.com>.
> > 
> > Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
> 
> Thanks for fixing this. Assuming it passes Bin's tests:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Applied and sent out. Thanks.

-Bin.
