Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ECFC46466
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC04120831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loksYP4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC04120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeKUHK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:10:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43000 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUHK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:10:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id x21-v6so1981257pln.9;
        Tue, 20 Nov 2018 12:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4StMWijwP7IYyXQ0zz69zX8YEL8XtIhhvi2PpUPdR20=;
        b=loksYP4RHl/lKf7s8fmd0c4uwdyKWzWzuTs7G7xrwXS9jyLCO1kanmEfqQrQ6er/rc
         Gxmj37IXL38Y8abOvrTgf9HENdO1H+89dCtgJIPGyHxkEkcbBt8ruK9XBATxdlWTszU4
         4FbbGDbsG5HsinVbpQT5KT4iFLS8pPitIjM9LomJghUolPCo5NMoXmBo1nWaaC4X1y9z
         ynvv3rlob7AM0wXNifORCFTuBdb3OK8o6D0K355XpcvEn2vu/Swsr/w6rVRjTClCI11b
         QKd8VaHRo441OARSKrmAKS64aZ2kzPWMtsdWNsoM9m0YxsDOwyHIJDsWe9t32fmigOx1
         NS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4StMWijwP7IYyXQ0zz69zX8YEL8XtIhhvi2PpUPdR20=;
        b=CiaugwBht/t7xnD1M/8BOOONlrDgbNvr1DBtneGBhizgTMjU6Zpk6PPHobAWSat6Ty
         FYlMrj4GvXailvgNu+uF2AaRqgCmNECbhdffwZVCYyd48xXnAX+y9/23RZ+Tag70shaG
         z0VQtcrDK51GsRpaKqHG/Tn7rhTfgHi5cM37tWhXzV334a6OrDNJ1SNGzZZ3cPa+Lf1w
         CuMb734TY7bQd8hMeC6Hm50QD1RRLjGr1XgcqPepP+f05NDYIEMZ731XPXUYe8XXeppG
         iXPzG37QJQVzwoTzUEoKmndRI4bfh832c46dU1JqlTzl/VCOoyINyu9wPhVpw7XmGww2
         +3cQ==
X-Gm-Message-State: AA+aEWZ2Is9AvfdzAVqnMLalfqqWU+F/AcfxsznqU/NG2aOVdAoCoy+e
        V45GWC/JnAFoUam0TFImO6g=
X-Google-Smtp-Source: AFSGD/XgvO21ZR/teCJy3mCKiYd2rV0l4w6ajtxCll0Uh8H4R4x89jeY0xfmaKSsXTbEReeNtCLPhg==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr3829407pll.280.1542746366941;
        Tue, 20 Nov 2018 12:39:26 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p62-v6sm51647030pfp.111.2018.11.20.12.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 12:39:26 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:39:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/83] 4.9.138-stable review
Message-ID: <20181120203925.GC19385@roeck-us.net>
References: <20181119162612.046511542@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:28:26PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.138 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 21 16:25:13 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 283 pass: 283 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
