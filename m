Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FC7ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D782083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp+5OJ0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D782083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeINUFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:05:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37514 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINUFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:05:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id h69-v6so4425568pfd.4;
        Fri, 14 Sep 2018 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GM0zwwQhQHEpCY67QD+OU/qWTBW46w5+ur5dot5GzYM=;
        b=jp+5OJ0wTJCI9VPyoGp+J9FiZrCG8O/f+w2RcFryvWrpYHubMuTf0GHkXjMci3/Sbd
         2Zr6d35h6BR+3mJ27kO6nmqugYOnj50NhaT95AWiwBSGVDQheSAQlyaCZWelGlqVpCha
         xOs2HSuAriHzmLJV1cWgyiNIkknVY8kLE2kmmzY/wX9atE+RMwV60S8LSFHkUSHoOVsl
         uDIS66zqMPrByUtWXg0IjEfpAto9NP3B5JBiLSplK5h/DFbU/e4Ja2IfPATPkU0/6gpU
         zDTa3xxu4zt5l/fKReSvTLoiTGKNu4Gj/lldIO35y639bCNBgDTDU3tYYLjH8N4QF42y
         aSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GM0zwwQhQHEpCY67QD+OU/qWTBW46w5+ur5dot5GzYM=;
        b=N6TJ55Cll+9mncr5tVpGukhskMl9ZnpSMU+vsOOiG4VtZZcRDdAtQR8SFervunEce4
         GA6kbP9BAsNzs5gpTwaldeGjk4YA/CFZEcjiy/e+hoGWxddKLdOlo3fNHJmxuvNv0QXk
         WgMeokgsU+7NfwJTo0Gp6dW+EdwJ8xnwvKWEfMVqJnERbYI9kFaRZMWtdq1tcyG6cAhZ
         qn9ftqNL5CUZzgji9v1sd2Oqfwl392lSMjHuDX2YFXf9WxqF8aCY3MTM6mFzt/fcaM8Y
         hLZB6gXrDVZWgD7e/FPxRSBjrkTPW7ZZgyng03AFWP3tulnQyW/bna/UdEo0as1EP5Ru
         80EQ==
X-Gm-Message-State: APzg51B8rw4BsRztH1PIgZfT82hL4A+t96tDiJtacfiIEQg/C50qusfL
        Oj89uqym2RaJo5ssAN5bjc0=
X-Google-Smtp-Source: ANB0VdZPL3WzrumkIJfRuYFjPXkkgu74d6OMwOv2hkKkuzukKQ9KWeKIuTdcotWjkN0WjKf8dYgCIA==
X-Received: by 2002:a63:5c5d:: with SMTP id n29-v6mr12402223pgm.253.1536936656303;
        Fri, 14 Sep 2018 07:50:56 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h85-v6sm11627440pfk.71.2018.09.14.07.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:50:55 -0700 (PDT)
Date:   Fri, 14 Sep 2018 07:50:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/197] 4.18.8-stable review
Message-ID: <20180914145054.GA19514@roeck-us.net>
References: <20180913131841.568116777@linuxfoundation.org>
 <20180914144848.GA19364@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914144848.GA19364@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 07:48:48AM -0700, Guenter Roeck wrote:
> On Thu, Sep 13, 2018 at 03:29:09PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.8 release.
> > There are 197 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Sep 15 13:17:57 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 139 pass: 139 fail: 0
> Qemu test results:
> 	total: 221 pass: 221 fail: 0
> 
No wait that was 3.18. Here are the results for 4.18:

Build results:
	total: 137 pass: 137 fail: 0
Qemu test results:
	total: 318 pass: 318 fail: 0

Sorry for the confusion.

Guenter
