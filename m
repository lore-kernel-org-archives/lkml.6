Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED1BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DED20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DED20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeIKM0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:26:54 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34106 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeIKM0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:26:53 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so45410284ois.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 00:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1IqzoYlci59ghZH2l9OfnFGuta9lFisMgOXdXkE1dhE=;
        b=ACRss7YWFlRcgXIosSk5NETd8FBUDFgyJ9545sfYpHVaWDKeD69q4Xp1PyKQAYM4G3
         4CSgJDBU5YLgJmKwc4kZaK4D+VJIRmT8YdL3sUf/NgWJU1iAPvXxlMGVIcCgRiC/iJJl
         dKhlLmMMe6yJVlbwFfFt4vkqRN3X/GTOOh8Z/wLG6/7beko9rvRlvkiD6esn77CUdOhk
         SUVu6jSz8ZxEjsIfxKQ56NZN2SwV9Ogcfn1deZW1aSkDLYjZeHxbvUl5Jm8KyfUShF5P
         GP8HM8mP6g/PLvDcfXvheF86qcuqW4AGyXN7LARyJGBI6rS3D8GgUxZFJkzs52C2PYPX
         qmbA==
X-Gm-Message-State: APzg51DXPGl8c2rH/G6hq5NS+HiIGYpLeCPUCPFsli+Fhoq/89/8l/j5
        MUkx807jQjQFWWsAdswUlMAFnq+Q1McYvBnkZ4coAw==
X-Google-Smtp-Source: ANB0VdapBxK0a545p9q0c+Ygmdbey6FCYesE84M5Xl2h0n2Q27/P1N5q72J8ZilEJb+Yvio/UZOAhG4JhOMceHKgQM8=
X-Received: by 2002:aca:ef0a:: with SMTP id n10-v6mr26684285oih.326.1536650935606;
 Tue, 11 Sep 2018 00:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180910124015.18073-1-fanc.fnst@cn.fujitsu.com> <20180911011331.GB8519@localhost.localdomain>
In-Reply-To: <20180911011331.GB8519@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Sep 2018 09:28:44 +0200
Message-ID: <CAJZ5v0g2SaGJLFM=Gb3Qr2JzGV_KiNW3xq3xP342YnNWkym=EQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory.
To:     fanc.fnst@cn.fujitsu.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, bhe@redhat.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        indou.takao@jp.fujitsu.com, Cao jin <caoj.fnst@cn.fujitsu.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 3:13 AM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> sorry, the cover letter forwand to rafael.

Thanks, but the relevant information still needs to go to the
changelog of the patch adding the extra ACPI tables parsing code.
Your cover letter will not be there in the git log.

I also would suggest to CC the entire series to linux-acpi along with
the cover letter.

Thanks,
Rafael
