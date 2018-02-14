Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AH8x226/ScztjuR1fudJ0umEQuZK0floIy/b/imt1nuPdxavv1U3CJZU/xfYv3J57NrM46ujJI4K
ARC-Seal: i=1; a=rsa-sha256; t=1518605726; cv=none;
        d=google.com; s=arc-20160816;
        b=Qgiorzwc46VygFI1gHuFZlzIj+7VPeymh2faKJtXT15AsTKbuHORkxt5SCw+v65zi7
         OlCK12lw6+ksMHye3Il1P1xeXWw4JNeADYG1jwRj1x2GZOAprrFtCQeIGB6HpUcvh2VP
         /BKofsNnEgKKdaBYComctmJ8ZNNWPl4vgPWNzngT+pb+ReZVFv6g5b0RZyET1bc9pq5w
         up/wU/a+aX2kLK7zI9ldVMZNkzxgUVMEFVA/kODDPjHfWbfCUCna5Vc9p5x/nWx7wToz
         qET8sD7Jh+2uSii/BKIE3PBDamjx1mkCUtc0x9KhnG+63pFuD6sol0CggZoTnvvzlLbz
         +67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=oZ2c4Z1kadB3+dWzfsBmd7kRzgiFsZ3VY+kSrVb1MuY=;
        b=Wh8xbtew1HOk+mB0x4k66OxgoMHKM3XJKXNsRTYkm+CCUZt4JtQmqyWgY5s+JTKe9q
         lPImzhhNi4XNsZqk0/iwJyrMOq1UoednP3008c3y4D9Ln69SWFGycKs5fxxI2x8iCUP5
         QpvhdvgmQ/HI8I7OMBEWjOh1ymqZuOC5oo0vANL6Ckzs7PYvKZHOL9xMHXKM+aoy2MpV
         3+TxxAxScXEkFFC5l525o28qquh3cSQfq8O8BRTuNZJ6enwjRWawa0sQvjiegviNAM5q
         KXXsiLMFI+0pxhmZBj42hTggUFXk74uL3pU9X1fxN36JhycNHwSV2ikxIVImKlTJogKb
         Q38w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / runtime: Update links_count also if !CONFIG_SRCU
Date: Wed, 14 Feb 2018 11:53:37 +0100
Message-ID: <28130344.VaHZHOhuzq@aspire.rjw.lan>
In-Reply-To: <68feef8bf476ab150e6481b54f1b6f5c401b8e10.1518286105.git.lukas@wunner.de>
References: <68feef8bf476ab150e6481b54f1b6f5c401b8e10.1518286105.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592038722413280584?=
X-GMAIL-MSGID: =?utf-8?q?1592373518206709737?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Saturday, February 10, 2018 7:13:58 PM CET Lukas Wunner wrote:
> Commit baa8809f6097 ("PM / runtime: Optimize the use of device links")
> added an invocation of pm_runtime_drop_link() to __device_link_del().
> However there are two variants of that function, one for CONFIG_SRCU and
> another for !CONFIG_SRCU, and the commit only modified the former.
> 
> Fixes: baa8809f6097 ("PM / runtime: Optimize the use of device links")
> Cc: stable@vger.kernel.org # v4.10+
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/base/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b2261f92f2f1..5847364f25d9 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -310,6 +310,9 @@ static void __device_link_del(struct device_link *link)
>  	dev_info(link->consumer, "Dropping the link to %s\n",
>  		 dev_name(link->supplier));
>  
> +	if (link->flags & DL_FLAG_PM_RUNTIME)
> +		pm_runtime_drop_link(link->consumer);
> +
>  	list_del(&link->s_node);
>  	list_del(&link->c_node);
>  	device_link_free(link);
> 

Applied, thanks!
