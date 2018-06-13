Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42A05C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD8B208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ4pX4eF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD8B208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754568AbeFMHxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:53:46 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:44339 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754472AbeFMHxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:53:43 -0400
Received: by mail-oi0-f48.google.com with SMTP id c128-v6so1454484oig.11;
        Wed, 13 Jun 2018 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hPFXEvJOVZ62m2jnnzwOpJs0CvPxrgob2wQ3DbjrRtg=;
        b=kJ4pX4eFb/vuZmemxoSvIbhIY4V8BjgOgSyy6qEmgED4zONHOhgQdDAYJYXMmfVsEU
         Cf8tNBHq7vj0Fv8ABmkBg1cDXOa0neO1Khx1n/QpCDJcjWCwZqUMVUIm9CXvcKcgLPeS
         lv2q0BWraq7Ew9vFkMbcYswqqylT+M20scWVTXUFHcncp+23wcAKma7PIZQt67h/WoyR
         zJzf7ZJ2OrMTZcD2Q5dO0rJ5YOVI0ZiAo///7an2zRkD6EI9J7LSkD7ZLt0cf/rpI9St
         bT4QhFTJeM1tKULr+w1caS5sCDmMKNZnRjhBcagX42yjHTAx8ityyLna213QXyEXWhpG
         Zuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hPFXEvJOVZ62m2jnnzwOpJs0CvPxrgob2wQ3DbjrRtg=;
        b=mFGaEnyrE+VfjDEMhbCOjBfN0XE9v4lQQylMNLAPhB9zyeprnlzXP2egd6UGneD7CZ
         ctpjdOJkY2G6iTiQLq0Udsc9KB69K3FmIlWeqkLYtlQcM+TWMKqPcalCRmilTLG5W9+C
         gcGXoYGnPNsKIZn9PTtBqmrKAzCv8NKTozVLfiWNFpx4n2vQLHciMqX9lMaz8SfmEuMM
         jEt2UhMELWeQ6wEXj4Fhat60xLma93N9cFSKOobkbYanu65YaQPrzVUPmgpbrbbi+0D6
         QRUYqaoyn46t98PrY6m6dQLodtdkT55zXTjY3QP2jAMH2rdtB7TEXRpqkdqfZQqCa2+/
         ThqQ==
X-Gm-Message-State: APt69E3uNJcLjZAGcaeVF4T81CDhrYmxXUK9F+d0pfV9CreP5758V/YL
        lNHVdbyU3hChj4iCxH3xmEstvmjnlmQnvvngQ6Y=
X-Google-Smtp-Source: ADUXVKKo0dK0wr31jjV8H1jXFDF9n1OYRjGOdLUKCHpZ+as4oluoNSr9xGCnE+Pjt5rWHG81GJzNugA55b2hJaDNydQ=
X-Received: by 2002:aca:e143:: with SMTP id y64-v6mr3632872oig.282.1528876423323;
 Wed, 13 Jun 2018 00:53:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 00:53:42
 -0700 (PDT)
In-Reply-To: <A05971DC-4453-4615-9AE9-8C4608569427@canonical.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
 <CAJZ5v0iyNo+ZZ1O0_j4p6w-+eS1W9MUYs-vjeNHVENFVhReGzw@mail.gmail.com>
 <CAJZ5v0jiWugSt98MXOLUKAsig=uWFsTHK1Mntvy6z0JfiWt9sQ@mail.gmail.com>
 <2505591.oRh3ktjo9V@aspire.rjw.lan> <A05971DC-4453-4615-9AE9-8C4608569427@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jun 2018 09:53:42 +0200
X-Google-Sender-Auth: P8xkAXH8wnrPHaW06WNkItTLVWc
Message-ID: <CAJZ5v0h_062K-MJrEr0zAjthZgxU9RFpu_b86N4zBKvOqpejdQ@mail.gmail.com>
Subject: Re: Possible regression caused by commit a192aa923b66a
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        P HeLiOn <perryhelionsemail@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 4:45 AM, Kai Heng Feng
<kai.heng.feng@canonical.com> wrote:
> Hi Rafael,
>
>> On Jun 12, 2018, at 5:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> On Monday, June 11, 2018 11:52:34 PM CEST Rafael J. Wysocki wrote:
>>>
>>> --000000000000703623056e64c488
>>> Content-Type: text/plain; charset="UTF-8"
>>>
>>> On Mon, Jun 11, 2018 at 10:09 AM, Rafael J. Wysocki <rafael@kernel.org>
>>> wrote:
>>>>
>>>> On Mon, Jun 11, 2018 at 8:26 AM, Kai-Heng Feng
>>>> <kai.heng.feng@canonical.com> wrote:
>>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> There's a regression report [1] that says commit a192aa923b66a ("ACPI /
>>>>> LPSS: Consolidate runtime PM and system sleep handling") is the first
>>>>> bad
>>>>> commit.
>>>>>
>>>>> From the looks of it, it didn't introduce any behavioral change. So
>>>>> your
>>>>> help is appreciated.
>>>>>
>>>>> [1] https://bugs.launchpad.net/bugs/1774950
>>>>
>>>>
>>>> Well, the only difference is the iosf quirk AFAICS, but that should be
>>>> easy enough to check.  I'll try to cut a patch for that later today.
>>>
>>>
>>> If the iosf quirk is the source of the problem, the attached patch should
>>> help.
>>
>>
>> The one below should be slightly better, please test this one.
>
>
> Affected users reported that this patch solves the issue for them.

OK, thanks for verifying.  Let me add a changelog to it and resend it, then.

Thanks,
Rafael
