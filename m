Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AEBECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A79E214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fcmLI33t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A79E214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeIQXnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:43:20 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36470 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeIQXnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:43:20 -0400
Received: by mail-yb1-f193.google.com with SMTP id 5-v6so1697689ybf.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=JJoeTPWmY2QGmGtaS6kgwyqXMVLxcqpMTBdJInaGe3A=;
        b=fcmLI33tzxcPOUMsh1fOyrLi8YA2z/s4nkHJDZ8ximrVSOrwF/FGpdQegNxcyBSEnH
         McEX3ZF8ce/ANy/nntxVkaxnb2neuiqmQT5TRiDtg7pZSHtIGpYs1wxF6kjL0n38yaIP
         JERpZDV68RoXV6rdLcCB31ZmIa4LVERyGw+7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=JJoeTPWmY2QGmGtaS6kgwyqXMVLxcqpMTBdJInaGe3A=;
        b=nn3hIM8s/vDmgNVvFpxoetF7u3c0sZti+0dc/xtq0v68JF1CZswgUo0sP47xxE/l3V
         bSwe7sG8zoS15mAuWvrUa/92P4lZ9qE7NdEUJDxeBMewjerRNZfepPacAsYR9Y6rXzor
         2TIW14BIXqWNXM6JHKhD5wKJ/ETKDz09niaRwOAPl1GoaK1S9rttWwtKedsA8nB9coFW
         6N5EIGAqQxRdHKD/xVWUCi9DrC2SiDZQZiASutHwb0dH0EgRqeLBr6cIlu+ILmdO1CuE
         75CEZ0rTJiPRINOZPNSkbFz3DA4MYkVFoGtQEzr1/Uj1OizFyujmw7zYu3HVR6/Ntqvb
         dfeg==
X-Gm-Message-State: APzg51AwjMRZDp28z8/U8U/q63XrjpUOZtak9VI4t1iueIlfoc37vtSa
        12xbzknZLUf09xHOPh8+vlEpZA==
X-Google-Smtp-Source: ANB0VdZTMdmXgdJP8T/mKSQYzJwZUzp3wvzZAWtfzTIL7BU6Bs6bfGtofOvzm6fGTrhu/1fFWHk9Tw==
X-Received: by 2002:a25:2d10:: with SMTP id t16-v6mr11278574ybt.445.1537208090215;
        Mon, 17 Sep 2018 11:14:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id w207-v6sm19762306yww.17.2018.09.17.11.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 11:14:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180913213036.GA15874@hector.attlocal.net>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>
References: <20180717202947.197922-1-swboyd@chromium.org>
 <20180913213036.GA15874@hector.attlocal.net>
Message-ID: <153720808732.119890.6116001417130864555@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/2] qcom: remove memcpy()ing from cmd-db driver
Date:   Mon, 17 Sep 2018 11:14:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Gross (2018-09-13 14:30:36)
> On Tue, Jul 17, 2018 at 01:29:45PM -0700, Stephen Boyd wrote:
> > Some changes to the cmd-db code to not do any more copying
> > of memory. Instead, we'll just hand out pointers to things
> > inside cmd-db. Merging the second patch will cause problems
> > for any in-flight users of the cmd-db APIs that are modified
> > and/or removed. Probably that patch can wait until later, or =

> > I can provide the fixes for any patches in-flight that get
> > wrecked when it's applied.
> =

> The Adreno folks picked up the cmd-db APIs and ran with them.  I'll
> need an additional patch to fix that breakage.  You can see this in
> 4.19-rc1.
> =


I'll resend. I already had fixed it a few weeks ago.

