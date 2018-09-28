Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A27CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF6D206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n9jZaIOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF6D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeI2FaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:30:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2FaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WsTzXtg5q47SXmHc///IwX9bC/jq6sNprPFeTCQQOI4=; b=n9jZaIOuKt0ASk67lpscIhHLN
        48hqbSL5+tulZooRD87x0GYp1sa0EDXYNsU/o7sT642WBDScO41PgnfwIBsWw/oIztHLmNB+mZGGa
        9b9yBvgt23vMPOhigVurZ3d80m4p2fYIchnX+s0bEbxyAnsURKrmbuxJIEo3XX3GoeIphrv5JimW7
        LgIK54jINFyBdU3+/HEmPjIAg9OfvOpINLyORpTh2ZJ5ave6jx0b7tZl7Tjbla8wQ3SvaB+B5E3Fx
        3cyxiRcpPGMD5lA/ZB4mCL8tZU+bstWx5U5JwO35U3KtyxnRjy9dbwwC06oMigz4DAKqttS7PA8tB
        ESZ0+k+7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g61o0-00083U-NV; Fri, 28 Sep 2018 23:04:16 +0000
Date:   Fri, 28 Sep 2018 16:04:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v2 2/2] scsi: ufs: Execute START_STOP_UNIT during init
Message-ID: <20180928230416.GA30772@infradead.org>
References: <20180928230203.905-1-evgreen@chromium.org>
 <20180928230203.905-3-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928230203.905-3-evgreen@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 04:02:03PM -0700, Evan Green wrote:
> For UFS devices that are provisioned to have an initial power mode
> (bInitPowerMode) of "sleep", Linux will currently fail to enumerate
> the device. This is because the UFS specification says that the
> device must get a START_STOP_UNIT SCSI command to wake the unit
> up before other common initialization features like the device
> descriptor will be available to be read.

Yikes, this is just completely broken in terms of scsi compliance.

I think we should simply not support such devices.
