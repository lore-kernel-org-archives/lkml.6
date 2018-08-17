Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE90BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F41221868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F41221868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeHQKx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:53:26 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42978 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeHQKxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:53:25 -0400
Received: by mail-oi0-f67.google.com with SMTP id b16-v6so12578310oic.9;
        Fri, 17 Aug 2018 00:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ku9Odfjhnl7Ln4vJl6+cvAXA2CAU/aX4tpiMr794FCk=;
        b=EnR4oDo6X5jFBrFXCWEdeeUgMkHyR+jLPXrBLIg3iQbbOHDwOKHmoSDRwQdBNpeQ2P
         nvrbQihD9HL48iQCeSzpOqyUngujwFDTVqbeD//Va8aM1vDPwgKEpr4X8wPY57QBCBok
         NkQQvNCFuNcT2r5DvqO21eDhEdkP9+V5aq8Rrs7Gy4pwzQyILJZ2GOJQtZGAC1wib/2Z
         oWujOJyVwe/qBNxqD8SDNbK0cplWZ/snatsniRUZmIYnrZ+fNYhXYqZV/6nI1D18S8z0
         gTRa3PWlhwfqU1/5nm8/5vRDOtJbcOvZ/uhTnqAB8Lu6FfBwOOnQgJDTjKlMIv1nq/8S
         5YTg==
X-Gm-Message-State: AOUpUlHphmjK3XASAqgysacCl7Db61Y4Sxt7K1Nr/SNmmFvcJsT1nD/T
        EU+qM1NgtLwL0Y3mJlPAx1Nn85gbOM8bPAhQFek=
X-Google-Smtp-Source: AA+uWPxg95vejQ0nLzrcU/srQXvEOoTmwxQH/FYbcFrtiE2eK5xrir79WiIcuc+5xY8z22eMZdxGnPL0ttUhPFy3fDI=
X-Received: by 2002:aca:190d:: with SMTP id l13-v6mr1405050oii.216.1534492263963;
 Fri, 17 Aug 2018 00:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <6401388.2t0qD3iTOr@aspire.rjw.lan> <20180817.144354.2288619657950222607.teika@gmx.com>
In-Reply-To: <20180817.144354.2288619657950222607.teika@gmx.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Aug 2018 09:50:52 +0200
Message-ID: <CAJZ5v0gueiBtbAS00LQ0yp15=OmvZe-i2ETzxaPvVD5wuZGV7Q@mail.gmail.com>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume all bridges on suspend-to-RAM
To:     teika@gmx.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 7:45 AM Teika Kazura <teika@gmx.com> wrote:
>
> For the record, about the exactness of the patch description.
>
> The patch mentions the regression by the commit c62ec4610c40, but it is not the cause of the bug (https://bugzilla.kernel.org/show_bug.cgi?id=20067)
> reported by me; I reverted c62ec4610c40 on linux-4.17.13, and the bug remained.
>
> # Some details: my bug was introduced by the commit (i) 877b3729ca0 on Jan 3. The commit (ii) c62ec4610c40 was on May 22. The commit (iii) 26112ddc254c
> on Jun 30 fixes one problem caused by c62ec4610c40. The present patch modifies the code of the commit (iii), so it can be said as the completion of the
> commit (iii). It at the same time fixes my bug, too.

You are right, commit 877b3729ca0 introduced the issue for you, but it
did that by exposing the same functional problem in the firmware that
was previously addressed by commit 26112ddc254c in a different case.

> This suggests the present patch possibly fixes other unknown PM problems; former kernels had some loose end(s). Now this patch puts the kernel in a better position.
>
> I'm a lay Linux user, and don't know if this post helps. If it does, it may be worth mentioning it in the above bugzilla entry.

Yes, it does, thanks!

I have updated the tags and the commit log of this patch according to
the information above.

Cheers,
Rafael
