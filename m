Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445CFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0096E21104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="M4gwlqyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0096E21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeKUOAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:00:13 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25415 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbeKUOAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:00:13 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1542770832; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=bFhncskcP7fb0105ABDouH6A1Px0oFAqRstK/SCMBQSVDvw1C6B9vxtuuc2ykzkifB/+CW61r93ubAMouptZh+B8ku0eiDRVopO7qOfzRQMo6e57DgGIUpUFDahBHTWPSGmPU70NF0rzPC4NtrlJJxXHZFVk6DttKu0vxRoSsEY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1542770832; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=RlKVwpvHCjZ1SDlUa5wjbUP+HlpARBKConxYOYaQty4=; 
        b=kl8ipXGkk3KQ+EeXIOrY0qxPN/hG7EA/8/HyHGcQLC0sPwqb6cpgC5XhHldQNzgeg4QAZCtg0D1tSMQnH9PZIyYhRu9dy+8OLIqr9/H6nVH8moJD8G07GOoWylkHsnjV6mZ7CfaLgAbCdsSFJOFWqKwpdUAsl9yBbOdZjrCRMNM=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=ZtEa9lLlMgCmKqMoHJWaofmDIoeZJlc/kQS/evaTl6ANeu2vIGkYE6OT1yEfSrB9AKbGGU9XFBA3
    4PLOBKnzHZ6zXcmsb9xvaGPlE5ye+Xgm6maJH2Ik0be+Bce5R9tZ  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1542770832;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=2048;
        bh=RlKVwpvHCjZ1SDlUa5wjbUP+HlpARBKConxYOYaQty4=;
        b=M4gwlqybHbPsXMPMkEDJLWngpUNCdgWJP7yfTicCzXHoi3yvLYWFeESFQtn/mRWt
        p/k6sWJGBWuLvMmpMNdixJ5wdbkTfkut+JJt2q21R2Vavf/aSfTUWF5vv9STeQ/MxOO
        mkz55V3Lj2PxSYiAcRk+x6TSB7r50ZvNSN/i/i0g=
Received: from YEHS1XR956R00D1.lenovo.com (58.243.153.247 [58.243.153.247]) by mx.zohomail.com
        with SMTPS id 1542770831193408.0950458479167; Tue, 20 Nov 2018 19:27:11 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, dan.j.williams@intel.com, willy@infradead.org,
        zwisler@kernel.org, jack@suse.cz, dave.jiang@intel.com,
        vishal.l.verma@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
Subject: [RFC PATCH v2 0/3] realize dax_operations for dm-snapshot
Date:   Wed, 21 Nov 2018 11:26:59 +0800
Message-Id: <20181121032702.3048-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Changes
v1->v2:
	Add NULL funtions for origin_dax_direct_access and
	origin_dax_copy_from/to_iter in order to avoid building
	error when CONFIG_DAX_DRIVER has NOT been enabled.

[v1]: https://lkml.org/lkml/2018/11/20/759

This series patches are used to realize the dax_operations for dm-snapshot
with persistent memory device.

Here are the steps about how to verify the function.

1. Configure the persistent memory to fs-dax mode and create namespace with ndctl;
2. find them in /dev;
  # ndctl list
  {
    "dev":"namespace0.0",
    "mode":"fsdax",
    "map":"dev",
    "size":132118478848,
    "sector_size":512,
    "blockdev":"pmem0",
    "name":"yhs_pmem0",
    "numa_node":0
  },
3. create lv_pmem (here is 4G size) for testing;
   # pvcreate /dev/pmem0
   # vgcreate vg_pmem /dev/pmem0
   # lvcreate  -L 4G -n lv_pmem vg_pmem
4. create filesystem (ext2 or ext4) to /dev/pmem0
   # mkfs.ext2 -b 4096 /dev/vg_pmem/lv_pmem
5. mount pmem with DAX way;
   # mkdir /mnt/lv_pmem
   # mount -o dax /dev/vg_pmem/lv_pmem /mnt/lv_pmem/
6. cp some files to /mnt/lv_pmem;
   # cp linear_table03.log /mnt/lv_pmem/
   # cp test0.log /mnt/lv_pmem/
7. create snapshot for test (here I limit it to 1G size);
   # lvcreate -L 1G -n snap_pmem -s /dev/vg_pmem/lv_pmem
8. modify the files copied with vim or copy more other new files;
   # vim /mnt/lv_pmem/test0.log
9. umount the pmem device;
   # umount /mnt/lv_pmem/
10.merge the snapshot back to origin;
   # lvconvert --merge /dev/vg_pmem/snap_pmem
11.mount pmem device again for checking the content of files;
   # mount -o dax /dev/vg_pmem/lv_pmem /mnt/lv_pmem/

Huaisheng Ye (3):
  dm: enable dax_operations for dm-snapshot
  dm: expand hc_map in mapped_device for lack of map
  dm: expand valid types for dm-ioctl

 drivers/md/dm-core.h  |  1 +
 drivers/md/dm-ioctl.c |  4 +++-
 drivers/md/dm-snap.c  | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/md/dm.c       | 15 +++++++++++++++
 4 files changed, 68 insertions(+), 3 deletions(-)

-- 
1.8.3.1


