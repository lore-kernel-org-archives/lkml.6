Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030491AbeEYVfo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:35:44 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41027 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030318AbeEYVfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:35:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH, net-next] vmcore: hide vmcoredd_mmap_dumps() for nommu builds
Date: Fri, 25 May 2018 23:34:57 +0200
Message-Id: <20180525213526.2117790-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:APn3fuVWucgr21fPwJWrtH3rwIFB/lp8HBxeASlJQxDXdojmkhK
 oFb634yx/esXJOMPvgxFyD1+6CyvUFwD0A7ccvmNXw94jp7d38PBN58iyJq8y+Qy9qO+ipa
 ECzIIipxt/ldIC+jjDxL05uzRBIb6A+K3A8NE1EAK1E933/wki44F9GljXbebFXu4DAwsEM
 vDHfDeqdVBujnqvdGm8oQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Icidxji6ck4=:ycuDj06w4HxKnay/EJHTou
 jBDIQPsb2GBHAm66zaXQ5+u3sonl3IIUrI1Kn9vbf3NLVDW1sdeSWaDZY2KDYl5h3+AzVMZK4
 KPMeTjK2SSdD4ULA9I15uPHJrfRXwlBsdaOSzoVEwpvzT0xiV94Bf31CuhFKEsoPs3uv9mBSz
 HKBxP6kSCarXfb14b9Y6pMB8yZykriNrMRnMih1qRYtRAP/QhqjkiDdAPTHq5e+ZFtsQgjtsA
 urXvvSb4/kEqmzA1EWbs5k2q++kW/AviV5D1MQ5xcT6uUIU2opvVd6A65jI+zrb3XogTHLtma
 +hI8AIsL0Ngq3DULXYQzWXjPwb0861DcowxUMDJY01dsAgHwlEn6RBKSjUBb7bqJ3HrpNPzbX
 ViccROmPKhD7FR/rtNQf00g1hkCiFmIYZj8doJjgeXki5Q1d+uHDDF8vCVdYfpafSAVGiCdvX
 347nTyWw6i/Q9mFFfdgN+POZkhQkmH8CezEmmmBQ2GFI3oHTL765zQQHPa/6LfbpzA59BQq4f
 4K8PnxIi5rAN0gK4LrAulzi8giGOXr4EZxVUkbzI46lyy6PAfi/6Jv3XD+oWLlpq2t/aPcpss
 BEEuNMQXyuIk7WUl71IYug+5SVb0mpnx1p6GdLBEaSIz/LDxcoYp6zKD6eR9q4OlsL6K8f+RG
 SxrcNXxXikzHc7wFUUPWw+sS68GG0OSTidrFYC/phga7BS4s1Usn4O6C7IsStcLeGrso=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_MMU, we get a build warning:

fs/proc/vmcore.c:228:12: error: 'vmcoredd_mmap_dumps' defined but not used [-Werror=unused-function]
 static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,

The function is only referenced from an #ifdef'ed caller, so
this uses the same #ifdef around it.

Fixes: 7efe48df8a3d ("vmcore: append device dumps to vmcore as elf notes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/proc/vmcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index cfb6674331fd..0651646dd04d 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -225,6 +225,7 @@ static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, int userbuf)
 	return ret;
 }
 
+#ifdef CONFIG_MMU
 static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 			       u64 start, size_t size)
 {
@@ -259,6 +260,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 	mutex_unlock(&vmcoredd_mutex);
 	return ret;
 }
+#endif /* CONFIG_MMU */
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 
 /* Read from the ELF header and then the crash dump. On error, negative value is
-- 
2.9.0
