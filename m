Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD04EC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8460F21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfBGRB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43416 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfBGRBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:24 -0500
Received: by mail-qt1-f196.google.com with SMTP id y4so613953qtc.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IIQVg0/54aHNSuas4/Tru3avab4Ag3l4H/PDl5CjyJY=;
        b=rlVBS5BUQgXuSzuuZlHW5oDnWOnCqVvybbRprcXsbUk5o1al8Mrp1LeT5TZ+l26Fak
         tQ2Ik4XXRWgtOEr2NTSQsUW6JQq2z/LHt8VrHj10NhcRZkqJlvKUXUIoW4YBdU1vE8EW
         j1bh6z7cAV7u9rcMq4AF6O13qlC5w/HSJFQxLIfFgf6IOjB4dlUIwN7eCSN4wV7UHJkM
         bM6s5ooPcPMA4BR/+ucCqTtuQf49fuPHf9Z14THFkwBegzg0C4cNnGUTSS+Wy7ZLUkkT
         e6SLydIDJZR/2GwTk/KHYrTsKIInM5AXckFt6cbO1Pd2ZMI5/z694NKqj4faGqufe4hv
         MbMw==
X-Gm-Message-State: AHQUAuZkgPFNkzStE+v9jgZ11BQAAfzsHukqsNHsphz5gzpXwqkTSl5z
        /wtKU3LpoiBYPD8i7eVrgzjggRuVksqdRA==
X-Google-Smtp-Source: AHgI3IaMpbxB1PIhg95K+sp2Vjj65sg8dUr2oCY6U4Prj8z9irHL0x7REPC27HG3vTH6PinkHiGGag==
X-Received: by 2002:aed:31c5:: with SMTP id 63mr12716789qth.385.1549558882260;
        Thu, 07 Feb 2019 09:01:22 -0800 (PST)
Received: from t460s.bristot.redhat.com ([177.72.25.22])
        by smtp.gmail.com with ESMTPSA id 10sm11914810qtx.60.2019.02.07.09.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 09:01:21 -0800 (PST)
Subject: Re: [PATCH V4 2/9] jump_label: Add the jump_label_can_update_check()
 helper
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
 <36237a0ee38d6c98d080d3fee2921501d8788e4d.1549308412.git.bristot@redhat.com>
 <20190205072220.GD21801@zn.tnic>
 <cb65e500-44dd-873c-622f-b49b9336b6a2@redhat.com>
 <20190205211348.GV21801@zn.tnic>
 <30b5ffc9-9794-874b-1544-d05034b55f1b@redhat.com>
 <20190207140819.GF2414@zn.tnic>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <473c03b3-c5c3-7412-e2ad-3dedb413d165@redhat.com>
Date:   Thu, 7 Feb 2019 18:00:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207140819.GF2414@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 3:08 PM, Borislav Petkov wrote:
> On Thu, Feb 07, 2019 at 02:21:09PM +0100, Daniel Bristot de Oliveira wrote:
>> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
>> index 288d630da22d..1e6f4d27e28d 100644
>> --- a/kernel/jump_label.c
>> +++ b/kernel/jump_label.c
>> @@ -374,22 +374,29 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
>>  	return enabled ^ branch;
>>  }
>>  
>> +static bool jump_label_can_update(struct jump_entry *entry, bool init)
>> +{
>> +	/*
>> +	 * Cannot update code that was in an init text area.
>> +	 */
>> +	if (!init || jump_entry_is_init(entry))
> 
> Shouldn't this be &&
> 
> ?

Oops! should be &&! sorry.

>> +		return false;
>> +
>> +	if (WARN_ONCE(!kernel_text_address(jump_entry_code(entry)),
>> +			 "can't patch jump_label at %pS", (void *)jump_entry_code(entry)))
>> +		return false;
> 
> Yeah, I think that this way of writing it is less readable than:
> 
> 	if (!kernel_text_address(jump_entry_code(entry))) {
> 		WARN_ONCE(1, "can't patch jump_label at %pS", (void *)jump_entry_code(entry));
> 		return false;
> 	}

It is taking 95 characters. In this case, wouldn't be better to break?

        if (!kernel_text_address(jump_entry_code(entry))) {
                WARN_ONCE(1, "can't patch jump_label at %pS",
                          (void *)jump_entry_code(entry));
                return false;
        }

I agree your suggestion is better... just confirming that 95 is not too long...

> 
>> +		if (jump_label_can_update(entry, init)) {
>> +			arch_jump_label_transform(entry, jump_label_type(entry));
> 
> Yap.
> 
> Thx.
> 

Thanks!

-- Daniel
