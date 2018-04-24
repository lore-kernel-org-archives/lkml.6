Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932711AbeDXAtj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 20:49:39 -0400
Received: from genki.is ([159.203.135.224]:32942 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932635AbeDXAti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 20:49:38 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 genki.is E5D6040040
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: David Herrmann <dh.herrmann@gmail.com>
From: Genki Sky <sky@genki.is>
In-Reply-To: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com>
Message-ID: <2580c734d38041e984215ccc522a4f2d@genki.is>
User-Agent: alot
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock BOOTTIME
Date: Mon, 23 Apr 2018 20:40:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3O0njni023190

  Hello,

I came across this thread for same reason as [0]: Daemons getting
killed by systemd on resume (after >WatchdogSec seconds of
suspending). I'm using master branch of systemd and the kernel. As
mentioned, systemd uses CLOCK_MONOTONIC, originally expecting it to
not include suspend time.

Correct me if I'm mistaken, but I don't see the ambiguity of whether
this patch series breaks systemd. If it's implemented correctly, you'd
hope it *would* break it!

As a random end user, I see three options to get suspend/resume
working again on my laptop:

(A) Change systemd to keep track of the difference between
CLOCK_MONOTONIC and CLOCK_MONOTONIC_ACTIVE, using their difference via
clock_gettime(). This seems to be what the author of this patch series
intends (?).

(B) Implement timerfd_*(2) for CLOCK_MONOTONIC_ACTIVE in the kernel.
Do a sed s/CLOCK_MONOTONIC/&_ACTIVE in systemd source code.

(C) Do a 90% reverting of this patch series. Just introduce
CLOCK_MONOTONIC_ACTIVE as the "what you should use", document and
publicize this fact, and sometime in the future (monotonically
speaking :) finally unify CLOCK_MONOTONIC and CLOCK_BOOTTIME.

Thoughts?

Also, agreed, the missing break in do_clock_gettime() should be fixed,
as David mentioned in [1]. Is someone already patching this?

[0]: http://lkml.kernel.org/r/CANq1E4Tf27FJHTrO4ZVtWhYK=DLmwzszK=njOpgXZZXqzAOunA@mail.gmail.com
[1]: http://lkml.kernel.org/r/CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com

  Genki
