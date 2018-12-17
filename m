Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41060C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187842133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbeLQPoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:44:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387434AbeLQPoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:44:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0325588E48;
        Mon, 17 Dec 2018 15:44:38 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E30D06012B;
        Mon, 17 Dec 2018 15:44:36 +0000 (UTC)
Subject: Re: [PATCH V2] livepatch: fix non-static warnings
To:     Miroslav Benes <mbenes@suse.cz>,
        Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1544965657-26804-1-git-send-email-hofrat@osadl.org>
 <alpine.LSU.2.21.1812171256390.3087@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <20ef1d3a-2916-ce00-2938-3397746efac9@redhat.com>
Date:   Mon, 17 Dec 2018 10:44:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1812171256390.3087@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 17 Dec 2018 15:44:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/2018 07:03 AM, Miroslav Benes wrote:
> Hi,
> 
> I'm sorry for being late to the party.
> 
> On Sun, 16 Dec 2018, Nicholas Mc Guire wrote:
> 
>> Sparse reported warnings about non-static symbols. For the variables
>> a simple static attribute is fine - for those symbols referenced by
>> livepatch via klp_func the symbol-names must be unmodified in the
>> symbol table - to resolve this the __noclone attribute is used
>> for the shared statically declared functions.
>>
>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
>> Link: https://lkml.org/lkml/2018/12/13/827
> 
> A nit, but I'd reorder the tags. Link, Suggested-by:, Signed-off-by:. Also 
> it would be great if you used https://lkml.kernel.org/r/${Msg-ID} 
> redirection.
> 
>> ---
>>
>> V2: not all static functions shared need to carry the __noclone
>>     attribute only those that need to be resolved at runtime by
>>     livepatch - so drop the unnecessary __noclone attributes as
>>     well as the Note on __noclone as suggested by Joe Lawrence
>>     <joe.lawrence@redhat.com> - thanks !
> 
> I talked to Martin Jambor (GCC) and he suggested __attribute__((used)). It 
> should be better than __noclone, which was reportedly implemented only for 
> testing purposes (which is why it does not imply noinline, although 
> inlining internally uses cloning). Newer gcc also has "noipa" attribute, 
> but "used" would definitely be safe.
> 
> Sorry for not responding earlier.
>

Hi Miroslav,

Thanks for following up on this. "noipa" would have been nice to use,
but as you say, is a newer gcc attribute.

Regarding "used" vs. "noclone", can we assume that "used" implies that
the function name remains unchanged?

The gcc online doc [1] speaks about ensuring that "code must be
emitted".  This reads like it solves our
static-function-not-directly-referenced problem, but isn't explicit
about naming.

    used

    This attribute, attached to a function, means that code must be
    emitted for the function even if it appears that the function is not
    referenced. This is useful, for example, when the function is
    referenced only in inline assembly.

Perhaps it's equivalent to a "I want to keep this function and leave
it's symbols alone" attribute.  FWIW, I modified Nicholas' change on my
box to use "used" and it worked as Martin advertised, so it would get my
Ack.

I'm just being picky about its documentation and how we should note its
usage in the v3 patch.  Think that s/__noclone/used/g of the v2 commit
message would be sufficient?


[1]
https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noclone-function-attribute


Thanks,

-- Joe
