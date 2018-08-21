Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EE0C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3DD20834
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLXcsnN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3DD20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeHUVRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:17:04 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34768 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeHUVRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:17:04 -0400
Received: by mail-yw1-f66.google.com with SMTP id y134-v6so4613863ywg.1;
        Tue, 21 Aug 2018 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mTER1lSMFNMnOCZgbPuqvLTPedgAzbq6jgXMEglLFDY=;
        b=RLXcsnN35dwxJV601hI8ebtmTV9D7o3FE2TAhhrw/eOi+ZW7EYJjBNciqSQiEny2g3
         rRbd5nCUItl5ut+hAYmHKYoXJlL6ketINLLp9M2GxhDwsYDUkJrbR9M2Ct9By50NdWiG
         HYGu/Kz7FyNneiexz3CDrOGN8lX7vsISVSV8S7y13sNNMuOsqVtR8/iN6B95teJTMSxT
         EAy/jN9o1zT9MFKhjqH5J3HuuZ4QFef14QwY+71hU6i803NcHHcwrXHBgWFVgpBTMU4m
         gh/QC+j3GvzdIzCB2x0J6YVrA03juCwPf+wZfzQ9i2jXeRNBv/877JmQmXRkLXl2jRx+
         0YDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mTER1lSMFNMnOCZgbPuqvLTPedgAzbq6jgXMEglLFDY=;
        b=oAC7nsY3YVmkQDIXidcp+bBQpSKCAclbdtF7Er4/4ieFc2DjnmsXabTv30asBQ6nRE
         nLmiLvOG3eE9qQPZ/eFBpQOSg09xuXW4gHaW5ySL9b6vcKNC/otwkjGsNQ7A5YBOq1kk
         TJ4PIaxSAQkwAbED9IyuT6LcKaoSUAHQ32Z8hB/YeGecqF3l1N76HvYCie0on8haf9hm
         lnidYVVlfMHBDwlKAmlL/Z/a1IHjTAWTqpBJt/Sdr/kzSZs/VZUhmXinIYKHyqNdxzrz
         /Wpkr4xHKzPIlEcI69Zu3VlZvRD90kMNdiCQXTO3KDHOJTifR6uk1/FpHijmyqq5A3hP
         hG6w==
X-Gm-Message-State: APzg51DVpWKRcjpl7BRG5Pec0UNMHXDzGxhox8bkKVRdXtkU+eCmewxM
        F/+rnl9D946B3BNIc5YA63g=
X-Google-Smtp-Source: ANB0VdZvfM14HteH9OzpmKW42bWuZ2cHZFN0/+ShOCi4qWxiGiQiB5O5hOALSJfiPCy82dLsdBEY0w==
X-Received: by 2002:a81:5803:: with SMTP id m3-v6mr3757444ywb.312.1534874153876;
        Tue, 21 Aug 2018 10:55:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:9c5d])
        by smtp.gmail.com with ESMTPSA id u64-v6sm12863257ywu.107.2018.08.21.10.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:55:52 -0700 (PDT)
Date:   Tue, 21 Aug 2018 10:55:50 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] workqueue: skip lockdep wq dependency in
 cancel_work_sync()
Message-ID: <20180821175550.GS3978217@devbig004.ftw2.facebook.com>
References: <20180821120317.4115-1-johannes@sipsolutions.net>
 <20180821120317.4115-2-johannes@sipsolutions.net>
 <20180821160814.GP3978217@devbig004.ftw2.facebook.com>
 <1534871894.25523.34.camel@sipsolutions.net>
 <20180821172711.GR3978217@devbig004.ftw2.facebook.com>
 <1534872621.25523.39.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534872621.25523.39.camel@sipsolutions.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 21, 2018 at 07:30:21PM +0200, Johannes Berg wrote:
> I don't see how? This is only relevant in ordered/single-threaded WQs,
> but even there it doesn't matter doesn't matter as explained?
> 
> I'm actually seeing a false positive report from lockdep, because it
> *is* flushing, i.e. I'm running into the case of the work actually
> running, i.e. the "_sync" part of "cancel_work_sync()" is kicking in,
> but in that case a single-threaded WQ can't have anything executing
> *before* it, so we don't need to generate a lockdep dependency - and in
> fact don't *want* to create one to avoid the false positive.
> 
> I'm not really sure what you think we might be missing? Am I missing
> some case where cancel_work_sync() can possibly deadlock? Apart from the
> issue I addressed in the second patch, obviously.

Ah, that was me being slow.  I thought you were skipping the work's
lockdep_map.  I can almost swear we had that before (the part you're
adding on the second patch).  Right, fd1a5b04dfb8 ("workqueue: Remove
now redundant lock acquisitions wrt. workqueue flushes") removed it
because it gets propagated through wait_for_completion().  Did we miss
some cases with that change?

Thanks.

-- 
tejun
