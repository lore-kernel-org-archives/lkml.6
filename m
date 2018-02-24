Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeBXSYI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 13:24:08 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:37767 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeBXSYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 13:24:07 -0500
X-Google-Smtp-Source: AG47ELsvh6vBmg8aZrxgpg6vB+/xu7RGdxFsWmiT3pFnEv/1+xON1OlJsgPJJWsMi8Or49/izVos1P5UNgc2bow78es=
MIME-Version: 1.0
From: Michael Menegakis <arxeio@gmail.com>
Date: Sat, 24 Feb 2018 20:24:06 +0200
Message-ID: <CAOQuFyEXvtW6NFKxE1ZO_6=V6jd=ZijFBn6t9Jj0D-Kha7UE3A@mail.gmail.com>
Subject: The usage of hid_have_special_driver() in hid_add_device() of
 hid-core.c makes the usage of /dev/hidraw cumbersome from user space.
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent patch of Wine allows to have proper access to raw HID for
bluetooth devices expressed at /dev/hidraw* and via libudev. This
generally opens the door to a wide array of windows software that
relies on raw HID access to be used on Linux.

However, the relevant code at hid_add_device() doesn't create a
/dev/hidraw at all if one wants to blacklist a kernel driver from
being loaded for that device! That renders userspace incapable to use
raw HID unless they recompile the kernel for each device.

Let me know if I miss something or if a recent patch I'm not aware of
alters that behavior. If not, I suggest to provide away to retain the
existence of /dev/hidraw# if a corresponding module is not loaded,
without requiring user space to recompile.

PS. In case that part wasn't clear: We can't use both a special driver
+ another user space driver access /dev/hidraw in several cases
because they may conflict. Therefore one has to recompile the kernel
currently in order to avoid conflicts.

PPS. I noticed the existence of ignore_special_drivers parm of hid
while I was finishing this message but that appears a catch-all. I
generally don't get why /dev/hidraw# isn't retained if a special
driver is unloaded (or not loaded) by default.
