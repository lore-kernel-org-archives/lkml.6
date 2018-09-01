Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DC7C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE4120835
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8xttScU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE4120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeIAEXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 00:23:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34787 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeIAEXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 00:23:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so6210287pfi.1;
        Fri, 31 Aug 2018 17:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eS6f5x9QRtUQLe+IeCikEV1hkReNWR6GYSjT0Lq+71Y=;
        b=M8xttScUFJyuvz1zHO1NTKccoau1IuP3u72/cTX+2pGScsRExcnI92fDJ0vI1kh22Q
         5VAWP+vV37QxVk4udfvndj9gWc77HaTnPdefqoOlkmc2QGYAH3eou6dObovxs7Jvs1Yf
         cx/3Zk/hRdzqsB3zEnSaT27+9IpVkDS9+qWdjoOg0tgLmwuQysMIrY1xwSWKSqlDz1E7
         YxZHVUeVn1gnlkHegN1BVFnkOpVqA1Rm24HwO3Zf7E5akn04GewsaH1eXEz9gxDhBAF/
         nB9cinF2ERcBawLBMbpN9NO3spQpqEzunzKzMaCNhUMmoXI5bt0tJMDja1VqHbEClfbL
         XaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eS6f5x9QRtUQLe+IeCikEV1hkReNWR6GYSjT0Lq+71Y=;
        b=g/kHO/SToQ4p1e9os6/cx6gsJaQ9ZbZt5e4zt24ldJ5SZgdHZQylaRrPL+u7cI+sbM
         WYNKcVlPJK47srBcTnybgHTf4NyWqJza4y8j0fdsByzN2sCN75srg+yXh71v7wwITHly
         r2ivE7ho79KStuHY42oA+OKqGz55zSkex2dSunRUQ2oF1jV+QEfPSnMNdlKNXDWMiyyx
         pbA4NrNFSALYN3WO7eJ34WAkCP82G65fDHjneBfW3fE9hIl9o+QaySwQL3jYiBlP+Wk6
         ThktgRewyHGTX6gNFzUqcFCddHlG786Xea8bpIxdszt7hUnFyNmHmeA1kzavB/olQFGT
         EAsg==
X-Gm-Message-State: APzg51CSi6oGbfHFtDmfwPKr5PCrhGa9m6Uld5WIOr/2FbWUb3YNPGqQ
        NwawME13nXC7KoeTXo7IlIY=
X-Google-Smtp-Source: ANB0VdYn2m63ieU/H8ZsZvqBFiPskcfGbGB3DIeDrjfgcoLzD9fZZO9JJtRluU9CkD6aMDAYrmQ2BQ==
X-Received: by 2002:a62:9894:: with SMTP id d20-v6mr18402900pfk.186.1535760789014;
        Fri, 31 Aug 2018 17:13:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:a245])
        by smtp.gmail.com with ESMTPSA id i25-v6sm17426493pfi.150.2018.08.31.17.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 17:13:08 -0700 (PDT)
Date:   Fri, 31 Aug 2018 17:13:05 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] blkcg: remove bio->bi_css and instead use
 bio->bi_blkg
Message-ID: <20180901001305.GH1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-11-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-11-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:51PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Prior patches ensured that all bios are now associated with some blkg.
> This now makes bio->bi_css unnecessary as blkg maintains a reference to
> the blkcg already.
> 
> This patch removes the field bi_css and transfers corresponding uses to
> access via bi_blkg.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
