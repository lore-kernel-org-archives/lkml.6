Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3631C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A5D2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A5D2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeH1Q37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:29:59 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36126 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH1Q36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:29:58 -0400
Received: by mail-qt0-f180.google.com with SMTP id t5-v6so1431432qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 05:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCqjS7Z13C+VdmB7nErIoWjLyg5hCdYBA5g2QlPvym8=;
        b=DenCLYdycfCqF+64VGX44Y/Ep/J1PlnMXM3cwlY/M/z1seO3rDoJYp/vJshh7M+XMo
         hxUX06u5qMqycIsEvwjvSm9c3R3RyPUbudoVlSi03HTXUxaiK9KyVb5muAE2BeYQv/Pj
         d3+nEicHbpMKhIEhdtJOJW95Vrod00P4HeutcQjSyFIg7cn8li5it44IFQ4DK8GU42cY
         XRhcGukgGC5jeh86K7PFfZABSe9HU64TZg1LRbMOlwAa46aLp4GlezLRRV7pF8VdsoOf
         0FkTJgOn/fRtfUzbUUpO1eQw4bol/NP1DszK3/sMMcXN5v+Y9DolUs114EelEuPB5umL
         6Pyw==
X-Gm-Message-State: APzg51AhgCVB2OnkPZ6ANPPopsdjH5Gb4Xzpj9HZ0XfLgu/tV+qMT+E/
        CV1um5nrUeaPY4IzhDS/P5QcQSy/yLinEI3ZUotbzg==
X-Google-Smtp-Source: ANB0VdYNgAcWh4gE69ijR618yeZx3rUWtk3JzKG7iM20sVjYfGF4n7ZbMZ+K6tgZsTqTTl1O8g6SfcGSvQorJjcweTY=
X-Received: by 2002:a0c:d647:: with SMTP id e7-v6mr1252888qvj.238.1535459910518;
 Tue, 28 Aug 2018 05:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180821085513.13739-1-acelan.kao@canonical.com> <nycvar.YFH.7.76.1808281346150.25787@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1808281346150.25787@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 28 Aug 2018 14:38:18 +0200
Message-ID: <CAO-hwJLfpYr6bmTH=rcSfET61599VoZp4uEJ7uY62R2dSSfn6A@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Fix flooded incomplete report after S3 on
 Rayd touchscreen
To:     Jiri Kosina <jikos@kernel.org>
Cc:     acelan.kao@canonical.com, Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 1:46 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 21 Aug 2018, AceLan Kao wrote:
>
> > The incomplete report flooded after S3 and touchscreen becomes
> > malfunctioned.
> > [ 1367.646244] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/18785)
> > [ 1367.649471] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/28743)
> > [ 1367.651092] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/26757)
> > [ 1367.652658] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/52280)
> > [ 1367.654287] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/56059)
> >
> > Adding device ID, 04F3:30CC, to the quirk to re-send report description
> > after resume.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
>
> Applied, thanks.

Just a quick note Jiri. Hans pointed me this morning to
https://bugzilla.redhat.com/show_bug.cgi?id=1622695

And I think we should apply the quirk unconditionally as it should be
safe to retrieve the HID descriptor at all times. I am planning on
working on that tomorrow or Thursday when I have access to the XPS
with i2c_hid devices attached to it.

Cheers,
Benjamin

>
> --
> Jiri Kosina
> SUSE Labs
>
