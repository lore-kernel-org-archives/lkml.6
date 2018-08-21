Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6450EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B9521837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwgFyDbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B9521837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeHUUsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:48:18 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43743 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeHUUsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:48:17 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so8410088ywb.10;
        Tue, 21 Aug 2018 10:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jTGX14H0bWptDNMBYs9ye/y/xuZ84gxHsfCCH8xdm6g=;
        b=TwgFyDbQEhH0b1V5uFpPeGdej43EYw5Tj+SqBl83twLc4X1CQBzlpmJwUTkVn8IcCI
         7OUnlU0AWYV3kLpyJ4Wx8wcvwCzsKbJxnxGxhwVHG6t1f4zA8zutYUk1zeNdoxJpnBEL
         m2wz4wCqXV7YLlNCrqj/tNC1EvN8tA+n+MaUubBCRipU3qyQdd2mQ53AcJcw0Bwn3cTw
         Wz/Xy9rPAW/U8jeROxk3T4I9TpRlfR1GJcnsogPsIh/gzI3w/JjqHbq7B3F8rh/U6/fU
         XYne9fqY7rlznYayrRhLSoiBqOATLf/nyda9wvVESzLhQhPMkQ/zvQ0kDUfYkBsM+bRv
         t0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jTGX14H0bWptDNMBYs9ye/y/xuZ84gxHsfCCH8xdm6g=;
        b=Y1FuPZ36ASBa1o61lLvQ1n0NRTXhRCQgpjfFvR/4wkqNrSsZukOFs9JUrz56Efxwe5
         m4UwOSCr6f40WxsEWwmghCxh+5a+dSjdtuNy+hjjuzhkT3GxFA0Qm4ApMTjKdnT7Y3dh
         B4AvmDu+OV75NJFvErevV3L92XYK1QOs3kHBzuKAnP8DZQMUMf8QRgG9hEOHY77+ugC1
         UBWxJFnINrcS5LS4mYBbMDC+PwUmvHt6kuGRrhWkrdP3CweL6gEJNdLl/87TxWVCN9pT
         yy+LF3sNCT0L7NmRSEm62ifjit/VdK8RbBl8e52hiabVfMNoBUYeaUX3mmgfkFq153C+
         M0gg==
X-Gm-Message-State: AOUpUlGes7krvIuvauJX+gbHUIHw6mZWSdNB90vHtrXmURWKP2xtTDoQ
        PfeWHGlPp1Gxa3rgI7i4sCk=
X-Google-Smtp-Source: AA+uWPxgeRT7SEwd3IgF7ushYdu02oYLxF2W44MMLR38zYbpR78NOYoDAXs9GqPi0C5wBfSzFKhEcg==
X-Received: by 2002:a81:5545:: with SMTP id j66-v6mr27176187ywb.336.1534872434051;
        Tue, 21 Aug 2018 10:27:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:9c5d])
        by smtp.gmail.com with ESMTPSA id r12-v6sm5894349ywg.67.2018.08.21.10.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:27:13 -0700 (PDT)
Date:   Tue, 21 Aug 2018 10:27:11 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] workqueue: skip lockdep wq dependency in
 cancel_work_sync()
Message-ID: <20180821172711.GR3978217@devbig004.ftw2.facebook.com>
References: <20180821120317.4115-1-johannes@sipsolutions.net>
 <20180821120317.4115-2-johannes@sipsolutions.net>
 <20180821160814.GP3978217@devbig004.ftw2.facebook.com>
 <1534871894.25523.34.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534871894.25523.34.camel@sipsolutions.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Johannes.

On Tue, Aug 21, 2018 at 07:18:14PM +0200, Johannes Berg wrote:
> > But this can lead to a deadlock.  I'd much rather err on the side of
> > discouraging complex lock dancing around ordered workqueues, no?
> 
> What can lead to a deadlock?

Oh not this particular case, but I was wondering whether we'd be
missing legitimate possible deadlock cases by skipping lockdep for all
cancel_work_sync()'s as they can actually flush.

Thanks.

-- 
tejun
