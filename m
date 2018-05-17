Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeEQJrV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:47:21 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:50104 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751468AbeEQJrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:47:18 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40038170"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <hpa@zytor.com>, <peterz@infradead.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 0/1] Remove the check of duplicate processors
Date: Thu, 17 May 2018 17:46:57 +0800
Message-ID: <20180517094658.18707-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: E00ED4B3ED60.A3566
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in CPU hotplug code, I have two simple fix method, but I can't
ensure which one is better. So sent it out,  seek help.

We found some processors which have the same processor ID but in different
PXM in ACPI namespace. such as this:

proc_id   |    pxm
--------------------
0       <->     0
1       <->     0
2       <->     1
3       <->     1
......
89      <->     0
89      <->     1
89      <->     2
89      <->     3
......

So we create a mechanism to validate them. make the processor(ID=89)
as invalid. And once a processor be hotplugged physically, we check its
processor id.

    Commit 8e089eaa1999 ("acpi: Provide mechanism to validate processors in the ACPI tables")
    Commit a77d6cd96849 ("acpi/processor: Check for duplicate processor ids at hotplug time")

Recently, I found the check mechanism has a bug, it didn't use the
acpi_processor_ids_walk() right and always gave us a wrong result.
First, I fixed it by modifying the value with AE_OK which is the
standard acpi_status value.
 
    https://lkml.org/lkml/2018/3/20/273

But, now, I even think this check is useless. my reasons are following:

    1). Based on the practical effect, It works well, and no bug be reported
    2). Based on the code, the duplicate cases can be dealed with by

       if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id))

That seems more reasonable, let's see the following case:

                          Before the patch,             After the patch

the first processor(ID=89)
hot-add                        failed                        success

the others processor(ID=89)
hot-add                        failed                        failed


So, What's your idea about it.

Dou Liyang (1):
  acpi/processor: Remove the check of duplicates processor ids

 drivers/acpi/acpi_processor.c | 126 ------------------------------------------
 include/linux/acpi.h          |   3 -
 2 files changed, 129 deletions(-)

-- 
2.14.3
