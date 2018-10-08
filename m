Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56C5C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E532087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5ANP2H9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E532087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbeJIB6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:58:39 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F812204FD;
        Mon,  8 Oct 2018 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024332;
        bh=sopkgk9lQ+0/hkThnSzqOFm5HXaLP1qTXUeaV4scVoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5ANP2H9KR1y6ZFJ/VKvUs/ajulyjtBmE/2um9fRUzFnIXEvVrj+BPASQa5IE+thi
         B3AcZxkeXWXlhfmC/EuLWBrjYB/0ZBT0C8STKa0qAq2qN4ryCACH3qv4a4jR+BQDMs
         2xiBtR62B2bLj8Y2zbDtaxx8GeMmt+/BjltI4joY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 86/94] crypto: qat - Fix KASAN stack-out-of-bounds bug in adf_probe()
Date:   Mon,  8 Oct 2018 20:32:07 +0200
Message-Id: <20181008175610.646812914@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

commit ba439a6cbfa2936a6713f64cb499de7943673fe3 upstream.

The following KASAN warning was printed when booting a 64-bit kernel
on some systems with Intel CPUs:

[   44.512826] ==================================================================
[   44.520165] BUG: KASAN: stack-out-of-bounds in find_first_bit+0xb0/0xc0
[   44.526786] Read of size 8 at addr ffff88041e02fc50 by task kworker/0:2/124

[   44.535253] CPU: 0 PID: 124 Comm: kworker/0:2 Tainted: G               X --------- ---  4.18.0-12.el8.x86_64+debug #1
[   44.545858] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS BKVDTRL1.86B.0005.D08.1712070559 12/07/2017
[   44.555682] Workqueue: events work_for_cpu_fn
[   44.560043] Call Trace:
[   44.562502]  dump_stack+0x9a/0xe9
[   44.565832]  print_address_description+0x65/0x22e
[   44.570683]  ? find_first_bit+0xb0/0xc0
[   44.570689]  kasan_report.cold.6+0x92/0x19f
[   44.578726]  find_first_bit+0xb0/0xc0
[   44.578737]  adf_probe+0x9eb/0x19a0 [qat_c62x]
[   44.578751]  ? adf_remove+0x110/0x110 [qat_c62x]
[   44.591490]  ? mark_held_locks+0xc8/0x140
[   44.591498]  ? _raw_spin_unlock+0x30/0x30
[   44.591505]  ? trace_hardirqs_on_caller+0x381/0x570
[   44.604418]  ? adf_remove+0x110/0x110 [qat_c62x]
[   44.604427]  local_pci_probe+0xd4/0x180
[   44.604432]  ? pci_device_shutdown+0x110/0x110
[   44.617386]  work_for_cpu_fn+0x51/0xa0
[   44.621145]  process_one_work+0x8fe/0x16e0
[   44.625263]  ? pwq_dec_nr_in_flight+0x2d0/0x2d0
[   44.629799]  ? lock_acquire+0x14c/0x400
[   44.633645]  ? move_linked_works+0x12e/0x2a0
[   44.637928]  worker_thread+0x536/0xb50
[   44.641690]  ? __kthread_parkme+0xb6/0x180
[   44.645796]  ? process_one_work+0x16e0/0x16e0
[   44.650160]  kthread+0x30c/0x3d0
[   44.653400]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[   44.658457]  ret_from_fork+0x3a/0x50

[   44.663557] The buggy address belongs to the page:
[   44.668350] page:ffffea0010780bc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
[   44.676356] flags: 0x17ffffc0000000()
[   44.680023] raw: 0017ffffc0000000 ffffea0010780bc8 ffffea0010780bc8 0000000000000000
[   44.687769] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   44.695510] page dumped because: kasan: bad access detected

[   44.702578] Memory state around the buggy address:
[   44.707372]  ffff88041e02fb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   44.714593]  ffff88041e02fb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   44.721810] >ffff88041e02fc00: 00 00 00 00 00 00 f1 f1 f1 f1 04 f2 f2 f2 f2 f2
[   44.729028]                                                  ^
[   44.734864]  ffff88041e02fc80: f2 f2 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00
[   44.742082]  ffff88041e02fd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   44.749299] ==================================================================

Looking into the code:

  int ret, bar_mask;
    :
  for_each_set_bit(bar_nr, (const unsigned long *)&bar_mask,

It is casting a 32-bit integer pointer to a 64-bit unsigned long
pointer. There are two problems here. First, the 32-bit pointer address
may not be 64-bit aligned. Secondly, it is accessing an extra 4 bytes.

This is fixed by changing the bar_mask type to unsigned long.

Cc: <stable@vger.kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/qat/qat_c3xxx/adf_drv.c      |    6 +++---
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c    |    6 +++---
 drivers/crypto/qat/qat_c62x/adf_drv.c       |    6 +++---
 drivers/crypto/qat/qat_c62xvf/adf_drv.c     |    6 +++---
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c   |    6 +++---
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c |    6 +++---
 6 files changed, 18 insertions(+), 18 deletions(-)

--- a/drivers/crypto/qat/qat_c3xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
@@ -123,7 +123,8 @@ static int adf_probe(struct pci_dev *pde
 	struct adf_hw_device_data *hw_data;
 	char name[ADF_DEVICE_NAME_LENGTH];
 	unsigned int i, bar_nr;
-	int ret, bar_mask;
+	unsigned long bar_mask;
+	int ret;
 
 	switch (ent->device) {
 	case ADF_C3XXX_PCI_DEVICE_ID:
@@ -235,8 +236,7 @@ static int adf_probe(struct pci_dev *pde
 	/* Find and map all the device's BARS */
 	i = 0;
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
-	for_each_set_bit(bar_nr, (const unsigned long *)&bar_mask,
-			 ADF_PCI_MAX_BARS * 2) {
+	for_each_set_bit(bar_nr, &bar_mask, ADF_PCI_MAX_BARS * 2) {
 		struct adf_bar *bar = &accel_pci_dev->pci_bars[i++];
 
 		bar->base_addr = pci_resource_start(pdev, bar_nr);
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
@@ -125,7 +125,8 @@ static int adf_probe(struct pci_dev *pde
 	struct adf_hw_device_data *hw_data;
 	char name[ADF_DEVICE_NAME_LENGTH];
 	unsigned int i, bar_nr;
-	int ret, bar_mask;
+	unsigned long bar_mask;
+	int ret;
 
 	switch (ent->device) {
 	case ADF_C3XXXIOV_PCI_DEVICE_ID:
@@ -215,8 +216,7 @@ static int adf_probe(struct pci_dev *pde
 	/* Find and map all the device's BARS */
 	i = 0;
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
-	for_each_set_bit(bar_nr, (const unsigned long *)&bar_mask,
-			 ADF_PCI_MAX_BARS * 2) {
+	for_each_set_bit(bar_nr, &bar_mask, ADF_PCI_MAX_BARS * 2) {
 		struct adf_bar *bar = &accel_pci_dev->pci_bars[i++];
 
 		bar->base_addr = pci_resource_start(pdev, bar_nr);
--- a/drivers/crypto/qat/qat_c62x/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62x/adf_drv.c
@@ -123,7 +123,8 @@ static int adf_probe(struct pci_dev *pde
 	struct adf_hw_device_data *hw_data;
 	char name[ADF_DEVICE_NAME_LENGTH];
 	unsigned int i, bar_nr;
-	int ret, bar_mask;
+	unsigned long bar_mask;
+	int ret;
 
 	switch (ent->device) {
 	case ADF_C62X_PCI_DEVICE_ID:
@@ -235,8 +236,7 @@ static int adf_probe(struct pci_dev *pde
 	/* Find and map all the device's BARS */
 	i = (hw_data->fuses & ADF_DEVICE_FUSECTL_MASK) ? 1 : 0;
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
-	for_each_set_bit(bar_nr, (const unsigned long *)&bar_mask,
-			 ADF_PCI_MAX_BARS * 2) {
+	for_each_set_bit(bar_nr, &bar_mask, ADF_PCI_MAX_BARS * 2) {
 		struct adf_bar *bar = &accel_pci_dev->pci_bars[i++];
 
 		bar->base_addr = pci_resource_start(pdev, bar_nr);
--- a/drivers/crypto/qat/qat_c62xvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62xvf/adf_drv.c
@@ -125,7 +125,8 @@ static int adf_probe(struct pci_dev *pde
 	struct adf_hw_device_data *hw_data;
 	char name[ADF_DEVICE_NAME_LENGTH];
 	unsigned int i, bar_nr;
-	int ret, bar_mask;
+	unsigned long bar_mask;
+	int ret;
 
 	switch (ent->device) {
 	case ADF_C62XIOV_PCI_DEVICE_ID:
@@ -215,8 +216,7 @@ static int adf_probe(struct pci_dev *pde
 	/* Find and map all the device's BARS */
 	i = 0;
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
-	for_each_set_bit(bar_nr, (const unsigned long *)&bar_mask,
-			 ADF_PCI_MAX_BARS * 2) {
+	for_each_set_bit(bar_nr, &bar_mask, ADF_PCI_MAX_BARS * 2) {
 		struct adf_bar *bar = &accel_pci_dev->pci_bars[i++];
 
 		bar->base_addr = pci_resource_start(pdev, bar_nr);
--- a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
@@ -123,7 +123,8 @@ static int adf_probe(struct pci_dev *pde
 	struct adf_hw_device_data *hw_data;
 	char name[ADF_DEVICE_NAME_LENGTH];
 	unsigned int i, bar_nr;
-	int ret, bar_mask;
+	unsigned long bar_mask;
+	int ret;
 
 	switch (ent->device) {
 	case ADF_DH895XCC_PCI_DEVICE_ID:
@@ -237,8 +238,7 @@ static int adf_probe(struct pci_dev *pde
 	/* Find and map all the device's BARS */
 	i = 0;
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
-	for_each_set_bit(bar_nr, (const unsigned long *)&bar_mask,
-			 ADF_PCI_MAX_BARS * 2) {
+	for_each_set_bit(bar_nr, &bar_mask, ADF_PCI_MAX_BARS * 2) {
 		struct adf_bar *bar = &accel_pci_dev->pci_bars[i++];
 
 		bar->base_addr = pci_resource_start(pdev, bar_nr);
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
@@ -125,7 +125,8 @@ static int adf_probe(struct pci_dev *pde
 	struct adf_hw_device_data *hw_data;
 	char name[ADF_DEVICE_NAME_LENGTH];
 	unsigned int i, bar_nr;
-	int ret, bar_mask;
+	unsigned long bar_mask;
+	int ret;
 
 	switch (ent->device) {
 	case ADF_DH895XCCIOV_PCI_DEVICE_ID:
@@ -215,8 +216,7 @@ static int adf_probe(struct pci_dev *pde
 	/* Find and map all the device's BARS */
 	i = 0;
 	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
-	for_each_set_bit(bar_nr, (const unsigned long *)&bar_mask,
-			 ADF_PCI_MAX_BARS * 2) {
+	for_each_set_bit(bar_nr, &bar_mask, ADF_PCI_MAX_BARS * 2) {
 		struct adf_bar *bar = &accel_pci_dev->pci_bars[i++];
 
 		bar->base_addr = pci_resource_start(pdev, bar_nr);


