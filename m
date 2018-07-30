Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB38CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9370220857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9370220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeG3Xt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:49:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57813 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeG3XtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:49:25 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkGOf-000820-Gu; Tue, 31 Jul 2018 00:12:09 +0200
Date:   Tue, 31 Jul 2018 00:12:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Shier <pshier@google.com>
cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH] proc: added ept_ad flag to /proc/cpuinfo
In-Reply-To: <20180730211254.173686-1-pshier@google.com>
Message-ID: <alpine.DEB.2.21.1807302342570.1725@nanos.tec.linutronix.de>
References: <20180730211254.173686-1-pshier@google.com>
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

On Mon, 30 Jul 2018, Peter Shier wrote:

> Subject: [PATCH] proc: added ept_ad flag to /proc/cpuinfo

The 'proc:' prefix is misleading here. x86/cpufeatures is the right
choice. The /proc/cpuinfo display is a side effect.

Also please avoid 'added'. Changelogs should be written in imperative
mood. Something like this:

 x86/cpufeatures: Add EPT_AD feature bit
 
> The Intel Haswell architecture has an EPT feature whereby the access &
> dirty bits in EPT entries are updated without taking a guest exit.

Why would this be Haswell specific?

Aside of that I don't see what this has to do with exits. From the SDM:

  " * If bit 21 is read as 1, accessed and dirty flags for EPT are
      supported (see Section 28.2.4)"

And nothing in 28.2.4 says anything about exits. It's all about whether the
feature is supported or not. If it is supported it can be enabled in EPTP.

> This patch adds the "ept_ad" flag to /proc/cpuinfo if this feature is
> available.

See Documentation/process/submitting-patches.rst and search for 'This
patch'.

The other question is why is this new feature bit not used in the VMX code?
It needs to be checked to enable the AD bit in EPTP ....

Thanks,

	tglx
