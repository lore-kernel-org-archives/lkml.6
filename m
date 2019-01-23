Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF298C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818B420870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfAWMpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:45:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34050 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfAWMpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:45:52 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gmHud-0000Qt-1C; Wed, 23 Jan 2019 13:45:47 +0100
Date:   Wed, 23 Jan 2019 13:45:46 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        konrad.wilk@oracle.com, x86@kernel.org, srinivas.eeda@oracle.com,
        bp@suse.de, tim.c.chen@linux.intel.com, peterz@infradead.org,
        hpa@zytor.com
Subject: Re: [PATCH] x86/speculation: Update TIF_SPEC_IB before ibpb
 barrier
In-Reply-To: <48a105d3-fa32-40e4-9775-37d49f42eac0@default>
Message-ID: <alpine.DEB.2.21.1901231335570.1628@nanos.tec.linutronix.de>
References: <48a105d3-fa32-40e4-9775-37d49f42eac0@default>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, Zhenzhong Duan wrote:

> When a task is set for updating TIF_SPEC_IB throuth SECCOMP by others
> and it's scheduled in the first time, a stale TIF_SPEC_IB value is
> picked in cond_ibpb(). This is due to TIF_SPEC_IB is updated later at
> __switch_to_xtra().
> 
> Add an extra call to speculation_ctrl_update_tif() to update it before
> IBPB barrier.

Errm. No. It adds that call to speculation_ctrl_update_tif() for every
mm switch, most of the time for nothing.

If at all, and we discussed that before and decided not to worry about it
(because it gets fixed up on the next context switch), then you want to
handle ibpb() from there:

        if (likely(!((tifp | tifn) & _TIF_SPEC_FORCE_UPDATE))) {
                __speculation_ctrl_update(tifp, tifn);
        } else {
                speculation_ctrl_update_tif(prev_p);
                tifn = speculation_ctrl_update_tif(next_p);

                /* Enforce MSR update to ensure consistent state */
                __speculation_ctrl_update(~tifn, tifn);

------> Force update IBPB

        }

Thanks,

	tglx
