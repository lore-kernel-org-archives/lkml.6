Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A5CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAE020811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544648833;
	bh=lhuelJyiJO3gOK+X9u7cHU9gKBJk+gsGEuvxIHGR8mA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0pS6d6uKOrZ5xzQE9TabyUQ+VvGgMItumywk+MwTSvodhYtfP4MrWMJSB/K2UHIHl
	 nZFTQoOvQAFsSiNii0BkfvNCvCtAZPARnyzqsYj1J25mDNJmq/BuPCVQ8Vic6gMIVW
	 8kRgqqSIdC3qN8lpkrB7NlEIi7w7Gw/TBay/Eoy8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAE020811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeLLVHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:07:12 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39603 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLLVHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:07:12 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so16252308oia.6;
        Wed, 12 Dec 2018 13:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PIBF0E3FLHFvGHXC432wzO9boZ5X9jAQg8VhfrHE0JI=;
        b=s1Qjo6KqSe+MuORHFFAPM9rx/fiCn9cp/8OSrWspVK3l5UNKMivhD896paoEvbZrV9
         dh12Yzn2+2XZmp19GuXZcXWUXQMPtTuVcPRnpiRir/+j8+lnIb4C6ka02qswp2b/GCE/
         wHkFttz/9qm+VkqdhEljca5dQrgK4L8Zr2X4XkX6X7z8m4utTsut8F6qvmFaKRWyjhBb
         nRFJuLEFV75TGOvEEsKSJP2/LULrNQLdilQy1tyN5bP8/x7IQHgq0lcuENNEI2n9OooW
         kipivuJOEKqanpNAok4jv+oiZlxXmv1ZFDU657AkiwRrri99uUaTcXYFtDeAiSfPgkBu
         KNXQ==
X-Gm-Message-State: AA+aEWa+KnTnDQ82JUnjRSrZvBA+Om0lZMQarjhiRZWqfbjoRPXvPywR
        hwSIpGBlDmbhPS25msSmUYb9WrRc9PNcwLc7Zok=
X-Google-Smtp-Source: AFSGD/WP+VdeTj9DDVleTsNV2EPOLcfU38/m1awZqN+z55yoHHuQWkXVeX9DAqGS2llk+89QmWxZGPpOHrv/VipCM/M=
X-Received: by 2002:aca:a698:: with SMTP id t24mr333067oij.76.1544648830940;
 Wed, 12 Dec 2018 13:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20181212171941.7437-1-okaya@kernel.org> <20181212171941.7437-6-okaya@kernel.org>
 <CF6A88132359CE47947DB4C6E1709ED53C556B2C@ORSMSX122.amr.corp.intel.com> <39dc076f-1b3d-ad0c-c4bb-056ac589f361@kernel.org>
In-Reply-To: <39dc076f-1b3d-ad0c-c4bb-056ac589f361@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Dec 2018 22:06:58 +0100
Message-ID: <CAJZ5v0iN+OkN0+wy=jGA33Uz+wQT7=zxF-TX3e-TrHDnr4=YRA@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
To:     okaya@kernel.org, "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, devel@acpica.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 8:34 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 12/12/2018 2:02 PM, Schmauss, Erik wrote:
> >> ++ b/drivers/acpi/acpica/achware.h
> >> @@ -109,8 +109,17 @@ acpi_hw_enable_runtime_gpe_block(struct
> >> acpi_gpe_xrupt_info *gpe_xrupt_info,
> > CONFIG_PCI is a Linux-ism. We should stay with the OS-independent nature of
> > ACPICA. Please use ACPI_PCI_CONFIGURED and put it above the comment like so:
> >
> > #ifdef ACPI_PCI_CONFIGURED
>
> Thanks for the feedback. My search for ACPI_PCI_CONFIGURED returned nothing.
>
> git grep ACPI_PCI_CONFIGURED
>
> @Rafael,
>
> How do you want to handle this?

I think what Eric suggested is effectively to introduce a new ACPICA
symbol.  Erik?
