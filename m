Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E1C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A392086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A392086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeIJPbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:31:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38935 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeIJPbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:31:39 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzJa4-0005NV-Ev; Mon, 10 Sep 2018 12:38:08 +0200
Date:   Mon, 10 Sep 2018 12:38:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Matt Rickard <matt@softrans.com.au>,
        Florian Weimer <fweimer@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
In-Reply-To: <alpine.DEB.2.21.1809092159440.1402@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1809101235150.1402@nanos.tec.linutronix.de>
References: <20180901015935.CCF0B18E20A9@virtux64.softrans.com.au> <CALCETrU4PzskO9pE6G4EkXNRRX3Mu7Vvjv1P8XgrfRMdgGDZSg@mail.gmail.com> <alpine.DEB.2.21.1809092159440.1402@nanos.tec.linutronix.de>
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

On Sun, 9 Sep 2018, Thomas Gleixner wrote:
>  #ifdef BUILD_VDSO32_64
>  typedef u64 gtod_long_t;
>  #else
>  typedef unsigned long gtod_long_t;
>  #endif
> +
> +struct vgtod_ts {
> +	gtod_long_t	sec;

and actually this wants to become u64 unconditionally as we need to provide
the full seconds even on 32bit for the upcoming y2038 support. We still
have to truncate it for the current 32bit interface, but the core code
can be made ready now.

Thanks,

	tglx
