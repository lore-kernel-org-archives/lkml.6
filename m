Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166329AbeBOSWM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:22:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:3049 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163372AbeBOSWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:22:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="35068984"
From: Joe Konno <joe.konno@linux.intel.com>
To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ard.biesheuvel@linaro.org, matthew.garrett@nebula.com, jk@ozlabs.org,
        ak@linux.intel.com, tony.luck@intel.com
Subject: [PATCH 0/2] efivars: reading variables can generate SMIs
Date: Thu, 15 Feb 2018 10:22:06 -0800
Message-Id: <20180215182208.35003-1-joe.konno@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Konno <joe.konno@intel.com>

It was pointed out that normal, unprivileged users reading certain EFI
variables (through efivarfs) can generate SMIs. Given these nodes are created
with 0644 permissions, normal users could generate a lot of SMIs. By
restricting permissions a bit (patch 1), we can make it harder for normal users
to generate spurious SMIs.

A normal user could generate lots of SMIs by reading the efivarfs in a trivial
loop:

```
while true; do
    cat /sys/firmware/efi/evivars/* > /dev/null
done
```

Patch 1 in this series limits read and write permissions on efivarfs to the
owner/superuser. Group and world cannot access.

Patch 2 is for consistency and hygiene. If we restrict permissions for either
efivarfs or efi/vars, the other interface should get the same treatment.

Joe Konno (2):
  fs/efivarfs: restrict inode permissions
  efi: restrict top-level attribute permissions

 drivers/firmware/efi/efi.c | 10 ++++++----
 fs/efivarfs/super.c        |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.14.1
