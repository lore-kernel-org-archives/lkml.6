Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35F2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C40321479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C40321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJROQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:16:09 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24827 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727361AbeJROQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:16:09 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46308636"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Oct 2018 14:16:30 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id BDFBB4B69E01;
        Thu, 18 Oct 2018 14:16:25 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 18 Oct 2018 14:16:32 +0800
Date:   Thu, 18 Oct 2018 14:15:47 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v9 1/8] x86/boot: Introduce cmdline_find_option_arg()to
 detect if option=arg in cmdline
Message-ID: <20181018061547.GK12871@localhost.localdomain>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181017102012.872-2-fanc.fnst@cn.fujitsu.com>
 <20181018040120.GB1885@192.168.1.4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181018040120.GB1885@192.168.1.4>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: BDFBB4B69E01.A088B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:01:20PM +0800, Baoquan He wrote:
>On 10/17/18 at 06:20pm, Chao Fan wrote:
>> +bool cmdline_find_option_arg(const char *option, const char *arg, int argsize)
>> +{
>> +	char *buffer = malloc(argsize+1);
>> +	bool find = false;
>> +	int ret;
>> +
>> +	ret = cmdline_find_option(option, buffer, argsize+1);
>> +	if (ret == argsize && !strncmp(buffer, arg, argsize))
>> +		find = true;
>
>Wondering if we really need a wrapper like this. 

Well, my opinion is there are many code in kaslr.c can replaced by
cmdline_find_option_bool() and cmdline_find_option() and this new
cmdline_find_option_arg().
If this function introduced, we can clean up more code.

Thanks,
Chao Fan

>
>> +
>> +	free(buffer);
>> +	return find;
>> +}
>>  
>>  #endif
>> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
>> index a1d5918765f3..008fdc47a29c 100644
>> --- a/arch/x86/boot/compressed/misc.h
>> +++ b/arch/x86/boot/compressed/misc.h
>> @@ -67,6 +67,7 @@ static inline void debug_puthex(const char *s)
>>  /* cmdline.c */
>>  int cmdline_find_option(const char *option, char *buffer, int bufsize);
>>  int cmdline_find_option_bool(const char *option);
>> +bool cmdline_find_option_arg(const char *option, const char *arg, int argsize);
>>  #endif
>>  
>>  
>> -- 
>> 2.17.2
>> 
>> 
>> 
>
>


