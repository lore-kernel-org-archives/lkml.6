Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074E9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B8720657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IedkSYVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B8720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeKBFCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:02:19 -0400
Received: from mail.efficios.com ([167.114.142.138]:51224 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeKBFCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:02:19 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 448852482FE;
        Thu,  1 Nov 2018 15:57:54 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id EdxFZyWQrIt7; Thu,  1 Nov 2018 15:57:53 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BA5E02482F4;
        Thu,  1 Nov 2018 15:57:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BA5E02482F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1541102273;
        bh=I54LXg8G7Yu6uVetGBffLIwevssflFZPgNPEdsdiies=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IedkSYVVfsapo/dBsr4fWqNxN8ZADhwkW9AduVSIhXOFBEE92jelUSAX3R40e3D8d
         9PkpTiZrZWmTN4ciuC9upuPeDAS5icNjsDdJm0Gc4PRh3LXQGMkwMN9Xw9/8YayA2z
         XY2itCA7xk6wODk9Zwa4skBhG7JMPQVNsZXoRRBCkllvvQLU0mmL8eoETY0QpcfL3Y
         o3CIKKbVC9fZq5nZyuVGgpg+wKs1VwvytfYD0nHR9a81NgllnkuH8uhLFPgG9G36OE
         ZxTF/2w425SBPERSyZpTGwgAmUqYphQGziF0eZ2hMldxur/3W5/W0y8VR+Ho3R1aQV
         3+PXvfRjkxD+A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id pXf4ByOwEYnX; Thu,  1 Nov 2018 15:57:53 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 958582482E5;
        Thu,  1 Nov 2018 15:57:53 -0400 (EDT)
Date:   Thu, 1 Nov 2018 15:57:53 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>
Message-ID: <278477314.3995.1541102273591.JavaMail.zimbra@efficios.com>
In-Reply-To: <20181101144623.61d43102@gandalf.local.home>
References: <20181101095844.24462-1-mathieu.desnoyers@efficios.com> <20181101095844.24462-4-mathieu.desnoyers@efficios.com> <alpine.DEB.2.21.1811011320160.1642@nanos.tec.linutronix.de> <20181101144623.61d43102@gandalf.local.home>
Subject: Re: [RFC PATCH for 4.21 03/16] mm: Replace BUG_ON() by WARN_ON() in
 vm_unmap_ram()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: Replace BUG_ON() by WARN_ON() in vm_unmap_ram()
Thread-Index: aRy8zL1toyfw8/U3g76qqZpsB4Tqwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 1, 2018, at 7:46 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 1 Nov 2018 13:21:12 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
>> Mathieu,
>> 
>> On Thu, 1 Nov 2018, Mathieu Desnoyers wrote:
>> 
>> > It is encouraged to warn and return rather than use BUG_ON() when
>> > the condition can be recovered from in ways that are more graceful than
>> > halting the whole system.
>> 
>> You're failing to desribe how that graceful recovery works.
>> 
> 
> I think the graceful recovery is to simply return:
> 
>	if (WARN_ON(cond))
>		return;
> 
> is better than just
> 
>	BUG_ON(cond);
> 
> As that's what Linus made pretty clear at the Maintainer's Summit.

That's it. For an unmap function, this basically boils down to
print a warning and leak the memory on internal unmap error.

I will update the commit message describing this behavior.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
