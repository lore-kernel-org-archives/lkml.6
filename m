Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C9CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063C820863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="EU2oA2Nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063C820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeK2IPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:15:13 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36814 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK2IPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:15:13 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so23904742oix.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 13:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=ExmCBoOua2MUabiHglWEp17CO0p9PpNwj02pbR1LYqY=;
        b=EU2oA2Nh93ashUpkDaLGsXZo/SljzDTQFC2oaXJic/Q8g8KKgjvgWgyWjIdoRcPAY0
         wP24yVp6uepKT4PgjxOd991OY5gscrNV4X+upoGRCo1rBgnzhbWtVb/vrML+Q4AnSbIE
         fZBkLjI0oQobFPjh6KXPLGfD43ZomnMx/niw8JHp3TuHBh9+ntyXO0QcOCvByxLTJ5IW
         pHCxT5OxOfQmOkKWchLhmohLNXTVgVVKMNjrv8iSJU++JOtQ2j1MpPySpUS6sXfma3sQ
         tuLWmt8ekgyU3LdAdQpF5pzjTMzV20wchLeVDa3MSmVGtQ/vfi0nPMYBWVmF7T/VstQZ
         jVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=ExmCBoOua2MUabiHglWEp17CO0p9PpNwj02pbR1LYqY=;
        b=avNq/WlZ2eO4M3yUJj8+ncjph75/c6nD1BD58hIDTjf0zovQiYUhn/M2GyV9+IR2mU
         /0C1zY1lHrJBviMxASxKQsWs0ITEvktUQduDMA2EZJ0TspCxs7R8SG2yoTUEdCd9sSJH
         PL8n752PT6MJjSRWZIhCY/SVs9zh9dn9gnhcg7ZD8NcolBAWo30sxoTdm3jeJ0QEa5Kl
         L45HEaDBzMKFRlMY4SAAiw6010GiusPUlM5VtIZ3xujE3J94lkZzajUZLo1KKuEXJLi1
         8JVGCiuMWobu6hcMPnHF6X102l8nhy1BnE7pUV+ElHyD3vtVDH6G71KFC4QwYJyhHzzQ
         CKKQ==
X-Gm-Message-State: AGRZ1gLZCgzKJgVuxAAL3BP8CnEJk67XFCcPTAfCakxzP5u+J7LLrh8d
        IZWr5pXBmNAHSjdbLMd2qZFSOQ==
X-Google-Smtp-Source: AJdET5cKDlEI/h3cCz0F+rBdnbz5DkvszLznRzLD9dnFtH8NOm83Yo1+cKMgw5bltTGjvZIr/S5BiQ==
X-Received: by 2002:aca:ebd4:: with SMTP id j203mr22452521oih.222.1543439534516;
        Wed, 28 Nov 2018 13:12:14 -0800 (PST)
Received: from [100.146.221.89] ([172.56.6.202])
        by smtp.gmail.com with ESMTPSA id r17sm6166930otn.0.2018.11.28.13.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 13:12:13 -0800 (PST)
Date:   Thu, 29 Nov 2018 10:12:05 +1300
User-Agent: K-9 Mail for Android
In-Reply-To: <87in0g7waf.fsf@oldenburg.str.redhat.com>
References: <20181119103241.5229-1-christian@brauner.io> <20181119103241.5229-4-christian@brauner.io> <87in0g7waf.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] procfd_signal.2: document procfd_signal syscall
To:     Florian Weimer <fweimer@redhat.com>
CC:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <E81EDAAC-F9E3-4D3A-AEE8-09E266D7FEDB@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 29, 2018 9:59:52 AM GMT+13:00, Florian Weimer <fweimer@redhat=
=2Ecom> wrote:
>* Christian Brauner:
>
>> +=2E\" Copyright (C) 2018 Christian Brauner <christian@brauner=2Eio>
>
>The text seems to be largely derived from rt_sigqueueinfo, so I'm not
>sure if this appropriate here=2E
>
>> +the null signal (0) can be used to check if a process with a given
>> +PID exists=2E
>
>What does this mean if hte process is identified by file descriptor?
>
>> +=2EPP
>> +The optional
>> +=2EI info
>> +argument specifies the data to accompany the signal=2E
>> +This argument is a pointer to a structure of type
>> +=2EIR siginfo_t ,
>> +described in
>> +=2EBR sigaction (2)
>> +(and defined by including
>> +=2EIR <sigaction=2Eh> )=2E
>> +The caller should set the following fields in this structure:
>> +=2ETP
>> +=2EI si_code
>> +This must be one of the
>> +=2EB SI_*
>> +codes in the Linux kernel source file
>> +=2EIR include/asm-generic/siginfo=2Eh ,
>> +with the restriction that the code must be negative
>> +(i=2Ee=2E, cannot be
>> +=2EBR SI_USER ,
>> +which is used by the kernel to indicate a signal sent by
>> +=2EBR kill (2))
>> +and cannot (since Linux 2=2E6=2E39) be
>
>Obsolete reference in this context=2E
>
>> +=2ETP
>> +=2EB ESRCH
>> +The process or process group does not exist=2E
>> +Note that an existing process might be a zombie,
>> +a process that has terminated execution, but
>> +has not yet been
>> +=2EBR wait (2)ed
>> +for=2E
>
>Again: What does this mean if the process identified by a descriptor?
>Does a process in zombie state exist in this sense or not?
>
>Thanks,
>Florian

Updating the document is on my Todo=2E
Florian, can you take a look at the actual patch too, please?
