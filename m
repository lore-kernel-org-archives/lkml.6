Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAC7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD406240F8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD406240F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbeGCBil convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:38:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753215AbeGCBij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:38:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37FF0406E81E;
        Tue,  3 Jul 2018 01:38:39 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-30.sin2.redhat.com [10.67.116.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8B792156889;
        Tue,  3 Jul 2018 01:38:33 +0000 (UTC)
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
To:     Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
 <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
 <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
 <1530570880.3179.9.camel@HansenPartnership.com>
 <20180702161925.1c717283dd2bd4a221bc987c@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6e86c673-af14-2111-ea30-dc6cac655414@redhat.com>
Date:   Tue, 3 Jul 2018 09:38:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180702161925.1c717283dd2bd4a221bc987c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 03 Jul 2018 01:38:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 03 Jul 2018 01:38:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 07:19 AM, Andrew Morton wrote:
> On Mon, 02 Jul 2018 15:34:40 -0700 James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>
>> On Mon, 2018-07-02 at 14:18 -0700, Andrew Morton wrote:
>>> On Mon, 2 Jul 2018 12:34:00 -0700 Linus Torvalds <torvalds@linux-foun
>>> dation.org> wrote:
>>>
>>>> On Sun, Jul 1, 2018 at 10:52 PM Waiman Long <longman@redhat.com>
>>>> wrote:
>>>>> A rogue application can potentially create a large number of
>>>>> negative
>>>>> dentries in the system consuming most of the memory available if
>>>>> it
>>>>> is not under the direct control of a memory controller that
>>>>> enforce
>>>>> kernel memory limit.
>>>> I certainly don't mind the patch series, but I would like it to be
>>>> accompanied with some actual example numbers, just to make it all a
>>>> bit more concrete.
>>>>
>>>> Maybe even performance numbers showing "look, I've filled the
>>>> dentry
>>>> lists with nasty negative dentries, now it's all slower because we
>>>> walk those less interesting entries".
>>>>
>>> (Please cc linux-mm@kvack.org on this work)
>>>
>>> Yup.  The description of the user-visible impact of current behavior
>>> is far too vague.
>>>
>>> In the [5/6] changelog it is mentioned that a large number of -ve
>>> dentries can lead to oom-killings.  This sounds bad - -ve dentries
>>> should be trivially reclaimable and we shouldn't be oom-killing in
>>> such a situation.
>> If you're old enough, it's déjà vu; Andrea went on a negative dentry
>> rampage about 15 years ago:
>>
>> https://lkml.org/lkml/2002/5/24/71
> That's kinda funny.
>
>> I think the summary of the thread is that it's not worth it because
>> dentries are a clean cache, so they're immediately shrinkable.
> Yes, "should be".  I could understand that the presence of huge
> nunmbers of -ve dentries could result in undesirable reclaim of
> pagecache, etc.  Triggering oom-killings is very bad, and presumably
> has the same cause.
>
> Before we go and add a large amount of code to do the shrinker's job
> for it, we should get a full understanding of what's going wrong.  Is
> it because the dentry_lru had a mixture of +ve and -ve dentries? 
> Should we have a separate LRU for -ve dentries?  Are we appropriately
> aging the various dentries?  etc.

I have actually investigated having a separate LRU for negative
dentries. That will result in a far more invasive patch that will be
more disruptive.

Another change that was suggested by a colleague is to put a newly
created -ve dentry to the tail (LRU end) of the LRU and move it to the
head only if it is accessed a second time. That will put most of the
negative dentries at the tail that will be more easily trimmed away.

Cheers,
Longman


