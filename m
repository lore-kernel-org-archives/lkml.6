Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675C8C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2CD2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="msQmFTsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2CD2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeHVWYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:24:20 -0400
Received: from mail-dm3nam03on0077.outbound.protection.outlook.com ([104.47.41.77]:30240
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727874AbeHVWYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2aGte5Qb0XSOwV/mBVy2KAkgjt+5Li/7sITVteoltU=;
 b=msQmFTsbPRd7IaKrE20xVVqfOfnaJqYmdwVoeoD7j43z3QJAOgwTfleLIGCqIQBSLVsgCdjMMnhvn+HafxJihUr9wreutTQmBofUn60LqlEhVi3VjSqcWjSzXf2oeWSwKDkqW9GJNgT7rj6SbDAuv9hwR27UXTYfJRsCQzLystU=
Received: from jiandi-diesel.amd.com (165.204.77.1) by
 CY4PR1201MB2532.namprd12.prod.outlook.com (2603:10b6:903:d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Wed, 22 Aug
 2018 18:58:13 +0000
From:   Jiandi An <jiandi.an@amd.com>
To:     dri-devel@lists.freedesktop.org
Cc:     jiandi.an@amd.com, christian.koenig@amd.com, ray.huang@amd.com,
        Jerry.Zhang@amd.com, airlied@linux.ie, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/ttm: Set memory as decrypted for ttm framebuffer mappings
Date:   Wed, 22 Aug 2018 13:57:54 -0500
Message-Id: <20180822185754.104729-1-jiandi.an@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DF4PR8401CA0034.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7602::20) To CY4PR1201MB2532.namprd12.prod.outlook.com
 (2603:10b6:903:d8::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 915d666a-586b-443e-521e-08d608613646
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB2532;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;3:qtK7pw1BNIhQvALR6/IKMh1C/bH8IxtaR6L4tRTl42k4ajnVkdtngMRiP6b54ngOw1jiGj9197Cui386fKmmZdAThE1b0YuZHfOnQmlFhqP68S9ksHvnl7hU9pjXNIQHutaHorwzuftKd9kmuiErz+jF7/2h0yIJhGYnWCfTlzSfHfjC1CZWMgezHBNPwb9+HJKR2TSu8qb7ceS3Ih0E1GaXrb5Vow0J9LbGe9SMe4vytxmEVQ16fJ/crZ8xtM8Y;25:thllLLim5PPA8ajmAo6BjuvlhnGvyiyZtEb6iYGPG670C0EkwR6q+EWrtDtGYJqfzP4r3l4iDRxthnxdWp+wcxXHVnLfk50TLCDTFP51t1kiaz88Sr7TISlit1LLBgbxmQgxE4fBGDFChb2kiZEW3qx0zfIGPmq1WHW1CKgmpGkalsiWU9AshjaKvmbTtuAtgtJIMqmQrjVf5v4hUVTGNhxdXW4pkY8cvZcicyOZgJLIGf2/M6DYs2ktZv+pWFWA62gb22TCDovfSuw7U4THqKp8oKi+wdSth1RppcOUejlUMES9sza2NVeB/cHzkWhzeW+jQ8B6M3FiEWGPM8dY/w==;31:DLWaM/ocXcApgjAV1fwdmAyCdB/0hkOfq0JQh+2qihHVrV5yHgkCoU5nXzNfG8DoOpv8C5qKsl/jluM0T1Q6r6nB64YNBmF1ZswrAYYMQtltuZQaUmW8e+Ff2UeypZNB1Wjl+Ms9rjOKGF5X8DjG1UxHm1FEvd6gLlCZ5Sam80DAayHfpP+Yib2Lok5OFDAl0rEkeGXg3gkXadHYK3GrVVcySSeVGnlf/eTxmCHrV6A=
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2532:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;20:F4+LiuQtpIRJHeU3sq4qY/JQH7Kfpra0MPLl5W0KV5DffYInYuuxIife12qJtUUgg5zGlgdp1qKYeb9s442hNCJ/4HPZywnRf2cM14jc6pW12M1lCe682CHr/G7L4CpwFjAqMPYnUeOS4lRuQwj8z/iwIbIbgX8xhrivLcTavkEXA77EunRVzvKCBT6zaqqxCF1KQ9tT3XERgpYV3OKBsFMacpUQj04Q+27jR+mM0AobImbGt/C4QGy6rYzNXKybqNNC8PBFXN2a4bCN9a0d3GpN4ZFffceEFXnI3o35DDUJGfkZou8XrD2UeLbldJF5vj+kN2ThW99EMpYaureDOm3pM0R2tiOmcwxCxgQvsLEebPtr7L27jfMODzO/81bhjeYtIpI4JVFt6cDrA7nJYBr/goS4oWrgtc5Zw0+iW/6Tf9WhauDg0oy9iUnmDFKDxYq5tdyMuSDXfLt0t7CRBiyDhCDePCxAHriQOO41rzJQo31/6fhqUOz9026UzUvH;4:kUGFIEjt8P161z7/FIwtuV4poFNyxGyr3k23/zQVT1I2KCP8XUOTF3wLVeveZ4eJB7mCq6kUhhgzjO7yTTmqRdMv7Ml+V/a0Z09+q5VXl1fn6DA3mLCSyTulFpFI6yrCFo9Lga3u4TJEeSl7cpBrIjzRy7XWHzDiLvjH/FGIaLHNTevbWOff6PQDYhumjdxoX5GhKb13ax8YIh3tCQvKm6g9tQ5JG63z9ep7eEZ89Ps73hW3FWvt/Rb1XS84qvjwZYNr76rC37rlYbgRdajOglSo/fogif7XnAgRJVOeT+jpx+Uqx6v2tl8GWjjTmYdB
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25327519E528F2CF4316F78DFD300@CY4PR1201MB2532.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY4PR1201MB2532;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB2532;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(47776003)(66066001)(386003)(6346003)(53936002)(97736004)(48376002)(2906002)(50466002)(305945005)(956004)(81156014)(26005)(44832011)(81166006)(8676002)(25786009)(16586007)(2616005)(186003)(6486002)(476003)(316002)(5660300001)(2361001)(6116002)(3846002)(86362001)(106356001)(16526019)(478600001)(105586002)(486006)(1076002)(68736007)(50226002)(6666003)(6916009)(2351001)(72206003)(8936002)(53416004)(7696005)(52116002)(51416003)(36756003)(7736002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB2532;H:jiandi-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiandi.An@amd.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR1201MB2532;23:yYWbadqp8sRS7qagtSbppXOOnF3WyK3bgFT/PL3?=
 =?us-ascii?Q?qBIZyP5aAnHMyJk+oDfazeK99NjKsGtPRRzL0mMcVTqWKACTFmOQdwKvadJ+?=
 =?us-ascii?Q?e8udBLz4MlVbJUyOy62RNLO38dq4EkKJeCNRiAvZfbUnh8cPvXkI3T5UbwH1?=
 =?us-ascii?Q?z1MJVdsHpUnP4ly/sxStPM1G726c0s/0HeJFloYhNpwuyEVBQQBfjoI57wyf?=
 =?us-ascii?Q?XxFGHW27zP81oHTVfrcGDJfm8fjxy1M2NocTpi6pbNhzc68NvpXsLWOuhkBq?=
 =?us-ascii?Q?YR3vGmxJzpxoCfNKgGmWXX5WHnfns8AObylFLB1h41d9SZjANg9yHNWwIADg?=
 =?us-ascii?Q?ob0bPC/ah9JTSqLCeNYfTPG+5u6/Q6vKUteM8HmyARDBZf3hJkCH+yeLWjxB?=
 =?us-ascii?Q?MLG+bd5vZPQ7bY4fTUAhVXhbtI1GWlClZbc6ix0pFHuA5H4Au6m8Xs2GCi4R?=
 =?us-ascii?Q?QQs+0scBSrgHMveDuL2IDq3eFjj5gqubhLraNmBebvEMC/o2IgZTnJPnv4td?=
 =?us-ascii?Q?P+OA2GiThMwFz9vhL17Y/S9H+glSfWTOuwVH99h/mE019/DyW0wzjVY+D1/A?=
 =?us-ascii?Q?8kRM5Uc6oKd8g9X21Wn9gSGLPNxhsAfOcNjP3Ub1BPje/akzX2Z6wWWqahOn?=
 =?us-ascii?Q?uxBHCKBclUlu0/psHtfZg+qI639yGD8pXuv8ddEpzZ6bL4YR12La0fdiaLQD?=
 =?us-ascii?Q?eb7Fs8BEP3eAEsCBqH90XacYSMuAVYQ7lGnV7B/cczfYWT3Wh8l04LDPvFRk?=
 =?us-ascii?Q?S7omEnVLQTwV7wlJvc3va3oz+ZIQFqAeGyIWFI3n2vsuaMvYmyIgJwQ/8yZQ?=
 =?us-ascii?Q?6sbqkkWagTDkivZvcgXmlfpjTrZs1xDIanJJV4lGoPT8W/GEwyqBzG/RhKZd?=
 =?us-ascii?Q?D0hULoh9Ho0AXQ3Ee99CnRx4QhcgNib38aG9+2hEBDhOgP0YxA1f2fZp0M2B?=
 =?us-ascii?Q?3g/c0390Bkn3RQdFWH6aKvH5Ac1I7XbjrzVehVOBDvwx00Xb+aribCRz+dJI?=
 =?us-ascii?Q?QjF0gitj7BDdlzG2Qe1d05YT+7kqdRsRZToLQVwb3mdoSMnIjSTJj99UcaSu?=
 =?us-ascii?Q?ld202Wu3l2OVP7BYs8l5eZFG/WEZ3eUfzwd6DL8ClZ+p1uJ+kjQwaNufjPLr?=
 =?us-ascii?Q?HjrZ1S1zbqKzo1PBTg2TVLQPE58s0G2XaESlDDwV+iLPpP9YnfALQiJ3GsOt?=
 =?us-ascii?Q?q9/VeNBrud6LI2xEPBohnbpM/aWg6aUSz3n0LCrn+DbYM49AuwLwwbmwN4g?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: 6cjh5S5kc7j9+xU0zKrXar7MXD8wvQtL/m3CSEvCYnO8h8I76v2wLfu87tDe6Z+wZzJX+RUFbvbeaI0aRUJaP3dna+OawWBVmSgw40M/Xssv9wdBmZeEAsCaqUrO7gxwV5h0+eDtx6hc0/uJ2OvWkI8fqjorCRMjO0RNoTMPCuxuPAw+APTc+pfDdy42Iaij9OJF+8QfON2HNZR7GcIhToUXS/1BjU+bwJsgTaHNRCrEjC1OYZpwxS0fOM39xwd0AYWiqs/L4IkuC4Y0qB4xCMWwP4J7zYLEB+QRhPA3aAXRzBZdtRrZSp7Dongmy+NNYIc3GFFdn53HjN364xyBphVu2jxlIEl2bXhla9amTVA=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;6:rd27tRfMRMmM0D1ZPnPLy7z5WbgS6ajnzCJzA0LnP0lC45a9ZomPlWQYFvXi0HVsqushk/ko8w4JmzHTBpEM06+tRBkeDLoCtVFmFrWxQkElwXQ0fHPNAZTcI0NT8k1D7zeGJTmiQ/psWo0fJFlwOw5Z9rM/uhAZXoW5js5kocgGtcRyEhU4+rh6DxasuBB2uXOjLklFmhg+FUX/7xvJe+hJW0y+NeYkH15iJ0e3itYmdR9Kb9vrZnoH01XoLfGTqrxSzisdzufDPzJnnopDJBnyplXNT+yJoPBZV7b95DPIvf/0cA3GHUbQ83tvr9U/fhKYaItF9Bam5R/GgrzHKBbeltAqMj/rCamuPKJWKjTunb6IugNIMnSxr9L0oP8heN6twKwbjE8h1oSSuCghabJcIElVNsR4WtieCMISpxYDu87Mnd8sidu3aZQjoPejlUEGFuZ0iRHLqk6RP2UAgQ==;5:X5MFSyDUPW+Tf36/txJQoymESO1YeYV/wq5ga11i/qBjIHc5BfN1SgfPDiDmwldku3oVFM0tPvNQhgReCX3oSIoxYnRHGxFgpbtK708Deh4Qhs91WfBZPzK6d3Zgakb5PoVNB/UfCGXVcaZxjfU+N5DOIGum4a/jAopP4KaOtLg=;7:zttFkBZZwWx4V5tj+emBhCkCTmFRJeQ5gK/2JCcGJ7sHZzCcqn/R1dXLQZYhfsJcaD2K1HgUWYxTeBjqOyXZJUtnZgYkkUBVKFkmNaz5eYQnBcHKE/d/YaVOV3GBIbC52Y/yRdhXbyihMbih0N61OgMcvsxy9LuuMn9h+2SOQlt0+S3vSQ8Kd7IhcV1UIGXSkHYh426xdjQ20pWPsHkCurApalpCJZq3PNPsgdok9rcCGy+uEyL2hPH5qcsX2bst
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;20:0vg/xKHKyr7cgX4HoOfaU/DFzy2rTLwGkpOFsXYx0g2WqoMpetPTjFCok7anOvOkKqPAIsv6gAxGszbFkbQiMdqL7Gx0K1gJkutONXFvPF5w+EkqsILzswVEZYhMEN/eLSsTIPWTpCm1FA3PD8Obnr5h756NjC7Mg7fmv4u6YCSvdtAG7fJEdD7VZXoO771ZbPx6V9IdXPCTr83e9HYq0CXdm4ZXyuUb59+G9p4+vG7CmR8VTa/zmCq6ONqj2ZNd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 18:58:13.0418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 915d666a-586b-443e-521e-08d608613646
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2532
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Framebuffer memory needs to be accessed decrypted.  Ensure the
memory encryption mask is not set for the ttm framebuffer mappings.

Signed-off-by: Jiandi An <jiandi.an@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 12 +++++++++++-
 drivers/gpu/drm/ttm/ttm_bo_vm.c   |  6 ++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 046a6dda690a..b3f5d26f571e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -29,6 +29,7 @@
  * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
  */
 
+#include <asm/set_memory.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
 #include <drm/drm_vma_manager.h>
@@ -639,7 +640,11 @@ int ttm_bo_kmap(struct ttm_buffer_object *bo,
 	if (ret)
 		return ret;
 	if (!bo->mem.bus.is_iomem) {
-		return ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
+		ret = ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
+		if (!ret && sev_active())
+			set_memory_decrypted((unsigned long) map->virtual,
+					     num_pages);
+		return ret;
 	} else {
 		offset = start_page << PAGE_SHIFT;
 		size = num_pages << PAGE_SHIFT;
@@ -661,9 +666,14 @@ void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map)
 		iounmap(map->virtual);
 		break;
 	case ttm_bo_map_vmap:
+		if (sev_active())
+			set_memory_encrypted((unsigned long) map->virtual,
+					     bo->num_pages);
 		vunmap(map->virtual);
 		break;
 	case ttm_bo_map_kmap:
+		if (sev_active())
+			set_memory_encrypted((unsigned long) map->virtual, 1);
 		kunmap(map->page);
 		break;
 	case ttm_bo_map_premapped:
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 6fe91c1b692d..211d3549fd9f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -249,10 +249,12 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 	 * Speculatively prefault a number of pages. Only error on
 	 * first page.
 	 */
+
+	/* Mark framebuffer pages decrypted */
+	cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
+
 	for (i = 0; i < TTM_BO_VM_NUM_PREFAULT; ++i) {
 		if (bo->mem.bus.is_iomem) {
-			/* Iomem should not be marked encrypted */
-			cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
 			pfn = ttm_bo_io_mem_pfn(bo, page_offset);
 		} else {
 			page = ttm->pages[page_offset];
-- 
2.17.1

