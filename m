Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32A6C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9912148C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yjr71oq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9912148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeJQGxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbeJQGxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:53:14 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12DF22148C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 23:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539730836;
        bh=AtVdJg1PwWul3p9fkSe8Cet8TQhp0Y3/AYVopGoCJGA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yjr71oq+dd3SFO9GFAcKWoDBi2pl8g58F524dbBQn0PQxpdQMXX22c6JAlmZsz74s
         XqcoRzeQqkeQvutRKhFkpDzOqSAiLLhZPUI4YLIxEDtD/96Q8KNUYoPqkEj+/NV0yW
         R3cNpdTHWnXWKz1sl3eVIjiyaxEUs5672uByHo9s=
Received: by mail-wr1-f42.google.com with SMTP id e4-v6so27450507wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:00:36 -0700 (PDT)
X-Gm-Message-State: ABuFfog3rZOUbSUr+Q1tabW/JuUsd/BSjh9iP5aU/cgxg2ASQ2O4ppxn
        WF3cmWAqqFsAkZSBP/WWQtxFuFK5QzjsOMekSQ2kRQ==
X-Google-Smtp-Source: ACcGV61HojzK4sloNz8mOLGwzYXljhCb7vqPRFIGAHpotHaKwNWNOrKVj2W0fIYI8n2h20fYR8ttg5zv4wUy17zZeiY=
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr20798323wra.95.1539730834546;
 Tue, 16 Oct 2018 16:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181016202525.29437-1-bigeasy@linutronix.de> <20181016202525.29437-4-bigeasy@linutronix.de>
In-Reply-To: <20181016202525.29437-4-bigeasy@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 16 Oct 2018 16:00:23 -0700
X-Gmail-Original-Message-ID: <CALCETrV2jEG1b7deGeyxwRrXLk30Q2nn6hstzeTpE80i+vu1mQ@mail.gmail.com>
Message-ID: <CALCETrV2jEG1b7deGeyxwRrXLk30Q2nn6hstzeTpE80i+vu1mQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/fpu: Save FPU registers on context switch if
 there is a FPU
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 1:25 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Booting a 486 with "no387 nofxsr" ends with
> | math_emulate: 0060:c101987d
> | Kernel panic - not syncing: Math emulation needed in kernel
>
> on the first context switch in user land. The reason is that
> copy_fpregs_to_fpstate() tries `fnsave' which does not work. This
> happens since commit f1c8cd0176078 ("x86/fpu: Change fpu->fpregs_active
> users to fpu->fpstate_active").
>
> Add a check for X86_FEATURE_FPU before trying to save FPU registers (we
> have such a check switch_fpu_finish() already).
>
> Fixes: f1c8cd0176078 ("x86/fpu: Change fpu->fpregs_active users to fpu->fpstate_active")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Andy Lutomirski <luto@kernel.org>
