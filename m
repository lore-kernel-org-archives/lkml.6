Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8521C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C262087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbeL1Hqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 02:46:36 -0500
Received: from albireo.enyo.de ([5.158.152.32]:52790 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbeL1Hqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 02:46:35 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1gcmqk-00059a-1l; Fri, 28 Dec 2018 07:46:30 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1gcmin-0001pk-T5; Fri, 28 Dec 2018 08:38:17 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, libc-alpha@sourceware.org,
        qemu-devel@nongnu.org, ericvh@gmail.com, rminnich@sandia.gov,
        lucho@ionkov.net, hpa@zytor.com, arnd@arndb.de
Subject: Re: d_off field in struct dirent and 32-on-64 emulation
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
        <20181228022338.GA27992@altlinux.org>
Date:   Fri, 28 Dec 2018 08:38:17 +0100
In-Reply-To: <20181228022338.GA27992@altlinux.org> (Dmitry V. Levin's message
        of "Fri, 28 Dec 2018 05:23:39 +0300")
Message-ID: <87bm56w17a.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry V. Levin:

> On Thu, Dec 27, 2018 at 06:18:19PM +0100, Florian Weimer wrote:
>> We have a bit of an interesting problem with respect to the d_off
>> field in struct dirent.
>> 
>> When running a 64-bit kernel on certain file systems, notably ext4,
>> this field uses the full 63 bits even for small directories (strace -v
>> output, wrapped here for readability):
>> 
>> getdents(3, [
>>   {d_ino=1494304, d_off=3901177228673045825, d_reclen=40,
>> d_name="authorized_keys", d_type=DT_REG},
>>   {d_ino=1494277, d_off=7491915799041650922, d_reclen=24,
>> d_name=".", d_type=DT_DIR},
>>   {d_ino=1314655, d_off=9223372036854775807, d_reclen=24,
>> d_name="..", d_type=DT_DIR}
>> ], 32768) = 88
>> 
>> When running in 32-bit compat mode, this value is somehow truncated to
>> 31 bits, for both the getdents and the getdents64 (!) system call (at
>> least on i386).
>
> Why getdents64 system call is affected by this truncation,
> isn't it a kernel bug that has to be fixed in the kernel instead?

It's required because POSIX specifies that telldir and seekdir use
long int (and not off_t) as the seek offset.  If the kernel does not
truncate while keeping a useful value, these functions would turn
unusable.
