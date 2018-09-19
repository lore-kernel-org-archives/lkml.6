Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB1CECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70388214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70388214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbeISOST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:18:19 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34347 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeISOST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:18:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so4383850ois.1;
        Wed, 19 Sep 2018 01:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TO6yngxdwH3Wdh+tmybQorYdVuz5cokLxSYklFVD/k=;
        b=EW4MgyGZXhwt08M2bjloaodee390nh8zIFv/hvjDZuAG8x4p1gfVjcO2BGiI3orU6o
         SfS/0kXLkw+wc8h8DhuMICmxMG3rsZuujOsPS9b+pVGhZr1c8UYkUed33b3ihGksX5n7
         2VBUfzsAmHCVucWn2pJkeBFt/5Lt9bC4yirpzbqxPA38Qyh3vlUBsnSNnuK7VNYmTdQ6
         5qyszTLO/j3bBu0U1fBAh1fpmDyzvrxefxcf9AFFMuxRvoCjpReK6DRFInzPpzuGHQRD
         6pZwITBhG64AzWYpDXytFuuVtD1kViwrtwY6o+ZD3nbkC7Ny0RSUAOa7ZDCsujVyyzyR
         LLbA==
X-Gm-Message-State: APzg51BcA0+d/Z/MzthM3FquA1kwjfPTAlSt/gJRtQv2F9b2e7ScPIQu
        OJHFkoWsV+ON2Q2txfRNOD/M79JNroiv8b3XCOQ=
X-Google-Smtp-Source: ANB0Vdb5BPbUS5fzAoEKjMhz8HvtBiXseb6naPbSSoIZ1dQ/gIz4eZ6j3ElnuJCeUL/0AF+RXYCWzuMZC+x/gJ8qTzw=
X-Received: by 2002:aca:4141:: with SMTP id o62-v6mr1027216oia.24.1537346488013;
 Wed, 19 Sep 2018 01:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537275915.git.yu.c.chen@intel.com> <19aed6bb376b47f672800b4c59da07efca0f9e5a.1537275915.git.yu.c.chen@intel.com>
In-Reply-To: <19aed6bb376b47f672800b4c59da07efca0f9e5a.1537275915.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Sep 2018 10:41:16 +0200
Message-ID: <CAJZ5v0jrodgg_j_dEUDsfPibaSDouXVpt-++UQ3-k_7M41dpTA@mail.gmail.com>
Subject: Re: [PATCH 03/12][RFC v3] x86-32/asm/power: Create stack frames in hibernate_asm_32.S
To:     "Chen, Yu C" <yu.c.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kookoo.gu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 9:31 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> From: Zhimin Gu <kookoo.gu@intel.com>
>
> Backport
> Commit ef0f3ed5a4ac (x86/asm/power: Create stack frames
> in hibernate_asm_64.S)
> and
> Commit 4ce827b4cc58 (x86/power/64: Fix hibernation return
> address corruption)
>
> And also prepare for relocated code and jump address
> mapping.

I don't like the changelog.

It should explain the technical reasons for making the changes in the
first place and then mention that analogous changes were made for
64-bit before and by which commits.

Thanks,
Rafael
