Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC69C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422CB2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="if+TXo44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422CB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJDVeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:34:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41903 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJDVeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:34:17 -0400
Received: by mail-io1-f66.google.com with SMTP id q4-v6so8080905iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SavHLmJUNRwwJVSzw3nYo3pKKy4gR4lS5YhBRwZCqnY=;
        b=if+TXo44sVAAP7f7oIdwAhkEQxrOBog+e9k51BYRXDDwb9eYezx26bnDVCHlcUZzFN
         1IJZmj3n89RYiZCU/O6HMVCE+Y7JxqBL17sv21Q0hF5Tn+7p9Hv/AbXiHNGPBWRFcKLH
         9yp9C3bo/SSyEk5W8KOngpwZ5B2L7WL0Q572U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SavHLmJUNRwwJVSzw3nYo3pKKy4gR4lS5YhBRwZCqnY=;
        b=Iq/GMtt+ZiZR+6tzhOqHJwlvswQQu4nc4qbnMO5e0CHrdFXjrTE7NRovrpy9ZLANjd
         xk60xkgv9urUB269OKzhQ9y34Ob0Vk5xPzQC7ZIwKEjry2z7z0zbGUm2ByvWvMhN7KUC
         pFru+qD/FIBJTSbvlWamJcn4SilqBbzPeM9qcBktNtQWFD4HyhEZWlq/0M7ohIEmhCnT
         fxusWfKl0ddAO6t+JZL212yz9jxfF0nMKkx5wZwvEu79ar8S0lx4c9txmJi2kpae6gRw
         ZtVAQAmNdw9j1upy9sd0wnGooGz9rA2feUNdvlJw/PA6KPQhBNL8T0EOLRspHVcbYhpO
         w/QA==
X-Gm-Message-State: ABuFfoi5q7nrdm2jnRGt+KY+ssXORt5rgrKeSsM/Qzs5+aFZatM1wxAf
        TWWZHO6ofhD+U4voT/yFr4ChJvvaw8ZnrCIz89EGdw==
X-Google-Smtp-Source: ACcGV62ZLQjRwGPcKudVvDUGXPKf90ixQX0eVHkwRb5S/Di/ykkTI5X8UdqHkwl+WWsnU1CRzbtxMMGFavDXDauRPIE=
X-Received: by 2002:a6b:144b:: with SMTP id 72-v6mr4577471iou.218.1538664040605;
 Thu, 04 Oct 2018 07:40:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 07:40:00 -0700 (PDT)
In-Reply-To: <CAOGqxeXCsXbxOcDrdjsgLXXxOtFfyzE0-zVEU6Y9kLxUaVfDiQ@mail.gmail.com>
References: <61559514.Vym8FNvob2@aspire.rjw.lan> <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
 <CAOGqxeXCsXbxOcDrdjsgLXXxOtFfyzE0-zVEU6Y9kLxUaVfDiQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Oct 2018 16:40:00 +0200
Message-ID: <CAPDyKFodNLoHcCJQ0MnoPb6nJ4Nr7V57V16EAYBrk0B01uKagg@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Clear the direct_complete flag on errors
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 October 2018 at 15:59, Alan Cooper <alcooperx@gmail.com> wrote:
>> On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > If __device_suspend() returns early on an error or pending wakeup
>> > and the power.direct_complete flag has been set for the device
>> > already, the subsequent device_resume() will be confused by it
>> > and it will call pm_runtime_enable() incorrectly, as runtime PM
>> > has not been disabled for the device by __device_suspend().
>>
>> I think it would be fair to mention that is related to the async
>> suspend path, in dpm_suspend().
>
> This also fixed the issue and looks cleaner.
>
>>
>> >
>> > To avoid that, clear power.direct_complete if __device_suspend()
>> > is not going to disable runtime PM for the device before returning.
>>
>> Overall, by looking at the behavior in dpm_suspend() of async
>> suspended devices, it does look a bit fragile to me.
>>
>> My worries is that we put asynced suspended devices in the
>> dpm_suspended_list, no matter if the device was successfully suspended
>> or not. This differs from the no-async path.
>>
>> In the long run, maybe we should change that instead?
>
> I originally looked into this. Currently dmp_suspend moves async
> devices from the prepared list to the suspended list as they are
> queued and I looked at moving this to __device_suspend (after the
> checks for async_error and wake_pending) but realized that this would
> change normal resume ordering and was afraid that would be too
> disruptive.
>

I understand, however, I would be surprised if that would be a real
problem. But who knows. :-)

The hole async thing is opt-in, and it does also assume that
drivers/subsystems to cope with devices suspend/resume ordering to be
based upon device relationships, like parent/child,
device_link-supplier/consumers. If it's not working, drivers should
disable the async option, at least in my opinion.

Kind regards
Uffe
