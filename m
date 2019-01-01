Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC03C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 09:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12030208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 09:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RfEMFxag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfAAJsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 04:48:53 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:44502 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfAAJsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 04:48:53 -0500
Received: by mail-io1-f42.google.com with SMTP id r200so22530830iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 01:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=mqWrR79WcE5KTrHxN7RptmzqcdBuJY1+lnGhs0qIRSo=;
        b=RfEMFxag13aPgmSHtPwLvCJj9p5IYSww0QI8eFqdr3I+T0NQGYC1OyyNs9LskEf/b4
         vHFAn30Jm7PPyLnCZvdcB7VbHwRJ9WXwIWuWdQFFNJhu265j+ubB0ititLrPcsNz6XUN
         /pKNq951sHh5sI4OrJ9C2juN7Wmxlhe1n1GH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=mqWrR79WcE5KTrHxN7RptmzqcdBuJY1+lnGhs0qIRSo=;
        b=tjOi0EoUjfeJrP6fuMt2QNEmUDysDYfAEZIZ9W1hc2USOQyQ0HvxBdw2Xh5btYj9BM
         8tT0ujwInLMvpL7S6YGUJhrmcupQeQ7wE8AVukeu7yRf8UwGNr6Dmt1nB159EPlO/OXE
         WV/s7WXTuGznqlC+h0YgE60OJ/Vs9/izy3V9xaz9sDe+fTALNTH99zkB8y7L8prH+ABM
         gsAnODdtkPT7D907TNZrYxRNyw20uOHieIymwYpmY0CoTMEDtjDB1lqmsFiMUVFsZtwI
         S3UysxjYv9rPdI6h/k1tbgoPqG5cpr/1rq7MqtBtpO4GQAI6g6ORFPlAuUi1yy9cWIO/
         WdHw==
X-Gm-Message-State: AJcUukctURRELekZxmbv80obuAedJdQERCnGmt64iJZdo0ymX+vMo0aK
        ZzrvWW0bNnstyJdGMUXjV81fw9JzmjLMCBLgC2cxNw==
X-Google-Smtp-Source: ALg8bN5OaU36Qz4QmwAIOpgMAbQDIJ5vLeypzg30woThOut//1L88eNC7LNl1oswud5PPILh9U7irpdzlX4MGhi1lS4=
X-Received: by 2002:a6b:8bd1:: with SMTP id n200mr24327876iod.96.1546336132441;
 Tue, 01 Jan 2019 01:48:52 -0800 (PST)
From:   Murali Krishna Policharla <murali.policharla@broadcom.com>
References: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com> <20190101083450.GA17613@lunn.ch>
In-Reply-To: <20190101083450.GA17613@lunn.ch>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQDi+mxIHKhl/yIiH43SW54sVYgmegFJi9UIp3Mo/zA=
Date:   Tue, 1 Jan 2019 15:18:51 +0530
Message-ID: <30ecb54251911d28c50b61299b0f8d3d@mail.gmail.com>
Subject: RE: [PATCH] net: core: Fix to store new mtu setting in netdevice.
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, amritha.nambiar@intel.com,
        ecree@solarflare.com, ktkhai@virtuozzo.com,
        alexander.h.duyck@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
                           Currently net/dsa/slave.c does not have
ndo_change_mtu function.  But shortly I will be submitting a separate
patch outside this fix that has ndo_change_mtu function support added to
DSA switch.  As part of testing the newly added ndo_change_mtu function
for DSA switch it uncovered that new mtu size is not being updated to
netdevice structure. This patch fixes this issue and updates  new mtu size
to  netdevice structure.

Hope this clarifies, let me know if you need any further information.

Regards
Murali

-----Original Message-----
From: Andrew Lunn [mailto:andrew@lunn.ch]
Sent: Tuesday, January 1, 2019 2:05 PM
To: Murali Krishna Policharla
Cc: davem@davemloft.net; amritha.nambiar@intel.com; ecree@solarflare.com;
ktkhai@virtuozzo.com; alexander.h.duyck@intel.com; netdev@vger.kernel.org;
linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: Fix to store new mtu setting in netdevice.

On Tue, Jan 01, 2019 at 12:12:14PM +0530, Murali Krishna Policharla wrote:
> Store newly configured mtu settings in the netdevice after mtu
> configuration is successful to the dsa switch.

Hi Murali

Please could you give more details. net/dsa/slave.c does not have a
ndo_change_mtu function, so i don't know what you mean by the
reference to DSA.

	  Thanks
		Andrew
