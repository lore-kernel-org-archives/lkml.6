Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BB8C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3A1218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfBFP7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:59:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35917 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbfBFP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:59:49 -0500
Received: by mail-qt1-f196.google.com with SMTP id r9so8408551qtt.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r542Qz/TN1gfqmSDERvIA4SMo3MFOyfbz3mZZcNAjHY=;
        b=K10zAK1APFcAH1sBOMjQDrE9l7JICQLQEyKUf9X9Uj6U1Me/aq7s9uLrNZ0Zj/RJ74
         K4P6RxdhVthML+GXg7sKehNCmwX2tnEcaFH/K656xTyIp+PH64jqdbH0GsWizblRuKiY
         hSqoa4g2nkwGVhVh/Rs84zQHTd6IzmkJTSBEK988Erys1Wf3XORWq0DMvlYVIYS30pbz
         U7+QcUtH2OCalQuNNVj+WlH0MK3pAybp2XT9t5o6VfDIfw0Zk/Em6C1PxpEy8VMM56fK
         IO/0CoMGjkHnVqxJrNMq2dr9rcGBqTiQaYRGvQt09a1P95836pCstFO4OrV5yRqJ8q0+
         4teg==
X-Gm-Message-State: AHQUAuY02UvawUeKeH+cn/Pg2L+yiC4UTlx32nG6XVog+HwBVB4Z7mi0
        AZhYGwHJyd7UVKwxWihxumlQ8g==
X-Google-Smtp-Source: AHgI3IYUVG9DSI2SApBuiV42WL6ZIRLWb8LzyDmL03Q7GbMmYtiEtWh6Mxjxc/Nl6OjRIiNvPmozRQ==
X-Received: by 2002:a0c:f805:: with SMTP id r5mr8460407qvn.130.1549468788376;
        Wed, 06 Feb 2019 07:59:48 -0800 (PST)
Received: from t460s.bristot.redhat.com ([177.72.25.22])
        by smtp.gmail.com with ESMTPSA id c48sm21012020qtd.9.2019.02.06.07.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 07:59:47 -0800 (PST)
Subject: Re: [PATCH V4 8/9] jump_label: Batch updates if arch supports it
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <cover.1549308412.git.bristot@redhat.com>
 <a36bfdbc63c5848adfaa1a466a90b62391fd2289.1549308412.git.bristot@redhat.com>
 <20190206153418.722cc7f4a83d0e48c8dca552@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <df5a556f-332d-b014-b5ea-44968860acf5@redhat.com>
Date:   Wed, 6 Feb 2019 16:59:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206153418.722cc7f4a83d0e48c8dca552@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/19 7:34 AM, Masami Hiramatsu wrote:
> On Mon,  4 Feb 2019 20:59:01 +0100
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> --- a/kernel/jump_label.c
>> +++ b/kernel/jump_label.c
>> @@ -407,6 +407,7 @@ bool jump_label_can_update_check(struct jump_entry *entry, bool init)
>>  	return 0;
>>  }
>>  
>> +#ifndef HAVE_JUMP_LABEL_BATCH
>>  static void __jump_label_update(struct static_key *key,
>>  				struct jump_entry *entry,
>>  				struct jump_entry *stop,
>> @@ -419,6 +420,34 @@ static void __jump_label_update(struct static_key *key,
>>  		}
>>  	}
>>  }
>> +#else
>> +static void __jump_label_update(struct static_key *key,
>> +				struct jump_entry *entry,
>> +				struct jump_entry *stop,
>> +				bool init)
>> +{
>> +	for_each_label_entry(key, entry, stop) {
>> +
>> +		if (!jump_label_can_update_check(entry, init))
>> +			continue;
>> +
>> +		if (arch_jump_label_transform_queue(entry,
>> +						    jump_label_type(entry)))
>> +			continue;
>> +
>> +		/*
>> +		 * Queue's overflow: Apply the current queue, and then
>> +		 * queue again. If it stills not possible to queue, BUG!
>> +		 */
>> +		arch_jump_label_transform_apply();
>> +		if (!arch_jump_label_transform_queue(entry,
>> +						     jump_label_type(entry))) {
>> +			BUG();
> 
> Please do not relay on BUG(), since in both case (applied or not),
> jump_label is not critical for normal operation. I think you should use
> WARN_ONCE() here and lock the jump_label so that root user can report it
> to us :)

Oops! I wrote a patch changing this, removing the BUG(). It was a request from
steve, but somehow I ended up missing it.

Thanks for reviewing this...

My bad, sorry :-(

-- Daniel
> Thank you,
> 
> 

