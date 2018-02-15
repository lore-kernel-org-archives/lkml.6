Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755463AbeBOLEZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 06:04:25 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36608 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755323AbeBOLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 06:04:23 -0500
X-Google-Smtp-Source: AH8x2250zSQg6n5WXcxedJZ3XdvhZTVC1Zn+dUavjeWhA09alXN7oKKF7c7ZEXnx/4fC0pH+uAa9rQ==
Date: Thu, 15 Feb 2018 16:34:06 +0530
From: Linu Cherian <linuc.decode@gmail.com>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linu.cherian@cavium.com, Sunil.Goutham@cavium.com
Subject: Handling active DMA during a VFIO application crash
Message-ID: <20180215110406.GA15219@virtx40>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Was exploring the implications of an application crash while DMA 
is active from a vfio PCI device; the DMA being configured and 
started by the application using vfio APIs.               

The expectation is that, DMA is stopped/reset before we tear down the IOMMU mappings 
and finally free the mmapped pages(on which DMA is happening).                                            

>From the below stack trace(with dump_stack in vfio_pci_release),             
[  201.564273] [<ffffff8008798b50>] vfio_pci_release+0x80/0x458
[  201.564276] [<ffffff8008792b74>] vfio_device_fops_release+0x2c/0x50
[  201.564279] [<ffffff8008269ef4>] __fput+0x9c/0x218
[  201.564283] [<ffffff800826a0e8>] ____fput+0x20/0x30
[  201.564286] [<ffffff80080e7fe0>] task_work_run+0xa0/0xc8
[  201.564289] [<ffffff80080cbc7c>] do_exit+0x2bc/0x9c8
[  201.564293] [<ffffff80080cd0ec>] do_group_exit+0x3c/0xa8
[  201.564296] [<ffffff80080d94c4>] get_signal+0x3e4/0x538
[  201.564299] [<ffffff80080892f0>] do_signal+0x70/0x660
[  201.564302] [<ffffff8008089ce8>] do_notify_resume+0xe0/0x120
                                                                                               

PCI device is disabled/reset from vfio_pci_release invoked as part of 
device fd release. The fd releases are in turn invoked from exit_files
and exit_task_work.

But exit_mm, gets called before exit_files/exit_task_work in do_exit.
                                                                                               
Assuming all pages allocated/mmaped to a process gets freed in exit_mm,                                                                                               
is there is a possibility that user pages configured for DMA can get freed 
to kernel before the vfio device is stopped/reset ? 

Thanks.

-- 
Linu cherian
