Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE70BC282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB7720881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJfbE46R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfA3XL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:11:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44264 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3XLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:11:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so521986pfh.11;
        Wed, 30 Jan 2019 15:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=huEvtyNeNiUQKLOyXKODQsbeqDBkjT5JVa3S6ElZspU=;
        b=mJfbE46RYWSh19+xpTgAY3UZgpDI6dSoF1JT/AfAZgsgCJbA5kcrOZFe3zSABYH+A7
         t4zIj1qRmCNTGJGmpzhf9kIMN/r7iDp4jwByXBypaLh8xKwNwwxF44eXxNP++nVvfJQ4
         Te8lqZl0Qe+zdLZ1XFFAsukB5sxUAEoNdOedWCQQ9ZlTCI/EYHP/zormzy6B3NdCDKFK
         Nlao/8ETOrnZVyRI9Mg+5p21vv/u3CRcNP+vKgW19PJIqkyr5LOcBd7jeGmsuYyvmRLX
         jQDw+V3ztJcjE2lhUO78aPtJe3X4cU5uKyiPsy3D3iWlfGVu65G9J/VZiwRoj9N1Oah4
         q+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=huEvtyNeNiUQKLOyXKODQsbeqDBkjT5JVa3S6ElZspU=;
        b=jX+KyCTQvkUMW4inQKA3Ut7u3WbP13nLzNCVlD7VepvPbhLDS5G7epWkShyU5Pb128
         A60rvymGnEGdY3yeP9e7anSH0cdWyhYVeUVSnoUxGAegqWK8ny7md3qEmgsmQRi4AyOE
         SFhYyZ8i3jRJE96SLEBII54M04o43tFKG5JJi3LoV6I/Gyd1jGGKNLoEPnAN6LqeqBed
         WPPO9qQbKvXNnoM5O0hEXbIRa/W10o1ITVBoQndjvrp65Hr0z0DAFKkdjTd61h7iRYNi
         1IKQU3NnNFPGo/1pPfzoxWXvUJ8dmUC+WBaK42SBjikutKEcw02AqpNtDMLw3n7OXQPy
         RBmg==
X-Gm-Message-State: AHQUAuZ7ctjDCoSFIiIIciTPVLNVKZrdkQfarGIij8QhqYXYOvqR0zVM
        xX+GbU9pFNXdAyLFCK85wlAmed26
X-Google-Smtp-Source: AHgI3Iaf5UI/l1Agjv+zojcvrdrwm4I+raMKD0AGAWTB227ZZbIe8+YDEnFylDIYYTBbM3KzzNduPQ==
X-Received: by 2002:a63:287:: with SMTP id 129mr5832952pgc.332.1548886408857;
        Wed, 30 Jan 2019 14:13:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o84sm8970772pfi.172.2019.01.30.14.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:13:28 -0800 (PST)
Date:   Wed, 30 Jan 2019 14:13:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/68] 4.14.97-stable review
Message-ID: <20190130221327.GB26954@roeck-us.net>
References: <20190129113131.751891514@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:35:22PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.97 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 31 11:31:10 UTC 2019.
> Anything received after that time might be too late.
> 
For v4.14.96-69-g958f665be23e:

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 328 pass: 328 fail: 0

Guenter
