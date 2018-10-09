Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5728C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628E3214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqN3UPia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628E3214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeJJD6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:58:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44151 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJJD6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:58:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id r9-v6so1426639pff.11;
        Tue, 09 Oct 2018 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGHdrEodQPClQrKE3/thZGkYahqRNKwGC6U1JCEhQnc=;
        b=LqN3UPiaYiDwi797TX0gkxI1/rOM9GOq4ibaeLDTFJM8L/OzsKwJF9XRAinN1L0Coa
         b5v9RPuS6zH9fiSvf1LLqeoz5hJw6DltReXyXxIjlbldERFbIoB8/3/6rY/zPO8PkJJY
         7sVKXRLG3dllMTrAsJSl6H2cNN3Ofc6ST2SNsWRyJonE3q4O7KcDj64hl7+D8h2/opJe
         un8v+ProPRA0O99KcD5JQZi8vwi/9uhlpFicIcPMdvpfs2McHFRfSbE+Rq2rLSzXpOa2
         0i658/JrhO5o7QxPHUJBDnz5i9q3bQ3S78O6/3o3M3hI8ODUiL85JmvvupiM7QCtKio5
         nUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGHdrEodQPClQrKE3/thZGkYahqRNKwGC6U1JCEhQnc=;
        b=feEOcM+YOD2o50m7J3Lhwwl8wZXnySoaC4/gBkmLVKUI8nMsy86yekuXNyV3bWxmxV
         DL+UMwo1AsFMAFmK6hLff3UvvGq2iwwBiz027FXp8dueKXR2ionitiCbZ68yyx88TVoZ
         r2Fo+KAVoj1jbDyYNQPyeRiC3Xz+iFwfIF2gtGkc0vLbQ0VFQIR9yxxx8iR/9PJhGRu8
         Bj3EIibKKYp0/P/FDqV0SjTPewX/ZAeW/g665FXN563zeCfMpx7lwFBRXLG3moAm+Xmn
         y4JAAgPcZwvfZs/EkjJF0XrjP21hDh0FK3bVFdvPud6sdyqesyU/XUwghDik/bmiIx5D
         9bHA==
X-Gm-Message-State: ABuFfojchCCUkjB6ZnzDb1rROB+m69reEl/i8YCzG+MakzMdO1mrxcWL
        WXiRGWjyS8mkgoykO42SgAg=
X-Google-Smtp-Source: ACcGV60KN6FSDuPNL2b89oIRBSRAeu4ffSrRNFYeyamX5e1U00FwkthTWRRgEAUfvNm8Gi3mv4RoJg==
X-Received: by 2002:a63:d256:: with SMTP id t22-v6mr26813261pgi.335.1539117580083;
        Tue, 09 Oct 2018 13:39:40 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o76-v6sm33199742pfi.162.2018.10.09.13.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 13:39:38 -0700 (PDT)
Date:   Tue, 9 Oct 2018 13:39:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH] hwmon: (core) Add trace events to _attr_show/store
 functions
Message-ID: <20181009203937.GA11222@roeck-us.net>
References: <20181009182602.3085-1-nicoleotsuka@gmail.com>
 <20181009145721.0669e412@gandalf.local.home>
 <20181009191111.GA6166@Asurada-Nvidia.nvidia.com>
 <20181009154945.65300231@gandalf.local.home>
 <20181009195654.GA7963@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009195654.GA7963@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 12:57:43PM -0700, Nicolin Chen wrote:
> On Tue, Oct 09, 2018 at 03:49:45PM -0400, Steven Rostedt wrote:
> > > > > Trace events are useful for people who collect data from the
> > > > > ftrace output. This patch adds initial trace events for the
> > > > > hwmon core. To call hwmon_attr_base() for aligned attr index
> > > > > numbers, this patch also moves the function upward.
> > > > > 
> > > > > Ftrace outputs:
> > > > >  ...: hwmon_attr_show_string: index=2, attr_name=in2_label, val=VDD_5V
> > > > >  ...: hwmon_attr_show: index=2, attr_name=in2_input, val=5112
> > > > >  ...: hwmon_attr_show: index=2, attr_name=curr2_input, val=440
> > > > > 
> > > > > Note that the _attr_show and _attr_store functions are tied
> > > > > to the _with_info API. So a hwmon driver requiring the trace
> > > > > events feature should use _with_info API to register a hwmon
> > > > > device.  
> > > > 
> > > > Hmm, this doesn't really explain why these trace events are needed.
> > > > They look to be attached to sysfs reads. What's the purpose of tracing
> > > > these?  
> > > 
> > > Our power folks analyse Ftrace outputs of cpufreq, thermal and
> > > hwmon (power/voltage/current) so as to get the relationship of
> > > them. The reason why we specifically need trace events is that
> > > it's convenient and timestamped, and because both cpufreq and
> > > thermal already have trace events.
> > > 
> > > I could add this to make the commit message more convincing if
> > > you'd prefer that.
> > 
> > I'm not against the patch, but yes, having this in the change log is
> > helpful.
> 
> I will add it in v2.
> 
> > > > > @@ -193,6 +206,7 @@ static ssize_t hwmon_attr_show_string(struct device *dev,
> > > > >  				      char *buf)
> > > > >  {
> > > > >  	struct hwmon_device_attribute *hattr = to_hwmon_attr(devattr);
> > > > > +	enum hwmon_sensor_types type = hattr->type;
> > > > >  	const char *s;
> > > > >  	int ret;
> > > > >  
> > > > > @@ -201,6 +215,9 @@ static ssize_t hwmon_attr_show_string(struct device *dev,
> > > > >  	if (ret < 0)
> > > > >  		return ret;
> > > > >  
> > > > > +	trace_hwmon_attr_show_string(hattr->index + hwmon_attr_base(type),  
> > > > 
> > > > Also, the other to tracepoints use hattr->type, here you create a
> > > > separate variable. Is that just to keep within the 80 char limit?  
> > > 
> > > Yes. It looks clearer to me than wrapping the line here, since
> > > complier usually optimize the local variable away.
> > 
> > Or you can just break the 80 character limit ;-)
> 
> Personally a checkpatch warning bugs me more than having an extra
> line :)
> 
Same here. If we no longer believe in the 80-column limit, we should remove it,
not use it to hide other problems in the noise.

Thanks,
Guenter
