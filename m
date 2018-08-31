Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED07C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDD32083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XqYm1Njk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDD32083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeIACbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:31:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeIACbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wc68WdaMlE04hN3vECgN5sEUmVsEJXRkosxdzu2/8fA=; b=XqYm1NjkLvX6StmlNqi814hDi
        P+sftpobEflR2RWqIjlRIBLwvlHRzsFV+ZIwzRR9Lv8L37HPnwAGRD+QQIte+VwluY3Q4Ed54yIxj
        w5HkCL07xsb/VHA+InYfIH/ysRYkqm9j2MguOOMvVrWLcyxrNEofuCRZ0Y3hEnWr5npcSCSby25cv
        MFW9atTLPnDlwHlCW1u9QElbjyxy2aOjNdphiVSQFZ+5fLnSWW70ee+NYbiJhpaD9OJKhLJZdi3Z3
        O1Bxr8AloYELQpBS3POV5PNzRYkPC30O1/MYF6UDZnuSn+GGYdfRBasUOmSGzhcEOljJ7mBldboWY
        g3AxkS0Cg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvrnY-0000bz-LJ; Fri, 31 Aug 2018 22:21:48 +0000
Subject: Re: [PATCH] kconfig: do not require pkg-config on make {menu,n}config
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <1535708095-15847-1-git-send-email-yamada.masahiro@socionext.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <70ea8a20-fd5a-1a78-3fda-5d3b060ba389@infradead.org>
Date:   Fri, 31 Aug 2018 15:21:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535708095-15847-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 02:34 AM, Masahiro Yamada wrote:
> Meelis Roos reported a {menu,n}config regression:
> 
>  "I have libncurses devel package installed in the default system
>   location (as do 99%+ on actual developers probably) and in this
>   case, pkg-config is useless.  pkg-config is needed only when
>   libraries and headers are installed in non-default locations but
>   it is bad to require installation of pkg-config on all the machines
>   where make menuconfig would be possibly run."
> 
> For {menu,n}config, do not use pkg-config if it is not installed.
> For {g,x}config, keep checking pkg-config since we really rely on it
> for finding the installation paths of the required packages.
> 
> Fixes: 4ab3b80159d4 ("kconfig: check for pkg-config on make {menu,n,g,x}config")
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thank you.

> ---
> 
>  Documentation/process/changes.rst  |  2 +-
>  scripts/kconfig/Makefile           |  1 -
>  scripts/kconfig/check-pkgconfig.sh |  8 --------
>  scripts/kconfig/gconf-cfg.sh       |  7 +++++++
>  scripts/kconfig/mconf-cfg.sh       | 25 ++++++++++++++-----------
>  scripts/kconfig/nconf-cfg.sh       | 25 ++++++++++++++-----------
>  scripts/kconfig/qconf-cfg.sh       |  7 +++++++
>  7 files changed, 43 insertions(+), 32 deletions(-)
>  delete mode 100644 scripts/kconfig/check-pkgconfig.sh


-- 
~Randy
