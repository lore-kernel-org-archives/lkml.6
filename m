Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA09C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162332085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv6QzhDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162332085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbeKFB53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:57:29 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37468 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbeKFB52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:57:28 -0500
Received: by mail-yb1-f193.google.com with SMTP id d18-v6so4053395yba.4;
        Mon, 05 Nov 2018 08:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5D6B8SZiDJWloZJTLfl8O4vQl7ln5NDRmJQc+XqseP4=;
        b=Kv6QzhDDiGVwesKpr09Smj12ROI23t+yHETDN2mC/n5VCP1cxi5lkMfplmQRjJ9RFk
         7yWiOAG4kVquv49U/n+3BUWenNmRx7lx5H+h733vYQ5kbRTzR7uZu9R17qu4WC5PfvZS
         M7wSvinTc0zBvoQLGhMucOV3HWyhY7wHpwfv4PjEcSPAj/bpiQvLUkoaJkags8XK1080
         gAtIw11DHCU6+DtzNAnlXbTJDD0WLvgt+56Aph9EqhTqDgbiIQdIvgh8W1AxxwhKIs8X
         vPTz4DPH/Ej4gxH/D3iGNpyECrjWMYDbKk9P7B01yUhgrA8j106UMBkVNw9v7fZmDvm7
         FL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5D6B8SZiDJWloZJTLfl8O4vQl7ln5NDRmJQc+XqseP4=;
        b=GDTcdw7msC5a63bqGO8Rqkx2jaki+WGVGJ/9f5GYI+avozCmV5vOKF0AeAwAMXVLt5
         RHMgE/ged1c+pG+cIos4SX/0qpheFpJG2aTWlBj/gdG5mF0harbFPUCPz5BcoR5GTgXN
         BFD4823caR6HQH4BxIWVZki+9shwer1jcJv8d2QsrWr+KOGpzg+vOg5kHdirvgu87Rv6
         TnbUzxi+JGIFoZoeWLtI3qAzHFaTF8ky4PEYevwhRH7nXkSQ/wuA4vSz3zHhHhkX5G0k
         FebrV19dHT1GJ+1ZMqiGWK+sqlP42KpGSV+jMap8cZodBZgkrlxECDp1UBYpTG9OkCa4
         fzEw==
X-Gm-Message-State: AGRZ1gKJ1dLbDaRKSzUW/q+OW1DhLAcO1FY1Cn8g0ts0cAdRRy2fy0ja
        /ZCervYB25MSd/Nra8fa95c=
X-Google-Smtp-Source: AJdET5dof9JpV3V+E7V2G3PvKyFqIa9TSh8kWGQw3HPstZO8+lKgi5I2tUg9wUhOsCNmjT00KneQSw==
X-Received: by 2002:a25:ec07:: with SMTP id j7-v6mr21456906ybh.405.1541435819098;
        Mon, 05 Nov 2018 08:36:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:b217])
        by smtp.gmail.com with ESMTPSA id m68-v6sm11381994ywf.95.2018.11.05.08.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:36:58 -0800 (PST)
Date:   Mon, 5 Nov 2018 08:36:56 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v14 00/12] Enable cpuset controller in default hierarchy
Message-ID: <20181105163656.GK4182586@devbig004.ftw2.facebook.com>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539635377-22335-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

So, this looks good to me.  Peter, I'm gonna roll the series into
cgroup/for-4.21-cpuset.  Please holler if you have any objections /
comments.

Thanks.

-- 
tejun
