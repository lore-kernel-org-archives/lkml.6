Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeBBNIj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:08:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751638AbeBBNH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:07:27 -0500
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: prudo@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 01/17] kexec_file: Silence compile warnings
Date: Fri,  2 Feb 2018 14:07:02 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180202130718.35509-1-prudo@linux.vnet.ibm.com>
References: <20180202130718.35509-1-prudo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18020213-0020-0000-0000-000003F1AEFD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020213-0021-0000-0000-000042841C03
Message-Id: <20180202130718.35509-2-prudo@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802020162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the kernel with CONFIG_KEXEC_FILE enabled gcc prints a
compile warning multiple times.

In file included from <path>/linux/init/initramfs.c:526:0:
<path>/include/linux/kexec.h:120:9: warning: ‘struct kimage’ declared inside parameter list [enabled by default]
         unsigned long cmdline_len);
         ^
This is because the typedefs for kexec_file_load uses struct kimage before
it is declared. Fix this by simply forward declaring struct kimage.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 include/linux/kexec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f16f6ceb3875..7bae5e87bf0d 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -114,6 +114,8 @@ struct purgatory_info {
 	unsigned long purgatory_load_addr;
 };
 
+struct kimage;
+
 typedef int (kexec_probe_t)(const char *kernel_buf, unsigned long kernel_size);
 typedef void *(kexec_load_t)(struct kimage *image, char *kernel_buf,
 			     unsigned long kernel_len, char *initrd,
-- 
2.13.5
