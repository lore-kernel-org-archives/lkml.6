Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C39ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B61621525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RJPr0zv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B61621525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388608AbeIUErO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:47:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33542 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeIUErO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:47:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id b97-v6so5040420plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XnbSOaS3cXFSRr7RaJlQgCJQp+2/RhzokjFBEA1aXJw=;
        b=RJPr0zv705fZvYJeTcYQoYl+m4G1Z6F9hTm6q7h6UnUyhkEE0MDByNrt3eTT90nfPw
         scx/GDEMlnITYLYUzIVYl1Gb3HWmgh4BZQ3EdkGUYSTS1n95mKbegJcPNmmlnOi8bI5+
         lHMFw452MJXhmQwfRCntrX0sBrEmXfAmPpT5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XnbSOaS3cXFSRr7RaJlQgCJQp+2/RhzokjFBEA1aXJw=;
        b=RxwdadV9UweyexckCBSC9ZMgcYdSuupGxDebBRIKvOaRQtf7wqeAIgxXjtb+iW2Fml
         azTFqhA0abFbjX65q5zpVWtSOwdEybqD6ffIMQoo5TPWBIEZTjd6Xdpp9nfv06PTIZ9D
         +FX96LbVU79Ey6cGR2xY2J6UJZ4xYCMks/elWeNQgHyTSL4rMeUycKqXOvvuojiuIoSa
         KzZ5q6q8t/ZJ+3n6BfkbpJ+CjcuguaiPt3hDlzGc1J3KMDGZK3kCvAZ1yem0jYmPoELR
         ps3OktT9ALrA/ql3F738cA57XqkeNEMDfA3pjn+lNJGxo9FCLkqnrpCgZ93nfRxznQau
         w8ZA==
X-Gm-Message-State: APzg51AEgss/049u2cCVvOR2cJY7zz4hA2CglSlAbDh+1zgsp16PvNwv
        VMeksMYsIMeTDnKrqx4i7w8aNg==
X-Google-Smtp-Source: ANB0VdZ+j2v8m4x9lYeW5QwMTAjeVo8BSpBFXhvo2KqoYstzWsqF9NpMrDFjT7SkDYOt9QjmzQV5ig==
X-Received: by 2002:a17:902:ac86:: with SMTP id h6-v6mr4137818plr.103.1537484483721;
        Thu, 20 Sep 2018 16:01:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id n9-v6sm41038945pfg.21.2018.09.20.16.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 16:01:21 -0700 (PDT)
Date:   Thu, 20 Sep 2018 16:01:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 0/2] Add API to retrieve the Bluetooth Device Address
 (BD_ADDR)
Message-ID: <20180920230121.GT22824@google.com>
References: <20180920223436.202454-1-mka@chromium.org>
 <0ea65ca1-8d06-72d8-3bbe-693e09605a8a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ea65ca1-8d06-72d8-3bbe-693e09605a8a@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 06:45:58PM -0400, Sinan Kaya wrote:
> On 9/20/2018 6:34 PM, Matthias Kaehlcke wrote:
> > On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
> > on the Bluetooth chip itself. One way to configure the BD address is
> > through the device tree. The btqcomsmd driver is an example, it can
> > read the BD address from the DT property 'local-bd-address'. It is
> > also planned to extend the hci_qca driver to support setting the BD
> > address through the DT.
> > 
> > To avoid redundant open-coded reading of 'local-bd-address' and error
> > handling this series adds an API to retrieve the BD address of a device
> > and adapts the btqcomsmd driver to use this API.
> 
> I don't think you have got enough number of line savings to make this
> code to be folded into property.c

Most of the new lines are documentation ;-)

> Not my call but seems redundant IMO.

Certainly true if this was the only driver. However another one will
follow soon and 'local-bd-address' is the official binding, so it's
not unlikely there will be more.

Also fwnode_get_bd_address() handles the case where the property
exists but is all zeros which adds a few LOC, which isn't handled by
the btqcomsmd driver.

Cheers

Matthias
