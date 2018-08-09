Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D83FC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68E7217C6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utGZlsN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68E7217C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbeHIMPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:15:46 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34243 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeHIMPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:15:46 -0400
Received: by mail-ua0-f194.google.com with SMTP id r15-v6so5639477uao.1;
        Thu, 09 Aug 2018 02:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KaPBWvyNWqLv5PDiEA3pwQJ5Ud2dsAmBliw+zgUc1Rk=;
        b=utGZlsN106VojLnutwtjd1xP7DQ+WrxOgrckqOnmcWXe63p12uOZlYTYZWmcj3yqTi
         bGK+eS1+O22HcXJVpsC55PxAd/YtEkjqOECAZvoI2sYMHPzleMIu5MRRhJR7r6gR6hxH
         2LRnQv+2clYoMNHebPKUh3AosRKunFWYmnmWHllkPAmMa2qvoSlrerTiWsW4Xlm8Sjd/
         RGrJ6HEO+IacXyhHvpZaxDikxt+gozPKUTgwbp/tCTMrVue/k/avLdwnvIG6mg5k8n5a
         TL2Bg034E8SQJnj1fpugLyEAOsOZCZ3PHSNLgmYnV08WkkE4lrU4TF5PJrIi07XWnCV9
         G4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KaPBWvyNWqLv5PDiEA3pwQJ5Ud2dsAmBliw+zgUc1Rk=;
        b=ozzVUt8yqUrc/F4ajcVAFxz3lfzAe4iFJazOa8IVANxt/+5xoaZoWiEO5a4WOfpWfq
         mkdiuaDhWB02zANPi5PqG20ONmPqlQJYDBQ56QTRwDrDSNRanodOfI9mQtXgCpAy/tLf
         oRspi3+zLghqPAYFOkeUVKud0t28UnSLYGrBBN75ktt0N+ok+8snmMlyzd62fqXxNtfx
         rhsTJVr9vW4gTuxYLoAe4+e6Ya6GB1pGMdxpMCZpDx7dVK6Ro0FkeIJ+qcD88QAhGxiK
         RRLBlANZjfL3rfnwjbhzZ3Ad18q5WJ3C5w9q9GbrqOq3BcJFzaC85BNV1077+tM3neG4
         4VAQ==
X-Gm-Message-State: AOUpUlH8MEfZogwGJ2Z9tGO8kAD7fYn5+nEGv5BrkJllrrUYvw2yrTZr
        DkshnPsV6S9kCJSVi13XG23BRBlcmj4D67Yx1Lg=
X-Google-Smtp-Source: AA+uWPzUBq1TO+dk41PDlbNjoFWvoCz5eWsehNUMElLi1S3v49KsFsALVIWqAzml4vir2MEZLwQFmNU3T/Q7ooz0RDI=
X-Received: by 2002:a9f:2187:: with SMTP id 7-v6mr904377uac.49.1533808300903;
 Thu, 09 Aug 2018 02:51:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 02:51:40 -0700 (PDT)
In-Reply-To: <7d8c71b9-292e-e51e-d3d3-cb0bb00528b6@redhat.com>
References: <20180809091558.4317-1-hdegoede@redhat.com> <20180809091558.4317-2-hdegoede@redhat.com>
 <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com> <7d8c71b9-292e-e51e-d3d3-cb0bb00528b6@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Aug 2018 12:51:40 +0300
Message-ID: <CAHp75VeiC35S=urEL_f-j+ZPVodPHqGJBRYxv2m5inBkuJ=1kQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] ACPI / scan: Initialize status to ACPI_STA_DEFAULT
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 12:39 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 09-08-18 11:35, Rafael J. Wysocki wrote:
>> On Thu, Aug 9, 2018 at 11:15 AM, Hans de Goede <hdegoede@redhat.com>
>> wrote:

>> I've applied the v4 of this patch and I don't think there are any
>> changes from it here.
>
>
> Correct, there were only changes to the 4th patch in the series.
>
>> As for the rest of the series I'll wait from comments from Wolfram and
>> the other reviewers.
>
>
> Ok, note if you've taken patch 1 you may also want to take patch 3 which
> is an ACPI code cleanup made possible by patch 1 and otherwise is
> unrelated.

I'm under impression Rafael is going to take entire series (at least
for patch 4 I'm expecting to give an Ack).

-- 
With Best Regards,
Andy Shevchenko
