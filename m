Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8720AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1422064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1422064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeJCA1q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:27:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbeJCA1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:27:46 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 155F78764F;
        Tue,  2 Oct 2018 17:43:15 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94FB59D80A;
        Tue,  2 Oct 2018 17:43:13 +0000 (UTC)
Subject: Re: [PATCH v8 3/5] ipc: Allow boot time extension of IPCMNI from 32k
 to 2M
To:     Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>
References: <1529317698-16575-1-git-send-email-longman@redhat.com>
 <1529317698-16575-4-git-send-email-longman@redhat.com>
 <20180817164548.GA32382@linux-r8p5>
 <5ddb67bb-872b-c8c1-7838-2622195ae1fc@redhat.com>
 <02ebafee-a295-58cf-044e-e2df0e878e0d@colorfullife.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8c9dda74-c9fb-cc18-5af4-c081dbb8b154@redhat.com>
Date:   Tue, 2 Oct 2018 13:43:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <02ebafee-a295-58cf-044e-e2df0e878e0d@colorfullife.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 02 Oct 2018 17:43:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 12:32 PM, Manfred Spraul wrote:
> Hello together,
>
> On 8/18/18 3:15 AM, Waiman Long wrote:
>> On 08/17/2018 12:45 PM, Davidlohr Bueso wrote:
>>> Cc'ing Manfred.
>>>
>>> On Mon, 18 Jun 2018, Waiman Long wrote:
>>>
>>>> The maximum number of unique System V IPC identifiers was limited to
>>>> 32k.  That limit should be big enough for most use cases.
>>>>
>>>> However, there are some users out there requesting for more. To
>>>> satisfy
>>>> the need of those users, a new boot time kernel option "ipcmni_extend"
>>>> is added to extend the IPCMNI value to 2M. This is a 64X increase
>>>> which
>>>> hopefully is big enough for them.
>>> Could you please provide more info on the need of these users and how
>>> you came up with this new value (which just seems quite arbitrary)?
>>>
>>> Thanks,
>>> Davidlohr
>> Red Hat has a customer that is migrating from Solaris to Linux. Some of
>> their applications just happen to use more than 32k of shared memory
>> segments. I think Solaris allows up to 16M unique ID.
>>
>> Yes, the amount of increase is a bit arbitrary. I was trying to balance
>> how many bits should be left for sequence number. Maybe I should just
>> take 8 more bits for ID and leave 8 bits for sequence number to match
>> Solaris.
>
> - I think we should use the same numbers as Solaris.
> Otherwise we later have to touch it again.

As said in my patch, it is a trade-off between # of uniq identifiers
versus the chance of id reuse. I don't have an objection to increase it
further, but I don't see the customers to really need such a large value.

>
> - What is the performance when using shmget() with already 10M
> segments present?

I am not sure the performance impact as I had not measure it myself. The
shmget() function is considered in slowpath. We are generally less
concern about its performance than other code paths that are in a
performance critical path.

>
> - I like the new logic for updating the sequence counter.
>
> Is there a reason why you only enable it for extended mode?

I tried not to disturb the existing logic for backward compatibility
concern. I don't mind switching it all over to use the new "deleted"
approach if other people have no objection.

Cheers,
Longman

> You create a rarely used codepath, and I don't understand what speaks
> against switching to the 'deleted' approach for all systems.
>
>
> -- 
>
>     Manfred
>


