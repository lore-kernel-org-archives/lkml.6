Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E8DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240042146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240042146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbeLCTWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:22:13 -0500
Received: from foss.arm.com ([217.140.101.70]:45916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbeLCTWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:22:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3B9E1688;
        Mon,  3 Dec 2018 11:22:08 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3DDC3F575;
        Mon,  3 Dec 2018 11:22:08 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id CE1721AE1062; Mon,  3 Dec 2018 19:22:28 +0000 (GMT)
Date:   Mon, 3 Dec 2018 19:22:28 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
Message-ID: <20181203192228.GC29028@arm.com>
References: <20181130150956.27620-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130150956.27620-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On Fri, Nov 30, 2018 at 04:09:56PM +0100, Anders Roxell wrote:
> Both of those functions end up calling ftrace_modify_code(), which is
> expensive because it changes the page tables and flush caches.
> Microseconds add up because this is called in a loop for each dyn_ftrace
> record, and this triggers the softlockup watchdog unless we let it sleep
> occasionally.
> Rework so that we call cond_resched() before going into the
> ftrace_modify_code() function.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm64/kernel/ftrace.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

It sounds like you're running into issues with the existing code, but I'd
like to understand a bit more about exactly what you're seeing. Which part
of the ftrace patching is proving to be expensive?

The page table manipulation only happens once per module when using PLTs,
and the cache maintenance is just a single line per patch site without an
IPI.

Is it the loop in ftrace_replace_code() that is causing the hassle?

Will
