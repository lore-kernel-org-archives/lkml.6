Return-Path: <daniel.lezcano@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526380040; cv=none;
        d=google.com; s=arc-20160816;
        b=owshFhqfCQnYzmv+j/soqCxEleTByR4RiSechR+iXvxzPXwDNRJ+10BlSli0zY6Px6
         f55lh/1AGbMNDksgUFofNM4I4AxBEiEYfYR04i7r8rQvgXmuIQetvgXVv2BzP5SLtUYR
         TXVoe3dBtrDm+d4gaizF7nrke9XRAzL5VsDINH7NbnrKm8awLtWG2QK/nZq3zY+9zBsD
         6sOBQvR3yIB64xJ4nDUO6zmw7w6F74OfHJEl6S95AAM5m02hdAG4aI+Ic0dN9cYMo8gd
         rVJWnDnxYp0ZbimDVLZNfNbMWjEZ7Bgr3fbfeitAWGcdvpkVrZXkdGLf265z7cIXOAAu
         hSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=Mg4TzCv1taza9PHf/YZizkiTKKhmuEFIKVpAvZusn+0=;
        b=xpxdpDhH5puBBKdJ07uElHs2VeMEt5v9CEmCUVRCPtPovjRoo8Z/nQAiMHu8skCfjQ
         uNRld9qnB5qPKtu2idZBwHI3qEs5t5aYwPymcKv9Hbczd6Cb12ESdLLKTd16NCf17111
         mcsE4EzC2pEPaNlayIDIOqyR6ZDOOiuc9eQ+bk1D5gzf3iJijBTCE6kW4r09nZvEMOrT
         5KNtMQWvTyCd0HYosGnwHRIAqNMnMcnlX9C1dVYkvRBuzwzyKGMkYQsVjMc+zzGEp40t
         D0ZkTdSD8aiIXBSPNkKPdFqo712EAME6YRf5eNqD2BVwA+wZQ8RxsP2nYO6MnP0T+Hhu
         QF9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BQd38arJ;
       spf=pass (google.com: domain of daniel.lezcano@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.lezcano@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BQd38arJ;
       spf=pass (google.com: domain of daniel.lezcano@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.lezcano@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZr3z/KZDw7DnxgjnDrDprZRD4Pt82YDDDEc+kWi7PYt0ORR+lYGXCkuIIBEl8Y5XtvAiRlKGA==
Date: Tue, 15 May 2018 12:27:15 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: tglx@linutronix.de, john.stultz@linaro.org, arnd@arndb.de,
	tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk,
	mark.rutland@arm.com, marc.zyngier@arm.com, broonie@kernel.org,
	paulmck@linux.vnet.ibm.com, mlichvar@redhat.com,
	rdunlap@infradead.org, kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org, pombredanne@nexb.com,
	thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de,
	linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org,
	hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com,
	len.brown@intel.com, rajvi.jingar@intel.com,
	alexandre.belloni@bootlin.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] Add persistent clock support
Message-ID: <20180515102715.GO29062@mai>
References: <cover.1526285602.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429141477472075?=
X-GMAIL-MSGID: =?utf-8?q?1600525476970478599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 04:55:26PM +0800, Baolin Wang wrote:
> Hi,
> 
> We will meet below issues when compensating the suspend time for the timekeeping.
> 
> 1. We have too many different ways of dealing with persistent timekeeping
> across architectures, so it is hard for one driver to compatable with different
> architectures.
> 
> 2. On some platforms (such as Spreadtrum platform), we registered the high
> resolution timer as one clocksource to update the OS time, but the high
> resolution timer will be stopped in suspend state. So we use another one
> always-on timer (but low resolution) to calculate the suspend time to
> compensate the OS time. Though we can register the always-on timer as one
> clocksource, we need re-calculate the mult/shift with one larger conversion
> range to calculate the suspend time and need update the clock in case of
> running over the always-on timer.

First, can you elaborate what you mean by 'suspend state' ? On which power
domain the clocksource belongs to?


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
