Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeERTKX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751606AbeERTKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:10:20 -0400
Subject: [PATCH v4 0/2] vfio/mdev: Device namespace protection
From: Alex Williamson <alex.williamson@redhat.com>
To: kwankhede@nvidia.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com
Date: Fri, 18 May 2018 13:10:16 -0600
Message-ID: <20180518190145.3187.7620.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4: Fix the 'create' racing 'remove' gap noted by Kirti by moving
    removal from mdev_list to mdev_device_release().  Fix missing
    mdev_put_parent() cases in mdev_device_create(), also noted
    by Kirti.  Added documention update regarding serialization as
    noted by Cornelia.  Added additional commit log comment about
    -EAGAIN vs -ENODEV for 'remove' racing 'create'.  Added second
    patch to re-order sysfs attributes, with this my targeted
    scripts can no longer hit the gap where -EAGAIN is regurned.
    BTW, the gap where the current code returns -ENODEV in this
    race condition is about 50% easier to hit than it exists in
    this series with patch 1 alone.

Thanks,
Alex

---

Alex Williamson (2):
      vfio/mdev: Check globally for duplicate devices
      vfio/mdev: Re-order sysfs attribute creation


 Documentation/vfio-mediated-device.txt |    5 ++
 drivers/vfio/mdev/mdev_core.c          |  102 +++++++++++---------------------
 drivers/vfio/mdev/mdev_private.h       |    2 -
 drivers/vfio/mdev/mdev_sysfs.c         |   14 ++--
 4 files changed, 49 insertions(+), 74 deletions(-)
