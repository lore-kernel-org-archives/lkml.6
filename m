Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFDFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481702086A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IxRUCDZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481702086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeKOKyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:54:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43103 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeKOKyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 05:54:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id n10-v6so8153835pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 16:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=G6K4jErTdVMwbQariIN8TE58IJz0AnJi+dq0mm+J18s=;
        b=IxRUCDZ4RUNUzSHarp7CNmBtfrpxmq3927ahN5xcL+2GOlrWlF1D9TvMlHYmzEBEFD
         W4kdeuaM19sS44wEKDk8IK2b+t0PfqZphjXM3dZ0sTMMNPLV68+2iHpJUlYOV2i3AZI3
         8FTq45iLTygvMkSuSRTklONl88c/tHrPqfREkKYJkey10VeKqoBUAQE4Eg8lqtYynrH/
         LAywAGKor5fyEB/yD0bfYc+4afcmAgeYXIgYlt24seFZ9mMEbaCD2+touLZ6dFpk2Ixc
         wUiaq8rhGk4kSNI/80ePkO7MTMI2qo/e2xl9/kuCTT/JiSRQDkvV5ixOPszjuJntmxNp
         ETuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=G6K4jErTdVMwbQariIN8TE58IJz0AnJi+dq0mm+J18s=;
        b=r9K/0otNm7esWa2ev6N8z4C89OEeIZt0fLfE10pkIoX0ya/rd+hK8g/7qsuyyIBozD
         3lM/gxinvq05E083Q5aTkqH5LJordEOAg5XcMeaEL1BdyIiQEkDmJ6SXnLZDbDj+Ibgr
         /H5C06bSerAZfz5GNfrQvSVZUXjHKsFlBSJe6oHcu2Rnvl7S8yBKjBSFmNFvycZTWbdr
         h6MAHukhbR/tj0u18lcrGbaCvNkd4z34VRJBfajrqy53x0/XPf1IMuKm7ddSnNBntDJY
         /Q/DWc7j1IsZhnHVz1484KzPoecU+gTrcSnAsxFizAnz7iHmBMHTgS5GGwgAFvW+GTmA
         0Rxg==
X-Gm-Message-State: AGRZ1gIgUh/s/jrbm9Jxr2wBNEP8zbx1VLqDPR4PswJrvw794huDYL1V
        ufrHLmJmkV1RenGKX7zB7RfVKg==
X-Google-Smtp-Source: AJdET5eHhUbu7EBCqJ882/WuPYrsEr+QNkRKnPzLx8k1qh3awWP47bjGvwEKhrtdHhcyCoqnmDJkgw==
X-Received: by 2002:a62:3501:: with SMTP id c1-v6mr4169225pfa.173.1542242923385;
        Wed, 14 Nov 2018 16:48:43 -0800 (PST)
Received: from localhost ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id m9sm17314703pgd.32.2018.11.14.16.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 16:48:42 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Wed, 14 Nov 2018 16:48:41 -0800 (PST)
To:     Sam Ravnborg <sam@ravnborg.org>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Jim Wilson <jimw@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH 0/2] modpost: skip section mismatch warnings on ELF local
 symbols by default
In-Reply-To: <20181020140835.GA3351@ravnborg.org>
Message-ID: <alpine.DEB.2.21.9999.1811141647190.22938@viisi.sifive.com>
References: <20181020131911.22443-1-paul.walmsley@sifive.com> <20181020140835.GA3351@ravnborg.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Sat, 20 Oct 2018, Sam Ravnborg wrote:

> modpost is not supposed to be used outside the kernel build.
> And therefore if we introduce a new option then the infrastructure
> to enable that option should also be in place.
> In this particular case I cannot see why we should add the possibility
> to include local symbols, in other words do not add the option.
> Wait a few days before you kill it, maybe others see the usefulness of it.

I've dropped the optionality from the patch set.

> I checked if there were any options supported by modpost that
> was not configurable in makefile.modpost.
> And I could see that the -M and -K options in getopt() was leftovers.
> The code that used these option was was dropped in:
> a8773769d1a1e08d0ca15f890515401ab3860637 ("Kbuild: clear marker out of modpost")
>
> Could you add a patch that delete these on top of what you already have.

Done.  This patch is now in the v2 set which should appear shortly.

- Paul
