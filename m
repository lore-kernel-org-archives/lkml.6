Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EEBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611BE2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYOZL2vh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611BE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeIJLQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:16:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33248 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeIJLQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:16:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so9930275pgc.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 23:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wkOrn52A2N0c4FZR5EYFMEE0+LMJfprNaVOHi0yDTSc=;
        b=RYOZL2vhHSSPw8JHXxpWprBgAScXuT0LthF8wb6GrtE/mMgDbpM6nlO402HAIMm+EY
         O8BmPxi0KlrHmPp7Dm6KAqMpFzeoVWSog4pvUP7xrjJsUtNPRbFwlquNxIs47TN7oj/k
         B1ll2i/W/PIhmVCOJ+Q/MYD8iRQoatT+3kCM7wYAqSysoHEhZt2PTqaT7RTnLVcVlY4I
         8uFARfEnWiFo5S0x8cnapz1KnjvHS4rFyTjEmzkn/raiIKHNgKrWcZSYscV3iWHqbzch
         qQOEFrbNEssdb3xaT0dGBPQU5I2ioRRBlV6mn+1+dTQBnsOO4k4C27CSz+qteukKPkr2
         wfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wkOrn52A2N0c4FZR5EYFMEE0+LMJfprNaVOHi0yDTSc=;
        b=FAft00+TpWi7q8v1MmsIqeklFEka+O2CQ23kLj6Z7awWZ11oYj+yDbTkvDVhmm5b4M
         KK6ANZ4RL1u3sArS53YNHnsB6SP7wm0szbfNcxqNk5y86+88Plf/TsZVGLmrI8lYwoxG
         5hsUenXrDwpDbyQrYyPfGlqrNoXfZ/ASU9dAZ47aC+pty2RonnsZ/CfzzHB9EQP+7ILT
         q5xFwd+oFDFRosMLh2heXkoJCjJaoTSOQ6oXKwFNtFhf8CPWxWajJ1aWWS2rsS3bj9tj
         ux6LlXDQKAojfAfIw7i0ARkNtM6NQ4aq0GsmflcUhkPbMDlBxOnyT7vhugqWqaTMfIV8
         sbIA==
X-Gm-Message-State: APzg51ADIdYJtXkMGW+sh8DZ7SBRmrqUao3151CQDLsU10HLmsxkleki
        NxDSM7hW2C/zerZyrTtZd1s=
X-Google-Smtp-Source: ANB0VdZjhmX5lBM789Yg/BzlQPNvnmMefTAJv9xa/x4eRQMrYl7/gCl/+SzErGFWBqYQI8jZVZUx4g==
X-Received: by 2002:a63:d518:: with SMTP id c24-v6mr19978252pgg.357.1536560642462;
        Sun, 09 Sep 2018 23:24:02 -0700 (PDT)
Received: from localhost.localdomain ([104.237.86.186])
        by smtp.gmail.com with ESMTPSA id e190-v6sm29884955pfc.81.2018.09.09.23.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 23:24:02 -0700 (PDT)
From:   Ocean He <oceanhehy@gmail.com>
To:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>
Subject: [PATCH 0/3] libnvdimm: reset seeds for next namespace creation 
Date:   Mon, 10 Sep 2018 02:21:45 -0400
Message-Id: <1536560508-24564-1-git-send-email-oceanhehy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

When pmem namespaces created are smaller than section size twice, the
second creation would fail and meanwhile there is a kernel call trace
which comes from commit 15d36fecd0bdc7510b70 ("mm: disallow mappings that
conflict for devm_memremap_pages()").
	------------[ cut here ]------------
	nd_pmem pfn1.1: Conflicting mapping in same section
	WARNING: CPU: 84 PID: 51974 at kernel/memremap.c:194 devm_memremap_pages+0x4a0/0x4e0
	CPU: 84 PID: 51974 Comm: ndctl Kdump: loaded Tainted: G W E 4.19.0-rc2-23-default+ #27
	RIP: 0010:devm_memremap_pages+0x4a0/0x4e0
	Call Trace:
	 pmem_attach_disk+0x3ab/0x581 [nd_pmem]
	 nvdimm_bus_probe+0x69/0x150 [libnvdimm]
	 really_probe+0x262/0x3d0
	 driver_probe_device+0x60/0x120
	 bind_store+0x102/0x190
	 kernfs_fop_write+0x105/0x180
	 __vfs_write+0x36/0x1a0
	 ? common_file_perm+0x47/0x130
	 ? security_file_permission+0x2c/0xb0
	 vfs_write+0xad/0x1a0
	 ksys_write+0x52/0xc0
	 do_syscall_64+0x5b/0x180
	 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Here is an example (section size is 128MB) based on kernel 4.19-rc2.
	# ndctl create-namespace -r region1 -s 100m -t pmem -m fsdax
	{
	  "dev":"namespace1.0",
	  "mode":"fsdax",
	  "map":"dev",
	  "size":"96.00 MiB (100.66 MB)",
	  "uuid":"ef9a0556-a610-40b5-8c71-43991765a2cc",
	  "raw_uuid":"177b22e2-b7e8-482f-a063-2b8de876d979",
	  "sector_size":512,
	  "blockdev":"pmem1",
	  "numa_node":1
	}
	# ndctl create-namespace -r region1 -s 100m -t pmem -m fsdax
	libndctl: ndctl_pfn_enable: pfn1.1: failed to enable
	  Error: namespace1.1: failed to enable
	failed to create namespace: No such device or address

When above second creation failure occurs, the expectation is to destroy
namespace1.0 to create a new namespace which size is aligned with section
size. However, both namespace seed and pfn seed have been consumed, the
new namespace creation still fails.
	# ndctl destroy-namespace namespace1.0 -f
	destroyed 1 namespace
	# ndctl create-namespace -r region1 -s 128m -t pmem -m fsdax
	failed to create namespace: Device or resource busy

To ensure pfn_seed/dax_seed and namespace_seed are always ready for next
namespace creation, this patch set enables seed detach and reset. Back to
the example, the new namespace creation never fails if this patch set
applied.
	# ndctl destroy-namespace namespace1.0 -f
	destroyed 1 namespace
	# ndctl create-namespace -r region1 -s 128m -t pmem -m fsdax
	{
	  "dev":"namespace1.0",
	  "mode":"fsdax",
	  "map":"dev",
	  "size":"124.00 MiB (130.02 MB)",
	  "uuid":"0d0e7506-d108-4a88-824a-edef26fd0399",
	  "raw_uuid":"efeb9647-12f5-44cd-8a52-2f3a0d14589a",
	  "sector_size":512,
	  "blockdev":"pmem1",
	  "numa_node":1
	}
	# ndctl create-namespace -r region1 -s 128m -t pmem -m fsdax
	{
 	  "dev":"namespace1.1",
 	  "mode":"fsdax",
 	  "map":"dev",
 	  "size":130023424,
 	  "uuid":"689828dc-8779-434d-8e93-0406d4e1e536",
 	  "raw_uuid":"d86e1025-c224-48b6-b2a7-6ccef152d5fd",
 	  "sector_size":512,
 	  "blockdev":"pmem1.1",
 	  "numa_node":1
	}

The mode devdax (-m devdax) has the same issue, this patch set could
cover it.

Ocean He (3):
  libnvdimm, claim: remove static attribute of nd_detach_and_reset
  libnvdimm, namespace_devs: add function nd_region_reset_ns_seed for
    namespace seed reset
  libnvdimm, region_devs: reset related seeds when fail to create
    namespace

 drivers/nvdimm/claim.c          |  2 +-
 drivers/nvdimm/namespace_devs.c | 32 ++++++++++++++++++++++++++++++++
 drivers/nvdimm/nd-core.h        |  2 ++
 drivers/nvdimm/region_devs.c    | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 1 deletion(-)

-- 
1.8.3.1

