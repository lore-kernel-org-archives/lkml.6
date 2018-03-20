Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeCTIcj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:32:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCTIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:32:37 -0400
Date: Tue, 20 Mar 2018 09:32:35 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: "H.J. Lu" <hjl.tools@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] x86: Don't build vDSO with $(RETPOLINE_CFLAGS)
 -DRETPOLINE
In-Reply-To: <CAMe9rOoa81MC=oFW3coLuxha0pp6qdZowYR_o_my=n7ZXjVu=g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1803200912580.6506@nanos.tec.linutronix.de>
References: <CAMe9rOoa81MC=oFW3coLuxha0pp6qdZowYR_o_my=n7ZXjVu=g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H.J.

On Mon, 19 Mar 2018, H.J. Lu wrote:

Could you please send patches inline so reply has the patch in it for
review comments?

> vDSO code runs in userspace.  Don't compile it with retpoline.

I think this is a dangerous generalization. Just because code runs in user
space does not mean that it does not have to be compiled with retpoline.

You very much need retpolines in user space to prevent certain types of
inter process attacks. And disabling it in the VDSO gives a nice
predictable vector once the compiler decides to use a indirect jump table
for the clockid switch case.

So we rather keep retpoline enabled and let the build fail so we can
inspect why the compiler decided to convert something to indirect branches
and either annotate the function if it's not dangerous or modify the code
in a way that indirect branches are avoided.

The VDSO clock_gettime() implementation is one of the hottest code pathes
so we really have to think about it. Adding retpolines is going to hurt,
but just blindly dismissing them is wrong.

Thanks,

	tglx
