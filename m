Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeBUDfq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 22:35:46 -0500
Received: from sonic311-15.consmr.mail.bf2.yahoo.com ([74.6.131.125]:33483
        "EHLO sonic311-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751180AbeBUDfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 22:35:44 -0500
X-YMail-OSG: 1lbsgXAVM1mtKYxP45Uuvu36wpPmlztzaFvx4k9QQ36CoeE621qgqtzf8CUF_bQ
 vJbdh_5TQltSiGSNOz24RCERVZ2Cr06aXT7CaiLLamnRxPeUfjBdmKD_ud_WyQegfqTK02iKArMo
 D3.g65FSpQ04nVMeqI3o8KYkwWYsleEYypcFy8QdQDRyOTdZQN4AYZNkA2XxRjeKRte9x9z4XCmS
 3Z6akWNA1B.v_1SneWhH9KshdB7d796eG5twO8ubAZtlO.xuV3sz7LBLGKdQ9kSnrigSNgSzrLEf
 H4N5jzPTApXJtMnruqQyt2jRruVhLdSB0p6pk3QfdQktnPg.lBr9s6aO86pLZWKIxazqc.0kOEN6
 R179h2jUFlSBAVVXHn_9Qtm9eOWxFFCvXa8oBQ_5eLz8ZuoGPlxGZQvQfB1PBxkAuWZBFx5aVbCB
 d4eubdmGLbBApjiYIoR_IldCvVEZKMalnorz3V5nz4PdY7aas1zTYoQgcLxLVi22B5RxVw0cl82A
 NEqzrFcv7hSDKSbXoeSpt
Date: Wed, 21 Feb 2018 03:35:31 +0000 (UTC)
From: Denis Du <dudenis2000@yahoo.ca>
To: David Miller <davem@davemloft.net>
Cc: <khc@pm.waw.pl>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-ID: <1603547691.2507241.1519184131708@mail.yahoo.com>
In-Reply-To: <2005408285.4065183.1517935842178@mail.yahoo.com>
References: <998451043.3408644.1516727290310@mail.yahoo.com> <m3r2qavz73.fsf@pm.waw.pl> <438911112.3985245.1517930128335@mail.yahoo.com> <20180206.102943.1688399898359622454.davem@davemloft.net> <2005408285.4065183.1517935842178@mail.yahoo.com>
Subject: Re: [PATCH] Carrier detect ok, don't turn off negotiation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Mailer: WebService/1.1.11419 YMailNorrin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36 Edge/16.16299
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1L3a5nr005435

Hi, David:

How  is your thinking about this patch?



>From b5902a4dfc709b62b704997ab64f31c9ef69a6db Mon Sep 17 00:00:00 2001 
From: Denis Du <dudenis2000@yahoo.ca> 
Date: Mon, 15 Jan 2018 17:26:06 -0500 
Subject: [PATCH] netdev: carrier detect ok, don't turn off negotiation 

Sometimes when physical lines have a just good noise to make the protocol 
handshaking fail, but the carrier detect still good. Then after remove of 
the noise, nobody will trigger this protocol to be start again to cause 
the link to never come back. The fix is when the carrier is still on, not 
terminate the protocol handshaking. 

Signed-off-by: Denis Du <dudenis2000@yahoo.ca> 
--- 
drivers/net/wan/hdlc_ppp.c | 5 ++++- 
1 file changed, 4 insertions(+), 1 deletion(-) 

diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c 
index afeca6b..ab8b3cb 100644 
--- a/drivers/net/wan/hdlc_ppp.c 
+++ b/drivers/net/wan/hdlc_ppp.c 
@@ -574,7 +574,10 @@ static void ppp_timer(struct timer_list *t) 
            ppp_cp_event(proto->dev, proto->pid, TO_GOOD, 0, 0, 
                     0, NULL); 
            proto->restart_counter--; 
-        } else 
+        } else if (netif_carrier_ok(proto->dev)) 
+            ppp_cp_event(proto->dev, proto->pid, TO_GOOD, 0, 0, 
+                     0, NULL); 
+        else 
            ppp_cp_event(proto->dev, proto->pid, TO_BAD, 0, 0, 
                     0, NULL); 
        break; 
-- 
2.1.4 





On ‎Tuesday‎, ‎February‎ ‎06‎, ‎2018‎ ‎12‎:‎06‎:‎43‎ ‎PM‎ ‎EST, Denis Du <dudenis2000@yahoo.ca> wrote: 







Ok, I submit it  again.


In drivers/net/wan/hdlc_ppp.c, some noise on physical line can cause the carrier detect still ok, but the protocol will fail. So if carrier detect ok, don't turn off protocol negotiation

This patch is against the kernel version Linux 4.15-rc8





On Tuesday, February 6, 2018, 10:29:53 AM EST, David Miller <davem@davemloft.net> wrote: 





From: Denis Du <dudenis2000@yahoo.ca>

Date: Tue, 6 Feb 2018 15:15:28 +0000 (UTC)

> How  do you think my patch?
> 
> As you see, Krzysztof  think my patch is ok to be accepted.
> But if you have a better idea to fix it,I am glad to see it. Anyway, this issue have to be fixed.


Please resubmit it and I'll think about it again, thank you.
