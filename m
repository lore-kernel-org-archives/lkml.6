Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDC3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DA220881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfA1Ig4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:36:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41165 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfA1Igz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:36:55 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1go2PU-0003EB-Ae; Mon, 28 Jan 2019 09:36:52 +0100
Date:   Mon, 28 Jan 2019 09:36:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        konrad.wilk@oracle.com, x86@kernel.org, srinivas.eeda@oracle.com,
        bp@suse.de, tim.c.chen@linux.intel.com, peterz@infradead.org,
        hpa@zytor.com
Subject: Re: [PATCH] x86/speculation: Update TIF_SPEC_IB before ibpb
 barrier
In-Reply-To: <0aa09e77-1454-9eaf-ef67-b00518e6f2d2@oracle.com>
Message-ID: <alpine.DEB.2.21.1901280934270.1622@nanos.tec.linutronix.de>
References: <48a105d3-fa32-40e4-9775-37d49f42eac0@default> <alpine.DEB.2.21.1901231335570.1628@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901251637480.1622@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901251858280.1622@nanos.tec.linutronix.de>
 <0aa09e77-1454-9eaf-ef67-b00518e6f2d2@oracle.com>
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

On Mon, 28 Jan 2019, Zhenzhong Duan wrote:
> On 2019/1/26 2:03, Thomas Gleixner wrote:
> > Bah, nonsense. Brain was clearly still out for lunch and I confused IBPB
> > and STIBP for a moment. cond_ibpb() is the thing issues in switch_mm() and
> > that is not leaving a stale MSR around because we only write to it when we
> > need the barrier. The bit is not stale because the barrier is only issued
> > with the write. The bit has not to be cleared.
> > 
> > So the only 'issue' what happens is that switch_to() either issues a
> > barrier too much or misses one. That's really not a problem.
> 
> Ok, yes, the purpose of this patch is to avoid the one missed barrier.

And that missed barrier is not worth it to do extra work in switch_to/mm
simply because it's a one off event and there is no way to exploit that
reliably.

Thanks,

	tglx
