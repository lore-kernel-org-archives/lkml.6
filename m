Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AD5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888B320833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888B320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeKCE1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:27:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeKCE1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:27:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65B0A3001E72;
        Fri,  2 Nov 2018 19:18:38 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-27.ams2.redhat.com [10.36.116.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5629D1062249;
        Fri,  2 Nov 2018 19:18:16 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: Supporting core-specific instruction sets (e.g. big.LITTLE) with restartable sequences
References: <313542172.8.1541171544337.JavaMail.zimbra@efficios.com>
Date:   Fri, 02 Nov 2018 20:18:12 +0100
In-Reply-To: <313542172.8.1541171544337.JavaMail.zimbra@efficios.com> (Mathieu
        Desnoyers's message of "Fri, 2 Nov 2018 11:12:24 -0400 (EDT)")
Message-ID: <877ehvb85n.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 02 Nov 2018 19:18:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> Basically, the use-cases targeted are those where some cores on the
> system support a larger instruction set than others. So for instance,
> some cores could use a faster atomic add instruction than others,
> which should rely on a slower fallback. This is also the same story
> for reading the performance monitoring unit counters from user-space:
> it depends on the feature-set supported by the CPU on which the
> instruction is issued. Same applies to cores having different
> cache-line sizes.

The kernel needs to present a consistent view to userspace, the common
denominator.  I don't think there is any other way.

The situation is not new at all, by the way.  It also arises with VM and
process migration.  In glibc, we do not re-run CPU feature selection
upon resume (and how could we? function pointers would have to change),
and we have no plans to implement anything differently.

Thanks,
Florian
