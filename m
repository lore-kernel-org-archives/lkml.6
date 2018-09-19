Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C59AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0160C2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0160C2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbeISWgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:36:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33006 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732663AbeISWgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:36:12 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g2fmy-0006Od-6S; Wed, 19 Sep 2018 18:57:20 +0200
Date:   Wed, 19 Sep 2018 18:57:20 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [RFC PATCH 04/10 v2 ] x86/fpu: eager switch PKRU state
Message-ID: <20180919165719.iepvc7tg6aabp5mm@linutronix.de>
References: <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com>
 <20180914203501.qibhpmueosvkr74w@linutronix.de>
 <a239e97a-d1a1-388e-5db9-10758c33d702@redhat.com>
 <20180918142701.atfb4ul45k7tl6ew@linutronix.de>
 <7e9a13f3-93f5-fe4a-20d2-f4f9407bd43b@redhat.com>
 <83e271e1298d603c1105dd0dbea32d67da9cf1fa.camel@surriel.com>
 <36e8493f-f994-e885-8fe6-2f0d4a9904a1@redhat.com>
 <20180918160419.2zeru6xnufxixcax@linutronix.de>
 <11aa7d0f4ba36eff8b61a5dc1bd35ee5195fd576.camel@surriel.com>
 <c3492a53-74cd-4474-b664-f227ef37b7de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3492a53-74cd-4474-b664-f227ef37b7de@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-19 07:55:51 [+0200], Paolo Bonzini wrote:
> A kthread can do use_mm/unuse_mm.

indeed. The FPU struct for the kernel thread isn't valid / does not
contain the expected PKRU value. So loading the pkru value from the
struct FPU does not work as expected. We could set it to 0 for a kernel
thread so we don't end up with a random value.
If we want to get this usecase working then we would have to move pkru
value from FPU to mm_struct and consider it in use_mm(). Do we want
this?

> Paolo

Sebastian
