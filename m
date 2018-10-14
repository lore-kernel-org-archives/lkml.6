Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F37C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDDA20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDDA20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeJOBAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:00:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38978 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOBAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 21:00:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBk2Z-0001r8-Pn; Sun, 14 Oct 2018 17:18:55 +0000
Date:   Sun, 14 Oct 2018 18:18:55 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com
Subject: Re: [PATCH 1/2] sysctl: add overflow detection to proc_get_long()
Message-ID: <20181014171855.GW32577@ZenIV.linux.org.uk>
References: <20181014132510.25943-1-christian@brauner.io>
 <20181014132510.25943-2-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181014132510.25943-2-christian@brauner.io>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 03:25:09PM +0200, Christian Brauner wrote:

> +static unsigned long sysctl_strtoul_lenient(const char *cp, char **endp,
> +					    unsigned int base, bool *overflow)
> +{
> +	unsigned long long result;
> +	unsigned int rv;
> +
> +	cp = _parse_integer_fixup_radix(cp, &base);
> +	rv = _parse_integer(cp, base, &result);
> +	if ((rv & KSTRTOX_OVERFLOW) ||
> +	    (result != (unsigned long long)(unsigned long)result))
> +		*overflow = true;
> +	else
> +		*overflow = false;

Yecchh...  First of all, the cast back to unsigned long long is completely
pointless.  What's more,
	if (expr)
		foo = true;
	else
		foo = flase;
is a fairly unidiomatic way to spell foo = expr;

And... is there anything that would really care if this "overflow" thing had
been replaced by simply returning ~0UL on such?  That would appear to be
a lot more natural API...
