Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD1FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686E020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eHYcJ9H3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686E020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeGYSku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:40:50 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34970 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbeGYSkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:40:49 -0400
Received: by mail-io0-f195.google.com with SMTP id w11-v6so6995836iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/n4tus6ra8XaDtlo2xNAYjaTu0fc9dSx4SV3M/Ztks=;
        b=eHYcJ9H3ss03j+7GkO69FroVmIzyYqmkpZxL32VMf4DjW9+gt9Xk5NNHitWfEapPae
         FqSEA918bTusn8lgwd8eSfQsT6PjMJNvSboQBQCxv16vQRXNrxP4idIZAT4OCMff+muj
         zn1P31YUHZscgYQ43g9YZVGYSNnALgV6y77IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/n4tus6ra8XaDtlo2xNAYjaTu0fc9dSx4SV3M/Ztks=;
        b=lpde/Ja7hc7WvTblSVsaI6ZmNsMwr0/LAm4WyCVJS+0ZVae+9Cp/1e7HwMBRS96exT
         99muRnfe4xUHRTAoS17YW2j5kdj2xoDY8BMWqyNaxFV8R2R34YItNMjacJeG9p9v5B7Z
         XmgLxJ05zYB4ftaryqJiarKPgKVVTdS/uOfg5sk9nK8hzVFd7dARPmWIh347Xcov9VZT
         uGpV0SCzPBdU32XS/pEUthcuTut9y4rVeIToENp3105eOR7EqEgqb3Ev2S9/gRkFuK3G
         vLoiJIHYHyUtfWUzJa3X420OrHiPGniTUrHEfowqo/gD51A4CPCy4poESOAvOVxB8EHM
         ZjJQ==
X-Gm-Message-State: AOUpUlHl7gc+Vo2zIwf4Xb/Us4nYiGrFtGD+cIo2SrrXWJJDaq/rOl2r
        4UbK2zdJ8Nvq4oZE5OXZm5qS1/T9xUJDKqiv4R0=
X-Google-Smtp-Source: AAOMgpdPrq27g94yvNMl7c77JDoUFLuhzFNT5B7vgOSFTaM18gUABQpCJoW8e20dWghKO3U/zAUNE2+ynn8l11moD7I=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr18681420iov.203.1532539691222;
 Wed, 25 Jul 2018 10:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1807242147560.997@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1807242147560.997@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Jul 2018 10:28:00 -0700
Message-ID: <CA+55aFz+5e3-YudC1a0YPx-dUN5YjHxQKF=ROPv9J2N-6b1ZDw@mail.gmail.com>
Subject: Re: [PATCH] x86/bugs: protect against userspace-userspace spectreRSB
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 12:53 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> Mitigate userspace-userspace attacks by always unconditionally filling RSB on
> context switch when generic spectrev2 mitigation has been enabled.

Shouldn't this also do something like

     x86_spec_ctrl_base |= x86_spec_ctrl_mask & SPEC_CTRL_STIBP;

if we have HT enabled?

              Linus
