Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EFEECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7605A20672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7605A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJ1PLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 11:11:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:57466 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbeJ1PLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 11:11:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2018 23:27:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,435,1534834800"; 
   d="scan'208";a="91801189"
Received: from rwang-mobl4.amr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.211.80])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Oct 2018 23:27:22 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gGeXi-0003Y2-4o; Sun, 28 Oct 2018 14:27:22 +0800
Date:   Sun, 28 Oct 2018 14:27:22 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: simplify get_next_ra_size
Message-ID: <20181028062722.hfomc3davarmzojw@wfg-t540p.sh.intel.com>
References: <1540707206-19649-1-git-send-email-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1540707206-19649-1-git-send-email-hsiangkao@aol.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me, thanks!

Reviewed-by: Fengguang Wu <fengguang.wu@intel.com>

On Sun, Oct 28, 2018 at 02:13:26PM +0800, Gao Xiang wrote:
>It's a trivial simplification for get_next_ra_size and
>clear enough for humans to understand.
>
>It also fixes potential overflow if ra->size(< ra_pages) is too large.
>
>Cc: Fengguang Wu <fengguang.wu@intel.com>
>Signed-off-by: Gao Xiang <hsiangkao@aol.com>
>---
> mm/readahead.c | 12 +++++-------
> 1 file changed, 5 insertions(+), 7 deletions(-)
>
>diff --git a/mm/readahead.c b/mm/readahead.c
>index 4e63014..205ac34 100644
>--- a/mm/readahead.c
>+++ b/mm/readahead.c
>@@ -272,17 +272,15 @@ static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
>  *  return it as the new window size.
>  */
> static unsigned long get_next_ra_size(struct file_ra_state *ra,
>-						unsigned long max)
>+				      unsigned long max)
> {
> 	unsigned long cur = ra->size;
>-	unsigned long newsize;
>
> 	if (cur < max / 16)
>-		newsize = 4 * cur;
>-	else
>-		newsize = 2 * cur;
>-
>-	return min(newsize, max);
>+		return 4 * cur;
>+	if (cur <= max / 2)
>+		return 2 * cur;
>+	return max;
> }
>
> /*
>-- 
>2.7.4
>
