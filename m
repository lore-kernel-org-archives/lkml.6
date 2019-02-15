Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E0FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AE721924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393362AbfBOKFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:05:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37796 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387578AbfBOKF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:05:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so8925755wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KSvtxws+WnSjw5JKVDERpE4PVInlOZj6YPpbscDAEJU=;
        b=juijCKPULovCFnaaK2HTFAQUL+n2+5EK34jSF6uPlxXgpdxVl5GT15o8i/P7kPpATP
         PsWguWg01GsQi6wndqPmHAlhfcb6Zueq9+UcR3WvTZVix+J+jeHd3z/YqBKtL8NKaDG6
         vVURRrTfPvVv2Qywo5O92IWOjnQfh1EFO/1/DXnC6JZ3lJuhmwurz/D/4i++51LTnTn+
         /J4a+U3XqPw0umJp9ZeKbBWhGxRFlaX1LzIRli5qRfEJjxAl/Gd+5f0mt+tFgTtmAegZ
         RZk6Ni/nTtPqllrCu9FF/L7gCL4CCWp4E46lEL7hqBCwAQLiTeIU+kpeNLjm+k0SXNlw
         8U8Q==
X-Gm-Message-State: AHQUAuYwVToybQRvbaeezxhLHdTfD3QBiYccEpAYujcMSKIb/70fd2u5
        qFzPgcR6H+lno3u/ko/XWsLZYQ==
X-Google-Smtp-Source: AHgI3IZ5MuC4GtCt9kGXTZTrHPf9FKHyU+qWhfR5QUittT9ps1xq9Vin7SBHuoraiIYSxnV6XoYDUQ==
X-Received: by 2002:a1c:ab87:: with SMTP id u129mr5947139wme.104.1550225127355;
        Fri, 15 Feb 2019 02:05:27 -0800 (PST)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id c65sm7803794wma.24.2019.02.15.02.05.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 02:05:26 -0800 (PST)
Subject: Re: [PATCH V4 3/9] x86/jump_label: Move checking code away from
 __jump_label_transform()
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <cover.1549308412.git.bristot@redhat.com>
 <10e6ab5f9481a5a51bd6dd6c818453908ea60777.1549308412.git.bristot@redhat.com>
 <20190205073321.GE21801@zn.tnic>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <fe3179b1-6d94-17dd-a30f-e183e8143775@redhat.com>
Date:   Fri, 15 Feb 2019 11:05:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205073321.GE21801@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 8:33 AM, Borislav Petkov wrote:
> On Mon, Feb 04, 2019 at 08:58:56PM +0100, Daniel Bristot de Oliveira wrote:
>> Move the check of the current code, before updating an entry, to specialized
>> functions. No changes in the method, only code relocation.
>>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>> Cc: Jiri Kosina <jkosina@suse.cz>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>> Cc: Chris von Recklinghausen <crecklin@redhat.com>
>> Cc: Jason Baron <jbaron@akamai.com>
>> Cc: Scott Wood <swood@redhat.com>
>> Cc: Marcelo Tosatti <mtosatti@redhat.com>
>> Cc: Clark Williams <williams@redhat.com>
>> Cc: x86@kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  arch/x86/kernel/jump_label.c | 60 +++++++++++++++++++++++++-----------
>>  1 file changed, 42 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
>> index f99bd26bd3f1..e443c43478eb 100644
>> --- a/arch/x86/kernel/jump_label.c
>> +++ b/arch/x86/kernel/jump_label.c
>> @@ -35,16 +35,53 @@ static void bug_at(unsigned char *ip, int line)
>>  	BUG();
>>  }
>>  
>> +static inline void __jump_label_trans_check_enable(struct jump_entry *entry,
>> +						   enum jump_label_type type,
>> +						   const unsigned char *ideal_nop,
>> +						   int init)
>> +{
>> +	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
>> +	const void *expect;
>> +	int line;
>> +
>> +	if (init) {
>> +		expect = default_nop; line = __LINE__;
>> +	} else {
>> +		expect = ideal_nop; line = __LINE__;
>> +	}
>> +
>> +	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
>> +		bug_at((void *)jump_entry_code(entry), line);
>> +}
>> +
>> +static inline void __jump_label_trans_check_disable(struct jump_entry *entry,
>> +						    enum jump_label_type type,
>> +						    union jump_code_union *jmp,
>> +						    int init)
>> +{
>> +	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
>> +	const void *expect;
>> +	int line;
>> +
>> +	if (init) {
>> +		expect = default_nop; line = __LINE__;
>> +	} else {
>> +		expect = jmp->code; line = __LINE__;
>> +	}
>> +
>> +	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
>> +		bug_at((void *)jump_entry_code(entry), line);
>> +}
> 
> Why the carve out?
> 
> The next patch is adding __jump_label_set_jump_code() which calls them
> so you could just as well keep the functionality all in that function without
> having too many helpers which are called only once...
> 

I removed these helpers and moved the code to __jump_label_set_jump_code().

The function looks like this now:
-------------- %< ----------------------
static void __jump_label_set_jump_code(struct jump_entry *entry,
				       enum jump_label_type type,
				       union jump_code_union *code,
				       int init)
{
	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
	const void *expect;
	int line;

	code->jump = 0xe9;
	code->offset = jump_entry_target(entry) -
		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);

	if (type == JUMP_LABEL_JMP) {
		if (init) {
			expect = default_nop; line = __LINE__;
		} else {
			expect = ideal_nop; line = __LINE__;
		}

		if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
			bug_at((void *)jump_entry_code(entry), line);

	} else {
		if (init) {
			expect = default_nop; line = __LINE__;
		} else {
			expect = code->code; line = __LINE__;
		}

		if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
			bug_at((void *)jump_entry_code(entry), line);

		memcpy(code, ideal_nop, JUMP_LABEL_NOP_SIZE);
	}
}
-------------- >% ----------------------


Thanks!

-- Daniel
