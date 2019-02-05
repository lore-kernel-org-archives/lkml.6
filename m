Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2838AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E122175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfBENvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:51:02 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44944 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBENvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:51:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so3778355qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 05:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XhJNnnxUE+OIUMyycxzNXdt3pQUWurm7GNeOcP7X05I=;
        b=Mropn/Ne7qdHfBpmRi+2UU7N7DiSSRGIPXaTi4HYg66ezJGbdqjh16QNCPox99EElN
         G62QB9oqLScvaOV9BTTzCH6NWK4cL2aYwpHSXyPNWoJIsoHgYRH00y5Opr0bdfoRUDDG
         11RlfraDgzkTIzDA4APzBMv1EaS7pz5LIUpmo+RGG4Yuh4a6oMY8Qe06KeDbPT7I6flu
         +ouJf0+SS74K8LMZOsMJJOFCYxwbxISJ5j08348MfXVXrrShd92MaBdHkxi+b8ZqZY0c
         n4na7kW8hJchad2AAtSGBakaF/5xG6Jnn1SGATejadtWmK89MlpN0WvKlYOY03RSRyRR
         AsrA==
X-Gm-Message-State: AHQUAuY8bims0QQrcdn1McoaAc5fk4hvu2cBzTopXBZJoiEQAFCBZwcZ
        IiSPFDOlFZ+XjDOa4h2ZQTvvrg==
X-Google-Smtp-Source: AHgI3IY6M5E1pqNBZRC6zidIndD5zqteLoiQiseSEqjvcIEmjMCvtoPRKZ8t4ul/lkO1vmw+FqLWew==
X-Received: by 2002:ac8:4284:: with SMTP id o4mr3576816qtl.389.1549374660855;
        Tue, 05 Feb 2019 05:51:00 -0800 (PST)
Received: from t460s.bristot.redhat.com ([177.72.25.22])
        by smtp.gmail.com with ESMTPSA id r1sm17296894qte.28.2019.02.05.05.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 05:50:59 -0800 (PST)
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
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <cb65e500-44dd-873c-622f-b49b9336b6a2@redhat.com>
Date:   Tue, 5 Feb 2019 14:50:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205072220.GD21801@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav!

On 2/5/19 8:22 AM, Borislav Petkov wrote:
>> Subject: Re: [PATCH V4 2/9] jump_label: Add the jump_label_can_update_check() helper
> 
> s/the/a/

ack!

> On Mon, Feb 04, 2019 at 08:58:55PM +0100, Daniel Bristot de Oliveira wrote:
>> Move the check of if a jump_entry is valid to a function.
> 
> s/of //

ack!

>> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
>> index 288d630da22d..456c0d7cbb5b 100644
>> --- a/kernel/jump_label.c
>> +++ b/kernel/jump_label.c
>> @@ -374,22 +374,32 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
>>  	return enabled ^ branch;
>>  }
>>  
>> +bool jump_label_can_update_check(struct jump_entry *entry, bool init)
> 
> static.
> 
> Also, "jump_label_can_update" is sufficient for a name AFAICT.

sounds better indeed.

>> +{
>> +	/*
>> +	 * An entry->code of 0 indicates an entry which has been
>> +	 * disabled because it was in an init text area.
>> +	 */
>> +	if (init || !jump_entry_is_init(entry)) {
>> +		if (!kernel_text_address(jump_entry_code(entry))) {
>> +			WARN_ONCE(1, "can't patch jump_label at %pS",
>> +				  (void *)jump_entry_code(entry));
>> +			return 0;
>> +		}
>> +		return 1;
>> +	}
>> +	return 0;
> 
> Those should be bools which it returns, no?
> 
> Also, I'd do the function this way, to make it more readable and not
> have three returns back-to-back. :)
> 
> /*
>  * An entry->code of 0 indicates an entry which has been disabled because it
>  * was in an init text area.
>  */
> bool jump_label_can_update(struct jump_entry *entry, bool init)
> {
>         if (!init && jump_entry_is_init(entry))
>                 return false;
> 
>         if (WARN_ON_ONCE(!kernel_text_address(jump_entry_code(entry))),
>                          "can't patch jump_label at %pS", (void *)jump_entry_code(entry))
>                 return false;
> 
>         return true;
> }
> 
> That second check could be even:
> 
>         if (WARN_ON_ONCE(!kernel_text_address(jump_entry_code(entry))),
>                          "can't patch jump_label at %pS", (void *)jump_entry_code(entry))
>                 return false;
> 
> but that's not more readable than above, I'd say.

Agreed!

> 
>>  static void __jump_label_update(struct static_key *key,
>>  				struct jump_entry *entry,
>>  				struct jump_entry *stop,
>>  				bool init)
>>  {
>>  	for_each_label_entry(key, entry, stop) {
>> -		/*
>> -		 * An entry->code of 0 indicates an entry which has been
>> -		 * disabled because it was in an init text area.
>> -		 */
>> -		if (init || !jump_entry_is_init(entry)) {
>> -			if (kernel_text_address(jump_entry_code(entry)))
>> -				arch_jump_label_transform(entry, jump_label_type(entry));
>> -			else
>> -				WARN_ONCE(1, "can't patch jump_label at %pS",
>> -					  (void *)jump_entry_code(entry));
>> +		if (jump_label_can_update_check(entry, init)) {
>> +			arch_jump_label_transform(entry,
>> +						  jump_label_type(entry));
> 
> Yeah, let that one stick out.

I did not get this part...

Thanks!

-- Daniel

