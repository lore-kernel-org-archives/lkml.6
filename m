Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8986C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA182146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546118784;
	bh=Zo/h59cn95R/v4d0XxAmTX9yZPvCjn9nJ/pSPyVVP1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VO9HS+t0q2Zbi9McxSTLTeE+a1rfD8hbUe1ZbAlT07d+ChFUXZYFEvbc0XtAePQwc
	 HuDqGyh/4PGcwee/O1sE3nGJy6OEVeZvVKx8AQYcJ22Mt4H+oQyQSvC0Rs6PVttiFJ
	 YW4RwAyp4gR3AG012Z/G8VmKickqtUDE1IcanhEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeL2V0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 16:26:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45036 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeL2V0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 16:26:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so11830951pfh.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 13:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9s7KH+N4XjN84bfMdgoqFceiWJ//7x9bEjKqaL1ztgk=;
        b=BVr+WlGqVSxa6D2XDT/ufHYQk2SvNMNWlNuLhcixeine4W2LA6q7adNJpR8WUEUM7n
         90R4th2NCKgwxw7BHFtoMBTTp1yMWXJrIroxH9GepYvfCCvaWaHjvzCjszcszHsCVdEv
         DKhiK1U8P1/M4ozVHP7mrwbjMMYIEHSs45uResz0WskLqZVSWJf62/EvaWQsh/fVbnX5
         SJ1Myl2fkFlBZe+dbD0ljysdFhEKrBMHMvHVcO5TDK/ORllT1RVztSSjeQEf6iUh4KXA
         1jeLKcOjEDUWcQaKHTE7tzI3YhvrMaztTYQAfAiG1QLOyWtXRAgYi8peBlzEHzCH93K8
         ar2w==
X-Gm-Message-State: AJcUukfIDlrh8p5G1/BCVnjkzYg3/D56rxzba4P/q2UpuhMjXWukIR+w
        O25cgFfsaIXVKXStr/xgT6s=
X-Google-Smtp-Source: ALg8bN4RHuIisYqSx997hpsEEMjWTO+Sq37LGNjSGipwCd/MiNrODhd7PnmxfmYQwBbx9sYvRZG2Cw==
X-Received: by 2002:a63:c051:: with SMTP id z17mr2720037pgi.20.1546118782544;
        Sat, 29 Dec 2018 13:26:22 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c090:180::1:8c74])
        by smtp.gmail.com with ESMTPSA id l3sm71656435pga.92.2018.12.29.13.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 13:26:21 -0800 (PST)
Date:   Sat, 29 Dec 2018 15:26:19 -0600
From:   Dennis Zhou <dennis@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: plumb gfp flag to pcpu_get_pages
Message-ID: <20181229212619.GB73871@dennisz-mbp>
References: <20181229013147.211079-1-shakeelb@google.com>
 <20181229130352.8a1075da5b7583d5e0e4aa9a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229130352.8a1075da5b7583d5e0e4aa9a@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sat, Dec 29, 2018 at 01:03:52PM -0800, Andrew Morton wrote:
> On Fri, 28 Dec 2018 17:31:47 -0800 Shakeel Butt <shakeelb@google.com> wrote:
> 
> > __alloc_percpu_gfp() can be called from atomic context, so, make
> > pcpu_get_pages use the gfp provided to the higher layer.
> 
> Does this fix any user-visible issues?

Sorry for not getting to this earlier. I'm currently traveling. I
respoeded on the patch itself. Do you mind unqueuing? I explain in more
detail on the patch, but __alloc_percpu_gfp() will never call
pcpu_get_pages() when called as not GFP_KERNEL.

Thanks,
Dennis
