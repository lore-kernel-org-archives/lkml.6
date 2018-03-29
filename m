Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeC2Ovc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:51:32 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38200 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeC2Ovb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:51:31 -0400
X-Google-Smtp-Source: AIpwx4/RIgooUa5tegM4AejrXcLCUhCZeLziNE20ngbN0ALJJFtagclODeU9KOl13OS06W4KoDy2mg==
To: Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Subject: aacraid code passes GFP_DMA32 to kmalloc this will not work
Message-ID: <258be5fa-f930-bc5e-d8a0-3d6b5bee0a8b@redhat.com>
Date: Thu, 29 Mar 2018 16:51:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Since I made the same mistake myself I've done a quick grep for
GFP_DMA32 in the kernel and drivers/scsi/aacraid/commctrl.c
came up as a result of this grep, it does:

                                 p = kmalloc(sg_count[i], GFP_KERNEL|GFP_DMA32);

But kmalloc always returns memory from the normal memory-zone,
if you need memory from a specific memory-zone like the
DMA32 zone, you must use the dma allocation functions (which
from a quick glance at the code seems appropriate here) or
directly call alloc_page or __get_free_page.

Regards,

Hans
