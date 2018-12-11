Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE76C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45D420849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544521487;
	bh=OgcC+Z1Um4qbp61khV5sMaM1sgo3tXMH2Y/q2WiMLhY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=h3SyBCLWzXlSD4H43voV28eEt/aNgpoUBFELP739vKAtRwuU7Lz4OgwUwAfV+AdIB
	 vRnG1VuUVlgbeAHWtNQGW4FXx8dKOpNpZmna9x5DhXd8Ke9gAfRZLpJ2qUtGz57lGW
	 mIaB8TQJvtkwZDlV7SPAMi6sOybuprnFkDDMXlT8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45D420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeLKJoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:44:46 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:36863 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKJoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:44:46 -0500
Received: by mail-oi1-f182.google.com with SMTP id x23so11498806oix.3;
        Tue, 11 Dec 2018 01:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgcC+Z1Um4qbp61khV5sMaM1sgo3tXMH2Y/q2WiMLhY=;
        b=idKEwt62N206P/3zQumbxjFLCLK+RlBYODr41vF4tQd6BunYu8GGgRl/J6qXkBL5X7
         l1nPoe8Mk6ucUmjGP/LJo9sJT+snnKQWuXyJTl5QZAp3hXbWD1mRYn8ZhsbP5U2ZzhT0
         5f1nOgScmAK6XUjREaZoDGeU4n0aWqS7fvwFexZ4FFcIDF6xRqOhJVyi8nZ4ff/I/lFs
         qWZkw/KFrgW7jcjBlpvVWI0WnRYK6RCGEn5E7z4AkmsUr/vptTIFkPrkii8BzpYdhDWx
         PZ9NnwyU9pr58+J9RhBWaBWNQAKaqCnV0/8mIJDsWiJHK+ilZOJPHgJFA/n2OxSWIKJL
         QWxg==
X-Gm-Message-State: AA+aEWb3zZAq73qWN/ZWgExPMskyJslmlH4eaZyt/vesaxSVRPF9Ylsx
        cUj8pUfQWzpTcxbesZ0w2KPQS1S4N8NGelLgXI4=
X-Google-Smtp-Source: AFSGD/XCFSGDvn/vBXRLKAquyw4XCs1LvbAD0EldLa+KSiInQxY2ZiwlYs4ZV5opHsl+m9qmTy8gBUax+x6S1+hRWB0=
X-Received: by 2002:aca:b642:: with SMTP id g63mr828122oif.195.1544521484258;
 Tue, 11 Dec 2018 01:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20181211010310.8551-1-keith.busch@intel.com> <20181211010310.8551-2-keith.busch@intel.com>
In-Reply-To: <20181211010310.8551-2-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Dec 2018 10:44:32 +0100
Message-ID: <CAJZ5v0iqC2CwR2nM7eF6pDcJe2Me-_fFekX=s16-1TGZ6f6gcA@mail.gmail.com>
Subject: Re: [PATCHv2 01/12] acpi: Create subtable parsing infrastructure
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 2:05 AM Keith Busch <keith.busch@intel.com> wrote:
>
> Parsing entries in an ACPI table had assumed a generic header structure
> that is most common. There is no standard ACPI header, though, so less
> common types would need custom parsers if they want go through their
> sub-table entry list.

It looks like the problem at hand is that acpi_hmat_structure is
incompatible with acpi_subtable_header because of the different layout
and field sizes.

If so, please state that clearly here.

With that, please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch.
