Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD80FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BB320890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KuZJ2G1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BB320890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeG3RFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:05:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46356 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbeG3RFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:05:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UFTMsC081663;
        Mon, 30 Jul 2018 15:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=D7G2dXn34gMz/yeSkauvck5L6lAJWgUI8OeE+hMxDPE=;
 b=KuZJ2G1tiS7heDcE7XBf8e3ockoo6Ui0hrlM4eWUMeZ1D8uKgDeONgTCDjx1jG6oJzzK
 BpahS4DyAQGe6NXjPsLDkDyplRdPjalSxqwHJNutLGN5ji6gXLKt6uxYS+l+JVXxtnEk
 Vuub8MfI2mPFKz5HPWlAklCPQF8dSN8wAS5kl8wRD5zOkZCxueS3Sbt7cPzmKqLBgkcX
 LaEXnJr+Xrybk2D+DnzIdv106iu8sbWqnOxJDS3ofjYoJWXuU8mnyCboN71ijvX9MRMF
 xFjy6lxcId2mzA7YRkI+x2lYpxA71Cpy6NzSwSXblcUaSKY0usN36meRseZCltFEjW7B bw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2kge0cw6d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 15:29:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6UFTMl3009593
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 15:29:22 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6UFTLfc009651;
        Mon, 30 Jul 2018 15:29:21 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 08:29:21 -0700
Subject: [PATCH 1/1] arm64: kexec: machine_kexec should call
 __flush_icache_range
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
References: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <e07fc674-2a71-29ae-2212-46ee5f79593d@oracle.com>
Date:   Mon, 30 Jul 2018 10:29:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8969 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine_kexec flushes the reboot_code_buffer from the icache
after stopping the other cpus.

Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
for kernel mappings") added an IPI call to flush_icache_range, which
causes a hang here, so replace the call with __flush_icache_range

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f62effc..e8c0283 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -184,7 +184,7 @@ void machine_kexec(struct kimage *kimage)
 
 	/* Flush the reboot_code_buffer in preparation for its execution. */
 	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
-	flush_icache_range((uintptr_t)reboot_code_buffer,
+	__flush_icache_range((uintptr_t)reboot_code_buffer,
 		arm64_relocate_new_kernel_size);
 
 	/* Flush the kimage list and its buffers. */
-- 
1.8.3.1

