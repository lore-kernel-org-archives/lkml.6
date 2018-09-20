Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DCFECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F9820867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F9820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbeIUCFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:05:54 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:41276 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUCFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:05:53 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g35RA-0005Ly-MQ from joseph_myers@mentor.com ; Thu, 20 Sep 2018 13:20:32 -0700
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 20 Sep 2018 21:20:29 +0100
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1g35R6-0005Zu-MR; Thu, 20 Sep 2018 20:20:28 +0000
Date:   Thu, 20 Sep 2018 20:20:28 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH] glibc: Perform rseq(2) registration at nptl init
 and thread creation
In-Reply-To: <1619649568.9014.1537474457166.JavaMail.zimbra@efficios.com>
Message-ID: <alpine.DEB.2.21.1809202016270.17228@digraph.polyomino.org.uk>
References: <20180919144438.1066-1-mathieu.desnoyers@efficios.com> <alpine.DEB.2.21.1809191630260.26757@digraph.polyomino.org.uk> <67473000.8399.1537375994645.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1809191706090.26757@digraph.polyomino.org.uk>
 <1619649568.9014.1537474457166.JavaMail.zimbra@efficios.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018, Mathieu Desnoyers wrote:

> Are you saying glibc has an explicit check for the kernel version visible
> from /proc before using specific features ? If so, how can this work with
> the variety of feature backports we find in the distribution kernels out
> there ?

See sysdeps/unix/sysv/linux/dl-sysdep.c and 
sysdeps/unix/sysv/linux/dl-osinfo.h.  As I said, Carlos has proposed 
removing that check.

> For too-old headers at compile time, one possibility is that we don't event
> expose the __rseq_abi TLS symbol. OTOH, if we need to keep exposing it anyway
> for ABI consistency purposes, then we'd leave its cpu_id field at the initial
> value (-1). But that would require that we copy linux/rseq.h into the glibc
> source tree.

The ABI needs to be independent of the kernel headers used.  I don't think 
you need to copy linux/rseq.h; all you should need is to e.g. define an 
array of suitable size and alignment with the relevant member initialized 
and a suitable explanatory comment.

-- 
Joseph S. Myers
joseph@codesourcery.com
