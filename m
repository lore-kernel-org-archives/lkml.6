Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8635C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B574C20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfAGIFU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:05:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36259 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfAGIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:05:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so24897709qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 00:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=50a0MKEQeWMUI+zOVz7NUtyN/qtB/I7FfAlGx84PPu8=;
        b=Qs64YimvtgSdVJpfeKkdCsZKe7g1ALjeflJuYe4HsiuMOP0r7BkztS7dUaH8JU1zXi
         65S2OqtX1kBmt1cstDY7JfUwFW802q6BDFDtgNUgjDcUHizLj62ErfQZ9l58XNZmgHLT
         Qg1C6ZmzCjWRn3+0jIXYk765fwUrPc1RPMXymnGamqc08HtZ8pt2BHmLNCOSAMATtT9n
         9TfehZ9Cvi6VMnnmzNDmFRZRHVcRNr/MiDAI1ViEQ0PO4zeBvBU15MLK8+g4kGN2RmYs
         6zftRaBiULDG/WDjh24BPdzRKEh+XxMgvKvHhWYlXoCi+0WLGPmSc1l4CuixAaX2RgEK
         sSkQ==
X-Gm-Message-State: AJcUukeL761BzVq7m2O4pqTXRNyDymtDRU+2AMjWQRSq6Rfc1G61Dp28
        6p8GrP73PqZ36xc/HEb+d+D3ZKT4MdywQaKZpW7ZvA==
X-Google-Smtp-Source: ALg8bN5BM/gZkN/DyGL2hBCV7Nzqo2+70cFTAy8KWzHcN4bZLwZ1eWOqLOzaDRHrj15DEW1zwyRJSMyzWTsL9ukoPB8=
X-Received: by 2002:a37:9d8a:: with SMTP id g132mr12513397qke.192.1546848319148;
 Mon, 07 Jan 2019 00:05:19 -0800 (PST)
MIME-Version: 1.0
References: <20181228175327.14863-1-kaelinphilipp@gmail.com> <F09EA46C-73C3-48A8-9105-F4DE55D7FBB6@canonical.com>
In-Reply-To: <F09EA46C-73C3-48A8-9105-F4DE55D7FBB6@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 7 Jan 2019 09:05:07 +0100
Message-ID: <CAO-hwJLW2rqz+SOPULTY=a51AeACNYNnePcUvuA0WGidvn8Nqg@mail.gmail.com>
Subject: Re: [PATCH] Elantech Touchpad: Fix Elantech touchpad and trackpoint
 for Lenovo ThinkPad notebooks.
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Philipp Kaelin <kaelinphilipp@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

On Sun, Jan 6, 2019 at 10:44 AM Kai Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Benjamin,
>
> > On Dec 29, 2018, at 1:53 AM, Philipp Kaelin <kaelinphilipp@gmail.com> wrote:
> >
> > Initial situation:
> > - The touchpad of a Lenovo ThinkPad L580 doesn't work with newer kernel versions eg. 4.20
> > - It used to work on earlier versions eg. 4.14
> >
> > Cause:
> > - The elantech driver was adapted in to support SMBus wich not all firmware versions
> >  of the elantech firmware support. The SMBus is used as default.
> >
> > Solution:
> > - Previously a blacklist was introduced for devices which doesn't support the access using SMBus.
> >  The ThinkPad P52 and P72 have already been fixed by adding it to such a blacklist in a prevois patch.
> >  The exact same solution fixed also the issue on the mentioned ThinkPad L580.
> >
> > Change:
> > 1) The firmware id of the ThinkPad L580 was added to this blacklist.
> > 2) To not have a half baked solution the information which firmware versions are using the same driver
> >   and therefore most probably have all the same issue was extracted from the Lenovo Windows driver package.
> >   All these firmware versions are now also added to the blacklist.
>
> I actually have a reversed situation:
> I’d like to make Elantech touchpad defaults to SMBus on some platforms, but the firmware version does not match to ETP_NEW_IC_SMBUS_HOST_NOTIFY().
>
> Use whitelist is obviously a bad idea so I’d like to know do you have any better approach in mind?

TL;DR: I think there is no other solution than using a whitelist.

Well, that's not entirely true. There is a bit in the old touchpads
that says if it can be used by an other bus (I2C, SMBus or something
else). But the problem is that those touchpads have been around for a
quite a long time, and blindly switching them to SMBus would likely
introduce regressions on old hardware we don't want to support
anymore.

I chose to only enable the new ones because I thought it would prevent
me for having to deal with many issues, and you can see the result. At
least, all of those machines are from the latest generation (or
previous generation) so it doesn't seem to be a bad idea to try to fix
them.

So I'd say for the old touchpads that do not have
ETP_NEW_IC_SMBUS_HOST_NOTIFY(), we should likely stick with a well
defined whitelist so we can control the damages.

Cheers,
Benjamin
