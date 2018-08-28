Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781DFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2068A2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2068A2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeH2Csh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:48:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727366AbeH2Csh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:48:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3446F40201C3;
        Tue, 28 Aug 2018 22:54:46 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-12.rdu2.redhat.com [10.10.123.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC50F2166B41;
        Tue, 28 Aug 2018 22:54:44 +0000 (UTC)
Subject: Re: [PATCH 0/2] fs/dcache: Track # of negative dentries
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
 <20180828155006.a6a94a7ba64ac4ce6b8b190c@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4284b67f-51bd-88d9-b7c4-8303179127b7@redhat.com>
Date:   Tue, 28 Aug 2018 18:54:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180828155006.a6a94a7ba64ac4ce6b8b190c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 28 Aug 2018 22:54:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 28 Aug 2018 22:54:46 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 06:50 PM, Andrew Morton wrote:
> On Tue, 28 Aug 2018 13:19:38 -0400 Waiman Long <longman@redhat.com> wrote:
>
>> This patchset is a reduced scope version of the
>> patchset "fs/dcache: Track & limit # of negative dentries"
>> (https://lkml.org/lkml/2018/7/12/586). Only the first 2 patches are
>> included to track the number of negative dentries in the system as well
>> as making negative dentries more easily reclaimed than positive ones.
>>
>> There are controversies on limiting number of negative dentries as it may
>> make negative dentries special in term of how memory resources are to
>> be managed in the kernel. However, I don't believe I heard any concern
>> about tracking the number of negative dentries in the system. So it is
>> better to separate that out and get it done with. We can deal with the
>> controversial part later on.
> Seems reasonable.
>
> It would be nice to see testing results please.  Quite comprehensive
> ones.
>
> And again, an apparently permanent feature of this patchset is that the
> changelogs fail to provide descriptions of real-world problems with the
> existing code.  Please do provide those (comprehensive) descriptions and
> demonstrate that these changes resolve those problems.
>
> Also, a grumpynit: with 100% uniformity, the vfs presently refers to
> negative dentries with the string "negative" in the identifier.  This
> patchset abbreviates that to "neg".
>
Will do.

Cheers,
Longman

