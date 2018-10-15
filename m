Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43ADC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5054D20869
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="byGwsKfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5054D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeJPFYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:24:11 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:35624 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeJPFYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1166; q=dns/txt; s=iport;
  t=1539639428; x=1540849028;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yYprDjdedaZWsXdo4vmP4D1jqM77QeIZ0LgnnTH1BR0=;
  b=byGwsKfGsnOdZLo8Cx4pB0fG7eWXDjE7J+KwPD9TKvcFBeIxuxiV3TJX
   Rm7oJg08OURCdgkhvCZibk/h4U5gnsMGD5imZJ6J9u8WZGNc7PAfT3kV/
   jCPCW5CNwcMpx44GwnQWnsXeuwfQEAUAOiNQ0014Ps2qQhtnwNRPuDTey
   M=;
X-IronPort-AV: E=Sophos;i="5.54,385,1534809600"; 
   d="scan'208";a="464813567"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 21:37:08 +0000
Received: from [10.154.208.167] ([10.154.208.167])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTP id w9FLVvGL032210;
        Mon, 15 Oct 2018 21:31:59 GMT
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>,
        Enke Chen <enkechen@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <20181015222144.27fdafc3@alans-desktop>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <3e3728f7-1370-586c-c5ac-4ba0604976a5@cisco.com>
Date:   Mon, 15 Oct 2018 14:31:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015222144.27fdafc3@alans-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.167, [10.154.208.167]
X-Outbound-Node: alln-core-7.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alan:

As I replied earlier, I will remove the logic that allows setting on others.
This function "set_predump_signal_perm()" will be gone too.

Thanks.  -- Enke

On 10/15/18 2:21 PM, Alan Cox wrote:
>> +/*
>> + * Returns true if current's euid is same as p's uid or euid,
>> + * or has CAP_SYS_ADMIN.
>> + *
>> + * Called with rcu_read_lock, creds are safe.
>> + *
>> + * Adapted from set_one_prio_perm().
>> + */
>> +static bool set_predump_signal_perm(struct task_struct *p)
>> +{
>> +	const struct cred *cred = current_cred(), *pcred = __task_cred(p);
>> +
>> +	return uid_eq(pcred->uid, cred->euid) ||
>> +	       uid_eq(pcred->euid, cred->euid) ||
>> +	       capable(CAP_SYS_ADMIN);
>> +}
> 
> This makes absolutely no security sense whatsoever. The uid and euid of
> the parent and child can both change between the test and the signal
> delivery.
> 
> There are reasons that the child signal control code is incredibly
> careful about either the parent or child using execve or doing a
> privilege change that might pose a risk.
> 
> Until this code gets the same protections I don't believe it's safe.
> 
> Alan
> 
