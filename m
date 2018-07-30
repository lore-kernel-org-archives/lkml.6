Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FFAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B61E20890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B61E20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbeG3VQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:16:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57318 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731927AbeG3VQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:16:09 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkE0z-0005wg-6K; Mon, 30 Jul 2018 21:39:33 +0200
Date:   Mon, 30 Jul 2018 21:39:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?J=FCrg_Billeter?= <j@bitron.ch>
cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prctl: add PR_[GS]ET_KILLABLE
In-Reply-To: <922baeb3d6d6387c480026fc3a6ca01d915f60a5.camel@bitron.ch>
Message-ID: <alpine.DEB.2.21.1807302138580.1725@nanos.tec.linutronix.de>
References: <20180730075241.24002-1-j@bitron.ch>         <20180730101659.GA24781@redhat.com> <922baeb3d6d6387c480026fc3a6ca01d915f60a5.camel@bitron.ch>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-788013628-1532979573=:1725"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-788013628-1532979573=:1725
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 30 Jul 2018, Jürg Billeter wrote:

> On Mon, 2018-07-30 at 12:17 +0200, Oleg Nesterov wrote:
> > On 07/30, Jürg Billeter wrote:
> > > 
> > > This is required for job control in a shell that uses CLONE_NEWPID for
> > > child processes.
> > 
> > Could you explain in more details?
> 
> The SIGNAL_UNKILLABLE flag, which is implicitly set for tasks cloned
> with CLONE_NEWPID, has the effect of ignoring all signals (from
> userspace) if the corresponding handler is set to SIG_DFL. The only
> exceptions are SIGKILL and SIGSTOP and they are only accepted if raised
> from an ancestor namespace.
> 
> SIGINT, SIGQUIT and SIGTSTP are used in job control for ^C, ^\, ^Z.
> While a task with the SIGNAL_UNKILLABLE flag could install handlers for
> these signals, this is not sufficient to implement a shell that uses
> CLONE_NEWPID for child processes:
> 
>  * As SIGSTOP is ignored when raised from the SIGNAL_UNKILLABLE process
>    itself, I don't think it's possible to implement the stop action in
>    a custom SIGTSTP handler.
>  * Many applications do not install handlers for these signals and
>    thus, job control won't work properly with unmodified applications.
> 
> Job control in a shell is just an example. There are other scenarios,
> of course, where applications rely on the default actions as described
> in signal(7), and PID isolation may be useful. In my opinion, the
> kernel support for preventing accidental killing of the "init" process
> should really be optional and this new prctl provides this without
> breaking backward compatibility.

This makes sense and exactly that information needs to be in the changelog.

Thanks,

	tglx
--8323329-788013628-1532979573=:1725--
