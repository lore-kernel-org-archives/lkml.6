Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E930CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B259221871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cNFR9tUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfABJyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:54:04 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:52838 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbfABJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:54:04 -0500
Received: by mail-it1-f175.google.com with SMTP id g76so40211609itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 01:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=79wF/LLmWclybjJHnhYuLXTw2JwMV0rfZxsnEihMyGA=;
        b=cNFR9tUXaqHc8TIDldW7NP5CxmqIsBlWOlhRcTie4j6pbXMC0AkAF1t5lghbgikFJ/
         Z2J/4uOtvWQe+84thD3AI4VIkd/s36Acv27mhkK2ASyGuuHOxXS6bf5CR7LLqAvfoL8b
         WwE3Rat1njm3UfupQP9iE/LiXBOrrvhluLiAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=79wF/LLmWclybjJHnhYuLXTw2JwMV0rfZxsnEihMyGA=;
        b=tOVhu5wdd/WstPLdDpcZKXSacPS1mszgv0Yztgw4XpE24kpfWrdoDl4Fx8suqbapH2
         tZYpMPIqF/rNAETI929fcgNDaGAV6CXhDAgYw7eZYCYyjVfrd65+1AyAVCQk6jlwPu45
         Sb+rBtxAbeDLApcLboedKPlXYMLDRzN2cSHtbrvn/PPzGpHcJ1pF2+u2frAPMHDDQFAr
         Jhl5FERctKzmaBNOQkXIP7zt8s/+P/gpN+NC4sMve7JyS3SzAR9u4i5vzzfMBz0juUPj
         XYHl1qQHsMPTyexSV3er0t1PtnBmKoq42Aa2mShbYLt2Oo3MHCtzYwNjkw3eIPG4EQUL
         Hk6A==
X-Gm-Message-State: AA+aEWZJV0RijLWMGcofW89Pd0wc84hB70V46i8E95VVdCAkQSCstnV4
        XE0VMGjHmOAXgkwuh/XIUuVKBUuYj2tRKx/UBYJhCQ==
X-Google-Smtp-Source: AFSGD/WpyZbGMtswn9jX4x9AcEnkyEdRPYiTcNrDgFiOkC+MA5cAdHddiDIXUYKTt+tRlr6g0at+gFK+RVQywQmV5lg=
X-Received: by 2002:a02:5c0e:: with SMTP id q14mr28541331jab.13.1546422842914;
 Wed, 02 Jan 2019 01:54:02 -0800 (PST)
From:   Murali Krishna Policharla <murali.policharla@broadcom.com>
References: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
 <20190101083450.GA17613@lunn.ch> <30ecb54251911d28c50b61299b0f8d3d@mail.gmail.com>
 <20190101232443.GA22737@lunn.ch>
In-Reply-To: <20190101232443.GA22737@lunn.ch>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQDi+mxIHKhl/yIiH43SW54sVYgmegFJi9UIATpxsa4CXZKPHadX9Zsg
Date:   Wed, 2 Jan 2019 15:24:01 +0530
Message-ID: <b6ff97415cd415614393e35793972ccc@mail.gmail.com>
Subject: RE: [PATCH] net: core: Fix to store new mtu setting in netdevice.
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     davem@davemloft.net, amritha.nambiar@intel.com,
        ecree@solarflare.com, ktkhai@virtuozzo.com,
        alexander.h.duyck@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew,
>                            Currently net/dsa/slave.c does not have
> ndo_change_mtu function.  But shortly I will be submitting a separate
> patch outside this fix that has ndo_change_mtu function support added to
> DSA switch.  As part of testing the newly added ndo_change_mtu function
> for DSA switch it uncovered that new mtu size is not being updated to
> netdevice structure. This patch fixes this issue and updates  new mtu
size
> to  netdevice structure.
>
> Hope this clarifies, let me know if you need any further information.

> Hi Murali

> Thanks for the explanation.

> However, i looked at the patch you listed as 'fixes'. I don't see what
> came before that setting the mtu when an ndo_change_mtu function is
> provided. It seems to me, if you provide an ndo_change_mtu, it has to
> do the assignment. I don't think you are fixing anything here.

> If you do want to move the assignment into the core, please review all
> the MAC drivers which implement ndo_change_mtu and remove the
> assignment from them.

>	   Thanks
>		Andrew

Hi Andrew/Heiner

                                       Thanks for the feedback. This patch
fixes a case where ndo_change_mtu function is provided but the callback
function is not storing mtu to netdevice structure. In the discussion
thread for this patch it is mentioned that there is a possibility of
ndo_change_mtu function to manipulate the mtu size and then store the
modified value  to netdevice structure. For me it appears this is
incorrect operation since mtu value is being modified and it is not
storing the value that user has configured.  In another  use case that is
discussed user configures mtu value that exceeds the max/min permitted
value. In this case an error should be returned to the user rather than
modifying/storing only the permitted value.  Also any modifications done
to mtu in the callback function for DMA operations/restrictions should be
transparent to user.   As per my understanding ndo_change_mtu callback
function can modify and use the mtu value that suits for the respective
device operation, but only user configured mtu size should be stored in
netdevice structure and this is done in the core driver with this fix.
Please let me know your inputs.


Thanks
Murali
