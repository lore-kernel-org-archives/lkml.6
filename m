Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZp01CDc3sNL7n/RVMdHWh6rYtxYzwxx2Ei2z3IbuBDPA6WE6eaLPRwJrMS+l+A4dRk1LIP4
ARC-Seal: i=1; a=rsa-sha256; t=1526311152; cv=none;
        d=google.com; s=arc-20160816;
        b=ZIgRki0Rb4H0sZt5+483XpVe+TZ6WROh+xBrW4ga4BeBo6SQRZor6pEkDtMdxsg42j
         7Zjv6Xkf6QJkYrPQ9eq7jz+FgqhmX202+E6K82+Zlv6/7EJE2xpwN3xAU/FHCx6j1eMV
         e53/LriFurB+MmojS+43B2GszszQGai2Co76IaOJAWcha40kch5gWWtjvPgxmMizup3E
         VMB2f62bQ2M8zzPbQdcyAv3t73gBPLFbOZU20cA4TUPmFXG7OXyiEYfVfvrcFqeBziPs
         6pUeOAuhYKRvfPjbSQlQcI0Hwy5Pjfs4S+U1KdqE4KiV3uJjv4gwMFA28nXT4fe38ILP
         qrog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Q3dpk77FV3HxdpnpBUl3sZjZYXzXDFuVIUPgpd6Yi2s=;
        b=g/ajlR9N4HJ0D3bJZa3cS6Vn3f6d2iV06oiRHcOrQ261hV+DBu2KOqHcT9/n1968f7
         T45OCNcfLgb2hJcOr98uMWtAZygF2Nsn0Ye0rxTLn/RytOJpbmDCI4am48+G5DENbDmB
         BkeKsoXIY5LgepDIdr6hHVDqDbMyP+ZYfZviVHWsxFCG9VEmnKwSIvdUSBvgkrPL+GXs
         nqXDxbeWGlDhiPtDeip9Xssp9WlbDOoD/5/y0tDIJz7xkFCRNzZUqweBN/nSFOGaolK1
         uX2t+4oH+xBVCC2z+vs/wjKCsrjSKd8TGLkcz/RMJlPjUFcQFu9b45tFM0jNQX9gdjxo
         45nA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Mon, 14 May 2018 08:19:07 -0700
From: Tony Lindgren <tony@atomide.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kevin Hilman <khilman@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Sanyog Kale <sanyog.r.kale@intel.com>, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 07/11] driver core: Respect all error codes from
 dev_pm_domain_attach()
Message-ID: <20180514151907.GK98604@atomide.com>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-8-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524732790-2234-8-git-send-email-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798225940952926?=
X-GMAIL-MSGID: =?utf-8?q?1600453242451865056?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ulf,

* Ulf Hansson <ulf.hansson@linaro.org> [180426 09:01]:
> The limitation of being able to check only for -EPROBE_DEFER from
> dev_pm_domain_attach() has been removed. Hence let's respect all error
> codes and bail out accordingly.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/platform.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 8075ddc..9460139 100644
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

Looks like this causes Linux next to not boot for me with device
probes failing with error -17. So that's at least omaps, looks
like kernelci has others failing too.

Reverting for 8c123c14bbba ("driver core: Respect all error codes from
dev_pm_domain_attach()") fixes the issue for me.

Sounds like something is missing, any ideas?

Regards,

Tony
