Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7BEC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576972083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576972083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeJEAlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:41:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38362 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbeJEAlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:41:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id h15-v6so10026696otj.5;
        Thu, 04 Oct 2018 10:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HCpyyxqmoao7fBg8aIBcW/4jZxbsY2lesZJ5z2xFw8=;
        b=eFTD0CpqXX0cfv/TOxwUWXXPzkfgpXswbjUc0RmbVw/AEcVUet+kDvCByTxLN7MlKw
         f6/UIrRngSbHEDBS67ejcuofOnVM2+A9sISrjznOAvvRt+qB+nhi3AoCCWefY8DvVRRk
         Dkd5IueUZETGMAigR2g0xXtjpTfl2HVfNKZ+6ewnipzaQtDLu39PqFxOeHNA6oBRsnsA
         YF4HiAzxMuuFGj2/wblfwL6ARB1vfrtVZngKa0sF+X3ycxo7opSNTx7lKionsRAczN9+
         nf81XENw1leOq08rraxDx5/M7UUzWbdP60zuLxP2FsNA7cON1MOnDZspOzmWltvvJE7m
         rexw==
X-Gm-Message-State: ABuFfogvMjbEqoYe6jIXeU9onAlJnoQxdpE0atWVqWmLBmi7V9uG+rpv
        iS/l94c4zD4AOYB4+UcKGfGA+gBFOYYPwqNXHUI=
X-Google-Smtp-Source: ACcGV62Low7lWuAfJITLFWZIrQBw6TzYh8iVv+HKUypgoPm7mlpK5q3IvH0GIDm/gUx6ZvwG2+Ah6wbwFTcqoVy/hW0=
X-Received: by 2002:a9d:7594:: with SMTP id s20-v6mr4516585otk.258.1538675234360;
 Thu, 04 Oct 2018 10:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <61559514.Vym8FNvob2@aspire.rjw.lan> <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
In-Reply-To: <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Oct 2018 19:47:02 +0200
Message-ID: <CAJZ5v0ih4Hn5W-dTzOayMyMfLMe=djKVhxBcoQ=7oJz6QnpTJQ@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Clear the direct_complete flag on errors
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>, alcooperx@gmail.com,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If __device_suspend() returns early on an error or pending wakeup
> > and the power.direct_complete flag has been set for the device
> > already, the subsequent device_resume() will be confused by it
> > and it will call pm_runtime_enable() incorrectly, as runtime PM
> > has not been disabled for the device by __device_suspend().
>
> I think it would be fair to mention that is related to the async
> suspend path, in dpm_suspend().

OK, fair enough.

> >
> > To avoid that, clear power.direct_complete if __device_suspend()
> > is not going to disable runtime PM for the device before returning.
>
> Overall, by looking at the behavior in dpm_suspend() of async
> suspended devices, it does look a bit fragile to me.
>
> My worries is that we put asynced suspended devices in the
> dpm_suspended_list, no matter if the device was successfully suspended
> or not. This differs from the no-async path.

That's because this was the most straightforward way to organize that
(otherwise you need to worry about the list locking with respect to
the async suspends etc and you really need to preserve the ordering
there).

> In the long run, maybe we should change that instead?

Is there anything wrong with it really?
