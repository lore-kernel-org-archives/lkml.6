Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1C7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C94218B0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfBGHoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 02:44:12 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:33262 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbfBGHoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 02:44:12 -0500
X-Greylist: delayed 12056 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2019 02:44:11 EST
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x174KgpE010422;
        Thu, 7 Feb 2019 04:23:03 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qg6k7jet2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Feb 2019 04:23:03 +0000
Received: from sarge.linuxathome.me (unknown [16.99.168.108])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 4014D83;
        Thu,  7 Feb 2019 04:23:00 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        x86@kernel.org, Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, stable@vger.kernel.org
Subject: [Patch v2 2/4] x86/platform/UV: kill uv_bios_call_reentrant() as it has no callers
Date:   Thu,  7 Feb 2019 04:22:32 +0000
Message-Id: <20190207042234.25109-3-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207042234.25109-1-hedi.berriche@hpe.com>
References: <20190207042234.25109-1-hedi.berriche@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=375 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uv_bios_call_reentrant() has no callers nor is it exported, kill it.

Cc: Russ Anderson <rja@hpe.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
---
 arch/x86/include/asm/uv/bios.h |  1 -
 arch/x86/platform/uv/bios_uv.c | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index e652a7cc6186..4eee646544b2 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -140,7 +140,6 @@ enum uv_memprotect {
  */
 extern s64 uv_bios_call(enum uv_bios_cmd, u64, u64, u64, u64, u64);
 extern s64 uv_bios_call_irqsave(enum uv_bios_cmd, u64, u64, u64, u64, u64);
-extern s64 uv_bios_call_reentrant(enum uv_bios_cmd, u64, u64, u64, u64, u64);
 
 extern s64 uv_bios_get_sn_info(int, int *, long *, long *, long *, long *);
 extern s64 uv_bios_freq_base(u64, u64 *);
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 4a6a5a26c582..cd05af157763 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -66,18 +66,6 @@ s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 	return ret;
 }
 
-s64 uv_bios_call_reentrant(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
-					u64 a4, u64 a5)
-{
-	s64 ret;
-
-	preempt_disable();
-	ret = uv_bios_call(which, a1, a2, a3, a4, a5);
-	preempt_enable();
-
-	return ret;
-}
-
 
 long sn_partition_id;
 EXPORT_SYMBOL_GPL(sn_partition_id);
-- 
2.20.1

