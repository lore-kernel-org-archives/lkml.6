Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76842070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfANThM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:37:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfANThM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:37:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFC6B8831D;
        Mon, 14 Jan 2019 19:37:11 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-20.ams2.redhat.com [10.36.116.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5F4A4503;
        Mon, 14 Jan 2019 19:37:03 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at nptl init and thread creation (v4)
References: <20181204192141.4684-1-mathieu.desnoyers@efficios.com>
        <87h8fkz6qx.fsf@oldenburg2.str.redhat.com>
        <1681283664.1380.1547152315426.JavaMail.zimbra@efficios.com>
        <87fttv9iic.fsf@oldenburg2.str.redhat.com>
        <394676913.486.1547493757710.JavaMail.zimbra@efficios.com>
Date:   Mon, 14 Jan 2019 20:37:01 +0100
In-Reply-To: <394676913.486.1547493757710.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Mon, 14 Jan 2019 14:22:37 -0500
        (EST)")
Message-ID: <87y37n8202.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 14 Jan 2019 19:37:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Jan 14, 2019, at 10:55 AM, Florian Weimer fweimer@redhat.com wrote:
>
>> * Mathieu Desnoyers:
>> 
>>> Therefore, both symbols will end up in
>>> sysdeps/unix/sysv/linux/Versions.
>> 
>> I'm not sure what you mean by that.  The physical location in the
>> directory tree has little effect on which shared object the symbol is
>> placed in; that will need other changes.
>
> I'm currently moving the symbol definitions to csu/rseq-sym.c. On Linux,
> its content is overridden by a new sysdeps/unix/sysv/linux/rseq-sym.c
> which contains both __rseq_abi and __rseq_refcount symbols. On other
> platforms, it is a stub file.

You don't need a stub file if you use the “ifeq ($(subdir),csu)”
construct.

The other question is whether this belongs into the csu subdirectory.
Since TLS is not available in ld.so, the initialization would have to
happen rather late, after relocation, but before ELF constructors are
run.

(A side effect is that the rseq area would not be usable from IFUNC
resolvers.)

Thanks,
Florian
