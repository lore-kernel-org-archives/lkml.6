Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C855C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B6A20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B6A20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389546AbeG0V1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:27:51 -0400
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:34542 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389337AbeG0V1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:27:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 28163182CF69F;
        Fri, 27 Jul 2018 20:04:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pigs55_7db3e850f6508
X-Filterd-Recvd-Size: 6309
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Jul 2018 20:04:23 +0000 (UTC)
Message-ID: <f22d3024773abbd811673c4eb957e4a5ffca1387.camel@perches.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: replace unnecessarily
 macroses on functions
From:   Joe Perches <joe@perches.com>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 13:04:22 -0700
In-Reply-To: <20180727193641.GA2619@khorivan>
References: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
         <98a6d1cd4d313512d66ced3fc25f438449b3c310.camel@perches.com>
         <20180727193641.GA2619@khorivan>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 22:36 +0300, Ivan Khoronzhuk wrote:
> On Fri, Jul 27, 2018 at 12:21:07PM -0700, Joe Perches wrote:
> > On Fri, 2018-07-27 at 22:13 +0300, Ivan Khoronzhuk wrote:
> > > Replace ugly macroses on functions.
> > 
> > Careful, see below.
> > 
> > > diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> > 
> > []
> > > @@ -565,40 +565,40 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
> > >  				(func)(slave++, ##arg);			\
> > >  	} while (0)
> > > 
> > > -#define cpsw_dual_emac_src_port_detect(cpsw, status, ndev, skb)		\
> > > -	do {								\
> > > -		if (!cpsw->data.dual_emac)				\
> > > -			break;						\
> > > -		if (CPDMA_RX_SOURCE_PORT(status) == 1) {		\
> > > -			ndev = cpsw->slaves[0].ndev;			\
> > > -			skb->dev = ndev;				\
> > > -		} else if (CPDMA_RX_SOURCE_PORT(status) == 2) {		\
> > > -			ndev = cpsw->slaves[1].ndev;			\
> > > -			skb->dev = ndev;				\
> > > -		}							\
> > > -	} while (0)
> > > -#define cpsw_add_mcast(cpsw, priv, addr)				\
> > > -	do {								\
> > > -		if (cpsw->data.dual_emac) {				\
> > > -			struct cpsw_slave *slave = cpsw->slaves +	\
> > > -						priv->emac_port;	\
> > > -			int slave_port = cpsw_get_slave_port(		\
> > > -						slave->slave_num);	\
> > > -			cpsw_ale_add_mcast(cpsw->ale, addr,		\
> > > -				1 << slave_port | ALE_PORT_HOST,	\
> > > -				ALE_VLAN, slave->port_vlan, 0);		\
> > > -		} else {						\
> > > -			cpsw_ale_add_mcast(cpsw->ale, addr,		\
> > > -				ALE_ALL_PORTS,				\
> > > -				0, 0, 0);				\
> > > -		}							\
> > > -	} while (0)
> > > -
> > >  static inline int cpsw_get_slave_port(u32 slave_num)
> > >  {
> > >  	return slave_num + 1;
> > >  }
> > > 
> > > +static inline void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
> > > +					struct sk_buff *skb)
> > > +{
> > > +	if (!cpsw->data.dual_emac)
> > > +		return;
> > > +
> > > +	if (CPDMA_RX_SOURCE_PORT(status) == 1)
> > > +		skb->dev = cpsw->slaves[0].ndev;
> > > +	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
> > > +		skb->dev = cpsw->slaves[1].ndev;
> > > +}
> > 
> > perhaps better as a switch/case
> 
> not better, it's shorter.

True for the source code but it compiles to more object code.

$ cat foo.c
struct cpsw_common {
	struct {
		int dual_emac;
	} data;
	struct {
		int ndev;
	} slaves[2];
};

struct sk_buff {
	int dev;
};

#define CPDMA_RX_SOURCE_PORT(__status__)        ((__status__ >> 16) & 0x7)

#if defined SWITCH

void foo(struct cpsw_common *cpsw, int status, struct sk_buff *skb)
{
	if (!cpsw->data.dual_emac)
		return;

	switch (CPDMA_RX_SOURCE_PORT(status)) {
	case 1:
		skb->dev = cpsw->slaves[0].ndev;
		break;
	case 2:
		skb->dev = cpsw->slaves[1].ndev;
		break;
	}
}

#else

void foo(struct cpsw_common *cpsw, int status, struct sk_buff *skb)
{
	if (!cpsw->data.dual_emac)
		return;

	if (CPDMA_RX_SOURCE_PORT(status) == 1)
		skb->dev = cpsw->slaves[0].ndev;
	else if (CPDMA_RX_SOURCE_PORT(status) == 2)
		skb->dev = cpsw->slaves[1].ndev;
}

#endif
$ gcc -c -O2 -DSWITCH foo.c
$ size foo.o
   text	   data	    bss	    dec	    hex	filename
     94	      0	      0	     94	     5e	foo.o
$ objdump -d foo.o

foo.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <foo>:
   0:	8b 07                	mov    (%rdi),%eax
   2:	85 c0                	test   %eax,%eax
   4:	74 15                	je     1b <foo+0x1b>
   6:	c1 fe 10             	sar    $0x10,%esi
   9:	83 e6 07             	and    $0x7,%esi
   c:	83 fe 01             	cmp    $0x1,%esi
   f:	74 17                	je     28 <foo+0x28>
  11:	83 fe 02             	cmp    $0x2,%esi
  14:	75 0a                	jne    20 <foo+0x20>
  16:	8b 47 08             	mov    0x8(%rdi),%eax
  19:	89 02                	mov    %eax,(%rdx)
  1b:	f3 c3                	repz retq 
  1d:	0f 1f 00             	nopl   (%rax)
  20:	f3 c3                	repz retq 
  22:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  28:	8b 47 04             	mov    0x4(%rdi),%eax
  2b:	89 02                	mov    %eax,(%rdx)
  2d:	c3                   	retq   
$ gcc -c -O2 foo.c
$ size foo.o
   text	   data	    bss	    dec	    hex	filename
    102	      0	      0	    102	     66	foo.o
$ objdump -d foo.o

foo.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <foo>:
   0:	8b 07                	mov    (%rdi),%eax
   2:	85 c0                	test   %eax,%eax
   4:	74 10                	je     16 <foo+0x16>
   6:	c1 fe 10             	sar    $0x10,%esi
   9:	83 e6 07             	and    $0x7,%esi
   c:	83 fe 01             	cmp    $0x1,%esi
   f:	74 0f                	je     20 <foo+0x20>
  11:	83 fe 02             	cmp    $0x2,%esi
  14:	74 1a                	je     30 <foo+0x30>
  16:	f3 c3                	repz retq 
  18:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  1f:	00 
  20:	8b 47 04             	mov    0x4(%rdi),%eax
  23:	89 02                	mov    %eax,(%rdx)
  25:	c3                   	retq   
  26:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  2d:	00 00 00 
  30:	8b 47 08             	mov    0x8(%rdi),%eax
  33:	89 02                	mov    %eax,(%rdx)
  35:	c3                   	retq   


