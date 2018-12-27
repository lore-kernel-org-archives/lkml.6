Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2CEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EACC21741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeL0SJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 13:09:15 -0500
Received: from albireo.enyo.de ([5.158.152.32]:48678 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeL0SJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 13:09:14 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1gca5n-0005Pp-6z; Thu, 27 Dec 2018 18:09:11 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1gca5n-00020w-3v; Thu, 27 Dec 2018 19:09:11 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, libc-alpha@sourceware.org,
        qemu-devel@nongnu.org, ericvh@gmail.com, rminnich@sandia.gov,
        lucho@ionkov.net, hpa@zytor.com, arnd@arndb.de
Subject: Re: d_off field in struct dirent and 32-on-64 emulation
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
        <957967d7-5717-8ada-fb30-dfdf19898b6b@linaro.org>
Date:   Thu, 27 Dec 2018 19:09:11 +0100
In-Reply-To: <957967d7-5717-8ada-fb30-dfdf19898b6b@linaro.org> (Adhemerval
        Zanella's message of "Thu, 27 Dec 2018 15:58:47 -0200")
Message-ID: <87pntmu9iw.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Adhemerval Zanella:

> Also for glibc standpoint, although reverting it back to use getdents 
> syscall for non-LFS mode might fix this issue for architectures that
> provides non-LFS getdents syscall it won't be a fix for architectures 
> that still provides off_t different than off64_t *and* only provides 
> getdents64 syscall.
>
> Currently we only have nios2 and csky (unfortunately).  But since generic 
> definition for off_t and off64_t still assumes non-LFS support, all new
> 32-bits ports potentially might carry the issue.

For csky, we could still change the type of the non-standard d_off
field to long long int.  This way, only telldir would have to fail
when truncation is necessary, as mentioned below:

>> There is another annoying aspect: The standards expose d_off through
>> the telldir function, and that returns long int on all architectures
>> (not off_t, so unchanged by _FILE_OFFSET_BITS).  That's mostly a
>> userspace issue and thus needing different steps to resolve (possibly
>> standards action).
