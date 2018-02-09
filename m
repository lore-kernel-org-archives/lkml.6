Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AH8x224C77kKi7oN3aNiQFEWotT47MWhij19FU0bFtUD5PJYLOAzOQL6C0iigoVUSKP8nX/I0rsD
ARC-Seal: i=1; a=rsa-sha256; t=1518177513; cv=none;
        d=google.com; s=arc-20160816;
        b=eA4Xfse6mgKp3Olm1RLcRTTvr5jNBGFRLTSGNt1skvKbZKn/1Rm/h0FOg/pY/vR8j4
         Rp/9JCWi3n6Gu3HS4e6TykLZuDw68tlZ+fLAUkGBN+1AjeTaK/J66prYG34kFHJsVcRJ
         s22wEddgB8x0K1fJ/xztsW31kJ0Y8ZEYcginjAnqywoQ/aUfMbmPdx99WeCj2RsUFXQ/
         VECmpksEAyeSTbcIRu5M2BFG1vLcQWIvi/xGje/bgPI0jOWLqcq9PdwvIwOHBxzDer04
         6BgAkmciu2UpRbkM39JutfDYX6OAsuwi0oq8KlAt2hT/uqY6ryAqMSbSPCOk5c34nXY/
         1n2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=QURsZJ80iLdp2Dzjnpmuia7p6hDNm/oAeQDauKnFSho=;
        b=io+Ob04c33A/8avh8xumAm0XepReBPxugbludSErrgPmlv13UQ29NnKrA/voDGmIqH
         5o1pVDw9ga7aAJKsWpqJb+C57zkOmBdth6YmRS7s3G0/CZWBJNFL/X/DD/MMFSIB3xHK
         RqTDdkU94QUOo2PUg9Pvfu/RU19hMBEKDjH10qhDJWOoxtCvhCSZzwnW1fE3j/3P96St
         4N+t+ycVM/bZRItXQZWeHwZRi9wB212lHsoo89t4ei/uOxH6BzTuBjJDUVP5qG/UScoM
         vFCKsELeJt7HAsTp+Jp8i8eeAzp2RwiInSivDc2YJx/Bqd7DdDBhA4F9pBTMKP9HY1q1
         Q+fg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, khilman@kernel.org, ulf.hansson@linaro.org
Cc: len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] base: power: domain: Replace mdelay with msleep
Date: Fri, 09 Feb 2018 12:56:50 +0100
Message-ID: <66016771.HTTzQvm2zL@aspire.rjw.lan>
In-Reply-To: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
References: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590643262439305991?=
X-GMAIL-MSGID: =?utf-8?q?1591924504668787789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday, January 26, 2018 9:38:19 AM CET Jia-Ju Bai wrote:
> After checking all possible call chains to genpd_dev_pm_detach() and
> genpd_dev_pm_attach() here,
> my tool finds that these functions are never called in atomic context,
> namely never in an interrupt handler or holding a spinlock.
> Thus mdelay can be replaced with msleep to avoid busy wait.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/base/power/domain.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0c80bea..f84ac72 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2144,7 +2144,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>  		if (ret != -EAGAIN)
>  			break;
>  
> -		mdelay(i);
> +		msleep(i);
>  		cond_resched();
>  	}
>  
> @@ -2231,7 +2231,7 @@ int genpd_dev_pm_attach(struct device *dev)
>  		if (ret != -EAGAIN)
>  			break;
>  
> -		mdelay(i);
> +		msleep(i);
>  		cond_resched();
>  	}
>  	mutex_unlock(&gpd_list_lock);
> 

Ulf, Kevin, any concerns or objections?
