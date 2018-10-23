Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAE8C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3A8207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBxEu7FP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3A8207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeJXFP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 01:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeJXFP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 01:15:58 -0400
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6D2A2075D;
        Tue, 23 Oct 2018 20:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540327855;
        bh=KtPoq6UX031rFQqznA35SZlcDT6KzyNX0cH7NCI3SLI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QBxEu7FPStbXcYXM+XqTmAP+0KT7OQ6ncNuafc4n44GZ+N82W8PFuyyzY5uXYoz8x
         mVxKNyjTnlUd8dKjOzGyzgyzG74CVW1qt5fse2lLE+bDWMarEnuduChR8I96L9G87J
         Ua75Z7ZmFnNWMlOzBkZYeHl58BK7EPHDeu8NX16w=
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        maco@android.com, Shuah Khan <shuah@kernel.org>
References: <20181019173538.590-1-urezki@gmail.com>
 <20181022125142.GD18839@dhcp22.suse.cz>
 <20181022165253.uphv3xzqivh44o3d@pc636>
 <20181023072306.GN18839@dhcp22.suse.cz>
 <dd0c3528-9c01-12bc-3400-ca88060cb7cf@kernel.org>
 <20181023152640.GD20085@bombadil.infradead.org>
 <20181023170532.GW18839@dhcp22.suse.cz>
 <98842edb-d462-96b1-311f-27c6ebfc108a@kernel.org>
 <20181023193044.GA139403@joelaf.mtv.corp.google.com>
 <024af44a-77e1-1c61-c9b2-64ffbe4f7c49@kernel.org>
 <20181023200923.GB25444@bombadil.infradead.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <ffec3806-969d-62df-2965-e8800babb8a1@kernel.org>
Date:   Tue, 23 Oct 2018 14:50:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023200923.GB25444@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2018 02:09 PM, Matthew Wilcox wrote:
> On Tue, Oct 23, 2018 at 01:48:32PM -0600, Shuah Khan wrote:
>> On 10/23/2018 01:30 PM, Joel Fernandes wrote:
>>> On Tue, Oct 23, 2018 at 11:13:36AM -0600, Shuah Khan wrote:
>>>> I like this proposal. I think we will open up lot of test opportunities with
>>>> this approach.
>>>>
>>>> Maybe we can use this stress test as a pilot and see where it takes us.
>>>
>>> I am a bit worried that such an EXPORT_SYMBOL_KSELFTEST mechanism can be abused by
>>> out-of-tree module writers to call internal functionality.
>>
>> That is  valid concern to consider before we go forward with the proposal.
>>
>> We could wrap EXPORT_SYMBOL_KSELFTEST this in an existing debug option. This could
>> be fine grained for each sub-system for its debug option. We do have a few of these
>> now
> 
> This all seems far more complicated than my proposed solution.
> 

Not sure if it that complicated. But it is more involved. It dies have the
advantage of fitting in with the rest of the debug/test type framework we
already have.

The option you proposed sounds simpler, however it sounds a bit adhoc to me.

In any case I went looking for EXPORT_SYMBOL defines and found them in 

tools/include/asm/export.h
tools/include/linux/export.h
tools/virtio/linux/export.h

selftests/powerpc/copyloops/asm/export.h
selftests/powerpc/stringloops/asm/export.h

thanks,
-- Shuah
