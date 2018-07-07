Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7288EC3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2413A22430
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2413A22430
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932766AbeGGDC2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:02:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932463AbeGGDC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:02:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 788DE401EF27;
        Sat,  7 Jul 2018 03:02:25 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-141.rdu2.redhat.com [10.10.120.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E51A7215688A;
        Sat,  7 Jul 2018 03:02:23 +0000 (UTC)
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
 <20180706222814.GE30522@ZenIV.linux.org.uk>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <56b1d7ee-d362-f915-34fb-92173d512cbe@redhat.com>
Date:   Fri, 6 Jul 2018 23:02:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180706222814.GE30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sat, 07 Jul 2018 03:02:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sat, 07 Jul 2018 03:02:25 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 06:28 PM, Al Viro wrote:
> On Fri, Jul 06, 2018 at 03:32:45PM -0400, Waiman Long wrote:
>
>> With a 4.18 based kernel, the positive & negative dentries lookup rates
>> (lookups per second) after initial boot on a 2-socket 24-core 48-thread
>> 64GB memory system with and without the patch were as follows: `
>>
>>   Metric                    w/o patch  neg_dentry_pc=0  neg_dentry_pc=1
>>   ------                    ---------  ---------------  ---------------
>>   Positive dentry lookup      584299       586749	   582670
>>   Negative dentry lookup     1422204      1439994	  1438440
>>   Negative dentry creation    643535       652194	   641841
>>
>> For the lookup rate, there isn't any signifcant difference with or
>> without the patch or with a zero or non-zero value of neg_dentry_pc.
> Sigh...  What I *still* don't see (after all the iterations of the patchset)
> is any performance data on workloads that would be likely to feel the impact.
> Anything that seriously hits INCLUDE_PATH, for starters...

I wrote a simple microbenchmark that does a lot of open() system calls
to create positive or negative dentries. I was not seeing any noticeable
performance difference as long as not too many negative dentries were
created.

Please enlighten me on how kind of performance benchmark that you would
like me to run.

Thanks,
Longman

