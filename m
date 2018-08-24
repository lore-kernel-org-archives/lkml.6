Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DF5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C46121557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DUPf/zpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C46121557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeHXTE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:04:59 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41375 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeHXTE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:04:59 -0400
Received: by mail-yb0-f195.google.com with SMTP id z3-v6so3610834ybm.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GQmMU3Gxp4JXIoQDTT0wjvwlOuaD//oyUExjc3i6iZw=;
        b=DUPf/zprGz/ff1XbbVdGNFCLChZcb7yyPgmZXCvdqqH/OEqotcDY+nopYTU3PP3Fxe
         w2m3PXfDZ4ZQYjAJCq2cuZLN2jciiGBUhTy3DPqkw3cr1zpNp+SuLZkPozZuCTwOk1I+
         0E/35quRHALr87PLU/RT1BX2nhpFDBvFNKg/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GQmMU3Gxp4JXIoQDTT0wjvwlOuaD//oyUExjc3i6iZw=;
        b=uWy2U5Zf4M3qVNEptzaszyn2/T306532ZShpr2Jp5746QD+rRbIJ/d7INNBxcIE5A1
         2SeLsBAsZFM1sEfZqumn1Ea4aXwhcvrxH4HnWY1Me0PyPFtbY2BZVqK0+UMZpjO5tA/Z
         KPdv2ZJnme64mPcGi/Q1hMAEPOmsEDfPqTx6z5I76SyNz6teAhhO24DiiiRbCrOcQnJW
         yIGtRYqCfXx9M0jidkTcpyMlm9rL/5MLr3sfBKJg73pO1KAd/Fz38IffdVG4TqEmCfhI
         WJlI+YQvXbufBdbtWEM3nG+uPY71Vb5ADaduC085T2O0msRMtDoIn8+ufjTqOJyjkQvF
         tYOg==
X-Gm-Message-State: APzg51BLejvMPPTV3KjCdhX5teCB9V+CfmwWh1WPUz9GrYLXSz8kZ9u5
        TjQcHrp0XiKo0tdO8q+2ysicz2roKAs=
X-Google-Smtp-Source: ANB0VdbbfihULYo0ZcBCwpASswrCCX+9YAMlzyFkvefBByJIZzsCNRNnzglMJjw5unCi/ZNEffDQWA==
X-Received: by 2002:a25:3cf:: with SMTP id 198-v6mr1280696ybd.414.1535124590428;
        Fri, 24 Aug 2018 08:29:50 -0700 (PDT)
Received: from mail-yb0-f181.google.com (mail-yb0-f181.google.com. [209.85.213.181])
        by smtp.gmail.com with ESMTPSA id j132-v6sm1668457ywg.46.2018.08.24.08.29.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 08:29:48 -0700 (PDT)
Received: by mail-yb0-f181.google.com with SMTP id z3-v6so3610781ybm.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 08:29:47 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr1271283ybh.209.1535124587339;
 Fri, 24 Aug 2018 08:29:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 08:29:46
 -0700 (PDT)
In-Reply-To: <65985f8df55b037283746559c1718a54d56e7ec4.1535119711.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org> <65985f8df55b037283746559c1718a54d56e7ec4.1535119711.git.saiprakash.ranjan@codeaurora.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 24 Aug 2018 08:29:46 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL6tGu9U_ANrZSfWREtySqFAJ+CQa3v5YRihZ2oHNMGGw@mail.gmail.com>
Message-ID: <CAGXu5jL6tGu9U_ANrZSfWREtySqFAJ+CQa3v5YRihZ2oHNMGGw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] pstore: Add register read/write{b,w,l,q}
 tracing support
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 7:45 AM, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
> read/write{b,w,l,q} are typically used for reading from memory
> mapped registers, which can cause hangs if accessed
> unclocked. Tracing these events can help in debugging
> various issues faced during initial development.
>
> We log this trace information in persistent ram buffer which
> can be viewed after reset.
>
> We use pstore_rtb_call() to write the RTB log to pstore.
> RTB buffer size is taken from ramoops dt node with additional
> property called rtb-size.
>
> For reading the trace after mounting pstore, rtb-ramoops entry
> can be seen in /sys/fs/pstore/ as in below sample output.
>
> Sample output of tracing register reads/writes in drivers:
>
>  # mount -t pstore pstore /sys/fs/pstore
>  # tail /sys/fs/pstore/rtb-ramoops-0
>  [LOGK_READ ] ts:36468476204  data:ffff00000800d0fc  <ffff0000084e9ee0>  gic_check_gicv2+0x58/0x60
>  [LOGK_WRITE] ts:36468477715  data:ffff00000800d000  <ffff0000084e9fac>  gic_cpu_if_up+0xc4/0x110
>  [LOGK_READ ] ts:36468478548  data:ffff00000800d000  <ffff0000084e9fd8>  gic_cpu_if_up+0xf0/0x110
>  [LOGK_WRITE] ts:36468480319  data:ffff00000800d000  <ffff0000084e9fac>  gic_cpu_if_up+0xc4/0x110
>  [LOGK_READ ] ts:36468481048  data:ffff00000800d00c  <ffff000008081a34>  gic_handle_irq+0xac/0x128
>  [LOGK_WRITE] ts:36468482923  data:ffff00000800d010  <ffff000008081aac>  gic_handle_irq+0x124/0x128
>  [LOGK_READ ] ts:36468483184  data:ffff00000800d00c  <ffff000008081a34>  gic_handle_irq+0xac/0x128
>  [LOGK_WRITE] ts:36468485215  data:ffff00000800d010  <ffff000008081aac>  gic_handle_irq+0x124/0x128
>  [LOGK_READ ] ts:36468486309  data:ffff00000800d00c  <ffff000008081a34>  gic_handle_irq+0xac/0x128
>  [LOGK_WRITE] ts:36468488236  data:ffff00000800d010  <ffff000008081aac>  gic_handle_irq+0x124/0x128
>
> Output has below 5 fields:
>
>  * Log type, Timestamp, Data from caller which is the address of
>    read/write{b,w,l,q}, Caller ip and Caller name.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

As this is a tracing-like method, could this instead be added to
ftrace? That would mean it could reuse all the ftrace tools and you'd
get pstore storage for free.

-Kees

-- 
Kees Cook
Pixel Security
