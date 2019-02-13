Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36241C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C35222CF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394419AbfBMTeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:34:50 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:51576 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728018AbfBMTeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:34:50 -0500
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DJMQIb006022;
        Wed, 13 Feb 2019 19:34:35 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qmnqthxyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Feb 2019 19:34:35 +0000
Received: from sarge.linuxathome.me (unknown [16.99.162.65])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id B556CBE;
        Wed, 13 Feb 2019 19:34:32 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        x86@kernel.org, Russ Anderson <rja@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, stable@vger.kernel.org
Subject: [Patch v3 3/4] x86/platform/UV: use efi_enabled() instead of test_bit()
Date:   Wed, 13 Feb 2019 19:34:12 +0000
Message-Id: <20190213193413.25560-4-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213193413.25560-1-hedi.berriche@hpe.com>
References: <20190213193413.25560-1-hedi.berriche@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=395 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ad hoc efi_enabled() instead of fiddling with test_bit().

Cleanup, no functional changes.

Cc: Russ Anderson <rja@hpe.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: stable@vger.kernel.org # v4.9+
Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
---
 arch/x86/platform/uv/bios_uv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 91e3d5285836..38a2e3431fc6 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -44,7 +44,7 @@ s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
 	 * If EFI_OLD_MEMMAP is set, we need to fall back to using our old EFI
 	 * callback method, which uses efi_call() directly, with the kernel page tables:
 	 */
-	if (unlikely(test_bit(EFI_OLD_MEMMAP, &efi.flags)))
+	if (unlikely(efi_enabled(EFI_OLD_MEMMAP)))
 		ret = efi_call((void *)__va(tab->function), (u64)which, a1, a2, a3, a4, a5);
 	else
 		ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
-- 
2.20.1

