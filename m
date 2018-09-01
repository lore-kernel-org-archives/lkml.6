Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DB1C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFEC2083A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9V3DeVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFEC2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeIAEmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 00:42:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35977 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeIAEmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 00:42:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so6131844pgo.3;
        Fri, 31 Aug 2018 17:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AWdzujc9EZFcPTJnRiI7cTrZ1EeyIfooBNTWwxNkX1I=;
        b=C9V3DeVq0q4cwKU4sNcX7iDGR88OyavwgK2WBmo/moPlNeVbGk3ru7PVP1I62cQjag
         hq3WzBPOCy1vGXA1gJ1vn9Nd/5FKi//LdHT1keS7DCf0daY8kdxuLFwbnK3BWgT9tJT/
         EbuXE1ZcZbF5Gp8qltGR4eKfTX4fSDVx8c9ePcJXKuTJIbMgrlguX0UL5yy30vnHo/MG
         WUiCW5YfM2yP5xLwHqr5UyPEx+hI2Hh9P+navxeCf+5szlUvCyCp9COnmBWYfANehBK4
         rysbBTqn1pfg9GrqZNZ0S6hddkoW0hqW4mj/QO8X8s7gyVn/30ZwHJkQKecRlqXL9N4r
         nMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AWdzujc9EZFcPTJnRiI7cTrZ1EeyIfooBNTWwxNkX1I=;
        b=cv38aGg0OJ8p0x4C+ofvIzGnt9aCHajG2APqUMim6r8cpeIPEPbkUIobyY8D2UGnpy
         SYmfVspGeiNfFtpBv0f1O7R9OYSHqJ4N7IrTSw+zJSgYexkj3BQlzhnJUdf4Y0B0UdaV
         aGZFhaJXzpP5lQ2u6ZeYmib5EaudFFDpGvD9R6qNva5bJznodrUTzw/omSRsX7+ubCzd
         HkKSJBcpMsApZH4YnbYU1ENHsdCPq3XKtgA0tQnI1mMmolSB6IHJ3w/mL5sVwnlnvtey
         urQMdXqNA9kJnu3FyndPUgUotl2STgSnRbZaV4hwN83FbYhj6YWg7bO117GPT62yYTbv
         C7qw==
X-Gm-Message-State: APzg51DbPNwPOkZHyie4P2TzxEQhsovYkTcOIux0WW9IGElayB4/VctB
        sG5h2fWSEiRnl59WwGX1Wjs=
X-Google-Smtp-Source: ANB0VdZ/fFreeXqTSkaacQLJbNOGDBvNm2F6blqCzjl3l/Pp5p2K+1fXA+dl8Kf/J+wjumlZVk/ZjA==
X-Received: by 2002:aa7:818f:: with SMTP id g15-v6mr18377851pfi.71.1535761973534;
        Fri, 31 Aug 2018 17:32:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:a245])
        by smtp.gmail.com with ESMTPSA id p4-v6sm20532703pgs.75.2018.08.31.17.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 17:32:52 -0700 (PDT)
Date:   Fri, 31 Aug 2018 17:32:50 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] blkcg: rename blkg_try_get to blkg_tryget
Message-ID: <20180901003250.GL1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-15-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-15-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:55PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> blkg reference counting now uses percpu_ref rather than atomic_t. Let's
> make this consistent with css_tryget. This renames blkg_try_get to
> blkg_tryget and now returns a bool rather than the blkg or NULL.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
