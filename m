Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeB1NiP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:38:15 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:45721 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbeB1NiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:38:13 -0500
X-Google-Smtp-Source: AG47ELvy32KD71A7+Pj6ELq9+HCt0CW9s2JI5g98gXVfAwId6FuHVrGa0/o93bXAJZ8zbIcae48TZQ==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fix deadlocks in autosuspend
Date: Wed, 28 Feb 2018 14:37:57 +0100
Message-Id: <20180228133803.30040-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have not recieved any feedback on these so I resend them.

I got this deadlock on my own driver (pxrc) when using the same
construction.

Please have a look

Here is a clip from 
[PATCH v3] input: pxrc: new driver for PhoenixRC Flight Controller Adapter [1]
that describes the problem.

-------------------------------8<----------------------------------------------
Also, I think we have a deadlock in the synaptics_usb driver.

When the device is suspended and someone is open the device, the input
subsystem will call input_open_device() which takes the
input_dev->mutex and then call input_dev->open().

synusb_open() has a call to usb_autopm_get_interface() which will
result in a call to the registered resume-function if the device is
suspended. (see Documentation/driver-api/usb/power-manaement.rst).

In the case of snaptics_usb, it will take the input_dev->mutex in the
resume function.

I have no synaptic mouse, but tested to put the same code into my
driver just to confirm, and got the following dump:

[ 9215.626476] INFO: task input-events:8590 blocked for more than 120 seconds.
[ 9215.626495]       Not tainted 4.15.0-rc8-ARCH+ #6
[ 9215.626500] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 9215.626507] input-events    D    0  8590   4394 0x00000004
[ 9215.626520] Call Trace:
[ 9215.626546]  ? __schedule+0x236/0x850
[ 9215.626559]  schedule+0x2f/0x90
[ 9215.626569]  schedule_preempt_disabled+0x11/0x20
[ 9215.626579]  __mutex_lock.isra.0+0x1aa/0x520
[ 9215.626609]  ? usb_runtime_suspend+0x70/0x70 [usbcore]
[ 9215.626622]  ? pxrc_resume+0x37/0x70 [pxrc]
[ 9215.626632]  pxrc_resume+0x37/0x70 [pxrc]
[ 9215.626655]  usb_resume_interface.isra.2+0x39/0xe0 [usbcore]
[ 9215.626676]  usb_resume_both+0xd2/0x120 [usbcore]
[ 9215.626688]  __rpm_callback+0xb6/0x1f0
[ 9215.626699]  rpm_callback+0x1f/0x70
[ 9215.626718]  ? usb_runtime_suspend+0x70/0x70 [usbcore]
[ 9215.626726]  rpm_resume+0x4e2/0x7f0
[ 9215.626737]  rpm_resume+0x582/0x7f0
[ 9215.626749]  __pm_runtime_resume+0x3a/0x50
[ 9215.626767]  usb_autopm_get_interface+0x1d/0x50 [usbcore]
[ 9215.626780]  pxrc_open+0x17/0x8d [pxrc]
[ 9215.626791]  input_open_device+0x70/0xa0
[ 9215.626804]  evdev_open+0x183/0x1c0 [evdev]
[ 9215.626819]  chrdev_open+0xa0/0x1b0
[ 9215.626830]  ? cdev_put.part.1+0x20/0x20
[ 9215.626840]  do_dentry_open+0x1ad/0x2c0
[ 9215.626855]  path_openat+0x576/0x1300
[ 9215.626868]  ? alloc_set_pte+0x22c/0x520
[ 9215.626883]  ? filemap_map_pages+0x19b/0x340
[ 9215.626893]  do_filp_open+0x9b/0x110
[ 9215.626908]  ? __check_object_size+0x9d/0x190
[ 9215.626920]  ? __alloc_fd+0xaf/0x160
[ 9215.626931]  ? do_sys_open+0x1bd/0x250
[ 9215.626942]  do_sys_open+0x1bd/0x250
[ 9215.626956]  entry_SYSCALL_64_fastpath+0x20/0x83
[ 9215.626967] RIP: 0033:0x7fbf6358f7ae


tablet/pegasus_notetaker.c and touchscreen/usbtouchscreen.c has the same
construction (taking input_dev->mutex in resume/suspend and call
usb_autopm_get_interface() in open()).

I will create a separate "pm_mutex" to use instead of input_dev->mutex
to get rid of the lockups in those drivers 

-------------------------------8<----------------------------------------------


[1] https://lkml.org/lkml/2018/1/20/191

Thanks,

Best regards
Marcus Folkesson
