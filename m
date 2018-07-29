Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039A6C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 04:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE01520870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 04:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+ol9vto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE01520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeG2FvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 01:51:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeG2FvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 01:51:01 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16AA4208A6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 04:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532838123;
        bh=8gveFQqn+hDqGgQrjtyMJKTv/DpWGwRpUq1kMqEzPV8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Z+ol9vtoMgeysRRZ9zhLHWCpeEgLAFU5C2LCDZAITo5bteHoe49A9yzwsfjZC+41o
         XT6fTF/5HsxEYPEZyVelYHO858gZEhJ+x038eiMHbms8NErrp/sgZvV3NF0lBkbWWH
         Y4CsYy45noa3afNK10Qgheamkkkpe0Y5Qnw9008o=
Received: by mail-wm0-f46.google.com with SMTP id t25-v6so9831655wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 21:22:03 -0700 (PDT)
X-Gm-Message-State: AOUpUlG1knnoa7iFXu5L6oWvwPuhYmHnrM3WWXNpjbTkI+GatGQcbn5o
        35UfdREJxubvZ43Z4Lv2n7ceMN8OGFWKgwujaqQn6w==
X-Google-Smtp-Source: AAOMgpdwp4i/gu536hgwoeGE7Uxs62fWsl6nBWJoxfH7i+WsFOpQ89zbLDoYJvgdvVHnna/DWIKF7kCtssJ67Sg+4L4=
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr9448227wmd.46.1532838121605;
 Sat, 28 Jul 2018 21:22:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 21:21:41 -0700 (PDT)
In-Reply-To: <20180728215357.3249-7-riel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-7-riel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 28 Jul 2018 21:21:41 -0700
X-Gmail-Original-Message-ID: <CALCETrXB9yupF_skJFdP9UP1tRftJjqCa=trkHsXwepq670hvw@mail.gmail.com>
Message-ID: <CALCETrXB9yupF_skJFdP9UP1tRftJjqCa=trkHsXwepq670hvw@mail.gmail.com>
Subject: Re: [PATCH 06/10] mm,x86: skip cr4 and ldt reload when mm stays the same
To:     Rik van Riel <riel@surriel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>, will.daecon@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 2:53 PM, Rik van Riel <riel@surriel.com> wrote:
> When switching back from lazy TLB mode to a thread of the same process
> that switched into lazy TLB mode, we still have the cr4 (and sometimes
> LDT) of that process loaded, and there is no need to reload it.
>
> When there was no TLB flush while the CPU was in lazy TLB mode, the
> current code in switch_mm_irqs_off already avoids the reload, by
> returning early.
>
> However, when the TLB contents on the CPU are out of date, and we
> flush the TLB for the task, we fall through to the regular context
> switching code. This patch teaches that code to skip the cr4 and LDT
> flushes when switching back to the same mm after a flush.

Acked-by: Andy Lutomirski <luto@kernel.org>
