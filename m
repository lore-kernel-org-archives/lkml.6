Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2944AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD1120864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="gPC+nLQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD1120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404556AbeKVPfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:35:10 -0500
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:10109 "EHLO
        rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732146AbeKVPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2824; q=dns/txt; s=iport;
  t=1542862651; x=1544072251;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EogIDfV15YxKr2BXXdqnF6omuQ2/TzVu/7ZV0Brqjlw=;
  b=gPC+nLQ572ajJLQiE4yxkG50bjtAzQQbHyK6nNrwJ9aRqqOK9lb8O3Rw
   TLfP5HfZbuebO+C9P/moch4yO28E0uwebLpiQnaq94ptrv9rMnLwo502O
   AhL3looZY+ch996/ffcoHy0GqJQ2wnhu2pWb2+OdcwydRG5CNr6vIBpOh
   g=;
X-IronPort-AV: E=Sophos;i="5.56,264,1539648000"; 
   d="scan'208";a="476454414"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 04:57:31 +0000
Received: from [10.24.99.63] ([10.24.99.63])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id wAM4vSVd019125;
        Thu, 22 Nov 2018 04:57:28 GMT
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
 <20181121173341.707a0a869bf16b85f09d75b5@linux-foundation.org>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <08366d06-9f47-b80e-3662-a84c5107be89@cisco.com>
Date:   Wed, 21 Nov 2018 20:57:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181121173341.707a0a869bf16b85f09d75b5@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.99.63, [10.24.99.63]
X-Outbound-Node: rcdn-core-8.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew:

As suggested, I will post them as a patch series (with the same version v5):

    [PATCH v5 1/2] kernel/signal: Signal-based pre-coredump notification
    [PATCH v5 2/2] selftests/prctl: selftest for pre-coredump signal notification

I have a diff for the manpage as well. I guess that it should be submitted separately
from the code.

Thanks.  -- Enke

On 11/21/18 5:33 PM, Andrew Morton wrote:
> On Wed, 21 Nov 2018 17:09:50 -0800 Enke Chen <enkechen@cisco.com> wrote:
> 
>> Hi, Andrew:
>>
>> On 11/21/18 4:37 PM, Andrew Morton wrote:
>>> On Tue, 30 Oct 2018 17:46:29 +0100 Oleg Nesterov <oleg@redhat.com> wrote:
>>>
>>>> On 10/29, Enke Chen wrote:
>>>>>
>>>>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>>>>
>>>> Hmm. I didn't say this ;)
>>>>
>>>> But OK, feel free to keep this tag.
>>>>
>>>> I do not like this feauture.
>>>
>>> Why is that?
>>>
>>>> But I see no technical problems in this version
>>>> and I never pretented I understand the user-space needs, so I won't argue.
>>>
>>> The changelog appears to spell this all out quite well?  Unusually
>>> well, in my experience ;)
>>
>> I also followed up with a little more explanation in the email thread on
>> 10/30/2018:
>>
>> ---
>> As I explained earlier, the primary application is in the area of network
>> high-availability / non-stop-forwarding where early fault notification and
>> early action can help maintain BFD sessions and thus avoid unnecessary
>> disruption to forwarding while the control-plane is recovering.
>> ---
>>
>> BTW, I probably should have pointed out this earlier:
>>
>> BFD stands for "RFC 5880: Bi-directional forwarding detection".
> 
> I saw that.  My point is that your above followup wasn't necessary -
> the changelog is clear!
> 
>>>
>>> - As it's a linux-specific feature, a test under
>>>   tools/testing/selftests would be appropriate.  I don't know how much
>>>   that work will be. 
>>
>> The selftest code was submitted on 10/25/2018:
>>
>>    [PATCH] selftests/prctl: selftest for pre-coredump signal notification
> 
> OK, please prepare these as a patch series.
> 
>>> Do we have other linux-specific signal extensions which could piggyback onto that?
>>
>> No. There are enough existing signals that an application can choose for this
>> purpose, such as SIGUSR1, SIGUSR1, and any of the RT signals.
>>
> 
> My point is that if we have previously added any linux-specific signal
> expensions then your selftest patch would be an appropriate place where
> we could add tests for those features.  I'm not saying that you should
> add such tests at this time, but please do prepare the selftest as a
> thing which tests linux-specific signal extensions in general, not as a
> thing which tests pre-coredump signals only.
> 
