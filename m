Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C2CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E8621871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeLSKOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:14:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40340 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbeLSKOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:14:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so5068288wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 02:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W1/tkFOU+vxydoqmgf2UXUN/v3TmEjtahGnlqdX24vo=;
        b=PSCM/wWhiBK0kVpiQAXjb9N6TRtu1/bXolWJGlUDDV0PpWAaa/qWlO9QK4RmA6/KJN
         Nrg/qY5EhChJNAsh9pWubUYeVx9VmbZpVS9lHvif4E7OVISWjxjjlkfx15sb/lK2TerS
         s4lzo5nQFo7gY0qNjCAnraGfmSe42631mdQm7yfShutGUnAW9qoWfL07a0BpSo1ECfq8
         WdItyQQ+x7qFQmD26TL9HtQDABMglVyrW5PfCDGkK46gCx1sIgERyKOr8Upiz3ouJ/q6
         VjGxWRVfPQDuOg977LpzOWewlO2A3qMScPtiYAM/BpF9wizDGlUwxXW92pVoLT5m6g1d
         rzcg==
X-Gm-Message-State: AA+aEWZe3uqLZ0fhYG76369tey+PO2RazLK4Twwqt2DciSrqM5XRfc4Z
        gjy7Apzx6rMG3E5Ut301qnOg2A==
X-Google-Smtp-Source: AFSGD/X+prInQT9Nwtg64E9sHjAkBNKNDvdPnHT3zxYWowhRVLdQB5sES2VXnPXzbOXnr4KhQe0OLg==
X-Received: by 2002:a1c:ad43:: with SMTP id w64mr6389130wme.32.1545214491213;
        Wed, 19 Dec 2018 02:14:51 -0800 (PST)
Received: from t460s.bristot.redhat.com ([193.205.81.201])
        by smtp.gmail.com with ESMTPSA id f192sm5350419wmd.12.2018.12.19.02.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 02:14:50 -0800 (PST)
Subject: Re: [PATCH V2 3/9] x86/jump_label: Move checking code away from
 __jump_label_transform()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <cover.1545149539.git.bristot@redhat.com>
 <1d1a40fec7285eaf47b8055a26684508109eefb7.1545149539.git.bristot@redhat.com>
 <nycvar.YFH.7.76.1812190942360.17216@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1812190949250.1651@nanos.tec.linutronix.de>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <2e694ddf-f315-ed74-8f0b-c5edce48b4a5@redhat.com>
Date:   Wed, 19 Dec 2018 11:14:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1812190949250.1651@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 9:49 AM, Thomas Gleixner wrote:
> On Wed, 19 Dec 2018, Jiri Kosina wrote:
> 
>> On Tue, 18 Dec 2018, Daniel Bristot de Oliveira wrote:
>>
>>> This patch creates a new functions 
>>
>> I am not a native speaker, but this doesn't sound like proper english to 
>> me.
> 
> Aside of that 'This patch' is wrong to begin with. See Documentation/process/
> 

I will address these errors in the next version.

Thanks.

-- Daniel
