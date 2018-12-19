Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18931C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8652184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeLSHiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:38:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36019 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeLSHiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:38:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so17430872wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 23:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bcivv8KFuRDbNKXtCCJGIghczdqRHQkbP+yCg7OYjsk=;
        b=XkKVx5CqkVqRq7emalK+m280vHwuc4nyfVJ+S0y3NTqx6XwXesF7vg0IX8Y/OVX9zV
         zC/GXmUr3VuNk6UwWcb9e4dDivyydZ3eGLrom+wgY7fbwsWlwlibBNf3UFYZuIhyt8rl
         +jpdysLTotLxpKxFoHjWSvtJOLBwn4vj5n0qM7WmHLAO2X11QxDD1tA3kcDLOwlwubDi
         I+X8og/o61vEMyN9iBfnMcFLA7NErpM+5s7juSvpFSK2B2Kbq6q8H02gkQAhVIT5DP7G
         DBJ+Z6F/ehWxQLla2eGqO6rIe8BfZ44tEh5QJFL7mYUtKuHpBX/Dgj+buHnFgIBWh8ty
         cMAQ==
X-Gm-Message-State: AA+aEWbsvszZ3NQ/bj4fWNhK0dK7x/S4JYdEW6duFXCAqs1dUJX2VwS1
        rpISdO5MnSKFrdMW3lBOn5e99A==
X-Google-Smtp-Source: AFSGD/Unf2R7U7qn7hPwD+xVJPMNnfFpEY6JXlbfjijE0jqrmfQW2hWhMzZooCRo6qNy3hbVfUCaUw==
X-Received: by 2002:adf:b716:: with SMTP id l22mr18291186wre.186.1545205086343;
        Tue, 18 Dec 2018 23:38:06 -0800 (PST)
Received: from t460s.bristot.redhat.com ([193.205.81.201])
        by smtp.gmail.com with ESMTPSA id c10sm4145637wrw.49.2018.12.18.23.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 23:38:05 -0800 (PST)
Subject: Re: [PATCH V2 1/9] jump_label: Add for_each_label_entry helper
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <cover.1545149539.git.bristot@redhat.com>
 <c1b514e312238c0fe4e22500d1d41c0f565cae28.1545149539.git.bristot@redhat.com>
 <20181218211923.GM7485@zn.tnic>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <21a12942-2813-9b8a-9051-582070b5eda5@redhat.com>
Date:   Wed, 19 Dec 2018 08:38:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181218211923.GM7485@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 10:19 PM, Borislav Petkov wrote:
> On Tue, Dec 18, 2018 at 05:46:30PM +0100, Daniel Bristot de Oliveira wrote:
>> This patch adds the helper:
>> 	for_each_label_entry(key, entry, stop)
>>
>> For the "for each jump label entry" for defined as:
>> 	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++)
>>
>> Simplifying the reading and usage.
> 
> Please avoid writing "This patch" in a commit message and also what it
> does - that should be obvious. Instead say something like:
> 
> "Add a helper macro to make jump entry iteration code more readable."
> 
> or so.

Right! I will change it!

> But then, IINM, this macro is being used only once. Isn't that a bit too
> much? I mean, you could just as well do:
> 
> 	# iterate over each jump entry
> 	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
> 
> and have it even more readable without introducing macro which is not
> going to be used elsewhere. Or is it going to...?

It is also used in the patch 9. But I can remove it, no problem.

Thoughts?

Thanks!

-- Daniel

