Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EB8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ED621927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391101AbfBOQAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:00:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37983 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391029AbfBOQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:00:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so10103825wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RSWMYoh2m2aH6oy93JiWom/YXxiOyMbF7IrlsBBtFeA=;
        b=Sk1sLbjRjG8deotGRcYJB9DIAyrAl+uxvKjHf1KMCAiV/+wvU2Zyn0cy4edJpaEr8A
         WjOAEYx5w4t+rIQdXiPUAzsUL9qdkwBG5kgLDTOaVRfjc7sFIiXrZIUMrGa1xyiyc+z9
         lO4D8F0X4SKV9yQ+JKdHiKrlqwk8HhBN9iHIYjJbn7z3wN4p1lnV0omYC0jRjso869HF
         NpAGk9sosPsE3TcX1NuHC14XCNwwvN9NRVo393XE+ZsAYi435qBjOFQUjNiYfNUA6zDY
         uER5DXiTjF/iwVRPOwXV9f3lKkT2jpuXnkF1u5yks3IgDuuNvOOV9JW48kO5b0yUNcij
         bJzA==
X-Gm-Message-State: AHQUAubKklFLDbIXD9B0zbH8Dfm07JPVoLuKg7I6ZpIEQPgfXzDQVtjI
        +jFUbQJTO3uzZUtBhAuxZwenhg==
X-Google-Smtp-Source: AHgI3IYzY9LL6dyUCfxQctc3VDH0ntqI2+WstrSjMBv5/y1iMke0oWqVnBrPcmSA/7U7UeQ1031qwQ==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr6987747wmk.149.1550246451362;
        Fri, 15 Feb 2019 08:00:51 -0800 (PST)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id w22sm5746426wmc.9.2019.02.15.08.00.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 08:00:50 -0800 (PST)
Subject: Re: [PATCH V4 7/9] x86/alternative: Batch of patch operations
To:     Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <cover.1549308412.git.bristot@redhat.com>
 <84e6b00634085f0fca721e4e7e5aaf43cd062564.1549308412.git.bristot@redhat.com>
 <20190214125330.GB12467@zn.tnic> <20190214090620.1ee73a36@gandalf.local.home>
 <20190214143030.GB4423@zn.tnic> <20190214094011.6e8a22eb@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <23408225-1768-d01e-4fd6-24289ef673ae@redhat.com>
Date:   Fri, 15 Feb 2019 17:00:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214094011.6e8a22eb@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 3:40 PM, Steven Rostedt wrote:
> On Thu, 14 Feb 2019 15:30:30 +0100
> Borislav Petkov <bp@alien8.de> wrote:
> 
>>> 	void *trampoline;  
>>
>> Well, it ain't a trampoline either. It is a "temporary location to go to while
>> patching is going on".
> 
> 	void *detour;
> 

The comment on top of text_poke_bp() defines:

handler:    address to jump to when the temporary breakpoint is hit

so, how about tmp_jump_addr?

well, detour works as well :-)

thoughts?

Thanks!
-- Daniel
