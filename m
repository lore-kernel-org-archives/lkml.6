Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BE9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007C7214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="rxwLq5vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007C7214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeIZTVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:21:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41345 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeIZTVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:21:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so4722647pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 06:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rdRq66r569w9WeOYmdeZNug1blty10t+0CACVTSe3pA=;
        b=rxwLq5vwrfD2tp//4pdwR7CDSijdH4FKhjHnRqnRhCAfZLVWMhuy2DrITzq2lrIZD1
         D78AKF9n4gI63Zlz5ZcqFdPY5nEC/8HAbnG2T6ScnyzRJo9zHj3VM0ZFiTHo4M3iyGU/
         4DaIfbo4X7FT4EyBmh2bXaLOFnfvF+Cr9+Wn9WRm+0JRCiaBIZu7KcdvXwGob4u1WcPk
         N+1oRd3TKsjZEulShPnPZDIfb/n0A8WkWQ6bEWJ4N/iA9OYbmbZBZgS6CHXgJnw5DjvY
         C0bL3OUkbhFRzdOoAZxlUOZsvpXH5o3N7jHMaCKAIdNE3tPOxmjwyeKQNqnBuNlAgD0Q
         BORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rdRq66r569w9WeOYmdeZNug1blty10t+0CACVTSe3pA=;
        b=q7XaJL+WoVyyg3GBMoJDEbkYDdtgvC0cXWFA2/WAg+NLU3UvceTjbOdhWcJqwsL+Rh
         u+RsZlkM8OnyY3H+K17Ib7a+AegV2Kcp6E8Fs8qflE73CZVQfJtb8Aap3zKFk0gur38f
         Zy4Xefqlf1gNG7WimwKwfZsPeBo3BFbJiPTHTNcWiNoWYKbpTmfsAieJWyVM4WnfFL8s
         fnyLVfz/dY9UCVWhYf+8EV3UVwBbFmb5GLbkzia6LY9QWlTQ2O0V/op4MUztxgfT811a
         iBvJBiWfzI+7ZB6DwzATGU+R65nZ0CHYlGT3jABpU18dkaV0Nohj9nDfZNLO65gjBAC7
         6AGw==
X-Gm-Message-State: ABuFfogxtES0035o+/6CW5q64zR0VifLWYuS7oGB2WdSM7ESRMYhPj08
        g8nHW+CiRgiPgo2iuGwSh5ZveQ==
X-Google-Smtp-Source: ACcGV60YPQ/LZxiW4hOIWJGBY5UkEB8+xq7rYBk1jSWL7ARAHy5bXLy72vdrmxt+NhDtJKPBwcZj6w==
X-Received: by 2002:a63:5f05:: with SMTP id t5-v6mr5560403pgb.352.1537967339389;
        Wed, 26 Sep 2018 06:08:59 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id 142-v6sm7407596pgg.54.2018.09.26.06.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 06:08:58 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E4AA9300029; Wed, 26 Sep 2018 16:08:50 +0300 (+03)
Date:   Wed, 26 Sep 2018 16:08:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: linux-mm@ archive on lore.kernel.org (Was: [PATCH 0/2] thp
 nodereclaim fixes)
Message-ID: <20180926130850.vk6y6zxppn7bkovk@kshutemo-mobl1>
References: <20180925120326.24392-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925120326.24392-1-mhocko@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 02:03:24PM +0200, Michal Hocko wrote:
> Thoughts, alternative patches?
> 
> [1] http://lkml.kernel.org/r/20180820032204.9591-1-aarcange@redhat.com
> [2] http://lkml.kernel.org/r/20180830064732.GA2656@dhcp22.suse.cz
> [3] http://lkml.kernel.org/r/20180820032640.9896-2-aarcange@redhat.com

All these links are broken. lore.kernel.org doesn't have linux-mm@ archive.

Can we get it added?

Does anybody have good enough archive of the list to get started?

-- 
 Kirill A. Shutemov
