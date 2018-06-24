Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EEAC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 23:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D20F2537B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 23:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dPxWQu4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D20F2537B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeFXXwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 19:52:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbeFXXwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 19:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Cc:Subject:From:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9mXmX60PglXrrDtDNg7XbTRkg9hbC6SBcZ/XhTeEkTw=; b=dPxWQu4DvoC2aRmfYB6arLUOq
        jzH2YL5+hI1GqqmrnzzxoHh/UgdBObMAmy5P8B72pyf5jgbMDm+Reec8GNzqV24Tq19LrNyrO12Cn
        PZBmXeWRZa/CjqqawtP6jxjAQPjNYDxspOc1cg+4h5GytkbaU1cV1BeFoWNUt7ROKzzNaRxvaZ9OI
        P0BfkhiymzYSo36NymmuwTl9r5TjcuhAOZF4RSJAFvBIRbL0h14kq5Uh2WimE+xTL+UokPn5zO316
        clj+Cv4KvXcqLtR/Pv5mJ7vAj+B/TKNbeUqmrn0qBkXRlFZ91o5NwAepkXkwHLwP8lNDwbokfKFJh
        m049o75qQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXEnZ-000768-GR; Sun, 24 Jun 2018 23:52:01 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: syscalls: incompatible types and aliases on i386
Cc:     X86 ML <x86@kernel.org>
Message-ID: <d2014bd6-e7c0-251e-aa88-ae7e00b77393@infradead.org>
Date:   Sun, 24 Jun 2018 16:51:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing lots of this type of warning in 4.18-rc2 (maybe even before,
but this is on x86_32/i386, so maybe people aren't checking it so much?):

In file included from ../arch/x86/kernel/process_32.c:40:
../include/linux/syscalls.h:234:18: warning: 'sys_arch_prctl' alias between functions of incompatible types 'long int(int,  long unsigned int)' and 'long int(long int,  long int)' [-Wattribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~
../include/linux/syscalls.h:223:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
../include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
../arch/x86/kernel/process_32.c:310:1: note: in expansion of macro 'SYSCALL_DEFINE2'
 SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 ^~~~~~~~~~~~~~~
../include/linux/syscalls.h:239:18: note: aliased declaration here
  asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                  ^~~~~~~~
../include/linux/syscalls.h:223:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
../include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
../arch/x86/kernel/process_32.c:310:1: note: in expansion of macro 'SYSCALL_DEFINE2'
 SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 ^~~~~~~~~~~~~~~



I see around 300 of these.
Using:  gcc (SUSE Linux) 8.1.1 20180523 [gcc-8-branch revision 260570]

Is there a patch for this?

thanks,
-- 
~Randy
