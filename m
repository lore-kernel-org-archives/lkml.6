Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A365920854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMZc31jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A365920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbeGRQKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:10:08 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:41679 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbeGRQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:10:08 -0400
Received: by mail-yb0-f175.google.com with SMTP id s8-v6so1992702ybe.8;
        Wed, 18 Jul 2018 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hR+qD/rstAfQOlQkLYPzveTTy2nQYci9SLbQtsf9TfI=;
        b=sMZc31jhwq9tu4K/f0rBurhN0Hpa+rkT0/9jX9xSiSQF3nFbe87mIpEQY6aXK+t3k3
         SR3a5suk1TX1lgqqOJ9djyBEmB5Z+mSDOd8CGS1I6qq9w5oTNAAPyRzbA2rJoPbUP4hz
         DlC9f445y24coOLwjQyLpsVzs2JQJPS1AVY53zrWhVv0XZEN6tzOe9gATcQZYDCEErKT
         2D48L1LLAE4h23oQ6b6UahXV7IIjBK+n2uVBbvbwZpSCJZ1hc3jEdC6lLkb6uXGnXXZK
         jDiX9Ixul6z2OvIvpjA8wiPSf2QWv7S0fj9WuBGVNpebCaIHbRngkbKrY2W6TSdAteVP
         RPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hR+qD/rstAfQOlQkLYPzveTTy2nQYci9SLbQtsf9TfI=;
        b=KeOoty7t+pxH8rRRKrP+n4Im1kakBQJsYSTtr1eBbLRJRT2+atMIxaV2EDLtVDb4Dx
         oUh+Uq3kjM4lGo8vS8iHTzu1dKo20bYN72LCCuEAnTwwpkk1P7Hi6ck51W1c8ocY1FYa
         iXh3ThVKbTw6pvCtsSfLvnB5vEjSoUyTJw/6WX32wCgwVjVbpZGI4xMHnCq13lDExB3c
         giNuWK8sUHQOHkxM8b7oIAqNqdjfVPR5IBr6oD20/s5zbIGn8P7NRJzlLrO9JwYYNrzA
         gBywRtd0gSPeuDFDk0zfmsSkUwjRuUIHc0zvkaHN7BX84/cibf+/PnUdfmJE8X9Bb89W
         nKnA==
X-Gm-Message-State: AOUpUlGW7+MTkgI5YAUAIYCGEzqyr4CBib0slCB9BJL2RaWXEcZvqCJ1
        wgLRy+QvURraI3cWQnnN8LFTTOGd
X-Google-Smtp-Source: AAOMgpfqwFRutIEdLHIldf8r+nxrIo8dwcStaSerhbbTZ97AeQTzXme7RQRgNO+V42yhzKCQG34QBg==
X-Received: by 2002:a25:51c1:: with SMTP id f184-v6mr3398581ybb.81.1531927901787;
        Wed, 18 Jul 2018 08:31:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:eedb])
        by smtp.gmail.com with ESMTPSA id 203-v6sm1129211ywv.34.2018.07.18.08.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:31:40 -0700 (PDT)
Date:   Wed, 18 Jul 2018 08:31:39 -0700
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
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v11 7/9] cpuset: Expose cpus.effective and mems.effective
 on cgroup v2 root
Message-ID: <20180718153139.GQ72677@devbig577.frc2.facebook.com>
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
 <1529825440-9574-8-git-send-email-longman@redhat.com>
 <20180702165322.GI533219@devbig577.frc2.facebook.com>
 <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
 <20180703155823.GS533219@devbig577.frc2.facebook.com>
 <4cf9924e-7b97-187f-a1f5-853a45165abb@redhat.com>
 <151fc655-7e29-f060-789e-ee6c5c23d132@redhat.com>
 <a1eb4971-ff23-6fd8-d75b-112d63f0aee9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1eb4971-ff23-6fd8-d75b-112d63f0aee9@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:21:18AM -0400, Waiman Long wrote:
> What do you think about this patch?
> 
> Are there any other issues you have with this patchset?

Looks good to me.  If others are okay with it, I think we're all good.

Thanks.

-- 
tejun
