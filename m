Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218FCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D729C2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D729C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbeHaTL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:11:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729029AbeHaTL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:11:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 080EA80C3C2D;
        Fri, 31 Aug 2018 15:03:33 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E49563F3B;
        Fri, 31 Aug 2018 15:03:32 +0000 (UTC)
Subject: Re: [PATCH 1/2] fs/dcache: Track & report number of negative dentries
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
 <1535476780-5773-2-git-send-email-longman@redhat.com>
 <20180829001153.GD1572@dastard>
 <20180831143100.GA6379@bombadil.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2b1fcabb-ff53-7906-c4d3-dfe19f8449e6@redhat.com>
Date:   Fri, 31 Aug 2018 11:03:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180831143100.GA6379@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 31 Aug 2018 15:03:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 31 Aug 2018 15:03:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 10:31 AM, Matthew Wilcox wrote:
> On Wed, Aug 29, 2018 at 10:11:53AM +1000, Dave Chinner wrote:
>>> +++ b/Documentation/sysctl/fs.txt
>>> @@ -63,19 +63,26 @@ struct {
>>>          int nr_unused;
>>>          int age_limit;         /* age in seconds */
>>>          int want_pages;        /* pages requested by system */
>>> -        int dummy[2];
>>> +        int nr_negative;       /* # of unused negative dentries */
>>> +        int dummy;
>>>  } dentry_stat = {0, 0, 45, 0,};
>> That's not a backwards compatible ABI change. Those dummy fields
>> used to represent some metric we no longer calculate, and there are
>> probably still monitoring apps out there that think they still have
>> the old meaning. i.e. they are still visible to userspace:
> I believe you are incorrect.  dentry_stat was introduced in 2.1.60 with
> this hunk:
>
> +struct {
> +       int nr_dentry;
> +       int nr_unused;
> +       int age_limit;          /* age in seconds */
> +       int want_pages;         /* pages requested by system */
> +       int dummy[2];
> +} dentry_stat = {0, 0, 45, 0,};
> +
>
> Looking through the rest of the dentry_stat changes in the 2.1.60 release,
> it's not replacing anything, it's adding new information.

Thanks for looking up earlier non-git source tree. If that is the case,
the dummy[2] was there just for future extension purpose. It should be
perfectly fine to reuse one of the dummy entry for negative dentry count
then as no sane application would have checked the last 2 entries of
dentry-state and do dummy things if they are non-zero.

Cheers,
Longman

