Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BB2FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14BF20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14BF20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbeG3SVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:21:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:60106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730607AbeG3SVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:21:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C176BACEA;
        Mon, 30 Jul 2018 16:45:09 +0000 (UTC)
Date:   Mon, 30 Jul 2018 09:44:59 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, jack@suse.cz, jglisse@redhat.com,
        mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/shm.c add ->pagesize function to shm_vm_ops
Message-ID: <20180730164459.zduhnk7itoldqnom@linux-r8p5>
Mail-Followup-To: Jane Chu <jane.chu@oracle.com>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, mhocko@suse.com, jack@suse.cz,
        jglisse@redhat.com, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <20180727211727.5020-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180727211727.5020-1-jane.chu@oracle.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018, Jane Chu wrote:

>Commit 05ea88608d4e13 (mm, hugetlbfs: introduce ->pagesize() to
>vm_operations_struct) adds a new ->pagesize() function to
>hugetlb_vm_ops, intended to cover all hugetlbfs backed files.
>
>With System V shared memory model, if "huge page" is specified,
>the "shared memory" is backed by hugetlbfs files, but the mappings
>initiated via shmget/shmat have their original vm_ops overwritten
>with shm_vm_ops, so we need to add a ->pagesize function to shm_vm_ops.
>Otherwise, vma_kernel_pagesize() returns PAGE_SIZE given a hugetlbfs
>backed vma, result in below BUG:
>
>fs/hugetlbfs/inode.c
>        443             if (unlikely(page_mapped(page))) {
>        444                     BUG_ON(truncate_op);
>
>[  242.268342] hugetlbfs: oracle (4592): Using mlock ulimits for SHM_HUGETLB is deprecated
>[  282.653208] ------------[ cut here ]------------
>[  282.708447] kernel BUG at fs/hugetlbfs/inode.c:444!
>[  282.818957] Modules linked in: nfsv3 rpcsec_gss_krb5 nfsv4 ...
>[  284.025873] CPU: 35 PID: 5583 Comm: oracle_5583_sbt Not tainted 4.14.35-1829.el7uek.x86_64 #2
>[  284.246609] task: ffff9bf0507aaf80 task.stack: ffffa9e625628000
>[  284.317455] RIP: 0010:remove_inode_hugepages+0x3db/0x3e2
>....
>[  285.292389] Call Trace:
>[  285.321630]  hugetlbfs_evict_inode+0x1e/0x3e
>[  285.372707]  evict+0xdb/0x1af
>[  285.408185]  iput+0x1a2/0x1f7
>[  285.443661]  dentry_unlink_inode+0xc6/0xf0
>[  285.492661]  __dentry_kill+0xd8/0x18d
>[  285.536459]  dput+0x1b5/0x1ed
>[  285.571939]  __fput+0x18b/0x216
>[  285.609495]  ____fput+0xe/0x10
>[  285.646030]  task_work_run+0x90/0xa7
>[  285.688788]  exit_to_usermode_loop+0xdd/0x116
>[  285.740905]  do_syscall_64+0x187/0x1ae
>[  285.785740]  entry_SYSCALL_64_after_hwframe+0x150/0x0
>
>Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>Signed-off-by: Jane Chu <jane.chu@oracle.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>
