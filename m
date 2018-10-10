Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260C5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B5420835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B5420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeJJRAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:00:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53224 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeJJRAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:00:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so4706911wmw.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 02:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q46N/Cig/LEIA9U22CIkDbnUUw9Tof6cjCzl8SQ4bKI=;
        b=fESkw4BDZZHgGBBouii0K2zQYQMc4xfZfFfvgG/LFYNBF7AH5OLOMxLSukE/ED/z+R
         8Qy1y+3m6Zct/fU+qc15ZGWtERbfRW8W5ImGkRJKrRh8HNOjVfj09NjwG3ziUGv6n5yN
         YvzYVAd2RSnwa70NuXCSbpToD24jAgnr1QNDIN1ZwQ9/lx1vZPsu411RrGwbbdxOOtYo
         63f8thvMrceirwtvpLgFNRqFbAxI/uNH9jgMvOdlFqcnCe1jJy9bRPk92jebqHg6CWNJ
         nMhsW8Swt0oH/8au12HbjU0PraQdgRl52AHzB6xIkXD+o9BLv4lB93c11O6mAamZrnVo
         2+MA==
X-Gm-Message-State: ABuFfogn4a4cSmYb1VNJeJPHCMUVk5Vw02MdXdeTICPeoaoq3vTWYEcw
        Of0CpHJZw94SjgYN58ccywg=
X-Google-Smtp-Source: ACcGV62DTXCcbPwJL3wQj2bVrNZNjNfCPyv+sqtoHVPVKzoEsDRYz4S2dqiYVuw0LhcaJIEgP5HCkw==
X-Received: by 2002:a1c:2dc5:: with SMTP id t188-v6mr219547wmt.94.1539164349444;
        Wed, 10 Oct 2018 02:39:09 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id u76-v6sm31355346wmd.10.2018.10.10.02.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 02:39:08 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 1D817125018; Wed, 10 Oct 2018 11:39:08 +0200 (CEST)
Date:   Wed, 10 Oct 2018 11:39:08 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3 2/3] mm: return zero_resv_unavail optimization
Message-ID: <20181010093908.GA20663@techadventures.net>
References: <20181002143821.5112-1-msys.mizuma@gmail.com>
 <20181002143821.5112-3-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002143821.5112-3-msys.mizuma@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 10:38:20AM -0400, Masayoshi Mizuma wrote:
> From: Pavel Tatashin <pavel.tatashin@microsoft.com>
> 
> When checking for valid pfns in zero_resv_unavail(), it is not necessary to
> verify that pfns within pageblock_nr_pages ranges are valid, only the first
> one needs to be checked. This is because memory for pages are allocated in
> contiguous chunks that contain pageblock_nr_pages struct pages.
> 
> Signed-off-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Looks good to me 

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks
-- 
Oscar Salvador
SUSE L3
