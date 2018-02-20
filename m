Return-Path: <prvs=582c6db63=Richard.Leitner@skidata.com>
X-Google-Smtp-Source: AH8x225urshC0MfCSb+cfXKs0q2DwreWsKO/UQ4/rUtNYQP5oFXUR7/dzPAxB9VSIMQjcugNHJYR
ARC-Seal: i=1; a=rsa-sha256; t=1519128872; cv=none;
        d=google.com; s=arc-20160816;
        b=xMHT4mXJ82K/lrOdmE1rxiUFiqAAPOoPG+sApA+fO23naQxxYH0yRXeDcmc+c8kXkh
         0e2FDCWwdeJvp069TJP2B//lFvvTyokYoV8RoKX2rtL3cuTOPkyBAiP0xNiyFYZO0kwd
         M7qVHeb9/nHGr+0nDHtD+gmXzTwiGEzxRIyOP1xSQLrRtCw7fcf6gHegKqJvwmI7X6uE
         xZ1xj3G1JwkHc8Fdr3g8pSTBqHzM0sjZqk6S57QtGKAanNHI/n2v0bynQuZ54ZodzEn8
         5LAgoaNDyJprX5I60ofE+lfbvhCyZy1BLzSgIqPgtlWBJ/ps/Yd8zTbL+7NTH//l+hRr
         3D2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=VDg0C5dPgU5ixlOTgfqaQPqhyErBoHT9GLOGKp8tOWs=;
        b=S4isfAEGz988Gk1lFJsY3mfIiGilzRGaWUuf++mCE5lJTptz2pAEY7w1yfyAlC/BGn
         ZKbYYo8OehrN7wPnKkyS1Uh8kBIhwQEITN3HztXACugDM0M3g8OC9TD8aqJX4YnGOOWc
         4coHKQGIGH2B2dFaNvMDpF7qUcUrwJLDmUoAu+a5prMIpMTYo7UrVDCW9lX4EP/CzzRc
         GvYkQXmWoUK3r/flIhPYFDUg/27i0j+/Qj1aVVBCAYWfhfifze60Zby5zmsF6Ewz9bXA
         fartS0D8vIPCegbfh539xCdQk/+5nwHDlJH2qVbqN/rVC5TdEKdu+2uTIWw2IPEcUBrl
         nvwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of prvs=582c6db63=richard.leitner@skidata.com designates 91.230.2.91 as permitted sender) smtp.mailfrom=prvs=582c6db63=Richard.Leitner@skidata.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of prvs=582c6db63=richard.leitner@skidata.com designates 91.230.2.91 as permitted sender) smtp.mailfrom=prvs=582c6db63=Richard.Leitner@skidata.com
X-IronPort-AV: E=Sophos;i="5.46,539,1511823600";
   d="scan'208";a="1285288"
Subject: Re: [PATCH v2] usb: core: introduce per-port over-current counters
To: Felipe Balbi <felipe.balbi@linux.intel.com>, Richard Leitner
	<dev@g0hl1n.net>, <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
	<linux@roeck-us.net>, <mathias.nyman@linux.intel.com>, <johan@kernel.org>,
	<ekorenevsky@gmail.com>, <peter.chen@nxp.com>, <drake@endlessm.com>,
	<joe@perches.com>
References: <20180220115033.29496-1-dev@g0hl1n.net>
 <87k1v7q3hx.fsf@linux.intel.com>
From: Richard Leitner <richard.leitner@skidata.com>
Message-ID: <5c398870-08ea-e0ec-5fd4-101255e2b727@skidata.com>
Date: Tue, 20 Feb 2018 13:14:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87k1v7q3hx.fsf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592920589628798934?=
X-GMAIL-MSGID: =?utf-8?q?1592922076110917271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/20/2018 12:55 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Richard Leitner <dev@g0hl1n.net> writes:
>> From: Richard Leitner <richard.leitner@skidata.com>
>>
>> For some userspace applications information on the number of
>> over-current conditions at specific USB hub ports is relevant.
>>
>> In our case we have a series of USB hardware (using the cp210x driver)
>> which communicates using a proprietary protocol. These devices sometimes
>> trigger an over-current situation on some hubs. In case of such an
>> over-current situation the USB devices offer an interface for reducing
>> the max used power. As these conditions are quite rare and imply
>> performance reductions of the device we don't want to reduce the max
>> power always.
>>
>> Therefore give user-space applications the possibility to react
>> adequately by introducing an over_current_counter in the usb port struct
>> which is exported via sysfs.
> 
> why don't you just provide more than one configuration with several
> bMaxPower fields? Then host OS should choose correct configuration based
> on power budget.

Thank you for that suggestion!
Generally speaking that would be possible. Nonetheless we
	a) don't have the possibility to change the firmware or the USB 
		configuration of the device.
	b) in those corner-cases (where the over-current situation occurs)
		the device consumes more than 500mA (which couldn't be 
		configured in bMaxPower AFAIK?). Nonetheless most
		hubs don't detect the over-current (AFAIK) due to
		electrical tolerances of their components. Our problem are
		the hubs which trigger the over-current situation (which
		is fine from a USB perspective).

I know it's probably not a very nice solution, so if anybody has a better
proposal please let me know :-)

Thanks!

regards;Richard.L
