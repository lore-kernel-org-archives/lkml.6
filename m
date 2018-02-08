Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750944AbeBHGaF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 01:30:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60905 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeBHGaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 01:30:04 -0500
X-Google-Smtp-Source: AH8x225zv74x0TKbu3twZck9P8qF/EKNbxbwenZn/mvGY6WVJP+1pKLe/5wHPPUCUI/DWZAEzAPKVw==
From: Kai Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.9\))
Subject: Regression after commit 19809c2da28a ("mm, vmalloc: use __GFP_HIGHMEM
 implicitly")
Message-Id: <627DA40A-D0F6-41C1-BB5A-55830FBC9800@canonical.com>
Date: Thu, 8 Feb 2018 14:29:57 +0800
Cc: linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Michal Hocko <mhocko@suse.com>, Laura Abbott <labbott@redhat.com>
X-Mailer: Apple Mail (2.3445.6.9)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user with i386 instead of AMD64 machine reports [1] that commit 19809c2da28a ("mm, vmalloc: use __GFP_HIGHMEM implicitly”) causes a regression.
BUG_ON(PageHighMem(pg)) in drivers/media/common/saa7146/saa7146_core.c always gets triggered after that commit.

Commit 704b862f9efd ("mm/vmalloc.c: don't unconditonally use __GFP_HIGHMEM”) adjusts the mask logic, now the __GFP_HIGHMEM only gets applied when there is no GFP_DMA or GFP_DMA32.

So I tried to adjust its malloc to "__vmalloc(nr_pages * sizeof(struct scatterlist), GFP_KERNEL | GFP_DMA | __GFP_ZERO, PAGE_KERNEL)”, but both GFP_DMA or GFP_DMA32 still trigger the BUG_ON(PageHighMem()) macro.

Also there are other BUG_ON(PageHighMem()) in drivers/media, I think they will get hit by same regression in 32bit machine too.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1742316

Kai-Heng
