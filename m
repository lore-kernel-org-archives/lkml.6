Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73802C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0B0206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP8JUw24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0B0206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeKUCOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:14:00 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43312 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeKUCOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:14:00 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so454198qtj.10;
        Tue, 20 Nov 2018 07:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SM4C77HJsk3VZeoo7j2DXFW5SgWyxknbONhZKcDfceQ=;
        b=NP8JUw246bZpGQJ/j4aJD6AVvEi/6N6xyn4YStgKbtJP1B9pxU4T6lCDvjX/U7vge8
         8UPsXdHhOcAp/sE+P5wl7HHytNW9CRmuNngsjBLPPro27x+YIEFP3JGyjeuvmLXM9L/W
         CbN8OAnB0iJ0Z0ORhPfRQKhiwnbIqHME/XtUDOhLUQ1qID7EplQYxk9A3udALGUfhIEh
         4zYBZz12NRTyhpu5MlvrZwVZlpE+LsS25Yfj1b/hGKumfO0gadeiX3JcFlhW6BfMeOwh
         JS5hSmCkM5JVIudZl+aQ1srGDv5bi/QPSwtq0blvmod5unhoXMwX9A3e5FbUNNi87jXI
         PTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SM4C77HJsk3VZeoo7j2DXFW5SgWyxknbONhZKcDfceQ=;
        b=CGG6GrzGTg4X4S1OU+Scwodw4dA5TKayWDA4wdJrV8uWb4ihuGQ2wDHZf7vQSOfefb
         NrRqmuuyAch68A2jF7TnLtnCA/ryMSNYK1GMAOhbf/tvufp8PG8Wrjn/qFwzzx5qRwiK
         9yXmQNvNBxrH/HF2XbvCNZYs4wPW/j0VutyLydcKdGc2veMMejRisvfA93KbolKV5GrQ
         vk/1XQjFNSaxhLxZhVvV2B0wO0Z5dDNSSEg23UfOClbLIPF1wte7GZY9S9N1jYY9eciF
         Bta+BZMfgbbPzjo13ewY6haupUJcUa/doDDo6ExzjkboTt829O9oQLjOYVY/dbNIu1Fk
         pAtQ==
X-Gm-Message-State: AA+aEWZESGCa/Gc2+RH72v8W0kSImtGAPXK7bkSXakfAa/ZMC3pI0ewf
        6H1TioTfHcJ5dQSEIYel96g/5ei+
X-Google-Smtp-Source: AFSGD/VjwmNGBOEKsCDVznPkDyAhgitPkgJr8eHqfrcRiyupcjR54bFznjkxlYqLuINbswzhvz97Kg==
X-Received: by 2002:a0c:b786:: with SMTP id l6mr2389247qve.244.1542728654022;
        Tue, 20 Nov 2018 07:44:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:4b6a])
        by smtp.gmail.com with ESMTPSA id x19sm22515759qtj.5.2018.11.20.07.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:44:12 -0800 (PST)
Date:   Tue, 20 Nov 2018 07:44:10 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH cgroup/for-4.21 1/2] cpuset: Minor cgroup2 interface
 updates
Message-ID: <20181120154410.GQ2509588@devbig004.ftw2.facebook.com>
References: <20181113201339.GN2509588@devbig004.ftw2.facebook.com>
 <20181120124624.GL2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120124624.GL2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Peter.

On Tue, Nov 20, 2018 at 01:46:24PM +0100, Peter Zijlstra wrote:
> Why though? The Changelog doesn't give rationale for the actual changes.

Ah yeah, sorry about that.

> And I'm not sure I agree with either one of them.
> 
> The partition is a scheduling feature;

So is everything with cpuset.cpus prefix.  They're all modifying how
scheduler handles the cpus.

> and I like 0/1 much better to type, so why not allow that?

Mostly for consistency and it's generally better to keep interfaces
minimal - e.g. what if we need to add support for more key words to
the file?  Would we assign incrementing integers to them?

Thanks.

-- 
tejun
