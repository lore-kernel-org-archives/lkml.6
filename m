Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4EDECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6042621523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5khgJsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6042621523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbeIUTIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:08:41 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:46195 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUTIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:08:40 -0400
Received: by mail-pf1-f171.google.com with SMTP id u24-v6so5966125pfn.13;
        Fri, 21 Sep 2018 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nGhxyorp14g5T6FRc09xMYKNnNiBNmiDNU6WkK4Sby0=;
        b=c5khgJsJl0YRC2TE0MX1P43JYqnhWXHooGBPdPYkPTBmeOjL01RIXRW2vwP6sWaZmc
         i8ZikxF5fS9kRg4sLk/ogYt3YIGil17eg7ibPFMU2/PpYPoSYGS1cqe8k+gRyhomEl+5
         0aXV/IdGmNmnNmrkfzebsEA1bu03jg6/dJgP4drQX756Uj5Ta4800NiPeqfBVpk0ozeT
         r8wOnQqliRIXpI2MSeZ1cS+ppgVGwWI7qRjHmPD2psCr4ZLevc7ojZkCBo++DQl3Ldd/
         m3Tu24iA9hztrcDMaGG4M1/VSDwoJPoI0GRM6aQr13jlKtXiSoaosPfCDwqL5J+N+K/l
         2QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nGhxyorp14g5T6FRc09xMYKNnNiBNmiDNU6WkK4Sby0=;
        b=tbtvuVKyYcQgZmQbwnq1Pxvrwl9QZKb5ynq1XEVAtNrMfUek79CuLdNcqnhcE2lWWk
         uU/tuxwJNQX5JiNRiaWppAAODQE1fGPj6r1H6jH6XD2wkhqB6mveSmIJCOS2CjqzwAhQ
         Gf/VIPq2nJwYq5P88UwTAfKKXMvCmKvQ0EpGAHFdK357ts0d2mkLnq2aFgxPKtIP3rFF
         9N7ALhgBwkww06U08AkKpBmypeFMH566vP6XE/pypp8HBIH2lEqVMoqQVY6FCw/ZLfiy
         HoUNBdcl+OVMjia2htL7QSz5dV/R76pbZRu5zqS6KoRzkBaOOD212Fl9sHjYK5x38w5n
         5A8A==
X-Gm-Message-State: APzg51Du0v6dPA3FpIWekbkmUPt9AWz6suy+aizjeDJkNfrBUCMhOmGV
        jmrORo+tV6arpXHUS2Q9eNlAB1Yz
X-Google-Smtp-Source: ANB0VdZvROcMD1VBudr9jQzTRdJ89XlPw9JlArR8pis3RG1lMCjaRQo19Eo6PMD9xdwWuu5WMgkLrw==
X-Received: by 2002:a63:f51:: with SMTP id 17-v6mr14292629pgp.100.1537535990111;
        Fri, 21 Sep 2018 06:19:50 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y85-v6sm41911115pfa.170.2018.09.21.06.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:19:49 -0700 (PDT)
Date:   Fri, 21 Sep 2018 06:19:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] hwmon: scpi-hwmon:  remove redundant continue
Message-ID: <20180921131948.GA16088@roeck-us.net>
References: <1537493403-15745-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537493403-15745-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 09:30:03AM +0800, zhong jiang wrote:
> The continue will not truely skip any code. hence it is safe to
> remove it.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Applied to hwmon-next.

Thanks,
Guenter
