Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A755ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECAB20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECAB20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeINP4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:56:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47476 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeINP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:56:34 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0lYY-0002LJ-Do; Fri, 14 Sep 2018 12:42:34 +0200
Date:   Fri, 14 Sep 2018 12:42:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yi Sun <yi.y.sun@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelly@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v1 2/3] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
In-Reply-To: <20180914090440.GB11769@yi.y.sun>
Message-ID: <alpine.DEB.2.21.1809141232260.1473@nanos.tec.linutronix.de>
References: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com> <1536830005-37260-3-git-send-email-yi.y.sun@linux.intel.com> <alpine.DEB.2.21.1809131307110.1473@nanos.tec.linutronix.de> <20180914090440.GB11769@yi.y.sun>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-176408337-1536921492=:1473"
Content-ID: <alpine.DEB.2.21.1809141238560.1473@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-176408337-1536921492=:1473
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1809141238561.1473@nanos.tec.linutronix.de>

On Fri, 14 Sep 2018, Yi Sun wrote:
> > > +static void hv_notify_long_spin_wait(void)
> > > +{
> > > +	u64 input = spin_wait_info | 0x00000000ffffffff;
> > 
> > What? The result is always 0x00000000ffffffff .....
> > 
> Oh, sorry for such error.
> 
> > > +	spin_wait_info++;
> > > +	hv_do_fast_hypercall8(HVCALL_NOTIFY_LONG_SPIN_WAIT, input);
> > > +}
> > > +
> > > +static void hv_qlock_kick(int cpu)
> > > +{
> > > +	spin_wait_info--;
> > 
> > Looking at the above this is completely pointless and I have no idea what
> > that variable is supposed to do.
> > 
> Per Microsoft Hypervisor Top Level Functional Specification, the input
> parameter of HVCALL_NOTIFY_LONG_SPIN_WAIT is defined as below:
> 
> SpinwaitInfo – Specifies the accumulated count the guest was spinning.
> 
> So, it is increased when guest is spinning and reduced when spinlock is
> released.

But that's a global variable, so it might be incremented and decremented by
several CPUs at once. I don't have the spec and have no time to study it
either, but global does not make any sense to me. The spin wait info comes
from a single guest CPU and the wakeup is targeted at that guest CPU as
well. So why global? It might be defined that way, but then you really want
to explain it proper.

Thanks,

	tglx


--8323329-176408337-1536921492=:1473--
