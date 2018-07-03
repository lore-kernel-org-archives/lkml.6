Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0432C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6269E24F00
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6269E24F00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753792AbeGCA7f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:59:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753748AbeGCA7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:59:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04AB640255C9;
        Tue,  3 Jul 2018 00:59:32 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-30.sin2.redhat.com [10.67.116.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6279C2026D76;
        Tue,  3 Jul 2018 00:59:27 +0000 (UTC)
Subject: Re: [PATCH v5 2/6] fs/dcache: Make negative dentry tracking
 configurable
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
References: <1530510723-24814-1-git-send-email-longman@redhat.com>
 <1530510723-24814-3-git-send-email-longman@redhat.com>
 <20180702141206.8d08b4769a9c8a4300ce06de@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f4799a88-7c5e-fc23-f18b-a71d51d566f0@redhat.com>
Date:   Tue, 3 Jul 2018 08:59:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180702141206.8d08b4769a9c8a4300ce06de@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 03 Jul 2018 00:59:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 03 Jul 2018 00:59:32 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 05:12 AM, Andrew Morton wrote:
> On Mon,  2 Jul 2018 13:51:59 +0800 Waiman Long <longman@redhat.com> wrote:
>
>> The negative dentry tracking is made a configurable option so that
>> users who don't care about negative dentry tracking will have the
>> option to disable it. The new config option DCACHE_TRACK_NEG_ENTRY
>> is disabled by default.
>>
>> If this option is enabled, a new kernel parameter "neg_dentry_pc=<%>"
>> allows users to set the soft limit on how many negative dentries are
>> allowed as a percentage of the total system memory. The default is 2%
>> and this new parameter accept a range of 0-10% where 0% means there
>> is no limit.
>>
>> When the soft limit is reached, a warning message will be printed to
>> the console to alert the system administrator.
> It would be much more convenient if this was tunable at runtime via yet
> another /proc knob.  Is there any particular reason why we can't do this?
>
The percpu accounting of negative dentries cannot be dynamically turn on
and off or the count won't be accurate. Fortunately that part shouldn't
introduce any noticeable overhead. Everything else can be dynamically
turn on or off, if desired. I will look into making this patchset more
dynamic in the next version.

Cheers,
Longman


