Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529EAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3BE223C6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aNTfh0tQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3BE223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeK2KGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:06:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43644 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeK2KGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:06:43 -0500
Received: by mail-ed1-f67.google.com with SMTP id f4so276941edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CE12QcvRz4bHEK5BSf8wl4z8hyf5jvjQNuVNADkpqQ=;
        b=aNTfh0tQCfu/WQuvF456yrd8VOLEWkoasgCAK0KiTtoDWSC7/9Q1aWBel6kDK6cY8a
         GmL7VVHstPd7pfZ7pSxv+UVzEDSBkbVhtBXtFsbCI7b2sFjDcjOgnGJgN49paxW623nF
         a17/3mq9xuPrUOuKfpvIbT7LeXXb8HOvEdxbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CE12QcvRz4bHEK5BSf8wl4z8hyf5jvjQNuVNADkpqQ=;
        b=KNjuqptcH/qGIDjdHiZF60tWhwRRamrhzQE0+ipSlePScC+/LQrGTTYQspcexJSaBK
         NE+2HuCDwXBfHcpGhNgw4MZlv/rPCxjHcXSyYsebeVbhdKawo6wDeJFYvNIOuS7tizhH
         KnMMMId63J7AcY12qQWAzXlx25Y9yEYYI3HkvKaaNqt9nTAfsZlt7XV94Psqi37gciF5
         giAEJu3bgPLGfOG4i3zZ43hfFymOib3JMaq8cNHVTcXI9/SQA3EOkfN6hxBd9d/UrM73
         DGa4i5ifUNl7RPcrEUzyIpGJFy4EJKPPj6ZtETE3clE5V6WJWMDgtRRj99y9bDJMByR+
         KGag==
X-Gm-Message-State: AGRZ1gL5Y1RPVwDo2ShUcam9vykiNty31ZSvvP0ZJDEqqT486xYZFSIE
        eLCjMeV6dh10ASHkKb2m5lcEUWtgzss=
X-Google-Smtp-Source: AJdET5cE7/5iIU3cOxlkUAEWeSqxzjaX334TFOdFT/eCouyk6SNplc92g/aKlPUoIw63NBvOoW9pnA==
X-Received: by 2002:a17:906:38e:: with SMTP id b14-v6mr28269003eja.209.1543446207562;
        Wed, 28 Nov 2018 15:03:27 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id f19-v6sm48956eje.28.2018.11.28.15.03.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 15:03:26 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id s14so353328wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:03:26 -0800 (PST)
X-Received: by 2002:a1c:c483:: with SMTP id u125mr4349361wmf.14.1543446205677;
 Wed, 28 Nov 2018 15:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20181122063409.15816-1-peter.hutterer@who-t.net> <20181122063409.15816-9-peter.hutterer@who-t.net>
In-Reply-To: <20181122063409.15816-9-peter.hutterer@who-t.net>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Wed, 28 Nov 2018 15:03:13 -0800
X-Gmail-Original-Message-ID: <CA+jURcs30_4Lw0ZvAj2C_XG9TjSNfJs6AKtw+TmZdSE+_ithfQ@mail.gmail.com>
Message-ID: <CA+jURcs30_4Lw0ZvAj2C_XG9TjSNfJs6AKtw+TmZdSE+_ithfQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
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

Hi Peter,

Thanks for the work you've put into this!

On Wed, 21 Nov 2018 at 22:35, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> * HID++ 1.0: Anywhere MX, Performance MX
> * x2120: M560
> * x2121: MX Anywhere 2, MX Master 2S
> [snip]
> This was tested on an MX Anywhere 2S, Harry, please re-test on the other
> mice, thanks.

Sure, I've tested the V2 patch with the original five mice quoted
above, as well as the M325, which doesn't have a high-resolution wheel
but which I used to check that it still reports a REL_WHEEL_HI_RES
axis and reports movements of 120 on it.

The only issue I noticed is that the M560 doesn't report a
REL_HWHEEL_HI_RES axis, even though it has horizontal tilt scrolling.
(The M325 also has horizontal tilt scrolling and does report a
REL_HWHEEL_HI_RES axis.) This is probably because the M560 has a lot
of special treatment in the driver (see `m560_populate_input` and
`m560_raw_event` in particular).

Other than that:
Verified-by: Harry Cutts <hcutts@chromium.org>

Harry Cutts
Chrome OS Touch/Input team
