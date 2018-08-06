Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0D1C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB367208B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MFwl5dPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB367208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbeHFUPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:15:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36053 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbeHFUPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:15:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so7237864pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 11:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=yAhoVKyNE5Zk12E7k843gWMlRagJuhU8C9BB7QqHPbI=;
        b=MFwl5dPPYHxBIBBMSNPVAV39JYmqZqCxnlfdcYoZn1vd6ZS6TIcOi5f0sALT+9i1R6
         3vfGQYNypqV1kbV8JoXAB3cHLRNoUian4oa7PqOmQezIg0juFINgnfzNnRWdMX8RYPva
         2wemlrQ3vlxt7HfOweiCHrMrOSnfY7ZXGmYKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=yAhoVKyNE5Zk12E7k843gWMlRagJuhU8C9BB7QqHPbI=;
        b=ZhBdtq0ssv2cRyY2FpQMecCq5JagNkLt3SD98O5S2IX31VhYNJrAaArR8JaDdaQls2
         4cfk8i9U3R6EW8+GFG8MmJKtkbl0+qoryrNCgFz+/tQVbxj4UUniQvMW6NR6doOH7fsP
         MnX3SJnLiTUIUp3ajSD3phhKWK+4QKzksdM9pbU7xBAnMvNmhFC1uoh6Ztqc8P4QJHLb
         fgXSKysiS/sNnhK2C4oQewtS6V+Du36qYCJTqhqC/i9FTVZIiSyvHOltEwKg1Btz23mr
         9xAQK0bKVfZMW5RnOOX/WzbkDCRnDuRDgpDfLBcIPAYWn23R08fIPd+lDTDwrbIlnVCi
         5mDw==
X-Gm-Message-State: AOUpUlGV3YejEwrMk0+AKqdO8keHCIE6TPQD8VBB8H66PQCVsRf3Z8Hi
        mtuMnv8LEIyqNdkDd+KlKZDY4w==
X-Google-Smtp-Source: AAOMgpd54/QFgBw8vMP5bRQ8xrBdOljQHn21/W8s6vFl+/iNmOA+opeXturH7I40XCfVCaLhnNXypA==
X-Received: by 2002:a65:428b:: with SMTP id j11-v6mr12041705pgp.200.1533578737909;
        Mon, 06 Aug 2018 11:05:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id d9-v6sm21320668pfb.86.2018.08.06.11.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 11:05:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Brian Norris <briannorris@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180806173806.GA26374@ban.mtv.corp.google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Escande <thierry.escande@collabora.com>
References: <20180806171047.227835-1-swboyd@chromium.org>
 <20180806173806.GA26374@ban.mtv.corp.google.com>
Message-ID: <153357873656.220756.13862913888448347196@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] firmware: coreboot: Let OF core populate platform device
Date:   Mon, 06 Aug 2018 11:05:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Norris (2018-08-06 10:38:08)
> On Mon, Aug 06, 2018 at 10:10:47AM -0700, Stephen Boyd wrote:
> > Now that the /firmware/coreboot node in DT is populated by the core DT
> > platform code with commit 3aa0582fdb82 ("of: platform: populate
> > /firmware/ node from of_platform_default_populate_init()") we should and
> =

> Does this deserve a 'Fixes' tag?
> =

> Fixes: 3aa0582fdb82 ("of: platform: populate /firmware/ node from of_plat=
form_default_populate_init()")
> =

> The coreboot-of driver was in 4.12, and it seems to have broken in 4.16,
> along with the above patch.

Yes. A fixes tag should be added.

> =

> > can remove the platform device creation here. Otherwise, the
> > of_platform_device_create() call will fail, the coreboot of driver won't
> > be registered, and this driver will never bind. At the same time, we can
> > move this driver to use platform device APIs instead of DT specific ones
> > and drop the of_node handling that was presumably placed there to hold a
> > reference to the DT node created during module init.
> > =

> > Cc: Wei-Ning Huang <wnhuang@chromium.org>
> > Cc: Julius Werner <jwerner@chromium.org>
> > Cc: Brian Norris <briannorris@chromium.org>
> =

> Reviewed-by: Brian Norris <briannorris@chromium.org>
> =


Thanks!
