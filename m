Return-Path: <stefan@agner.ch>
X-Google-Smtp-Source: AIpwx49nUFgwOXAXeoLmIQnyjum8taufE+HWIbOeLOgacgd1wiWg0hBzXHr2uAjzO6/lAJTp4srx
ARC-Seal: i=1; a=rsa-sha256; t=1524212562; cv=none;
        d=google.com; s=arc-20160816;
        b=jJ/NOsBuv1rn4j6BllX64wx5UdmivxGLrPlCUKS5tBtYzRkQp1uKYsoy+N1uTFyxT0
         lVB55wzV+Ae+6vvY2ZzBBC1lVnaCKzMUfeexpP4DhBynubdbQQBa6SoGbTGI4Wg4GoBZ
         vpuJyflXc5HHnfkca9EpiFWxIhpAN6fjU7J6RSOG9cjrD7S74c28kyfL+1n/3+gcntKF
         3Okz+7HGOwhKov6bsUKpazmJ04hhDNQyCdd4sjsZRgp5Y4YhpIG8kbWS5IiONW20tJH7
         qxOIMiZvbMoBX1IQ+SkDu06Q1SNbgGAaCQ2cBOi82ZI0K492uPF5FAzeqytFoQJmkgXk
         92KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :arc-authentication-results;
        bh=cwtq4XfinItztfDmWdT2ki3Ezn/K6ayBzvf1jwlL5Fc=;
        b=KAsA7iNchi07lAoYnLxUTL2MGmXhF6P94p+m8SeoMaROXFEVT+SdxQSemRawWoaQb0
         eqkU7G8DKUosVXu2ydZBOJ/GILKolFahIYfZtQzymEUy357QQC1SVz09zyyGW6jtO5JL
         4SWi/A9V1/ewhQkDFai/yt7I8XoCUtjdvSIXaaDcpKPdsQXBnFUAyCn72gsZlUrsQjY4
         HxvCxPlG3wWwyeLUI6P8lHaKS88+Ir1QF/hlkdHt0i4CK8tQnyqQzCFnSJH180uw5+CY
         Nn5CMaLlzl1s+6UwvvEXLSIFecCAD/B3x78qcg7Yyha6kvh0gPGw7c27ZyrQOqTkVq65
         rM4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@agner.ch header.s=dkim header.b=zsQIAnAi;
       spf=pass (google.com: domain of stefan@agner.ch designates 2a02:418:6a02::a2 as permitted sender) smtp.mailfrom=stefan@agner.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@agner.ch header.s=dkim header.b=zsQIAnAi;
       spf=pass (google.com: domain of stefan@agner.ch designates 2a02:418:6a02::a2 as permitted sender) smtp.mailfrom=stefan@agner.ch
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Fri, 20 Apr 2018 10:22:41 +0200
From: Stefan Agner <stefan@agner.ch>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: imx: fix cached UCR2 read on software reset
In-Reply-To: <20180420060315.ob6eygfcibwq7f24@pengutronix.de>
References: <20180416153502.11814-1-stefan@agner.ch>
 <581f0f26d7191aa3355a6c63b531f876@agner.ch>
 <20180420060315.ob6eygfcibwq7f24@pengutronix.de>
Message-ID: <c53b19818748ec4c179970c5d53a89d3@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.10 / 15.00];
	 RCVD_TLS_ALL(0.00)[];
	 ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
	 RCVD_COUNT_ZERO(0.00)[0];
	 RCPT_COUNT_FIVE(0.00)[5];
	 FROM_HAS_DN(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 FROM_EQ_ENVFROM(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 ARC_NA(0.00)[];
	 DKIM_SIGNED(0.00)[]
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597917613675943799?=
X-GMAIL-MSGID: =?utf-8?q?1598252711876942052?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20.04.2018 08:03, Uwe Kleine-König wrote:
> Hello Stefan,
> 
> On Thu, Apr 19, 2018 at 11:37:23PM +0200, Stefan Agner wrote:
>> On 16.04.2018 17:35, Stefan Agner wrote:
>> > To reset the UART the SRST needs be cleared (low active). According
>> > to the documentation the bit will remain active for 4 module clocks
>> > until it is cleared (set to 1).
>> >
>> > Hence the real register need to be read in case the cached register
>> > indcates that the SRST bit is zero.
>> >
>> > This bug lead to wrong baudrate because the baud rate register got
>> > restored before reset completed in imx_flush_buffer.
>>
>> Given that you reviewed my other patch rather quickly, you might have
>> overlooked this one?
> 
> no I didn't, still the ping was justified. I didn't look into it at once
> because I didn't feel like opening the refman.
>  
>> Since it is a regression, this should go into v4.17 still...
> 
> That's right,
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> I wonder what is different on your side that made it break. I didn't see
> any breakage and tested that on a handful of different machines.

I observed it on a i.MX 6DualLite, UART in DTE mode...

It did work on a i.MX 7Dual just fine for me too. Probably bus clock
etc. dependent...

--
Stefan

> 
> Best regards
> Uwe
