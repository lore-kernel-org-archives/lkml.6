Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9197EC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575582086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544564959;
	bh=g3bZKrBIESL7oyXrOsvKbwjByucYBLypnBo+lO9AmxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JSgswNz2+qRWsCbU2odl2gHhnUFXnh7REdwycTkPDLfeEdZpqHfP/iouxH50MmFV/
	 /skFd7iEAWuGmQrtchud23ZgSLRS6AV6/ynIB4qRUeCIFJkt/Xs5TV/mua7G6GCzAq
	 r/RExhLdXjlBKYPL6WdUj/ekdiH/G3ONrgRNhnoM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575582086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeLKVtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:49:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44414 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKVtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:49:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id f18so15594920otl.11;
        Tue, 11 Dec 2018 13:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+jqbTXgJcnaNmwXr4mvE8v4D3fDUTKKXNhqcpfB32k=;
        b=sFU5wBZIao8xk5LHZceQNsNr4uadZPbKt21QVfKvlFIFQfWIwJL7PSMzLv33gMeX9Q
         z/t+aU1Bmr4YpkhYnY1IABUc5r7d8y4XI7zPwH3+qhT438/l8eEeZvPUTuZ6j2j4accw
         gm5Ejq3mrQwIb+LNgNQtS94go7svvppT5+OzKm+7wrdmuYQN22YObugNc6lQrEhR+VtI
         FEgD0e0lyhZxVhNbbqyTFrlzxjqgbZRwmc7lc0CrWx/3iUpv+vg+dJAnoNWlIvcLG8/Z
         MWzgWyDJImLrTlr4vIXfkW2pUe5NrxvkkNj7/JQTgV3zZeCV4cPP/axZ2KhC54MvzLbV
         IqdQ==
X-Gm-Message-State: AA+aEWZO7ZpPLt+77xC7wyj8MU8bhg8RFrMZEpCFH0TW5ACI5ayzxoUQ
        1SdVBZ7QZwd/4YKvPcQ0Mxj8Pp0GGl0tlVuw48g=
X-Google-Smtp-Source: AFSGD/VZ7S1N/46qsE9QmxUrC3ly74yF0S95wgxza2rk/cyGjquDbOhUrq+ZVeWfreeABytTt6RFl3Yvh5fJ5H2M2cM=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr11824902ota.244.1544564957226;
 Tue, 11 Dec 2018 13:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20181208214644.5374-1-okaya@kernel.org> <CAJZ5v0jV+UZ7A46Kiyv6JysoFJ=_ts7O_p3z9F1Uze3OwZdh_Q@mail.gmail.com>
 <4aa65942-bf97-c957-7f77-38bfdf7d1d3a@kernel.org>
In-Reply-To: <4aa65942-bf97-c957-7f77-38bfdf7d1d3a@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Dec 2018 22:49:05 +0100
Message-ID: <CAJZ5v0gsq4-pzMrqrKuiUysXbnjc5AfVnY3=2OxQRZPsma=ZMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: Allow PCI to be disabled for reboot
To:     okaya@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 5:54 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 12/11/2018 5:12 AM, Rafael J. Wysocki wrote:
> > On Sat, Dec 8, 2018 at 10:47 PM Sinan Kaya <okaya@kernel.org> wrote:
> >>
> >> Make PCI reboot conditional on PCI support being present on the kernel
> >> configuration.
> >>
> >> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> >
> > Same comment as for patch [2/3]: make the subject say clearly that
> > this is about CONFIG_PCI.
>
> Sure
>
> >>          case ACPI_ADR_SPACE_PCI_CONFIG:
> >> +       {
> >> +#ifdef CONFIG_PCI
> >> +               unsigned int devfn;
> >> +               struct pci_bus *bus0;
> >> +
> >>                  /* The reset register can only live on bus 0. */
> >>                  bus0 = pci_find_bus(0, 0);
> >>                  if (!bus0)
> >> @@ -45,7 +48,10 @@ void acpi_reboot(void)
> >>                  pci_bus_write_config_byte(bus0, devfn,
> >>                                  (rr->address & 0xffff), reset_value);
> >>                  break;
> >> -
> >> +#else
> >> +               return;
> >
> > Why not "break"?
> >
>
> I struggled between break and return. Existing code seems to return on failure
> when bus0 is NULL. I assumed it would be more logical to return as someone could
> put some code after here that assumes everything is in order.

Well, there's no such code ATM, so there's no practical difference
between the two and you don't really need the #else branch at all, do
you?
