Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeBFPSd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:18:33 -0500
Received: from sonic303-3.consmr.mail.bf2.yahoo.com ([74.6.131.42]:36534 "EHLO
        sonic303-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752026AbeBFPSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:18:24 -0500
X-YMail-OSG: Vfk05CAVM1lAp3ZCdyQrNJdevT0JacNcicfeIsIu98CrO1OsJ2wvWk.Fd_60Psb
 ALXUYyzTGtdGUyD7nklWcWRn1yLtKlBJIyA7FyORDaDFtuYWmDUOTduhYm9VRFiqy9Bu11WIuXpi
 Qh15LoT6FNYFTBJHW.KMNtiR00xRI8oHmH7pJQg66K6tuL11x3qFl3Jvhiega8KQyYYYYx2bEmDL
 D_s3LOUiFmHb4wT0ggv4lvzSj3gxbHUd6bIYqS6RvrR92CLndq8BW0.Ebx3OYHNxW_BLz55evP5E
 pAsbGZOVTPV8u30hjl0Sj0.b63dMv6uCGbL5F_4Q_P8NRkhsRODeJZjpcK2nNR235axrlqLItDHG
 7F0TVXii6WmZvXjFaHWYyQFm1.ttAEUul3k0Igb6sG6TBuBDrwyHvAP6uc1mRBiVqhf6e5eZN.Y.
 oLrdwRHezxbAwunha3p9.rGVElc.B4HX4GrIin5QEed_BuYjkVVpLHh2BQdG0l.aygHyXCfc1Lh2
 ocZ_RfxiLhdq_lUYY
Date: Tue, 6 Feb 2018 15:18:20 +0000 (UTC)
From: Denis Du <dudenis2000@yahoo.ca>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-ID: <431228126.4042690.1517930300853@mail.yahoo.com>
In-Reply-To: <m3r2qavz73.fsf@pm.waw.pl>
References: <751079597.1884905.1516121905374.ref@mail.yahoo.com> <751079597.1884905.1516121905374@mail.yahoo.com> <20180122.152513.1108868799788445512.davem@davemloft.net> <998451043.3408644.1516727290310@mail.yahoo.com> <m3r2qavz73.fsf@pm.waw.pl>
Subject: Re: [PATCH] Carrier detect ok, don't turn off negotiation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Mailer: WebService/1.1.11316 YMailNorrin Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w16FIb9Q018769



Hi, David:

How  do you think my patch?

As you see, Krzysztof  think my patch is ok to be accepted.

But if you have a better idea to fix it,I am glad to see it. Anyway, this issue have to be fixed.



Denis DU




On Sunday, January 28, 2018, 9:34:15 AM EST, Krzysztof Halasa <khc@pm.waw.pl> wrote: 





Denis Du <dudenis2000@yahoo.ca> writes:


>>From the above code, I can get that only Carrier have some change, it
> will restart the protocol by hdlc_proto_start(dev);and thus the timer,
> the previous timer expired due to protocol fail.
>
> If carrier keep no change by if (hdlc->carrier == on)
>         goto carrier_exit; /* no change in DCD line level */It will do
> nothing, not start any new protocol and thus the timer.


Sorry about being late, just returned home and am trying to get all the
backlogs under control.

I remember the PPP standard is a bit cloudy about the possible issue,
but the latter indeed exists (the PPP state machine was written directly
to STD-51). There is related (more visible in practice, though we aren't
affected) issue of "active" vs "passive" mode (hdlc_ppp.c is "active",
and two "passives" wouldn't negotiate at all).

Anyway the problem is real (though not very visible in practice,
especially on relatively modern links rather than 300 or 1200 bps dialup
connections) and should be fixed. Looking at the patch, my first
impression is it makes the code differ from STD-51 a little bit.
On the other hand, perhaps applying it as is and forgetting about the
issue is the way to go.

Ideally, I think the negotiation failure should end up (optionally, in
addition to the current behavior) in some configurable sleep, then
the negotiation should restart. If it's worth the effort at this point,
I don't know.

Perhaps I could look at this later, but no promises (this requires
pulling on and setting up some legacy hardware).

Anyway, since the patch is safe and can solve an existing problem:

Acked-by: Krzysztof Halasa <khc@pm.waw.pl>
-- 
Krzysztof Halasa
