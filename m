Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991E9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A61A208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oPwhyJMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A61A208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJBF0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:26:12 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46164 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBF0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:26:12 -0400
Received: by mail-yw1-f66.google.com with SMTP id j202-v6so1748784ywa.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UMzJokdN836gOh5JAgIVLjCkTlz0ooJGNhxCcGJyP+w=;
        b=oPwhyJMemd0B4pNTa9TnSGo0z51tzG9fA7HhMGTMc7mr3rAZvdxdFtBpA9nbLou/rH
         bUC6MGt26lYWo1p+/IcqVeyOT7lTa4b0Fiuu7i0xElg4vblKUwuW24B1dlnSqBEWTBTC
         ShTLjvl2Ki9YeDtkNox/KUgQ1L7M1WBgPNSfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UMzJokdN836gOh5JAgIVLjCkTlz0ooJGNhxCcGJyP+w=;
        b=DAvsPsNvCtT3qFQmsL43DiPfdVFDebIQ/IHYRq8FM4Yr6NYd4WKJyZDhkowY88xdXt
         yCONEChHBXvMehBf/YkzecdZkofASmdU/Vu6L4Uul77vw6d9BPoaoH1hRwnjekYs9Cbj
         uQQGcHHXmr2wa+pqWdT9P480/5wluMj34b6I2ftufigNongPHnfcHUiSI7jJS1Y3ZnO/
         Ss7l7wE86PnA9+rkB9Pi3wIFZSZaViQkQvJR/1csXI6hjZX3bBdzA7Vto1en/tV/UVR2
         ylS9DTDSQww4gwxGPZdklLt3Vn36tiR493pK6OgGQVRZn5c/vQdHNrx29+rBMnMNr2Ql
         oFNA==
X-Gm-Message-State: ABuFfohIdWg19+1qKC7NyGqllxe9NRv7xvsRW5Mu86EAEE6KdK5oGVMh
        9NR8ESAq873UlXIQRILtZ0s/igsVX1o=
X-Google-Smtp-Source: ACcGV62JfE/5QREP0RsPHMprnZMfJfan3uj/8fNYOzCF9PQhPT3SeE58jBA8IWGZvkI8J8zZWt6lAw==
X-Received: by 2002:a0d:e984:: with SMTP id s126-v6mr7219979ywe.253.1538433967954;
        Mon, 01 Oct 2018 15:46:07 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id p128-v6sm7164063ywp.65.2018.10.01.15.46.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 15:46:07 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id a197-v6so2248671ywh.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:46:07 -0700 (PDT)
X-Received: by 2002:a81:2908:: with SMTP id p8-v6mr7166457ywp.407.1538433536573;
 Mon, 01 Oct 2018 15:38:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 15:38:55 -0700 (PDT)
In-Reply-To: <20181001172315.225d18dc@gandalf.local.home>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-5-keescook@chromium.org>
 <b169724f-c6c2-f4c0-806b-c8e23819ea6a@canonical.com> <20181001172315.225d18dc@gandalf.local.home>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 15:38:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJbO7c0Hiw8_9hhkbo74c-56g5ppW8g1ynyPt-WsLaxRw@mail.gmail.com>
Message-ID: <CAGXu5jJbO7c0Hiw8_9hhkbo74c-56g5ppW8g1ynyPt-WsLaxRw@mail.gmail.com>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 2:23 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 1 Oct 2018 14:07:55 -0700
> John Johansen <john.johansen@canonical.com> wrote:
>
>> On 09/24/2018 05:18 PM, Kees Cook wrote:
>> > This partially reverts commit 58eacfffc417 ("init, tracing: instrument
>> > security and console initcall trace events") since security init calls
>> > are about to no longer resemble regular init calls.
>> >
>> > Cc: James Morris <jmorris@namei.org>
>> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> > Cc: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
>> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> > Cc: linux-security-module@vger.kernel.org
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>>
>> though I do think it would be a good idea to add a new set
>> of trace points, but that can come as a separate patch
>>
>>
>
> Agreed.

BTW, how would this look? I'm not familiar with adding new tracepoints...

-Kees

-- 
Kees Cook
Pixel Security
