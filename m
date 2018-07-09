Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D91C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655D32089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="T4Lv02w3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655D32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934089AbeGISTX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:19:23 -0400
Received: from mail.efficios.com ([167.114.142.138]:54712 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933804AbeGISTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:19:20 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 09C0122DE36;
        Mon,  9 Jul 2018 14:19:20 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id f1sMCcJRevd0; Mon,  9 Jul 2018 14:19:19 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A40E822DE33;
        Mon,  9 Jul 2018 14:19:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A40E822DE33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531160359;
        bh=uxtrlg9yJh8Dm5InNagtlfCbvwqprH/0APACDExG+Dw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=T4Lv02w306q9YTbr9Iu6I7JyIULkjvEq/YovMiZBVQunKFuk9IawLmboHgDtVcu8y
         O60hY3cWx8eujpKsHlE/ccdlxaua7SatGzFhQ/lDS5tq+LP7zQRAARM8NeW0+GPNPN
         SvC3QwkqjQCMhw9TTdjeHRFZqff6x7lV0mFyAty8bzGVEiJ8SWKJaG7DI8H4k98rux
         YVMbAwGjQGdPLVho3FH6xnA+2cwJVAh2uOXEu7ijJDEL3AKiqdvmPCxmMUZWp0J7N3
         TD6rO+cRKlSigc5zF8/HenOg0YT6RpAWUGVNf4jxA8qxrI3eLoRaAEjesEAhnOHY3J
         uUqO9baQjGIgw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id aatk5hLiKMq3; Mon,  9 Jul 2018 14:19:19 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 8868C22DE29;
        Mon,  9 Jul 2018 14:19:19 -0400 (EDT)
Date:   Mon, 9 Jul 2018 14:19:19 -0400 (EDT)
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
        Joel Fernandes <joelaf@google.com>,
        Andrew Hunter <ahh@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <1519037424.2393.1531160359475.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFzpjA3r9HdfCU5LrEhSt6S=+RfKuJ2GVc8Wv5Hz-_Me8Q@mail.gmail.com>
References: <20180708210330.27324-1-mathieu.desnoyers@efficios.com> <20180708210330.27324-3-mathieu.desnoyers@efficios.com> <854203778.2272.1531157327328.JavaMail.zimbra@efficios.com> <CA+55aFzpjA3r9HdfCU5LrEhSt6S=+RfKuJ2GVc8Wv5Hz-_Me8Q@mail.gmail.com>
Subject: Re: [PATCH for 4.18 2/6] rseq: use get_user/put_user rather than
 __get_user/__put_user
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use get_user/put_user rather than __get_user/__put_user
Thread-Index: OuIzqNIgBMQUDD8FPq1UZ6kvWHaB1g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 9, 2018, at 2:04 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Mon, Jul 9, 2018 at 10:28 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> So, another twist to this story: ppc32 does not implement u64 get_user().
> 
> I was going to say that "that's not possible", since we actually have
> 64-bit arguments at least in the form of "loff_t __user *".
> 
> But when I started looking, it turns out that yeah, we do
> "copy_from_user()" on them, and instead made the x86 copy_from_user()
> have special cases for constant sizes.
> 
> So a 8-byte copy_from_user() is fine. It ends up being a "get_user()"
> on x86 anyway.

Given that this memory area has already been checked with access_ok()
on rseq registration, are you fine with leaving
__get_user/__put_user/__copy_{from,to}_user in place so we do the
minimal change at this stage of rc, or should I go ahead and replace
the lot with get_user/put_user/copy_{from,to}_user ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
