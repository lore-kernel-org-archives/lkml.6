Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AIpwx48m5sU+e3iWs1pyrXEQpetINtgHyzH8iD1ignf1oqJmnWz8ov4FfHfuK6ZMFteXhR5e/W59
ARC-Seal: i=1; a=rsa-sha256; t=1522772462; cv=none;
        d=google.com; s=arc-20160816;
        b=JmaYeUKWFXaHMc+sa1C95m5W7J6r8NpDwsezeXLBQNB1TLmkzBsNDLHtaDui0cDyyb
         JYlxvHrovpUNhHIpQjcVyBL0Q6DYuQxY1rdsVlOS7k3r/Xb7eN92RuJpEUjUCc5BRp8n
         /0yIm+3KFhVuk5jOE3PjLRe+MPR20KNthb/UVl3PciUTfxajB6lqU7KSGjezV+ByXlTP
         dx6x0ioaNLTlhz4M3Y5no69B2btdPlZ1kW9LJFg4SjAeI+tX7oGhlo3DAO6DAbasP89M
         PbP64O+RBmaHnnZdojE3X8v00Cjbkg99xD85SHJsCQN2O3SEfFg4PEw/TtYv2IOeC6vB
         6TPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=cN2c2hO+gvKU4yJ0O0AC1l27WBdVIcPcDctI+364luc=;
        b=QMq2BwrPJ/z4D+lGBjK7WHkj/mC7/x7FcddO1MGIWWC+gpfaU3uYnfzI7O2mzkouTR
         w07thISLf3aoTPpSclr+ScQ2latQ5pG1QQhAvzqbJ9600lE6CA84Lv179zU1qy99AP73
         ljNslsUNxx4i6s72+SNyDdU2rrCP0VMdWXK3bwNbZNssbkdwY1mbfvM8AwgwJf/Usnrr
         sjVGjtg+zwVQWEzbN9QGZdYaRC+sFTE+FJ9QS6FjxXWbWXKNAjEflRmAq/xKUOyc31LJ
         KhYBpH8cJ8lNamMCDpSZiZrg5838SO1aqpumr2E5wFgIKfRO/gVLDY3wNEb2wEjtH+ka
         uEzA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.169 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.169 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3151:3352:3622:3865:3866:3868:3870:3871:3872:3874:4321:4385:5007:7576:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21600:21627:30054:30075:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: shoe19_42fa2f0942a44
X-Filterd-Recvd-Size: 2134
Message-ID: <1522772458.11653.51.camel@perches.com>
Subject: Re: [PATCH 1/1] taging: fbtft: fix memory leak
From: Joe Perches <joe@perches.com>
To: Xidong Wang <wangxidong_97@163.com>, Thomas Petazzoni
	 <thomas.petazzoni@free-electrons.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Xidong Wang <2711406067@qq.com>
Date: Tue, 03 Apr 2018 09:20:58 -0700
In-Reply-To: <1522762386-13990-1-git-send-email-wangxidong_97@163.com>
References: <1522762386-13990-1-git-send-email-wangxidong_97@163.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596731155733578693?=
X-GMAIL-MSGID: =?utf-8?q?1596742657582666749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-03 at 21:33 +0800, Xidong Wang wrote:
> From: Xidong Wang <2711406067@qq.com>
> 
> In function fbtft_framebuffer_alloc(), the memory allocated by
> framebuffer_alloc() is not released on the error path that txbuflen > 0
> and txbuf, which holds the return value of devm_kzalloc(), is NULL.
> This will result in a memory leak bug.
[]
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
[]
> @@ -836,7 +836,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
>  	if (txbuflen > 0) {
>  		txbuf = devm_kzalloc(par->info->device, txbuflen, GFP_KERNEL);
>  		if (!txbuf)
> -			goto alloc_fail;
> +			goto err_info;
>  		par->txbuf.buf = txbuf;
>  		par->txbuf.len = txbuflen;
>  	}
> @@ -872,6 +872,9 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
>  
>  	return info;
>  
> +err_info:
> +	framebuffer_release(info);
> +
>  alloc_fail:
>  	vfree(vmem);

What about the

	if (par->gamma.curves && gamma) {
		if (fbtft_gamma_parse_str(par,
			par->gamma.curves, gamma, strlen(gamma)))
			goto alloc_fail;
	}

a little above this?

Presumable then it should goto err_info too.
