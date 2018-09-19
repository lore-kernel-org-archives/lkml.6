Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA17EECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E5D2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E5D2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbeISQOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:14:09 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44770 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeISQOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:14:09 -0400
Received: by mail-oi0-f65.google.com with SMTP id l82-v6so4599173oih.11;
        Wed, 19 Sep 2018 03:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2v67INzC76a/0IyjpLkFvj4ENyZkF9lWA4QBf5pS6Ic=;
        b=kV7hgxl4o75wDNSCdHz3wG3zQbdqTxoJfyxZagjJqZPy5wnJp99F3DdyjyJbqa3oDG
         aBN9hz79yHqt6gFLPpw7eH/hbSHJLvxJpTkwo/wcb9btHn+U92w+EbylD/pRXHwRnCBz
         Kvo0ry3gyx4hCGAuLNIX95TwLD1IJHXDQNdzGqSc7YKyb7FZ/0fuLxRLY0T2F1CMWSfl
         C+WWQ6PUdRRmCtMTUvYXqHmsSKLUHVZEKooZEdplMFTi2GzBJvg1Lxu0vwj5jXOId075
         C+EDfL57aJkFx3RjTMkP5VDDj+XNKBR8ar54oHPUvSNn3fArKD+SlqU20fwGiRFSDtfK
         WIcw==
X-Gm-Message-State: APzg51A4ptVAWavOV0gWGdvkSzr+t2o0VqE/G12cJrFa1X7VHqmPN7OZ
        1GfuQJnMc4W0zbjyJnwbgWY9tVEKkmBaZJGbIzU=
X-Google-Smtp-Source: ANB0VdZ9BWCPOlKFVMcLlu1b2HHq1q8UDcBlxVmow2f6idPL22g70VZjhIlLmEsMkuwXXWA/TJVkWvRXomS9AaQsIHY=
X-Received: by 2002:aca:4141:: with SMTP id o62-v6mr1270703oia.24.1537353411063;
 Wed, 19 Sep 2018 03:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537275915.git.yu.c.chen@intel.com> <020db877db6a8d39808dfaef2a5162f541f0853b.1537275915.git.yu.c.chen@intel.com>
 <CAJZ5v0jvB5zF-LqYsB1ughaZbRhZW1RjVSvY87q_W_pNkmqBeQ@mail.gmail.com> <20180919103405.GA19621@gmail.com>
In-Reply-To: <20180919103405.GA19621@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Sep 2018 12:36:40 +0200
Message-ID: <CAJZ5v0hq_qawFjpCsYvkOF=OotY+a2AuNc7eTR8RhaLyNPMd-w@mail.gmail.com>
Subject: Re: [PATCH 04/12][RFC v3] x86, hibernate: Extract the common code of
 64/32 bit system
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Sep 19, 2018 at 12:34 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> > > index 000000000000..fbde8f0e8fe0
> > > --- /dev/null
> > > +++ b/arch/x86/power/hibernate.c
> > > @@ -0,0 +1,249 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Hibernation support for x86
> > > + *
> > > + * Copyright (c) 2007 Rafael J. Wysocki <rjw@sisk.pl>
> > > + * Copyright (c) 2002 Pavel Machek <pavel@ucw.cz>
> > > + * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
> >
> > I don't think this "copyright" information has any legal bearing any
> > more at this point.
>
> I think that's wrong in general, and it's routine for corporate legal
> departments to insist on specific boilerplate copyright notices when
> OSS code is contributed.
>
> Copying code and then removing copyright notices is frowned upon
> independently as well.
>
> While you can probably talk for your own copyright notice, I'm not sure
> it's true of the two other historic copyright notices that were copied.
>
> So I think it's best practice to preserve all copyright notices as-is.

OK, let's retain them, then.

Thanks,
Rafael
