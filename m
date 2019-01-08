Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA92C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA8721019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546962037;
	bh=MfKxa9WFo3o5zJR2JfajSRtL0AIyUtUfLnxxV6BOsfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AHl0wGqFPQ715RrJH76c4RRuSqHmaLJXlEvg/gHjEtUErqQQOryL9WgdZOV11XaDn
	 mF0TUEULaPXsvOcLqxFTQy7HUsBVTF7PaBC7tUMopaJrwLByGqxIHRibPJEyykpwzm
	 l5DW7gVghw3CAK8917sbXuIgF+UnbxFUxEfTZsvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfAHPkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:40:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:35168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728238AbfAHPkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:40:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3565B0BF;
        Tue,  8 Jan 2019 15:40:32 +0000 (UTC)
Date:   Tue, 8 Jan 2019 16:40:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.0-rc1 (test results)
Message-ID: <20190108154031.GB343@dhcp22.suse.cz>
References: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
 <20190107192648.GA10789@roeck-us.net>
 <CAHk-=wjt6oKtYuJ-EOGSO1m8vBdPa+g2_6WZ6MKCwfu4afoSrw@mail.gmail.com>
 <20190108095107.GA25409@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108095107.GA25409@guoren-Inspiron-7460>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-01-19 17:51:07, Guo Ren wrote:
[...]
> static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> {
> 	pte_t *pte;
> 	unsigned long i;
> 
> 	pte = (pte_t *) __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> 						     ^^^^^^^^^^^^^^^^^^^
> 						     It's necessary ?
> 						     x86 & arm don't use
> 						     it.
> 	if (!pte)
> 		return NULL;

That depends on whether you want OOM killer to be triggered for these
allocations. If you add the flag then the allocation bails out with a
failure rather than kill an oom victim.
-- 
Michal Hocko
SUSE Labs
