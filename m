Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B830EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7B1218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeL0R4G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 12:56:06 -0500
Received: from albireo.enyo.de ([5.158.152.32]:48474 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeL0R4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 12:56:05 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1gcZt4-0005Ag-5F; Thu, 27 Dec 2018 17:56:02 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1gcZt4-0001kn-2M; Thu, 27 Dec 2018 18:56:02 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, libc-alpha@sourceware.org,
        qemu-devel@nongnu.org, ericvh@gmail.com, lucho@ionkov.net,
        hpa@zytor.com, arnd@arndb.de
Subject: Re: d_off field in struct dirent and 32-on-64 emulation
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
        <C65D3222-723F-4C0B-AF02-38488C302E84@amacapital.net>
Date:   Thu, 27 Dec 2018 18:56:02 +0100
In-Reply-To: <C65D3222-723F-4C0B-AF02-38488C302E84@amacapital.net> (Andy
        Lutomirski's message of "Thu, 27 Dec 2018 10:38:10 -0700")
Message-ID: <87wonuua4t.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski:

>> On Dec 27, 2018, at 10:18 AM, Florian Weimer <fw@deneb.enyo.de> wrote:
>> 
>> We have a bit of an interesting problem with respect to the d_off
>> field in struct dirent.
>> 
>> When running a 64-bit kernel on certain file systems, notably ext4,
>> this field uses the full 63 bits even for small directories (strace -v
>> output, wrapped here for readability):
>> 
>> getdents(3, [
>>  {d_ino=1494304, d_off=3901177228673045825, d_reclen=40,
>> d_name="authorized_keys", d_type=DT_REG},
>>  {d_ino=1494277, d_off=7491915799041650922, d_reclen=24, d_name=".",
>> d_type=DT_DIR},
>>  {d_ino=1314655, d_off=9223372036854775807, d_reclen=24,
>> d_name="..", d_type=DT_DIR}
>> ], 32768) = 88
>> 
>> When running in 32-bit compat mode, this value is somehow truncated to
>> 31 bits, for both the getdents and the getdents64 (!) system call (at
>> least on i386).
>
> I imagine you’re encountering this bug:
>
> https://lkml.org/lkml/2018/10/18/859

It's definitely in this area.  However, the original collision problem
with 32-bit hashes is also real, so I can see the desire to use more
bits.

> Presumably the right fix involves modifying the relevant VFS file
> operations to indicate the relevant ABI to the implementations.

Not sure.  How does NFS solve this problem when access happens from a
32-bit process and the rest (client kernel, transport, server kernel)
is 64-bit all the way?

> I would guess that 9p is triggering the “not really in the syscall you
> think you’re in” issue.

I think the issue is more like the networking case for 9p.  In this
scenario, the server shouldn't have to care whether the client process
is in 32-bit mode or 64-bit mode.  But maybe the only solution is to
pass through some sort of flag, as Peter Maydell has just suggested.
