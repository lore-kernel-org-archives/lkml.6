Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49499C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00565208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00565208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbeHAM3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:29:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387462AbeHAM3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:29:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DAA781663F3;
        Wed,  1 Aug 2018 10:44:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.32.181.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62BC4215670D;
        Wed,  1 Aug 2018 10:44:22 +0000 (UTC)
Message-ID: <225373e97b42e0e5ee6210b329f0bbb94055b651.camel@redhat.com>
Subject: Re: AW: AW: PROBLEM: Kernel Oops in UDP stack
From:   Paolo Abeni <pabeni@redhat.com>
To:     Marcel Hellwig <mhellwig@mut-group.com>,
        'Eric Dumazet' <eric.dumazet@gmail.com>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>,
        "'andrew@lunn.ch'" <andrew@lunn.ch>
Cc:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Matthias Wystrik <mwystrik@mut-group.com>
Date:   Wed, 01 Aug 2018 12:44:22 +0200
In-Reply-To: <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
         <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
         <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
         <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
         <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 01 Aug 2018 10:44:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 01 Aug 2018 10:44:27 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pabeni@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 10:35 +0000, Marcel Hellwig wrote:
> > > [<c0228adc>] (udp_recvmsg+0x284/0x33c) from [<c02306e0>] (inet_recvmsg+0x38/0x4c): net/ipv4/udp.c:1234
> > 
> >              sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
> > 
> > Unaligned access trap (virtual address c14fe63a), so either sin or ip_hdr(skb) are not on a 32bit alignment
> > 
> > Can you produce the disassembly of the trapping instruction ?
> 
> https://gist.github.com/hellow554/6b11c6c0827d5db80a7e66f71f5636ff#file-net_uipv4_udp-lst-L1892-L1895
> 
> 		sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
> c0228ad8:	e5943080 	ldr	r3, [r4, #128]	; 0x80
> c0228adc:	e593300c 	ldr	r3, [r3, #12]
> c0228ae0: 	e5823004	str	r3, [r2, #4]

I *think* pskb_trim_rcsum() in __udp4_lib_rcv() can copy the ipv4
header to an unaligned address, for cloned skbs. If I understood
correctly the relevant socket is a mcast one, so cloned skbs can land
there.

Paolo

