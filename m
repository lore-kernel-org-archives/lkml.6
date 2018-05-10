Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZr727QLDiBMzMSI1fRmmJ84SHlQ/Z7l0QVRDmxX7Z0EoDdp1si5R0YsM3b8cFbA2gKRK/uB
ARC-Seal: i=1; a=rsa-sha256; t=1525962684; cv=none;
        d=google.com; s=arc-20160816;
        b=AKiEwHw8OVPukaN3F9W1ML28OtdrlQNPw0orGrrWicKhGxUkXyRgXSbyuuW8CfL1rt
         IpIh1dm+crjfurW0o5K2duxDBZY2cz6QmUjWmr4bJs02QuUibR9hrfExBy8I2uiPlsT6
         LCROTP+8owQ240ovW8gi+kp9ECPyrV/dB+UjpmC7VI4e7/UcMVw6OJZ9hegOrvK7xcZs
         PsnoR1pqMq3aE/CB3LlvA4DDsJvi9ZknQe7c/svxvmCP3JMcu4wgajMCbg5XhSwJ4IQ1
         LftEoxUkH3taFIGpyIrFVAvw8/42EfebWUf9Thf9QT6EMXRZJQfwda8F7litQDvXs/vs
         CoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=fvXCLjTM2yZxZ7oydiCS+o789WN3/WIjko/8PENChiA=;
        b=DvQ5PRM+cAPHIqtGW7lXcQoIv+SLY3Q/qxje03LadOXCA13Os51h1OQbCb68THzNg2
         xYTJNTg7Rji2/lT4OG9A6bWhqlSjp4OQwwKTZg39EtC46a/cOmDUQjn2BepRSgtuoNg8
         0oVzactzYoiZQuWOqBjbHwuVqJ36fs5ppAPeGsLY/It4WjZa51w4o0XTQ4jGuHQM3xJk
         fpW2rK9dl9C7wJhV340qQ/gkM1Q/X0bGWI34ud9Iinc+KMdrIsu3YsU6eGZ36eTQpN3s
         Bq6UdIDfgI7Lee8v7Iy9iOFTE6LqQvyEVccUoU4DI5kHh7RrVC8DqA2Z9/sGVEkroiEF
         NRdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>, rajanv@xilinx.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control
 APIs
To: Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
 mingo@kernel.org, gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
 hkallweit1@gmail.com, keescook@chromium.org, dmitry.torokhov@gmail.com,
 mturquette@baylibre.com, sboyd@codeaurora.org, michal.simek@xilinx.com,
 robh+dt@kernel.org, mark.rutland@arm.com, linux-clk@vger.kernel.org
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-10-git-send-email-jollys@xilinx.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <5bcc47f7-3352-f0e6-29c5-78d5be96c1d1@arm.com>
Date: Thu, 10 May 2018 15:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523389127-14243-10-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389327627066068?=
X-GMAIL-MSGID: =?utf-8?q?1600087848727501017?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 10/04/18 20:38, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Add debugfs file to control clocks using firmware APIs
> through debugfs interface.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp-debug.c | 48 ++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
> index 1cb69f7..837fcd1 100644
> --- a/drivers/firmware/xilinx/zynqmp-debug.c
> +++ b/drivers/firmware/xilinx/zynqmp-debug.c
> @@ -34,6 +34,15 @@ static struct pm_api_info pm_api_list[] = {
>  	PM_API(PM_GET_API_VERSION),
>  	PM_API(PM_IOCTL),
>  	PM_API(PM_QUERY_DATA),
> +	PM_API(PM_CLOCK_ENABLE),
> +	PM_API(PM_CLOCK_DISABLE),
> +	PM_API(PM_CLOCK_GETSTATE),
> +	PM_API(PM_CLOCK_SETDIVIDER),
> +	PM_API(PM_CLOCK_GETDIVIDER),
> +	PM_API(PM_CLOCK_SETRATE),
> +	PM_API(PM_CLOCK_GETRATE),
> +	PM_API(PM_CLOCK_SETPARENT),
> +	PM_API(PM_CLOCK_GETPARENT),
>  };
>  
>  /**
> @@ -87,6 +96,7 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
>  	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
>  	u32 pm_api_version;
>  	int ret;
> +	u64 rate;
>  
>  	if (!eemi_ops)
>  		return -ENXIO;
> @@ -132,6 +142,44 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
>  				pm_api_ret[2], pm_api_ret[3]);
>  		break;
>  	}
> +	case PM_CLOCK_ENABLE:
> +		ret = eemi_ops->clock_enable(pm_api_arg[0]);
> +		break;

As I mentioned in earlier patch, I don't see the need for this debugfs
interface. Clock lay has read-only interface in debugfs already. Also if
you want to debug clocks, you can do so using the driver which uses
these clocks. Do you really want to manage clocks in user-space ?
The whole idea of EEMI kind of interface is to abstract and hide the
fine details even from non-trusted rich OS like Linux kernel, but by
providing this you are doing exactly opposite.

-- 
Regards,
Sudeep
