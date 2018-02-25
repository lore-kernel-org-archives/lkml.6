Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeBYXyt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 18:54:49 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:45070 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeBYXyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 18:54:44 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.101.1) smtp.mailfrom=rabel@robertabel.eu smtp.helo=buildbert.robertabel.eu
From: Robert Abel <rabel@robertabel.eu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Robert Abel <rabel@robertabel.eu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: charlcd: fix hex literal ranges for
 graphics command
Date: Mon, 26 Feb 2018 00:54:28 +0100
Message-Id: <20180225235432.31209-1-rabel@robertabel.eu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
X-PPP-Message-ID: <20180225235442.31368.42173@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch set fixes the x/y coordinate addressing issue I mentioned earlier
as well as not marking the two-line command sequence as processed resulting in a confusing
state.

I implemented the logic around using kstrtoul by terminating the substrings that contain
numbers for each command separately and then restoring the command character following the
number that was overwritten.

Additionally, the code now doesn't write live to the x and y address fields and will
bail out if an unknown command character or an invalid number was encountered.

I did try to keep it backwards compatible, so sequences of the form ^[[Lx0y1x2y4; will
still work (and result in x2y4).

Additionally, I noticed that the ^[[H home function was just resetting the x/y coordinates
but not the display shift, which results in a situation where the display cannot be
programmatically unshifted (except for init ^[[LI). So I implemented the HOME command 0x02
for charlcd_home. The old behavior can be simulated using ^[[Lx0y0; (just reset x/y, don't
unshift).

I tested on my Raspberry Pi Zero W with a clone 1602 display.

Robert Abel (4):
  auxdisplay: charlcd: fix two-line command ^[[LN not marked as
    processed
  auxdisplay: charlcd: name x/y address struct
  auxdisplay: charlcd: fix x/y address commands
  auxdisplay: charlcd: make home command unshift display

 drivers/auxdisplay/charlcd.c | 76 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 16 deletions(-)

-- 
2.11.0
