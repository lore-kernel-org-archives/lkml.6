Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8F2C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DC22070D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfAFVwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 16:52:41 -0500
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:58249 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbfAFVwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 16:52:41 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id CD6D1100E86C2;
        Sun,  6 Jan 2019 21:52:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: nose92_51444bf427c39
X-Filterd-Recvd-Size: 3271
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sun,  6 Jan 2019 21:52:38 +0000 (UTC)
Message-ID: <3e9bc1431278847ad72fc32960b3687da3f01909.camel@perches.com>
Subject: acpi_string with const char * losing casts
From:   Joe Perches <joe@perches.com>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 06 Jan 2019 13:52:37 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/acpi/actypes.h:typedef char *acpi_string;       /* Null terminated ASCII string */

It seems there are cases where a function with an acpi_string
argument should instead use const acpi_string.

Some acpi function callers cast const char * to non-const to
avoid compiler warnings.

It would be good to use const acpi_string where appropriate in
the generic acpi_<foo> functions instead.

Also acpi_<foo> seems to use acpi_string and char * somewhat
interchangeably.

It would also be good to standardize on one style.

For instance intel-hid.c has:

   static const char *intel_hid_dsm_fn_to_method[INTEL_HID_DSM_FN_MAX] = {
   	NULL,
   	"BTNL",
   	"HDMM",
   	"HDSM",
   	"HDEM",
   	"BTNS",
   	"BTNE",
   	"HEBC",
   	"VGBS",
   	"HEBC"
   };

   [...]

   static bool intel_hid_execute_method(acpi_handle handle,
   				     enum intel_hid_dsm_fn_codes fn_index,
   				     unsigned long long arg)
   {
   	union acpi_object *obj, argv4, req;
   	acpi_status status;
   	char *method_name;

   	if (fn_index <= INTEL_HID_DSM_FN_INVALID ||
   	    fn_index >= INTEL_HID_DSM_FN_MAX)
   		return false;

   	method_name = (char *)intel_hid_dsm_fn_to_method[fn_index];

   [...]

where the const is cast away because

   skip_dsm_exec:
   	status = acpi_execute_simple_method(handle, method_name, arg);

here acpi_execute_simple_method takes a non-const acpi_string method_name.

   include/acpi/acpi_bus.h:acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
   include/acpi/acpi_bus.h-                                       u64 arg);

and the implementation in drivers/acpi/utils.c does not modify method

   acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
   				       u64 arg)
   {
   	union acpi_object obj = { .type = ACPI_TYPE_INTEGER };
   	struct acpi_object_list arg_list = { .count = 1, .pointer = &obj, };

   	obj.integer.value = arg;

   	return acpi_evaluate_object(handle, method, &arg_list, NULL);
   }
   EXPORT_SYMBOL(acpi_execute_simple_method);

and acpi_evaluate_object does not modify method either
but may assign it to another const char *relative_pathname

   acpi_status
   acpi_evaluate_object(acpi_handle handle,
   		     acpi_string pathname,
   		     struct acpi_object_list *external_params,
   		     struct acpi_buffer *return_buffer)

   {
   	[...]

   	info->relative_pathname = pathname;


