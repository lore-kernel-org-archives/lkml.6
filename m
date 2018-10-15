Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8692AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA94208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ZGY9umb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA94208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeJPC0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:26:08 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:52186 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeJPC0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=746; q=dns/txt; s=iport;
  t=1539628780; x=1540838380;
  h=subject:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=QwMaFRmp4FoAGJvsqbXJX/x9khc5sTCL54rY9D1eWyE=;
  b=ZGY9umb0A/b1C73IAPoPF1tZmaTR6Ki+Ycfq4jXKwF/HeDKOpwWuL0OR
   /xpm/HZ9GFs4NIkWf46GCOywZYa8bcIbs3reoHTNXMyIVGaLnwu04+3PU
   JFPfylc0DHzDCxlEeFH484s3G8cQ6fb74NDTlAL7iI3cHe0cYiC4n4MMr
   k=;
X-IronPort-AV: E=Sophos;i="5.54,385,1534809600"; 
   d="scan'208";a="185845618"
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 18:39:39 +0000
Received: from [10.154.208.167] ([10.154.208.167])
        by alln-core-12.cisco.com (8.15.2/8.15.2) with ESMTP id w9FIdXst019863;
        Mon, 15 Oct 2018 18:39:33 GMT
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Cc:     christian@brauner.io, Thomas Gleixner <tglx@linutronix.de>,
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
 <20181013104446.b3z26rwmiripqfks@gmail.com>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <5bbe7c70-d6a8-7b37-51d4-eed9a99bc7e1@cisco.com>
Date:   Mon, 15 Oct 2018 11:39:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181013104446.b3z26rwmiripqfks@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.167, [10.154.208.167]
X-Outbound-Node: alln-core-12.cisco.com
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christian:

As I replied to Jann, I will remove the code that does the setting on others
to make the code simpler and more secure.

Thanks.  -- Enke

>> +static bool set_predump_signal_perm(struct task_struct *p)
>> +{
>> +	const struct cred *cred = current_cred(), *pcred = __task_cred(p);
>> +
>> +	return uid_eq(pcred->uid, cred->euid) ||
>> +	       uid_eq(pcred->euid, cred->euid) ||
>> +	       capable(CAP_SYS_ADMIN);
> 
> So before proceeding I'd like to discuss at least two points:
> - how does this interact with the dumpability of a process?
> - do we need the capable(CAP_SYS_ADMIN) restriction to init_user_ns?
>   Seems we could make this work per-user-ns just like
>   PRCTL_SET_PDEATHSIG does?
> 
>> +}

