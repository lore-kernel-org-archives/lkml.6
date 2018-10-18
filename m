Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CEDECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A89721473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cXSufFkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A89721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeJRUlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:41:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45684 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeJRUlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:41:02 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9ICe5rr025940;
        Thu, 18 Oct 2018 07:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539866405;
        bh=oujgwrzkNCJLVjSK2ttIJhP2uzYSmJcWTwVYGHru/yw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=cXSufFkrbZavMaxof7X1uEtj7X6wVI8smve9wYvcLg4BafHfuF+KWZ14nJZVgOVni
         h+QECoEHHBEie5oWBTcfXPs3HYsA5DXzYCB0rdeZN5RdAacerk46KZYhBw+T1llan8
         Q2UgEoThmBEJ+3BoMtlARawAZ6M9TnX2lmSvd3F4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9ICe4rG013947;
        Thu, 18 Oct 2018 07:40:05 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 18
 Oct 2018 07:40:03 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 18 Oct 2018 07:40:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9ICe3tm022687;
        Thu, 18 Oct 2018 07:40:03 -0500
Date:   Thu, 18 Oct 2018 07:40:03 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Paul Elder <paul.elder@ideasonboard.com>,
        <kieran.bingham@ideasonboard.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <balbi@kernel.org>, <stern@rowland.harvard.edu>, <rogerq@ti.com>
Subject: Re: [PATCH 0/6] usb: gadget: add mechanism to asynchronously
 validate data stage of ctrl out request
Message-ID: <20181018124003.GD8763@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        kieran.bingham@ideasonboard.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, stern@rowland.harvard.edu, rogerq@ti.com
References: <20181010024903.1633-1-paul.elder@ideasonboard.com>
 <20181011193142.GC8763@uda0271908>
 <1944130.9sTDClXDAS@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1944130.9sTDClXDAS@avalon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thu, Oct 18, 2018 at 02:42:29AM +0300, Laurent Pinchart wrote:
> Hi Bin,
> 
> On Thursday, 11 October 2018 22:31:42 EEST Bin Liu wrote:
> > On Tue, Oct 09, 2018 at 10:48:57PM -0400, Paul Elder wrote:
> > > This patch series adds a mechanism to allow asynchronously validating
> > > the data stage of a control out request, and for stalling or suceeding
> > > the request accordingly. This mechanism is implemented for MUSB, and is
> > > used by UVC. At the same time, UVC packages the setup stage and data
> > 
> > Why is this for MUSB only? Other UDC such as DWC3 doesn't need this?
> 
> Unfortunately, the asynchronous control request data stage validation 
> mechanism must be implemented by every UDC. This patch series only addresses 
> MUSB as this is Paul's main test platform. Once the core patches get reviewed 
> and the API accepted (possibly in a modified form), we plan to update the DWC2 
> and DWC3.

Thanks for the explanation.

Regards,
-Bin.
