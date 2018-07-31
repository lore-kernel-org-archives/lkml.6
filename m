Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12F3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F6120841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F6120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbeGaScf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:32:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49522 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbeGaScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:32:35 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fkXrc-00032b-Tz; Tue, 31 Jul 2018 16:51:12 +0000
Date:   Tue, 31 Jul 2018 17:51:12 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] fs: don't let getdents return bogus names
Message-ID: <20180731165112.GJ30522@ZenIV.linux.org.uk>
References: <20180731161025.189534-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731161025.189534-1-jannh@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 06:10:27PM +0200, Jann Horn wrote:
> +/*
> + * Most filesystems don't filter out bogus directory entry names, and userspace
> + * can get very confused by such names. Behave as if a low-level IO error had
> + * happened while reading directory entries.
> + */
> +bool bogus_dirent_name(int *errp, const char *name, int namlen,
> +		       const char *caller)
> +{
> +	if (namlen == 0) {
> +		pr_err_once("%s: filesystem returned bogus empty name\n",
> +			    caller);
> +		*errp = -EUCLEAN;
> +		return true;
> +	}
> +	if (memchr(name, '/', namlen)) {
> +		pr_err_once("%s: filesystem returned bogus name '%*pEhp' (contains slash)\n",
> +			    caller, namlen, name);
> +		*errp = -EUCLEAN;
> +		return true;
> +	}
> +	return false;
> +}

> +	if (bogus_dirent_name(&buf->result, name, namlen, __func__))
> +		return -EUCLEAN;

These calling conventions st^Ware rather suboptimal.  First of all,
	* none of ->actor() callbacks will ever get called directly.
	* there are only 4 callers.  3 of them (all in fs.h) are
of the form return ....->actor(...) == 0;  The fourth is
        return orig_ctx->actor(orig_ctx, name, namelen, offset, ino, d_type);
in ovl_fill_real(), which itself is an ->actor() callback.

So all these "return -E..." in the instances are completely pointless;
we should just turn filldir_t into pointer-to-function-returning-bool
and get rid of that boilerplate, rather than adding more to it.

Furthermore, who the hell cares which callback has stepped into it?
"The first time it happened from getdents(2) in a 32bit process and
that's all you'll ever get out of me" seems to be less than helpful...

And frankly, I would prefer
	buf->result = check_dirent_name(name, namelen);
	if (unlikely(buf->result))
		return false;
making that thing return -EUCLEAN or 0.  Quite possibly - inlining it
as well...
