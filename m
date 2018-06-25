Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C28C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39005253D1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZxiOVxo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39005253D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeFYCWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 22:22:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbeFYCWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 22:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ubT3V0bdTZcdgVCi6Yrf3mINHtnD7iqYXOsI8Lc1yJ8=; b=ZxiOVxo0wyJ0GzqeqbzJckTSu
        f8AheWIBViNoz1luhgbb/fDFDsMn0RwGQDhaWLc9/eJPYvqNvghfcwpDY2/RdmgeOuzDKJTjSBsOu
        8ODKFp4dqV+XRYL18VdEXv0t3g5008ykRsMY/pO1nwfHjdGxpr1OkDzrw2Puxzu+zA0NZgF/DehXT
        RV9ErgFalX1JbQpA0MNg6vaJ0+oLie3Rww7sm8ehjPDgKbL0/AolIMFcVxAQfGUjzDqlQQ9xC3/Cp
        VA0PufScaRohECaDcGmi9tr69rtPPPOhhj84X4fY1hHka/b/35WM8RgrPc2gYOcIn4iI2QLd2Ivrb
        UTaD0J8QA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXH9R-0008RF-JM; Mon, 25 Jun 2018 02:22:45 +0000
Subject: Re: syscalls: incompatible types and aliases on i386
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     X86 ML <x86@kernel.org>
References: <d2014bd6-e7c0-251e-aa88-ae7e00b77393@infradead.org>
Message-ID: <899b9c95-7515-f843-662e-5ffa93a3f3e4@infradead.org>
Date:   Sun, 24 Jun 2018 19:22:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d2014bd6-e7c0-251e-aa88-ae7e00b77393@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/2018 04:51 PM, Randy Dunlap wrote:
> Hi,
> 
> I'm seeing lots of this type of warning in 4.18-rc2 (maybe even before,
> but this is on x86_32/i386, so maybe people aren't checking it so much?):
> 
> In file included from ../arch/x86/kernel/process_32.c:40:
> ../include/linux/syscalls.h:234:18: warning: 'sys_arch_prctl' alias between functions of incompatible types 'long int(int,  long unsigned int)' and 'long int(long int,  long int)' [-Wattribute-alias]
>   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>                   ^~~
> ../include/linux/syscalls.h:223:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~
> ../include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>  #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
>                                     ^~~~~~~~~~~~~~~
> ../arch/x86/kernel/process_32.c:310:1: note: in expansion of macro 'SYSCALL_DEFINE2'
>  SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
>  ^~~~~~~~~~~~~~~
> ../include/linux/syscalls.h:239:18: note: aliased declaration here
>   asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>                   ^~~~~~~~
> ../include/linux/syscalls.h:223:2: note: in expansion of macro '__SYSCALL_DEFINEx'
>   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~
> ../include/linux/syscalls.h:213:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>  #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
>                                     ^~~~~~~~~~~~~~~
> ../arch/x86/kernel/process_32.c:310:1: note: in expansion of macro 'SYSCALL_DEFINE2'
>  SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
>  ^~~~~~~~~~~~~~~
> 
> 
> 
> I see around 300 of these.
> Using:  gcc (SUSE Linux) 8.1.1 20180523 [gcc-8-branch revision 260570]
> 
> Is there a patch for this?

Found it.

thnx,
-- 
~Randy
