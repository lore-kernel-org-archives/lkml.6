Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D05BC28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D1C2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEHGEAYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D1C2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJLKiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 06:38:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35314 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJLKiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 06:38:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so5424480pff.2;
        Thu, 11 Oct 2018 20:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ksspey1WB8ngQYsBm8yPpi+IB6wDJf2/4nhy6CC6K1I=;
        b=YEHGEAYJENTxI/tiMd5E5pG31UiIvO6gvdCrTmCO7ZMwcT2xt1jS8k+XAGQdSXcSLN
         FchilFDp9kCxfcirivTs7TjaKXSWAqvwT0Go4zLDaG563ZhMdS15+2dxMNXP/5Ac/bY9
         SzHeZJvKf27nuyDg9PMNATH23oVVyjJpiSI9rRs5PMwOaump4z6RruEqcVSWvC40v6hy
         sbpCh6ubpEHF4cMGI08Xb4/gCQwMn4wNO6dLyE8xdaKvFGghwe4qftq1QwY6T4qx1h45
         Ks+/ic3llbmGVFsu4Au85M5owBU8mKa9Bxi+r33CkKNzu4h1yy9eFXNGXLeUgFAUyjio
         hFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ksspey1WB8ngQYsBm8yPpi+IB6wDJf2/4nhy6CC6K1I=;
        b=UouMjYJciVmrxFW/UQ+xf99KtMQh0cwIaAS34TDOvSx8xBkQF/t7RCsGT+kA54CdM8
         IarSS+tBfbAB5kGfxxUV468b5s1245lswqPXiv0cQW2SsevO5FArz/8Fp8MI3QAx7svm
         z2vTn0Xa7AqB94L7tGePB6RsTFeU+eNfJsCATGee5VAFsSP5vCYN1xAcYHFwaxT2IJXk
         ETwh02X7u1PCzWRn3mwKzcUDlhc77EqOT656o2S5i01kBCGgVs+swrmfu7akLdzHnAZV
         dzQnsF+lEMXYcxw7Git/oLt499DWSR02mp8feAhokivFp5AQXi1Cv7SVlPjgpg8xNkzu
         jivQ==
X-Gm-Message-State: ABuFfoiz+yxFfI1+yyiPXpj0K2IvHAgA/bWpyYCu1hOTi9+kGdmFgQSz
        cHEHlA1ddAhiQ0djXN7lCvo=
X-Google-Smtp-Source: ACcGV63knL931vbaehOU3ju8HQXkFqtNuK8Z9NL5/qSGxr4Y12G5WS9k9w4ejZcZ0s0wg39uWPmQgA==
X-Received: by 2002:a62:3541:: with SMTP id c62-v6mr4223492pfa.45.1539313674377;
        Thu, 11 Oct 2018 20:07:54 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 72-v6sm4728084pfl.126.2018.10.11.20.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 20:07:53 -0700 (PDT)
Date:   Thu, 11 Oct 2018 20:07:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, rostedt@goodmis.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH v2] hwmon: (core) Add trace events to _attr_show/store
 functions
Message-ID: <20181012030751.GA12514@roeck-us.net>
References: <20181009214219.19489-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009214219.19489-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 02:42:19PM -0700, Nicolin Chen wrote:
> Trace events are useful for people who collect data from the
> Ftrace outputs. There're people who analyse the relationship
> of cpufreq, thermal and hwmon (power/voltage/current) using
> the convenient and timestamped Ftrace outputs, while unlike
> cpufreq and thermal subsystems the hwmon does not have trace
> events supported yet.
> 
> So this patch adds initial trace events for the hwmon core.
> To call hwmon_attr_base() for aligned attr index numbers, it
> also moves the function upward.
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
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> Changelog
> v1->v2:
>  * Added a descriptive reason for this change in the commit message
> 
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
> diff --git a/include/trace/events/hwmon.h b/include/trace/events/hwmon.h
> new file mode 100644
> index 000000000000..d7a1d0ffb679
> --- /dev/null
> +++ b/include/trace/events/hwmon.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM hwmon
> +
> +#if !defined(_TRACE_HWMON_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_HWMON_H
> +
> +#include <linux/tracepoint.h>
> +
> +DECLARE_EVENT_CLASS(hwmon_attr_class,
> +
> +	TP_PROTO(int index, const char *attr_name, long val),
> +
> +	TP_ARGS(index, attr_name, val),
> +
> +	TP_STRUCT__entry(
> +		__field(int, index)
> +		__string(attr_name, attr_name)
> +		__field(long, val)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->index = index;
> +		__assign_str(attr_name, attr_name);
> +		__entry->val = val;
> +	),
> +
> +	TP_printk("index=%d, attr_name=%s, val=%ld",
> +		  __entry->index,  __get_str(attr_name), __entry->val)
> +);
> +
> +DEFINE_EVENT(hwmon_attr_class, hwmon_attr_show,
> +
> +	TP_PROTO(int index, const char *attr_name, long val),
> +
> +	TP_ARGS(index, attr_name, val)
> +);
> +
> +DEFINE_EVENT(hwmon_attr_class, hwmon_attr_store,
> +
> +	TP_PROTO(int index, const char *attr_name, long val),
> +
> +	TP_ARGS(index, attr_name, val)
> +);
> +
> +TRACE_EVENT(hwmon_attr_show_string,
> +
> +	TP_PROTO(int index, const char *attr_name, const char *s),
> +
> +	TP_ARGS(index, attr_name, s),
> +
> +	TP_STRUCT__entry(
> +		__field(int, index)
> +		__string(attr_name, attr_name)
> +		__string(label, s)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->index = index;
> +		__assign_str(attr_name, attr_name);
> +		__assign_str(label, s);
> +	),
> +
> +	TP_printk("index=%d, attr_name=%s, val=%s",
> +		  __entry->index, __get_str(attr_name), __get_str(label))
> +);
> +
> +#endif /* _TRACE_HWMON_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
