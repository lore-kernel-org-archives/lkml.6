Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933783AbeBMI2X (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:28:23 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41271 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933692AbeBMI2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:28:19 -0500
X-Google-Smtp-Source: AH8x227JW2PdjFfooVHpY6eGmT3J2mHL7+b5bB6yD4MyWvbmK5AyP+jfKsYv83WtuNRiZctukKIVcOehxGOIcE9r32Y=
MIME-Version: 1.0
In-Reply-To: <20180213072328.GA1636@1wt.eu>
References: <1516095490-83827-1-git-send-email-wangxiongfeng2@huawei.com>
 <CANiq72=AeytaT5KBtujTBUkfbNTFFxMPAeToqzmZJOr790R6yw@mail.gmail.com>
 <a1034df8-246d-e979-e2ee-2974ae31dde7@huawei.com> <20180213072328.GA1636@1wt.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Feb 2018 09:28:18 +0100
X-Google-Sender-Auth: cRYIMcEvIT_M7Ve6JGdFOWmv4ng
Message-ID: <CAK8P3a0k=XTmys46cvAd2k-TRPO0YLawFur4PzGA_scwr5mChQ@mail.gmail.com>
Subject: Re: [PATCH V2] auxdisplay: use correct string length
To: Willy Tarreau <w@1wt.eu>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Dan <dan.carpenter@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 8:23 AM, Willy Tarreau <w@1wt.eu> wrote:
> On Tue, Feb 13, 2018 at 09:19:21AM +0800, Xiongfeng Wang wrote:

>> This may suppress the gcc warning.
>
> In fact there are two big problems with gcc warnings :
>   - writing -Wno-something-unknown triggers an error on versions where
>     "something-unknown" isn't known, making it difficult to permanently
>     disable warnings (though in the kernel we handle this pretty fine)

We have the $(call cc-disable-warning) helper for this.

>   - warnings and diagnostics are conflated. Some warnings should only be
>     provided when the developer explicitly asks for suspicious stuff
>     (-Wsecurity, -Wsuspicious, etc) that would *not* be part of -Wall
>     since -Wall is usually used to report real warnings.

And this is what the W=1 and W=2 make options are for.

I originally asked Xiongfeng to look at some of the new gcc-8 warnings,
but must have miscommunicated at some point. I think we do want to
enable the new -Wstringop-overflow warnings by default and fix all
instances, including the false-positive ones. This is a useful warning
because it tells you when you actually write past a buffer, e.g. using
strcpy() with a source string that is longer than the destination.

For  -Wstringop-truncation, we can decide whether it should be W=1
or W=2, but I'd still make it possible for users and maintainers to
easily enable the warning when test building new code.

       Arnd
