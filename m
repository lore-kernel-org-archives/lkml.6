Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264F6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDEA223B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="E35/LRHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDEA223B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934967AbeGFTfp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:35:45 -0400
Received: from mail.efficios.com ([167.114.142.138]:46452 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934617AbeGFTfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:35:42 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3EB321C1407;
        Fri,  6 Jul 2018 15:35:42 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id vXbN0YTZR13W; Fri,  6 Jul 2018 15:35:41 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D77CB1C1404;
        Fri,  6 Jul 2018 15:35:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D77CB1C1404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530905741;
        bh=H27Xr6V1rq2eLzcePxU2am0SaGYkRzqh368EyymiS4E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=E35/LRHLlo34jgAHKHZzcBx7dn5NbLdJM2YJta4EsEyG4ALZj+CAWhyy8UC9NUUlW
         kkY8Yywe64B0dz5v+Z24SF4CofDbEUftkN6tpdszsVzpT6olDxXsg/eObIpeuCNJ3/
         s9MXAOzlDmA+WNJ1/bb2c9C+YVzY6hFBbcQ0sKo5y2H3C4HHvKxwjuPBnPEANWcP1H
         P+T/PFLeW6gO/q9YozJ+yHrmY8uYYWU2YVqRu4xtbBurmDv9vLCyXpgsTEQUgC/1ie
         v2yqRBEQkHXAEIAONTmg7Eyy3C//UdBpyCiwq8CM8yLE5rqWhz6Fan32JiS9RvcPjS
         qzrbQnfBNYflQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id UWAtWQLSgeFm; Fri,  6 Jul 2018 15:35:41 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id BDA7C1C13FE;
        Fri,  6 Jul 2018 15:35:41 -0400 (EDT)
Date:   Fri, 6 Jul 2018 15:35:41 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
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
Message-ID: <1913049637.1366.1530905741745.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFzz1CC6son0T2nD-Yqhy0_yC5nBer2XSH9kqe5x3N26Ug@mail.gmail.com>
References: <20180705180601.18423-1-mathieu.desnoyers@efficios.com> <20180705180601.18423-4-mathieu.desnoyers@efficios.com> <1846432971.1245.1530892973439.JavaMail.zimbra@efficios.com> <436937568.1359.1530905019620.JavaMail.zimbra@efficios.com> <CA+55aFzz1CC6son0T2nD-Yqhy0_yC5nBer2XSH9kqe5x3N26Ug@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 3/5] rseq: uapi: declare rseq_cs field as
 union, update includes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: uapi: declare rseq_cs field as union, update includes
Thread-Index: JrPvCxuCl8CoGjfD9J8mi9cMcDM8Sw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 6, 2018, at 3:31 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Fri, Jul 6, 2018 at 12:23 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> For -rc, I would favor the following simpler approach. Or I could even
>> just use get_user() instead. Thoughts ?
> 
> Please just use "get_user()".
> 
> In fact, we should be thinking seriosly about just removing
> __get_user() entirely. It's wrong. It optimizes the wrong thing
> entirely. It _used_ to be that the range check was noticeable, and it
> really isn't any more. These days the expensive parts are the SMAP
> costs, and both get_user() and __get_user() have those, except
> get_user() is safer and doesn't waste I$ on inlining the code to
> disable and re-enable SMAP.

Will do, thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
