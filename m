Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739AAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476B32133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeLRIES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:04:18 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:48429 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726324AbeLRIER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:04:17 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07857972|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03295;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.DZFShi5_1545120251;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DZFShi5_1545120251)
          by smtp.aliyun-inc.com(10.147.40.7);
          Tue, 18 Dec 2018 16:04:12 +0800
Subject: Re: [PATCH] pstore: fix crypto dependencies of 842/zstd compression
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
References: <1544603038-9373-1-git-send-email-liaoweixiong@allwinnertech.com>
 <201812171624.Ych15Vum%fengguang.wu@intel.com>
From:   =?UTF-8?B?5buW5aiB6ZuE?= <liaoweixiong@allwinnertech.com>
Message-ID: <12bc8a0a-45bc-3622-5745-654957825047@allwinnertech.com>
Date:   Tue, 18 Dec 2018 16:04:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201812171624.Ych15Vum%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi ,
On 2018/12/17 16:16, kbuild test robot wrote:
> Hi liaoweixiong,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on kees/for-next/pstore]
> [also build test ERROR on v4.20-rc7 next-20181214]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/liaoweixiong/pstore-fix-crypto-dependencies-of-842-zstd-compression/20181214-222645
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    fs/pstore/platform.o: In function `zbufsize_zstd':
>>> platform.c:(.text+0x30a): undefined reference to `ZSTD_compressBound'
Yes, i reproduced it. I had made a new patch in version 2.
On new patch, i try to trun sub-options of compression back to 'bool'
for more rigorous.

Commit info like this:
On commit 58eb5b670747 ("pstore: fix crypto dependencies"),
dependency bug was fixed by selecting the crypto core rather than
turned compression sub-options to 'tristate'.
In addition, these options are used to enable/disable compression. They
are not modules, and mean nothing when set to 'M'.
So, this patch is going to turn them back to 'bool'.

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

