Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2121C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BA72085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tqPdKA37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BA72085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeJKVe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:34:58 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49985 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727510AbeJKVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:34:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BB07B21B98;
        Thu, 11 Oct 2018 10:07:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 11 Oct 2018 10:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=v2uWZ4
        GtY1Eo6rE5xG55W43O77OvfDSw8vt46/3D+jY=; b=tqPdKA37Qaix5Ciq0SaCbQ
        A30tw+zATBLx1S49Gtu6lU8E73+I24TMpK0nEAwezwlpKya08dbVIMqYWCjK1p7G
        4MzXZYD3U8UpZwlve/xXbbZurHAvZiZ/j4Q23DdsIt37tVH+AfopYIBZRqLhFCaE
        MebE89IHfGa2WIAoqSUG5l5sUcmL9Yt+yKh41wHwgBvsD0vVZN45k2DPNlIQ6Ai1
        likRDrSgXXJvCzTcs4XiwPaesxPgN/Ktg1Lu65U2PumME5q7FHxjoUMtAxClZWdu
        /ZgyO/4wNJ5OSrSzYaYtZ7mlYa7uReIBvEFgKCZUtGPw4TkLod6ezPjT5sCA5+JA
        ==
X-ME-Sender: <xms:KVm_Wx4WOFcT4lvijbz4PQ2XT7LxmwbHBVwE0bJ2_48JvxRDDNEKpg>
X-ME-Proxy: <xmx:KVm_W-2D179EUG3---bj5aWN7B6sjNT_YPPAaYBW2SmqUVSQrwa-hQ>
    <xmx:KVm_WxZ6ElZwvRrcIR8oJYKmQY6Ht2fDb5TNUTzZBqrzf4Zw6hH6kA>
    <xmx:KVm_WyXgockMHQlsrM6n-Y0ruOhjH0g12LEZzKbXUVuaXhdo9OzFTg>
    <xmx:KVm_W6TXlN-TIQ_z-_mB-oR_v1I-ySkTV8niyTQPNO1jbPa_3l2FzQ>
    <xmx:KVm_W2K_b63ZQ9jKAWSEO7xg_LadUFEnLgOo9iEJOENhcbKpxzwMmQ>
    <xmx:KVm_W9URF_6S4zVehTOJA8u3rx0uYALlfV2Zs6MHIzRmySUFINpVbw>
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.messagingengine.com (Postfix) with ESMTPA id 037E2E40E6;
        Thu, 11 Oct 2018 10:07:36 -0400 (EDT)
Date:   Thu, 11 Oct 2018 16:07:35 +0200
From:   Greg KH <gregkh@linux-foundation.org>
To:     maowenan <maowenan@huawei.com>
Cc:     netdev@vger.kernel.org, dwmw2@infradead.org,
        eric.dumazet@gmail.com, davem@davemloft.net,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable 4.4 V2 0/6] fix SegmentSmack in stable branch
 (CVE-2018-5390)
Message-ID: <20181011140735.GA9507@kroah.com>
References: <1536913450-12380-1-git-send-email-maowenan@huawei.com>
 <83856420-af5a-e469-5b5b-e24634fc290f@huawei.com>
 <20180926202121.GB23881@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926202121.GB23881@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:21:21PM +0200, Greg KH wrote:
> On Tue, Sep 25, 2018 at 10:10:15PM +0800, maowenan wrote:
> > Hi Greg:
> > 
> > can you review this patch set?
> 
> It is still in the queue, don't worry.  It will take some more time to
> properly review and test it.
> 
> Ideally you could get someone else to test this and provide a
> "tested-by:" tag for it?

All now queued up, let's see what breaks :)

thanks,

greg k-h
