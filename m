Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5109AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087EA2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087EA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936119AbeFRWRT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:17:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934807AbeFRWRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:17:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C711687A6E;
        Mon, 18 Jun 2018 22:17:17 +0000 (UTC)
Received: from treble (ovpn-123-40.rdu2.redhat.com [10.10.123.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87BF32156880;
        Mon, 18 Jun 2018 22:17:17 +0000 (UTC)
Date:   Mon, 18 Jun 2018 17:17:16 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Manoj Gupta <manojgupta@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: clang: objtool: native_machine_emergency_restart() falls through
 to next function
Message-ID: <20180618221716.3qizmt3mph377ovi@treble>
References: <20180615211441.GO88063@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615211441.GO88063@google.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 18 Jun 2018 22:17:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 18 Jun 2018 22:17:17 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 02:14:41PM -0700, Matthias Kaehlcke wrote:
> Hi Josh,
> 
> with your work on objtool and the upcoming implementation of
> -fno-delete-null-pointer-checks (https://reviews.llvm.org/D47894,
> https://reviews.llvm.org/D47895) in clang most objtool warnings
> for clang builds will be fixed.
> 
> However even with -fno-delete-null-pointer-checks we currently still
> get a warning about native_machine_emergency_restart():
> 
> arch/x86/kernel/reboot.o: warning: objtool:
>   native_machine_emergency_restart()
>   falls through to next function machine_power_off()
> 
> This only occurs when building with -Oz.
> 
> One of our compiler engineers looked into this, LLVM optimizes the
> return statement away since the function has an endless loop, and
> actually never returns.
> 
> Is there a way to tell objtool that the function is not expected to
> return (I tried the attribute __noreturn, but it doesn't make a
> difference), or do we have to tell clang to restrain from optimizing
> returns out?
> 
> To repro:
> 
> git checkout v4.16
> make CC=clang defconfig
> echo "CONFIG_CC_OPTIMIZE_FOR_SIZE=y" >> .config
> make CC=clang arch/x86/kernel/reboot.o

Hi Matthias,

Objtool can't detect 'noreturn' functions, so unfortunately we have to
keep a manual list.  Does this fix it?

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5409f6f6c48d..ace3f85701c8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -139,6 +139,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"lbug_with_loc",
 		"fortify_panic",
 		"usercopy_abort",
+		"machine_real_restart",
 	};
 
 	if (func->bind == STB_WEAK)
