Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266CBC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D799721AA7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D799721AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbeHIBwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:52:02 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:39815 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeHIBwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:52:02 -0400
Received: by mail-qk0-f171.google.com with SMTP id b5-v6so2821763qkg.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 16:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EBMatEYMksJCq/izl9uvqVEFm9O9jRFxaT3UO8YbThs=;
        b=oYJ6NHT5CwHNu3XDDWaYmoeNXWmPtiqtVqRnRYImF/MjzUCwlltgy4w4kfU/Wvfjn/
         tltkw1CCcOlzm+VyMsEaPzYIc3Q96t4mZ7AUNJDrGTUeE1PUlqeF1UyXcousiK4Wi7Jo
         rKr55kCeAvIueCepUoe9pBIgZrr/ipoUOY5O/V+etLxfuqtw3X+rbgOQneM2kbaB9LNs
         5x5Y6fJz4wZYWkNfgLmsFoSr1fxD5zWQaHwlx4uLAYvlkdBTTkXF6J+qn80+QduRKXzC
         V2KGviMfkxdC+L01a31ImGhDZsyx0aW9Fs3yxxRDuXrqOcX3wp3Py12SHHlQK9edkOfH
         N3Ug==
X-Gm-Message-State: AOUpUlHQ//3bWRuZ4SIEsz3IKc53tP6fo3wDu3z+hInXWMLlbXiDuqHD
        QWaPI7m1ZsBupKpiuh34yu69UvjOPBR66xzhOAtmto5QtA8=
X-Google-Smtp-Source: AA+uWPzJTostMTF12aXRJfl9rjm1mNQ/bEsgv/+PSursYzZxFjWg/DtK5yjCn6xVGg+tOpaDfOEjBY3bp2d0TXZz0x4=
X-Received: by 2002:a37:c404:: with SMTP id d4-v6mr4477616qki.289.1533771005679;
 Wed, 08 Aug 2018 16:30:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:cc04:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 16:30:05 -0700 (PDT)
From:   Andrew Jeddeloh <andrew.jeddeloh@redhat.com>
Date:   Wed, 8 Aug 2018 16:30:05 -0700
Message-ID: <CAK=WzwePk3iREsb3mz_+RuHV_f2WhcQ9AECnMCWGW2wW=4amew@mail.gmail.com>
Subject: [BUG] Loopback devices with 4k logical block size are not
 automatically scanned for GPT partitions
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I found a bug with partition scanning/loopback devices with 4k
logical sectors. It affects 4.14.x and 4.17.x kernels (and presumably
others). I've also filed the bug on the kernel bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=200749

Copied from the bugzilla report:

Loop devices with the logical sector size set to 4096 do not
autodetect partitions when attached. It may be the case for devices
with 4k logical sectors in general, but I do not have hardware to test
that. I have not tested with non-GPT disks.

I expect to see /dev/loopNpX devices appear when attaching a loopback
device with partitions, regardless of logical block size. With 4096
byte logical block size I only see /dev/loopN devices and no
/dev/loopNpX devices.

Steps to reproduce:
1) truncate -s 1G diskimg
2) losetup -fP --show -b 4096 diskimg
3) sgdisk -n 0:0:0 /dev/loopN # Other partitioning tools will probably
also work.
4) losetup -d /dev/loopN
5) losetup -fP --show -b 4096 diskimg

This happens reliably. I can reproduce it 100% of the time.

Running `sgdisk -p /dev/loopN` with trigger a partition scan and it
find the partitions correctly then, but they do not appear when
initially attached with `losetup -P`. Disk images with logical block
size 512 do appear correctly.

I've tested this with a Fedora 4.17.x kernel, my gentoo 4.17.x kernel
and a Container linux 4.14.x kernel; they all exhibit the same
behavior.

I don't see anything interesting in dmesg and udevadm monitor shows
there are no ADD uevents for the partition block devices until `sgdisk
-p /dev/loopN` is run.

Let me know if there's any other information you want.
Also please CC me in replies. I am not subscribed to the list in general

 - Andrew Jeddeloh
