Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AH8x227V8H8L/qCEJT5DfzwUFXY1V7+VCPDXr93MXHNl01kvw/4BxYV1+9phFHQYWS3lz/bPF1Gl
ARC-Seal: i=1; a=rsa-sha256; t=1518425016; cv=none;
        d=google.com; s=arc-20160816;
        b=v6DQuY2n4EQwzgUBTjx2MGmIqehn/9t7XPYmMFOGjfHLeyhI9RjpUSwTQ3LZV4sxtV
         2hqAF7EUrN/V4R5cyNqEZUZZtQXrn9EVZhRaEv/U5IYqEQ+5vAC1tw4cGVm1csKzeNz1
         ZT2F7IDRKF6BLtAgb5F+gtYPctf63oT5m5fFSeS0TWGfAbPz9ht/mU1lkcXkiTU+D0nJ
         uvMZI8wE6fY40aygDanGWXVthHo8RGMjvQJOmwYEuYNyQGVENGXEdGGcZuRTeZ16S6Ci
         rMkr/sGs0mz1rvmWdH5ajtHvNkHyDzVNuXc4qJSo1cTE7P9y0gD/a6CFla3bUcw0ELuI
         +zmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Cva+kIWUu97UOgGY6NKCRgY3n0lPGNN6RAKOYGtwcd0=;
        b=PM1l4WRHusLgzfbWW7JhjU2mYVwxdlHZKIiPaIOVhT54Dt2RHBv0PrNhK46xyDw0Ne
         NLFMwwvtp3GymyXe4CBBW8bbeDc18EnMJ7GmCY7FmIz8f569C6R4SAfBjgtASJmZ0a87
         MVv83UqKaNeRwPupD+lCVN0fSUHbJ6Wnvor9tm6CiMrcSQbmAAjvt+RSLqsLI7XCX7Z/
         mrG4lvHEJlzfv+SvJfWvYDFGHLgeou07rw0WUrSbrTtgGNaOfPU7lv4Uy6BBcBbRySYn
         KAbeC1cXj5LtJCTteM7XXZ+Hp6QJ2YtR0Jkshux3as7jVyTFLkasF2FhU3OZOYmsB+er
         Rsgw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ssADkrGS;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ssADkrGS;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Mon, 12 Feb 2018 11:42:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kys@microsoft.com, Stephen Hemminger <stephen@networkplumber.org>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        leann.ogasawara@canonical.com, marcelo.cerri@canonical.com,
        sthemmin@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 08/12] Drivers: hv: vmbus: Implement Direct Mode for
 stimer0
Message-ID: <20180212084205.idjf2lwrdn2nprw7@mwanda>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
 <20180212003320.6748-1-kys@exchange.microsoft.com>
 <20180212003320.6748-8-kys@exchange.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212003320.6748-8-kys@exchange.microsoft.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120113
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153266380237670?=
X-GMAIL-MSGID: =?utf-8?q?1592184030028685426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 05:33:16PM -0700, kys@exchange.microsoft.com wrote:
> @@ -116,9 +146,29 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
>  {
>  	union hv_timer_config timer_cfg;
>  
> +	timer_cfg.as_uint64 = 0;
>  	timer_cfg.enable = 1;
>  	timer_cfg.auto_enable = 1;
> -	timer_cfg.sintx = VMBUS_MESSAGE_SINT;
> +	if (direct_mode_enabled)
> +		/*
> +		 * When it expires, the timer will directly interrupt
> +		 * on the specified hardware vector/IRQ.
> +		 */
> +		{
> +		timer_cfg.direct_mode = 1;
> +		timer_cfg.apic_vector = stimer0_vector;
> +		hv_enable_stimer0_percpu_irq(stimer0_irq);
> +		}
> +	else
> +		/*
> +		 * When it expires, the timer will generate a VMbus message,
> +		 * to be handled by the normal VMbus interrupt handler.
> +		 */
> +		{
> +		timer_cfg.direct_mode = 0;
> +		timer_cfg.sintx = VMBUS_MESSAGE_SINT;
> +		}
> +

This indenting isn't right.  We should probably zero out .apic_vector
if .direct_mode is zero.  Or maybe it's fine.  I don't know if any
static analysis tools will complain...

>  	hv_init_timer_config(HV_X64_MSR_STIMER0_CONFIG, timer_cfg.as_uint64);
>  
>  	return 0;
> @@ -191,6 +241,10 @@ int hv_synic_alloc(void)
>  		INIT_LIST_HEAD(&hv_cpu->chan_list);
>  	}
>  
> +	if (direct_mode_enabled && hv_setup_stimer0_irq(
> +		&stimer0_irq, &stimer0_vector, hv_stimer0_isr))
> +		goto err;


Can you indent it like this:

	if (direct_mode_enabled &&
	    hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
				 hv_stimer0_isr))
		goto err;


[ What follows is a long rant not directed at you ]

It's annoying because as soon as I see the "goto err;", I know the error
handling for this function is going to be buggy...

Some rules of error handling are:

1)  Each function should clean up after itself instead returning
    partially allocated structures.
2)  Each allocation function should have a matching free function.
3)  Give meaningful label names based on what the label location so that
    we can tell what the goto does just by looking at it, such as,
    "goto free_some_variable".  This way we can just keep a mental tally
    of the most recently allocated resource and verify based on the
    "goto free_resource;" statemetn that it frees the correct thing.  We
    don't need to scroll to the bottom of the function.

    Using good names means that we should avoid do-nothing gotos
    because, by definition, the label name for a do-nothing goto is
    going to be vague.

In this case the label looks like this:

> +
>  	return 0;
>  err:
>  	return -ENOMEM;

We allocate a bunch of stuff in this function so at first glance this
looks like we leak everything but, actually, the cleanup is done in
vmbus_bus_init().  This is a layering violation.

Later on, we changed hv_synic_alloc() in 37cdd991fac8 ("vmbus: put
related per-cpu variable together") and we started allocating:

	hv_cpu->clk_evt = kzalloc(...

but we forgot to update the error handling because it was in the wrong
place.  It's a very predictable, avoidable bug if we just use proper
error handling style.

Anyway...  Sorry for the long rant.  Summary:  Always distrust vague
label names.

regards,
dan carpenter
