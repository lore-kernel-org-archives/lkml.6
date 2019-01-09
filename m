Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFBBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE93206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbfAIOuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:50:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:37104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732063AbfAIOuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:50:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 917F0ADE7;
        Wed,  9 Jan 2019 14:50:10 +0000 (UTC)
Date:   Wed, 9 Jan 2019 15:50:09 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 04/11] livepatch: Don't block the removal of patches
 loaded after a forced transition
In-Reply-To: <20190109124329.21991-5-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1901091549310.12972@pobox.suse.cz>
References: <20190109124329.21991-1-pmladek@suse.com> <20190109124329.21991-5-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Petr Mladek wrote:

> module_put() is currently never called in klp_complete_transition() when
> klp_force is set. As a result, we might keep the reference count even when
> klp_enable_patch() fails and klp_cancel_transition() is called.
> 
> This might give the impression that a module might get blocked in some
> strange init state. Fortunately, it is not the case. The reference count
> is ignored when mod->init fails and erroneous modules are always removed.
> 
> Anyway, this might be confusing. Instead, this patch moves
> the global klp_forced flag into struct klp_patch. As a result,
> we block only modules that might still be in use after a forced
> transition. Newly loaded livepatches might be eventually completely
> removed later.
> 
> It is not a big deal. But the code is at least consistent with
> the reality.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
