Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BE8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F8620693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2FUZ2yJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F8620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936343AbeFRWGt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936180AbeFRWGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:06:47 -0400
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE7E20874
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529359607;
        bh=XckgwGt2nnVP7SWyJ4wCw2zyF0yWOrB+10bhD6iuApQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A2FUZ2yJgFhgGnvs6oFGEBcdwBOKUhYOX17/xKGHKZCd3JHCj31ou3AOiY4PBYLSq
         ggTPhut6N5YgmcGPK8nDxRlNvBXFibTOT3f5yCOy8XSpa+3R4bcw6NFBu2BBco2yoy
         bxZjsMXhMEmHAHKltS/49CQRX3ujCeYDXKX4s4Sg=
Received: by mail-wm0-f45.google.com with SMTP id x6-v6so16524541wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 15:06:46 -0700 (PDT)
X-Gm-Message-State: APt69E05AncniAWhzdwcMbjCD6DLFY4w7UUQeqFhtBdcjCryTZIqeQ1N
        4w3hyINns4EDJc6lx/THNlUmj023s5Hv7rBoRNgPCw==
X-Google-Smtp-Source: ADUXVKLQ5unNfdAuf7LICfxDNpTMoWPJkMZUlS8m/WNQp8fqYYHbtugQaPA7HHz/fPFQDt6VKFm6IuWORIMA9B2lC7E=
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr9076270wmi.46.1529359605232;
 Mon, 18 Jun 2018 15:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <1528391168-22224-1-git-send-email-chang.seok.bae@intel.com> <1528391168-22224-5-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1528391168-22224-5-git-send-email-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 Jun 2018 15:06:33 -0700
X-Gmail-Original-Message-ID: <CALCETrUeEAGcsg84oxEY99bNqd3ewc27nP8gHFwMf4GQhPtcDQ@mail.gmail.com>
Message-ID: <CALCETrUeEAGcsg84oxEY99bNqd3ewc27nP8gHFwMf4GQhPtcDQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] x86/fsgsbase/64: Factor out load FS/GS segments
 from __switch_to
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 10:06 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> Instead of open code, load_fsgs() will cleanup __switch_to
> and symmetric with FS/GS segment save. When FSGSBASE
> enabled, X86_FEATURE_FSGSBASE check will be incorporated.

The code is:

Reviewed-by: Andy Lutomirski <luto@kernel.org>

The changelog could be cleaned up a bit.  Maybe:

Instead of open coding the calls to load_seg_legacy(), add a
load_fsgs() helper to handle fs and gs.  When FSGSBASE is enabled,
load_fsgs() will be updated.
