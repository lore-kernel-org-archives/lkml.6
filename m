Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AE8C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AFF20843
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AFF20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeIYEx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:53:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35892 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbeIYEx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:53:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id c18-v6so4851663otm.3;
        Mon, 24 Sep 2018 15:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfpC3BQJNqmM6dMbQCyGnJNhNPjedBUxGe0kgK+ranU=;
        b=HycbJ+BNDJlnNs07Lb5LAwSrCWF+hW8Y2LdqxLdkRR9+CXcPZ0G7QZL/xafzK+mKuQ
         n8WFdOKwXxTcjQT4sydQ5HP6XActVI6uB/OO+HkQYl1w11Fh3MqDFrxNkhKq7rhbSAMM
         gHRQnGCgs8u/60iTYXncGnHaUQOHgBUqr+KQow5hM9B9zOcGNFESkl7vmvC+rW5GFgt7
         fbrfz7ehrAgtjXTHYTbJkEYFtaqIjJ2IdCh7BEj4cixNaNyc9hp/7rA0l4fUEoMNNc7Y
         qoRtKerM9FTEfDf17vULpNekZnUfufKOu017jeqdDd2xkhL5PAzPDVpwE3iTznL81Gzs
         /wBQ==
X-Gm-Message-State: ABuFfojqj+E/lsq8WmCHikvtVQskCAPnKa6i3DVv3hLunOp5MudZRL69
        GR/RGN8N1euS9nkv4jdRJfoxkz4ZRMCqHhWOFmE=
X-Google-Smtp-Source: ACcGV609oLWZmdRb6hCRzvrDmeCz/FG6I6Dv4I2nEUzLwdfhjV0w4h6lxQUH7X1f2hBuLAZFSRT2IP3bL/xshb6uluw=
X-Received: by 2002:a9d:2b03:: with SMTP id o3-v6mr782972otb.102.1537829367280;
 Mon, 24 Sep 2018 15:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180912161101.2634-1-vkuznets@redhat.com> <nycvar.YFH.7.76.1809241123040.15880@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1809241123040.15880@cbobk.fhfr.pm>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Sep 2018 00:49:16 +0200
Message-ID: <CAJZ5v0g10fyZZhvLTz_qSADWQCO==fg=zcFQHD7QLZYwVDOsgA@mail.gmail.com>
Subject: Re: [PATCH] hyper-v: Fix wakeup from suspend-to-idle
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:24 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Wed, 12 Sep 2018, Vitaly Kuznetsov wrote:
>
> > It makes little sense but still possible to put Hyper-V guests into
> > suspend-to-idle state. To wake them up two wakeup sources were registered
> > in the past: hyperv-keyboard and hid-hyperv. However, since
> > commit eed4d47efe95 ("ACPI / sleep: Ignore spurious SCI wakeups from
> > suspend-to-idle") pm_wakeup_event() from these devices is ignored. Switch
> > to pm_wakeup_hard_event() API as these devices are actually the only
> > possible way to wakeup Hyper-V guests.
> >
> > Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> >  drivers/hid/hid-hyperv.c              | 2 +-
>
>         Acked-by: Jiri Kosina <jkosina@suse.cz>
>
> for the above. I guess this'd better go through ACPI tree?

No problem with that if you prefer.

Cheers,
Rafael
