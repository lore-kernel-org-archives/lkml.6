Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E1DC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC8E2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="AUuz7YCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC8E2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLIVZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:25:28 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43348 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLIVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:25:28 -0500
Received: by mail-io1-f67.google.com with SMTP id f10so7233142iop.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 13:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ndonyk+1VUSAM+umr79jqJfNm0olKRQxrFc2mvGA1pk=;
        b=AUuz7YCELysT0MluQWnfJjvUqQ+BL95/vzAnoZcSm/ySFtK8FavOIHZKPEXDHOIgdG
         NiQOptQWJMVogN+YS/TcV5sJutGV7WR/+vZm0tfa6We43D4G376wnST1UkUCM9UlH4fZ
         AjTerLsHEhWFcHVbUAV+J3DShdMoEzvE1eh8sBwE5QWUJjl7F6ftzTJvz+fMKUdSPKnZ
         JBhEz1JR5NbS+3txMuU7fnQqYCIK+hZUS8h9VAnHQ40yFyr7vzUzM+kr4KsTssZ8vWwu
         h9mANuL0WMy5ZUCL2hHm/Av4gqx1S3gq3IMJ5xaBuvSjQg6WdpMqn9fNLRzlP9mMcJ7x
         PPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ndonyk+1VUSAM+umr79jqJfNm0olKRQxrFc2mvGA1pk=;
        b=UvB/kDBaqpV2fbL6by2kAo0UKSAgYEa28iWTrxf3rAyN4eWVddMbrTMr8qg8f9rsMg
         fP4Wam3P0Opi45LPx/SHlmmf6Yi/dSb9zQmAaGaP7GFwlwSQumFS0E3F0va2HZJBjsQC
         o/Xro6+J49cD2RyNt/EoXnHCTAdFkUyTIgCpfOByTORh2yCojsJRiBuekHnDgal7V08j
         Kf9I+hpBzwpAKxgFYLm1g5of4HcuD1XrdXPFBxg3evJh/MMcFjo5Cin+31X0YtjAFMYc
         ZU9yq7Knv99VStQTKsgy+80ku6eDWWmlBzwQ+bVDVx14x/2WL9eFPVgB2IYlUUehqE1n
         zCVw==
X-Gm-Message-State: AA+aEWYShPjI0jx5MgwO6gsWEFW8uyOeUMrLWnJbdC+c3uwgClzgZ1Qz
        +Phe/y9hR7P9IqK6XA0/+46PNeXKLcJkpw==
X-Google-Smtp-Source: AFSGD/WVoRzXJFTUw9VX2jpkdjt927UTliGeOSu2YzmJAGHBfcMnD5qoFlItgsOcif0DncOAJfqO5w==
X-Received: by 2002:a6b:3b47:: with SMTP id i68mr7918814ioa.133.1544390726790;
        Sun, 09 Dec 2018 13:25:26 -0800 (PST)
Received: from cisco (71-218-133-134.hlrn.qwest.net. [71.218.133.134])
        by smtp.gmail.com with ESMTPSA id c68sm5066447itd.19.2018.12.09.13.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 13:25:26 -0800 (PST)
Date:   Sun, 9 Dec 2018 14:25:23 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-sparse@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] copy_{to,from}_user(): only inline when !__CHECKER__
Message-ID: <20181209212523.GE30796@cisco>
References: <20181209204449.18906-1-tycho@tycho.ws>
 <20181209210220.GB2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209210220.GB2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Sun, Dec 09, 2018 at 09:02:21PM +0000, Al Viro wrote:
> On Sun, Dec 09, 2018 at 01:44:49PM -0700, Tycho Andersen wrote:
> > While working on some additional copy_to_user() checks for sparse, I
> > noticed that sparse's current copy_to_user() checks are not triggered. This
> > is because copy_to_user() is declared as __always_inline, and sparse
> > specifically looks for a call instruction to copy_to_user() when it tries
> > to apply the checks.
> > 
> > A quick fix is to explicitly not inline when __CHECKER__ is defined, so
> > that sparse will be able to analyze all the copy_{to,from}_user calls.
> > There may be some refactoring in sparse that we can do to fix this,
> > although it's not immediately obvious to me how, hence the RFC-ness of this
> > patch.
> 
> Which sparse checks do not trigger?  Explain, please - as it is, I had been
> unable to guess what could "specifically looks for a call instruction" refer
> to.

In sparse.c there's check_call_instruction(), which is triggered when
there's an instruction of OP_CALL type in the basic block. This simply
compares against the name of the call target to determine whether or
not to call check_ctu().

I think what's happening here is that the call is getting inlined, and
so the OP_CALL goes away, and check_call_instruction() never gets
called.

Tycho
