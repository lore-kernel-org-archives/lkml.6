Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC165ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 00:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A3020875
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 00:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A3020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeGNAhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 20:37:23 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48772 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731264AbeGNAhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 20:37:22 -0400
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.18])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fe8I9-0002fO-1Y; Fri, 13 Jul 2018 18:20:05 -0600
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Suresh Warrier <warrier@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20180622194752.11221-4-logang@deltatee.com>
 <20180713233831.GA2946@roeck-us.net>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0a32dbb8-a1fa-f691-1d4a-9851b1496b9a@deltatee.com>
Date:   Fri, 13 Jul 2018 18:20:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180713233831.GA2946@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: npiggin@gmail.com, warrier@linux.vnet.ibm.com, mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org, horia.geanta@nxp.com, andy.shevchenko@gmail.com, gregkh@linuxfoundation.org, arnd@arndb.de, akpm@linux-foundation.org, linux-crypto@vger.kernel.org, linux-ntb@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@roeck-us.net
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [v18,3/7] iomap: introduce io{read|write}64_{lo_hi|hi_lo}
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/18 05:38 PM, Guenter Roeck wrote:
> This patch causes a build failure in -next when building
> ppc:corenet64_smp_defconfig.

Thanks for the report. This 64bit IO stuff is a bit of a mess. It looks
like your corner case arch and config was never covered by the kbuild
robot which has run extensively on this patchset.

Anyway, I think the fix is to put back the ioread64/write64 prototypes
(even though they are only used in this one corner).

Can you try it with the following patch to ensure it fixes things for you?

Logan

--

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 5a4af0199b32..9f11a79e0d7a 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -32,6 +32,11 @@ extern unsigned int ioread16be(void __iomem *);
 extern unsigned int ioread32(void __iomem *);
 extern unsigned int ioread32be(void __iomem *);

+#ifdef CONFIG_64BIT
+extern u64 ioread64(void __iomem *);
+extern u64 ioread64be(void __iomem *);
+#endif
+
 #ifdef readq
 #define ioread64_lo_hi ioread64_lo_hi
 #define ioread64_hi_lo ioread64_hi_lo
@@ -49,6 +54,11 @@ extern void iowrite16be(u16, void __iomem *);
 extern void iowrite32(u32, void __iomem *);
 extern void iowrite32be(u32, void __iomem *);

+#ifdef CONFIG_64BIT
+extern void iowrite64(u64, void __iomem *);
+extern void iowrite64be(u64, void __iomem *);
+#endif
+
 #ifdef writeq
 #define iowrite64_lo_hi iowrite64_lo_hi
 #define iowrite64_hi_lo iowrite64_hi_lo
