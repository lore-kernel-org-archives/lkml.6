Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B052EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C692064D
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8MHWLyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C692064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeG2E1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 00:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeG2E1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 00:27:52 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ABE3208A0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 02:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532833146;
        bh=ARtYfl4AfHPodu+htRIrnmgPKYhFk+ScLknvXxW7HDA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=a8MHWLyG6ju5xvQUlPqixocvJRIW58WPsPBCLoHpKRyQc21HWM2/QOEewc91zYUc7
         K9cTN2TopbPsHJtpVN/uDT9fjmboxrOQCs4CS1PgVKtMTA6+5+EgskGF6lZMSi8aEo
         ZbcI2DGSESaZQXBfqDj0cgcwdQkehEFPzZOXb0AE=
Received: by mail-wr1-f50.google.com with SMTP id h14-v6so8941363wrw.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 19:59:06 -0700 (PDT)
X-Gm-Message-State: AOUpUlHJfDmurrfm7tpwWnOtIiOeR57z9imvFetk0YFZnZZoQjnnjozJ
        vMnUMelSGI3su9Iyidc2xR8OofDMHEeRO/7cHgMIWg==
X-Google-Smtp-Source: AAOMgpdi1HVxxhZmtsOsk0MXwsOi6xfNPx20uDdnR8/aXzPnzne8M8Qhn/Dzr/XtTNF9PLiZY1B8rW+z8QMLkdnulb4=
X-Received: by 2002:adf:e0cc:: with SMTP id e12-v6mr11323820wri.199.1532833144794;
 Sat, 28 Jul 2018 19:59:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 19:58:44 -0700 (PDT)
In-Reply-To: <20180728215357.3249-5-riel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-5-riel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 28 Jul 2018 19:58:44 -0700
X-Gmail-Original-Message-ID: <CALCETrUPvja=MNOFkN7iK7Vs=r8QbP1Avwn_gsX3UpMS5qf__Q@mail.gmail.com>
Message-ID: <CALCETrUPvja=MNOFkN7iK7Vs=r8QbP1Avwn_gsX3UpMS5qf__Q@mail.gmail.com>
Subject: Re: [PATCH 04/10] x86,mm: use on_each_cpu_cond for TLB flushes
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
> Instead of open coding bitmap magic, use on_each_cpu_cond
> to determine which CPUs to send TLB flush IPIs to.
>
> This might be a little bit slower than examining the bitmaps,
> but it should be a lot easier to maintain in the long run.

Looks good.

i assume it's not easy to get the remove-tables case to do a single
on_each_cpu_cond() instead of two?  Currently it's doing the lazy ones
and the non-lazy ones separately.
