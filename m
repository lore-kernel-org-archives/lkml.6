Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B3CC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E05C20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E05C20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbeLFOXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:23:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbeLFOXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:23:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27C4D3DE;
        Thu,  6 Dec 2018 14:23:49 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FABB5D96F;
        Thu,  6 Dec 2018 14:23:48 +0000 (UTC)
Subject: Re: [PATCH v14 03/11] livepatch: Consolidate klp_free functions
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-4-pmladek@suse.com>
 <20181205190220.vterzx33opvvijne@redhat.com>
 <20181206081501.jkki7hg4u43fqwth@pathway.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <d4dcf407-462a-e6bd-7ab5-6d27fbcccb99@redhat.com>
Date:   Thu, 6 Dec 2018 09:23:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181206081501.jkki7hg4u43fqwth@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 06 Dec 2018 14:23:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 03:15 AM, Petr Mladek wrote:
> On Wed 2018-12-05 14:02:20, Joe Lawrence wrote:
>> On Thu, Nov 29, 2018 at 10:44:23AM +0100, Petr Mladek wrote:
>>> The code for freeing livepatch structures is a bit scattered and tricky:
>>>
>>> [ ... snip ... ]
>>>
>>> +static int klp_init_patch(struct klp_patch *patch)
>>> +{
>>> +	struct klp_object *obj;
>>> +	int ret;
>>> +
>>> +	mutex_lock(&klp_mutex);
>>> +
>>> +	ret = klp_init_patch_before_free(patch);
>>>  	if (ret) {
>>>  		mutex_unlock(&klp_mutex);
>>>  		return ret;
>>>  	}
>>>
>>
>> I believe klp_init_patch_before_free() accumulates more responsibilities
>> later in the patchset, but I'll ask here: does it really need the
>> klp_mutex since it looks to be operating only on the klp_patch, its
>> objects and functions? 
> 
> I do not have a strong opinion about it.
> 
> On one hand, we are manipulating all the structures and should prevent
> any parallel use. On the other hand, the rest of the code will not
> touch the patch until it is added into klp_patches list or until
> the sysfs interface is created.
> 
> If you think that it might cause false expectations and confusions
> then I could move it out of the lock.

I didn't find it confusing, nor is it performance limiting.  I figured I
would point it out in case there was some reason for the mutex that I
had missed.

> Well, in the final version we need to call klp_check_patch_conflict()
> under the mutex.

That's right.

-- Joe

