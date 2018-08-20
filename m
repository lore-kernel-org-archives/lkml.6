Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5BEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C88721531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C88721531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeHTSiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:38:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55789 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHTSiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:38:05 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1frm0D-00083Q-QY; Mon, 20 Aug 2018 17:21:57 +0200
Date:   Mon, 20 Aug 2018 17:21:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: [RFC PATCH ghak10 v4 0/2] audit: Log modifying adjtimex(2)
 calls
In-Reply-To: <20180820123818.27547-1-omosnace@redhat.com>
Message-ID: <alpine.DEB.2.21.1808201721350.1551@nanos.tec.linutronix.de>
References: <20180820123818.27547-1-omosnace@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018, Ondrej Mosnacek wrote:

+ Miroslav Lichvar

> Hi,
> 
> this patchset implements more detailed auditing of the adjtimex(2)
> syscall in order to make it possible to:
>   a) distinguish modifying vs. read-only calls in the audit log
>   b) reconstruct from the audit log what changes were made and how they
>      have influenced the system clock
> 
> The main motivation is to be able to detect an adversary that tries to
> confuse the audit timestamps by changing system time via adjtimex(2),
> but at the same time avoid flooding the audit log with records of benign
> read-only adjtimex(2) calls.
> 
> @John or other timekeeping/NTP folks: We had a discussion on the audit
> ML on which of the internal timekeeping/NTP variables we should actually
> log changes for. We are only interested in variables that can (directly
> or indirectly) cause noticeable changes to the system clock, but since we
> have only limited understanding of the NTP code, we would like to ask
> you for advice on which variables are security relevant.
> 
> Right now, the patchset is conservative and logs all changes that can be
> done via adjtimex(2):
>   - direct injection of timekeeping offset (obviously relevant)
>   - adjustment of timekeeping's TAI offset
>   - NTP value adjustments:
>     - time_offset (probably important)
>     - time_freq (maybe not important?)
>     - time_status (likely important, can cause leap second injection)
>     - time_maxerror (maybe not important?)
>     - time_esterror (maybe not important?)
>     - time_constant (???)
>     - time_adjust (sounds important)
>     - tick_usec (???)
> 
> Could you please give us some hints on the effect of changing these
> variables and whether you think that it is important to log their
> changes?
> 
> Thanks a lot!
> 
> 
> GitHub issue: https://github.com/linux-audit/audit-kernel/issues/10
> 
> Changes in v4:
>   - Squashed first two patches into one
>   - Rename ADJNTPVAL's "type" field to "op" to align with audit record
>     conventions
>   - Minor commit message editing
>   - Cc timekeeping/NTP people for feedback
> 
> v3: https://www.redhat.com/archives/linux-audit/2018-July/msg00001.html
> Changes in v3:
>   - Switched to separate records for each variable
>   - Both old and new value is now reported for each change
>   - Injecting offset is reported via a separate record (since this
>     offset consists of two values and is added directly to the clock,
>     i.e. it doesn't make sense to log old and new value)
>   - Added example records produced by chronyd -q (see the commit message
>     of the last patch)
> 
> v2: https://www.redhat.com/archives/linux-audit/2018-June/msg00114.html
> Changes in v2:
>   - The audit_adjtime() function has been modified to only log those
>     fields that contain values that are actually used, resulting in more
>     compact records.
>   - The audit_adjtime() call has been moved to do_adjtimex() in
>     timekeeping.c
>   - Added an additional patch (for review) that simplifies the detection
>     if the syscall is read-only.
> 
> v1: https://www.redhat.com/archives/linux-audit/2018-June/msg00095.html
> 
> Ondrej Mosnacek (2):
>   audit: Add functions to log time adjustments
>   timekeeping/ntp: Audit clock/NTP params adjustments
> 
>  include/linux/audit.h      | 21 ++++++++++++++++
>  include/uapi/linux/audit.h |  2 ++
>  kernel/auditsc.c           | 15 ++++++++++++
>  kernel/time/ntp.c          | 50 ++++++++++++++++++++++++++++++--------
>  kernel/time/timekeeping.c  |  3 +++
>  5 files changed, 81 insertions(+), 10 deletions(-)
> 
> -- 
> 2.17.1
> 
> 
