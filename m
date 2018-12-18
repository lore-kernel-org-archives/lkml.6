Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515AFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2AE218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeLRT1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:27:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54616 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeLRT1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:27:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so3798828wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 11:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EbcKsKRYODG9JdY4SeogDzc/+WW5I3uKhv14yEm3ahw=;
        b=rtP7Aa7T+KEysEeQ4OZOC6TI2ReIQs7bVL7RREmo8PaxaSnlYrtj5APihdzK6mGpAX
         NBwEAKOQHVt5M/YnyMq22RMTGG2GAh8p/YCBsrnf8pwXZOnXNVaBS00j8TJctAqjRwpl
         Dz7P+CuHq1jhIIKDeaT80u/lemlcjipfP4HnXaAI2yWia/JocDfwccBEiJ3oi2RZrINa
         B75hHeSgpZM0KNNvDfYBRmZXSeiPjy30SR24r5lKDS8Rf7eq1velyHDaVK9/hz2IYzlN
         V7bTceHGnEED4p95B43vPZ0Zv99iKOeScQwZbu94zcUfucIztj6mpCU9ZSQXjDR57hWV
         jCOA==
X-Gm-Message-State: AA+aEWb7pnuGtRCuN9/FrSmiZXHvZoe1gLPAmbXxgEb6GC/3VYmNI4bG
        4xxlEneuB8koV7MYBdkkRQoK1g==
X-Google-Smtp-Source: AFSGD/VUfuzu64pBeOixd7ajAFyt+HBfdnSKWjX2R87yIvvZ2Q/HiQaxDTzdynvYwjmd6aVx4s7SEA==
X-Received: by 2002:a1c:760c:: with SMTP id r12mr3711165wmc.127.1545161249612;
        Tue, 18 Dec 2018 11:27:29 -0800 (PST)
Received: from t460s.bristot.redhat.com (host252-226-dynamic.249-95-r.retail.telecomitalia.it. [95.249.226.252])
        by smtp.gmail.com with ESMTPSA id 202sm3804557wmt.8.2018.12.18.11.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 11:27:28 -0800 (PST)
Subject: Re: [PATCH V2 7/9] x86/alternative: Batch of patch operations
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
 <327a30e43e27ed3a0300952126bf36fae6652b74.1545149539.git.bristot@redhat.com>
 <20181218123134.2bdcc042@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <e32c4c71-b88a-833a-9c6d-468bf0d8b512@redhat.com>
Date:   Tue, 18 Dec 2018 20:27:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181218123134.2bdcc042@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 6:31 PM, Steven Rostedt wrote:
> On Tue, 18 Dec 2018 17:46:36 +0100
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> +void text_poke_bp_batch(struct text_to_poke *tp, unsigned int nr_entries)
>> +{
>> +	unsigned int i;
>> +	unsigned char int3 = 0xcc;
>> +	int patched_all_but_first = 0;
>> +
>> +	bp_int3_tpv = tp;
>> +	bp_int3_tpv_nr = nr_entries;
>> +	bp_patching_in_progress = true;
>> +	/*
>> +	 * Corresponding read barrier in int3 notifier for making sure the
>> +	 * in_progress and handler are correctly ordered wrt. patching.
>> +	 */
>> +	smp_wmb();
>> +
>> +	for (i = 0; i < nr_entries; i++)
>> +		text_poke_bp_set_handler(tp[i].addr, tp[i].handler, int3);
>> +
>> +	on_each_cpu(do_sync_core, NULL, 1);
>> +
>> +	for (i = 0; i < nr_entries; i++) {
>> +		if (tp->len - sizeof(int3) > 0) {
> Should this be:
> 
> 		if (tp[i].len - sizeof(int3) > 0) {
> 
> ?

Ops! Missed that... you are right.

Fixing in the v3.

Thanks!

-- Daniel
