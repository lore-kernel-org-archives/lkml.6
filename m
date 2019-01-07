Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E984C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766AB20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfAGH7h convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:59:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58335 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfAGH7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:59:37 -0500
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x077xHl22965441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 6 Jan 2019 23:59:18 -0800
Date:   Sun, 06 Jan 2019 23:59:10 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190107074056.12532-1-caoj.fnst@cn.fujitsu.com>
References: <20190107074056.12532-1-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86/boot: drop memset from copy.S
To:     Cao jin <caoj.fnst@cn.fujitsu.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
CC:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
From:   hpa@zytor.com
Message-ID: <000CE7C8-33F3-404A-9E7D-F2CCB0BA110E@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 6, 2019 11:40:56 PM PST, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>According to objdump output of setup, function memset is not used in
>setup code. Currently, all usage of memset in setup come from macro
>definition of string.h.
>
>Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>---
>Compiled and booted under x86_64; compiled under i386.
>
>Questions: now there is 2 definition of memcpy, one lies in copy.S,
>another lies in string.h which is mapped to gcc builtin function. Do we
>still need 2 definition? Could we move the content of copy.S to
>boot/string.c?
>
>At first glance, the usage of string.{c.h} of setup is kind of
>confusing,
>they are also used in compressed/ and purgatory/
>
> arch/x86/boot/copy.S | 15 ---------------
> 1 file changed, 15 deletions(-)
>
>diff --git a/arch/x86/boot/copy.S b/arch/x86/boot/copy.S
>index 15d9f74b0008..5157d08b0ff2 100644
>--- a/arch/x86/boot/copy.S
>+++ b/arch/x86/boot/copy.S
>@@ -33,21 +33,6 @@ GLOBAL(memcpy)
> 	retl
> ENDPROC(memcpy)
> 
>-GLOBAL(memset)
>-	pushw	%di
>-	movw	%ax, %di
>-	movzbl	%dl, %eax
>-	imull	$0x01010101,%eax
>-	pushw	%cx
>-	shrw	$2, %cx
>-	rep; stosl
>-	popw	%cx
>-	andw	$3, %cx
>-	rep; stosb
>-	popw	%di
>-	retl
>-ENDPROC(memset)
>-
> GLOBAL(copy_from_fs)
> 	pushw	%ds
> 	pushw	%fs

This is dependent on both gcc version and flags.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
