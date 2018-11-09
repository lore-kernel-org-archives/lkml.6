Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9534C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E96620855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A71FZsUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E96620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeKIPp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:45:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeKIPp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:45:29 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABEA6208E3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Nov 2018 06:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541743589;
        bh=edKnIOVpTAW8cmFcOoS4kpKzGT1Q4Tuvv+ifbrrxjA4=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=A71FZsUiKNNIV7YXMPdvTyc4/Ecnqw/yoyW3je+eNo8aWRr2x+q5UgM98IBLvMS4b
         f2D54NANChTBCkZNX+1MFrvhVv29eMmZ/Q/2wiQkG9UDoNXKLRK6XEfJxA0yKKwZBT
         4ku+iTHA5YqdvWeVey4ovBI7Z8kbX0Kh1q4kkFfM=
Received: by mail-wm1-f42.google.com with SMTP id b203-v6so847271wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:06:28 -0800 (PST)
X-Gm-Message-State: AGRZ1gLX534v8teirhw8z5afd6/oSEvkz2xWlVWnS55DHIEzGay5CS08
        udtwy3pWTHmMWtiRa4u55+aoS/mHExqSvZHcxGP9cg==
X-Google-Smtp-Source: AJdET5eUxYpcAqRU2ognw4Rw01N9cbi69Hf4FS/5gLkwRHAP+iThd3XyY/m248E6gVdENwTVIuCsjN2Eut0RKORBUPo=
X-Received: by 2002:a1c:954b:: with SMTP id x72-v6mr3445069wmd.14.1541743585155;
 Thu, 08 Nov 2018 22:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20181107042751.3b519062@akathisia> <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181109031303.GA20906@altlinux.org>
In-Reply-To: <20181109031303.GA20906@altlinux.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 8 Nov 2018 22:06:13 -0800
X-Gmail-Original-Message-ID: <CALCETrUMnBxZ=-EWf5TJY9kqMA9Sy=mtk7OyS0tHub1+DREM=w@mail.gmail.com>
Message-ID: <CALCETrUMnBxZ=-EWf5TJY9kqMA9Sy=mtk7OyS0tHub1+DREM=w@mail.gmail.com>
Subject: Re: [PATCH 00/13] Prepare for PTRACE_GET_SYSCALL_INFO
To:     Andrew Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        aou@eecs.berkeley.edu, jacquiot.aurelien@gmail.com,
        Chris Zankel <chris@zankel.net>,
        Eric Paris <eparis@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, green.hu@gmail.com,
        lftan@altera.com, Mark Salter <msalter@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>, palmer@sifive.com,
        Paul Moore <paul@paul-moore.com>,
        Richard Kuo <rkuo@codeaurora.org>, deanbo422@gmail.com,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-audit@redhat.com, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-xtensa@linux-xtensa.org, nios2-dev@lists.rocketboards.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 7:13 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> syscall_get_arch() is required to be implemented on all architectures
> that use tracehook_report_syscall_entry() in order to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.

Nice!

I'm pretty sure you have vastly more changelog than code here :)

--Andy
