Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5B6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E92F20578
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lYeTZT6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfAPROo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:14:44 -0500
Received: from mail.efficios.com ([167.114.142.138]:52774 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfAPROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:14:44 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C9B95B3A7F;
        Wed, 16 Jan 2019 12:14:42 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id HkSffJ_jyUJ4; Wed, 16 Jan 2019 12:14:42 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 39732B3A7B;
        Wed, 16 Jan 2019 12:14:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 39732B3A7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547658882;
        bh=vvsdTaiHhAXezOQzySRhTcUST6JnGZMuNuPJr0PnxVA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lYeTZT6hnVgoY3zMNuxvQy9XEF4qRHD739QpYYmHUxWuefqYH9pOqPzntO0Ij7r4Q
         es4/IZZowvlet7uOzCJ0SHvAdJPo3c9d1oXBCRFgL/rSdxsHlZNtLxXy1jJi6+cv+z
         shX25IYvc2ZD0hSJa0DB2Cy71Uo3v2hxpIeXwQ3DLV65hZg21e88AbJUU+tu117nDK
         QDTAmVU/43LLaye2Lj6KXMlFytkvXYrS4huXCICM2Wb2kC3HopcqQv5sNTi67BuLU0
         6pTsX90lBr7jWAwudLix7NNzhsOeO7TPoDl44fA8vu4Zn4AiT6zv2h0FMq+lNc6In+
         8fDZCTwScpY1w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 7WUEYyawWg11; Wed, 16 Jan 2019 12:14:42 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 22521B3A73;
        Wed, 16 Jan 2019 12:14:42 -0500 (EST)
Date:   Wed, 16 Jan 2019 12:14:41 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Paul Turner <pjt@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1584600558.1675.1547658881995.JavaMail.zimbra@efficios.com>
Subject: Adaptative busy spinning with rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Index: J3qJ+PBbrDR6J4FErmtvrwEYr2/KHw==
Thread-Topic: Adaptative busy spinning with rseq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

A follow up on the Edinburgh discussion I had with Daniel: I did a prototype
implementation of adaptative busy spinning with rseq. It only uses current
upstream rseq features. It's not optimized at this stage (and I don't have time to
work more on it at the moment), and it's only x86-64, but I'm throwing the code out
there for feedback:

https://github.com/compudj/rseq-test/blob/adapt-lock/test-rseq-adaptative-lock.c

The trick here is to rely on the Zero Flag being invariant for a sub-section of
the rseq critical sections, and use it to figure out if it has been aborted
after cmpxchg has succeeded. Testing the Zero Flag on abort basically removes the
rseq requirement that the very last instruction of a rseq critical section needs
to be the "commit" instruction, allowing us to cover an entire loop within a rseq
critical section.

Feedback is welcome!

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
