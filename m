Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44179C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E2320664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fTJl7A09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E2320664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbeJ2Vb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:31:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39656 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbeJ2Vb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:31:56 -0400
Received: by mail-qk1-f196.google.com with SMTP id e4so4765798qkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFk0s9XRKuivYN0a3km/JYwlVbX+IGRYe4HQp0npcO4=;
        b=fTJl7A09qVl1M2gM59f7z/C7zU3YMuMzSfCUskm3UZNFiddVujQUyAFRVXAzNQjAJu
         zTvwPmH9S47dCPGrkcwwnUqY2MElaXg1NKhZ3M2T8Z+v86kwSYTPZ24vNTXzxhiUy7fu
         Sf+NUI/Dd1VrGbgdqFb1GY66YjMs5jQDsIjWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=sFk0s9XRKuivYN0a3km/JYwlVbX+IGRYe4HQp0npcO4=;
        b=dLvxGiHimZuI8OipjdLFm3vMcf99oPMLMzj8s3Ekc8VRHJeI33aeWr3t1mO0AoA6Zu
         F0SvW8dn1ygy+q5l4qExWrxFrHTr/SrV44RG4NXx2PokC82kzFNvD0loN/NFvzN1HeSi
         sE8tyjfSkHkoY3n+JG4Sgrk9/qxUz7OCFi18g7PUV1wV8aCg7bfvmrXc+5T/oUIsOP99
         Rpw6hUFpIhfppbyA5pRS+db2ic6oFo0hQn2z2c1ZrXcJJN61q4nckBYwroVKa7ztpUWD
         BodnBc31SK5WwxTOkZUGaC9TzJYmWhw68fZWRB+hPfjCdT9MJtvmjs4G+qO018NTMd7T
         SPJw==
X-Gm-Message-State: AGRZ1gIysxnkoOQ7xrd+1Xmqd7UlfqZ+RiERA+rurS1m77avQwUT7kZX
        iL5AAYwv9K/ToYJDBgjLwujx2h1zs7DeuhI7
X-Google-Smtp-Source: AJdET5cc3ydQfc0OXS6To3z6Dcd4vT33x1g25+B3Xj9yGhy8DaVBhfLfJDR87BSO8fdb8P23egPMVQ==
X-Received: by 2002:a37:5288:: with SMTP id g130-v6mr12498879qkb.124.1540817004182;
        Mon, 29 Oct 2018 05:43:24 -0700 (PDT)
Received: from pure.paranoia.local ([185.232.22.59])
        by smtp.gmail.com with ESMTPSA id h187sm12215728qke.46.2018.10.29.05.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 05:43:23 -0700 (PDT)
Date:   Mon, 29 Oct 2018 08:43:20 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, linux_dti@icloud.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        webmaster@kernel.org
Subject: Re: [sysadmin] Re: linux-next: Tree for Oct 29
Message-ID: <20181029124320.GA9047@pure.paranoia.local>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux_dti@icloud.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        webmaster@kernel.org
References: <20181029170212.4a34959f@canb.auug.org.au>
 <20181029063319.GC8104@Ubuntu-DTI>
 <20181029204142.7dbce8d8@canb.auug.org.au>
 <20181029114225.GA2395@zrhn9910b>
 <20181029230841.1d9625ce@canb.auug.org.au>
 <CAMuHMdXM+Zcx_CnwPZyvz7JUD+r1eQ-MFv43kKAg1_cNMhLzvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXM+Zcx_CnwPZyvz7JUD+r1eQ-MFv43kKAg1_cNMhLzvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 01:16:59PM +0100, Geert Uytterhoeven wrote:
> I can confirm syd.git.kernel.org and ord.git.kernel.org have it, but
> fra.git.kernel.org (my default) hasn't.

The Frankfurt frontend lost the VPN connection to our main infra. I'm
checking why the alerts for that didn't fire properly, but for now it's
at least back to properly replicating.

-K
