Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5799CC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE3C2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gGDQgHpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE3C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeJLDA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:00:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41822 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeJLDA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:00:26 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9BJVgT4108560;
        Thu, 11 Oct 2018 14:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539286302;
        bh=FyhPFQ8evN8rekXTVKKA9BeT6FCLx/5FwsEeV/kiDDY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gGDQgHpgA0/sfmOG5lcPKJik3Kxqt8OPGaXK9NOavuBsOlgjYDAQnF2iLBuw86qCz
         sw14GmW+mXTgLQAgPI1dzNq1sTwOxG+IaNwr9MH3iAOeMs3yrFtlgZ9R7QxRWtDj2t
         /O98SuOKQzWe6owraw+UPyO3+Ge9trMx75QFn8/o=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BJVgOx017444;
        Thu, 11 Oct 2018 14:31:42 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 11
 Oct 2018 14:31:42 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 11 Oct 2018 14:31:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BJVgPC017840;
        Thu, 11 Oct 2018 14:31:42 -0500
Date:   Thu, 11 Oct 2018 14:31:42 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
CC:     <laurent.pinchart@ideasonboard.com>,
        <kieran.bingham@ideasonboard.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <balbi@kernel.org>, <stern@rowland.harvard.edu>, <rogerq@ti.com>
Subject: Re: [PATCH 0/6] usb: gadget: add mechanism to asynchronously
 validate data stage of ctrl out request
Message-ID: <20181011193142.GC8763@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        stern@rowland.harvard.edu, rogerq@ti.com
References: <20181010024903.1633-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181010024903.1633-1-paul.elder@ideasonboard.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 09, 2018 at 10:48:57PM -0400, Paul Elder wrote:
> This patch series adds a mechanism to allow asynchronously validating
> the data stage of a control out request, and for stalling or suceeding
> the request accordingly. This mechanism is implemented for MUSB, and is
> used by UVC. At the same time, UVC packages the setup stage and data

Why is this for MUSB only? Other UDC such as DWC3 doesn't need this?

Regards,
-Bin.

