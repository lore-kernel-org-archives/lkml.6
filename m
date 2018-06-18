Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DC4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C559820862
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C559820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755310AbeFRQLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:11:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37608 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754481AbeFRQLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:11:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54D411529;
        Mon, 18 Jun 2018 09:11:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAD0E3F25D;
        Mon, 18 Jun 2018 09:10:57 -0700 (PDT)
Date:   Mon, 18 Jun 2018 17:10:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com
Cc:     mingo@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>
Subject: Re: [PATCHv3 07/18] atomics: prepare for atomic64_fetch_add_unless()
Message-ID: <20180618161054.nez5trvedaz5qk7h@lakrids.cambridge.arm.com>
References: <20180618101919.51973-1-mark.rutland@arm.com>
 <20180618101919.51973-8-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618101919.51973-8-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:19:08AM +0100, Mark Rutland wrote:
> Currently architecture must implement atomic_fetch_add_unless(), with
> common code providing atomic_add_unless(). Architectures must also
> implement atmic64_add_unless() directly, with no corresponding
> atomic64_fetch_add_unless().
> 
> This divergenece is unfortunate, and means that the APIs for atomic_t,
> atomic64_t, and atomic_long_t differ.
> 
> In preparation for unifying things, with architectures providing
> atomic64_fetch_add_unless, this patch adds a generic
> atomic64_add_unless() which will use atomic64_fetch_add_unless(). The
> instrumented atomics are updated to take this case into account.

> +#ifdef arch_atomic64_fetch_add_unless
> +#define atomic64_fetch_add_unless atomic64_fetch_add_unless
> +static __always_inline int atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)

Whoops: s/int/s64/ here

I've fixed that up in my branch.

Thanks,
Mark.
