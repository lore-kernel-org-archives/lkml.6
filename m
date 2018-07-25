Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416CFC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED82F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED82F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbeGYTrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:47:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729799AbeGYTrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:47:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B24A4023337;
        Wed, 25 Jul 2018 18:34:21 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0445A2026D68;
        Wed, 25 Jul 2018 18:34:19 +0000 (UTC)
Date:   Wed, 25 Jul 2018 14:31:24 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     paul@paul-moore.com, zhong.weidong@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        jiang.biao2@zte.com.cn
Subject: Re: [PATCH v2] audit: fix potential null dereference
 'context->module.name'
Message-ID: <20180725183124.zstlfonw7n3rxkvq@madcap2.tricolour.ca>
References: <1532485579-34431-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532485579-34431-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 25 Jul 2018 18:34:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 25 Jul 2018 18:34:21 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-25 10:26, Yi Wang wrote:
> The variable 'context->module.name' may be null pointer when
> kmalloc return null, so it's better to check it before using
> to avoid null dereference.
> Another one more thing this patch does is using kstrdup instead
> of (kmalloc + strcpy), and signal a lost record via audit_log_lost.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
> v2: use kstrdup instead of kmalloc + strcpy, and signal a lost
> record. Thanks to Eric and Paul.
> 
>  kernel/auditsc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index e80459f..713386a 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1272,8 +1272,12 @@ static void show_special(struct audit_context *context, int *call_panic)
>  		break;
>  	case AUDIT_KERN_MODULE:
>  		audit_log_format(ab, "name=");
> -		audit_log_untrustedstring(ab, context->module.name);
> -		kfree(context->module.name);
> +		if (context->module.name) {
> +			audit_log_untrustedstring(ab, context->module.name);
> +			kfree(context->module.name);
> +		} else
> +			audit_log_format(ab, "(null)");
> +
>  		break;
>  	}
>  	audit_log_end(ab);
> @@ -2408,8 +2412,9 @@ void __audit_log_kern_module(char *name)
>  {
>  	struct audit_context *context = current->audit_context;
>  
> -	context->module.name = kmalloc(strlen(name) + 1, GFP_KERNEL);
> -	strcpy(context->module.name, name);
> +	context->module.name = kstrdup(name, GFP_KERNEL);
> +	if (!context->module.name)
> +		audit_log_lost("out of memory in __audit_log_kern_module");
>  	context->type = AUDIT_KERN_MODULE;
>  }
>  

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
