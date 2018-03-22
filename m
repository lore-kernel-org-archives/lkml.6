Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeCVDhi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 23:37:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751728AbeCVDhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 23:37:37 -0400
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org,
        takahiro.akashi@linaro.org, ebiederm@xmission.com, vgoyal@redhat.com,
        dyoung@redhat.com, prudo@linux.vnet.ibm.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/2] Kexec_file: Load kernel at top of system ram
Date: Thu, 22 Mar 2018 11:37:20 +0800
Message-Id: <20180322033722.9279-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current kexec_file ignores kexec_buf.top_down value when call
arch_kexec_walk_mem() to allocate memory for loading kernel/initrd
stuffs. This is not supposed to be what kexec_buf.top_down is used
for.

In patch 0001, introduce a new function walk_system_ram_res_rev()
which is a variant of walk_system_ram_res(), walks through resources
of System RAM from top to down. And patch 0001 is picked from AKASHI's
patchset which adds arm64 kexec_file support. His next round of post
won't need walk_system_ram_res_rev any more, so I take it into this
patchset and use it in patch 0002.

In patch 0002, check kexec_buf.top_down in arch_kexec_walk_mem(),
if its value is 'true', call walk_system_ram_res_rev(). Otherwise
call walk_system_ram_res().

AKASHI Takahiro (1):
  resource: add walk_system_ram_res_rev()

Baoquan He (1):
  kexec_file: Load kernel at top of system RAM if required

 include/linux/ioport.h |  3 +++
 kernel/kexec_file.c    |  2 ++
 kernel/resource.c      | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

-- 
2.13.6
