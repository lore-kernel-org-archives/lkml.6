Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC75C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 03:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DEB20899
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 03:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXmAFqDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DEB20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeG2E3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 00:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeG2E3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 00:29:04 -0400
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C732089F
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 03:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532833218;
        bh=PTlxSAOBBNT08i1ITf8yyFrXsOGKVnhArEgq/0II59g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=gXmAFqDa5LMkOz5FEAj5BFQklcdfXFMJ4dueBXepEARsO8NuK7XTIrTo2U7hvNv58
         Y7HzHAxbJxW/qRxPT+/imjJquRqLOKEF/RacFHxgN94hkXhZX4C4/S39jPILVTYmhP
         VOayvWqCSSrF6kVw0q631aPVVnW17U/wy5oWiQnk=
Received: by mail-wm0-f44.google.com with SMTP id t25-v6so9740823wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 20:00:18 -0700 (PDT)
X-Gm-Message-State: AOUpUlHSwYcRZjpLX4z7RH0YPOiZxPmg6/XWacq7MokVREYMDreGJFIf
        SbXsESfOW8RLHVZLMAK04U2DMu8tq4lJCg131zjRIA==
X-Google-Smtp-Source: AAOMgpc/l1Poj1lpAuH6IdFSR2Dybv2UE+hTlRcg8EQopRkv6rWXB/Gk4jCYeYxkoULIdEhY1TYSz1XBs0XGcmOwICY=
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr9272392wmd.46.1532833217185;
 Sat, 28 Jul 2018 20:00:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 19:59:56 -0700 (PDT)
In-Reply-To: <20180728215357.3249-2-riel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-2-riel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 28 Jul 2018 19:59:56 -0700
X-Gmail-Original-Message-ID: <CALCETrWfbsXHUMmEhqER_hJ5O+nJNs5X1jNGME-d=hShABkttg@mail.gmail.com>
Message-ID: <CALCETrWfbsXHUMmEhqER_hJ5O+nJNs5X1jNGME-d=hShABkttg@mail.gmail.com>
Subject: Re: [PATCH 01/10] x86,tlb: clarify memory barrier in switch_mm_irqs_off
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
> Clarify exactly what the memory barrier synchronizes with.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
