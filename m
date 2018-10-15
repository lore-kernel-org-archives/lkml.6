Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF7DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B48208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="QK3gjbxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B48208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeJPCfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:35:46 -0400
Received: from alln-iport-1.cisco.com ([173.37.142.88]:4250 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeJPCfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1145; q=dns/txt; s=iport;
  t=1539629357; x=1540838957;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XbgV8xjLdW7wMJ/qjo6To1z3qhlXgU2lNaHxmlKVLtA=;
  b=QK3gjbxXZz+18uOWnnZInYicHov4dHO5DbZe9N3SWg1Bbce1GOkqXRHl
   I/NBhYJ4mUCbqm5klEtTjO8dVU+v9m8P8oj3blDy058zNMqjekxERNQ8N
   nUoB9e/e9I7kXO4XWwNubalP54Z/lvBpLTFgbanYB7WdxG39zrcT/1xcx
   A=;
X-IronPort-AV: E=Sophos;i="5.54,385,1534809600"; 
   d="scan'208";a="186319960"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 18:49:16 +0000
Received: from [10.154.208.167] ([10.154.208.167])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id w9FInCod026848;
        Mon, 15 Oct 2018 18:49:12 GMT
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
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
 <20181013064023.GA28177@kroah.com>
 <37401cea-5a37-2cd9-8595-8b07dfc4de7d@cisco.com>
 <20181015184358.GA12153@kroah.com>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <614dad0f-97e3-91b4-0c29-c052d01922eb@cisco.com>
Date:   Mon, 15 Oct 2018 11:49:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015184358.GA12153@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.167, [10.154.208.167]
X-Outbound-Node: alln-core-2.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg:

On 10/15/18 11:43 AM, Greg Kroah-Hartman wrote:
> On Mon, Oct 15, 2018 at 11:16:36AM -0700, Enke Chen wrote:
>> Hi, Greg:
>>
>>> Shouldn't there also be a manpage update, and a kselftest added for this
>>> new user/kernel api that is being created?
>>>
>>
>> I will submit a patch for manpage update once the code is accepted.
> 
> Writing a manpage update is key to see if what you are describing
> actually matches the code you have submitted.  You should do both at the
> same time so that they can be reviewed together.

Ok, will do at the same time. But should I submit it as a separate patch?

> 
>> Regarding the kselftest, I am not sure.  Once the prctl() is limited to
>> self (which I will do), the logic would be pretty straightforward. Not
>> sure if the selftest would add much value.
> 
> If you do not have a test for this feature, how do you know it even
> works at all?  How will you know if it breaks in a future kernel
> release?  Have you tested this?  If so, how?

I have the test code. I am just not sure whether I should submit and check
it in to the kselftest?

Thanks.  -- Enke

