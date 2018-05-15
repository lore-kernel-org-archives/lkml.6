Return-Path: <linux@roeck-us.net>
X-Google-Smtp-Source: AB8JxZrXVjlAPhGOygoVwdlYzjnqjgHohlGbyFNR7uI3cNQYNDMerNFNqwVVuiL7sAvZ2z5U6XPT
ARC-Seal: i=1; a=rsa-sha256; t=1526359605; cv=none;
        d=google.com; s=arc-20160816;
        b=CxH11TZaoDOl6aazpFxod1swTbC9mM6COrOr1UDw6TdMHzQJBcv7cM3AAPnhgksBVX
         F+Rl9CPZV1j6e5U+lrTnuMxUYhhj2YdS1Fed/chE3naeIb74UTzTpWjstpktPyA6af/d
         ptn9VnxpNbU/jyKk4wINdidShqde4Q+On1mq9ot/qXMVSDe0EX7HwJ213dsVQ/OMUFOR
         MkCmQMKFAycOl5NLaVKSE6+TxEZ4rMKZS2uNbUBzZwJ40youiqyFRxsf6lwcRKNKGn0E
         rtUc1ZZEiMWv9ri3ADGYzWkfUlLlaEBsRkWTPmv/s+/g/uVsOPhh/QRnd1GtxWe2XGmm
         sJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=mEZfXp5v6uCsOlhK65Nq3ySLOhKaHn+DauZYW/HDjZM=;
        b=QCZRSn/qDCB3EdG2umRVJO1RlWHjnX0PHvkr85pCVQnsZnIa2WLjPWKWjz1tIZ234u
         e/LJ9nB9uEiFVPNRu8wOQhE5fWAzGNG/MGSl6OY3DSRrQgKEapPK4/fzVF4SJ9PV13Jl
         UFaFQn81A0tBh9xCZdWyCy+j0/FVHSXl7jrbswic7ED4dtcLrbYpyLgTmXthtuymG5Nc
         Rd/HMS3ttNPWLLyBS5dc0NdfbGcWnrA164yH1EXQowT8DiDhsoiPR9kKyn8MzDBO8WbH
         kHOyvPlpR/54Qw819HAKcuEj33RLcFNpCWhEuPCFWNb2uSILZCHYLMTPX243yML1bzML
         JkVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=QvZ+4oiQ;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=QvZ+4oiQ;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Date: Mon, 14 May 2018 21:46:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Respect all error codes from
 dev_pm_domain_attach()
Message-ID: <20180515044642.GA26133@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798225940952926?=
X-GMAIL-MSGID: =?utf-8?q?1600504049521805264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:53:06AM +0200, Ulf Hansson wrote:
> The limitation of being able to check only for -EPROBE_DEFER from
> dev_pm_domain_attach() has been removed. Hence let's respect all error
> codes and bail out accordingly.
> 

AFAICS this patch causes all drivers/devices to fail instantiating
if dev_pm_domain_set() is called in the device initialization path.
That seems to be a systemic problem, since dev_pm_domain_set() must
only be called for unbound devices.

In practice, I see the problem when trying to boot beagle or overo
with qemu (the Linaro version). Of course, that doesn't mean much
because that is not real hardware. However, I am not surprised that
all devices instantiated through, for example, omap_device_build_from_dt()
fail to instantiate. Instrumentation confirms that dev_pm_domain_set()
is called prior to platform_drv_probe(). 

Guenter

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/platform.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 8075ddc70a17..9460139d9b02 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -572,17 +572,16 @@ static int platform_drv_probe(struct device *_dev)
>  		return ret;
>  
>  	ret = dev_pm_domain_attach(_dev, true);
> -	if (ret != -EPROBE_DEFER) {
> -		if (drv->probe) {
> -			ret = drv->probe(dev);
> -			if (ret)
> -				dev_pm_domain_detach(_dev, true);
> -		} else {
> -			/* don't fail if just dev_pm_domain_attach failed */
> -			ret = 0;
> -		}
> +	if (ret)
> +		goto out;
> +
> +	if (drv->probe) {
> +		ret = drv->probe(dev);
> +		if (ret)
> +			dev_pm_domain_detach(_dev, true);
>  	}
>  
> +out:
>  	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
>  		dev_warn(_dev, "probe deferral not supported\n");
>  		ret = -ENXIO;
> -- 
> 2.7.4
