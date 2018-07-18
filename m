Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC23ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A2D206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A2D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbeGRQjk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:39:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbeGRQjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:39:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A3FB879C4;
        Wed, 18 Jul 2018 16:01:05 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF2251C581;
        Wed, 18 Jul 2018 16:01:03 +0000 (UTC)
Subject: Re: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
 <CA+55aFyH6dHw-7R3364dn32J4p7kxT=TqmnuozCn9_Bz-MHhxQ@mail.gmail.com>
 <20180702141811.ef027fd7d8087b7fb2ba0cce@linux-foundation.org>
 <1530570880.3179.9.camel@HansenPartnership.com>
 <20180702161925.1c717283dd2bd4a221bc987c@linux-foundation.org>
 <20180703091821.oiywpdxd6rhtxl4p@quack2.suse.cz>
 <20180714173516.uumlhs4wgfgrlc32@devuan>
 <CA+55aFw1vrsTjJyoq4Q3jBwv1nXaTkkmSbHO6vozWZuTc7_6Kg@mail.gmail.com>
 <20180714183445.GJ30522@ZenIV.linux.org.uk>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <990ac8fd-69a6-7d6b-6608-cda012ac22a4@redhat.com>
Date:   Wed, 18 Jul 2018 12:01:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180714183445.GJ30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 18 Jul 2018 16:01:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 18 Jul 2018 16:01:05 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/14/2018 02:34 PM, Al Viro wrote:
> On Sat, Jul 14, 2018 at 11:00:32AM -0700, Linus Torvalds wrote:
>> On Sat, Jul 14, 2018 at 10:35 AM Pavel Machek <pavel@ucw.cz> wrote:
>>> Could we allocate -ve entries from separate slab?
>> No, because negative dentrires don't stay negative.
>>
>> Every single positive dentry starts out as a negative dentry that is
>> passed in to "lookup()" to maybe be made positive.
>>
>> And most of the time they <i>do</i> turn positive, because most of the
>> time people actually open files that exist.
>>
>> But then occasionally you don't, because you're just blindly opening a
>> filename whether it exists or not (to _check_ whether it's there).
> BTW, one point that might not be realized by everyone: negative dentries
> are *not* the hard case.
> mount -t tmpfs none /mnt
> touch /mnt/a
> for i in `seq 100000`; do ln /mnt/a /mnt/$i; done
>
> and you've got 100000 *unevictable* dentries, with the time per iteration
> being not all that high (especially if you just call link(2) in a loop).
> They are all positive and all pinned.  And you've got only one inode
> there and no persistently opened files, so rlimit and quota won't help
> any.

Normally you need to be root or have privileges to mount a filesystem.
Right?

I am aware there is effort going on to allow non-privilege user mount in
container. That can open a can of worms if it is not done properly.

With privileges, there is a lot of ways one can screw up the system. So
I am not less concern about this particular issue.

Cheers,
Longman


