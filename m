Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A424C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9542081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jCzBNf5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9542081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeJaCnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:43:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46962 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeJaCnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:43:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id v18-v6so11273725edq.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hw4d6rOdT80jngEvhuprpfvAvrlSV1+fKlVWPWdXFlw=;
        b=jCzBNf5c0+d08OjJ0xSCsbMI2ZsyvRtGvzdOM7GIQNljnZi5JO6TGeQUf4h9ly4kNx
         7+cNvMyoJMcIBTqCrc8nx3mpOZwpfHBTYxf5JAvGpLAh3z5CNAMnGrvm7WTuRhMVpx0i
         dyM1jpW+unVmtHLQBCpe+fRP7cHcU5+nIKy9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hw4d6rOdT80jngEvhuprpfvAvrlSV1+fKlVWPWdXFlw=;
        b=Iz6u6j+QKpstV/UNJ33SvtcuGEuRoAakKWXp+HRZyqsxP/ylxNqPFOb58cScrCgR2I
         7ncuG+lQkfOxYfo4HveDdQnjop0oNy954TtDvYa18MK3yfwh5u6OMerH9KGarhVd5TxF
         oKFVLVo0dwWMrZkiAtmn+3ZhOs453yExYlsRIUANbVp/Xumf7GTY1hCCzMzrgrqLoj55
         1gMOE7WUPL40dY9rkUH9KjfqPMfTWbA4vt3NXGQgnH5/jOhF5u6p7tRkG1duUxS0kCPM
         uufqL95cgmM7OV5bVcWrMboVEzXXOvQUI9Y2CmRFSSWQHtfBk7+htaoYiKRBAoV0ZvWv
         tYOw==
X-Gm-Message-State: AGRZ1gLYqy98KJPchMSs81xIw4bA67ll1A9iFnFx6iyUz41vSzI0kvz6
        /XPLKMlTLZclygTu0Fin6awB+LCLtX0=
X-Google-Smtp-Source: AJdET5ctNG039Ys0jEjUjTwc6/l9DUCololYbPmltGcgnu8xv1xBcBAOG6xDypsa30TmTWEC9HuXXg==
X-Received: by 2002:aa7:d410:: with SMTP id z16-v6mr18312055edq.26.1540921719898;
        Tue, 30 Oct 2018 10:48:39 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id f3-v6sm1994112edr.64.2018.10.30.10.48.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 10:48:38 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id t10-v6so13577785wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 10:48:38 -0700 (PDT)
X-Received: by 2002:adf:f90f:: with SMTP id b15-v6mr12802718wrr.178.1540921717759;
 Tue, 30 Oct 2018 10:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
 <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
 <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
 <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
 <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
 <CA+jURcvAQWP-fMLxNBF=PZ7moJZgorjO0SGXn8xSWKt=k+oe1w@mail.gmail.com>
 <20181030062657.GA5380@jelly> <CAHk-=wg5m-zt0Kc0o1mOaZSKUsWbjud9xjZssoHAth=ZxoAhQg@mail.gmail.com>
In-Reply-To: <CAHk-=wg5m-zt0Kc0o1mOaZSKUsWbjud9xjZssoHAth=ZxoAhQg@mail.gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Tue, 30 Oct 2018 10:48:25 -0700
X-Gmail-Original-Message-ID: <CA+jURctDNnVjKEZD6jm3ACv1r8_Me9f+6T_aRiApR=Nd_+upvw@mail.gmail.com>
Message-ID: <CA+jURctDNnVjKEZD6jm3ACv1r8_Me9f+6T_aRiApR=Nd_+upvw@mail.gmail.com>
Subject: Re: Logitech high-resolution scrolling..
To:     torvalds@linux-foundation.org
Cc:     Peter Hutterer <peter.hutterer@who-t.net>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the analysis, Peter.

On Mon, 29 Oct 2018 at 23:27, Peter Hutterer <peter.hutterer@who-t.net> wro=
te:
> IMO this is a lost battle because you cannot know when the ratchet is
> enabled or not (at least not on all mice). Users switch between ratchet a=
nd
> freewheeling time and once you're out of one mode, you have no reference
> to the other mode's reset point anymore.

It would be a lost battle, if it weren't for the fact that on all the
mice I've tested, putting the wheel back into clicky mode causes the
wheel to jump to the nearest notch resting point, which should mean
that the remainder resets to 0 (or maybe =C2=B11 if the mechanism is worn).

> So my suggestion is to combine Linus' reset with your approach and use th=
e
> center-point for the trigger. This gives us a few events to slide and sti=
ll
> do the right thing, and any direction change will reset anyway. Biggest
> drawback is that the first event after a direction change is triggered
> faster than the next event. Otherwise it feels correct to me, both in
> free-wheeling and in ratchet mode now.

This sounds like a reasonable approach if we find that we can't keep
the triggering point consistent.

> Also, WTF moment: I managed to get the mouse into a state where it would
> only give me 1 hi-res event per notch movement but failed to reproduce th=
at
> again.

Interesting; let me know if you manage to reliably reproduce it. The
only time I've encountered this in the past was when connecting to the
mouse over BLE, where we don't seem to be able to detect if the mouse
is power cycled (meaning that the mouse resets to low-res mode but the
kernel is still expecting high-res reports). I held off on enabling
high-res scrolling over Bluetooth for this reason.

On Tue, 30 Oct 2018 at 09:29, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I wonder if there's some docs on what Logitech does internally in the
> mouse. It might involve a timeout (ie "if not moving for a while, do
> the rounding _and_ reset), which would probably be too expensive to do
> on the host side.

I've been wondering this as well. Nestor (CCed), is there anything you
can tell us about this?

Harry Cutts
Chrome OS Touch/Input team
