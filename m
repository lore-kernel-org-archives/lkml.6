Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E136C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F136F2159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SOhQ0bs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F136F2159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeI0WFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:05:12 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45101 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeI0WFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:05:11 -0400
Received: by mail-yb1-f193.google.com with SMTP id d9-v6so1272565ybr.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o2dDXoc4o3Opr67mYFPsZEAVgXdrDgApyXSfnIME2Mw=;
        b=SOhQ0bs+4rXQbrBfNu9Ewr1GqE9KSGMfkVdyQAltQpetWHcxEdXwzPSZ7JMbHB4vTX
         q1nuR6ID10MX7sifoPAF3PU0eToAQVcMm50ZmoGvgtL0UqVEFJ0VXksnEGCS09+Vca4V
         G99IEdZJ/wFQtsdBVbdS68KrKXYnc8xFN5Ps4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o2dDXoc4o3Opr67mYFPsZEAVgXdrDgApyXSfnIME2Mw=;
        b=d5n0gdX3mjpOQAwXNxXp8drKZFw3Pr0jipFj7zP6XGjiMMgFETGtlzPFSlGT8qcXSb
         I0tlpYGe43fQA+n02f4cauKME6/YI47w1mA9cmO8/pzsLAmvP68lR33EPdmd/q3F+8BN
         JXuvpz4AesWsSk+thuW0RREZOTp5N8Zyc8YbN7NmN0S+mFqAc77IwYPpGdJktWWb/V7j
         fOafNBCRVuiQ/gIrX5fDX2W/ic72tG8kMqwFnbH/gYJWhr6q19k1eZk+/eDqJAFOG7JN
         5suiR+jcIrU7HpZP7cL8kYY2Hap9Yedb9jCP/e1+66Pp63ljBI/D5nPwg85rSJ3mV/1N
         IURw==
X-Gm-Message-State: ABuFfoiYlhASNPA6AujMFJre+x8DuPUKNT6Klf0AlqRL2dbL5OHoJbJB
        o8UGpChuyoRdiTawfyL5s+2qJlFDy30=
X-Google-Smtp-Source: ACcGV60V3hFPObl4FeqztUfxKncG+ZdkIbidYOnrCb0TESqRlM67vS0XQymML8m01mSr84pyO8cM7w==
X-Received: by 2002:a25:1c83:: with SMTP id c125-v6mr5959721ybc.93.1538063179106;
        Thu, 27 Sep 2018 08:46:19 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id t64-v6sm892098ywe.21.2018.09.27.08.46.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 08:46:17 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id o8-v6so1269609ybk.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:46:17 -0700 (PDT)
X-Received: by 2002:a25:3617:: with SMTP id d23-v6mr6205425yba.141.1538063177226;
 Thu, 27 Sep 2018 08:46:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 08:46:16
 -0700 (PDT)
In-Reply-To: <20180919130803.GH24124@hirez.programming.kicks-ass.net>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org> <20180919130803.GH24124@hirez.programming.kicks-ass.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 27 Sep 2018 08:46:16 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKZSvJo=E1sKzAVuGaCSdEUspB4dUbhpKQ7+otfsyu2wA@mail.gmail.com>
Message-ID: <CAGXu5jKZSvJo=E1sKzAVuGaCSdEUspB4dUbhpKQ7+otfsyu2wA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] add support for relative references in jump tables
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 6:08 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Sep 18, 2018 at 11:51:35PM -0700, Ard Biesheuvel wrote:
>
>> Ard Biesheuvel (8):
>>   kernel/jump_label: abstract jump_entry member accessors
>>   kernel/jump_label: implement generic support for relative references
>>   arm64/kernel: jump_label: switch to relative references
>>   x86: add support for 64-bit place relative relocations
>>   x86: jump_label: switch to jump_entry accessors
>>   x86/kernel: jump_table: use relative references
>>   jump_label: annotate entries that operate on __init code earlier
>>   jump_table: move entries into ro_after_init region
>>
>> Heiko Carstens (1):
>>   s390/jump_label: switch to relative references
>
> This all looks good to me;
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Ingo, could you queue this?

Seconded. :) (My Reviewed-by tags are already in the patches I've examined.)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
