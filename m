Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED8C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A8D206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaAAT+sU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A8D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeIKV2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:28:35 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37634 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKV2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:28:35 -0400
Received: by mail-yb1-f195.google.com with SMTP id f145-v6so9562462ybg.4;
        Tue, 11 Sep 2018 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SgKXe1P45yrdUnFpQp9xAddHz5/gmeVY6MVbuy+BCCg=;
        b=UaAAT+sUwXVbXb8s3DcUgxHFsLTmcuMKCetZxFlQfQUfUFDiAmO7J0GfqW6FUu9k7B
         fv3XTM2+4AYGWG5LRoeZ+PIG1L09WOxaaWxRUpyiRMOqUj/ZeQIUZrRko/JFshhYKDDZ
         iIbT2XB9mF0Z5x+NRjoc0FRq3d7z0i5t7WuSuCBcpD5r33FcJmDhL4SV8GgES/eTGV4W
         BFOwVdIHM+pA+8fpapPJZ6kjgGJiMe7RLZshwjLGqjUW/V3RG1ID3TnPyztwv+fQKn2X
         ed5XzY5KSB3dd6hupSKhQaFU0gQ+swXKnyHTFJZ6XM1ojHoIakkMbsSFAKWdd4/r+ngS
         +n3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SgKXe1P45yrdUnFpQp9xAddHz5/gmeVY6MVbuy+BCCg=;
        b=K7QHesGS38KrW/H2OhwB/9c0k8BzO1KrOyfyFbZaYn5V+XJDwahNLBNTH/B5VgFA7G
         1fcVYTECVIco/vowjO7Vv9k6X49vUxHGxsjsf6tF7Y20biQusUnmNiw79b4rNIUGYXcI
         e+riwfUNIku+jsk+3nQq3OVHfir9DxtofhnO2FabZKQ5YWxdQEDEd0VRFQXoroF2CE+n
         SZixeobttbPDMwE7gxl6X0FWsd2Pvs4O8WrJBEyc2ZF4GOp82WwtBold4lmlGQuaQJDt
         5gm/ebLxP3hBpB0GsjNsxbkJqBx2uTXJpvlX37YqmoQIHAEwnkGt4y3+DaT0j+Qhs/gi
         uGvQ==
X-Gm-Message-State: APzg51A53mF339VCio4ubIkoi5epYRE5cMCZCSy49puTXx/Az2sYAHTd
        fYtaAJ9QIa4qRTCdivb4MJs=
X-Google-Smtp-Source: ANB0VdafITz7InCSQo81eIukv99W/SEIG4NavXMskQRFxnOFEIJ1WRG8KmIvdp4vJsjaltE18XTSsg==
X-Received: by 2002:a25:f212:: with SMTP id i18-v6mr13107392ybe.267.1536683311316;
        Tue, 11 Sep 2018 09:28:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6304])
        by smtp.gmail.com with ESMTPSA id h63-v6sm7541562ywb.28.2018.09.11.09.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:28:30 -0700 (PDT)
Date:   Tue, 11 Sep 2018 09:28:27 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 08/16] sched/core: uclamp: propagate parent clamps
Message-ID: <20180911162827.GJ1100574@devbig004.ftw2.facebook.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-9-patrick.bellasi@arm.com>
 <20180911151819.GH1100574@devbig004.ftw2.facebook.com>
 <20180911162624.GB1413@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911162624.GB1413@e110439-lin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Patrick.

On Tue, Sep 11, 2018 at 05:26:24PM +0100, Patrick Bellasi wrote:
> My question is: IF the scheduler maintainers are going to be happy
> with the overall design for the core bits, are you happy to start the
> review of the cgroups bits before the core ones are (eventually) merged?

Yeah, sure, once the feature is more or less agreed on the scheduler
core side, we can delve into how it should be represented in cgroup.

Thanks.

-- 
tejun
