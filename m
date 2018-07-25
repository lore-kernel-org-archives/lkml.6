Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0FDC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C58205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDb8+8qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C58205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbeGYRse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:48:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37889 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbeGYRse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:48:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so5665750pgq.5;
        Wed, 25 Jul 2018 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRW9tXOESlyDOols04phrpGyAxDfY+aDQxt9u7DKkN4=;
        b=HDb8+8qxQEUa66llF4VFYoo1h1dIfOe5KvwL8sG//6lQJaQz4lzrqvn5PFBULam425
         lnfzC4ugm/9MGKgmOxLrytEwhcffIpV3j7dAsYcUvWnPcsLYusdJCxJhULTKoXV0JoxB
         9VTuUKaQM4cR18OzgEdD+UWBhdfvNj0PYp8Ct5sxBTkthEpixZ54V1NTow4dffDz+Lqg
         ZuNImc4OrjuOeX3mxFC9OuiPxa8PYZE3AC551gqBJMD/JtWJ6wz7372/JqLW5jiXDZ1l
         CEzEtK4ZAsSGmlPMGLqxr1JSE/0zEgiFA6cSQdQpXWQfP7Xpzm1isFAfg8zL/dVGqMWf
         O45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRW9tXOESlyDOols04phrpGyAxDfY+aDQxt9u7DKkN4=;
        b=GnhdaDlXomyRCXeeu/4rFrR4WVCcDn4E5ety8WZ9oNGESNcj22iCaHWVJ0qs5wHTEl
         O/tI3ZzRFAKUEkuSLoGTyZGoMaMRDnKlTNTLIGig1olj28Hz+ltbWEjDjyMeI/WHaa6d
         ULwu76Pch7BhqdVvBFuc1iJyDaoiVQ+o/lmCIqfPwbOVs6IV81e85Jbrd0uUfsw85Me+
         GF5wYfsgRzpVme16spbxIh8eGtyE8xYDgARwFszkz8T/MkLZoxafznnQHnKqcBLKu6Gk
         ppgWocijYmL4O1LLUxCcsFyoRPckE89oFgUPmPNxgcFOKzKGkynIBvzUdwI/ehwlchCs
         W/tg==
X-Gm-Message-State: AOUpUlGR9PaPMRwb50QcxMty+3K8fLOuH5OP5Utuao+SHrdaq4j1zwYC
        vgJ96REwTyr1kfgP/2x9yk8=
X-Google-Smtp-Source: AAOMgpcM/zq5gWgt7oQfXSkJCdCOnABQWw7mdpZ6pOp7DvLkEHb2AgsWfREjqzVm7OXQfIuaL4T12A==
X-Received: by 2002:a63:a919:: with SMTP id u25-v6mr21843546pge.211.1532536566873;
        Wed, 25 Jul 2018 09:36:06 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u2-v6sm20675668pfn.59.2018.07.25.09.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 09:36:06 -0700 (PDT)
Date:   Wed, 25 Jul 2018 09:36:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        jdelvare@suse.com, mark.rutland@arm.com, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, joel@jms.id.au
Subject: Re: [PATCH v4 2/9] Documentation: hwmon: Add OCC documentation
Message-ID: <20180725163604.GA21332@roeck-us.net>
References: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1531342898-15790-3-git-send-email-eajames@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531342898-15790-3-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:01:31PM -0500, Eddie James wrote:
> Document the hwmon interface for the OCC.
> 
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  Documentation/hwmon/occ | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/hwmon/occ
> 
> diff --git a/Documentation/hwmon/occ b/Documentation/hwmon/occ
> new file mode 100644
> index 0000000..465fa1a
> --- /dev/null
> +++ b/Documentation/hwmon/occ
> @@ -0,0 +1,73 @@
> +Kernel driver occ-hwmon
> +=======================
> +
> +Supported chips:
> +  * POWER8
> +  * POWER9
> +
> +Author: Eddie James <eajames@linux.vnet.ibm.com>
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for the On-Chip Controller (OCC)
> +embedded on POWER processors. The OCC is a device that collects and aggregates
> +sensor data from the processor and the system. The OCC can provide the raw
> +sensor data as well as perform thermal and power management on the system.
> +
> +The P8 version of this driver is a client driver of I2C. It may be probed
> +manually if an "ibm,p8-occ-hwmon" compatible device is found under the
> +appropriate I2C bus node in the device-tree.
> +
> +The P9 version of this driver is a client driver of the FSI-based OCC driver.
> +It will be probed automatically by the FSI-based OCC driver.
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported. All attributes are read-only unless
> +specified.
> +
> +temp[1-n]_label		OCC sensor id.
> +temp[1-n]_input		Measured temperature in millidegrees C.
> +[with temperature sensor version 2+]
> +    temp[1-n]_fru_type		Given FRU (Field Replaceable Unit) type.

What is this ? An integer ? A string ?

> +    temp[1-n]_fault		Temperature sensor fault.
> +
> +freq[1-n]_label		OCC sensor id.
> +freq[1-n]_input		Measured frequency.

What does that have to do with hardware monitoring, and what exactly does it
measure ? AC voltage frequency ? Frequency of rainstorms in the surrounding
area ?

> +
> +power[1-n]_label	OCC sensor id.
> +power[1-n]_input	Measured power in microwatts.
> +power[1-n]_update_tag	Number of 250us samples represented in accumulator.

update_tag to represent number of samples ? Odd choice for
an attribute name. Why not "_samples" ? Also, if each sample
represents a specific amount of time, why not report a time ?

> +power[1-n]_accumulator	Accumulation of 250us power readings.

There is no explanation of "accumulation". Is this the energy ?
If so, why not use energy attributes ? And what is the unit of
this measurement ?

> +[with power sensor version 2+]
> +    power[1-n]_function_id	Identifies what the power reading is for.

String ? Number ? Slot index ?  Bitmap ? And why isn't that reported
in the label ? After all, that is what the label is supposed to be
used for.

> +    power[1-n]_apss_channel	Indicates APSS channel.
> +

Does that provide any value to the user ?

> +[power version 0xa0 only]
> +power1_id			OCC sensor id.

This is inconsistent with the other attributes and even with itself.

> +power[1-n]_label		Sensor type, "system", "proc", "vdd", or "vdn".
> +power[1-n]_input		Most recent power reading in microwatts.

Overall I am left with no idea what
	_id
	_label
	_function_id
	_apps_channel
are and how they relate to each other, except that it all looks quite
inconsistent. You might want to consider merging all those attributes into
the label in some consistent way.

> +power[1-n]_update_tag		Number of samples in the accumulator.
> +power[1-n]_accumulator		Accumulation of power readings.

Same as above.

> +[with sensor type "system" and "proc" only]
> +    power[1-n]_update_time	Time in us that the power value is read.
> +
> +caps1_current		Current OCC power cap in watts.
> +caps1_reading		Current system output power in watts.
> +caps1_norm		Power cap without redundant power.
> +caps1_max		Maximum power cap.

Why do those have to be non-standard attributes ? Please explain why you can not
use power[1-n]_cap attributes.

> +[caps version 1 and 2 only]
> +    caps1_min		Minimum power cap.
> +[caps version 3+]
> +    caps1_min_hard		Hard minimum cap that can be set and held.
> +    caps1_min_soft		Soft minimum cap below hard, not guaranteed.
> +caps1_user		The powercap specified by the user. Will be 0 if no
> +			user powercap exists. This attribute is read-write.
> +[caps version 1+]
> +    caps1_user_source	Indicates how the user power limit was set.
> +
> +extn[1-n]_label		ASCII id or sensor id.
> +extn[1-n]_flags		Indicates type of label attribute.
> +extn[1-n]_input		Data.

Great non-explanation.

Not reviewing the series further. I am sure I asked that each non-standard
attribute is explained. There is neither an explanation why the attributes
are needed nor, in many cases, why non-standard attributes were chosen
instead of standard ones. On top of that, the non-standard attributes are
not even documented properly, leaving the reader wondering not only why
they are needed, but what they are used for in the first place.

Guenter
