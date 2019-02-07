Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55096C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2376B218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0rFEzLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBGTQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:16:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40399 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfBGTQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:16:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so374774pfo.7;
        Thu, 07 Feb 2019 11:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lzbp2sP/pJaCnsygquW6ilK8mRQHMw8NwDjU7re2YoM=;
        b=q0rFEzLL+39D1iC3c+Eed8K9tYnW7+p6PJYlj3IYsi8r05fxmGi8ICfhy6Kpg7SOyI
         dn82r20U/ZxxCqElOzok4Uj8GkDlIqpEJEgFtGhtZixRToKNSgqbnawa+BLFsmyMOdjf
         R7H+nNQ1DYKotwc+nCmbyuMIB2ssZyBiGBxmcxSSy0IRiIqVM1xzBEEHrEeWHvAiHAJd
         BDwzd6CYKW/WOjHXxbkjiirmOzR6G2LSQtZX41sugIO8Y2DQN8zBSkaBBoQz4QLsXm2d
         otV3jYIi+UX2VCz3CD3tpc8eBvjynZlE/L3JSxUtjgQx+ndngQm3iwagXuylP0sxonVk
         +Z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lzbp2sP/pJaCnsygquW6ilK8mRQHMw8NwDjU7re2YoM=;
        b=ssApemA9NSGpOrsfHCqGxUGU64IsqEFlpZOK7yxbznZuVH9XZSEXGdQq5b11+2WHbg
         IX8StlmGVt2Rn8MnVYbEe+s3CDesxkFvFgIB4kWRmrcbreE/5LEt9zojj5taxMxxdGHk
         76rePBtjC+gwwpnU0YihTaMZAB1UdlTeK1uXZUSEsef688ZdQCoBZoq5YmQWdFBqnuBb
         s8Fqql8z5gkDH7C4qr0TGzy/ItjZA0h2xqQb5EmlEkLxLx2bhzQPGyBXAf0u7Itwr9Wi
         xu+eatdYKlklsyYw3uzAFwTjbYHLxHgiOiizKkc3it5H97mdYDuC/ohuAw5FxtpUbx8H
         Xi4A==
X-Gm-Message-State: AHQUAubbdGm9Gkyta6gNzL6M7Mq4RnfU1F+DT8IWOiSwSaVlNMCxh6bH
        VOW6MlKU/di9wCg4sZnGV08=
X-Google-Smtp-Source: AHgI3IbzPcY4Y7B3uV3nP5CyRkMWiOE3Bbj0titorHs8odz3Kti/UUgVn/sVgnZ1Ju/NpLb0jc7KLA==
X-Received: by 2002:a62:9f1b:: with SMTP id g27mr17314251pfe.87.1549566974430;
        Thu, 07 Feb 2019 11:16:14 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2sm14993441pgc.94.2019.02.07.11.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:16:13 -0800 (PST)
Date:   Thu, 7 Feb 2019 11:16:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/34] 4.4.174-stable review
Message-ID: <20190207191611.GB30122@roeck-us.net>
References: <20190207113025.552605181@linuxfoundation.org>
 <2780bab7-047c-33c2-e0dc-cdc0cec46400@roeck-us.net>
 <20190207154708.GB7164@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207154708.GB7164@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 04:47:08PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 07, 2019 at 06:20:43AM -0800, Guenter Roeck wrote:
> > On 2/7/19 3:41 AM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.4.174 release.
> > > There are 34 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat Feb  9 11:30:10 UTC 2019.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> > 	total: 171 pass: 170 fail: 1
> > Failed builds:
> > 	x86_64:allyesconfig
> > Qemu test results:
> > 	total: 291 pass: 291 fail: 0
> 
> Oh, and thanks for the very fast turn-around time.
> 
No problem; all automatic.

If there is only one branch to build, it is quite fast. A single branch
takes ~90 minutes to build and test. Of course, that means if you push
{3.18..4.20} together, it takes at 9+ hours for the builds and tests to
complete, plus the additional time for master, next, and 3.16 if those
branches change as well. Since, thanks to California's outrageous
electricity costs, builds only start between 11:00pm and 4:00am PST,
results are often only available around noon the next day.

Guenter
