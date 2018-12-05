Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9475C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9928920645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9928920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeLETFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:05:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeLETFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:05:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DACE34E928;
        Wed,  5 Dec 2018 19:05:07 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7A2F60BEE;
        Wed,  5 Dec 2018 19:05:06 +0000 (UTC)
Date:   Wed, 5 Dec 2018 14:05:06 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 04/11] livepatch: Refuse to unload only livepatches
 available during a forced transition
Message-ID: <20181205190506.o7feg4y7m7t7eyp7@redhat.com>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-5-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-5-pmladek@suse.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 05 Dec 2018 19:05:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:24AM +0100, Petr Mladek wrote:
> module_put() is currently never called in klp_complete_transition() when
> klp_force is set. As a result, we might keep the reference count even when
> klp_enable_patch() fails and klp_cancel_transition() is called.
> 
> This might make an assumption that a module might get blocked in some
             ^^^^^^^^^^^^^^^^^^
re-wording suggestion: "give the impression"

> strange init state. Fortunately, it is not the case. The reference count
> is ignored when mod->init fails and erroneous modules are always removed.
> 
> Anyway, this might make some confusion. Instead, this patch moves
                     ^^^^^^^^^^^^^^^^^^^
re-wording suggestions: "create confusion" or "be confusing"

> the global klp_forced flag into struct klp_patch. As a result,
> we block only modules that might still be in use after a forced
> transition. Newly loaded livepatches might be eventually completely
> removed later.
> 
> It is not a big deal. But the code is at least consistent with
> the reality.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe
