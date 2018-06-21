Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807ACC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D30B21486
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D30B21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933417AbeFUQNf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:13:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39196 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeFUQNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:13:34 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fW2Cz-0001Z2-GS; Thu, 21 Jun 2018 18:13:17 +0200
Date:   Thu, 21 Jun 2018 18:13:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v11 3/6] time: replace read_boot_clock64() with
 read_persistent_wall_and_boot_offset()
In-Reply-To: <20180620212700.29178-4-pasha.tatashin@oracle.com>
Message-ID: <alpine.DEB.2.21.1806211811060.1591@nanos.tec.linutronix.de>
References: <20180620212700.29178-1-pasha.tatashin@oracle.com> <20180620212700.29178-4-pasha.tatashin@oracle.com>
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

On Wed, 20 Jun 2018, Pavel Tatashin wrote:

> If architecture does not support exact boot time, it is challenging to
> estimate boot time without having a reference to the current persistent
> clock value. Yet, we cannot read the persistent clock time again, because
> this may lead to math discrepancies with the caller of read_boot_clock64()
> who have read the persistent clock at a different time.
> 
> This is why it is better to provide two values simultaneously: the
> persistent clock value, and the boot time.
> 
> Thus, we replace read_boot_clock64() with:
> read_persistent_wall_and_boot_offset(wall_time, boot_offset)
> 
> Where wall_time is returned by read_persistent_clock()
> And boot_offset is wall_time - boot time
> 
> We calculate boot_offset using the current value of local_clock() so
> architectures, that do not have a dedicated boot_clock but have early
> sched_clock(), such as SPARCv9, x86, and possibly more will benefit from
> this change by getting a better and more consistent estimate of the boot
> time without need for an arch specific implementation.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/arm/kernel/time.c      | 12 +-------
>  arch/s390/kernel/time.c     | 11 +++++--
>  include/linux/timekeeping.h |  3 +-
>  kernel/time/timekeeping.c   | 61 +++++++++++++++++++------------------

Please don't make that a wholesale patch. I surely indicated the steps
which are required and the steps can be done as separate patches easily,

Thanks,

	tglx
