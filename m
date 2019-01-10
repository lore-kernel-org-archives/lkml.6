Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7246CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AE52184B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547126778;
	bh=j5qYE6P9WfSgsp0q/Ulg7FRLiqNYqxR2g7YFDQ8wRFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zfojixbWJ3osILAErNInoquelaTtRHAPcQp9jwAqtHIdS33nd9Ae0qOFlNcuCoTw/
	 ZY4CdiTAa0Azljl+4YpJv/IEO66+tQlt2YILO38ZJTo+TjX4sKIMZ+M0Y4Gzx5YqFv
	 HnceyzL/jxQgRTYGnC4uvMiYwZoF09EWy/P9wJgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfAJN0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:26:17 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:45866 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfAJN0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:26:17 -0500
Received: by mail-io1-f47.google.com with SMTP id c2so8877273iom.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 05:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j5qYE6P9WfSgsp0q/Ulg7FRLiqNYqxR2g7YFDQ8wRFM=;
        b=RJzEV8wjaFTkE9lyluOOqu2kfod8GRRvtUH/Q92nyY6BFEWk44ZquKVXQcR/MCXFl7
         sJ6Yp4K/gLKRE8XdJpQDqG9tPWdkPveRWP4dVnDmaiculUjZQWfwU1C1cW+PCVcTmKTp
         3xAvFDsOCboNAimLlo/Cado2n+dnIgSGMUihw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j5qYE6P9WfSgsp0q/Ulg7FRLiqNYqxR2g7YFDQ8wRFM=;
        b=Sasj7fR1w/i9VK8D9KSUkC/pSFFPWuzadTssIae9K8NMKlfI1pe+8mZFLuI47SUfaW
         pSKx59cPWbzkxEjOCodZbUNCtHgzvpjh+2lfm3Uamctn+A8uCj1t6TQ7uPx/vJUITGDk
         e0esY0bRbmQt8ul7cq3EkPchZFUAfdOZB6DNOa+SUxq2jgIj9+r/9yuBz+EpqYb9ZioX
         aCJwVqEam4zCtlH5tYMLFyLXWX5ffv2ILMreUmNaRPKecIE9tZn4h+hUg2YhQDpNYw3p
         MOtDveGwiWRppr0lcG3zJXPIcJwTQHgXzkV8I/ggZExweIWmN8Fr12YKUx6SEPt+Dgvi
         UsrA==
X-Gm-Message-State: AJcUukfSYQGoGPMkmFxxvPr3TxiWrFoL5V2pJRnSZC7Jz4PxrujCNG7l
        M9PTbaN03v1BddtAhcmwXhHelA==
X-Google-Smtp-Source: ALg8bN6hMFPGp0tdGeYHmnwsEvUKmOTYZf+VPzhHFW2StGxrNYheOcVqVkxZEloyIEsDclqiYOl2fw==
X-Received: by 2002:a5e:de01:: with SMTP id e1mr6640938iok.137.1547126776395;
        Thu, 10 Jan 2019 05:26:16 -0800 (PST)
Received: from pure.paranoia.local ([198.144.156.49])
        by smtp.gmail.com with ESMTPSA id q197sm8935828itb.22.2019.01.10.05.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 05:26:15 -0800 (PST)
Date:   Thu, 10 Jan 2019 08:26:13 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     pr-tracker-bot@kernel.org, torvalds@linux-foundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Message-ID: <20190110132613.GB22569@pure.paranoia.local>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20190109182955.GC30131@pure.paranoia.local>
 <20190110080203.GA13262@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110080203.GA13262@guoren-Inspiron-7460>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:02:03PM +0800, Guo Ren wrote:
> Can I take back this pull request and send a new pull request with
> https:// URLs ?

It's not necessary at this point, as the pull request has already been
processed. However, your future emails should have the public URL of the
git repository.

Best,
-K
