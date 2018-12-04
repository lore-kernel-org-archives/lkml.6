Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED42C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617DC20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617DC20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeLDMwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:52:15 -0500
Received: from foss.arm.com ([217.140.101.70]:59572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbeLDMwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:52:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7050C80D;
        Tue,  4 Dec 2018 04:52:14 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 40A143F59C;
        Tue,  4 Dec 2018 04:52:14 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7AD041AE10C5; Tue,  4 Dec 2018 12:52:34 +0000 (GMT)
Date:   Tue, 4 Dec 2018 12:52:34 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: Linux-next: Build failed
Message-ID: <20181204125233.GA1519@arm.com>
References: <CA+G9fYsvJkW5_hruVYzLX3g9_5scj9nnL240rOMQ+DSz70dqqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsvJkW5_hruVYzLX3g9_5scj9nnL240rOMQ+DSz70dqqQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Tue, Dec 04, 2018 at 05:56:09PM +0530, Naresh Kamboju wrote:
> FYI,
> 
> The Linux -next build failed due to below warnings/errors.
> 
> include/asm-generic/bitops/atomic.h: In function 'set_bit':
> include/asm-generic/bitops/atomic.h:17:2: error: implicit declaration
> of function 'atomic_long_or'; did you mean '__atomic_load_n'?
> [-Werror=implicit-function-declaration]
>   atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
>   ^~~~~~~~~~~~~~
>   __atomic_load_n

Ha, I like that the compiler is trying to get us to use its __atomic
builtins here :)

Anyway, you're seeing this because of this previous error in Mark's script:

.../scripts/atomic/atomic-tbl.sh: line 183: fold: command not found

even though fold is part of coreutils :/

Do you have grep? Maybe the diff below helps.

Will

--->8

diff --git a/scripts/atomic/atomic-tbl.sh b/scripts/atomic/atomic-tbl.sh
index 9d6be538a987..81d5c32039dd 100755
--- a/scripts/atomic/atomic-tbl.sh
+++ b/scripts/atomic/atomic-tbl.sh
@@ -180,7 +180,7 @@ gen_proto_variants()
 #gen_proto(meta, ...)
 gen_proto() {
        local meta="$1"; shift
-       for m in $(echo "${meta}" | fold -w1); do
+       for m in $(echo "${meta}" | grep -o .); do
                gen_proto_variants "${m}" "$@"
        done
 }

