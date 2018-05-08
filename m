Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932815AbeEHXRi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 19:17:38 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:44937 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755759AbeEHXRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 19:17:37 -0400
X-Google-Smtp-Source: AB8JxZqIN1YCR2VntlFr8eA6LMgg6EGpkgUWqh+3nlsVM8Ap3wRjhx9XDfrXXer0oXHhQ9KXO1CFHYU1dQlRnPbhNIk=
MIME-Version: 1.0
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 8 May 2018 16:17:35 -0700
Message-ID: <CALAqxLVJekViPWi4kh2JOQ46XXtTv2-2BXOe9O8AvfnvX9Z+Sw@mail.gmail.com>
Subject: Userland breakage from "Modify the device name as devfreq(X) for sysfs"
To: Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc: Dmitry Shmidt <dimitrysh@google.com>, Leo Yan <leo.yan@linaro.org>,
        Jean Wangtao <kevin.wangtao@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,
  I wanted to bring up an issue we've recently tripped over, which was
caused by 4585fbcb5331f ("PM / devfreq: Modify the device name as
devfreq(X) for sysfs").
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=4585fbcb5331fc910b7e553ad3efd0dd7b320d14

That patch replaced paths like:
   /sys/class/devfreq/ddr_devfreq/min_freq
and
  /sys/class/devfreq/e82c0000.mali/min_freq

With
  /sys/class/devfreq/devfreq(0)/min_freq
and
  /sys/class/devfreq/devfreq(1)/min_freq


This broke userspace we have that needs to work on 4.4, 4.9 and 4.14 (and on).

I wanted to try to ask to understand more about the rational for this
patch, as it doesn't make much sense to me, particularly as now it is
less obvious as to which path is for which device  - and more
worrisome it could change depending on initialization order.

Unfortunately, this wasn't noticed very quickly, as the patch has been
upstream now for some time.  But I wanted to better understand why
this change was made, and see if we might consider reverting it, or
alternatively consider provide multiple sysfs links (both dev_name and
devfreq(N)) so that we can preserve compatibility?

Thoughts?
-john
