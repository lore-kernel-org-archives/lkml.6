Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEF7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4D72087B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4D72087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeH2FNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 01:13:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725723AbeH2FNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 01:13:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18AF940241C3;
        Wed, 29 Aug 2018 01:18:58 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-12.rdu2.redhat.com [10.10.123.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F35192166B41;
        Wed, 29 Aug 2018 01:18:56 +0000 (UTC)
Subject: Re: [PATCH 2/2] fs/dcache: Make negative dentries easier to be
 reclaimed
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
 <1535476780-5773-3-git-send-email-longman@redhat.com>
 <20180828221352.GC11400@bombadil.infradead.org>
 <6873378b-3202-e738-2366-5fb818b4a013@redhat.com>
 <CA+55aFxy1vH2CamZ_pdFohKgSJgi1i2MkeaY1qX8NdFK8Xu8Ww@mail.gmail.com>
 <20180828162207.52240d3442fbe65166f9d604@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a7c7150f-9e8e-62d3-6dac-0b86a2f69876@redhat.com>
Date:   Tue, 28 Aug 2018 21:18:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180828162207.52240d3442fbe65166f9d604@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 29 Aug 2018 01:18:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 29 Aug 2018 01:18:58 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 07:22 PM, Andrew Morton wrote:
> On Tue, 28 Aug 2018 16:10:24 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> On Tue, Aug 28, 2018 at 3:29 PM Waiman Long <longman@redhat.com> wrote:
>>> Yes, I can rewrite it. What is the problem with the abbreviated form?
>> Either gcc rewrites it for you, or you end up _actually_ using a
>> function pointer and calling through it.
>>
>> The latter would be absolutely horribly bad for something like
>> "list_add()", which should expand to just a couple of instructions.
>>
>> And the former would be ok, except for the "you wrote code the garbage
>> way, and then depended on the compiler fixing it up". Which we
>> generally try to avoid in the kernel.
>>
>> (Don't get me wrong - we definitely depend on the compiler doing a
>> good job at CSE and dead code elimination etc, but generally we try to
>> avoid the whole "compiler has to rewrite code to be good" model).
>>
> And the "abbreviated form" will surely explode if one or both of those
> "functions" happens to be implemented (or later reimplemented) as a macro.
> It's best not to unnecessarily make such assumptions.
>
Yes,  that is true.

Thanks,
Longman

