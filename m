Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE61C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 01:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7846C21890
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 01:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7846C21890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeHREV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 00:21:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeHREV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 00:21:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83A18B796;
        Sat, 18 Aug 2018 01:15:45 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-191.rdu2.redhat.com [10.10.120.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2B3510075E8;
        Sat, 18 Aug 2018 01:15:43 +0000 (UTC)
Subject: Re: [PATCH v8 3/5] ipc: Allow boot time extension of IPCMNI from 32k
 to 2M
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        manfred@colorfullife.com
References: <1529317698-16575-1-git-send-email-longman@redhat.com>
 <1529317698-16575-4-git-send-email-longman@redhat.com>
 <20180817164548.GA32382@linux-r8p5>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5ddb67bb-872b-c8c1-7838-2622195ae1fc@redhat.com>
Date:   Fri, 17 Aug 2018 21:15:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180817164548.GA32382@linux-r8p5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sat, 18 Aug 2018 01:15:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sat, 18 Aug 2018 01:15:45 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 12:45 PM, Davidlohr Bueso wrote:
> Cc'ing Manfred.
>
> On Mon, 18 Jun 2018, Waiman Long wrote:
>
>> The maximum number of unique System V IPC identifiers was limited to
>> 32k.  That limit should be big enough for most use cases.
>>
>> However, there are some users out there requesting for more. To satisfy
>> the need of those users, a new boot time kernel option "ipcmni_extend"
>> is added to extend the IPCMNI value to 2M. This is a 64X increase which
>> hopefully is big enough for them.
>
> Could you please provide more info on the need of these users and how
> you came up with this new value (which just seems quite arbitrary)?
>
> Thanks,
> Davidlohr 

Red Hat has a customer that is migrating from Solaris to Linux. Some of
their applications just happen to use more than 32k of shared memory
segments. I think Solaris allows up to 16M unique ID.

Yes, the amount of increase is a bit arbitrary. I was trying to balance
how many bits should be left for sequence number. Maybe I should just
take 8 more bits for ID and leave 8 bits for sequence number to match
Solaris.

-Longman
