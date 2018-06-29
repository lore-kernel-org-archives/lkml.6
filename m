Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3AAC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0685827B65
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0685827B65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755476AbeF2SlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:41:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:44085 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752683AbeF2SlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:41:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 11:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,286,1526367600"; 
   d="scan'208";a="212243038"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.83.49])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2018 11:41:15 -0700
Message-ID: <95b3748fcb911c7305bd2bbcfd4e368f044f8b14.camel@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Mario.Limonciello@dell.com, alex.hung@canonical.com,
        dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Date:   Fri, 29 Jun 2018 11:41:15 -0700
In-Reply-To: <74ac9bf130074e0a8f86a7904783d091@ausx13mpc120.AMER.DELL.COM>
References: <20180628181906.54910-1-srinivas.pandruvada@linux.intel.com>
         <74ac9bf130074e0a8f86a7904783d091@ausx13mpc120.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 16:44 +0000, Mario.Limonciello@dell.com wrote:
> > 

[...]

> I verified this on XPS 9370 FW 1.3.2 (which contains this alternate
> HEBC interface).
> Power button works again for wakeup from s2idle.
> 
> Tested-by: Mario Limonciello <mario.limonciello@dell.com>
> 
So there are some customers who will have issue with power button
without this patch, so it should be also marked for stable also.
Also this may be a candidate for 4.18-rcX.

Thanks,
Srinivas

> > ---
> > Accidently sent the patch without change of version, so please
> > ignore
> > the previous one sent today.
> > v2:
> > 	Minor changes suggested by Andy
> > 
> >  drivers/platform/x86/intel-hid.c | 178
> > ++++++++++++++++++++++++++++++++++----
> > -
> >  1 file changed, 157 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/intel-hid.c
> > b/drivers/platform/x86/intel-hid.c
> > index b5adba227783..6cf9b7fa5bf0 100644
> > --- a/drivers/platform/x86/intel-hid.c
> > +++ b/drivers/platform/x86/intel-hid.c
> > @@ -96,13 +96,140 @@ struct intel_hid_priv {
> >  	bool wakeup_mode;
> >  };
> > 
> > -static int intel_hid_set_enable(struct device *device, bool
> > enable)
> > +#define HID_EVENT_FILTER_UUID	"eeec56b3-4442-408f-a792-
> > 4edd4d758054"
> > +
> > +enum intel_hid_dsm_fn_codes {
> > +	INTEL_HID_DSM_FN_INVALID,
> > +	INTEL_HID_DSM_BTNL_FN,
> > +	INTEL_HID_DSM_HDMM_FN,
> > +	INTEL_HID_DSM_HDSM_FN,
> > +	INTEL_HID_DSM_HDEM_FN,
> > +	INTEL_HID_DSM_BTNS_FN,
> > +	INTEL_HID_DSM_BTNE_FN,
> > +	INTEL_HID_DSM_HEBC_V1_FN,
> > +	INTEL_HID_DSM_VGBS_FN,
> > +	INTEL_HID_DSM_HEBC_V2_FN,
> > +	INTEL_HID_DSM_FN_MAX
> > +};
> > +
> > +static const char
> > *intel_hid_dsm_fn_to_method[INTEL_HID_DSM_FN_MAX] = {
> > +	NULL,
> > +	"BTNL",
> > +	"HDMM",
> > +	"HDSM",
> > +	"HDEM",
> > +	"BTNS",
> > +	"BTNE",
> > +	"HEBC",
> > +	"VGBS",
> > +	"HEBC"
> > +};
> > +
> > +static unsigned long long intel_hid_dsm_fn_mask;
> > +static guid_t intel_dsm_guid;
> > +
> > +static bool intel_hid_execute_method(acpi_handle handle,
> > +				     enum intel_hid_dsm_fn_codes
> > fn_index,
> > +				     unsigned long long arg)
> >  {
> > +	union acpi_object *obj, argv4, req;
> >  	acpi_status status;
> > +	char *method_name;
> > 
> > -	status = acpi_execute_simple_method(ACPI_HANDLE(device),
> > "HDSM",
> > -					    enable);
> > -	if (ACPI_FAILURE(status)) {
> > +	if (fn_index <= INTEL_HID_DSM_FN_INVALID ||
> > +	    fn_index >= INTEL_HID_DSM_FN_MAX)
> > +		return false;
> > +
> > +	method_name = (char
> > *)intel_hid_dsm_fn_to_method[fn_index];
> > +
> > +	if (!(intel_hid_dsm_fn_mask & fn_index))
> > +		goto skip_dsm_exec;
> > +
> > +	/* All methods expects a package with one integer element
> > */
> > +	req.type = ACPI_TYPE_INTEGER;
> > +	req.integer.value = arg;
> > +
> > +	argv4.type = ACPI_TYPE_PACKAGE;
> > +	argv4.package.count = 1;
> > +	argv4.package.elements = &req;
> > +
> > +	obj = acpi_evaluate_dsm(handle, &intel_dsm_guid, 1,
> > fn_index, &argv4);
> > +	if (obj) {
> > +		acpi_handle_debug(handle, "Exec DSM Fn code:
> > %d[%s]
> > success\n",
> > +				  fn_index, method_name);
> > +		ACPI_FREE(obj);
> > +		return true;
> > +	}
> > +
> > +skip_dsm_exec:
> > +	status = acpi_execute_simple_method(handle, method_name,
> > arg);
> > +	if (ACPI_SUCCESS(status))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static bool intel_hid_evaluate_method(acpi_handle handle,
> > +				      enum intel_hid_dsm_fn_codes
> > fn_index,
> > +				      unsigned long long *result)
> > +{
> > +	union acpi_object *obj;
> > +	acpi_status status;
> > +	char *method_name;
> > +
> > +	if (fn_index <= INTEL_HID_DSM_FN_INVALID ||
> > +	    fn_index >= INTEL_HID_DSM_FN_MAX)
> > +		return false;
> > +
> > +	method_name = (char
> > *)intel_hid_dsm_fn_to_method[fn_index];
> > +
> > +	if (!(intel_hid_dsm_fn_mask & fn_index))
> > +		goto skip_dsm_eval;
> > +
> > +	obj = acpi_evaluate_dsm_typed(handle, &intel_dsm_guid,
> > +				      1, fn_index,
> > +				      NULL,  ACPI_TYPE_INTEGER);
> > +	if (obj) {
> > +		*result = obj->integer.value;
> > +		acpi_handle_debug(handle,
> > +				  "Eval DSM Fn code: %d[%s]
> > results: 0x%llx\n",
> > +				  fn_index, method_name, *result);
> > +		ACPI_FREE(obj);
> > +		return true;
> > +	}
> > +
> > +skip_dsm_eval:
> > +	status = acpi_evaluate_integer(handle, method_name, NULL,
> > result);
> > +	if (ACPI_SUCCESS(status))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static void intel_hid_init_dsm(acpi_handle handle)
> > +{
> > +	union acpi_object *obj;
> > +
> > +	guid_parse(HID_EVENT_FILTER_UUID, &intel_dsm_guid);
> > +
> > +	obj = acpi_evaluate_dsm_typed(handle, &intel_dsm_guid, 1,
> > 0, NULL,
> > +				      ACPI_TYPE_BUFFER);
> > +	if (obj) {
> > +		intel_hid_dsm_fn_mask = *obj->buffer.pointer;
> > +		ACPI_FREE(obj);
> > +	}
> > +
> > +	acpi_handle_debug(handle, "intel_hid_dsm_fn_mask =
> > %llx\n",
> > +			  intel_hid_dsm_fn_mask);
> > +}
> > +
> > +static int intel_hid_set_enable(struct device *device, bool
> > enable)
> > +{
> > +	acpi_handle handle = ACPI_HANDLE(device);
> > +
> > +	/* Enable|disable features - power button is always
> > enabled */
> > +	if (!intel_hid_execute_method(handle,
> > INTEL_HID_DSM_HDSM_FN,
> > +				      enable)) {
> >  		dev_warn(device, "failed to %sable hotkeys\n",
> >  			 enable ? "en" : "dis");
> >  		return -EIO;
> > @@ -129,9 +256,8 @@ static void intel_button_array_enable(struct
> > device
> > *device, bool enable)
> >  	}
> > 
> >  	/* Enable|disable features - power button is always
> > enabled */
> > -	status = acpi_execute_simple_method(handle, "BTNE",
> > -					    enable ? button_cap :
> > 1);
> > -	if (ACPI_FAILURE(status))
> > +	if (!intel_hid_execute_method(handle,
> > INTEL_HID_DSM_BTNE_FN,
> > +				      enable ? button_cap : 1))
> >  		dev_warn(device, "failed to set button
> > capability\n");
> >  }
> > 
> > @@ -217,7 +343,6 @@ static void notify_handler(acpi_handle handle,
> > u32 event,
> > void *context)
> >  	struct platform_device *device = context;
> >  	struct intel_hid_priv *priv = dev_get_drvdata(&device-
> > >dev);
> >  	unsigned long long ev_index;
> > -	acpi_status status;
> > 
> >  	if (priv->wakeup_mode) {
> >  		/*
> > @@ -269,8 +394,8 @@ static void notify_handler(acpi_handle handle,
> > u32 event,
> > void *context)
> >  		return;
> >  	}
> > 
> > -	status = acpi_evaluate_integer(handle, "HDEM", NULL,
> > &ev_index);
> > -	if (ACPI_FAILURE(status)) {
> > +	if (!intel_hid_evaluate_method(handle,
> > INTEL_HID_DSM_HDEM_FN,
> > +				       &ev_index)) {
> >  		dev_warn(&device->dev, "failed to get event
> > index\n");
> >  		return;
> >  	}
> > @@ -284,17 +409,24 @@ static bool button_array_present(struct
> > platform_device
> > *device)
> >  {
> >  	acpi_handle handle = ACPI_HANDLE(&device->dev);
> >  	unsigned long long event_cap;
> > -	acpi_status status;
> > -	bool supported = false;
> > 
> > -	status = acpi_evaluate_integer(handle, "HEBC", NULL,
> > &event_cap);
> > -	if (ACPI_SUCCESS(status) && (event_cap & 0x20000))
> > -		supported = true;
> > +	if (intel_hid_evaluate_method(handle,
> > INTEL_HID_DSM_HEBC_V2_FN,
> > +				      &event_cap)) {
> > +		/* Check presence of 5 button array or v2 power
> > button */
> > +		if (event_cap & 0x60000)
> > +			return true;
> > +	}
> > +
> > +	if (intel_hid_evaluate_method(handle,
> > INTEL_HID_DSM_HEBC_V1_FN,
> > +				      &event_cap)) {
> > +		if (event_cap & 0x20000)
> > +			return true;
> > +	}
> > 
> >  	if (dmi_check_system(button_array_table))
> > -		supported = true;
> > +		return true;
> > 
> > -	return supported;
> > +	return false;
> >  }
> > 
> >  static int intel_hid_probe(struct platform_device *device)
> > @@ -305,8 +437,9 @@ static int intel_hid_probe(struct
> > platform_device *device)
> >  	acpi_status status;
> >  	int err;
> > 
> > -	status = acpi_evaluate_integer(handle, "HDMM", NULL,
> > &mode);
> > -	if (ACPI_FAILURE(status)) {
> > +	intel_hid_init_dsm(handle);
> > +
> > +	if (!intel_hid_evaluate_method(handle,
> > INTEL_HID_DSM_HDMM_FN,
> > &mode)) {
> >  		dev_warn(&device->dev, "failed to read mode\n");
> >  		return -ENODEV;
> >  	}
> > @@ -352,13 +485,16 @@ static int intel_hid_probe(struct
> > platform_device
> > *device)
> >  		goto err_remove_notify;
> > 
> >  	if (priv->array) {
> > +		unsigned long long dummy;
> > +
> >  		intel_button_array_enable(&device->dev, true);
> > 
> >  		/* Call button load method to enable HID power
> > button */
> > -		status = acpi_evaluate_object(handle, "BTNL",
> > NULL, NULL);
> > -		if (ACPI_FAILURE(status))
> > +		if (!intel_hid_evaluate_method(handle,
> > INTEL_HID_DSM_BTNL_FN,
> > +					       &dummy)) {
> >  			dev_warn(&device->dev,
> >  				 "failed to enable HID power
> > button\n");
> > +		}
> >  	}
> > 
> >  	device_init_wakeup(&device->dev, true);
> > --
> > 2.14.1
> 
> 
