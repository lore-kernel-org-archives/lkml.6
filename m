Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D366C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449B22418F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449B22418F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeFVL74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:59:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41292 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeFVL7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:59:55 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWKjB-0004Rz-2s; Fri, 22 Jun 2018 13:59:45 +0200
Date:   Fri, 22 Jun 2018 13:59:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 02/16] x86/split_lock: Handle #AC exception for split
 lock in kernel mode
In-Reply-To: <alpine.DEB.2.21.1806212301590.1591@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1806221334150.2402@nanos.tec.linutronix.de>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com> <1527435965-202085-3-git-send-email-fenghua.yu@intel.com> <alpine.DEB.2.21.1806212301590.1591@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Thomas Gleixner wrote:
> The whole thing is simply:
> 
> handle_ac()
> {
> 	if (user_mode(regs)) {
> 		 do_trap(AC, SIGBUS, ...);
> 	} else {
> 		disable_ac_on_local_cpu();
> 		WARN_ONCE(1);
> 	}
> }
> 
> That wants #AC enabled as early as possible so the kernel gets as much
> coverage as it can. If it trips in the kernel it's a bug and needs to be
> fixed and we can them fix ONE by ONE.

That said, #AC is just yet another badly defined and hastily bolted on
(mis)feature. This should have been:

  Bit A:	   Enable #AC if CPL < 3
  Bit B:	   Enable #AC if CPL == 3

But that would have been too useful and would allow sensible use of #AC
without creating software trainwrecks.

Aside of that the spec says:

  31 Disable LOCK# assertion for split locked access.

Can you pretty please make sure that this bit enforces #AC enable? If 31 is
ever set and such an access happens then the resulting havoc will takes
ages to decode.

That bit is also mentioned in the SDM with ZERO explanation why it exists
in the first place and why anyone would ever enable it and without a big
fat warning about the possible consequences. Can this pretty please be
fixed?

Thanks,

	tglx
