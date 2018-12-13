Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC12C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730BF20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLR5UjGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730BF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeLMFp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:45:26 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37419 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLMFpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:45:25 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so2110559iti.2;
        Wed, 12 Dec 2018 21:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XE5E2YurINBhMtxMz+BnanOhge/4PJwFRU6tmwEhWZc=;
        b=dLR5UjGYkqtwiM9HGQZtnMbRgk36M10hbKxPdlH+a9bqjYvIqVwrnhsbM6CE2wX6tJ
         rEsMocBHAUw0lP7ervlVIFrPvzAufOjyJnbVuHsu+P6ePmlWbN/n2FA3OfPG7fBsD0kv
         5RvOxaCHE/G4fTgBQ5sSSKjoNsGr1yPYVelIUen/sE8r1pg8/+lKoqtZdO6Btw8uOi62
         v+9Nb800Hi9Y+zV3ujDot2gt90SpEODJOoDDN6Cz8NN+ptJmaQmIMFeJd1CEeCRLj84c
         pkUJTKZSRMA3lqctp+dCuewA0MVIryl5gqcZHVJgaEGiqL2tbamCgQhCILywyaKSeLq2
         nMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XE5E2YurINBhMtxMz+BnanOhge/4PJwFRU6tmwEhWZc=;
        b=B7S1MOo12NySjquKh7ZpFH5s1wCR86vKzdXH88fUvA9ax2FbUhFXdGznol01Y70yXE
         KHwOfElBVwsF06RuPXIh8LZK3p2UmvHvs0iL5SRmMfjF07t3mTOinR39NJ8YGle1++3m
         +30QGWnDwNLeFV/33Po3bIzCSA21/R6cVZnDm6puC24K2r4+RcyQGRDtN4YCjxAEwzLH
         J7sIJK9tQ3HLvTlVgzdBCvyUyLh9uqtuKwbN9xT/3yrCAExui5aWziV9XYCKDshYmz7t
         2U+TgYsyco7ZpCTAQFU7KEme3W4bYfZ5WQq4bFEliEUQqJzGVB/Dv4Zs/C3JEsdYX3mp
         goDg==
X-Gm-Message-State: AA+aEWYB/tV2I8dluAk5z02LfV4a0Cu/Jh6B4WN0H4smsvvHF4oCaHYu
        nTJYl7tyU3JXpEBNzxcaVoU=
X-Google-Smtp-Source: AFSGD/VKmDJCMhcVwShnsC6DryASby4aUR9vqZyeVMC8he4gwpDwloAGJx8YLQFvClhkQHTGNZMf3Q==
X-Received: by 2002:a05:660c:14f:: with SMTP id r15mr8033848itk.20.1544679924642;
        Wed, 12 Dec 2018 21:45:24 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:6dde])
        by smtp.gmail.com with ESMTPSA id f10sm679114itf.41.2018.12.12.21.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 21:45:23 -0800 (PST)
Date:   Wed, 12 Dec 2018 21:45:21 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>, daniel@iogearbox.net,
        ast@kernel.org, netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next: Signed-off-by missing for commits in the bpf-next
 tree
Message-ID: <20181213054519.nhdcqisombemwnh7@ast-mbp.dhcp.thefacebook.com>
References: <20181212205253.d3reuxcyjhnwh3ul@ast-mbp.dhcp.thefacebook.com>
 <20181213094820.62d26354@canb.auug.org.au>
 <20181212233909.hhf5q4vpi3mmi37u@ast-mbp.dhcp.thefacebook.com>
 <20181212.164526.189502766995329983.davem@davemloft.net>
 <20181213043339.znj2674c2povyl2n@ast-mbp.dhcp.thefacebook.com>
 <20181213163728.037ac535@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213163728.037ac535@canb.auug.org.au>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 04:37:28PM +1100, Stephen Rothwell wrote:
> Hi Alexei,
> 
> On Wed, 12 Dec 2018 20:33:41 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > If Stephen's scripts can recognize SOB anywhere in the log then
> > --signoff can theoretically solve it.
> 
> My script just grabs all the Signed-off-by lines in the commit message.
> 
> > Unfortunately it's "Incompatible with the --interactive option"
> > So we have to do things manually
> > or fix scripts
> > or fix git.
> 
> My version (2.19.1 and 2.20.0) of git does not say it is incompatible
> with --interactive, so maybe the last is true :-)  It says:

Awesome! While 2.17.1 failed, 2.20.0 worked!

