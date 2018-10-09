Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C45C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368D4214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368D4214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeJJDIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbeJJDIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:08:20 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9DDC214C4;
        Tue,  9 Oct 2018 19:49:46 +0000 (UTC)
Date:   Tue, 9 Oct 2018 15:49:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] hwmon: (core) Add trace events to _attr_show/store
 functions
Message-ID: <20181009154945.65300231@gandalf.local.home>
In-Reply-To: <20181009191111.GA6166@Asurada-Nvidia.nvidia.com>
References: <20181009182602.3085-1-nicoleotsuka@gmail.com>
        <20181009145721.0669e412@gandalf.local.home>
        <20181009191111.GA6166@Asurada-Nvidia.nvidia.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 12:11:11 -0700
Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> On Tue, Oct 09, 2018 at 02:57:21PM -0400, Steven Rostedt wrote:
> 
> > > Trace events are useful for people who collect data from the
> > > ftrace output. This patch adds initial trace events for the
> > > hwmon core. To call hwmon_attr_base() for aligned attr index
> > > numbers, this patch also moves the function upward.
> > > 
> > > Ftrace outputs:
> > >  ...: hwmon_attr_show_string: index=2, attr_name=in2_label, val=VDD_5V
> > >  ...: hwmon_attr_show: index=2, attr_name=in2_input, val=5112
> > >  ...: hwmon_attr_show: index=2, attr_name=curr2_input, val=440
> > > 
> > > Note that the _attr_show and _attr_store functions are tied
> > > to the _with_info API. So a hwmon driver requiring the trace
> > > events feature should use _with_info API to register a hwmon
> > > device.  
> > 
> > Hmm, this doesn't really explain why these trace events are needed.
> > They look to be attached to sysfs reads. What's the purpose of tracing
> > these?  
> 
> Our power folks analyse Ftrace outputs of cpufreq, thermal and
> hwmon (power/voltage/current) so as to get the relationship of
> them. The reason why we specifically need trace events is that
> it's convenient and timestamped, and because both cpufreq and
> thermal already have trace events.
> 
> I could add this to make the commit message more convincing if
> you'd prefer that.

I'm not against the patch, but yes, having this in the change log is
helpful.


> 
> > > @@ -193,6 +206,7 @@ static ssize_t hwmon_attr_show_string(struct device *dev,
> > >  				      char *buf)
> > >  {
> > >  	struct hwmon_device_attribute *hattr = to_hwmon_attr(devattr);
> > > +	enum hwmon_sensor_types type = hattr->type;
> > >  	const char *s;
> > >  	int ret;
> > >  
> > > @@ -201,6 +215,9 @@ static ssize_t hwmon_attr_show_string(struct device *dev,
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > +	trace_hwmon_attr_show_string(hattr->index + hwmon_attr_base(type),  
> > 
> > Also, the other to tracepoints use hattr->type, here you create a
> > separate variable. Is that just to keep within the 80 char limit?  
> 
> Yes. It looks clearer to me than wrapping the line here, since
> complier usually optimize the local variable away.
> 

Or you can just break the 80 character limit ;-)

-- Steve
