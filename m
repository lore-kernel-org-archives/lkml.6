Return-Path: <vigneshr@ti.com>
X-Google-Smtp-Source: AIpwx4+IE3bOBFcggkkzrszbS6UQnqp5PSB10NNP4h5IBjRaQ/YXWC0S8iSAZJXhf3sGEEzV+gC7
ARC-Seal: i=1; a=rsa-sha256; t=1522301477; cv=none;
        d=google.com; s=arc-20160816;
        b=tdthRhFNBx+vcf1xuHEtuMYSgHklZiO2/qVpukeCWzF0TQtX8cZSOIXKcoREuks5e4
         Rsnq0t4exsZ6p9xSJ1tlrnS5hNTd9y7MLuklBfu9DgrATBo9aP1Hn7dz3SY6l4OulB7E
         WZKiBiZ8NSrsFbEqbsNgZ/tldmDs8SjzzawIP+UMGdWTnOZkdndwd89asmA4Ru+Yqtfi
         asDVlsVNz6JQsU5aiOesbiZsOu9bwIuVihU8MGvSdjl0pqn0kOwC2UpYEu2mLkn16+oo
         69FSvOnq9IlgKQmPPXLz+8ARwoZ3CfIgELIaFMK96JEOwXwRg3/WjpG/NwKwNoO9jmEC
         NohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=KFKpZuV1ZwCuEfztMkqFtZ2Gv3THDSL2Qom5Yd+oqy8=;
        b=ywRCtCazQNOj6rx9BmE2Jh+JWUD7vdddXA003KeNzyovRqLBDDHlKdHvt3Gb5ac43P
         VPRyjCPCGchq3AzGOdEubzLNebQtmMM+g9OdDpa+o0tHkzh/sEhIv04kaiDrzm5ztqz3
         HLVa5esSrz1Q8tUK7sFjUBCBttrPGKVDClbjk5upbVVAc53D76hYLBWqDxp2p+asxr2n
         pOqwyznF868VrniNlkvH4SlG7a9+ULFIMWBrmul4+k18TH2PrQA5lP4IH4urqf+GzV3m
         36Rkw4+Kh34TZPWKysgZfsprVgbQYbqykV+lLSE9GjmXE0QiLKW0bUtYXcn9dfFOUQTs
         SK3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=R6Ll74zX;
       spf=pass (google.com: domain of vigneshr@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=vigneshr@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=R6Ll74zX;
       spf=pass (google.com: domain of vigneshr@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=vigneshr@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH] serial: 8250: omap: Provide ability to enable/disable
 UART as wakeup source
To: Tony Lindgren <tony@atomide.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jslaby@suse.com>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>
References: <20180327120217.4749-1-vigneshr@ti.com>
 <20180328223020.GL5700@atomide.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <c43b081a-a94a-fb89-d2d7-9c4947bac4a6@ti.com>
Date: Thu, 29 Mar 2018 11:02:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328223020.GL5700@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596092181415045913?=
X-GMAIL-MSGID: =?utf-8?q?1596248793924599925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Thursday 29 March 2018 04:00 AM, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [180327 12:03]:
>> Enable/Clear module level UART wakeup in UART_OMAP_WER register based on
>> return value of device_may_wakeup() in .suspend(). This allows
>> userspace to use sysfs to control the ability of UART to wakeup the
>> system from deep sleep state. Register is restored back in .startup()
>> call that happens as part of resume sequence.
>> 
>> With this patch, userspace can control UART wakeup capability via sysfs:
>> To enable wakeup capability:
>> echo enabled >  /sys/class/tty/ttyXX/device/power/wakeup
>> For disabling wakeup capability:
>> echo disabled > /sys/class/tty/ttyXX/device/power/wakeup
> 
> To avoid confusion, can you please add this to the description:
> 
> Note that the UART wakeup events configured in the 8250 hardware only
> work for idle modes that do not cut off power for the UART. For deeper
> idle states, dedicated padconf wakeirqs must be used. Or in some cases
> the UART RX pin can be remuxed to GPIO input if the GPIO block stays
> powered.
> 

That makes sense, I will add it to patch description in v2.

> I tested this briefly and the dedicated wakeirqs still work for me,
> so from that point of view:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks for testing!

-- 
Regards
Vignesh
