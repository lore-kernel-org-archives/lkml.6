Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D1BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058A62075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058A62075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbeIGThH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:37:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33150 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbeIGThH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:37:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86E8118A;
        Fri,  7 Sep 2018 07:55:50 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 575DB3F575;
        Fri,  7 Sep 2018 07:55:50 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7EEF31AE3828; Fri,  7 Sep 2018 15:56:05 +0100 (BST)
Date:   Fri, 7 Sep 2018 15:56:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: lib: use C string functions with KASAN enabled.
Message-ID: <20180907145605.GE12788@arm.com>
References: <20180906170534.20726-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906170534.20726-1-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 08:05:33PM +0300, Andrey Ryabinin wrote:
> ARM64 has asm implementations of memchr(), memcmp(), str[r]chr(),
> str[n]cmp(), str[n]len(). KASAN don't see memory accesses in asm
> code, thus it can potentially miss many bugs.
> 
> Ifdef out __HAVE_ARCH_* defines of these functions when KASAN is
> enabled, so the generic implementations from lib/string.c will be used.
> 
> Declare asm functions as weak instead of removing them because they
> still can be used by efistub.

I don't understand this bit: efistub uses the __pi_ prefixed versions of the
routines, so why do we need to declare them as weak?

Will
