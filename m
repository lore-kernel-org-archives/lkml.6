Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7A6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F95A2245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F95A2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeKMEZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:25:25 -0500
Received: from mail02.iobjects.de ([188.40.134.68]:53784 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeKMEZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:25:25 -0500
Received: from tux.wizards.de (p3EE2F45F.dip0.t-ipconnect.de [62.226.244.95])
        by mail02.iobjects.de (Postfix) with ESMTPSA id AFF1A4160F7C;
        Mon, 12 Nov 2018 19:30:57 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 45AD2EEB928;
        Mon, 12 Nov 2018 19:30:57 +0100 (CET)
Subject: Re: [PATCH 4.19 025/361] ACPICA: AML interpreter: add region
 addresses in global list during initialization
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Jean-Marc Lenoir <archlinux@jihemel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20181111221619.915519183@linuxfoundation.org>
 <20181111221623.163909820@linuxfoundation.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <9da1c8e8-d237-11b3-8918-859a4bbdbcc4@applied-asynchrony.com>
Date:   Mon, 12 Nov 2018 19:30:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181111221623.163909820@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 11:16 PM, Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me know.

As probably expected this patch causes problems. In my case one server
can no longer load the nct6775 hwmon module, which means the fan cannot be
monitored, and therefore my monitoring system promptly starts spamming me with
alerts that my fan has failed - which is of course not true.

--snip--
Nov 12 18:08:56 tux kernel: nct6775: Found NCT6776D/F or compatible chip at 0x2e:0x290
Nov 12 18:08:56 tux kernel: ACPI Warning: SystemIO range 0x0000000000000295-0x0000000000000296 conflicts with OpRegion 0x0000000000000290-0x
Nov 12 18:08:56 tux kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
--snip--

This is certainly caused by my old BIOS and its broken ACPI implementation,
however since it's working perfectly fine otherwise I see no reason to replace
it. That being said, I must be able to monitor my fan, so for now reverting
the patch immediately "fixed" the problem for me - the fan entries appeared
in sysfs again after successfully loading the module.

Idea, workarounds or patches welcome.

> ------------------
> 
> From: Erik Schmauss <erik.schmauss@intel.com>
> 
> commit 4abb951b73ff0a8a979113ef185651aa3c8da19b upstream.
> 
> The table load process omitted adding the operation region address
> range to the global list. This omission is problematic because the OS
> queries the global list to check for address range conflicts before
> deciding which drivers to load. This commit may result in warning
> messages that look like the following:
> 
> [    7.871761] ACPI Warning: system_IO range 0x00000428-0x0000042F conflicts with op_region 0x00000400-0x0000047F (\PMIO) (20180531/utaddress-213)
> [    7.871769] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> 
> However, these messages do not signify regressions. It is a result of
> properly adding address ranges within the global address list.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200011
> Tested-by: Jean-Marc Lenoir <archlinux@jihemel.com>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>   drivers/acpi/acpica/dsopcode.c |    4 ++++
>   1 file changed, 4 insertions(+)
> 
> --- a/drivers/acpi/acpica/dsopcode.c
> +++ b/drivers/acpi/acpica/dsopcode.c
> @@ -417,6 +417,10 @@ acpi_ds_eval_region_operands(struct acpi
>   			  ACPI_FORMAT_UINT64(obj_desc->region.address),
>   			  obj_desc->region.length));
>   
> +	status = acpi_ut_add_address_range(obj_desc->region.space_id,
> +					   obj_desc->region.address,
> +					   obj_desc->region.length, node);
> +
>   	/* Now the address and length are valid for this opregion */
>   
>   	obj_desc->region.flags |= AOPOBJ_DATA_VALID;
> 
> 
> 

