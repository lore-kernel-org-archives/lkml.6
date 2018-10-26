Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BF7C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D189C20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D189C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeJZUzy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 16:55:54 -0400
Received: from dresden.studentenwerk.mhn.de ([141.84.225.229]:37610 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727507AbeJZUzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 16:55:54 -0400
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 42hNMR0HJgzMkw4;
        Fri, 26 Oct 2018 14:18:59 +0200 (CEST)
From:   Wolfgang Walter <linux@stwm.de>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, fw@strlen.de, steffen.klassert@secunet.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        christophe.gouault@6wind.com, gregkh@linuxfoundation.org
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec tunnels
Date:   Fri, 26 Oct 2018 14:18:58 +0200
Message-ID: <3245883.cYmPfsiBkz@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.18.12-041812-generic; KDE/4.14.13; x86_64; ; )
In-Reply-To: <20181025.103450.1966639999117342457.davem@davemloft.net>
References: <20181002213536.sgjansduqenps2md@breakpoint.cc> <2766296.15tpkxTHJV@stwm.de> <20181025.103450.1966639999117342457.davem@davemloft.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 25. Oktober 2018, 10:34:50 schrieb David Miller:
> From: Wolfgang Walter <linux@stwm.de>
> Date: Thu, 25 Oct 2018 11:38:19 +0200
> 
> > there is now a new 4.19 which still has the big performance regression
> > when
> > many ipsec tunnels are configured (throughput and latency get worse by 10
> > to 50 times) which makes any kernel > 4.9 unusable for our routers.
> > 
> > I still don't understand why a revert of the flow cache removal at least
> > for the longterm kernels is that a bad option (maybe as a compile time
> > option), especially as there is no workaround available.
> 
> You do know that the flow cache is DDoS targettable, right?
> 
> That's why we removed it, we did not make the change lightly.

Though this is true, we now have simply a permanent DDoS situation. The 
removal of the flow cache leads to the situation so that with enough ipsec-
tunnels you are now always as bad as you would have been prior under a DDoS 
attack.

This is not comparable to the routing cache situation where a fast, well 
tested solution already existed (for routes in a table; if you use a lot of 
rules for policy routing this may be a different story).

Futher I don't think that the DoS is that a strong argument for the removal of 
the routing cache if the routing performance would have dropped 10 times and 
more.

Also, the routing cache was even a problem with legitimate traffic, so I never 
had a problem with the moderate performance regression it caused here.

> 
> Adding a DDoS vector back into the kernel is not an option sorry.

All kernels >= 4.14 are in our use case as bad as if they were under attack. 
They are completely unusable and I even can't 

> 
> Please work diligently with Florian and others to try and find ways to
> soften the performance hit.
> 

I proposed to revert this for the longterm kernels and I only depending on a 
compile time option which explicitely had to be switched on. Then we could 
start using 4.19. People not using ipsec or who use it only with < 100 rules 
would still live without flow cache.

Regards,
-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
