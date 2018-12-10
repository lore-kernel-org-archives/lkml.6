Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8198C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1382086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uH7YDxbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1382086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeLJQyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:54:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34369 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeLJQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:54:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id 17so5231904pgg.1;
        Mon, 10 Dec 2018 08:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mXjRzPujUks+cX0uY/GEdewRS9USL1pvlhvSE4R9qqg=;
        b=uH7YDxbcVVGqSiVF4owEDm3wFdNxyMPIdJnx13ZlkcADg36ta/iepl4NDywUWPGNCf
         92DjAV9aAhExqRVxXfi+6EmCsh5rrqc9NBQy70DNm+BZ0m5MdB2pzJ0EGjX9exebxMeZ
         P0/ArW0eCha7iPj7xbq3PNYa6mBPjzhqEgOCclW4fR6ghxjFnVIp0jh6Sn+ohgXWVTbK
         q5o6fqdwcIvb5P9d/U0G2WX14r4h07uNY12tY3O/ifMH4daNaAJpKQ5gkr5Yw5M+d0GP
         iBzy4XzzpyFzpcnQ9YX2LKxC8fd7jHJdCcLi3GvbngCFF/fdB7nGrNVbnzSkE+4m3wLi
         xXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mXjRzPujUks+cX0uY/GEdewRS9USL1pvlhvSE4R9qqg=;
        b=sYWXc56zkzQy3PfUtb3zdg1XTHuSIlj4cigZN0uUFD5uSbcuWcq4DLgSnfZABMpX+H
         yb3AAYvrfVqUZnfsVmlIzgmJnJPB3spJMQ0vxIAXERAHJOGeGriw4sFJw/QbGGRbKKEi
         PC8Pes3ttd75IPXE2xz6tIKOiqrK4qLbGyT+xx2tQREDy6RgqLZYVDSMjfsBs0BtWpMP
         pThIOSX4YgSyq6KTi0C/9t+fJtMaWbcHMcJCea6ird8YbC72r8wJHhjlPg3JXO1ebg5g
         OQk4vF9vPw9kTf0oo+W6XLdG/Jq6YmKPt/5Foe9dwqHby++JmkZESfpiMiyMRrSy+s5n
         VhlA==
X-Gm-Message-State: AA+aEWYZuy8Z+1hNTQ9jndiSvMys7hmoC87AneXOAh1uEkvDXnyZw3S4
        aYcN8gcmla5yrepDOjhJJEZOXcDH
X-Google-Smtp-Source: AFSGD/VGMiEtQjFrVu5JhpftR12EXuBMaw40b3veVQshJfEKlWc9YKxjBtB1/0k9zFfK0QGTuoCHyg==
X-Received: by 2002:a63:c0f:: with SMTP id b15mr11631836pgl.314.1544460857157;
        Mon, 10 Dec 2018 08:54:17 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e16sm14599179pfn.46.2018.12.10.08.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:54:16 -0800 (PST)
Date:   Mon, 10 Dec 2018 08:54:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3.16 000/328] 3.16.62-rc1 review
Message-ID: <20181210165414.GA25566@roeck-us.net>
References: <lsq.1544392232.713909046@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 09:50:32PM +0000, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.62 release.
> There are 328 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Dec 14 18:00:00 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 135 fail: 1
Failed builds: 
	i386:tools/perf 
Qemu test results:
	total: 219 pass: 219 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
