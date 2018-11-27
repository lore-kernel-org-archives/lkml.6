Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC3FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA742086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WEKlRrRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA742086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeK0NNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:13:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40440 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeK0NNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:13:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so17636959edx.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKfX2QOlMx5VMoGw7J6PhvPcTQZgsXz/YbdHYaAMbko=;
        b=WEKlRrRDUgb9pX5oOLalZDUjKhhU23zpeeOMRlrwdJQyNji10myDKQ1eoZ7UZWuQ/A
         JGIyycL/FKiJBe5EYJaK/kMo/wH9vK9shVALFPCOwrW4nxZ8Y/WaEjloDAeTm3dZVIH+
         XkQoaLw57QASaYbNm2vRnYjHA8I3OKEvDXJ4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKfX2QOlMx5VMoGw7J6PhvPcTQZgsXz/YbdHYaAMbko=;
        b=ZqnhWGIPxDKUKmIexBRRGQk0Hhzq2kcmo+KdVVSMOBMlJXy4TPMP3p25gBKj7lU5vd
         9ilXUglWoSeYutgUzY8wl0QHNEzwOBfPg0xfAb8WhIk+4bETteW/7Dy9flVM7i7dCqTx
         hPtJOa5na0pmzRct5T1LMrm1T0wZcacULJgl5G/buJjemvZNwQcjXWTrR77ktsNV46n4
         1dTLj/+tAtIUOujzynqL8hgbnPmXOf6T7+bfnjtLNpjr3IRYdXiyDRBRzFZ8I7g1JTSQ
         pe7fNPN076UWXXBUcl6y5krV0hXlUJ6fvx8XvNpYe32cTqEmgCzulyJYcN2kMtb4mROa
         6zLw==
X-Gm-Message-State: AA+aEWYxd8netWlwFtG98CMOA0dhwdAx93i0shsOnUpbfrtDgSv/4LcJ
        uifQJtcC8kDAbfwiR+Xhlxg4yoEWdBo=
X-Google-Smtp-Source: AFSGD/VTZ70q/9GtGUFnFkqm0kgHhbKbhmTfXbTqZEoIKuDP++xA/ieP+vEjBQDhzRT3zwybmZFmdQ==
X-Received: by 2002:a50:f284:: with SMTP id f4mr24875738edm.77.1543285049006;
        Mon, 26 Nov 2018 18:17:29 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id b14sm572130edt.6.2018.11.26.18.17.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 18:17:27 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id r10so20977846wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:17:27 -0800 (PST)
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr12602680wrj.107.1543285047147;
 Mon, 26 Nov 2018 18:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
 <20181122063409.15816-5-peter.hutterer@who-t.net> <20181122232839.GA10747@jelly>
In-Reply-To: <20181122232839.GA10747@jelly>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Mon, 26 Nov 2018 18:17:15 -0800
X-Gmail-Original-Message-ID: <CA+jURcv+1xWUR=xabVr+70LthoQqNbLZ_a8zTXxEeLrG4=wohw@mail.gmail.com>
Message-ID: <CA+jURcv+1xWUR=xabVr+70LthoQqNbLZ_a8zTXxEeLrG4=wohw@mail.gmail.com>
Subject: Re: [PATCH 4/8] HID: input: use the Resolution Multiplier for
 high-resolution scrolling
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 at 15:28, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> The choices we have now are:
> - use 1200 or 12000 internally and divide by 10 before sending the
>   final value
> - just make the evdev API use 1200 or 12000 and let userspace deal with it.
>   much simpler.
>
> Any suggestions/comments?

The second option seems cleaner to me, as then we don't have multiple
representations of the scroll amount to get mixed up.

Harry Cutts
Chrome OS Touch/Input team
