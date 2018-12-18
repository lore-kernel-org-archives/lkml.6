Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7E3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D483D21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545126621;
	bh=FFZ93hWzq3t79v94ey2iEtEqNHL15CEJIxxpSsmeo4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gMiJ+jrvt8EXgSqoJayMTEu/reRT/Hfbdm+m4hBCX69ZXjxQ/cyh94xvZzjVbFG8U
	 VRebb3X6UMrKWYI/li/8tYTMalEL042mrNTAj26zU4ciL3Md8mr5eNU+/G459bE+oY
	 Z1iwQW4g/Pv3fajSKL7CQv/gmOwm4Q93DcLuqC+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeLRJuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:50:20 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36347 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeLRJuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:50:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so15100544otk.3;
        Tue, 18 Dec 2018 01:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMsQK28SW25yGjqfkug2NcENbZyHIWuQwhrHCb4iN64=;
        b=rvOp+q0r8AkwkEqexvY+1UDZhp78Z59bLDYy2eKaG53zCsrxsYorFk2QgZV5Aqu+27
         HXSIuzq2gZ0SX4oeXTQfaqVuQHBvtuvTl496226dD7BDARKpngux2rSbNdoG/JBG2ezt
         2FlWcjJsdfILyBQS4L3vNObqVfPe33gaf0OzdioTGak/Auwhu7y5ieBuXfcXswsoW/l+
         IYvEDm+Du64QEQ2F1I65DeDWweIuEhQI9B1U/Piftm8xShnouMjSahVz8CvK7XUQMCAC
         ZRizXP1RFLYPTqTt1czjjeONBzwBTpSEFNNztbOAq29+U7o+dWMvWnfovVSr6dh3ME24
         44Wg==
X-Gm-Message-State: AA+aEWZ8iuQxHSa5hMFP8wJDzhpBvUT7MAfn6Sexr0qc+e0ETd57LjLx
        Ui8wXUOb4EhiEJS798RMfqjk4FNXRrEGriVJhtACwQ==
X-Google-Smtp-Source: AFSGD/VEYVnTcp8UC7PNOWDjNYYDuVwE+FriwOVjUZ0Jx05Bxn7IyQRUhAKWxYNwcXC6zheXfy/1si8vwvwaiY9XTSM=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr11330782otn.200.1545126618513;
 Tue, 18 Dec 2018 01:50:18 -0800 (PST)
MIME-Version: 1.0
References: <4307523.O7RPX2KSmk@aspire.rjw.lan> <20181217165025.GA2469@lahna.fi.intel.com>
In-Reply-To: <20181217165025.GA2469@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Dec 2018 10:50:07 +0100
Message-ID: <CAJZ5v0hCGoOB36sGDo1cfLN4tHbwmK+YGresjPAFPyXKUdbP=g@mail.gmail.com>
Subject: Re: [RFT][PATCH 0/2] ACPI / PM: Avoid spurious wakeups from
 non-wakeup GPEs in suspend-to-idle
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 5:50 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Dec 17, 2018 at 12:19:27PM +0100, Rafael J. Wysocki wrote:
> > Hi All,
>
> Hi Rafael,
>
> > It turns out that on some systems non-wakeup GPEs cause trouble (see the
> > changelog of patch [1/2]), so they better should be disabled during
> > suspend-to-idle (at least before entering the main loop of it).  This
> > is done in patch [1/2].
> >
> > Patch [2/2] is just a folllow-up.
>
> I tested both patches on Lenovo Carbon X1 6th generation and one new
> Dell system. Both default to s2idle. I did not see any issues around
> s2idle with the two patches applied.
>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you!
