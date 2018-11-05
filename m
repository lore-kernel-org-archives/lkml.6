Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60711C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346B520700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346B520700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbeKFDkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:40:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59650 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbeKFDkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:40:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 99FD8144A04B9;
        Mon,  5 Nov 2018 10:19:08 -0800 (PST)
Date:   Mon, 05 Nov 2018 10:19:08 -0800 (PST)
Message-Id: <20181105.101908.1114982106486155632.davem@davemloft.net>
To:     acme@kernel.org
Cc:     adrian.hunter@intel.com, jolsa@redhat.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        mathieu.poirier@linaro.org
Subject: Re: [PATCH 1/5] perf tools: Add fallback functions for cases where
 cpumode is insufficient
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181105172946.GH11147@kernel.org>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
        <20181031091043.23465-2-adrian.hunter@intel.com>
        <20181105172946.GH11147@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Nov 2018 10:19:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date: Mon, 5 Nov 2018 14:29:46 -0300

>> @@ -2542,6 +2542,46 @@ int machine__get_kernel_start(struct machine *machine)
>>  	return err;
>>  }
>>  
>> +/*
>> + * machine__single_ku_as - Machine has same address space for kernel and user.
>> + * @machine: machine object
>> + *
>> + * Some architectures have a single address space for kernel and user addresses,
>> + * which makes it possible to determine if an address is in kernel space or user
>> + * space.
>> + */
>> +static bool machine__single_ku_as(struct machine *machine)
>> +{
>> +	return strcmp(perf_env__arch(machine->env), "sparc");
>> +}
> 
> Can we avoid having this strcmp be done repeatedly? I.e. just make this
> a boolean initialized at session start, when machine->env is setup, so
> we'd have:
> 
>    machine->single_address_space
> 
> Instead of a function?

Agreed, doing this every time is wasteful.

We could also make it a define in some arch/foo file.
