Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbeFDNvq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:51:46 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38328 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbeFDNvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:51:44 -0400
X-Google-Smtp-Source: ADUXVKJwDrYHje0Gp61EPYosQCsPVB0WSaVDEAc3g0LJS5/Nng7I/jcS8mhFBciPGpHyaH9FlF+zxr+4gdipVtYLMwI=
MIME-Version: 1.0
In-Reply-To: <ea0b7233-da00-ee24-5138-9f49a63e4a5a@redhat.com>
References: <20180604123238.82200-1-chiu@endlessm.com> <ea0b7233-da00-ee24-5138-9f49a63e4a5a@redhat.com>
From: Daniel Drake <drake@endlessm.com>
Date: Mon, 4 Jun 2018 07:51:43 -0600
Message-ID: <CAD8Lp45FmOMK3B537sKfnC3STtxwspNdoRVKTyaoDnsJ3EMEtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Call new led hw_changed API
 on kbd brightness change
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chris Chiu <chiu@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 7:22 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Is this really a case of the hardware itself processing the
> keypress and then changing the brightness *itself* ?
>
> From the "[PATCH 2/2] platform/x86: asus-wmi: Add keyboard backlight
> toggle support" patch I get the impression that the driver is
> modifying the brightness from within the kernel rather then the
> keyboard controller are ACPI embeddec-controller doing it itself.
>
> If that is the case then the right fix is for the driver to stop
> mucking with the brighness itself, it should simply report the
> right keyboard events and export a led interface and then userspace
> will do the right thing (and be able to offer flexible policies
> to the user).

Before this modification, the driver reports the brightness keypresses
to userspace and then userspace can respond by changing the brightness
level, as you describe.

You are right in that the hardware doesn't change the brightness
directly itself, which is the normal usage of LED_BRIGHT_HW_CHANGED.

However this approach was suggested by Benjamin Berg and Bastien
Nocera in the thread: Re: [PATCH v2] platform/x86: asus-wmi: Add
keyboard backlight toggle support
https://marc.info/?l=linux-kernel&m=152639169210655&w=2

The issue is that we need to support a new "keyboard backlight
brightness cycle" key (in the patch that follows this one) which
doesn't fit into any definitions of keys recognised by the kernel and
likewise there's no userspace code to handle it.

If preferred we could leave the standard brightness keys behaving as
they are (input events) and make the new special key type directly
handled by the kernel?

Daniel
