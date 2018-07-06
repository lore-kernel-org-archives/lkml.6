Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA539C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D21023EA8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D21023EA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933668AbeGFQ1p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:27:45 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17969 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932724AbeGFQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:27:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3f98580000>; Fri, 06 Jul 2018 09:27:04 -0700
Received: from HQMAIL108.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 06 Jul 2018 09:27:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 06 Jul 2018 09:27:43 -0700
Received: from [172.17.136.14] (172.17.136.14) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 6 Jul
 2018 16:27:43 +0000
X-Nvconfidentiality: public
To:     <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <luke.starrett@broadcom.com>
From:   Bo Yan <byan@nvidia.com>
Subject: a question about IP checksum helper for arm64
Message-ID: <141d76cc-d43b-5412-fb39-426d7c2261b9@nvidia.com>
Date:   Fri, 6 Jul 2018 09:27:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
X-Originating-IP: [172.17.136.14]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL108.nvidia.com (172.18.146.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin, Luke,

Recently I bumped into an error when running GCC undefined behavior 
sanitizer:

UBSAN: Undefined behaviour in 
kernel-4.9/arch/arm64/include/asm/checksum.h:34:6
        load of misaligned address ffffffc198c8b254 for type 'const 
__int128 unsigned'
        which requires 16 byte alignment


The relevant code:

         tmp = *(const __uint128_t *)iph;
         iph += 16;
         ihl -= 4;
         tmp += ((tmp >> 64) | (tmp << 64));
         sum = tmp >> 64;
         do {
                 sum += *(const u32 *)iph;
                 iph += 4;
         } while (--ihl);

But, I checked the generated disassembly, it doesn't look like anything 
special is generated taking advantage of that.

I'm using Linaro GCC 6.4-2017.08, expecting ldp instructions to be 
emitted, but don't see it.

There were some prior discussions about GCC behavior, like this thread: 
https://patchwork.kernel.org/patch/9081911/ , in which you talked about 
the difference between GCC4 and GCC5.3. It looks to me this is regressed 
in Linaro GCC6.4 build.

I have not checked newer GCC versions.

Will it be more stable to just do this with inline assembly instead of 
relying on __uint128_t data type?

GCC documentation says __int128 is supported for targets which have an 
integer mode wide enough to hold 128 bits. aarch64 doesn't have such an 
integer mode.

Thanks

Bo
