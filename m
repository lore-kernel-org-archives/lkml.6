Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78563C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B21120645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="TCXj16x3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B21120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403825AbeKVLzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:55:21 -0500
Received: from alln-iport-8.cisco.com ([173.37.142.95]:41773 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbeKVLzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=549; q=dns/txt; s=iport;
  t=1542849505; x=1544059105;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Tf1ypSEORuU6mfstZ7lfCRr4hjIOBNtLBdqepAXdlIs=;
  b=TCXj16x3avnFNmmmMDGJ66qkk5MWOYzBxyxWg47ivFRQClh6qY7wiR1I
   iRwDURglK+bwXvKcI+1mwVbZRKvNhN1vn/IRvxpfIDGCBjoc+YDLTWzMa
   PvRI4K7ukcMK5b8AwP5nLo4wU/nz7qBuK/8dyo52xQztsQLPvjnb8d+nZ
   0=;
X-IronPort-AV: E=Sophos;i="5.56,263,1539648000"; 
   d="scan'208";a="202270243"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 01:18:25 +0000
Received: from [10.24.99.63] ([10.24.99.63])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id wAM1IMC9027281;
        Thu, 22 Nov 2018 01:18:22 GMT
Subject: Re: [PATCH v5] kernel/signal: Signal-based pre-coredump notification
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>,
        Enke Chen <enkechen@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
 <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
 <20181026082812.GA10581@redhat.com>
 <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
 <20181029111804.GA24820@redhat.com>
 <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
 <20181030164628.GD7643@redhat.com>
 <20181121163711.2c00316784d221eb1750edb0@linux-foundation.org>
 <ae3b48ef-6bb0-2bc2-eca6-651fdb2dce37@cisco.com>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <44f0214e-93cf-ef19-f590-1a1a9e0f44b3@cisco.com>
Date:   Wed, 21 Nov 2018 17:18:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ae3b48ef-6bb0-2bc2-eca6-651fdb2dce37@cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.99.63, [10.24.99.63]
X-Outbound-Node: alln-core-11.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew:

On 11/21/18 5:09 PM, Enke Chen wrote:
> Hi, Andrew:
> 
> On 11/21/18 4:37 PM, Andrew Morton wrote:

>> Do we have other linux-specific signal extensions which could piggyback onto that?
> 
> No. There are enough existing signals that an application can choose for this
> purpose, such as SIGUSR1, SIGUSR1, and any of the RT signals.
> 
> Thanks.  -- Enke
> 

Let me clarify: I meant this feature is complete by itself. But you seem to ask a
somewhat different question, for which I am not aware of.

Thanks.  -- Enke

