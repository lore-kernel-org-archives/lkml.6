Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB28FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8124D21738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XKzfijqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfAJBix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:38:53 -0500
Received: from mail.efficios.com ([167.114.142.138]:42958 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfAJBix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:38:53 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A8B20B0A19;
        Wed,  9 Jan 2019 20:38:51 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id t4t5C14ljMoD; Wed,  9 Jan 2019 20:38:51 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3E643B0A12;
        Wed,  9 Jan 2019 20:38:51 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3E643B0A12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547084331;
        bh=13z99JCYWudhdbdFNt9pspv0ZHzH8UIAfO1+OTfP/pc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=XKzfijqDzh5BPukRi4DGSrrJyOhClKtcJcnCSeABs/2tEThrafDDAuZWOiG03GrGB
         x6wZo2rsnPF2Ms5L/YMBXnhxt/skGuA9Sx4xR6pOj6xHgRaGMBeYQztupIM+jWvK6L
         njn7IudRPvxZqgwmKCz+Fwf+j8RN+242xvOV2yDgZqi9I9FNe3b/Ps1hENW2QxPniY
         L+wa+3doT7fLQuUyh24KLFODt607x4nQkZiVzv95IXHwkzolbjtt6vCD+5Bq5c0Jjl
         62Zt7/3QpCJV4WiUZgB7FL+eLXQmbgK9L3nKaQDxKJT8cPU6XbkRdguNnoawuQgydV
         w1aX9TF2c4Jtg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id IJXMPDABKdVN; Wed,  9 Jan 2019 20:38:51 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 26F57B0A0B;
        Wed,  9 Jan 2019 20:38:51 -0500 (EST)
Date:   Wed, 9 Jan 2019 20:38:51 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>
Message-ID: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com>
Subject: Possible use of RCU while in extended QS: idle vs RCU read-side in
 interrupt vs rcu_eqs_exit
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Index: hxTKI2Xu74Wy4EXX1gypHP2vNvrAVg==
Thread-Topic: Possible use of RCU while in extended QS: idle vs RCU read-side in interrupt vs rcu_eqs_exit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I've had a user report that trace_sched_waking() appears to be
invoked while !rcu_is_watching() in some situation, so I started
digging into the scheduler idle code.

It appears that interrupts are re-enabled before rcu_eqs_exit() is
invoked when exiting idle code from the scheduler.

I wonder what happens if an interrupt handler (including scheduler code)
happens to issue a RCU read-side critical section before rcu_eqs_exit()
is called ? Is there some code on interrupt entry that ensures rcu eqs
state is exited in such scenario ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
