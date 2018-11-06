Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE4EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503ED20685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503ED20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbeKGAZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:25:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38058 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388800AbeKGAZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:25:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id v83-v6so10931139oia.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mvrppLPNyUmK9QoeGegp7B8KyARBY7NMFJppKuMgJ8=;
        b=iX4qZQ/5KrMVGU0MG+jiPOA4oS2GgjUQ732cPLU733Tb5ERM4a42g258Kc4hl8P0o+
         4UWpb8TKZpNcaAoPZE95cnFyfmP15R6SXfTgD5p7zSFQ2+SPfAiK3OQx+iJXQtgSbJ84
         SO90IP6uLBYzPA333TImdYwQsqIKyE1KlsQkaSfEvTz7ClTQjNTPb8pLUYtuOg6aFKK1
         NK615O46c6Vp2a6iubpok6kolmXlPMRA6Fw/C4HgsRvpp1vbTppTwLck4QdR2jEGZOAU
         h2wOcv6bPRqZUBIxkYKHQFZI6q8KLmFcoZA0AfZppR4UKo5av/Cl+q+47LgcXjL3ogj2
         chhg==
X-Gm-Message-State: AGRZ1gICKR4SuQS3eCSj+EQTswfaAq8qmTFMsdV7XKxeVAHd/2ibb1zl
        +Soo3sDej+p2mXYpisM4n5MqNUtiIsrPaoc1w/c=
X-Google-Smtp-Source: AJdET5e72JUGUlaZrjLcKt6ISVE+Q5FJuRPAqMx1meV9Prr2FPv8DF+SL//ruYx21PzTRBD/NnJNHYKDFJQafuXjNr8=
X-Received: by 2002:aca:f3d4:: with SMTP id r203-v6mr14225673oih.95.1541516366654;
 Tue, 06 Nov 2018 06:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20181106134630.29591-1-smuchun@gmail.com> <CAJZ5v0ifsQqkoFw2tossFKJAUkqDLdR9NpN3eZTn3t0xUz6K-g@mail.gmail.com>
 <CAPSr9jE8EbWue31LP18eF9+KysZHNRqHNrzif8H4NkCzHHtueQ@mail.gmail.com>
In-Reply-To: <CAPSr9jE8EbWue31LP18eF9+KysZHNRqHNrzif8H4NkCzHHtueQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Nov 2018 15:59:15 +0100
Message-ID: <CAJZ5v0iZo95ssiu3JcGJMgP+QrKLy0wu9vshk212FE3aY_kwoQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Add branch prediction hints in really_probe()
To:     smuchun@gmail.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 3:43 PM Muchun Song <smuchun@gmail.com> wrote:
>
> Hi Rafael,
>
> If we want the driver core to test driver remove functions, we can
> enable CONFIG_DEBUG_TEST_DRIVER_REMOVE. This option is
> just for testing it. So, in most cases, the option is disabled and the if
> condition is false. So I think we can add an unlikely() to it.

Yes, it can be added there, but does it really need to be added?

If the conditions are false all the time, the branch predictor in the
processor should be able to deal with it just fine.

And if they are false already at build time, the compiler should just
optimize them away.
