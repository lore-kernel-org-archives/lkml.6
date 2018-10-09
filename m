Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E1CECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB9B214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB9B214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJJCPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbeJJCPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:15:47 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 078C5214C4;
        Tue,  9 Oct 2018 18:57:22 +0000 (UTC)
Date:   Tue, 9 Oct 2018 14:57:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] hwmon: (core) Add trace events to _attr_show/store
 functions
Message-ID: <20181009145721.0669e412@gandalf.local.home>
In-Reply-To: <20181009182602.3085-1-nicoleotsuka@gmail.com>
References: <20181009182602.3085-1-nicoleotsuka@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Oct 2018 11:26:02 -0700
Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> Trace events are useful for people who collect data from the
> ftrace output. This patch adds initial trace events for the
> hwmon core. To call hwmon_attr_base() for aligned attr index
> numbers, this patch also moves the function upward.
> 
> Ftrace outputs:
>  ...: hwmon_attr_show_string: index=2, attr_name=in2_label, val=VDD_5V
>  ...: hwmon_attr_show: index=2, attr_name=in2_input, val=5112
>  ...: hwmon_attr_show: index=2, attr_name=curr2_input, val=440
> 
> Note that the _attr_show and _attr_store functions are tied
> to the _with_info API. So a hwmon driver requiring the trace
> events feature should use _with_info API to register a hwmon
> device.

Hmm, this doesn't really explain why these trace events are needed.
They look to be attached to sysfs reads. What's the purpose of tracing
these?

> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  MAINTAINERS                  |  1 +
>  drivers/hwmon/hwmon.c        | 27 ++++++++++----
>  include/trace/events/hwmon.h | 71 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+), 7 deletions(-)
>  create mode 100644 include/trace/events/hwmon.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1640b9faa75e..589b32405bf4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6461,6 +6461,7 @@ F:	Documentation/devicetree/bindings/hwmon/
>  F:	Documentation/hwmon/
>  F:	drivers/hwmon/
>  F:	include/linux/hwmon*.h
> +F:	include/trace/events/hwmon*.h
>  
>  HARDWARE RANDOM NUMBER GENERATOR CORE
>  M:	Matt Mackall <mpm@selenic.com>
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index ac1cdf88840f..975c95169884 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -24,6 +24,9 @@
>  #include <linux/string.h>
>  #include <linux/thermal.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/hwmon.h>
> +
>  #define HWMON_ID_PREFIX "hwmon"
>  #define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
>  
> @@ -171,6 +174,13 @@ static int hwmon_thermal_add_sensor(struct device *dev,
>  }
>  #endif /* IS_REACHABLE(CONFIG_THERMAL) && ... */
>  
> +static int hwmon_attr_base(enum hwmon_sensor_types type)
> +{
> +	if (type == hwmon_in)
> +		return 0;
> +	return 1;
> +}
> +
>  /* sysfs attribute management */
>  
>  static ssize_t hwmon_attr_show(struct device *dev,
> @@ -185,6 +195,9 @@ static ssize_t hwmon_attr_show(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> +	trace_hwmon_attr_show(hattr->index + hwmon_attr_base(hattr->type),
> +			      hattr->name, val);
> +
>  	return sprintf(buf, "%ld\n", val);
>  }
>  
> @@ -193,6 +206,7 @@ static ssize_t hwmon_attr_show_string(struct device *dev,
>  				      char *buf)
>  {
>  	struct hwmon_device_attribute *hattr = to_hwmon_attr(devattr);
> +	enum hwmon_sensor_types type = hattr->type;
>  	const char *s;
>  	int ret;
>  
> @@ -201,6 +215,9 @@ static ssize_t hwmon_attr_show_string(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> +	trace_hwmon_attr_show_string(hattr->index + hwmon_attr_base(type),

Also, the other to tracepoints use hattr->type, here you create a
separate variable. Is that just to keep within the 80 char limit?

-- Steve

> +				     hattr->name, s);
> +
>  	return sprintf(buf, "%s\n", s);
>  }
>  
> @@ -221,16 +238,12 @@ static ssize_t hwmon_attr_store(struct device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> +	trace_hwmon_attr_store(hattr->index + hwmon_attr_base(hattr->type),
> +			       hattr->name, val);
> +
>  	return count;
>  }
>  
> -static int hwmon_attr_base(enum hwmon_sensor_types type)
> -{
> -	if (type == hwmon_in)
> -		return 0;
> -	return 1;
> -}
> -
>  static bool is_string_attr(enum hwmon_sensor_types type, u32 attr)
>  {
>  	return (type == hwmon_temp && attr == hwmon_temp_label) ||

