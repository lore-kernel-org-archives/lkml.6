Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97732C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4522A204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4522A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbeGXMpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:45:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388196AbeGXMpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:45:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B69B8401EF05;
        Tue, 24 Jul 2018 11:39:32 +0000 (UTC)
Received: from ovpn-112-24.rdu2.redhat.com (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02E912026DE8;
        Tue, 24 Jul 2018 11:39:31 +0000 (UTC)
Message-ID: <450ab68cc6b7cebbf1b6292e3140932ea1ac9e57.camel@redhat.com>
Subject: Re: [PATCH] audit: fix potential null dereference
 'context->module.name'
From:   Eric Paris <eparis@redhat.com>
To:     Yi Wang <wang.yi59@zte.com.cn>, paul@paul-moore.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Date:   Tue, 24 Jul 2018 07:39:31 -0400
In-Reply-To: <1532411834-33775-1-git-send-email-wang.yi59@zte.com.cn>
References: <1532411834-33775-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 24 Jul 2018 11:39:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 24 Jul 2018 11:39:32 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eparis@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would it make more sense to actually check for failure on allocation
rather than try to remember to deal with it later? How about we just
have audit_log_kern_module return an error and fail if we are OOM?
(also this seems like a good place to use kstrdup, instead of
kmalloc+strcpy)

On Tue, 2018-07-24 at 13:57 +0800, Yi Wang wrote:
> The variable 'context->module.name' may be null pointer when
> kmalloc return null, so it's better to check it before using
> to avoid null dereference.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>  kernel/auditsc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index e80459f..4830b83 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1272,8 +1272,12 @@ static void show_special(struct audit_context
> *context, int *call_panic)
>  		break;
>  	case AUDIT_KERN_MODULE:
>  		audit_log_format(ab, "name=");
> -		audit_log_untrustedstring(ab, context->module.name);
> -		kfree(context->module.name);
> +		if (context->module.name) {
> +			audit_log_untrustedstring(ab, context-
> >module.name);
> +			kfree(context->module.name);
> +		} else
> +			audit_log_format(ab, "(null)");
> +
>  		break;
>  	}
>  	audit_log_end(ab);
> @@ -2409,7 +2413,8 @@ void __audit_log_kern_module(char *name)
>  	struct audit_context *context = current->audit_context;
>  
>  	context->module.name = kmalloc(strlen(name) + 1, GFP_KERNEL);
> -	strcpy(context->module.name, name);
> +	if (context->module.name)
> +		strcpy(context->module.name, name);
>  	context->type = AUDIT_KERN_MODULE;
>  }
>  
