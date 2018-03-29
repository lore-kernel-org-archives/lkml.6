Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeC2TGk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:06:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750866AbeC2TGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:06:39 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: kexec_file: Fix error code when trying to load kdump kernel
Date: Thu, 29 Mar 2018 16:05:43 -0300
X-Mailer: git-send-email 2.16.2
X-TM-AS-GCONF: 00
x-cbid: 18032919-8235-0000-0000-00000D3C92F5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008766; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01010231; UDB=6.00514696; IPR=6.00789509;
 MB=3.00020316; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-29 19:06:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032919-8236-0000-0000-00004043DF85
Message-Id: <20180329190543.25118-1-bauerman@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-29_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803290197
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexec_file_load() on powerpc doesn't support kdump kernels yet, so it
returns -ENOTSUPP in that case.

I've recently learned that this errno is internal to the kernel and isn't
supposed to be exposed to userspace. Therefore, change to -EOPNOTSUPP which
is defined in an uapi header.

This does indeed make kexec-tools happier. Before the patch, on ppc64le:

  # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
  kexec_file_load failed: Unknown error 524

After the patch:

  # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
  kexec_file_load failed: Operation not supported

Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
Reported-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/machine_kexec_file_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This is a minor issue, but since it's a simple patch it might be worth
applying it to stable branches.

This is the kexec-tools thread where this problem was brought up:

https://lists.infradead.org/pipermail/kexec/2018-March/020346.html

And this is an instance of a similar fix being applied elsewhere in the
kernel, for the same reasons:

https://patchwork.kernel.org/patch/8490791/

The test shown in the commit log was made using Hari Bathini's patch
adding kexec_file_load() support to kexec-tools in ppc64.

diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index e4395f937d63..45e0b7d5f200 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -43,7 +43,7 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 
 	/* We don't support crash kernels yet. */
 	if (image->type == KEXEC_TYPE_CRASH)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
 		fops = kexec_file_loaders[i];
