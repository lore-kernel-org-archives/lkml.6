Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F4BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EAC208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="c/73f50V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EAC208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJPXim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:38:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42733 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbeJPXil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:38:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id g15-v6so26115490wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=31MY2B6OV9JmHaDov0jb65gO+jYtP4SXe7kbwKQ8A7I=;
        b=c/73f50V2UgbbCueOAG4ppvsWatZpQ/uLqOseGsLifcCid0HhxK6vZwUU6lNDepc1A
         UxC86Svr9MvaAKHEN/Q2H0KA9Fd4tbnTEuq7i4q3sfO6JmkA377F43snyL5rNVTh0X/o
         HFQVHGxr+SZna7qFVEXwxmhzV766/rIMqA5X2Huvp/H5xOwMf4wx6LNVB9sHOGzga0Af
         55Gqz/3duq6s+PTI3gM+WngSUIpnBKHL+K9lG7YednsmV1L6+79/uULmwoDHMwgvjlDW
         gnixYvLTbpNYwSASAOZt+ATeovRZbkSy+zbRKs1OrH6LWV829BgwUEi8RJ4lidVtYaHv
         HD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=31MY2B6OV9JmHaDov0jb65gO+jYtP4SXe7kbwKQ8A7I=;
        b=ONsLDuXIeMpJ4vGTvUa6P7ipYTpzuq4oU4rh1gU9RYM3MP8toyew9bDHLF2Vne7dAh
         Y8HyPNqj/uWuPkzSo6QR10TxMn5izmaZngajDSxHHnHsWDd3zYY9y0+qgvsHspZidKW3
         6iHjsZeE7IscqBTc2OOjHu2dd66pOqbqwT2k5/nMwS6q6FQNseTip1eNJxY2golhkWZg
         lZANErdSdz3bh0TxgrjGI1CGB5FdUY6/fUq0spqUY62Gc8iqQE/jYrteRqP6Kq4g4ZPz
         y23cu3ozNfdJwpdwn8ZYXSMEPZgjxagYhxtU3khaZoVniHRsEbJPjuArmmOZHT7KQRI8
         Lozg==
X-Gm-Message-State: ABuFfogkEg4MSV0AFbB/qMeej/ReIFWnHu0WeR40UUdou7GNx85pmPsF
        bCFRYn0djA4Xca1pHEOvif+LDA==
X-Google-Smtp-Source: ACcGV63kjr97ntgn4xUFxyy64KSy6okAatkRk1KxTlIPhtu8FW2skE/dY4jaK2jpSJRTqeKEYSC/WQ==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr19586621wrx.310.1539704857516;
        Tue, 16 Oct 2018 08:47:37 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id b14-v6sm13039079wrp.42.2018.10.16.08.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 08:47:36 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:47:30 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Waiman Long <longman@redhat.com>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        linux@dominikbrodowski.net, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v1 2/2] sysctl: handle overflow for file-max
Message-ID: <20181016154729.sjw2atqxdo6yidh7@brauner.io>
References: <20181015105544.4395-1-christian@brauner.io>
 <20181015105544.4395-3-christian@brauner.io>
 <22319ca1-6dab-fe36-40d5-9c88f7a175ee@redhat.com>
 <20181016152100.zg2pmyk6puc5qsr5@brauner.io>
 <11e172de-0953-2c46-c0f0-72c42ae9a910@redhat.com>
 <20181016152955.vcjtzcx5rzlxeovh@brauner.io>
 <4aa6ff1a-28c7-db85-1fea-fa0e4fc1ef2e@redhat.com>
 <20181016154040.znumdxkhaudewlku@brauner.io>
 <3b0dd3ae-4362-4996-eb86-99ff92659a59@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b0dd3ae-4362-4996-eb86-99ff92659a59@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 11:44:40AM -0400, Waiman Long wrote:
> On 10/16/2018 11:40 AM, Christian Brauner wrote:
> > On Tue, Oct 16, 2018 at 11:34:07AM -0400, Waiman Long wrote:
> >> On 10/16/2018 11:29 AM, Christian Brauner wrote:
> >>> On Tue, Oct 16, 2018 at 11:25:42AM -0400, Waiman Long wrote:
> >>>> On 10/16/2018 11:21 AM, Christian Brauner wrote:
> >>>>> On Tue, Oct 16, 2018 at 11:13:28AM -0400, Waiman Long wrote:
> >>>>>> On 10/15/2018 06:55 AM, Christian Brauner wrote:
> >>>>>>> Currently, when writing
> >>>>>>>
> >>>>>>> echo 18446744073709551616 > /proc/sys/fs/file-max
> >>>>>>>
> >>>>>>> /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> >>>>>>> crashes the system.
> >>>>>>> This commit explicitly caps the value for file-max to ULONG_MAX.
> >>>>>>>
> >>>>>>> Note, this isn't technically necessary since proc_get_long() will already
> >>>>>>> return ULONG_MAX. However, two reason why we still should do this:
> >>>>>>> 1. it makes it explicit what the upper bound of file-max is instead of
> >>>>>>>    making readers of the code infer it from proc_get_long() themselves
> >>>>>>> 2. other tunebles than file-max may want to set a lower max value than
> >>>>>>>    ULONG_MAX and we need to enable __do_proc_doulongvec_minmax() to handle
> >>>>>>>    such cases too
> >>>>>>>
> >>>>>>> Cc: Kees Cook <keescook@chromium.org>
> >>>>>>> Signed-off-by: Christian Brauner <christian@brauner.io>
> >>>>>>> ---
> >>>>>>> v0->v1:
> >>>>>>> - if max value is < than ULONG_MAX use max as upper bound
> >>>>>>> - (Dominik) remove double "the" from commit message
> >>>>>>> ---
> >>>>>>>  kernel/sysctl.c | 4 ++++
> >>>>>>>  1 file changed, 4 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> >>>>>>> index 97551eb42946..226d4eaf4b0e 100644
> >>>>>>> --- a/kernel/sysctl.c
> >>>>>>> +++ b/kernel/sysctl.c
> >>>>>>> @@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
> >>>>>>>  static int __maybe_unused two = 2;
> >>>>>>>  static int __maybe_unused four = 4;
> >>>>>>>  static unsigned long one_ul = 1;
> >>>>>>> +static unsigned long ulong_max = ULONG_MAX;
> >>>>>>>  static int one_hundred = 100;
> >>>>>>>  static int one_thousand = 1000;
> >>>>>>>  #ifdef CONFIG_PRINTK
> >>>>>>> @@ -1696,6 +1697,7 @@ static struct ctl_table fs_table[] = {
> >>>>>>>  		.maxlen		= sizeof(files_stat.max_files),
> >>>>>>>  		.mode		= 0644,
> >>>>>>>  		.proc_handler	= proc_doulongvec_minmax,
> >>>>>>> +		.extra2		= &ulong_max,
> >>>>>> What is the point of having a maximum value of ULONG_MAX anyway? No
> >>>>>> value you can put into a ulong type can be bigger than that.
> >>>>> This is changed in the new code to LONG_MAX. See the full thread for
> >>>>> context. There's also an additional explantion in the commit message.
> >>>>>
> >>>>>>>  	},
> >>>>>>>  	{
> >>>>>>>  		.procname	= "nr_open",
> >>>>>>> @@ -2795,6 +2797,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
> >>>>>>>  				break;
> >>>>>>>  			if (neg)
> >>>>>>>  				continue;
> >>>>>>> +			if (max && val > *max)
> >>>>>>> +				val = *max;
> >>>>>>>  			val = convmul * val / convdiv;
> >>>>>>>  			if ((min && val < *min) || (max && val > *max))
> >>>>>>>  				continue;
> >>>>>> This does introduce a change in behavior. Previously the out-of-bound
> >>>>>> value is ignored, now it is capped at its maximum. This is a
> >>>>>> user-visible change.
> >>>>> Not completely true though. Try
> >>>>>
> >>>>> echo 18446744073709551616 > /proc/sys/fs/file-max
> >>>>>
> >>>>> on a system you find acceptable loosing.
> >>>>> So this is an acceptable user-visible change I'd say. But I'm open to
> >>>>> other suggestions.
> >>>> I am not saying this is unacceptable. I just say this is a user-visible
> >>>> change and so should be documented somehow. BTW, you cap the max value,
> >>> Sure, I'll update linux manpages and I can CC stable on the next round.
> >>>
> >>>> but not the min value. So there is inconsistency. I would say you either
> >>>> do both, or none of them.
> >>> The min value is 0. I don't think it needs to be set explicitly. I just
> >>> kept the max value because it is != ULONG_MAX but LONG_MAX for file-max.
> >> I think you are making the change with just one use case in mind. This
> >> is a generic function that can be used by many different callers. So any
> >> change you make has to be applicable to all use cases. You just can't
> >> assume min is always 0 in all the other use cases.
> > So, any caller that calls {do_}proc_doulongvec_minmax() must want an
> > unsigned long lest they are calling the wrong function.
> > The smallest value for an unsigned long is 0. So if any caller wants to
> > get into a situation where the caller needs to be capped they need to be
> > able to set the value to lower than 0 which they can't since they are
> > requesting an unsigned. So I'm not sure it makes sense.
> >
> > Christian
> 
> There may be use cases where the developer may want a min value that is
> bigger than 0. As I said, you can't just make an assumption here.

Sorry, I'm not following your argument anymore. Why exactly is this
function not already handling this case and what exactly does break with
my changs?  And what exactly do we gain from setting file-max to extra1
= 0?

> Otherwise, what is the point of the following check:
> 
> 	if ((min && val < *min) || (max && val > *max))
>  		continue;
> 
> Cheers,
> Longman
> 
