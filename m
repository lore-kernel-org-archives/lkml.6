Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5708EC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A23024815
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A23024815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966435AbeF0W1f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:27:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:36440 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755075AbeF0W1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:27:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 15:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,280,1526367600"; 
   d="scan'208";a="67867381"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2018 15:27:33 -0700
Message-ID: <8ced867417ef922fe2872a6aa4ba86d25363fddf.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: intel-hid: Add support for Device
 Specific Methods
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Date:   Wed, 27 Jun 2018 15:27:33 -0700
In-Reply-To: <CAHp75Vcn22DG0=TPdq+RYTErtaGFMf4POpuZyP9X78+9FrhLyA@mail.gmail.com>
References: <20180626233454.47340-1-srinivas.pandruvada@linux.intel.com>
         <CAHp75Vcn22DG0=TPdq+RYTErtaGFMf4POpuZyP9X78+9FrhLyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 01:15 +0300, Andy Shevchenko wrote:
> On Wed, Jun 27, 2018 at 2:34 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > In some of the recent platforms, it is possible that stand alone
> > methods
> > for HEBC() or other methods used in this driver may not exist. In
> > this
> > case intel-hid driver will fail to load and power button will not
> > be
> > functional.
> > 
> > It is also possible that some quirks in this driver added for some
> > platforms
> > may have same issue in loading intel-hid driver.
> > 
> > There is an update to the ACPI details for the HID event filter
> > driver.
> > In the updated specification a _DSM is added, which has separate
> > function
> > indexes for each of the previous stand alone methods.
> > 
> > This change brings in support for the _DSM and allows usage of
> > function
> > index for corresponding stand alone methods.
> > 
> > Details of Device Specific Method:
> > 
> > Intel HID Event Filter Driver _DSM UUID:
> > eeec56b3-4442-408f-a792-4edd4d758054
> > 
> > • Function index 0: Returns a buffer with a bit-field representing
> > the
> > supported function IDs.
> > 
> > Function Index  ASL Object
> > --------------------------------
> > 1               BTNL
> > 2               HDMM
> > 3               HDSM
> > 4               HDEM
> > 5               BTNS
> > 6               BTNE
> > 7               HEBC
> > 8               VGBS
> > 9               HEBC
> > 
> > One significant change is to query the supported methods
> > implemented on
> > the platform. So the previous HEBC() has two variants. HEBC v1 and
> > HEBC v2. The v2 version allowed further define which of the 5-
> > button
> > are actually defined by the platform. HEBC v2 support is only
> > available
> > via new DSM.
> > 
> > v1 Button details:
> > Bits [0] - Rotation Lock, Num Lock, Home, End, Page Up,
> > Page Down
> > Bits [1] - Wireless Radio Control
> > Bits [2] - System Power Down
> > Bits [3] - System Hibernate
> > Bits [4] - System Sleep/ System Wake
> > Bits [5] - Scan Next Track
> > Bits [6] - Scan Previous Track
> > Bits [7] - Stop
> > Bits [8] - Play/Pause
> > Bits [9] - Mute
> > Bits [10] - Volume Increment
> > Bits [11] - Volume Decrement
> > Bits [12] - Display Brightness Increment
> > Bits [13] - Display Brightness Decrement
> > Bits [14] - Lock Tablet
> > Bits [15] - Release Tablet
> > Bits [16] - Toggle Bezel
> > Bits [17] - 5 button array
> > Bits [18-31] - reserved
> > 
> > v2 Buttom details:
> > Bits [0] - Rotation Lock, Num Lock, Home, End, Page Up, Page Down
> > Bits [1] - Wireless Radio Control
> > Bits [2] - System Power Down
> > Bits [3] - System Hibernate
> > Bits [4] - System Sleep/ System Wake
> > Bits [5] - Scan Next Track
> > Bits [6] - Scan Previous Track
> > Bits [7] - Stop
> > Bits [8] - Play/Pause
> > Bits [9] - Mute
> > Bits [10] - Volume Increment
> > Bits [11] - Volume Decrement
> > Bits [12] - Display Brightness Increment
> > Bits [13] - Display Brightness Decrement
> > Bits [14] - Lock Tablet
> > Bits [15] - Release Tablet
> > Bits [16] - Toggle Bezel
> > Bits [17] - 5 button array
> > Bits [18] – Power Button
> > Bits [19] - W Home Button
> > Bits [20] - Volume Up Button
> > Bits [21] - Volume Down Button
> > Bits [22] – Rotation Lock Button
> > Bits [23-31] – reserved
> 
> It's hard to get if they have a common part.
> If so, perhaps in the latter drop the common part and replace it with
> 
> ... same as v1 ...
> 
> or alike.
 I am copying as is from spec, so that they can be matched.

> 
> 
> > +enum intel_hid_dsm_fn_codes {
> > +       INTEL_HID_DSM_FN_INVALID,
> > +       BTNL_FN_CODE,
> > +       HDMM_FN_CODE,
> > +       HDSM_FN_CODE,
> > +       HDEM_FN_CODE,
> > +       BTNS_FN_CODE,
> > +       BTNE_FN_CODE,
> > +       HEBC_V1_FN_CODE,
> > +       VGBS_FN_CODE,
> > +       HEBC_V2_FN_CODE,
> > +       HEBC_MAX_FN_CODES
> 
> For sake of consistency I would rather name it
> INTEL_HID_DSM_FN_MAX
Makes sense.

> 
> > +};
> > +static bool intel_hid_execute_method(acpi_handle handle,
> > +                                    enum intel_hid_dsm_fn_codes
> > fn_index,
> > +                                    unsigned long long arg)
> >  {
> > +       union acpi_object *obj, argv4, req;
> >         acpi_status status;
> > +       guid_t dsm_guid;
> > +       char *method_name;
> > 
> > +       if (fn_index <= INTEL_HID_DSM_FN_INVALID ||
> > +           fn_index >= HEBC_MAX_FN_CODES)
> > +               return false;
> > +
> > +       method_name = (char *)intel_hid_dsm_fn_to_method[fn_index];
> 
> Can it be const char * in the first place?
The array is const char *. But acpi_execute_simple_method expects
char*.
So either I can change the array of methods to char * or leave like
this.
Since array is not going to change, I prefer that to be const char *.

> 
> > +
> > +       if (!(intel_hid_dsm_fn_mask & fn_index))
> > +               goto skip_dsm_exec;
> > +
> > +       guid_parse(HID_EVENT_FILTER_UUID, &dsm_guid);
> 
> Perhaps we can cache this in global variable and parse only once at
> init / probe time?
OK

> 
> > +
> > +       /* All methods expects a package with one integer element
> > */
> > +       req.type = ACPI_TYPE_INTEGER;
> > +       req.integer.value = arg;
> > +
> > +       argv4.type = ACPI_TYPE_PACKAGE;
> > +       argv4.package.count = 1;
> > +       argv4.package.elements = &req;
> > +
> > +       obj = acpi_evaluate_dsm(handle, &dsm_guid, 1, fn_index,
> > &argv4);
> > +       if (obj) {
> > +               pr_debug("Exec DSM Fn code: %d[%s] success\n",
> > fn_index,
> > +                        method_name);
> 
> acpi_handle_debug() ?
OK.

> 
> > +               ACPI_FREE(obj);
> > +               return true;
> > +       }
> > +
> > +skip_dsm_exec:
> > +       status = acpi_execute_simple_method(handle, method_name,
> > arg);
> > +       if (ACPI_SUCCESS(status))
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> > +static bool intel_hid_evaluate_method(acpi_handle handle,
> > +                                     enum intel_hid_dsm_fn_codes
> > fn_index,
> > +                                     unsigned long long *result)
> > +{
> 
> Same comments as per previous function.
> 
> > +}
> > +static void intel_hid_init_dsm(acpi_handle handle)
> > +{
> 
> Ditto.
> 
> > +}
> > +
> > +static int intel_hid_set_enable(struct device *device, bool
> > enable)
> > +{
> > +
> > +       /* Enable|disable features - power button is always enabled
> > */
> > +       if (!intel_hid_execute_method(ACPI_HANDLE(device),
> > HDSM_FN_CODE,
> > +                                     enable)) {
> 
> For me the temporary variable looks slightly better.
> 
> acpi_handle handle = ACPI_HANDLE(device);
OK

> 
> 
> >                 dev_warn(device, "failed to %sable hotkeys\n",
> >                          enable ? "en" : "dis");
> >                 return -EIO;
> > @@ -129,9 +259,8 @@ static void intel_button_array_enable(struct
> > device *device, bool enable)
> >         }
> > 
> >         /* Enable|disable features - power button is always enabled
> > */
> > -       status = acpi_execute_simple_method(handle, "BTNE",
> > -                                           enable ? button_cap :
> > 1);
> > -       if (ACPI_FAILURE(status))
> > +       if (!intel_hid_execute_method(handle, BTNE_FN_CODE,
> > +                                     enable ? button_cap : 1))
> >                 dev_warn(device, "failed to set button
> > capability\n");
> >  }
> 
> 
> >         if (priv->array) {
> > +               unsigned long long results;
> > +
> 
> Seems it's not used, perhaps call it dummy instead?
> 
OK.

> >                 intel_button_array_enable(&device->dev, true);
> > 
> >                 /* Call button load method to enable HID power
> > button */
> > -               status = acpi_evaluate_object(handle, "BTNL", NULL,
> > NULL);
> > -               if (ACPI_FAILURE(status))
> > +               if (!intel_hid_evaluate_method(handle,
> > BTNL_FN_CODE,
> > +                                              &results)) {
> >                         dev_warn(&device->dev,
> >                                  "failed to enable HID power
> > button\n");
> > +               }
> >         }
> 
> 
Thanks,
Srinivas
