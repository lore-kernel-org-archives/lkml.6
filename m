Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D45C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D7321582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SbVgr5sF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D7321582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeI0XcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:32:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43411 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeI0XcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:32:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so2345461pfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ixVkVXi1ynVKb5zmW4srfm6zYKWxWEJWjo4zCwv9DQ8=;
        b=SbVgr5sFfZQjrA5Eb1SkNKPmLjxA2pT44wto2xeUJioyktm/aTwj57Ux4t1fcOXdeJ
         SNWNR9OdILfEGpzAcbHK5YKmJTD4R1Ge2eu9xApID8tQivvEMokp9+z2MCbpwVu7rfUs
         2BBxEzXPOvlFw5V6t5502xx0FxrOZ7y5l0YXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ixVkVXi1ynVKb5zmW4srfm6zYKWxWEJWjo4zCwv9DQ8=;
        b=NA1ZrGKruMi+ez7GMHD3xwwNkBYSMDGtbTytm0Oy6rzwk2x4dRiZ3vwrxJUk2WuA88
         ZeUnroHmVcNecp0gAsAKHFrv94nfyzfI0m2gNj7zk4EvCsajJp4lJIHjCs/SPDKW+MKw
         LPUeGaZoivWbKX2ctXhERnuuqjThWP2UWg3cN/iKpcB/ZDoFZmNHEJIsIUEUbPofzqqk
         Atqyy3jnVve+uhNo2UM0nwi+LxxoLm0nDBiTpMMSbqR9uXs2E9ED9uTuRRY/7xxet/b7
         cg7tjtiV0Ikh/W1NM8+f7l4nSM7fVCQmBvMi7y6/N95g+bR2ak2HeQNg1ManuZGlvy0t
         Ppwg==
X-Gm-Message-State: ABuFfogUUf/KTflXlMTiq7K/jGHEM3dJuZd7peES14i0/5SM/jWEK73p
        1lnlcb8ipb1gnZozi+uN1Le8Zw==
X-Google-Smtp-Source: ACcGV60pgrjvUs2n7cVXCkFCWoBFZeoCAfDXcM2LWxM/EgqZywdCL1wQ6B84X/5uUVjzxT0k5xU0Fg==
X-Received: by 2002:a17:902:b7c2:: with SMTP id v2-v6mr12118406plz.238.1538068387083;
        Thu, 27 Sep 2018 10:13:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id o62-v6sm540446pfk.76.2018.09.27.10.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 10:13:06 -0700 (PDT)
Date:   Thu, 27 Sep 2018 10:13:05 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v4 1/2] Bluetooth: Add device_get_bd_address()
Message-ID: <20180927171305.GG22824@google.com>
References: <20180927004810.124185-1-mka@chromium.org>
 <20180927004810.124185-2-mka@chromium.org>
 <b28c34475e447cc29a139f9121b3c1d9@codeaurora.org>
 <e6752d4b-b22a-d951-e9db-1ae7445dc403@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6752d4b-b22a-d951-e9db-1ae7445dc403@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:47:06PM -0400, Sinan Kaya wrote:
> On 9/27/2018 12:41 PM, Balakrishna Godavarthi wrote:
> >   void bt_sock_reclassify_lock(struct sock *sk, int proto);
> > 
> > +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
> 
> Maybe change the API name to start with bt_ and get rid of device_?

device_ indicates that we get the BD_ADDR for a 'struct device' and
not for e.g. a 'struct fwnode_handle'.

Anyway with this version of the patch fwnode_get_bd_address() has been
scrapped and it might never be introduced again, so I'm open to change
the name to bt_ if there is a general preference for it.

Cheers

Matthias
