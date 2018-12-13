Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5587C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636422080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636422080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeLMXAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:00:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbeLMXAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 18:00:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 537873002F85;
        Thu, 13 Dec 2018 23:00:51 +0000 (UTC)
Received: from treble (ovpn-120-195.rdu2.redhat.com [10.10.120.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6CAF6012D;
        Thu, 13 Dec 2018 23:00:47 +0000 (UTC)
Date:   Thu, 13 Dec 2018 17:00:45 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 08/11] livepatch: Remove Nop structures when unused
Message-ID: <20181213230045.2xgi2pyewkjbou22@treble>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-9-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-9-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 13 Dec 2018 23:00:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:28AM +0100, Petr Mladek wrote:
> +static void __klp_free_funcs(struct klp_object *obj, bool free_all)
>  {
> -	struct klp_func *func;
> +	struct klp_func *func, *tmp_func;
> +
> +	klp_for_each_func_safe(obj, func, tmp_func) {
> +		if (!free_all && !func->nop)
> +			continue;

I suspect that changing 'free_all" to 'nops_only' (and inverting the
condition) would make the code more readable.

And a similar suggestion for __klp_free_objects().

> +
> +		/*
> +		 * Avoid double free. It would be tricky to wait for kobject
> +		 * callbacks when only NOPs are handled.
> +		 */
> +		list_del(&func->node);

I've read this comment several times but I still have no idea how it
relates to the code :-)

And a similar comment for __klp_free_objects().

-- 
Josh
