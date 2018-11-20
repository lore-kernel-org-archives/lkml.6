Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CF9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA5620671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="esGdAidZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA5620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeKTUuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:50:13 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25368 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbeKTUuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:50:13 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1542709259; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=A4/3JXjFBgKSG+/THysbzxIcSf1AlpnnEYDRsPhIWbeclDkxMJsoVYvaFzM2v0eTiwoi24EoWxfRAvfXr52pVyNyj9fjbkLmx+Tzo7iXsb9bX5cDQOOThXB4W74b+zHcrGYTR11QGAfewCLxwSfv/qP5pI59Xs8edQIwRBtHISY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1542709259; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=2+AqlYcK2jf9y0MPV2ufX/R2b3j/DgTZOx4LGarM5NY=; 
        b=Vn2xE9WGmoRFW7VbJd3m5MVuQHSF3VwV1RM/AWms4vy49kg5v8AW/oXcgKPBdyr0GNbRIrAr3G92WtJ850oa7fbhuc9g+oDxdp9EeyNPKyXCMB7i7OuWhHRwAutuxNLu6JWtIdb8mwlZkRvsZxFY5AEWlkh/NBWr8icrvPZPAEo=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=HPJSDxLFDqKl/qIxSLQgoZvdPx690BDxwSLnIjrbwnedVx71leTqwKKQQNAZt6GFq1dhyruLx+KO
    bUw53y2UqJ6OEWxzcM1N3BPqyoixQmgu96pmJcGTEz45QI9l/D4C  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1542709259;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=1811;
        bh=2+AqlYcK2jf9y0MPV2ufX/R2b3j/DgTZOx4LGarM5NY=;
        b=esGdAidZsOkjRiUp2xmsItu7Rnvq6QO27p7gn32qr4yo9dU8hRpXCcfa9WE3xuO6
        T+n/z1y3KRDEPRMhZoEm/PCw4/iJHq+NFZWwpss/LW/r5GLrbHseuyJClr61dCuWFul
        4o+C+bzc6TnHsQVGA87KXHjkSqhoQoY3Jj6SIbhU=
Received: from YEHS1XR956R00D1.lenovo.com (58.243.153.247 [58.243.153.247]) by mx.zohomail.com
        with SMTPS id 1542709257503801.448427061454; Tue, 20 Nov 2018 02:20:57 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, dan.j.williams@intel.com, willy@infradead.org,
        zwisler@kernel.org, jack@suse.cz, dave.jiang@intel.com,
        vishal.l.verma@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
Subject: [RFC PATCH 0/3] realize dax_operations for dm-snapshot
Date:   Tue, 20 Nov 2018 18:20:34 +0800
Message-Id: <20181120102037.4536-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

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
 drivers/md/dm-snap.c  | 44 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/md/dm.c       | 15 +++++++++++++++
 4 files changed, 61 insertions(+), 3 deletions(-)

-- 
1.8.3.1


