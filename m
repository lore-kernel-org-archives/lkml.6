Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3DDECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3092145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3092145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeJRCcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:32:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbeJRCcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:32:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E6E23082B6F;
        Wed, 17 Oct 2018 18:35:28 +0000 (UTC)
Received: from treble (ovpn-122-46.rdu2.redhat.com [10.10.122.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2A557AB56;
        Wed, 17 Oct 2018 18:35:21 +0000 (UTC)
Date:   Wed, 17 Oct 2018 13:35:19 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 05/12] livepatch: Refuse to unload only livepatches
 available during a forced transition
Message-ID: <20181017183519.wfc2n54ga6cyjhfi@treble>
References: <20181015123713.25868-1-pmladek@suse.com>
 <20181015123713.25868-6-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015123713.25868-6-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 17 Oct 2018 18:35:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble parsing the subject.  How about:

  Allow unloading of patches added after using 'force'

?

> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -45,7 +45,8 @@
>   */
>  DEFINE_MUTEX(klp_mutex);
>  
> -static LIST_HEAD(klp_patches);
> +/* Registered patches */
> +LIST_HEAD(klp_patches);

Instead of making this non-static, can we just move
klp_force_transition() to core.c?  It's nice to have all the list
management code encapsulated in the same file.

-- 
Josh
