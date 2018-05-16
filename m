Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeEPKIf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:08:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752808AbeEPKFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:05:41 -0400
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, lcapitulino@redhat.com,
        keescook@chromium.org, tglx@linutronix.de
Cc: x86@kernel.org, hpa@zytor.com, fanc.fnst@cn.fujitsu.com,
        yasu.isimatu@gmail.com, indou.takao@jp.fujitsu.com,
        douly.fnst@cn.fujitsu.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/2] x86/boot/KASLR: Skip specified number of 1GB huge pages when do physical randomization
Date: Wed, 16 May 2018 18:05:30 +0800
Message-Id: <20180516100532.14083-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a regression bug fix. Luiz's team reported that 1GB huge page
allocation will get one less 1GB page randomly when KASLR is enabled. On
their KVM guest with 4GB RAM, which only has one good 1GB huge page,
they found the 1GB huge page allocation sometime failed with below
kernel option adding.

  default_hugepagesz=1G hugepagesz=1G hugepages=1

This is because kernel may be randomized into those good 1GB huge pages.

I ever thought to solve this by specifying available memory regions
which kernel KASLR can be randomized into to avoid those good 1GB huge
pages. Chao's patches can be used to fix it:
https://lkml.org/lkml/2018/2/28/217

Later, Ingo suggested avoiding them in boot KASLR code.
https://lkml.org/lkml/2018/3/12/312

So I made this patchset to handle the conflict between 1GB huge pages
allocation and KASLR. Any idea or suggestion about the handling,
function naming is appreciated.

Baoquan He (2):
  x86/boot/KASLR: Add two functions for 1GB huge pages handling
  x86/boot/KASLR: Skip specified number of 1GB huge pages when do
    physical randomization

 arch/x86/boot/compressed/kaslr.c | 84 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 5 deletions(-)

-- 
2.13.6
