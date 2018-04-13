Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AIpwx4+UR8E4iybChYm76GwQSuSzMSxRct7YQZGP2vAIL/plBw47wULORku6jOO242aOxO0Hi+8d
ARC-Seal: i=1; a=rsa-sha256; t=1523638033; cv=none;
        d=google.com; s=arc-20160816;
        b=VZNFoT6WgHrkOlLJqgM4MDpg+8iaVH7WHeAoAzQoH2S7D7o+gx8w/jJPvfGZlq6b7N
         nRkGyE6FzdQ123/5J37HJ2Yf+F7lAl0BrPb0nHNPwXmFjByFDHewf8DPtlZahDXj478i
         CABfCqRmJekHNdLxp8rJThUvQ99MElxU5/k7bizTIhwBQJ0FL8fylmrgy+IVEFo4Q26l
         GUzaxLYivT+Dmb8GlLJMscFA5xz3dci+8CAnoK3lbRHPBoNX6DhytxYqZyqpDww1xf/D
         RJbEOwffirb7+dPiD494i/cF5uCxThMXxmdLOrc3bnHPwlQT+dytJ0M3rsABY1HOqPuP
         K0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=qjd1hxeBZp2iaPGYDvIfDbc6dExrsYOH4D/0Fhc3ppc=;
        b=My1aBC41+ALa09Lcz8LIS1yRHuhwHueRjxLYiPoYLWMF76Yxtv2lMHfEDWJK20Nder
         5jzqfHUGxqIdnbfJZg/F/F8k4nJQOXYL3XO9zxhaC5qlypWPG9SWV5JL+pHotcI/KOUL
         zlbkkrKK+mmaZqobmK7RBplKdvfa+gzUIiW7rU+Un8TL6atVYCVfsgjbPE6/LMNzpAYR
         PJgqjGTvEebH8WQDShabExp1WD6E4+tbCS4HvX38YHNhaTvC0In6glV5tfOl83fXxv7S
         Tjnkiaac1NeW0C9ANZQqovzONVpF0xvf326FEZ2n4/t+s+2B+B/IC590LJgLX0k13yow
         HYYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=QoB9UJc/;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=QoB9UJc/;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Fri, 13 Apr 2018 09:47:10 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v1 3/7] platform/mellanox: mlxreg-hotplug: add extra
 cycle for hotplug work queue
Message-ID: <20180413164710.GE27560@fury>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
 <1522144927-56512-4-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522144927-56512-4-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077329932393819?=
X-GMAIL-MSGID: =?utf-8?q?1597650274639710260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 10:02:03AM +0000, Vadim Pasternak wrote:
> It adds missed logic for signal acknowledge, by adding an extra run for
> work queue in case a signal is received, but no specific signal assertion
> is detected. Such case theoretically can happen for example in case
> several units are removed or inserted at the same time. In this situation
> acknowledge for some signal can be missed at signal top aggreagation
> status level.

Why can they be missed? What does "signal top aggregation status level"
mean? I'm asking to confirm that we are fixing this at the right place,
and not just applying a suboptimal bandaid by running the workqueue
more.

...

> 
> Fixes: 1f976f6978bf ("platform/x86: Move Mellanox platform hotplug driver to platform/mellanox")

You didn't mention above how this commit caused this - how did moving
the driver create this problem? Does this need to go to stable? I'm
assuming not as you've called it theoretical - not something you've
observed in practice?

...

>  static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
> @@ -410,6 +413,18 @@ static void mlxreg_hotplug_work_handler(struct work_struct *work)
>  	aggr_asserted = priv->aggr_cache ^ regval;
>  	priv->aggr_cache = regval;
>  
> +	/*
> +	 * Handler is invoked, but no assertion is detected at top aggregation
> +	 * status level. Set aggr_asserted to mask value to allow handler extra
> +	 * run over all relevant signals to recover any missed signal.
> +	 */
> +	if (priv->not_asserted == MLXREG_HOTPLUG_NOT_ASSERT) {
> +		priv->not_asserted = 0;
> +		aggr_asserted = pdata->mask;
> +	}
> +	if (!aggr_asserted)

We seem to check aggr_asserted in several places in this routine now.
Looks like something we could simplify. If you check it here, can you
drop the check lower in the routine? Can you remove it from the for loop
if conditional entirely? Please consider how to simplify.

-- 
Darren Hart
VMware Open Source Technology Center
