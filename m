Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90863C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABCD20672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABCD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeLFOgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:36:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbeLFOgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:36:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 313D7300250A;
        Thu,  6 Dec 2018 14:36:17 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45E5F2E053;
        Thu,  6 Dec 2018 14:36:07 +0000 (UTC)
Subject: Re: [PATCH v14 05/11] livepatch: Simplify API by removing
 registration step
To:     Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-6-pmladek@suse.com>
 <20181205193253.mhlqj37r4o6ukkhp@redhat.com>
 <20181206082814.uyzjw2q4avknhswd@pathway.suse.cz>
 <alpine.LSU.2.21.1812061019500.17628@pobox.suse.cz>
 <20181206101423.3nps4tgyg45jwofj@pathway.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <22937554-9c7c-ed9a-0f8d-70aa6e81b25d@redhat.com>
Date:   Thu, 6 Dec 2018 09:36:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181206101423.3nps4tgyg45jwofj@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 06 Dec 2018 14:36:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 05:14 AM, Petr Mladek wrote:
> On Thu 2018-12-06 10:23:40, Miroslav Benes wrote:
>> On Thu, 6 Dec 2018, Petr Mladek wrote:
>>
>>> On Wed 2018-12-05 14:32:53, Joe Lawrence wrote:
>>>>> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
>>>>> index 972520144713..e01dfa3b58d2 100644
>>>>> --- a/kernel/livepatch/core.c
>>>>> +++ b/kernel/livepatch/core.c
>>>>> @@ -45,7 +45,7 @@
>>>>>   */
>>>>>  DEFINE_MUTEX(klp_mutex);
>>>>>  
>>>>> -/* Registered patches */
>>>>> +/* Actively used patches. */
>>>>>  LIST_HEAD(klp_patches);
>>>>
>>>> By itself, this comment makes me wonder if there are un-active and/or
>>>> un-used patches that I need to worry about.  After this patchset,
>>>> klp_patches will include patches that have been enabled and those that
>>>> have been replaced, but the replacement transition is still in progress.  
>>>>
>>>> If that sounds accurate, how about adding to the comment:
>>>>
>>>> /* Actively used patches: enabled or replaced and awaiting transition */
>>>
>>> The replaced patches are not in the list. This is why I used the word
>>> "actively".
>>

After writing out my suggestion I realized that's why you chose
"actively" and almost erased my comment.  I think the extra text would
help a fresh reader of the code, so ...

>> The replaced patches are removed in klp_discard_replaced_patches(), which 
>> is called from klp_complete_transition(). Joe is right. The patches are in 
>> the list if a transition is still in progress.
> 
> These are patches that are being replaced. The replaced (after the
>  transition finishes) are not in the list.
> 
> By other word, Joe's text could be understand that replaced patches
> will never get removed from the list.
>
> So, is the text below acceptable?
> 
> /*
>  * Actively used patches: enabled or in transition. Note that replaced
>  * or disabled patches are not listed even though the related kernel
>  * module still can be loaded.
>  */

Yes this works and is more accurate than my original suggestion.

Thanks,

-- Joe
