Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94C7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790AF20841
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5gqgOg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790AF20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbeGLUTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:19:31 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44004 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732355AbeGLUTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:19:30 -0400
Received: by mail-yb0-f195.google.com with SMTP id x10-v6so11887411ybl.10;
        Thu, 12 Jul 2018 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QDWhokhxPbRHqNeP+G9O/mtYZ0lyz3BTOD9tObyaEQw=;
        b=V5gqgOg3pmg6RX4kQtl0dsS8DOwsJ/ygyvEadMnbmOUU8pTUsi8Nsb+FqldfJsMjRo
         woKvSeGxqNp9ODD/hCj9UcZwCE1cnpg6ukDFHt++tk2NTHC+cIE7/LtEzHe8rA9+re/y
         Sx3Pgki8hxzrv4jSLF7+LpzivCRZe9bcrqx48HhgxM0c+8rEeTWgBhBuQeAJ3WQ9hKJa
         qqogSpTTlevgST8BZ/nzFk4ludqBRjT3aJBA80CbY0dvsjnMJe7xvl8vGCWud2ROsMzh
         XCrfVzHK95knXddegf8oGw6MBYGfPHv2xauN3KL/nJotANMOpxIgEZsIpkbqIdwTLr8D
         YUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDWhokhxPbRHqNeP+G9O/mtYZ0lyz3BTOD9tObyaEQw=;
        b=H1I21JVNFE0pLd5AG/jIGfCzxnVeg//0Fi0iqx8g7hB7LXHPMESlKetZX3qxJadYZF
         E7Vwmc1W3NDN2L4OVZMN6bfrxPOjkWImgOzUNCCtcQ7/JHx7+sIo5DAcCNlhu3CMbLx/
         0FtJuzHgaVXfgoPSqsGjek8DjE61xou7QKoRgvateKUIinrYhiwDZh+HYJNn/cQitr3v
         LbnVv1M/FNZ4P+XZ03bFPp/6Gwovz5k5jF253DXdrth5I8FNVL2F9UqcwSU1x3F0NBdB
         MeqMHm2o3x8IlpaoohAd5aVXkIgv+3Tky3LLSUH3mdJi4jVlOHRlCKXjzMBkE86/TGQ4
         WMsw==
X-Gm-Message-State: AOUpUlGamZVVSLx8Ql5YxfQw0hVT3rUhTdRhdXwRMi2H0bm9t672rULP
        EOjmu87ZWQb88TGHRWbRi90=
X-Google-Smtp-Source: AAOMgpccGC2RhMAGFB8LlekRRTH2rmJ/WHkRtUUqHhqYu4h3jkV3yliB6xkcOIhnLcLF1J9/Ur+XVQ==
X-Received: by 2002:a25:1084:: with SMTP id 126-v6mr1997621ybq.340.1531426104180;
        Thu, 12 Jul 2018 13:08:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:a01e])
        by smtp.gmail.com with ESMTPSA id d11-v6sm10191126ywd.1.2018.07.12.13.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 13:08:23 -0700 (PDT)
Date:   Thu, 12 Jul 2018 13:08:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 09/10] psi: cgroup support
Message-ID: <20180712200821.GN72677@devbig577.frc2.facebook.com>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-10-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712172942.10094-10-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:29:41PM -0400, Johannes Weiner wrote:
> On a system that executes multiple cgrouped jobs and independent
> workloads, we don't just care about the health of the overall system,
> but also that of individual jobs, so that we can ensure individual job
> health, fairness between jobs, or prioritize some jobs over others.
> 
> This patch implements pressure stall tracking for cgroups. In kernels
> with CONFIG_PSI=y, cgroup2 groups will have cpu.pressure,
> memory.pressure, and io.pressure files that track aggregate pressure
> stall times for only the tasks inside the cgroup.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route with the rest of the patchset.

Thanks.

-- 
tejun
