Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D78C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A7227B80
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A7227B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933661AbeF2HmY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:42:24 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:33834 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933316AbeF2HmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:42:23 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fYo2v-0007Aq-P6; Fri, 29 Jun 2018 09:42:21 +0200
Message-ID: <1530258140.3481.4.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: use IDA to allocate wiphy indeces
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Date:   Fri, 29 Jun 2018 09:42:20 +0200
In-Reply-To: <20180621012945.185705-1-briannorris@chromium.org> (sfid-20180621_033004_543173_9D94C00F)
References: <20180621012945.185705-1-briannorris@chromium.org>
         (sfid-20180621_033004_543173_9D94C00F)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On Wed, 2018-06-20 at 18:29 -0700, Brian Norris wrote:
> It's annoying to see the phy index increase arbitrarily, just because a
> device got removed and re-probed (e.g., during a device reset, or due to
> probe testing). We can use the in-kernel index allocator for this,
> instead of just an increasing counter.

I can understand that it's somewhat annoying to people, but it was
actually done on purpose to avoid userspace talking to the wrong device.

Imagine you have some userspace process running that has remembered the
wiphy index to use it to talk to nl80211, and now underneath the device
goes away and reappears. This process should understand that situation,
and handle it accordingly, rather than being blind to the reset.

johannes
