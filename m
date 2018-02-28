Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752471AbeB1Kvk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:51:40 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54770 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752283AbeB1Kvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:51:39 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37332002"
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC: <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v9 0/5] x86/KASLR: Add parameter kaslr_boot_mem=nn[KMG]@ss[KMG]
Date: Wed, 28 Feb 2018 18:51:00 +0800
Message-ID: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 977D94D0EFD9.AEA4A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long time no reply, rebase the patchset, change the parameter name
from 'kaslr_mem' to 'kaslr_boot_mem'. There's no more code change.

***Background:
People reported that kaslr may randomly chooses some positions
which are located in movable memory regions. This will break memory
hotplug feature.

And also on kvm guest with 4GB meory, the good unfragmented 1GB could
be occupied by randomized kernel. It will cause hugetlb failing to
allocate 1GB page. While kernel with 'nokaslr' has not such issue.
This causes regression. Please see the discussion mail:
        https://lkml.org/lkml/2018/1/4/236

***Solutions:
Introduce a new kernel parameter 'kaslr_boot_mem=nn@ss' to let users to
specify the memory regions where kernel can be allowed to randomize
safely.

E.g if 'movable_node' is spedified, we can use 'kaslr_boot_mem=nn@ss' to
tell KASLR where we can put kernel safely. Then KASLR code can avoid
those movable regions and only choose those immovable regions
specified.

For hugetlb case, users can always add 'kaslr_boot_mem=1G' in kernel
cmdline since the 0~1G is always fragmented region because of BIOS
reserved area. Surely users can specify regions more precisely if
they know system memory very well.

*** Issues need be discussed
There are several issues I am not quite sure, please help review and
give suggestions:

1) Since there's already mem_avoid[] which stores the memory regions
KASLR need avoid. For the regions KASLR can safely use, I name it as
mem_usable[], not sure if it's appropriate. Or kaslr_boot_mem[] directly?

2) In v6, I made 'kaslr_boot_mem=' as a kernel parameter which users can
use to specify memory regions where kenrel can be extracted safely by
'kaslr_boot_mem=nn@ss', or regions where we need avoid to extract kernel by
'kaslr_boot_mem=nn!ss'. While later I rethink about it, seems
'kaslr_boot_mem=nn@ss' can satisfy the current requirement, there's no need
to introduce the 'kaslr_boot_mem=nn!ss'. So I just take that
'kaslr_boot_mem=nn!ss' handling patch off, may add it later if anyone think
it's necessary. Any suggestions?
        https://www.spinics.net/lists/kernel/msg2698457.html

***Test results:
 - I did some tests for the memory hotplug issues. I specify the memory
   region in one node, then I found every time the kernel will be
   extracted to the memory of this node.
 - Luiz tested this series with a 4GB KVM guest. With kaslr_boot_mem=1G,
   got one 1GB page allocated 100% of the time in 85 boots. Without
   kaslr_boot_mem=, got 3 failures in only 10 boots (that is, in 3 boots
   no 1GB page allocated). So this series solves the 1GB page problem.

***History
v8->v9:
 - Rebase in new version.
 - Change the name of parameter from 'kaslr_mem' to 'kaslr_boot_mem'

v7->v8:
 - Just improve some comments.
 - Change the wrong spelling.
 - Add the Tested-by and Acked-by.

v6->v7:
 - Drop the unnecessary avoid part for now.
 - Add document for the new parameter.

v5->v6:
 - Add the last patch to save the avoid memory regions.

v4->v5:
 - Change the problem reported by LKP
Follow Dou's suggestion:
 - Also return if match "movable_node" when parsing kernel commandline
   in handle_mem_filter without define CONFIG_MEMORY_HOTPLUG

v3->v4:
Follow Kees's suggestion:
 - Put the functions variables of immovable_mem to #ifdef
   CONFIG_MEMORY_HOTPLUG and change some code place
 - Change the name of "process_mem_region" to "slots_count"
 - Reanme the new function "process_immovable_mem" to "process_mem_region"
Follow Baoquan's suggestion:
 - Fail KASLR if "movable_node" specified without "immovable_mem"
 - Ajust the code place of handling mem_region directely if no
   immovable_mem specified
Follow Randy's suggestion:
 - Change the mistake and add detailed description for the document.

v2->v3:
Follow Baoquan He's suggestion:
 - Change names of several functions.
 - Add a new parameter "immovable_mem" instead of extending mvoable_node
 - Use the clamp to calculate the memory intersecting, which makes
   logical more clear.
 - Disable memory mirror if movable_node specified

v1->v2:
Follow Dou Liyang's suggestion:
 - Add the parse for movable_node=nn[KMG] without @ss[KMG]
 - Fix the bug for more than one "movable_node=" specified
 - Drop useless variables and use mem_vector region directely
 - Add more comments.

Chao Fan (5):
  x86/KASLR: Add kaslr_boot_mem=nn[KMG]@ss[KMG]
  x86/KASLR: Handle the memory regions specified in kaslr_boot_mem
  x86/KASLR: Give a warning if movable_node specified without
    kaslr_boot_mem=
  x86/KASLR: Skip memory mirror handling if movable_node specified
  document: add document for kaslr_boot_mem

 Documentation/admin-guide/kernel-parameters.txt |  10 ++
 arch/x86/boot/compressed/kaslr.c                | 154 +++++++++++++++++++++---
 2 files changed, 150 insertions(+), 14 deletions(-)

-- 
2.14.3
