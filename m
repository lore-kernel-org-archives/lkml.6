Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D151FECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA4320867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA4320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeISBt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:49:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58650 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbeISBt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:49:27 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2MOu-0001sa-KW; Tue, 18 Sep 2018 22:15:12 +0200
Date:   Tue, 18 Sep 2018 22:15:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: [REVIEW][PATCH 01/20] signal: Simplify
 tracehook_report_syscall_exit
In-Reply-To: <20180918000546.12552-1-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182214380.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-1-ebiederm@xmission.com>
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

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> Replace user_single_step_siginfo with user_single_step_report
> that allocates siginfo structure on the stack and sends it.
> 
> This allows tracehook_report_syscall_exit to become a simple
> if statement that calls user_single_step_report or ptrace_report_syscall
> depending on the value of step.
> 
> Update the default helper function now called user_single_step_report
> to explicitly set si_code to SI_USER and to set si_uid and si_pid to 0.
> The default helper has always been doing this (using memset) but it
> was far from obvious.
> 
> The powerpc helper can now just call force_sig_fault.
> The x86 helper can now just call send_sigtrap.
> 
> Unfortunately the default implementation of user_single_step_report
> can not use force_sig_fault as it does not use a SIGTRAP si_code.
> So it has to carefully setup the siginfo and use use force_sig_info.
> 
> The net result is code that is easier to understand and simpler
> to maintain.
> 
> Ref: 85ec7fd9f8e5 ("ptrace: introduce user_single_step_siginfo() helper")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
