Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8434BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 04:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFE02512A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 04:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFE02512A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeF3EE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 00:04:57 -0400
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:59810 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751861AbeF3EE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 00:04:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 54A0918008658;
        Sat, 30 Jun 2018 04:04:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ship02_47f50dfc1f93f
X-Filterd-Recvd-Size: 1833
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jun 2018 04:04:54 +0000 (UTC)
Message-ID: <15a087e0c207e87b0e1e7e0bdd5a09c5d336c224.camel@perches.com>
Subject: Re: [PATCH] modsign: log module name in the event of an error
From:   Joe Perches <joe@perches.com>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>
Date:   Fri, 29 Jun 2018 21:04:52 -0700
In-Reply-To: <20180629155329.2076-1-jeyu@kernel.org>
References: <20180629155329.2076-1-jeyu@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 17:53 +0200, Jessica Yu wrote:
> Now that we have the load_info struct all initialized (including
> info->name, which contains the name of the module) before
> module_sig_check(), make the load_info struct and hence module name
> available to mod_verify_sig() so that we can log the module name in the
> event of an error.
[]
> diff --git a/kernel/module-internal.h b/kernel/module-internal.h
[]
> +extern int mod_verify_sig(const void *mod, struct load_info *info,
> +			  unsigned long *_modlen);
> diff --git a/kernel/module.c b/kernel/module.c
[]
> @@ -2778,7 +2758,7 @@ static int module_sig_check(struct load_info *info, int flags)
>  	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
>  		/* We truncate the module to discard the signature */
>  		info->len -= markerlen;
> -		err = mod_verify_sig(mod, &info->len);
> +		err = mod_verify_sig(mod, info, &info->len);

This is the only place this is used correct?
So why pass info and info->member?

info should be enough


