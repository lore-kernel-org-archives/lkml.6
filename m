Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165448AbeE1Nh0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:37:26 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:50950 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163408AbeE1NhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:37:21 -0400
To: "Vinayak Holikatti <vinholikatti@gmail.com>; \"James E.J. Bottomley\"
        <jejb@linux.vnet.ibm.com>; \"Martin K. Petersen\""
        <martin.petersen@oracle.com>
Subject: [PATCH 0/5] scsi: ufs: UFS Host Controller crypto changes
CC: <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org;Manjunath M Bettegowda
        <manjumb@synopsys.com>; Prabu Thangamuthu <prabut@synopsys.com>; Tejas
        Joglekar <joglekar@synopsys.com>; Joao Pinto"
        <Joao.Pinto@synopsys.com>
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
Message-ID: <192fedba-4f7d-8230-2152-b618787fd934@synopsys.com>
Date: Mon, 28 May 2018 14:37:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.144.133.104]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series enables the inline encryption capability of the
UFS Host Controller. The Inline Encryption feature got considerable
performance improvements over the SW algorithms and crypto accelarators
that the crypto transformation on 512 bytes chunks in the device mapper
layer can be avoided and bio can be submitted directly to the block device 
drivers which performs the encryption inline to hardware.

The UFS Host Controller driver detects the crypto capability in the HW
during the init stage and registers an algorithm to the Linux Kernel
Cryptography Framework(LKCF). The UFS HC has multiple key slots in
the hardware  for storing the keys, the crypto support manages these
key slots in hardware.

The Inline Encryption support also requires enhancements in the
block layer for associating the crypto information to the
individual block I/O requests. Separate patch is sent to the block layer
community for the same.

Configuration and usage of the Inline Encryption support for the
Disk Encryption requires minor enhancement in the DM-Crypt 
subsystem. The I/O requests are submitted directly with the
crypto information to the block level device drivers without
actually performing the transformation in this layer. Separate patch is
sent to the device mapper layer community for the same.

The feature is tested and performance comparisions are done with
Synopsys UFS Controller IP on Synopsys HAPS-70 FPGA-based Prototyping
solution.

Ladvine D Almeida (5):
  scsi: ufs: Add crypto source file for UFS HC driver
  scsi: ufs: Add crypto header file for UFS HC driver
  scsi: ufs: Add Kconfig for UFS HC driver crypto support
  scsi: ufs: Add crypto masks for UFS HC driver
  scsi: ufs: Add hooks in UFS HC driver for crypto support

 drivers/scsi/ufs/Kconfig         |  15 ++
 drivers/scsi/ufs/Makefile        |   6 +-
 drivers/scsi/ufs/ufshcd-crypto.c | 520 +++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.h | 156 ++++++++++++
 drivers/scsi/ufs/ufshcd.c        |  63 ++++-
 drivers/scsi/ufs/ufshcd.h        |  29 +++
 drivers/scsi/ufs/ufshci.h        |   2 +
 7 files changed, 784 insertions(+), 7 deletions(-)
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.c
 create mode 100644 drivers/scsi/ufs/ufshcd-crypto.h

-- 
2.7.4
