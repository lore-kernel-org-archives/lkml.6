Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0CBC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6E12084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6E12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeJEPrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:47:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47071 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbeJEPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:47:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id o21so11680548otb.13;
        Fri, 05 Oct 2018 01:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aubCIKusfHi/jWHUl5MOhP2YOEoL5BytJdBC0SVXPxw=;
        b=UNu4ZQCYtmF4p4V9igKon1DJXpJtRnx3/S1SXLSYrwjiJyO8d0AjAZyBNOattRmUdp
         mp34G+3UKNWhSMDuk+7+K5Pz9StXpbszXKhZfjEET6pSmBtLZJwKiiTF01o/jW5keS+Y
         x1QpCEWjXDIMeR0PLBBVPdmo8++3NhV3IzH+NqrUevmnVFF0v3FMUAZp3GU8cvrLSPwf
         Phpxz0wwNngvf2Z0n7l9J9yMVelMC1xVdqGBkbIz2312yz+L3H7AbcBEV1xJS6EccCtN
         dHR9zfmjQlzFUUvvIaldmPAgbtI/6zLzE0aMQ6/VueHrRSouPgV4al6nPm1d2/kWJVtl
         U6OA==
X-Gm-Message-State: ABuFfoibsFcY3EA7WvHXGSxSD0foqGWHM1zqwn24mZe9/AGGXaqRMlH9
        7T4i2XgyAnNPalN0H1HX8tlrp4rCT67QpdwQpq4=
X-Google-Smtp-Source: ACcGV62sEfjn2yV8dzSZVxxqaQwZ/c+g5n7oeFnpq5dFp/3eDhGrFJ0nytHZkDyxX2L3B7d9nv/rSNuBvvKdZy2yfDM=
X-Received: by 2002:a9d:538c:: with SMTP id w12mr503691otg.139.1538729391532;
 Fri, 05 Oct 2018 01:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <3510260.hvypppS8Bs@aspire.rjw.lan> <4130376.2FFt7p4687@aspire.rjw.lan>
 <20181004145116.GB1881@mai> <CAJZ5v0h1Z7MKjq9XY0-tn9U4J3CdycYPbGkM3fjH7-FzaJ=uJA@mail.gmail.com>
 <b365081f-00bb-ec2a-84b2-48bed1b76c19@linaro.org>
In-Reply-To: <b365081f-00bb-ec2a-84b2-48bed1b76c19@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Oct 2018 10:49:40 +0200
Message-ID: <CAJZ5v0iysZaRY92ocQisAM3jaRUzoaQYrsbGXs4WwntEKMbLCQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from menu_select()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 10:35 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 04/10/2018 19:19, Rafael J. Wysocki wrote:
> > On Thu, Oct 4, 2018 at 4:51 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On Tue, Oct 02, 2018 at 11:44:06PM +0200, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Rearrange the code in menu_select() so that the loop over idle states
> >>> always starts from 0 and get rid of the first_idx variable.
> >>>
> >>> While at it, add two empty lines to separate conditional statements
> >>> one another.
> >>>
> >>> No intentional behavior changes.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>
> >> This code is becoming a bit complex to follow :/
> >>
> >> May be I missed something, but it is not possible to enter the condition without
> >> idx != 0, no ? (I meant the condition if ((drv->states[idx].flags &
> >> FLAG_POLLING))
> >
> > Not sure what you mean.
>
> Yes, sorry let me clarify.
>
> I meant the flag polling is always on state[0], so if the flag is set
> then idx == 0.
>
> We have the conditions:
>
>   drv->states[idx].flags & CPUIDLE_FLAG_POLLING
>
> If it is true then idx is zero.
>
>
> Then comes the second condition:
>
>   i == idx + 1
>
> because of the above, idx is zero, then it can become i == 1.
>
> Then the variable assignation:
>
>  idx = i can be replaced by idx = 1

Yes, but the former works too. :-)
