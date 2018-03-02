Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164204AbeCBCAJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 21:00:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47152 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163973AbeCBB7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 20:59:22 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: clarify mmio pointer types
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180301130729.3278022-1-arnd@arndb.de>
Date: Thu, 01 Mar 2018 20:59:05 -0500
In-Reply-To: <20180301130729.3278022-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Thu, 1 Mar 2018 14:07:07 +0100")
Message-ID: <yq1muzrxmom.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=550
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020017
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Broadcom folks: Please review!

> The newly added code mixes up phys_addr_t/resource_size_t with dma_addr_t
> and void pointers, as seen from these compiler warning:
>
> drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_base_get_chain_phys':
> drivers/scsi/mpt3sas/mpt3sas_base.c:235:21: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   base_chain_phys  = (void *)ioc->chip_phys + MPI_FRAME_START_OFFSET +
>                      ^
> drivers/scsi/mpt3sas/mpt3sas_base.c: In function '_clone_sg_entries':
> drivers/scsi/mpt3sas/mpt3sas_base.c:427:20: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>     sgel->Address = (dma_addr_t)dst_addr_phys;
>                     ^
> drivers/scsi/mpt3sas/mpt3sas_base.c:438:7: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>        (dma_addr_t)buff_ptr_phys;
>        ^
> drivers/scsi/mpt3sas/mpt3sas_base.c:444:10: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>           (dma_addr_t)buff_ptr_phys;
>
> Both dma_addr_t and phys_addr_t may be wider than a pointer, so we must
> avoid the conversion to pointer types. This also helps readability.
>
> A second problem is treating MMIO addresses from a 'struct resource'
> as addresses that can be used for DMA on that device. In almost all
> cases, those are the same, but on some of the more obscure architectures,
> PCI memory address 0 is mapped into the CPU address space at a nonzero
> offset. I don't have a good fix for that, so I'm adding a comment here,
> plus a WARN_ON() that triggers whenever the phys_addr_t number is
> outside of the low 32-bit address space and causes a straight overflow
> when assigned to the 32-bit sgel->Address.

-- 
Martin K. Petersen	Oracle Linux Engineering
