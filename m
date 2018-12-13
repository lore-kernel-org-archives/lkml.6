Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6A4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD03620645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD03620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbeLMMbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:31:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:56694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728859AbeLMMbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:31:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C52CFAC24;
        Thu, 13 Dec 2018 12:31:39 +0000 (UTC)
Date:   Thu, 13 Dec 2018 13:31:39 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: handle kzalloc failure
Message-ID: <20181213123139.oukmwpkw2yfap6oa@pathway.suse.cz>
References: <1544699390-15673-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544699390-15673-1-git-send-email-hofrat@osadl.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-12-13 12:09:49, Nicholas Mc Guire wrote:
> kzalloc() return should always be checked - notably in example code
> where this may be seen as reference. On failure of allocation
> livepatch_fix1_dummy_alloc() should return NULL.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> Problem was located with an experimental coccinelle script
> 
> Patch was compile tested with: x86_64_defconfig + FTRACE=y
> FUNCTION_TRACER=y, EXPERT=y, LATENCYTOP=y, SAMPLES=y, SAMPLE_LIVEPATCH=y
> (with some unrelated sparse warnings on symbols not being static)
> 
> Patch is against 4.20-rc6 (localversion-next is next-20181213)
> 
>  samples/livepatch/livepatch-shadow-fix1.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
> index 49b1355..a0e8f04 100644
> --- a/samples/livepatch/livepatch-shadow-fix1.c
> +++ b/samples/livepatch/livepatch-shadow-fix1.c
> @@ -89,6 +89,9 @@ struct dummy *livepatch_fix1_dummy_alloc(void)
>  	 * pointer to handle resource release.
>  	 */
>  	leak = kzalloc(sizeof(int), GFP_KERNEL);
> +	if (!leak)
> +		return NULL;

It should be:

	if (!leak) {
		kfree(d);
		return NULL;
	}

Note that The check is not strictly needed in this artificial
example because we never read/write any data there. But I agree
that we should add the check to promote the the right programming
patterns.

Best Regards,
Petr
