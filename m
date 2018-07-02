Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB25C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7AB2476F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NdQN4USa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7AB2476F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeGBTAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:00:19 -0400
Received: from mail.efficios.com ([167.114.142.138]:59330 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753263AbeGBTAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:00:17 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 95B6422F6E9;
        Mon,  2 Jul 2018 15:00:16 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id kwKDPYS4CbHp; Mon,  2 Jul 2018 15:00:16 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0B86022F6E6;
        Mon,  2 Jul 2018 15:00:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0B86022F6E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530558016;
        bh=41l1hGE2RoKcMZcMG7RhGdM8b1xVU7R9dcFWpnmpsaE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NdQN4USayJOcw1c5WIZhiCL6tYwUZb8VP6NlS3n3iryjQYXWtnHSXkP1/wBYegeR3
         XiZkZu40Le/MhAApk3RSPiQ7NRyF7NkGBeobbgRIgU2fdHkqozJADaGdbkzs2nZ12M
         Ue+NFNuFjHO37dXftQ7ZXHqtvVLCJdlVhGJvaj9hulU+3md2MLY8WmBulfccEoFrCj
         inzTqm0dKVhx5s8cBKsoxpaO770IzU7M6uKRNAWnWlH33xdtV3HwiqtjjNdd1mjuKE
         jZNAPleCEQoTqLsw3HGRfDisxU2iB2ZBhu5Fn1zRirCgBXOdASeHzcewCiJ8avgC19
         hl8g6STXzv+cw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id aDfyeMwUnSqX; Mon,  2 Jul 2018 15:00:15 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id E29A822F6DA;
        Mon,  2 Jul 2018 15:00:15 -0400 (EDT)
Date:   Mon, 2 Jul 2018 15:00:15 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <84003252.10754.1530558015813.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrVeu_V-3K8OfKv9QixrWBJs+q866yb=e96sC76SS4hxYg@mail.gmail.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <CA+55aFwJWxsE_LL=-8WgB7uH_mYeMSu=boWF4N5KdOW673g4hA@mail.gmail.com> <247789350.9741.1530288432573.JavaMail.zimbra@efficios.com> <CA+55aFz8KyVqFsVnp-6g+thz7vmm5nK_FSdRTPSks7gsNVNRdQ@mail.gmail.com> <184287091.10022.1530301738384.JavaMail.zimbra@efficios.com> <CALCETrXqjrCoHX1KyL0iKGBaAZSGJb1cVdNN1gNigJ8DW9LF8w@mail.gmail.com> <1527399163.10673.1530541966296.JavaMail.zimbra@efficios.com> <CALCETrVeu_V-3K8OfKv9QixrWBJs+q866yb=e96sC76SS4hxYg@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are <
 TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: validate rseq_cs fields are < TASK_SIZE
Thread-Index: sMVSw2nYxUZ+cM/mhjRVRgdtPHn7Sg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 2, 2018, at 1:11 PM, Andy Lutomirski luto@amacapital.net wrote:
> 
> But I think that the limited solution of changing
> instruction_pointer_set() really is a sufficient
> architecture-dependent change to fully solve your problem.

So let me recap with the changes I gather for 4.18 and 4.19:

4.18:

* Change struct rseq_cs field types from LINUX_FIELD_u32_u64() to __u64 in
  uapi/linux/rseq.h,
* Compare rseq->rseq_cs->abort_ip with TASK_SIZE before using it. Kill offending
  process if its value is over TASK_SIZE,
* Explicitly check that padding of rseq->rseq_cs is zero on 32-bit kernels
  (#ifndef __LP64__).

4.19:

* Introduce instruction_pointer_set() with input validation, use it when setting
  IP to abort_ip in rseq. This replaces the comparison of abort_ip with TASK_SIZE.

Is that consistent with what you have in mind ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
