Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AD7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28967218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeLSJyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:54:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:28952 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728532AbeLSJyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:54:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 01:54:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,372,1539673200"; 
   d="scan'208";a="305046576"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by fmsmga005.fm.intel.com with ESMTP; 19 Dec 2018 01:54:11 -0800
Subject: Re: [LKP] [xarray] 4e99d4e957: BUG:soft_lockup-CPU##stuck_for#s
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
References: <20181211095441.GR23332@shao2-debian>
 <20181211142947.GC6830@bombadil.infradead.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <d6f5c0ce-1faf-dfc9-caf7-a233cc72d4a5@intel.com>
Date:   Wed, 19 Dec 2018 17:54:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20181211142947.GC6830@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2018 10:29 PM, Matthew Wilcox wrote:
> On Tue, Dec 11, 2018 at 05:54:41PM +0800, kernel test robot wrote:
>> # To reproduce,
>> # 1) save job-script and this script (both are attached in 0day report email)
>> # 2) run this script with your compiled kernel and optional env $INSTALL_MOD_PATH
>>
>> kernel=$1
>>
>> initrds=(
>> 	/osimage/yocto/yocto-tiny-i386-2016-04-22.cgz
>> 	/lkp/lkp/lkp-i386.cgz
>> 	/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig.i386_2016-09-03.cgz
>> )
>>
>> HTTP_PREFIX=https://download.01.org/0day-ci/lkp-qemu
>> wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"
>>
>> {
>> 	cat "${initrds[@]//*\//}"
>> 	[[ $INSTALL_MOD_PATH ]] && (
>> 		cd "$INSTALL_MOD_PATH"
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> When I do this, the only output I get is:
>
> make: Entering directory '/home/willy/kernel/lkp-tests/bin/event'
> gcc    -c -o wakeup.o wakeup.c
> gcc  -static -o wakeup wakeup.o
> rm -f wakeup.o
> strip wakeup
> make: Leaving directory '/home/willy/kernel/lkp-tests/bin/event'
>
> Running under sh -x, I get as far as:
>
> + exec /home/willy/kernel/lkp-tests/lkp-exec/qemu -k ../idrext/.build-yocto/arch/x86/boot/bzImage job-script
>
> Editing that script to set -x, I get to:
>
> + /home/willy/kernel/lkp-tests/sbin/pack -f -a x86_64 lkp-src
> make: Entering directory '/home/willy/kernel/lkp-tests/bin/event'
> gcc    -c -o wakeup.o wakeup.c
> gcc  -static -o wakeup wakeup.o
> rm -f wakeup.o
> strip wakeup
> make: Leaving directory '/home/willy/kernel/lkp-tests/bin/event'
> + exit
>
> which would seem to indicate your 'pack' command failed with a non-zero
> exit code?  Adding set -x to _that_ script gives me:
>
> + find . -type d -exec chmod g+rwx '{}' ';'
> + chmod -R g+rw etc lib root usr
> + '[' -d /osimage/addon-x86_64 ']'
> + gzip -n -9 /home/willy/.lkp/cache/lkp-x86_64.cpio
> + mv -f /home/willy/.lkp/cache/lkp-x86_64.cpio.gz /home/willy/.lkp/cache/lkp-x86_64.cgz
> + [[ -n '' ]]
> + [[ -n '' ]]
> + exit
>
> I'm using your top-of-tree lkp-tests, commit
> e28c726dfe85e3e595ba4776a4eb92f2559d3ac0
>
> By the way, I took this kernel config and ran it under one of your other
> test cases (the one which runs Trinity) and didn't see a boot problem,
> so either it's something specific to this setup, or the problem got
> fixed between this commit and current top-of-tree.

Please accept my apologies for taking your time, the reproduce tool was broken for a long time, and it's fixed now.
if it can't be reproduced, here is the original bzImage(https://download.01.org/0day-ci/lkp-qemu/fbc/4e99d4e9579d3b950bf4b38d0d64eb1b9be78761/).

Best Regards,
Rong Chen


