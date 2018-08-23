Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9864EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 22:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA3F208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 22:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JiR+cbUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA3F208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeHXCRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:17:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33750 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeHXCRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:17:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id 60-v6so205133ple.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9LvequIgAEL+fZ/06R6fuuZhed0pkreHswh9z15WO/o=;
        b=JiR+cbUj6mBq9DEra5PBjRJdZ3QqPLDinN022+8jxtgtJvggNyS8spGKO8TPIqATSy
         ERj0za5JPCY5MMiSDPN815QUQDcX3uODGBfs71DhOrwr+2ddpxYCLVOmoAaO7jDHvDVb
         r6t+dYv45np/OtfqtC0RszdBxu1x5Hiw65XGDdv0LTUaJbHX/i9zE72F4lI3q/zDE0iY
         MRku50aoMH8vUGLLvux3X5RmFfzQHubzP5fjnBosz19qk5eS8Sem9FUzeAbwuLCXc6O0
         oEyipaOTsrdlAm3UpsRH5TJeo2gqENAfOuK6XlA9eIv/pNAQooqUFe0MbKmPgQCVNWqj
         7UCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9LvequIgAEL+fZ/06R6fuuZhed0pkreHswh9z15WO/o=;
        b=UMWmDRhDeQ9zwAUpqaWOSZburR803MINAK/fquntYMN3DLzwSrUHRQik6YQwQNTh6K
         2HNlJnxMAv3JrIMlTso1nltBohgAZx4GlZ41y7Ig3AezUXBw17dt4h1EjHdJTLY0UHog
         mA77/pCERvt7hqR4kvmBHEKDjICothE4zTR2P5J8j4BNUkZolvq4C08Zv+Cib1ERr5T/
         iba3QyB0jx04bAxNhrnCTZZ+Xy8fMjFFm/oHFDxFDZrrqeFMyaNuCb0pkT5yyVY25BN2
         LmgILmBMgsELbBAEtoW/xnpciYWPyiLxVBvCAn9+Z483Gm9lHGxtQUKpr+t0q3qPYTCp
         OYLg==
X-Gm-Message-State: APzg51BBoBIF+Cgofcr67Hi1yTnBKPB6DK8zA+V7gE0A+clDtSBSGFEY
        oCc53R/YDrjDovS0X2COSyPLFA==
X-Google-Smtp-Source: ANB0VdZG3DU/3TQI1aZsFaQeXtllVNyliXOnL6lTKroKX2mgtYlhNPfs8uv2fj5cS19gWxrL95hTuQ==
X-Received: by 2002:a17:902:bc8b:: with SMTP id bb11-v6mr2880122plb.112.1535064347371;
        Thu, 23 Aug 2018 15:45:47 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j27-v6sm10229683pfj.91.2018.08.23.15.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 15:45:46 -0700 (PDT)
Date:   Thu, 23 Aug 2018 15:45:45 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
 should_reclaim_retry().
In-Reply-To: <cb2d635c-c14d-c2cc-868a-d4c447364f0d@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.1808231544001.150774@chino.kir.corp.google.com>
References: <9158a23e-7793-7735-e35c-acd540ca59bf@i-love.sakura.ne.jp> <20180730144647.GX24267@dhcp22.suse.cz> <20180730145425.GE1206094@devbig004.ftw2.facebook.com> <0018ac3b-94ee-5f09-e4e0-df53d2cbc925@i-love.sakura.ne.jp> <20180730154424.GG1206094@devbig004.ftw2.facebook.com>
 <20180730185110.GB24267@dhcp22.suse.cz> <20180730191005.GC24267@dhcp22.suse.cz> <6f433d59-4a56-b698-e119-682bb8bf6713@i-love.sakura.ne.jp> <20180731050928.GA4557@dhcp22.suse.cz> <d11c3aa2-0f14-d882-59c5-6634dc56eed1@i-love.sakura.ne.jp>
 <20180803061653.GB27245@dhcp22.suse.cz> <804b50cb-0b17-201a-790b-18604396f826@i-love.sakura.ne.jp> <alpine.DEB.2.21.1808231304080.15798@chino.kir.corp.google.com> <cb2d635c-c14d-c2cc-868a-d4c447364f0d@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018, Tetsuo Handa wrote:

> > For those of us who are tracking CVE-2016-10723 which has peristently been 
> > labeled as "disputed" and with no clear indication of what patches address 
> > it, I am assuming that commit 9bfe5ded054b ("mm, oom: remove sleep from 
> > under oom_lock") and this patch are the intended mitigations?
> > 
> > A list of SHA1s for merged fixed and links to proposed patches to address 
> > this issue would be appreciated.
> > 
> 
> Commit 9bfe5ded054b ("mm, oom: remove sleep from under oom_lock") is a
> mitigation for CVE-2016-10723.
> 
> "[PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
> should_reclaim_retry()." is independent from CVE-2016-10723.
> 

Thanks, Tetsuo.  Should commit af5679fbc669 ("mm, oom: remove oom_lock 
from oom_reaper") also be added to the list for CVE-2016-10723?
