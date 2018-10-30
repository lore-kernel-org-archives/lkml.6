Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB483C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCF72080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QfUteZed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCF72080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeJ3SdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:33:09 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:59107 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeJ3SdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:33:09 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9U9e1G4015424
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 18:40:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9U9e1G4015424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540892402;
        bh=IX4TvQU0KfyT5v+vO7hXSZ1k1oxi8UCciQlFsENTRDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QfUteZedZ1mpk5VVr0NiAId6p/9aO/0KiT3muML+7n+Q9ahPxHmsx4W6m1CilSC6s
         Q0+t1w80UAJ+fs1Wkd7rdbqtIwrN5oCuObFQ/5JJNp6HhSloykI338Wefe89q9lLQt
         0hwZ6MEHeI8mm6RlJVrLrpOtelTHKj+nwegizbWWkbjE0ez/M1zQ9PkkY5fPl42FkO
         qV4mmFCGsU+0w9Diok1D8wX1mBNN8WVmb1uZ2OyExggeWFfCUl0qHGm2TGqXnoz/80
         s8VYnuKC05AYtOPqLQMtn88qcm1Xb3yUDeQv+ImDpTQA70XReY0Znf7zGg+ZQ4kp15
         /Jp2i9Zgpr28A==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id g10so4192342uak.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 02:40:02 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJEi3CgS8D7sX4O5WZ5DbMqBN2kItBJz+WCkrBXfwRJg0kxhsDV
        gs7YiLUZZXOY7tQIT3L0GAVjt5brJFw31uZ7+sM=
X-Google-Smtp-Source: AJdET5eSjC2D0CLovtmDGqwte+iZ6ju1up+d8fcqVgmtwVQvYbWRp6yWyAb22J4zrF2DIP3HZi8AKQG/PEzb+GJrmbE=
X-Received: by 2002:ab0:5444:: with SMTP id o4mr5596020uaa.55.1540892401308;
 Tue, 30 Oct 2018 02:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <e63900bc-d7af-4a57-aa96-f6cc84b89e09@default>
In-Reply-To: <e63900bc-d7af-4a57-aa96-f6cc84b89e09@default>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 30 Oct 2018 18:39:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQG62vzFpDC_xoTEh6CuxmRVU7jAtVe7YpVmqou1hEagQ@mail.gmail.com>
Message-ID: <CAK7LNAQG62vzFpDC_xoTEh6CuxmRVU7jAtVe7YpVmqou1hEagQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] retpolines: Only enable retpoline when compiler
 support it
To:     zhenzhong.duan@oracle.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, konrad.wilk@oracle.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, srinivas.eeda@oracle.com,
        Borislav Petkov <bp@suse.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michal Marek <michal.lkml@markovi.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,



On Tue, Oct 30, 2018 at 3:57 PM Zhenzhong Duan
<zhenzhong.duan@oracle.com> wrote:
>
> Since retpoline capable compilers are widely available, make
> CONFIG_RETPOLINE hard depend on it.
>
> Change KBUILD to use CONFIG_RETPOLINE_SUPPORT to avoid conflict with
> CONFIG_RETPOLINE which is used by kernel.
>
> With all that stuff, the check of RETPOLINE is changed to
> CONFIG_RETPOLINE.
>
> This change is based on suggestion in https://lkml.org/lkml/2018/9/18/1016
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> ---


Instead of adding another CONFIG option,
does it make sense to add compiler support checks
to 'depends on' syntax ?


config RETPOLINE
         bool "Avoid speculative indirect branches in kernel"
         depends on $(cc-option,-mindirect-branch=thunk-extern
-mindirect-branch-register) || \
                    $(cc-option,-mretpoline-external-thunk)
         default y
         select STACK_VALIDATION if HAVE_STACK_VALIDATION






-- 
Best Regards
Masahiro Yamada
