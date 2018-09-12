Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02484C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DAA20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DAA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeILVQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:16:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbeILVQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:16:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEA757263E;
        Wed, 12 Sep 2018 16:11:22 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0014C2026D76;
        Wed, 12 Sep 2018 16:11:21 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] fs/dcache: Eliminate branches in
 nr_dentry_negative accounting
To:     Matthew Wilcox <willy@infradead.org>
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
References: <1536693506-11949-1-git-send-email-longman@redhat.com>
 <1536693506-11949-5-git-send-email-longman@redhat.com>
 <20180912023610.GB20056@bombadil.infradead.org>
 <bf7592c3-dc1d-635e-8bb0-717f6e8a54d9@redhat.com>
 <20180912155557.GA18304@bombadil.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6247b212-923f-f8a1-3f97-c346b606a7b6@redhat.com>
Date:   Wed, 12 Sep 2018 12:11:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180912155557.GA18304@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 12 Sep 2018 16:11:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 12 Sep 2018 16:11:23 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 11:55 AM, Matthew Wilcox wrote:
> On Wed, Sep 12, 2018 at 11:49:22AM -0400, Waiman Long wrote:
>>> unless our macrology has got too clever for the compilre to see through
>>> it.  In which case, the right answer is to simplify the percpu code,
>>> not to force the compiler to optimise the code in the way that makes
>>> sense for your current microarchitecture.
>>>
>> I had actually looked at the x86 object file generated to verify that it
>> did use cmove with the patch and use branch without. It is possible that
>> there are other twists to make that happen with the above expression. I
>> will need to run some experiments to figure it out. In the mean time, I
>> am fine with dropping this patch as it is a micro-optimization that
>> doesn't change the behavior at all.
> I don't understand why you included it, to be honest.  But it did get
> me looking at the percpu code to see if it was too clever.  And that
> led to the resubmission of rth's patch from two years ago that I cc'd
> you on earlier.
>
> With that patch applied, gcc should be able to choose to use the
> cmov if it feels that would be a better optimisation.  It already
> makes one different decision in dcache.o, namely that it uses addq
> $0x1,%gs:0x0(%rip) instead of incq %gs:0x0(%rip).  Apparently this
> performs better on some CPUs.
>
> So I wouldn't spend any more time on this patch.

Thank for looking into that. Well I am not going to look further into
this unless I have no other thing to do which is unlikely.

Cheers,
Longman

