Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A948AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF1320684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c5IQ7ntQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF1320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392230AbeKWDqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:46:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33407 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732667AbeKWDqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:46:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so8559559ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cn/wxTBq2taxHU9QQJnCgVvU+LT4pCPMmAtsJ7XjpiM=;
        b=c5IQ7ntQMIDJaQuujnwPkUaDxbJPZTTSojL3yTA0LhehxLjh/EnqhcEC0P6jFuPQAU
         UhGBgBFEguHfxnLBPMKN0hmSyp9UmlwZwgzkBGFCTKDM5jgVKzXXNK9ZLtoN8DBxjaHH
         29sYrNuKk7AFLAoKK76XPrUGtvPPBYldB5I1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cn/wxTBq2taxHU9QQJnCgVvU+LT4pCPMmAtsJ7XjpiM=;
        b=WC5l2Typ8CDHIM44mBHhxYI/mUFpUTy6E99sVZ009vccWcmp8HbK8L+zBvvh9y9M5W
         MyV0ixMbAx8oXgVBZpDLgPcVDRbUEqx9C43zVxj/nFMojPddUyWMkMHo1ZrdXpqWQDaR
         xeT5wNJHrEE9EgckCjikb1z6GkYEN+DTqgtRG4aNiDV1eOk3Nm18bSWoSQSCV5C2HNMa
         VnD9xj9ChFR1vFWzREf8vfRSJAUs5rKb2EAtmgnLMxYB++3LPVbNfaxLhmacyQTI0NLQ
         pHTlXk3A2ZTsJMySqxT6QNTwOoJM95vd1iW7pRp3V3GknyaEJahIX0LwE6Q5d0mRyPxL
         qeGw==
X-Gm-Message-State: AA+aEWYY8I+SLDNIYWshkbY0qCe6Y+4zsPsLWftA57SA+2bvh6uH2WlK
        WqvzBgGoYvQByNDG3SwcZH3Cn3Ue5rPNOw==
X-Google-Smtp-Source: AFSGD/VfMjhtG7LtIavb/FesWPeIA1AsV+HqjnbhKurCIA/B9LWBZ3sRoNOTtqC1bYrP0vHmRmV7NA==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr8112692ljb.52.1542906365791;
        Thu, 22 Nov 2018 09:06:05 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id p77-v6sm8465300lja.0.2018.11.22.09.06.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 09:06:04 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id e26so6995607lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:06:04 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr6782122lfa.106.1542906363913;
 Thu, 22 Nov 2018 09:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20181122063409.15816-1-peter.hutterer@who-t.net> <20181122063409.15816-9-peter.hutterer@who-t.net>
In-Reply-To: <20181122063409.15816-9-peter.hutterer@who-t.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Nov 2018 09:05:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9pB3k6kuKHUfxeMaCLqm35CJs3W1kQteEHR5r8G4RUQ@mail.gmail.com>
Message-ID: <CAHk-=wh9pB3k6kuKHUfxeMaCLqm35CJs3W1kQteEHR5r8G4RUQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>, nlopezcasad@logitech.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:35 PM Peter Hutterer
<peter.hutterer@who-t.net> wrote:
>
> This patch is a combinations of the now-reverted commits 1ff2e1a44e0,
> d56ca9855bf9, 5fe2ccbef9d, 044ee89028 together with some extra bits for the
> directional and timeout-based reset.

Instead of using an actual timer (which is quite expensive), how about
just saving the "last time" data along with the remainder?

We have a fairly low-overhead 'sched_clock()' function that gives a
clock approximation in nanoseconds (64 bits). Note that it doesn't
actually give nanosecond precision - it might fall back to jiffies for
hardware that doesn't have anything better, but for timeouts on the
order of a second, it's fine.

                      Linus
