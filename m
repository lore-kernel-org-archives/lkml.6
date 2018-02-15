Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425673AbeBOQVN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:21:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424438AbeBOQVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:21:10 -0500
Date: Thu, 15 Feb 2018 09:21:09 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Linu Cherian <linuc.decode@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linu.cherian@cavium.com, Sunil.Goutham@cavium.com
Subject: Re: Handling active DMA during a VFIO application crash
Message-ID: <20180215092109.51dc7a1a@w520.home>
In-Reply-To: <20180215110406.GA15219@virtx40>
References: <20180215110406.GA15219@virtx40>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018 16:34:06 +0530
Linu Cherian <linuc.decode@gmail.com> wrote:

> Hi,
> 
> Was exploring the implications of an application crash while DMA 
> is active from a vfio PCI device; the DMA being configured and 
> started by the application using vfio APIs.               
> 
> The expectation is that, DMA is stopped/reset before we tear down the IOMMU mappings 
> and finally free the mmapped pages(on which DMA is happening).                                            
> 
> From the below stack trace(with dump_stack in vfio_pci_release),             
> [  201.564273] [<ffffff8008798b50>] vfio_pci_release+0x80/0x458
> [  201.564276] [<ffffff8008792b74>] vfio_device_fops_release+0x2c/0x50
> [  201.564279] [<ffffff8008269ef4>] __fput+0x9c/0x218
> [  201.564283] [<ffffff800826a0e8>] ____fput+0x20/0x30
> [  201.564286] [<ffffff80080e7fe0>] task_work_run+0xa0/0xc8
> [  201.564289] [<ffffff80080cbc7c>] do_exit+0x2bc/0x9c8
> [  201.564293] [<ffffff80080cd0ec>] do_group_exit+0x3c/0xa8
> [  201.564296] [<ffffff80080d94c4>] get_signal+0x3e4/0x538
> [  201.564299] [<ffffff80080892f0>] do_signal+0x70/0x660
> [  201.564302] [<ffffff8008089ce8>] do_notify_resume+0xe0/0x120
>                                                                                                
> 
> PCI device is disabled/reset from vfio_pci_release invoked as part of 
> device fd release. The fd releases are in turn invoked from exit_files
> and exit_task_work.
> 
> But exit_mm, gets called before exit_files/exit_task_work in do_exit.
>                                                                                                
> Assuming all pages allocated/mmaped to a process gets freed in exit_mm,                                                                                               
> is there is a possibility that user pages configured for DMA can get freed 
> to kernel before the vfio device is stopped/reset ? 

Pages mapped through the IOMMU are still pinned, so they have an
elevated reference count and I believe therefore cannot "get freed to
kernel".  Nothing should therefore be able to allocate those pages
until the container is released, which happens even after the device is
released.  Thanks,

Alex
