Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755521AbeEANv4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:51:56 -0400
Received: from smtp-out6.electric.net ([192.162.217.192]:51242 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeEANvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:51:55 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Ard Biesheuvel'" <ard.biesheuvel@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] efi: Ignore unrealistically large option roms
Thread-Topic: [PATCH v2] efi: Ignore unrealistically large option roms
Thread-Index: AQHT3rwKtYcaxpSvw0+LtPwhOolgBqQa6Oog
Date: Tue, 1 May 2018 13:52:55 +0000
Message-ID: <96034903ca984624a5972f7bb5aea975@AcuMS.aculab.com>
References: <20180427213509.20385-1-hdegoede@redhat.com>
 <CAKv+Gu9xxSy2XXN446etRC5xaXdeOBBBYBxZZy=0bZbdZA_K8Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu9xxSy2XXN446etRC5xaXdeOBBBYBxZZy=0bZbdZA_K8Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w41Dq13M011299

From: Ard Biesheuvel
> Sent: 28 April 2018 07:41
> On 27 April 2018 at 23:35, Hans de Goede <hdegoede@redhat.com> wrote:
> > setup_efi_pci() tries to save a copy of each PCI option ROM as this may
> > be necessary for the device driver for the PCI device to have access too.
> >
> > On some systems the efi_pci_io_protocol_64's romimage and romsize fields
> > contain invalid data, which looks a bit like pointers pointing back into
> > other EFI code or data. Interpreting these pointers as romsize leads to
> > a very large value and if we then try to alloc this amount of memory to
> > save a copy the alloc call fails.
> >
> > This leads to a "Failed to alloc mem for rom" error being printed on the
> > EFI console for each PCI device.
> >
> > This commit avoids the printing of these errors, by checking romsize
> > before doing the alloc and if it is larger then 256M silently ignore the
> > ROM fields instead of trying to alloc mem and fail.
> >
> 
> The UEFI spec limits the size of option ROMs to 16 MiB, so I'd prefer
> we use that as the upper bound instead.

Copying even 16MB of rom data into physical memory on the 'off chance' that
the kernel might need it seems a waste of memory.

I can't help feeling that some kind of caching would be more appropriate.

	David
