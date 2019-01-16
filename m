Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8196C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828C8206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tc9qzNCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfAPUiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:38:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43960 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfAPUiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:38:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so3322358pgk.10;
        Wed, 16 Jan 2019 12:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T55JJdvInoCU4aqNSI6bugV9TjeoJMBQyV0xzYAG5N0=;
        b=tc9qzNCE1dYIYkS16A6HmI7hseY/74hACIsPhZRQbB1r2HDT6SeAVuuZUG71SubtA3
         biiqxMONZMYVVtda4tfV16f1t5/zk8UF3RlxylcRROqz6gqfmx0c09PkEVS8fiZPmrIV
         3+sVKnjYJe4bV0pD4ZyeiLY/9ecM2RP8sy8bnM3Obt+50vSZ7MCnlFYxl4MB2O+1XD0Q
         PNAyWEonM9lGWvyTZVuMdP6m2mi5uswiSm/bsak1QpQRnqWwkhScQLZf0d5rh3HKadRn
         N6pUrnkx6VfaQ4Z1XT/375E3UzGPC3gzMiV+F4twgRNdBUqEakvwOgE4ZJV9EoRJ2vyl
         hL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=T55JJdvInoCU4aqNSI6bugV9TjeoJMBQyV0xzYAG5N0=;
        b=qrJfjmyQhDu/BFnyGyawynlAPHnYVj/PbIYP0rVEOgUvJMkArQwNv6Zlp8pCXXNdyz
         AHlznox62XlyCDzcH7euVhZxxeG+K8pKUopic/PLgT5dE55LAZJxbsyuKD21g5U5b7tH
         4JXEqggC+xcXfed+Wf4xQUnkDv6n9zFkSz0IrkNS4zfCxXW0lOwhPaugQTsvYjSQb08F
         pms1Ppi4SIPLVAAvRDDC3o7fGS18/XWWsq46LWON8wd9AEa187XX8a53KBYTXToRagXd
         7lF4eG+yUEb+Wgx2CzxUvSMMDD2F/smi6Wxwry9UKib/LpQQE3f7upqDlJXSJtf6edOX
         7K5g==
X-Gm-Message-State: AJcUukexYmC1k9YHm5GTbfuxHVngUQ8t1yZDTFgXBiLwf3ruqZwo0UdF
        LAuI3T5gSsACS8mPfFC8qgo=
X-Google-Smtp-Source: ALg8bN406RBGE1GnKQRPEM3BnMCUTMwDcqjx4VeXgFMpqlIifETlrZq0H592H0ZvTaQFa3M0Nj1rDw==
X-Received: by 2002:a63:2315:: with SMTP id j21mr10641979pgj.297.1547671125842;
        Wed, 16 Jan 2019 12:38:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e23sm9807562pfh.68.2019.01.16.12.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 12:38:45 -0800 (PST)
Date:   Wed, 16 Jan 2019 12:38:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/57] 4.20.3-stable review
Message-ID: <20190116203844.GE1302@roeck-us.net>
References: <20190115154910.734892368@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 05:35:41PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.3 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 17 15:48:32 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
