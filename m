Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123A7C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35602087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35602087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbeGIIrP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:47:15 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:43887 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeGIIrO (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:9:1>);
        Mon, 9 Jul 2018 04:47:14 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Mon, 09 Jul 2018 02:47:13 -0600
Message-Id: <5B43210E02000078001D232B@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Mon, 09 Jul 2018 02:47:10 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     <pavel@ucw.cz>
Cc:     <davem@davemloft.net>, <mingo@elte.hu>,
        <herbert@gondor.apana.org.au>, "Ingo Molnar" <mingo@kernel.org>,
        <tglx@linutronix.de>, <rjw@rjwysocki.net>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        "Alok Kataria" <akataria@vmware.com>, <hpa@zytor.com>
Subject: Re: [PATCH v2] x86-64: use 32-bit XOR to zero registers
References: <5B39FF1A02000078001CFB54@prv1-mh.provo.novell.com>
 <20180704202934.GB15246@amd> <20180705071215.GA29659@gmail.com>
 <20180709083359.GB7312@amd>
In-Reply-To: <20180709083359.GB7312@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 09.07.18 at 10:33, <pavel@ucw.cz> wrote:
> Anyway, normally assembler is the one who chooses instruction
> encoding.

There are different possible views here, and I personally think that
while it is a compiler's job to chose optimal encodings, assemblers
shouldn't by default alter what the programmer (or compiler) has
specified, unless there are multiple encodings that are _entirely_
identical in effect, but which are _truly_ different encodings (and
presence/absence of instruction prefixes to me doesn't count as
"truly different"). This view is particularly on the basis that
assembly programmers often imply a certain encoding to be chosen,
be it just to imply size, or to go as far as meaning to run-time patch
code.

> xor %rax, %rax is equivalent to xor %eax, %eax; first variant is
> slower on some CPUs, second variant will take one extra byte due to
> operand size prefix IIRC...

The second variant is actually shorter by one byte.

> Should the assembler generate right
> variant according to the CPU type?

An "optimization" mode has recently been added to gas, but in general
as well as for the sake of older gas I don't think we should rely on this
new behavior (which is also off by default) except in cases where the
impact on the source code would be undesirable (as can e.g. be the
case when macro-izing things).

Jan


