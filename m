Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038A7C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A685F21569
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L94cxNaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A685F21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387407AbeHBUku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:40:50 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34579 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeHBUku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:40:50 -0400
Received: by mail-yb0-f193.google.com with SMTP id e9-v6so1664327ybq.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 11:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sh9q1tVAuVTsAnQRkgUYSdoh+aHCoe/FoG3NQTBSJF0=;
        b=L94cxNaZEuTPp2qgQ85mo8E3NwP+3IWsZVi5e9DxgP59TIlfv79Ym3rlhvkaUfrKBN
         Oo24mBbv1Wt79i1b0aKwWrjoM0P45jYY4PXUgs+0Fwxs+SL21MnBD8F60vzOfLWRqmbY
         7BPxclbN7b0M2uCXU18Q1goInSh1JCe6g94GfnHyB0CzraeDS7zWkkd1EWaJYsVEUD21
         jVwBA7A49E5fEqDtH0awkwJwCM81kmK6P5CfeGoasf6eZpLQFBkgSZS7G62+QvTBwmNt
         3qu/nhFXNc1PFnsEH4kWR67m5AxHToFJHxf9w05+zlVLC5Gugn4Fprj0R9Y/qZdp6VOa
         0wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sh9q1tVAuVTsAnQRkgUYSdoh+aHCoe/FoG3NQTBSJF0=;
        b=kpYBOkkm4TM0rNPKRNaYUwPRIYAeGOCzfaNoPtIJZmhVuX/pjqzRaOeoza/CU/0QIQ
         oyTP87cHF6ApPpAXryCmdOwFSEmEOisJOTXVtE4Sv0PH/zjzauBN5X+Plj26pqV5T20P
         TbiXgIkOCStcS8Yrx4yPKdexeGRP7F2UYgocoYaePc4FiocdUPcxsKHvLvqtqHucqeNS
         madA6PB4XnUrr8NOH4XBjVajaRJBsAMg9Qnx4l8Hu2GrEWCB61jVyp1Ap2x1YePVChSK
         w3H/1AAfeCkpjRrLhA81l4t0DXKGeJIt3+TwUIWMZAvaPKMjsUbD/XNsy30zTwjE2V8K
         189Q==
X-Gm-Message-State: AOUpUlE+fCYxGRrTwy3IlRAESaC+9atBkImp93QPv5lLU/h6BJj3Z5/s
        qvPoWhpyg7trYhXif40wng8=
X-Google-Smtp-Source: AAOMgpeTIxXdar2EuU/TInJH13Vc5T+uM6rbdQZ6hOBtdPXCtKAgq5CchYc6YSrHht1yuXVgn1hIuA==
X-Received: by 2002:a25:5605:: with SMTP id k5-v6mr446213ybb.170.1533235708253;
        Thu, 02 Aug 2018 11:48:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:99d6])
        by smtp.gmail.com with ESMTPSA id l4-v6sm705893ywk.47.2018.08.02.11.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 11:48:27 -0700 (PDT)
Date:   Thu, 2 Aug 2018 11:48:25 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm, oom: introduce memory.oom.group
Message-ID: <20180802184825.GU1206094@devbig004.ftw2.facebook.com>
References: <20180802003201.817-1-guro@fb.com>
 <20180802003201.817-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802003201.817-4-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:32:01PM -0700, Roman Gushchin wrote:
> For some workloads an intervention from the OOM killer
> can be painful. Killing a random task can bring
> the workload into an inconsistent state.

For patches 1-3,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
