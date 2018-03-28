Return-Path: <tqnguyen@apm.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522230820; cv=none;
        d=google.com; s=arc-20160816;
        b=W6uX/iizXfWPd47dW7nXt4UemMMdLSkskyl2Mt4xK8nEILIpjycTI2zH5zNTnJBeNR
         E+jCObfdJhWMmu7+jdVQfCnVHmTLBGP4d+Lppq+Ryj6LKeos4k6YWz4BHgd3MGaAieOw
         8qrsCbMx0E+pkyx1DMQDKwp5mIu0oUWkykzSs97dGS8fWAPhTRZG1uUOur3LwDTZRbc+
         GKL0XF7yOR4Qr1olFQj4gAUSUOwd9Gm0P4AkQK6pYICeq2GhKK7vmWp31DZzYFrqe2aw
         Mva96f++QlNG5MDrkf6fntMMrPQgtpbRrTv4s7t53hOlH9Fcplg24gXFHI3bjUjgS/RA
         VRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=wm4QRpnqQHJhYXlczEPb9uimCFjqWlZcYHDynyiYIBY=;
        b=kzAIrE9hQTOCCuNBHusqAJNVW39X5a2U3GGWaAr/GcfBDxKKSvNZ4XBGPdwuNSkNOY
         SmXZrckYpLHkH4iMGB780E7umSzp4eMNox2eo5512HE/8x0bWJhaHsTad0qHdZwUWv0n
         j+nbWS4YzX1NI5U6vBYgHFGBb7HLJr5KaIVIxq2rD7yovNkV+ptWTDA9ZgBqq9Z/UQGp
         ZO4VBNlYMnKL3oqh26D18nxy7aUyba9S1/O6yUZ4jiXGtZemNxGsTs61GqLlnVAym+ut
         nnrYnL0RalAXbFAWJk3HWeuAZI9WO1k1JcVtPyLGXYUAwjYu/P3hDSDFdi4qHv0226P9
         Z1lg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@apm.com header.s=apm header.b=AODWOOXz;
       spf=pass (google.com: domain of tqnguyen@apm.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tqnguyen@apm.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=apm.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@apm.com header.s=apm header.b=AODWOOXz;
       spf=pass (google.com: domain of tqnguyen@apm.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tqnguyen@apm.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=apm.com
X-Google-Smtp-Source: AIpwx4/ajF5ZQurjBieFTvhcSGe8W9odAP6Cr4aA4ln+nM5XTunuSDus9AUWd94FRDg7cUOPWeV9/YksfZp5BLIosuY=
MIME-Version: 1.0
In-Reply-To: <CAKrQpStN6+UEp_CHdg3nSu7bAGPZ7N7VO_v0Srhc_Pe1ZLmEZg@mail.gmail.com>
References: <1517221474-19627-1-git-send-email-tqnguyen@apm.com> <CAKrQpStN6+UEp_CHdg3nSu7bAGPZ7N7VO_v0Srhc_Pe1ZLmEZg@mail.gmail.com>
From: "Thang Q. Nguyen" <tqnguyen@apm.com>
Date: Wed, 28 Mar 2018 16:53:39 +0700
Message-ID: <CAKrQpSuET_Uv9cqt0+OGkhOz11KYnTs4B7nkcC0Hh995ynmZ+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] usb: xhci: do not create and register shared_hcd
 when USB3.0 is disabled
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, Loc Ho <lho@apm.com>,
	Tung Nguyen <tunguyen@apm.com>, patches <patches@apm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590922041226886492?=
X-GMAIL-MSGID: =?utf-8?q?1596174705064279727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 5:22 PM, Thang Q. Nguyen <tqnguyen@apm.com> wrote:
> On Mon, Jan 29, 2018 at 5:24 PM, Thang Q. Nguyen <tqnguyen@apm.com> wrote:
>> From: Tung Nguyen <tunguyen@apm.com>
>>
>> Currently, hcd->shared_hcd always creates and registers to the usb-core.
>> If, for some reasons, USB3 downstream port is disabled, no roothub port for
>> USB3.0 is found. This causes kernel to display an error:
>> hub 2-0:1.0: config failed, hub doesn't have any ports! (err -19)
>> This patch checks and registers shared_hcd if USB3.0 downstream
>> port is available.
>>
>> Signed-off-by: Tung Nguyen <tunguyen@apm.com>
>> ---
>>  drivers/usb/host/xhci-plat.c |  9 ++++++---
>>  drivers/usb/host/xhci.c      | 13 +++++++++++++
>>  2 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>> index 6f03830..bdb3975 100644
>> --- a/drivers/usb/host/xhci-plat.c
>> +++ b/drivers/usb/host/xhci-plat.c
>> @@ -293,9 +293,12 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>         if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
>>                 xhci->shared_hcd->can_do_streams = 1;
>>
>> -       ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
>> -       if (ret)
>> -               goto dealloc_usb2_hcd;
>> +       /* Just add the shared_hcd when USB3.0 downstream port is available */
>> +       if (xhci->num_usb3_ports > 0) {
>> +               ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
>> +               if (ret)
>> +                       goto dealloc_usb2_hcd;
>> +       }
>>
>>         device_enable_async_suspend(&pdev->dev);
>>         pm_runtime_put_noidle(&pdev->dev);
>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>> index 1eeb339..9d3b1ab 100644
>> --- a/drivers/usb/host/xhci.c
>> +++ b/drivers/usb/host/xhci.c
>> @@ -611,6 +611,19 @@ int xhci_run(struct usb_hcd *hcd)
>>                 if (ret)
>>                         xhci_free_command(xhci, command);
>>         }
>> +       /*
>> +        * In case that the USB3.0 downstream port is not available
>> +        * No one triggers to start the xHC which should be done
>> +        * before finishing xhci_run
>> +        */
>> +       if (xhci->num_usb3_ports == 0) {
>> +               if (xhci_start(xhci)) {
>> +                       xhci_halt(xhci);
>> +                       return -ENODEV;
>> +               }
>> +               xhci->cmd_ring_state = CMD_RING_STATE_RUNNING;
>> +       }
>> +
>>         xhci_dbg_trace(xhci, trace_xhci_dbg_init,
>>                         "Finished xhci_run for USB2 roothub");
>>
>> --
>> 1.8.3.1
>>
> Hi,
> Do you have any comment on the patch?
Hi,
Do you have any comment on the patch?
