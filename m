Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACC4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBB120896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DWxHaA5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBB120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756603AbeFOVOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:14:44 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:45186 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756413AbeFOVOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:14:43 -0400
Received: by mail-pl0-f47.google.com with SMTP id c23-v6so5939157plz.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nx+suhTWrHqLTNae2xA9goxO9ZBD40sNvaYA30usqxI=;
        b=DWxHaA5qOtXskzWbhlXcb363CTyo/jIPnWhSLXfBndAOsLrInQQXOHH+yMA8XZF9g8
         ZYMC6YJcKYiZvwJk80JwoC6mu0VrM6/UB/Tp2VbeIxVBC9M3EMGJWXyDMiDaYSyqcM9T
         NuUXwvXp33FqYyFiYbERG8bXe40ODrhjN4Jy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nx+suhTWrHqLTNae2xA9goxO9ZBD40sNvaYA30usqxI=;
        b=ImoGEwqsNNB4Y3GkqfwFM7pug1Fvgoq/BGkhIPGNMySjNBXyGiPmUZXjZtgHmtYXVe
         SJ0/676Vki2EVBUmwxgZL3F0aQA7sVUknZ/TmZMlev4s7kCJkhM1iQBe1GXqCz4EC4E/
         sZrZ30zHL4RegYV+aEna26wGHEIInnJsagfXqeVKCu5uM8+j8QfehTXvo4FikYyU/PFO
         mdYlWyN4VKd34tAt0jIldISPY6V1i7K/8uzCDbLzdVhzudBUPKYLeH7C1ofu6JPDe3+T
         8gJ8SEGioU0dZyrq/uLPQ73v7aF3dAeFBHz873eElMfzKbDCthM5/KtmbQ0PCy9swr1Z
         PXLw==
X-Gm-Message-State: APt69E2uNHpx0/4qU7z/2iI2v/RqfBUUZeLC+j07v7HablnavIFDZUjT
        KBzzVYZ3gwzN59i6KSWkndH7qA==
X-Google-Smtp-Source: ADUXVKITzgPPB/u3tfnF4wRyoMP12iuL+6Fg5QHd3mz4OZl+nt+9LWwLpX7ByuPNXGr7LLrcZNC9IQ==
X-Received: by 2002:a17:902:7806:: with SMTP id p6-v6mr3821911pll.17.1529097283111;
        Fri, 15 Jun 2018 14:14:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id q8-v6sm20259044pfi.96.2018.06.15.14.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 14:14:42 -0700 (PDT)
Date:   Fri, 15 Jun 2018 14:14:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Manoj Gupta <manojgupta@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: clang: objtool: native_machine_emergency_restart() falls through to
 next function
Message-ID: <20180615211441.GO88063@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

with your work on objtool and the upcoming implementation of
-fno-delete-null-pointer-checks (https://reviews.llvm.org/D47894,
https://reviews.llvm.org/D47895) in clang most objtool warnings
for clang builds will be fixed.

However even with -fno-delete-null-pointer-checks we currently still
get a warning about native_machine_emergency_restart():

arch/x86/kernel/reboot.o: warning: objtool:
  native_machine_emergency_restart()
  falls through to next function machine_power_off()

This only occurs when building with -Oz.

One of our compiler engineers looked into this, LLVM optimizes the
return statement away since the function has an endless loop, and
actually never returns.

Is there a way to tell objtool that the function is not expected to
return (I tried the attribute __noreturn, but it doesn't make a
difference), or do we have to tell clang to restrain from optimizing
returns out?

To repro:

git checkout v4.16
make CC=clang defconfig
echo "CONFIG_CC_OPTIMIZE_FOR_SIZE=y" >> .config
make CC=clang arch/x86/kernel/reboot.o

Thanks

Matthias
