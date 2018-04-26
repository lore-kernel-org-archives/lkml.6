Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeDZHEh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:04:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:43597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753748AbeDZHEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:04:32 -0400
Message-ID: <1524726236.7572.1.camel@gmx.de>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and
 clock BOOTTIME
From: Mike Galbraith <efault@gmx.de>
To: Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: John Stultz <john.stultz@linaro.org>, Genki Sky <sky@genki.is>,
        David Herrmann <dh.herrmann@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Date: Thu, 26 Apr 2018 09:03:56 +0200
In-Reply-To: <alpine.DEB.2.21.1804251502310.2082@nanos.tec.linutronix.de>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com>
         <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de>
         <1996930.B4PaKZ6i1F@aspire.rjw.lan> <1858767.c2KKoU8fl2@aspire.rjw.lan>
         <alpine.DEB.2.21.1804251502310.2082@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TxWew2Js708ishd5+6OqTG0Zr21QOsMuxvAeMeW0KMELa/wqJxT
 4jSq0wavXtV9LRzcI7vCspRPzQI/gAVHjjmF4qM4m0qoTIkLv5tVywUNFewVR52U6Y/BzvT
 u59NiRJrdmwOwTBDnIlbwRS098ZBaH2l1/r0azND+ceEYknAuRTzXOtk/Mjy4pTc8Fz8naG
 VE11uaua6IUexX2hfrqew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iMqWPdqgjAg=:7S5AOArBLSUOGREKFUJ+HT
 2l7lj32cBweafnIuFAy7DNCBVA1YIRV9PrJ423/O6AxoCW4P6GIgka5wXtuB5g2GsLtnbrnuB
 tBYEcb6cmK1A3M7nHItViYw7e6m81/eItA+X5eCpHDwOm+4xTGgrzave+ivrk1cz3Ziq2KAAB
 UZAieuFtP5tPRBdL0Ut5Ol5RY0eNDbsomNzgBcIY3e0YfGgXP17ogjlRgOnI8G7nAWaWqwonm
 I/JsnAbEwjHPbE6Hca24W0ex0BB68Z+jAeEf7rdTnTV93tF/bwZO3DvPQy7YgeWNVX4O8Rd5y
 8175aSf1KAWcURjsI2cH02UUx7K0jQTS2TNiofO32hldgI7/tASmWhi+Zw8qNiHk09VKz/nlt
 /tJddidO8mmqCkNMxBtk7UKcbwySFxw7MpEn/juGsb1XjHDnJbKY74VTdAXIxMJXz4Q7endJX
 VJHgdERSbSNJEDJm07WgTg0/CZM7mPFph+bixYtZq8gg9ENBYwOueUPJIt25j0eh4RCGsCgIn
 SlOMi4bg5z7Hg/EBpO9n2JQ9FNCzuX7D1qG19zju1XjOhWrb+jo8FEcT19wx4gv0yZCI1x0e5
 B14Cg4cz2QNyi2ddOWJcLIr+KFm+OGWaxqIp1q/eWDT9/TvdAmojODsWsxIAC4pcCShiCISIk
 HDsTPiJJuSbWuFBKadYZPFKrsLjjL2E3d+H9OUIlVtsuNNu6TU3DrPsWfz8/u3NQO3Tt8qtDY
 +dH8oA9nbyKwA4fZXMfOemG8zFPVm0jvtntFS9PByHnNE/ssqJeSk7+Lmqoj4qE7jFlzSLDNT
 cp05yKRlxv3CGpOCIkhc8MeiocVz7xamHanZuXG2MVgAAA7P1M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 15:03 +0200, Thomas Gleixner wrote:
> Right, it does not matter. The real interesting one is d6ed449afdb3.

FWIW, three boxen here suspend/resume fine, but repeatably exhibit the
below after a very few minute suspend, and a short bisect fingered your
suspect.  Distro is opensuse 42.3.

[  211.113902] Restarting tasks ... done.
[  211.114817] PM: suspend exit
[  212.312993] systemd-journald[7266]: File /var/log/journal/016627c3c4784cd4812d4b7e96a34226/system.journal corrupted or uncleanly shut down, renaming and replacing.
[  212.313363] systemd-coredump[7264]: Detected coredump of the journal daemon itself, diverted to /var/lib/systemd/coredump/core.systemd-journal.0.0aa39276decf4f1ab6fda3464e31f9dd.582.1524720954000000.
