Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841F1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C49A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeLRVGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:06:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50934 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeLRVGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:06:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so4055784wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jR71NccjeBqIVu10xTr8F8X64Hkkni4cPjl1I2vN5r8=;
        b=KRb5p7VEMlsH1p7vxQ4nSPC6obnIzd8xBLKj4BNeeOjT+HjuYFpN+KYrrWYQllUWYX
         DLoZo+sB7raejWT/wvP6rBLuPL+dF1Xrz1t4efFAXw9CnXS+6yJlP46MXCJdH0JbW0Ii
         iwQnD1Y3Se1cvwd+2kWji7/eXaOFHSdAqJS6O9Am+L1sh1P+tFTibU7U08uqLwJgEBZ3
         Opl2jvXZkJvRu/rcN4M8iVbBwDTSri8zMJfgZ/nTYSD6EhK/oL2nYo92Eb2fGRsRSpMs
         QuV+Tde7DWA2+h4ntWgbpwtvIZ955e3svvvskoLj84f2KVapg1Jp1I1DcLL/kNTR81/x
         oDtw==
X-Gm-Message-State: AA+aEWaGvoATufvAX9b+Yc+GyPs325XNZbLqGM7iPGIJ92EhDiATMTaO
        ROyj+2LkPgxP7jaILaHdedejMA==
X-Google-Smtp-Source: AFSGD/W3aRzFRpSXJjnZk6on5WrzR1Lk4txz81iCAtU6PhAtf265yXsnhaUyeswAbqQGvUBoSDyRsQ==
X-Received: by 2002:a1c:de57:: with SMTP id v84mr4537814wmg.55.1545167168748;
        Tue, 18 Dec 2018 13:06:08 -0800 (PST)
Received: from t460s.bristot.redhat.com (host252-226-dynamic.249-95-r.retail.telecomitalia.it. [95.249.226.252])
        by smtp.gmail.com with ESMTPSA id b13sm6779288wrn.28.2018.12.18.13.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:06:08 -0800 (PST)
Subject: Re: [PATCH V2 9/9] jump_label: Batch up if arch supports it
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <cover.1545149539.git.bristot@redhat.com>
 <3c212982833e3b27f8610c8389413b81ed5fb0e1.1545149539.git.bristot@redhat.com>
 <20181218123556.5257b1a7@gandalf.local.home>
 <d8a417e9-eb0f-d087-f0c5-7405b030e51c@redhat.com>
 <20181218153208.6f8bd858@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <9bc42806-e48f-a9a0-980a-3f0c83dd3d3a@redhat.com>
Date:   Tue, 18 Dec 2018 22:06:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181218153208.6f8bd858@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 9:32 PM, Steven Rostedt wrote:
> Where? Mostly we have BUILD_BUG_ON() which isn't bad at all.
> 
> The only other BUG I see in the jump label code is in the arch specific
> code and that's from 2012. Lately, we are trying to get rid of BUG()
> and panic() entirely, with a few exceptions (where there's really no
> way to return. Like when the function graph stack is corrupted, and we
> don't know where to go).
> 
> If there's a way to continue in a critical state, it's best to WARN()
> and continue on. That way, the user can have a chance to see what
> happened.

Got it!

>> What I could do here is:
>>
>> Add a "fallback" boll that is disabled by default.
>> If I hit this case:
>> 	WARN()
>> 	turn "fallback" on, returning to the old mode (without batch)
>>
>> Sound better?
> Yes, please do.

ack!

Thanks, Steve!

-- Daniel
