Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA64C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC6C20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cHkok3Po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC6C20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeG2TmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 15:42:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36248 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeG2TmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 15:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cv9ApKFZB7x8AjO0M+6fdGovfTTsA7hhfAY1KhBtOeM=; b=cHkok3Po7dWKIC86Lh0FhZfFIO
        1Zy26YpxE8+gXgCC9bcnHqrMcOB13Cx7TyssReO8F99icUvfSqZLh0Q018cj0qduZlchAR00v1sYp
        x5s/FeYjitqblyuOt8PugyA3zp7DNQXfooryq7AKc2BC/eGQX90ek0fsc2pl2k/Daemej++Iv/JdX
        1TFJGQO26mYH8y3eI/KIRYx9zDvnP14/zfPf/y4kOfAIEhriKnLmFEgdm/QBvq90hL6rTJX1p6JUy
        VxPRZUYlrTP5iBD7bPYO9WuN72jYov5i+bwci+kP4zxw6D6GKJ5gOHnSVDM2fU/VPMkVqbS9iVzE7
        LoY+rgPQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fjq9g-0002k2-Dm; Sun, 29 Jul 2018 18:10:56 +0000
Subject: [PATCH 3/4 v3] arc: fix data type errors in platform headers
To:     Leon Romanovsky <leonro@mellanox.com>,
        rd_dunlab <rd.dunlab@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Elad Kanfi <eladkan@mellanox.com>,
        Ofer Levi <oferle@mellanox.com>
References: <15326613951079@infradead.org> <1532661395712@infradead.org>
 <20180729070113.GC7157@mtr-leonro.mtl.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0d2870ef-ae4c-d9a8-c894-c4f252fae7da@infradead.org>
Date:   Sun, 29 Jul 2018 11:10:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729070113.GC7157@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/2018 12:01 AM, Leon Romanovsky wrote:
> On Thu, Jul 26, 2018 at 08:16:35PM -0700, rd_dunlab wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Add <asm-generic/types.h> to fix build errors.
>> Both ctop.h and <soc/nps/common.h> use u32 types and cause many
>> errors.
>>
>> Examples:
>> ../include/soc/nps/common.h:71:4: error: unknown type name 'u32'
>>     u32 __reserved:20, cluster:4, core:4, thread:4;
>> ../include/soc/nps/common.h:76:3: error: unknown type name 'u32'
>>    u32 value;
>> ../include/soc/nps/common.h:124:4: error: unknown type name 'u32'
>>     u32 base:8, cl_x:4, cl_y:4,
>> ../include/soc/nps/common.h:127:3: error: unknown type name 'u32'
>>    u32 value;
>>
>> ../arch/arc/plat-eznps/include/plat/ctop.h:83:4: error: unknown type name 'u32'
>>     u32 gen:1, gdis:1, clk_gate_dis:1, asb:1,
>> ../arch/arc/plat-eznps/include/plat/ctop.h:86:3: error: unknown type name 'u32'
>>    u32 value;
>> ../arch/arc/plat-eznps/include/plat/ctop.h:93:4: error: unknown type name 'u32'
>>     u32 csa:22, dmsid:6, __reserved:3, cs:1;
>> ../arch/arc/plat-eznps/include/plat/ctop.h:95:3: error: unknown type name 'u32'
>>    u32 value;
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: linux-snps-arc@lists.infradead.org
>> Cc: Elad Kanfi <eladkan@mellanox.com>
>> Cc: Leon Romanovsky <leonro@mellanox.com>
>> Cc: Ofer Levi <oferle@mellanox.com>
>> ---
>> v2: no change
>>
>>  arch/arc/plat-eznps/include/plat/ctop.h |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- linux-next-20180723.orig/arch/arc/plat-eznps/include/plat/ctop.h
>> +++ linux-next-20180723/arch/arc/plat-eznps/include/plat/ctop.h
>> @@ -21,6 +21,7 @@
>>  #error "Incorrect ctop.h include"
>>  #endif
>>
>> +#include <asm-generic/types.h>
> 
> I'm not familiar with arch/* code, so maybe my question will sound
> naive., but why "asm-generic/types.h" and not "linux/types.h"?

Nope, good question.  That works and should be preferred.

Please use the new patch below.

-- 

From: Randy Dunlap <rdunlap@infradead.org>

Add <linux/types.h> to fix build errors.
Both ctop.h and <soc/nps/common.h> use u32 types and cause many
errors.

Examples:
../include/soc/nps/common.h:71:4: error: unknown type name 'u32'
    u32 __reserved:20, cluster:4, core:4, thread:4;
../include/soc/nps/common.h:76:3: error: unknown type name 'u32'
   u32 value;
../include/soc/nps/common.h:124:4: error: unknown type name 'u32'
    u32 base:8, cl_x:4, cl_y:4,
../include/soc/nps/common.h:127:3: error: unknown type name 'u32'
   u32 value;

../arch/arc/plat-eznps/include/plat/ctop.h:83:4: error: unknown type name 'u32'
    u32 gen:1, gdis:1, clk_gate_dis:1, asb:1,
../arch/arc/plat-eznps/include/plat/ctop.h:86:3: error: unknown type name 'u32'
   u32 value;
../arch/arc/plat-eznps/include/plat/ctop.h:93:4: error: unknown type name 'u32'
    u32 csa:22, dmsid:6, __reserved:3, cs:1;
../arch/arc/plat-eznps/include/plat/ctop.h:95:3: error: unknown type name 'u32'
   u32 value;

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Elad Kanfi <eladkan@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Ofer Levi <oferle@mellanox.com>
---
v2: no change
v3: use <linux/types.h> instead of <asm-generic/types.h>

 arch/arc/plat-eznps/include/plat/ctop.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20180723.orig/arch/arc/plat-eznps/include/plat/ctop.h
+++ linux-next-20180723/arch/arc/plat-eznps/include/plat/ctop.h
@@ -21,6 +21,7 @@
 #error "Incorrect ctop.h include"
 #endif
 
+#include <linux/types.h>
 #include <soc/nps/common.h>
 
 /* core auxiliary registers */

