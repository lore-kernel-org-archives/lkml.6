Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756830AbeEJJKl convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:10:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:57123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756699AbeEJJKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:10:38 -0400
Message-ID: <1525943427.8013.11.camel@gmx.de>
Subject: kernel spew from nouveau/ swiotlb
From: Mike Galbraith <efault@gmx.de>
To: nouveau <nouveau@lists.freedesktop.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ben Skeggs <bskeggs@redhat.com>
Date: Thu, 10 May 2018 11:10:27 +0200
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:208AdHrDNLAgdTF44umy1+aD6CoSizYPzq+N8NgCA3YCr8wM0cb
 VzR8F9hEIU2R2bu7ikEk8i67Gjm5W74F6xTk79ZdeJ5uCr1lQlxFOqnbNxjCZnyTOAbmMYm
 1YjhEDboKGiKcHqnM+6k1l7RWVaKyU4TngcizRRq7wJzKZTEfZuBf4DBnY0sT1BGCPygGVN
 AEw8eX2/YGI3zTYtJIQjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uztD/ORKjS4=:/qg0Z22yZAV4ooP8TNfbYt
 OQKudLgpVFnJSIBDNMxLpYtcNbOFc3DrJffmB1swqp4Qka20NSXjv8SE09Dc2327CITIm14HG
 f9ANeiVYJPL71+znVby0X5HsiB5GB1HVhB5zogiU5TDWQEJg2jYg7SErMuyGrmr59WYw1pt2w
 zkAO3oVGwhD3KTzoCsTIhz14/Q13YwIyP2DqVnTBRw+Jg7mTCXcvJT4+br5HtcozCXeYuN3cn
 sCdVD98rnquzoKQJYhd54ZfUjELx6rQGR2mZOO44Y0e5VpErZ7EXMBGBDoII2eIi7r4v4eV9j
 0YOOJN3slyK3MUnbRwN0596Wy4lhGX3ReqrcjziROnCDxJIftxjfJkoah0ciCFeBZqac0DdyL
 QEeEagdnzjyEDbpP8FrQZuaPQiiWzmEdw6uXYdC1QnjApouGZZCFwK+OQQBfcHAVUdCnf6LE6
 gtU/dk8J7guX8sQwn9+JkvpW/H6V3EZDyFSiWaPDlsNB2nyJ3faj8r/9vH8YtO2KiU2/UkJK6
 LGI7QOHelJtVTRY4sUi1+G1dg3iJPiPpDVbgd9lSPyZh3j6tZtInPHJtfKMxNUY6UHj125WFV
 w7pll2AVbp0Fg/QHvNMgGPD67xujHVsIeot09EmB6NuHO2Bn/iLRinctJlOWZf+TNlxwKfPtm
 pNNuhzz0fbQ5ITicIG4EP9Sg0ZvpVaie5CD1HgOe4lZaj7BqU6ig7gl/XvaKLibBt5+wJpGBw
 gQ+zyoSWC3i6P4s1UYUKZcap6pwG9ie+XlWPkO3ff8m0Z2sdRi7lhWsRjD3JCGQo/LFpVF/68
 dCmTovC
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

When box is earning its keep, nouveau/swiotlb grumble.. a LOT.  The
below is from master.today.

[12594.640959] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
[12594.693000] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
[12594.713787] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
[12594.743413] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
[12594.796740] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
[12607.000774] swiotlb_tbl_map_single: 54 callbacks suppressed
[12607.000776] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
[12607.347941] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
[12608.677038] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
homer:/novell/ssh # dmesg|grep 'swiotlb buffer is full'|wc -l
2052
homer:/novell/ssh # dmesg|grep 'callbacks suppressed'|wc -l
171

lib/swiotlb.c:
 573 not_found:
 574         spin_unlock_irqrestore(&io_tlb_lock, flags);
 575         if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 576                 dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);

Does nouveau perhaps want one of those DMA_ATTR_NO_WARN thingies?

	-Mike
