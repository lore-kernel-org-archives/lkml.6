Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABCCC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0555207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u2jRYh9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0555207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeJYAro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:47:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39192 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJYAro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+tuFQgVvbtJGl9AJR5zPCTWAT4KEygDtHeKSSYSBO2k=; b=u2jRYh9Nj2WVgix304rJzLwkdi
        SLRA6twaSTLUU7+huqaPRgfLulC9T0Akhj2KpsvonJlzk37lC2S5NSmoxvP3ivwr9Nahwr6cSAlaj
        WjlmgMcSzfQ3pikbLBfbGFVhojFAqyso0ozxYbl7EANV+VjyUk9RJGuyj7BJKKkgXGs3/rdfpo5xy
        wj3QrOyRAks9/fFjvRRtI9xZFWOHku2eRred1b84THx5lR3bbBOMXfSWAK4pc1zIyaSajDB5z2Ayx
        Uy6RHyPHx8QaUXykKX73lrO9iJDwB4k9JxoDDGsWGYoD5h62KW2iymuDvXPKIqInRyK5u/vyPh5PX
        7VYeLuPA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFLs5-0000t5-Sa; Wed, 24 Oct 2018 16:19:02 +0000
Subject: Re: [PATCH] V2 init/main.c Enable watchdog_thresh control from kernel
 line
To:     Laurence Oberman <loberman@redhat.com>,
        linux-kernel@vger.kernel.org
References: <1540396387-20337-1-git-send-email-loberman@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <88de4b50-b3cd-1870-8944-92163df84bb3@infradead.org>
Date:   Wed, 24 Oct 2018 09:19:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540396387-20337-1-git-send-email-loberman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 8:53 AM, Laurence Oberman wrote:
> Both graphics and serial consoles are exposed to hard lockups
> when handling a large amount of messaging. The kernel watchdog_thresh
> parameter up to now has not been available to be set on the kernel line for
> early boot. 
> This patch allows the setting of watchdog_thresh to be increased
> when needed to avoid the hard lockups in the console code.
> 
> Signed-off-by: Laurence Oberman <loberman@redhat.com>
> ---
>  init/main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/init/main.c b/init/main.c
> index e4a3160..5882750 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -977,6 +977,15 @@ static int __init set_debug_rodata(char *str)
>  __setup("rodata=", set_debug_rodata);
>  #endif
>  
> +static int __init
> +is_watchdog_thresh_setup(char *str)
> +{
> +	get_option(&str, &watchdog_thresh);
> +	return 1;
> +}
> +__setup("watchdog_thresh=", is_watchdog_thresh_setup);
> +
> +
>  #ifdef CONFIG_STRICT_KERNEL_RWX
>  static void mark_readonly(void)
>  {
> 

Hi Laurence,

Let's make this into more of a complete patch.

a.  update the diffstat to include the Documentation change

b.  send the patch with the Documentation change as part of the same patch,
not as a separate patch (It looks like the multiple "---" lines in the
email are confusing.)

c.  send the patch to someone who can merge it: scripts/get_maintainer.pl top
suggestions are:
Thomas Gleixner <tglx@linutronix.de> or Ingo Molnar <mingo@kernel.org>

thanks,
-- 
~Randy
