Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZpNcXiulMFYY4XVRdyPV3f+L1fVvUlyGZfAHoMwX1sOqY3+HCElvGJsHgANiCRoRPj1P/4k
ARC-Seal: i=1; a=rsa-sha256; t=1525961543; cv=none;
        d=google.com; s=arc-20160816;
        b=Jlf8l30+xhCsiZuC1QXq1HeGYAvDzOWFdNSXqYigFnmJ84Oakmt1lCK1dPmD/QEzjZ
         NVIR7dhQ4vTOOSL95g4+mRxhG7VCx3PY8r3ImdOV9ljWObDpIy3RA0WmG/UfbDZ2y9+b
         uVgLOlug4hD2DXC/NxZgcVIkA57nj8h3WmG9mbpAo3z20/bQVGWhHm2UVVMDkezx9JUv
         6Cqejb6/vVZvleM22muGn4od127zQry+ZpZS6GozygP4AUB6aqAiHnDJPBpnRp1I5DyF
         VzkDMi3hq0Xgj+SqK3tUefA1OMxYdEQu3g6kDCKEQ6VFoRClPwkyTy6zUxV5f+kJmPQ/
         cwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=9g8ucX+b4kAtirUKy72Cj7dZBF4Nz9gaUymyIbB8GSo=;
        b=MNdVS50lwruqEwDJ7i4nV0qL/1MIF02u79da9TjeqUifiwirxgIy5XPclJ1UJO4sLg
         UmXeEj26d+oYJ6wU/O/tAUUIzETGaLO0WioFa8Ke2hNhzFh7o+RXLA94tzOk47kS469S
         y0l7F6hQFeDjlEvF2ZO13iUz/NzZRQxlvD62LW8xolrSsOgUG0ywsiWREOBeP8LgLxnL
         3RfqfCM4J+fyojHlMMGbfOeAqsAQGJMbF3RJGvksEgLXnVeapZrTDfzcxuy2MVDXAVNa
         cHXQI3h3TWl4undPHnT9HqZo6BHd2rko3b3eM7qJAPME+A4VeLR9qgRyYQUadvXJsEXZ
         VlvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>, rajanv@xilinx.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v6 04/11] firmware: xilinx: Add query data API
To: Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
 mingo@kernel.org, gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
 hkallweit1@gmail.com, keescook@chromium.org, dmitry.torokhov@gmail.com,
 mturquette@baylibre.com, sboyd@codeaurora.org, michal.simek@xilinx.com,
 robh+dt@kernel.org, mark.rutland@arm.com, linux-clk@vger.kernel.org
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-5-git-send-email-jollys@xilinx.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <85f8f8c5-a177-dad8-e095-a9dd1c513e8d@arm.com>
Date: Thu, 10 May 2018 15:12:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523389127-14243-5-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389328792813890?=
X-GMAIL-MSGID: =?utf-8?q?1600086651842939508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 10/04/18 20:38, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Add ZynqMP firmware query data API to query platform
> specific information(clocks, pins) from firmware.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 14 ++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 44b43fa..ef09c44 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -258,9 +258,23 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
>  				   arg1, arg2, out);
>  }
>  
> +/**
> + * zynqmp_pm_query_data() - Get query data from firmware
> + * @qdata:	Variable to the zynqmp_pm_query_data structure
> + * @out:	Returned output value
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
> +{
> +	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
> +				   qdata.arg2, qdata.arg3, out);
> +}
> +
>  static const struct zynqmp_eemi_ops eemi_ops = {
>  	.get_api_version = zynqmp_pm_get_api_version,
>  	.ioctl = zynqmp_pm_ioctl,
> +	.query_data = zynqmp_pm_query_data,

Can you give more insight into this ? How will be this used ?
How this aligns with data we get from DT ? I am just trying to
understand how is this information split between this API and DT for
example.

-- 
Regards,
Sudeep
