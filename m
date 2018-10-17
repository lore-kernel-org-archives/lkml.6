Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55CBECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BD1214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BD1214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeJRCOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:14:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbeJRCOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:14:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44B2A3082A41;
        Wed, 17 Oct 2018 18:18:03 +0000 (UTC)
Received: from treble (ovpn-122-46.rdu2.redhat.com [10.10.122.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E4347BE3A;
        Wed, 17 Oct 2018 18:17:58 +0000 (UTC)
Date:   Wed, 17 Oct 2018 13:17:56 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 02/12] livepatch: Helper macros to define livepatch
 structures
Message-ID: <20181017181756.cy65ujygmf3ulmiz@treble>
References: <20181015123713.25868-1-pmladek@suse.com>
 <20181015123713.25868-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015123713.25868-3-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 17 Oct 2018 18:18:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 02:37:03PM +0200, Petr Mladek wrote:
> The definition of struct klp_func might be a bit confusing.
> The original function is defined by name as a string.
> The new function is defined by name as a function pointer
> casted to unsigned long.
> 
> This patch adds helper macros that hide the different types.
> The functions are defined just by the name. For example:

On one hand, these macros are kind of nice, because they do the function
pointer casting for the user.

On the other hand, they hide the field names, which hurts readability a
bit.  For example, it would be easy to accidentally assign the wrong
callback function.

Also, it's unfortunate that these macros are needed in the first place.

What if we just change new_addr (and old_addr) to be 'void *'?  Then the
macros wouldn't be as useful, and we could just get rid of them.

-- 
Josh
