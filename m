Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12217C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3E7244F4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgUVZuuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3E7244F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934248AbeFVPhR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933909AbeFVPhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:37:14 -0400
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com [209.85.128.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70BB924509
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529681833;
        bh=k3DNM2ii+IlKASEG5O5JI+yduC50SlU1ogvSpCdyO/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HgUVZuuU1swO78A3edBDQRHKtsSJIolBUWlVJbjGNQYfbS038RvGe5f7TqHl7n+sf
         vwJDsVoGAKePdkCfHJ0H07gvjV8eo57VLX95y9ltQLuMqAPTn6AMSlTepBolIUrstW
         Ko/8CnRNWIB2ohFJV25jJmG3CjKAXSUokCqXG7+8=
Received: by mail-wr0-f174.google.com with SMTP id a12-v6so7153234wro.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 08:37:13 -0700 (PDT)
X-Gm-Message-State: APt69E2A3UV6sH73P0PqxOkDzpuzdvegZY2OCeqZT0HXfDsLr0kRVrkD
        2Lki1Xnseqeb8o6hmEy3b4UAMwXlvm1WuqgILqdM9Q==
X-Google-Smtp-Source: AAOMgpefnm03jbfD5kKGaZr3xXkcH1CHSm3kkdQSzpkWfz+mI468tIfDTRinh4h0OlUmlXIxSTl3+wFItwJCtzgLDhc=
X-Received: by 2002:adf:fe4c:: with SMTP id m12-v6mr1953515wrs.171.1529681831869;
 Fri, 22 Jun 2018 08:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180620195652.27251-1-riel@surriel.com> <20180620195652.27251-8-riel@surriel.com>
In-Reply-To: <20180620195652.27251-8-riel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 08:36:59 -0700
X-Gmail-Original-Message-ID: <CALCETrXfHhPNe9J0NEabxdtKGRV+XOX=n6vtL7rbOY6e2GXMqA@mail.gmail.com>
Message-ID: <CALCETrXfHhPNe9J0NEabxdtKGRV+XOX=n6vtL7rbOY6e2GXMqA@mail.gmail.com>
Subject: Re: [PATCH 7/7] x86,idle: do not leave mm in idle state
To:     Rik van Riel <riel@surriel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 86@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Galbraith <efault@gmx.de>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:57 PM Rik van Riel <riel@surriel.com> wrote:
>
> Do not call leave_mm when going into a cstate. Now that mprotect and
> madvise no longer send IPIs for TLB shootdowns to idle CPUs, there is
> no real reason to disable lazy TLB mode in idle states.
>
> This seems to help performance on Broadwell systems. Haswell performance
> numbers are inconclusive.

I'm skeptical.  The code you're removing is more about power
consumption than about performance.  If a task migrates from one cpu
to another, runs for awhile, and exits, we don't want to IPI the old
CPU if the old CPU is deeply asleep.  The logic you're removing is a
bit awkwardly written, but the intent is to only do the leave_mm() in
deep sleep.  We should arguably change the condition to check the
expected sleep duration instead of the microarchitectural properties
of the target state, though.
