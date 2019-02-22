Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAC7C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D379C2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="iyFuHWDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBVSCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:02:45 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34808 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVSCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:02:45 -0500
Received: by mail-yb1-f194.google.com with SMTP id a4so1203025ybo.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0U6oTt6/Sgt3Nu8PhIORM2GAgTzgiX+4PSRFp/ODm9w=;
        b=iyFuHWDlZUT6BHswFDnmTxhNU0raC8a7XIB12MC8QKlcuG0i29Eko/N6xrRgmZhypz
         LzL7PwhcUg5WeOv4PmYSIm/a4xFU9fqzpQuZ+6TGQB4L5QVQuHDWb0WPjw4j5hSaJoZI
         2fh5xCEyOOTgAo6sULalA3UKqhXi4emKCz5ClnGTiHTbAYAOufVjzcim5x/p/w3thZP8
         QGF2wlV8lLS4DaAHe0rGFwH52eL5gFu39FZfRHtMs4KHdDgZ1JzpkYglcp3w5JAnlfxz
         RzJs0lcG5jVZlUx4KzBOPJlRaD/uNZrFRYl6UgALCxZkLkv31Fw19+r7UGPd2zNNvcAu
         BP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0U6oTt6/Sgt3Nu8PhIORM2GAgTzgiX+4PSRFp/ODm9w=;
        b=HAsPkwZYoBXoTdJafC+DAvvg1wQwSRRpHmBhHs85wNq5OSL39i5qT0YcgR3GMehj5o
         CgRHwcql69dujPw1fKodzJV7HmIV8I5jd9IAy0vYTAB8eoz+aKUEp5yypsuSW8HkRMRr
         2WcbQsCFsbvwkE8FSHQf1uAtcmiwRZREbj2m1E6XrVTleeyGKqKYVp8MePNeFcn5woZq
         zgoapUv6pSnLhcqQOJ9QFkd9zHg5WHdyCzvBOr0Eao8S8TNCQ2MVxr0wj+sD5NAbPUEd
         sdd1aw+3c2zbUZ/ZYqw3yoiV1ZyBIO6M+YhzellA+QCBTeGo9uxPycqDmkNj222VP97Z
         CHgQ==
X-Gm-Message-State: AHQUAuYg0W2N/ljS4UJVdUgNVS0MXgxm/easDqOkCynjwqfbhbGWApFz
        CWr4spMWqZyMJVCW9OyVPqjc3ZA8aIs=
X-Google-Smtp-Source: AHgI3Ibd/MTh5Q9gpkZz4igQpyJRmfcmB3hfLK858GyyaSg/R4wG5men+PZAksxMchFTM+ZhHLgURw==
X-Received: by 2002:a5b:34c:: with SMTP id q12mr4340807ybp.473.1550858564315;
        Fri, 22 Feb 2019 10:02:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::1:cd3d])
        by smtp.gmail.com with ESMTPSA id b7sm876522ywa.86.2019.02.22.10.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:02:43 -0800 (PST)
Date:   Fri, 22 Feb 2019 13:02:42 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 4/5] mm/vmscan: remove unused lru_pages argument
Message-ID: <20190222180242.GB15440@cmpxchg.org>
References: <20190222174337.26390-1-aryabinin@virtuozzo.com>
 <20190222174337.26390-4-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222174337.26390-4-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 08:43:36PM +0300, Andrey Ryabinin wrote:
> The argument 'unsigned long *lru_pages' passed around with no purpose,
> remove it.

The reference to this was removed recently in 9092c71bb724 ("mm: use
sc->priority for slab shrink targets"), might be worth pointing out
for context.

> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
