Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0C0C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA01A20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqOZCdsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA01A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389609AbeG0Vr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:47:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44714 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389368AbeG0VrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:47:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so5436706ljq.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SXbBH2imNzuqD9dTEv625iVdCMtu67IPQQQ8Na1pGgA=;
        b=LqOZCdsV1NYVaPJHk6RH6z4xv5evbJtZzVZgk03jao+XehZK5tHZcToRlHT8h1g7+J
         FWa3/oel+ZGSm8z3zgoTFEs6oED/QzwTBeXxiPuQjxzZpgxzwT8jYabm9QeFgUPk+xYq
         oAnJ6kN1jxBXdgEPnDymKiRw9sLpIHP4zPS4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SXbBH2imNzuqD9dTEv625iVdCMtu67IPQQQ8Na1pGgA=;
        b=gOUN7jQ5RDOnir8YSq+KHKoQxtc1zV1Q6akZjH/HnmfccGrt9NYiLrzm8N+fl9DrYd
         k6hp5qMFjxtNZzlJWurSqUa47GYsAWfy3Z9Qq2HRf+wIYk3ikvyNKnNAZzzl6vGgYx/A
         S7BEYDsYDeUw0O2+JBgSHAmSdOytNnGpe8yfPwnXdwanogXLOQEKAffi7Q1f9nDWM+7M
         JaT6xZzSboq0vFElXqkPtd5W/Ds0f8gCMV3eivKgKHMmpwyskeJ1fkUnGP+4ho6wPpOt
         IN5z9ti1oyehi3t9sQ8zUXYiwsh6hwY5zL/tkRFJxQLKcTaKXnUYPsN2VJy2kiJu1VoA
         I+4g==
X-Gm-Message-State: AOUpUlFMOI+NWSrtOHv+34EE89CiSshZ8KKvfI6QI+HiuxE+DJEejdAV
        Q6jJB8WOT8H5dMlayTIOzZwvQw==
X-Google-Smtp-Source: AAOMgpf4feK8TOtkJBRu4y2tWduPzRi1ycZx/HYBSntL59Rjsr/WKLxC5N2K5h66zMDhjrjkoH7+DQ==
X-Received: by 2002:a2e:92c4:: with SMTP id k4-v6mr6346054ljh.18.1532723032891;
        Fri, 27 Jul 2018 13:23:52 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id g3-v6sm654218lfk.72.2018.07.27.13.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 13:23:51 -0700 (PDT)
Date:   Fri, 27 Jul 2018 23:23:49 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: replace unnecessarily
 macroses on functions
Message-ID: <20180727202348.GC2619@khorivan>
Mail-Followup-To: Joe Perches <joe@perches.com>, grygorii.strashko@ti.com,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
 <98a6d1cd4d313512d66ced3fc25f438449b3c310.camel@perches.com>
 <20180727193641.GA2619@khorivan>
 <f22d3024773abbd811673c4eb957e4a5ffca1387.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f22d3024773abbd811673c4eb957e4a5ffca1387.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 01:04:22PM -0700, Joe Perches wrote:
>On Fri, 2018-07-27 at 22:36 +0300, Ivan Khoronzhuk wrote:
>> On Fri, Jul 27, 2018 at 12:21:07PM -0700, Joe Perches wrote:
>> > On Fri, 2018-07-27 at 22:13 +0300, Ivan Khoronzhuk wrote:
>> > > Replace ugly macroses on functions.
>> >
>> > Careful, see below.
>> >
>> > > diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>> >
>> > []
>> > > @@ -565,40 +565,40 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
>> > >  				(func)(slave++, ##arg);			\
>> > >  	} while (0)
>> > >
>> > > -#define cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb)		\
>> > > -	do {								\
>> > > -		if (!cpsw->data.dual_emac)				\
>> > > -			break;						\
>> > > -		if (CPDMA_RX_SOURCE_PORT(status) == 1) {		\
>> > > -			ndev = cpsw->slaves[0].ndev;			\
>> > > -			skb->dev = ndev;				\
>> > > -		} else if (CPDMA_RX_SOURCE_PORT(status) == 2) {		\
>> > > -			ndev = cpsw->slaves[1].ndev;			\
>> > > -			skb->dev = ndev;				\
>> > > -		}							\
>> > > -	} while (0)
>> > > -#define cpsw_add_mcast(cpsw, priv, addr)				\
>> > > -	do {								\
>> > > -		if (cpsw->data.dual_emac) {				\
>> > > -			struct cpsw_slave *slave = cpsw->slaves +	\
>> > > -						priv->emac_port;	\
>> > > -			int slave_port = cpsw_get_slave_port(		\
>> > > -						slave->slave_num);	\
>> > > -			cpsw_ale_add_mcast(cpsw->ale, addr,		\
>> > > -				1 << slave_port | ALE_PORT_HOST,	\
>> > > -				ALE_VLAN, slave->port_vlan, 0);		\
>> > > -		} else {						\
>> > > -			cpsw_ale_add_mcast(cpsw->ale, addr,		\
>> > > -				ALE_ALL_PORTS,				\
>> > > -				0, 0, 0);				\
>> > > -		}							\
>> > > -	} while (0)
>> > > -
>> > >  static inline int cpsw_get_slave_port(u32 slave_num)
>> > >  {
>> > >  	return slave_num + 1;
>> > >  }
>> > >
>> > > +static inline void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
>> > > +					struct sk_buff *skb)
>> > > +{
>> > > +	if (!cpsw->data.dual_emac)
>> > > +		return;
>> > > +
>> > > +	if (CPDMA_RX_SOURCE_PORT(status) == 1)
>> > > +		skb->dev = cpsw->slaves[0].ndev;
>> > > +	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
>> > > +		skb->dev = cpsw->slaves[1].ndev;
>> > > +}
>> >
>> > perhaps better as a switch/case
>>
>> not better, it's shorter.
>
>True for the source code but it compiles to more object code.
>
>$ cat foo.c
>struct cpsw_common {
>	struct {
>		int dual_emac;
>	} data;
>	struct {
>		int ndev;
>	} slaves[2];
>};
>
>struct sk_buff {
>	int dev;
>};
>
>#define CPDMA_RX_SOURCE_PORT(__status__)        ((__status__ >> 16) & 0x7)
>
>#if defined SWITCH
>
>void foo(struct cpsw_common *cpsw, int status, struct sk_buff *skb)
>{
>	if (!cpsw->data.dual_emac)
>		return;
>
>	switch (CPDMA_RX_SOURCE_PORT(status)) {
>	case 1:
>		skb->dev = cpsw->slaves[0].ndev;
>		break;
>	case 2:
>		skb->dev = cpsw->slaves[1].ndev;
>		break;
>	}
>}
>
>#else
>
>void foo(struct cpsw_common *cpsw, int status, struct sk_buff *skb)
>{
>	if (!cpsw->data.dual_emac)
>		return;
>
>	if (CPDMA_RX_SOURCE_PORT(status) == 1)
>		skb->dev = cpsw->slaves[0].ndev;
>	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
>		skb->dev = cpsw->slaves[1].ndev;
>}
>
>#endif
>$ gcc -c -O2 -DSWITCH foo.c
>$ size foo.o
>   text	   data	    bss	    dec	    hex	filename
>     94	      0	      0	     94	     5e	foo.o
>$ objdump -d foo.o
>
>foo.o:     file format elf64-x86-64
>
>
>Disassembly of section .text:
>
>0000000000000000 <foo>:
>   0:	8b 07                	mov    (%rdi),%eax
>   2:	85 c0                	test   %eax,%eax
>   4:	74 15                	je     1b <foo+0x1b>
>   6:	c1 fe 10             	sar    $0x10,%esi
>   9:	83 e6 07             	and    $0x7,%esi
>   c:	83 fe 01             	cmp    $0x1,%esi
>   f:	74 17                	je     28 <foo+0x28>
>  11:	83 fe 02             	cmp    $0x2,%esi
>  14:	75 0a                	jne    20 <foo+0x20>
>  16:	8b 47 08             	mov    0x8(%rdi),%eax
>  19:	89 02                	mov    %eax,(%rdx)
>  1b:	f3 c3                	repz retq
>  1d:	0f 1f 00             	nopl   (%rax)
>  20:	f3 c3                	repz retq
>  22:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
>  28:	8b 47 04             	mov    0x4(%rdi),%eax
>  2b:	89 02                	mov    %eax,(%rdx)
>  2d:	c3                   	retq
>$ gcc -c -O2 foo.c
>$ size foo.o
>   text	   data	    bss	    dec	    hex	filename
>    102	      0	      0	    102	     66	foo.o
>$ objdump -d foo.o
>
>foo.o:     file format elf64-x86-64
>
>
>Disassembly of section .text:
>
>0000000000000000 <foo>:
>   0:	8b 07                	mov    (%rdi),%eax
>   2:	85 c0                	test   %eax,%eax
>   4:	74 10                	je     16 <foo+0x16>
>   6:	c1 fe 10             	sar    $0x10,%esi
>   9:	83 e6 07             	and    $0x7,%esi
>   c:	83 fe 01             	cmp    $0x1,%esi
>   f:	74 0f                	je     20 <foo+0x20>
>  11:	83 fe 02             	cmp    $0x2,%esi
>  14:	74 1a                	je     30 <foo+0x30>
>  16:	f3 c3                	repz retq
>  18:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
>  1f:	00
>  20:	8b 47 04             	mov    0x4(%rdi),%eax
>  23:	89 02                	mov    %eax,(%rdx)
>  25:	c3                   	retq
>  26:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
>  2d:	00 00 00
>  30:	8b 47 08             	mov    0x8(%rdi),%eax
>  33:	89 02                	mov    %eax,(%rdx)
>  35:	c3                   	retq
>
>

This driver, mainly used for ARM

For ARM, situation a little bit different:
$ arm-linux-gnueabihf-gcc -c -O2 -DSWITCH foo.c
$ size foo.o
   text	   data	    bss	    dec	    hex	filename
     32	      0	      0	     32	     20	foo.o

$ arm-linux-gnueabihf-objdump -d foo.o

foo.o:     file format elf32-littlearm


Disassembly of section .text:

00000000 <foo>:
   0:	6803      	ldr	r3, [r0, #0]
   2:	b143      	cbz	r3, 16 <foo+0x16>
   4:	f3c1 4102 	ubfx	r1, r1, #16, #3
   8:	2901      	cmp	r1, #1
   a:	d005      	beq.n	18 <foo+0x18>
   c:	2902      	cmp	r1, #2
   e:	d000      	beq.n	12 <foo+0x12>
  10:	4770      	bx	lr
  12:	6883      	ldr	r3, [r0, #8]
  14:	6013      	str	r3, [r2, #0]
  16:	4770      	bx	lr
  18:	6843      	ldr	r3, [r0, #4]
  1a:	6013      	str	r3, [r2, #0]
  1c:	4770      	bx	lr
  1e:	bf00      	nop



$ arm-linux-gnueabihf-gcc -c -O2 foo.c
$ size foo.o
   text	   data	    bss	    dec	    hex	filename
     28	      0	      0	     28	     1c	foo.o

$ arm-linux-gnueabihf-objdump -d foo.o

foo.o:     file format elf32-littlearm


Disassembly of section .text:

00000000 <foo>:
   0:	6803      	ldr	r3, [r0, #0]
   2:	b13b      	cbz	r3, 14 <foo+0x14>
   4:	f3c1 4102 	ubfx	r1, r1, #16, #3
   8:	2901      	cmp	r1, #1
   a:	d004      	beq.n	16 <foo+0x16>
   c:	2902      	cmp	r1, #2
   e:	bf04      	itt	eq
  10:	6883      	ldreq	r3, [r0, #8]
  12:	6013      	streq	r3, [r2, #0]
  14:	4770      	bx	lr
  16:	6843      	ldr	r3, [r0, #4]
  18:	6013      	str	r3, [r2, #0]
  1a:	4770      	bx	lr

So, it's shorter.

-- 
Regards,
Ivan Khoronzhuk
