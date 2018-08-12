Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2BBC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AE1219E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AE1219E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeHLMUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 08:20:55 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38437 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbeHLMUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 08:20:55 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so22652779oie.5;
        Sun, 12 Aug 2018 02:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTpRevrKC/CmYKYo6NUngpdJOaN8ON9k05udvKg0ttM=;
        b=ghlUrnf+YDqrKs9j8K53t6ai/sn8ZjdnaSHmScAevm9Mc1yraTubPejibJRHL8PZC6
         z1cSilB/vBR+TuZCK+06HZtWT+x0FOQ5A68uWRkapQAiM6fG1521KdOcEl6j5+trvPZG
         ctgp3xXAmY5xZ2/7EbRT+6ulMuZEKNpwZylXmiiQeDfO2668EJEBwHfoFa/eYcsmKV+V
         1y06nKiX4NUSPqCyaPin61xkngnorX2HtsoRfgVk29skrT8mGy7YD/eXmZgJFoh+XuTN
         CBQjbYGErojO7UQmAo8TlEOBgStJlYovek1Go92mg2Egvzk1e65gHFnnRjhDrpbTCRtm
         AM1w==
X-Gm-Message-State: AOUpUlH4hu8EEZZkLz3v2tUa3I78ayTUX40sNn4hepBh52lfHnAya+lE
        f9I1TfGWpVU7Y/yfUSz0BXp1ZW3pePVXywupnKY=
X-Google-Smtp-Source: AA+uWPyMobLc1l2mkrxPzxOs+vNIpYmJbCM7XfJh1wdIV4JwaLU/Q9CqIU2rh2Ud/TXCM7R3JkczFgQyo/sBgKKT55o=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr12364769oia.154.1534067009024;
 Sun, 12 Aug 2018 02:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180811043547.560-1-gengdongjiu@huawei.com>
In-Reply-To: <20180811043547.560-1-gengdongjiu@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 12 Aug 2018 11:43:17 +0200
Message-ID: <CAJZ5v0j=2-h8YggK8w6qjn9qKrDX8jAJ87Axox8LBdnn95Xkvg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] arm64: clean the additional checks before
 calling ghes_notify_sea()
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@suse.de>, Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>, baicar.tyler@gmail.com,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Tyler Baicar <tbaicar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 6:36 AM Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> In order to remove the additional check before calling the
> ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.
>
> After this cleanup, we can simply call the ghes_notify_sea() to let
> APEI driver handle the SEA notification.
>
> CC: Tyler Baicar <tbaicar@codeaurora.org>
> CC: James Morse <james.morse@arm.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
> ---
> This cleanup is ever mentioned by Mark Rutland in [1]
>
> [1]:
> https://lkml.org/lkml/2018/5/31/289
>
> change since v2:
> 1. Add 'Reviewed-by' of Tyler

I have applied the v2 already.

Thanks!
