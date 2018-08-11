Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E2CC46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D4D223DC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QWRx+Ltn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SgUz8wM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D4D223DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeHKFCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 01:02:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46508 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeHKFCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 01:02:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 08B9460B84; Sat, 11 Aug 2018 02:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533954572;
        bh=OYCJxhr4Ld1uMV/Q+pQJnePMWSospGXg73DXb06xA7E=;
        h=Date:From:To:Cc:Subject:From;
        b=QWRx+LtnXE3Lm9zrd75mYhP8+bo6oCRlcCVyQO3VcXnJymHaUMJqgXnNx0wbHxa1x
         kIBdfBYjt4HEM9mLNaVuVslxI+0y3PNMsPZMHOBK2pt0oyh1IZdvRC7/1i+/iN6bi+
         P/RM4hagWJpB7uU8cjs2MeBcceMrEaAwblwdPlfM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 112CA60B19;
        Sat, 11 Aug 2018 02:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533954571;
        bh=OYCJxhr4Ld1uMV/Q+pQJnePMWSospGXg73DXb06xA7E=;
        h=Date:From:To:Cc:Subject:From;
        b=SgUz8wM6su+EAD34og4Wuo3uVXrAcE5ZVdeQ+mnsZvaoXl09L515Jvz8b/ti6WV7V
         /Ja+XFgtnGNETr2m1e75QzWy8aPJoziVpYXmK8KEMCul73OXu7pbB7olrKFiRRkLcv
         6/gtUvd2tptnALYpGCuqDN7EoMf+60Kz3zYggxv8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 10 Aug 2018 19:29:30 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        andreyknvl@google.com, keescook@chromium.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        psodagud@codeaurora.org
Subject: KASAN errors from unwind_frame
Message-ID: <e296f7e70a0d0e61c94337bf334e80c2@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have observed following KASAN error with 4.14.56 kernel.
Can you please copy change-[1](kasan: add no_sanitize attribute for 
clang builds) into stable kernels?

[1] - 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/compiler-clang.h?h=v4.18-rc8&id=12c8f25a016dff69ee284aa3338bebfd2cfcba33


==================================================================
BUG: KASAN: out-of-bounds in __read_once_size_nocheck 
include/linux/compiler.h:196 [inline]
BUG: KASAN: out-of-bounds in unwind_frame+0xc4/0x324 
arch/arm64/kernel/stacktrace.c:56
Read of size 8 at addr ffffffe3123ff4b0 by task poc/15233

CPU: 7 PID: 15233 Comm: poc Tainted: G S      W  O    4.14.56+ #3
Hardware name: Qualcomm Technologies, Inc.
Call trace:
dump_backtrace+0x0/0x388
show_stack+0x24/0x30
__dump_stack+0x24/0x2c
dump_stack+0x8c/0xd0
print_address_description+0x74/0x234
kasan_report+0x240/0x264
__asan_report_load8_noabort+0x2c/0x38
unwind_frame+0xc4/0x324
walk_stackframe+0x44/0x6c
__save_stack_trace+0x250/0x444
save_stack_trace_tsk+0x2c/0x38
proc_pid_stack+0x134/0x268
proc_single_show+0xdc/0x130
traverse+0x244/0x5b0
seq_lseek+0x10c/0x27c
vfs_llseek+0xb4/0xe4
SyS_lseek+0x54/0xa0
el0_svc_naked+0x34/0x38

The buggy address belongs to the page:
page:ffffffbf8c48ffc0 count:0 mapcount:0 mapping:          (null) 
index:0x0
flags: 0x0()
raw: 0000000000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: 0000000000000000 dead000000000200 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not active (free page?)

Memory state around the buggy address:
ffffffe3123ff380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffffffe3123ff400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffffffe3123ff480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
^
ffffffe3123ff500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffffffe3123ff580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

-Thanks, Prasad
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
