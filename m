Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEEFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E51220659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E51220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeIGDTv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:19:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeIGDTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:19:51 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 596A8D0A;
        Thu,  6 Sep 2018 22:42:09 +0000 (UTC)
Date:   Thu, 6 Sep 2018 15:42:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] prctl: add PR_[GS]ET_KILLABLE
Message-Id: <20180906154208.24f397896957116d1a644a3b@linux-foundation.org>
In-Reply-To: <20180803144021.56920-2-j@bitron.ch>
References: <20180730075241.24002-1-j@bitron.ch>
        <20180803144021.56920-1-j@bitron.ch>
        <20180803144021.56920-2-j@bitron.ch>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Aug 2018 16:40:21 +0200 Jürg Billeter <j@bitron.ch> wrote:

> PR_SET_KILLABLE clears the SIGNAL_UNKILLABLE flag. This allows
> CLONE_NEWPID tasks to restore normal signal behavior, opting out of the
> special signal protection for init processes. This prctl does not allow
> setting the SIGNAL_UNKILLABLE flag, only clearing.
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
>    itself, it's not possible to implement the stop action in a custom
>    SIGTSTP handler.
>  * Many applications do not install handlers for these signals and
>    thus, job control won't work properly with unmodified applications.
> 
> There are other scenarios besides job control in a shell where
> applications rely on the default actions as described in signal(7) and
> PID isolation may be useful. This new prctl makes the signal protection
> for "init" processes optional, without breaking backward compatibility.

This one is above my pay grade.  Eric & Oleg: could you please provide
input?

