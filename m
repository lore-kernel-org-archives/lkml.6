Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94839C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECDB2082B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="h/olmIEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECDB2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeJaJVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:21:34 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:8750 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbeJaJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=691; q=dns/txt; s=iport;
  t=1540945551; x=1542155151;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=LZUqOI0aqGVTCiLV36okuf1IPwe9QJF4KI0GQ/AS4mM=;
  b=h/olmIEzGkfkmxD38VfNE7irRTI1Nwk+Mu34RHOhVMBnAceBpvluLO11
   eIDO2Y0ourlcvdI0sEBm9Radrvb/20yz7MYZlJoXL7RHNCWcnzrt+nk/Q
   8Ztay8dC/96boR+lVHVcqKuFGJbxH75GpB2oZdIGuR47LjQgCORz5AX6o
   U=;
X-IronPort-AV: E=Sophos;i="5.54,446,1534809600"; 
   d="scan'208";a="194350737"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 00:25:50 +0000
Received: from [10.154.208.183] ([10.154.208.183])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTP id w9V0PmLW027665;
        Wed, 31 Oct 2018 00:25:48 GMT
Subject: Re: [PATCH v5] kernel/signal: Signal-based pre-coredump notification
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <b50b14cd-e1a9-ff7d-12e0-c3613e125be9@cisco.com>
Date:   Tue, 30 Oct 2018 17:25:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030164628.GD7643@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.183, [10.154.208.183]
X-Outbound-Node: rcdn-core-7.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Oleg:

On 10/30/18 9:46 AM, Oleg Nesterov wrote:
> On 10/29, Enke Chen wrote:
>>
>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> Hmm. I didn't say this ;)
> 
> But OK, feel free to keep this tag.

Thanks.

> 
> I do not like this feauture. But I see no technical problems in this version
> and I never pretented I understand the user-space needs, so I won't argue.

As I explained earlier, the primary application is in the area of network
high-availability / non-stop-forwarding where early fault notification and
early action can help maintain BFD sessions and thus avoid unnecessary
disruption to forwarding while the control-plane is recovering.

-- Enke

