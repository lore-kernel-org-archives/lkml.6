Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90478C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76772082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76772082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeKDRHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 12:07:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37784 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeKDRHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 12:07:33 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJDCk-00072s-J8; Sun, 04 Nov 2018 07:52:25 +0000
Date:   Sun, 4 Nov 2018 07:52:18 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: OCFS2: [ocfs2_rename:1688 ERROR: status = -39] with four
 syscalls on fresh FS image
Message-ID: <20181104075204.GD32577@ZenIV.linux.org.uk>
References: <CAE5jQCeFs0_NS9AZwfw+U60jKU5RRPD56THEhCq_jLJkiFy0=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5jQCeFs0_NS9AZwfw+U60jKU5RRPD56THEhCq_jLJkiFy0=A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2018 at 10:37:34AM +0300, Anatoly Trosinenko wrote:
> Hello,
> 
> When fuzzing OCFS2, I got an ERROR message in dmesg output with
> several syscalls on completely fresh, uncrafted FS image. From this
> https://oss.oracle.com/pipermail/ocfs2-devel/2012-August/008683.html
> it looks like ERROR messages are indicating some unexpected conditions
> in the driver code, is it right? If so, here it how to reproduce it
> with kvm-xfstests:
> 
> 1) Checkout latest torvalds/master (tested with commit 71e56028), copy
> x86_64-config-4.14 from fstests to .config, `make olddefconfig`,
> enable CONFIG_FS then OCFS2 and compile
> 2) Create fresh OCFS2 image:
> $ fallocate -l 256M ocfs2
> $ mkfs.ocfs2 -L test --fs-features=local ./ocfs2
> $ mv ocfs2 /tmp/kvm-xfstests-$USER/ # mkfs.ocfs2 seems to not operate
> on tmpfs that can be mounted on /tmp
> 3) gcc --static ocfs2.c -o /tmp/kvm-xfstests-$USER/repro
> 4) Inside the ./kvm-xfstests shell
> root@kvm-xfstests:~# mount /vtmp
> root@kvm-xfstests:~# mount /vtmp/ocfs2 /mnt
> [   17.168634] JBD2: Ignoring recovery information on journal
> [   17.173903] ocfs2: Mounting device (7,0) on (node local, slot 0)
> with ordered data mode.
> root@kvm-xfstests:~# /vtmp/repro
> [   20.597145] (repro,368,1):ocfs2_rename:1688 ERROR: status = -39

That would be -ENOTEMPTY...

> root@kvm-xfstests:~#
> 
> Best regards
> Anatoly

> #include <sys/stat.h>
> #include <sys/types.h>
> #include <unistd.h>
> #include <stdio.h>
> 
> int main()
> {
>   mkdir("/mnt/xyz", 0x700);
>   mkdir("/mnt/abc", 0x700);
>   symlink("/mnt", "/mnt/xyz/1");
>   rename("/mnt/abc", "/mnt/xyz");

... and this would certainly warrant that - the victim is not empty, indeed.
AFAICS, ocfs2_rename() yells on _any_ error it's about to return.  Including
-EMLINK, etc.
