Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA1CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FDC20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FDC20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIMMSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:18:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40968 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeIMMSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:18:37 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B3239707;
        Thu, 13 Sep 2018 07:10:26 +0000 (UTC)
Date:   Thu, 13 Sep 2018 09:10:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 34/80] enic: handle mtu change for vf properly
Message-ID: <20180913071024.GG11496@kroah.com>
References: <20180903164934.171677301@linuxfoundation.org>
 <20180903164935.510879136@linuxfoundation.org>
 <1536714193.3024.184.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536714193.3024.184.camel@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 02:03:13AM +0100, Ben Hutchings wrote:
> On Mon, 2018-09-03 at 18:49 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Govindarajulu Varadarajan <gvaradar@cisco.com>
> > 
> > [ Upstream commit ab123fe071c9aa9680ecd62eb080eb26cff4892c ]
> > 
> > When driver gets notification for mtu change, driver does not handle it for
> > all RQs. It handles only RQ[0].
> > 
> > Fix is to use enic_change_mtu() interface to change mtu for vf.
> [...]
> 
> This causes a assertion failure (noisy error logging, but not an oops)
> when the driver is probed.  This was fixed upstream by:
> 
> commit cb5c6568867325f9905e80c96531d963bec8e5ea
> Author: Govindarajulu Varadarajan <gvaradar@cisco.com>
> Date:   Mon Jul 30 09:56:54 2018 -0700
> 
>     enic: do not call enic_change_mtu in enic_probe
> 
> which is now needed on the 3.18, 4.4, and 4.9 stable branches.

Ah, I didn't realize it was really needed on the older branches as well,
due to the lack of the mtu settings on those kernel trees in this
driver.

I've now backported it there, thanks.

greg k-h
