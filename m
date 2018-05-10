Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965218AbeEJNkA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:40:00 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43520 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964920AbeEJNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:39:59 -0400
X-Google-Smtp-Source: AB8JxZqqoz5SIPO5IgsbFaF9KM+P5ovQ7oRSAsqsoRnrnrxjZqluMeAx6CxJyPWsZs1az4PjP2fxYg==
Date: Thu, 10 May 2018 19:12:04 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: daniel.vetter@intel.com, gustavo@padovan.org, seanpaul@chromium.org,
        airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH] gpu: drm: drm_vm: Adding new typedef vm_fault_t
Message-ID: <20180510134203.GA25166@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/gpu/drm/drm_vm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index 2660543..c330104 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -100,7 +100,7 @@ static pgprot_t drm_dma_prot(uint32_t map_type, struct vm_area_struct *vma)
  * map, get the page, increment the use count and return it.
  */
 #if IS_ENABLED(CONFIG_AGP)
-static int drm_vm_fault(struct vm_fault *vmf)
+static vm_fault_t drm_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_file *priv = vma->vm_file->private_data;
@@ -173,7 +173,7 @@ static int drm_vm_fault(struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;	/* Disallow mremap */
 }
 #else
-static int drm_vm_fault(struct vm_fault *vmf)
+static vm_fault_t drm_vm_fault(struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
 }
@@ -189,7 +189,7 @@ static int drm_vm_fault(struct vm_fault *vmf)
  * Get the mapping, find the real physical page to map, get the page, and
  * return it.
  */
-static int drm_vm_shm_fault(struct vm_fault *vmf)
+static vm_fault_t drm_vm_shm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_local_map *map = vma->vm_private_data;
@@ -291,7 +291,7 @@ static void drm_vm_shm_close(struct vm_area_struct *vma)
  *
  * Determine the page number from the page offset and get it from drm_device_dma::pagelist.
  */
-static int drm_vm_dma_fault(struct vm_fault *vmf)
+static vm_fault_t drm_vm_dma_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_file *priv = vma->vm_file->private_data;
@@ -326,7 +326,7 @@ static int drm_vm_dma_fault(struct vm_fault *vmf)
  *
  * Determine the map offset from the page offset and get it from drm_sg_mem::pagelist.
  */
-static int drm_vm_sg_fault(struct vm_fault *vmf)
+static vm_fault_t drm_vm_sg_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_local_map *map = vma->vm_private_data;
--
1.9.1
