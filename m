Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E616BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71BE2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HnKewxau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71BE2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJQAyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:54:20 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33167 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeJQAyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:54:19 -0400
Received: by mail-yb1-f196.google.com with SMTP id u88-v6so9199461ybi.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W+X5PaUpkOlPOO1tCJJftVuhOIrLdOI2ZHpJ3GHF0Ak=;
        b=HnKewxaupCcOK8cijKFG1yMgJz/jcv6g3pUVPw+UEAxyJzkzAFCVY5caSYRBa0QRZ1
         4FbJApSTyK6JgoYT3E6mrfUVt4s9FS72Id37ahDfoRmJjU8d4W48xlh0j+5SUa/ooSCE
         OzNVBZbLvuyPUU1zuuy/OSwPjCIZuyJfTdM3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W+X5PaUpkOlPOO1tCJJftVuhOIrLdOI2ZHpJ3GHF0Ak=;
        b=hutguLTnLsZvQVfOsHai3482q8VBmVXq4aBz2CxW+PebNhSRpppJ+J90IK+p9PVKC3
         X82ivzRnQOGdxzy9Ty6O3/vd5EF3x82wIUdai1dqgHK3VBAWbMP1wGTxRXVCXJrn9KcF
         V0kyj6f8zF8L9YAbY94KsbwT7u45wiMyRGNjzMMgDAkMx7NOh7fjyHifaNbDyocLjViP
         nlwBvHHGe5ByccIHxSAEzwdI4bJt7f5MRyfchVTIHl2XKt5DMuIrRG60+86Zk5OOre6s
         4IODhZW57NJXfJsH9/IIfKrZzosaA1ZqxfRNjyDVjhEDteIOsjGfZJVL0AGZcH/334I6
         rLlg==
X-Gm-Message-State: ABuFfoiQUmzWX5LzAlIOyVDFf3knP8IWcG3wcwQt1BIBTSSxuB3b43mB
        HRFzOINQ4QCfa6HfyZwwjf7MAowMbcs=
X-Google-Smtp-Source: ACcGV61WxDRVW2VZoqpcbIiMCb9dw+Y3rL1kfW6HurLKXYKMgrTpCpz1zTAfzICWW8W5R9MbJ/hOdg==
X-Received: by 2002:a25:9343:: with SMTP id g3-v6mr5601608ybo.222.1539709378999;
        Tue, 16 Oct 2018 10:02:58 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id q11-v6sm3485024ywc.77.2018.10.16.10.02.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 10:02:56 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id m127-v6so9206484ywb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 10:02:55 -0700 (PDT)
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr12732048yws.168.1539709374873;
 Tue, 16 Oct 2018 10:02:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 16 Oct 2018 10:02:53
 -0700 (PDT)
In-Reply-To: <20181016112928.4b52afb5@gandalf.local.home>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org> <20181016112928.4b52afb5@gandalf.local.home>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Oct 2018 10:02:53 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLBtBU1eX7tGX1gOVKSFKeLMeoke3bGHUuqxk86dLSnng@mail.gmail.com>
Message-ID: <CAGXu5jLBtBU1eX7tGX1gOVKSFKeLMeoke3bGHUuqxk86dLSnng@mail.gmail.com>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 8:29 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 16 Oct 2018 17:08:25 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
>> One more thing is for pstore dmesg-ramoops, I had to change
>> late_initcall to postcore_initcall which brings the question as to why
>> we changed to late_initcall?
>> Simple git blame shows to support crypto compress api, but is it really
>> helpful? A lot of boottime issues can be caught with pstore enabled at
>> postcore_initcall rather than late_initcall, this backtrace
>> is just one example. Is there any way we could change this?
>
> Does it break if the crypto is not initialized? Perhaps add a command
> line flag to have it happen earlier:
>
>  ramoops=earlyinit
>
> and add a postcore_initcall that checks if that flag is set, and if so,
> it does the work then, and the late_initcall() will do nothing.
>
> That way, you can still have unmodified kernels use pstore when it
> crashes at boot up.

Even better, if we could find a way to make it work with a late
initialization of compression (i.e. postcore_initcall() by default
means anything caught would be uncompressed, but anything after
late_initcall() would be compressed). I'd be very happy to review
patches for that!

-Kees

-- 
Kees Cook
Pixel Security
