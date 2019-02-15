Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8762C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932B421B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393807AbfBOMrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:47:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43828 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbfBOMrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:47:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id r2so10180158wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 04:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4EhqVKDQ7ytU6O9AcexiRhW0MJpBEFfT3i9JLbPqJbM=;
        b=d25wBCfh8hvYw8bcYA2iIexDRhfF5Xuqj3+UPmOgHDviqaDbd27J08nkyOEDk6xX74
         j01Y9xbVS9ILPLlF590kkjMMvsscRCUleUuJR/QNT0BtF21OEvfxWaKIUhz4Aw7BdmFf
         ib+ZpnJtHGc1wOHYTRgAJdwOngwS9bELIqUhVKqt+pNpfntj/O45b394SVu9/ZeqjvaY
         33L++8GrO6ZO8HRum3uCD7C2bxAgrdwo1I19yvvHj0wKkJDB6WAWATK72t7X/zo2p+rg
         vDsM6y0YhRUCj4c/o6OjF9RnYW2JyqYa2JY/ev1U3ektp3+R8UmBk3pSQ6oujuemPHU1
         aFyQ==
X-Gm-Message-State: AHQUAuaeOywqiOAueuSHFbV5CxB/NtQHqHlppo1/5B6gMWhMSOc0Tyuo
        A3YGwXYlN1RIr4iKZ0ZIPzfk1w==
X-Google-Smtp-Source: AHgI3IZv1rw6UDc56NutBhV9X1IK40jhN3/tx9e+YZg19nw32H95eMiEbhNdWX0DB6DYexcXUvGxUw==
X-Received: by 2002:adf:dc4e:: with SMTP id m14mr6963829wrj.107.1550234838215;
        Fri, 15 Feb 2019 04:47:18 -0800 (PST)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id d4sm3551274wmb.25.2019.02.15.04.47.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 04:47:17 -0800 (PST)
Subject: Re: [PATCH V4 5/9] x86/alternative: Split text_poke_bp() into tree
 steps
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
 <cf7096ad15708be48f3ea62b4e903f6ef29e2838.1549308412.git.bristot@redhat.com>
 <20190207191552.0782a29d@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <e4bf9378-411f-82d2-db5f-7159b16971ee@redhat.com>
Date:   Fri, 15 Feb 2019 13:47:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207191552.0782a29d@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 1:15 AM, Steven Rostedt wrote:
> On Mon,  4 Feb 2019 20:58:58 +0100
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>>  
>> +static void text_poke_bp_set_handler(void *addr, void *handler,
>> +				     unsigned char int3)
>> +{
>> +	bp_int3_handler = handler;
>> +	bp_int3_addr = (u8 *)addr + sizeof(int3);
>> +	text_poke(addr, &int3, sizeof(int3));
>> +}
>> +
>> +
>> +static void patch_first_byte(void *addr, const void *opcode, unsigned char int3)
>> +{
>> +	/* patch the first byte */
>> +	text_poke(addr, opcode, sizeof(int3));
>> +}
> Hmm, perhaps get rid of the first function entirely, and just do...
> (although why have the "int3" here anyway?)
> 

These helpers were created because they were used twice in the first versions of
this patch set. But with the change suggested by Masami, they are called only in
the text_poke_bp_batch() now, so I am thinking to get rid of them all (removing
this patch).

Thoughts?

Thanks!
-- Daniel
