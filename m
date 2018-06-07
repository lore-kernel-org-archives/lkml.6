Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YNHTLCrNGFtoewAAmS7hNA
	; Thu, 07 Jun 2018 06:24:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 77664608B8; Thu,  7 Jun 2018 06:24:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E3A10607E7;
	Thu,  7 Jun 2018 06:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3A10607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeFGGYE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:24:04 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43837 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752880AbeFGGYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:24:01 -0400
Received: by mail-oi0-f65.google.com with SMTP id t133-v6so7547524oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 23:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=783nSWGh9m9PLif2Bx2byVwYnFxfXgJhIM02FCZye2k=;
        b=fdB2J5L4208quO8545rpFnfy4fY/2qnmaGLL38DJjEXO3Bi9fkTJS36gJm7sVo1ksa
         8PYeeR8SPBbyHK+0vnfiCv7r5Dlb7G+UMo6dAmJYYhqVKOC17aHYhI2cNVs6sDmWH9H+
         h4Gj3vHzvrb+qb6x0Lcb5Cx6ef41Gw9t3McOLT+JyuJlv5NzfhrpAMBGvllN8g/RiJxb
         E8rgPOOAZWoQ6wD7yf4M6gkPftoZUl0S1Si4j7Qgy/+ERAmpsQtibjgT+7OOZ54yvWaX
         lchXs5kiqwjCdhO98VGhJkIhvfybuW3h37BmvioB8BramuguJHyb6XUCk2+jzcNwtg6s
         wUYg==
X-Gm-Message-State: APt69E3uigi5kZVRFfPWYEb5O3NlUdqe+eEgWHCzg3f5ZY1HS4yqcSGI
        KreMkFZJoxHHMKH4WN2r9O0uD9Ts2Kiw8jpBrj1Reg==
X-Google-Smtp-Source: ADUXVKJi4eumRXXU8Lquc2zyUbreW3RnZef8CKcN8rnGwb2p7DsoNYZj5BpQXnpfG6XEcEsGxyVrTIxMllUpvFNeido=
X-Received: by 2002:aca:b184:: with SMTP id a126-v6mr260214oif.67.1528352640353;
 Wed, 06 Jun 2018 23:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180606193940.16126-1-malat@debian.org> <20180606195655.GO1351649@devbig577.frc2.facebook.com>
In-Reply-To: <20180606195655.GO1351649@devbig577.frc2.facebook.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 7 Jun 2018 08:23:44 +0200
Message-ID: <CA+7wUsw6DsKWzPKZxi0xA4YRiBASBDFF203RCuHSdWYWLyRPfQ@mail.gmail.com>
Subject: Re: [PATCH] percpu_counter: `percpu_counter_read_positive' should not
 return negative number
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennisszhou@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 9:57 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Jun 06, 2018 at 09:39:40PM +0200, Mathieu Malaterre wrote:
> > Since function `percpu_counter_add' may result in a signed integer overflow
> > the result stored in `fbc->count' could be negative. Make sure that
> > function `percpu_counter_read_positive' does not return a negative number
> > in this case. This will match behavior when CONFIG_SMP=y.
> >
> > Detected wth CONFIG_UBSAN=y
> >
> > [76404.888450] ================================================================================
> > [76404.888477] UBSAN: Undefined behaviour in ../include/linux/percpu_counter.h:136:13
> > [76404.888485] signed integer overflow:
> > [76404.888490] 9223308017647617321 + 76624449492175 cannot be represented in type 'long long int'
> > [76404.888501] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #50
> > [76404.888506] Call Trace:
> > [76404.888523] [dffedd30] [c0478b90] ubsan_epilogue+0x18/0x4c (unreliable)
> > [76404.888533] [dffedd40] [c0479530] handle_overflow+0xbc/0xdc
> > [76404.888548] [dffeddc0] [c0439044] cfq_completed_request+0x560/0x1234
> > [76404.888557] [dffede40] [c03f3fc4] __blk_put_request+0xb0/0x2dc
> > [76404.888570] [dffede80] [c05a81d0] scsi_end_request+0x19c/0x344
> > [76404.888579] [dffedeb0] [c05a9954] scsi_io_completion+0x4b4/0x854
> > [76404.888592] [dffedf10] [c04046b4] blk_done_softirq+0xe4/0x1e0
> > [76404.888605] [dffedf60] [c07ec1d4] __do_softirq+0x16c/0x5f0
> > [76404.888617] [dffedfd0] [c0065160] irq_exit+0x110/0x1a8
> > [76404.888629] [dffedff0] [c001646c] call_do_irq+0x24/0x3c
> > [76404.888641] [c0cdbe80] [c0009a2c] do_IRQ+0x98/0x1a0
> > [76404.888649] [c0cdbeb0] [c001b93c] ret_from_except+0x0/0x14
> > [76404.888659] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
> >                    LR = arch_cpu_idle+0x30/0x78
> > [76404.888667] [c0cdbf70] [c0cda000] 0xc0cda000 (unreliable)
> > [76404.888679] [c0cdbf80] [c00a3844] do_idle+0xc4/0x158
> > [76404.888687] [c0cdbfb0] [c00a3a90] cpu_startup_entry+0x24/0x28
> > [76404.888696] [c0cdbfc0] [c097f820] start_kernel+0x47c/0x490
> > [76404.888703] [c0cdbff0] [00003444] 0x3444
>
> So, the _positive versions are there to deal with small negative reads
> coming from percpu propagation delays.  It's not there to protect
> against actual counter overflow although it can't detect that on SMP.
> It's just outright wrong to report 0 when the counter actually
> overflowed and applying the suggested patch masks a real problem
> undetectable.

I see, thanks for the explanation.

> I think the right thing to do is actually undersatnding what's going
> on (why is a 64bit counter overflowing?) and fix the underlying issue.
>
> Thanks.
>
> --
> tejun
