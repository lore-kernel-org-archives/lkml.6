Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D561CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1422083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1422083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeIFNk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:40:28 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35639 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeIFNk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:40:27 -0400
Received: by mail-oi0-f65.google.com with SMTP id m11-v6so19162883oic.2;
        Thu, 06 Sep 2018 02:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V70Q4ZLLcaibRVB7EYsFSnYCRxkAB7V7OnzE3w66NZ4=;
        b=azQKpzWMB/c+zGAUrr1ysy0DoOd67Lz6tS8gmNnLIOCMall8qnnmxqzmEhg3pz1a2s
         ZYZtQSGTVe/qwkcaa71qGgnf+HvA4aGU62s8PhkteYX14VLf8colEwOS0nwOtg9nwTTX
         +Pt48jgsnP9BAcw/IGOakyFEuU2iCTX/RYfCNoHxaw3G4AaczurNneMticYbJLPP+/dm
         sA7QSJqIGYNbZJVoTQyCzULQM0Vij0YhNJV6jDumRsfsCMsknlr1AINsc54apcO7acuG
         ghKuckb7KclNsUNoxCU3cMFCr4koob8uUq9nYJzQHFDG1avMrs0fx6k8Bp+dL4RElvxz
         7Utg==
X-Gm-Message-State: APzg51B7oFB8/ZE3Loy+Gq0FdpHl55MLl+IwZFzvGxftkgVFHcRFCRpL
        b/rcgEfvVTyZsOQ2ntamGfNYS5ftbL/SIxDn83Y=
X-Google-Smtp-Source: ANB0VdZGoaLAblg4BOQtXYWiEtzoFm34bhRX3ppE+VG7vZCGo1VhEO+N1fN4DqSSW84lqBTspkN3jHlKNA4DcB98InE=
X-Received: by 2002:aca:b844:: with SMTP id i65-v6mr1941082oif.177.1536224759848;
 Thu, 06 Sep 2018 02:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <1533875532-24954-1-git-send-email-okaya@kernel.org> <20180905212028.GS107892@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180905212028.GS107892@bhelgaas-glaptop.roam.corp.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Sep 2018 11:05:48 +0200
Message-ID: <CAJZ5v0jA5ibsHseygjOrG_Azw_Xj7y0=TAMks7x-i-yT4+E9QQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI/ACPI: correct error message for ASPM disabling
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     okaya@kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 11:20 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Aug 10, 2018 at 04:32:11AM +0000, Sinan Kaya wrote:
> > If _OSC execution fails today for platforms without an _OSC
> > entry, code is printing a misleading message saying disabling
> > ASPM as follows:
> >
> > acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> >
> > We need to ensure that platform supports ASPM to begin with.
> >
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > Reported-by: Michael Kelley <mikelley@microsoft.com>
>
> Tentatively applied both to pci/aspm for v4.20, thanks!
>
> Rafael, let me know if you object or would rather put these through your tree.

I have no problems with these and they can go in via the PCI tree as
far as I'm concerned.

Thanks,
Rafael
