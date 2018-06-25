Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26EDC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6315D25E6C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6315D25E6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933424AbeFYQlU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:41:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51626 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932523AbeFYQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:41:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fXUY9-00015T-QR; Mon, 25 Jun 2018 16:41:09 +0000
Date:   Mon, 25 Jun 2018 17:41:09 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        security@kernel.org, Christoph Hellwig <hch@infradead.org>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH] sys: don't hold uts_sem while accessing userspace memory
Message-ID: <20180625164109.GF30522@ZenIV.linux.org.uk>
References: <20180625163410.216168-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625163410.216168-1-jannh@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 06:34:10PM +0200, Jann Horn wrote:

> +	char tmp[32];
>  
> -	if (namelen > 32)
> +	if (namelen < 0 || namelen > 32)
>  		namelen = 32;
>  
>  	down_read(&uts_sem);
>  	kname = utsname()->domainname;
>  	len = strnlen(kname, namelen);
> -	if (copy_to_user(name, kname, min(len + 1, namelen)))
> -		err = -EFAULT;
> +	len = min(len + 1, namelen);
> +	memcpy(tmp, kname, len);
>  	up_read(&uts_sem);
>  
> -	return err;
> +	if (copy_to_user(name, tmp, len))
> +		return -EFAULT;

Infoleak, and similar in a lot of other places.
