Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC426C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814D820892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814D820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeLEUtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:49:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbeLEUtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:49:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4636220262;
        Wed,  5 Dec 2018 20:49:16 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 664515C548;
        Wed,  5 Dec 2018 20:49:15 +0000 (UTC)
Subject: Re: [PATCH v14 00/11] livepatch: Atomic replace feature
To:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181129094431.7801-1-pmladek@suse.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <176e592d-6e9c-8e1c-abe6-d07ba9b10d54@redhat.com>
Date:   Wed, 5 Dec 2018 15:49:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181129094431.7801-1-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 05 Dec 2018 20:49:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/2018 04:44 AM, Petr Mladek wrote:
> Hi,
> 
> I have an updated present for your mailboxes.
> 
> The atomic replace allows to create cumulative patches. They
> are useful when you maintain many livepatches and want to remove
> one that is lower on the stack. In addition it is very useful when
> more patches touch the same function and there are dependencies
> between them.
> 
> All the changes were simple in principle but they required quite
> some refactoring again :-( IMHO, the biggest change is renaming
> klp_init_lists() ->klp_init_patch_before_free(). It does all
> init actions that need to succeed before klp_free() functions
> can be safely called. The main motivation was the need to
> initialize also the new .kobj_alive flags.
> 
> 
> Changes against v13:
> 
>   + Rename old_addr -> old_func instead of new_func -> new_addr. [Josh]
> 
>   + Do not add the helper macros to define structures. [Miroslav, Josh]
> 
>   + Add custom kobj_alive flag to reliably handle kobj state. [Miroslav]
> 

Aside: I don't suppose that this could ever be folded into the kobject
code/data structure itself?  This seems like a common problem that
kobj-users will need to solve like this.

>   + Avoid renaming .forced flag to .module_put by calling klp_free
>     functions only with taken module reference. [Josh]
> 
>   + Use list_add_tail() instead of list_add() when updating the dynamic
>     lists of klp_object and klp_func structures. Note that this
>     required also updating the order of messages from the pre/post
>     callbacks in the selftest. [Josh, Miroslav]
> 

Updated self-tests ran fine for me, thanks for updating.

>   + Do not unnecessarily initialize ret variable in klp_add_nops(). [Miroslav]
> 
>   + Got rid of klp_discard_replaced_stuff(). [Josh]
> 
>   + Updated commit messages, comments and documentation, especially
>     the section "Livepatch life-cycle" [Josh, Miroslav]

Thank you for adding/revising this part.  It was pretty clear and it
helped to read this before going through the individual patches.

I don't have many code comments as the changes appear to safely and
correctly do what the say.  (We are at v14 after all :)  I mainly
compared the text and comments to the implementation and noted typos
(marked by substitution s/old/new) and awkward wordings (marked by
"re-wording suggestion").  That said, I ack'd each patch as I wouldn't
want these to hold up the patchset.

Thanks,

-- Joe




