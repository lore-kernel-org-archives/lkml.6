Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6439C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D2124EE7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrilUagc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D2124EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753490AbeGBVG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:06:59 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:45293 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753087AbeGBVGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:06:51 -0400
Received: by mail-yb0-f196.google.com with SMTP id h127-v6so5602600ybg.12;
        Mon, 02 Jul 2018 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kbCihH3cjJajTFlKG9m6dzlHxXoCyQHSjgqbA4/c6xs=;
        b=IrilUagcnIE9D1lIuCMdg9QF/3KcTYTzSfqJm2MV7LwlKzD83KFZ8vx2r68ZUNAfk2
         jTL6xSJmzQ/yPmNwefp8gSWDvJmnx5lgklWsPiPZVkKTeGdjdO/pmkeQ6jUxVZTpDIQW
         cM1ca37IeGjie3goGBhOZL1xUSVY5/Wv5w+n8fBrPM9BYbGitAL6K14ix1r9BEgxIygX
         ePzoyPLHJX1Z6uRl9C+vW3pPztFN34y0AvFbqCLo3fruXo4GoKS+M/xKDzTT5bizlzct
         q+BWUYxc7NqGkSyAuSAvoWSpd/3ccO9oHdpc1tH9SDOtBYdG662YqR/J+gwPQvnYAUYD
         5s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kbCihH3cjJajTFlKG9m6dzlHxXoCyQHSjgqbA4/c6xs=;
        b=Z8NsMJd96swmEfB2mqokD8Cpa9qTqCqVmPcOB4jxI6YMyBS8O/WLfXDjn6e8UskIy1
         dZfBq4656g2JLA3gSD/rgPfaLqAFZ0acZP1pe0daB1MqOnGKr5infEQdMiJmtp6/Tlle
         IUbLrOB/xIfGiAlFdu7y8aINUqNnX7RaJ3mruzTpIiLFIcCts25TQAT+WlBr7vyIF/aB
         LzoYZjWa2uRgGjaj2QMRZtO5NU/kNPBvUaqFt0Eq9kthmzQ22XyKnHMi5v9cOkJcfkFu
         Dzcw3iDSST1dK3Y8Yq1NNJ1YLv65p3gLtS3/LCXDD6n0XnLYwYfPRCjoq2XwCRh4Zoc2
         YeDA==
X-Gm-Message-State: APt69E3OTIGjDmAfMb6axWcG2P7YIqrWaxh+ir8lSM0ky4qfOL+jl4oD
        30eshGF9vvGgaOLpQrEwYEk=
X-Google-Smtp-Source: ADUXVKJ3iSsUDmsUbMVHWU9dnYUS7U2dlqUF50gaTMbmDsWZ8iSOdxoW125eeyddjILQpHqSZyzHFw==
X-Received: by 2002:a25:4210:: with SMTP id p16-v6mr13610192yba.294.1530565610420;
        Mon, 02 Jul 2018 14:06:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id z187-v6sm5187241ywf.57.2018.07.02.14.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:06:49 -0700 (PDT)
Date:   Mon, 2 Jul 2018 14:06:48 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 03/14] blk-cgroup: allow controllers to output their own
 stats
Message-ID: <20180702210648.GM533219@devbig577.frc2.facebook.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
 <20180629192542.26649-4-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629192542.26649-4-josef@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:25:31PM -0400, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> blk-iolatency has a few stats that it would like to print out, and
> instead of adding a bunch of crap to the generic code just provide a
> helper so that controllers can add stuff to the stat line if they want
> to.
> 
> Hide it behind a boot option since it changes the output of io.stat from
> normal, and these stats are only interesting to developers.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
