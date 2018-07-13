Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970C5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5350F208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5350F208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbeGMPrf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:47:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729762AbeGMPrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:47:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACC3E81663EE;
        Fri, 13 Jul 2018 15:32:27 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 875D110F1BE0;
        Fri, 13 Jul 2018 15:32:26 +0000 (UTC)
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
 <20180709081920.GD22049@dhcp22.suse.cz>
 <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
 <20180710142740.GQ14284@dhcp22.suse.cz>
 <a2794bcc-9193-cbca-3a54-47420a2ab52c@redhat.com>
 <20180711102139.GG20050@dhcp22.suse.cz>
 <9f24c043-1fca-ee86-d609-873a7a8f7a64@redhat.com>
 <1531330947.3260.13.camel@HansenPartnership.com>
 <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
 <1531336913.3260.18.camel@HansenPartnership.com>
 <4d49a270-23c9-529f-f544-65508b6b53cc@redhat.com>
 <1531411494.18255.6.camel@HansenPartnership.com>
 <30ac8e9b-a48c-9c37-5a96-731ad214262b@redhat.com>
 <1531416833.18255.10.camel@HansenPartnership.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <919c5749-4528-ad30-28dd-a3ebb2c42021@redhat.com>
Date:   Fri, 13 Jul 2018 11:32:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1531416833.18255.10.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 13 Jul 2018 15:32:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 13 Jul 2018 15:32:27 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 01:33 PM, James Bottomley wrote:
> On Thu, 2018-07-12 at 12:26 -0400, Waiman Long wrote:
>> On 07/12/2018 12:04 PM, James Bottomley wrote:
>>> On Thu, 2018-07-12 at 11:54 -0400, Waiman Long wrote:
>>>> It is not that dentry cache is harder to get rid of than the
>>>> other memory. It is that the ability of generate unlimited number
>>>> of negative dentries that will displace other useful memory from
>>>> the system. What the patch is trying to do is to have a warning
>>>> or notification system in place to spot unusual activities in
>>>> regard to the number of negative dentries in the system. The
>>>> system administrators can then decide on what to do next.
>>> But every cache has this property: I can cause the same effect by
>>> doing a streaming read on a multi gigabyte file: the page cache
>>> will fill with the clean pages belonging to the file until I run
>>> out of memory and it has to start evicting older cache
>>> entries.  Once we hit the steady state of minimal free memory, the
>>> mm subsytem tries to balance the cache requests (like my streaming
>>> read) against the existing pool of cached objects.
>>>
>>> The question I'm trying to get an answer to is why does the dentry
>>> cache need special limits when the mm handling of the page cache
>>> (and other mm caches) just works?
>>>
>>> James
>>>
>> I/O activities can be easily tracked.
> Tracked?  What do you mean tracked?  you mean we can control the page
> cache through userfaultfd or something without resorting to cgroup
> limits or something different?  I mean all caches are "tracked" because
> otherwise we wouldn't know whether we have to retrieve/generate the
> object or pull it from the cache.  If it's just about cache state,
> what's wrong with /proc/sys/fs/dentry-state?

Sorry for being imprecise. What I meant is it is easy to find out which
tasks issue the most I/O request and consume the most I/O bandwidth.
IOW, which one we can blame if there are too much I/O activities. On the
other hand, it is not that easy to find out which task generates the
most negative dentries.

>>  Generation of negative dentries, however, is more insidious. So the
>> ability to track and be notified when too many negative dentries are
>> created can be a useful tool for the system administrators. Besides,
>> there are paranoid users out there who want to have control of as
>> much as system parameters as possible.
> To what end?  what problem are these administrators trying to solve? 
> You keep coming back to the circular argument that the problem they're
> trying to solve is limiting negative dentries, but I want to know what
> issue they see in their systems that causes them to ask for this knob.
>
> James
>
I would say most system administrators don't want to have surprise. They
don't want to see bad performance or other system problems and after
some digging find out that some tasks are generating too much negative
dentries and thus consuming too much memory, for example. They would
certainly like to a way to notify them before the problems happen.

Cheers,
Longman


