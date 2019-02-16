Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E8DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223F3222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 02:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NZAi8qeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbfBPCIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 21:08:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44106 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731407AbfBPCI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 21:08:28 -0500
Received: by mail-ot1-f67.google.com with SMTP id g1so19753874otj.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 18:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=E8MQdVUTQEeEu3nqjpLgUdTpwxg637m/uFGbvQJuSWY=;
        b=NZAi8qeqKa4RmPPWbQVLGsqH4HcPbbo4moBaDR6y/8pPawWONe13ZuvYXTo5GAHWT+
         2SEhnciu5Nxtikh1o/YLTFaui0l1W7N0BaCqWNMvEK+gdODVygA3nZm22lFn8HMNXNx3
         STYAiZbSyO1Ox1c4sb4rzFQxdwtm2u3uBEq0ew6AthQ6ApS6/Ujbyv7ulFPS09nFNLPt
         nzZu6SouDanwDSRF3oecaNGJdqKJ0PXHwkLOud3BY85NPhN/hLR4Z7zDbDgypEricMVC
         R2gNUbkDzNKG0rv1ODmTwk7QgP5+T9W89SDM8e+uNq9jEGvZT3Vn5g9OrZ7T5Z/X0/o1
         iT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=E8MQdVUTQEeEu3nqjpLgUdTpwxg637m/uFGbvQJuSWY=;
        b=O0qVCHuTCA7+tc7dGyWqg3VOYvjCYKDerYQF7ZtppBmcFiwDGpET5NKP0DAzoQsLbt
         fJqWKFjU5X3ws3PxVpgIUrYr+eBWh5h/ZdBNq5/zZLn8dgtq11o01DuxinkeMskq97Fn
         1L1H4ptNzxU4tBiBCZ5jHMOJpz8Qfr//RU3dOhIOrs/YIn/WgF8p802W7JFDupvTeQGb
         Nr9dUJVmCB2LFa6WvfLq4v7qqGJoFN+wE8LwFc/Co+w0BcC/1vreabj+TuDTWUBI0G+c
         hv7rsLEdefAn2a8z3XSkjkfk4d3jkB4519hFqqX1gsRjmj520NIF+T8mGOFhIOhiLqmL
         gv+A==
X-Gm-Message-State: AHQUAubDw7tGogbsCNvL5oJ/dD/k30xl2deBp3Lzioft8Yqbp5od+NOI
        9xzKHFN55unnPNGZKhRginFE7ynAcjGalSe39BK1jQ==
X-Google-Smtp-Source: AHgI3IYiHFdoZ4/8rxjRC06U3FUw/zyaCagWPgW++88v+Zd3W6gFP6Xc57iHPsqgcS/aRz9zESCBYGPq1WDZ2Jsdub4=
X-Received: by 2002:a9d:7a87:: with SMTP id l7mr274118otn.98.1550282907624;
 Fri, 15 Feb 2019 18:08:27 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Feb 2019 18:08:15 -0800
Message-ID: <CAPcyv4gs7nGnf81Lj-Hf04uhmMb2wxKzi42ajaNVCHty7PAsAQ@mail.gmail.com>
Subject: find_get_entries_tag regression bisected
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Balcer, Piotr" <piotr.balcer@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Piotr reports the following crash can be triggered on latest mainline:

 EXT4-fs (pmem5): recovery complete
 EXT4-fs (pmem5): mounted filesystem with ordered data mode. Opts: dax
 ------------[ cut here ]------------
 kernel BUG at mm/pgtable-generic.c:127!
 invalid opcode: 0000 [#1] SMP PTI
 CPU: 28 PID: 1193 Comm: a.out Tainted: G        W  OE     4.19.0-rc5+ #2907
 [..]
 RIP: 0010:pmdp_huge_clear_flush+0x1e/0x80
 [..]
 Call Trace:
  dax_writeback_mapping_range+0x473/0x8a0
  ? print_shortest_lock_dependencies+0x40/0x40
  ? jbd2_journal_stop+0xef/0x470
  ? ext4_fill_super+0x3071/0x3110
  ? __lock_is_held+0x4f/0x90
  ? __lock_is_held+0x4f/0x90
  ext4_dax_writepages+0xed/0x2f0
  do_writepages+0x41/0xe0
  __filemap_fdatawrite_range+0xbe/0xf0
  file_write_and_wait_range+0x4c/0xa0
  ext4_sync_file+0xa6/0x4f0

I bisected this regression to commit c1901cd33cf4 "page cache: Convert
find_get_entries_tag to XArray". I suspect another case of pte vs pmd
confusion.

Below is the small reproducer from Piotr, it triggers in a qemu
environment with emulated pmem, but only with ext4 that I can see, but
I did not dig too deep. Let me know if anything jumps out to you. I'll
otherwise take a deeper look in the coming days.


#include <sys/mman.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <assert.h>

#define MB (1ULL << 20)

int
main(int argc, char *argv[])
{
    int ret;
    int fd;
    off_t size = 2 * MB;

    char *path = argv[1];

    fd = open(path, O_RDWR | O_CREAT | O_EXCL, 0666);
    assert(fd > 0);

    ret = ftruncate(fd, size);
    assert(ret == 0);

    char *addr = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
    assert(addr != MAP_FAILED);

    memset((char*)addr, '0', 1);

    ret = msync(addr + 4096, 1, MS_SYNC);
    assert(ret == 0);

    close(fd);

    return 0;
}
