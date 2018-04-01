Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AIpwx4/6nDuo9L6nAZThSyU+pgLqPl5rCDd0MBgYmpPsFVAMZmTeoppds6Kpwe7G4DvdZPz6lvtV
ARC-Seal: i=1; a=rsa-sha256; t=1522597789; cv=none;
        d=google.com; s=arc-20160816;
        b=JLCTMSDyUjR9dz4IiEoyjGJRbTytMB0aKC/fvXxg3FelfcmBpa0NUoqYcQHqA5PQCa
         tMczd3atyor22vrV8+TuwshJGmndJupZY6jJXXlAPJp/Kao2vz9TAgo3J/SA3xPhdamJ
         8eCtK4rUiGhonD65dkLrWUmP8cDxOgorfR4y27mfBB7w1D3ft52srglpQZEUtzMR/BuG
         MDbahUJN7Y4qTToHx7iUwgZ2TX1RTkV2q+FcFua/K78RcaSN3a0Jp89tAGjbgyxHXkwx
         02aorB0iTp7Yc3qJK4HOBBaAlVsmWekPGYYqyNBPgMJr4IFJ4LdLgJZ0ydKxc5TcBL9K
         beww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=68IPQtkSV68f1brbVwv0HWg6lf98syaotLRwRmf8Dhg=;
        b=Qz6oSIMDRX7+Kx6LaUn2DPp9SnpmMaSYMLbRyAHF24SIjQh/qgDt0ztb7MjBb4Anib
         0mHEl4JOFtoGhh1Nsb88gGDS5nr7vjwjtZWAw7s2VrIJ0qMO2NtNRjbGdhXBvKOAXAu/
         k5MQoTDdMTM2lKNKf7rID6YcolRCCrVfmbTiz6mdR/FbcYV+zj/5MrQ9mnyveAg71eJ0
         Xr6HWqc86j5leyLKVRSEw4vVfI5gDMJbg7YuhzTD2tzUwKXafQw/p5AHYYPsxEtA9hFB
         s4iZXErSJMx/t3+w7FNFf/0u8HKZC6bIQl2wd2lSGljD8Kji0K6E0WLjK0FzHNhh+zdy
         xomA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Message-ID: <1522597785.2654.54.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 068/134] usb: dwc2: Make sure we disconnect the
 gadget state
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>, Guodong Xu
	 <guodong.xu@linaro.org>, Amit Pundir <amit.pundir@linaro.org>, Rob Herring
	 <robh+dt@kernel.org>, John Youn <johnyoun@synopsys.com>, Douglas Anderson
	 <dianders@chromium.org>, Chen Yu <chenyu56@huawei.com>, Felipe Balbi
	 <felipe.balbi@linux.intel.com>, linux-usb@vger.kernel.org, John Stultz
	 <john.stultz@linaro.org>, Sasha Levin <alexander.levin@microsoft.com>
Date: Sun, 01 Apr 2018 16:49:45 +0100
In-Reply-To: <20180319171859.057406471@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
	 <20180319171859.057406471@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595390862547164468?=
X-GMAIL-MSGID: =?utf-8?q?1596559499183213694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-19 at 19:05 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: John Stultz <john.stultz@linaro.org>
> 
> 
> [ Upstream commit dad3f793f20fbb5c0c342f0f5a0bdf69a4d76089 ]

Maybe we should also have:

commit d2471d4a24dfbff5e463d382e2c6fec7d7e25a09
Author: John Stultz <john.stultz@linaro.org>
Date:   Mon Oct 23 14:32:48 2017 -0700

    usb: dwc2: Improve gadget state disconnection handling

Ben.

> I had seen some odd behavior with HiKey's usb-gadget interface
> that I finally seemed to have chased down. Basically every other
> time I plugged in the OTG port, the gadget interface would
> properly initialize. The other times, I'd get a big WARN_ON
> in dwc2_hsotg_init_fifo() about the fifo_map not being clear.
> 
> Ends up if we don't disconnect the gadget state, the fifo-map
> doesn't get cleared properly, which causes WARN_ON messages and
> also results in the device not properly being setup as a gadget
> every other time the OTG port is connected.
> 
> So this patch adds a call to dwc2_hsotg_disconnect() in the
> reset path so the state is properly cleared.
> 
> With it, the gadget interface initializes properly on every
> plug in.
> 
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: John Youn <johnyoun@synopsys.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Chen Yu <chenyu56@huawei.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Acked-by: John Youn <johnyoun@synopsys.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/dwc2/hcd.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -1385,6 +1385,7 @@ static void dwc2_conn_id_status_change(s
>  		dwc2_core_init(hsotg, false, -1);
>  		dwc2_enable_global_interrupts(hsotg);
>  		spin_lock_irqsave(&hsotg->lock, flags);
> +		dwc2_hsotg_disconnect(hsotg);
>  		dwc2_hsotg_core_init_disconnected(hsotg, false);
>  		spin_unlock_irqrestore(&hsotg->lock, flags);
> 		dwc2_hsotg_core_connect(hsotg);

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
