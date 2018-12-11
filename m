Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A66C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475442081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hpp5jXGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475442081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeLKO3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:29:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54958 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKO3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3lZ6iH/hfEnxvUJ99+5wMLUzxVp8nF2STyXFCHfIi18=; b=Hpp5jXGoZjC/IW8pQWwu/VHWG
        UbwpCH15sJU2/c5U7wNsvPRkZuWf5l8Ug0mbl0XwdmgeJZv99uDJr32/mCzYCX3mN24K8YYBHzz4m
        tp8nHvElVsOEJ5Otc2tIIPGqaH9A32/LmL5d7/i9zwPVVaBuHftW6aVMiQyn5dp8F3jAg/isa3AR2
        t344JJI5ilFNoqAizZMp5DfsjKcPpxdV/ZP5uOSuO1JrBPgwXD8aHM5Ezs2Th3MXjDrJRrlUeL2c+
        +TszgFeyUg04HBTmQUUP+6WB0CueTOkdhj2yo/sQ/8bGojwHdxoC1G0COIt3fdcdeOuP3aKT+FeED
        /1PnKcGww==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWj2h-0004fr-9q; Tue, 11 Dec 2018 14:29:47 +0000
Date:   Tue, 11 Dec 2018 06:29:47 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [LKP] [xarray] 4e99d4e957: BUG:soft_lockup-CPU##stuck_for#s
Message-ID: <20181211142947.GC6830@bombadil.infradead.org>
References: <20181211095441.GR23332@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211095441.GR23332@shao2-debian>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:54:41PM +0800, kernel test robot wrote:
> # To reproduce,
> # 1) save job-script and this script (both are attached in 0day report email)
> # 2) run this script with your compiled kernel and optional env $INSTALL_MOD_PATH
> 
> kernel=$1
> 
> initrds=(
> 	/osimage/yocto/yocto-tiny-i386-2016-04-22.cgz
> 	/lkp/lkp/lkp-i386.cgz
> 	/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig.i386_2016-09-03.cgz
> )
> 
> HTTP_PREFIX=https://download.01.org/0day-ci/lkp-qemu
> wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"
> 
> {
> 	cat "${initrds[@]//*\//}"
> 	[[ $INSTALL_MOD_PATH ]] && (
> 		cd "$INSTALL_MOD_PATH"
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email

When I do this, the only output I get is:

make: Entering directory '/home/willy/kernel/lkp-tests/bin/event'
gcc    -c -o wakeup.o wakeup.c
gcc  -static -o wakeup wakeup.o
rm -f wakeup.o
strip wakeup
make: Leaving directory '/home/willy/kernel/lkp-tests/bin/event'

Running under sh -x, I get as far as:

+ exec /home/willy/kernel/lkp-tests/lkp-exec/qemu -k ../idrext/.build-yocto/arch/x86/boot/bzImage job-script

Editing that script to set -x, I get to:

+ /home/willy/kernel/lkp-tests/sbin/pack -f -a x86_64 lkp-src
make: Entering directory '/home/willy/kernel/lkp-tests/bin/event'
gcc    -c -o wakeup.o wakeup.c
gcc  -static -o wakeup wakeup.o
rm -f wakeup.o
strip wakeup
make: Leaving directory '/home/willy/kernel/lkp-tests/bin/event'
+ exit

which would seem to indicate your 'pack' command failed with a non-zero
exit code?  Adding set -x to _that_ script gives me:

+ find . -type d -exec chmod g+rwx '{}' ';'
+ chmod -R g+rw etc lib root usr
+ '[' -d /osimage/addon-x86_64 ']'
+ gzip -n -9 /home/willy/.lkp/cache/lkp-x86_64.cpio
+ mv -f /home/willy/.lkp/cache/lkp-x86_64.cpio.gz /home/willy/.lkp/cache/lkp-x86_64.cgz
+ [[ -n '' ]]
+ [[ -n '' ]]
+ exit

I'm using your top-of-tree lkp-tests, commit
e28c726dfe85e3e595ba4776a4eb92f2559d3ac0

By the way, I took this kernel config and ran it under one of your other
test cases (the one which runs Trinity) and didn't see a boot problem,
so either it's something specific to this setup, or the problem got
fixed between this commit and current top-of-tree.
