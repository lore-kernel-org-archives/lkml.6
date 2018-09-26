Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767C4C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3096B2150C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rrbbrSrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3096B2150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeI0CgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:36:04 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:37987 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726431AbeI0CgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:36:04 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 683C4B10;
        Wed, 26 Sep 2018 16:21:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 26 Sep 2018 16:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=B0MjkBYf6h2nCHnoVUmHfPeDPR7Aj
        FY+VQ9aM1afxSg=; b=rrbbrSrhyYfxaTeeNX3OufF3ihkwMcpU8IqCu9b/6JD+8
        qSQ8++fjfyZmRizQc/bglr7AwSEds2LlOZafLfxKF1H3Y9YUKxJi95qULjSV/EMy
        BaInCoFSBPWEZe8oJP3payUgzrlnKa+e0+bYCyqbYDnHm1frzUuEYQapIxufRoyh
        SvuiHpRMUyVNO3JXILW6ggMs5UUsev0ooPDHoZ0yWCEiDSlhQd31c/kGddUa8u2k
        gxPpIaUbM22h3i7wsZf8Ief4pwjN9G1zWuZRcjoT9sHoUVeBkL9sppTRtEj4IZ2o
        BrtvAdHuy9ALiJp0LRxT5TiI1qhFwbmuF8SKOYH9w==
X-ME-Proxy: <xmx:Q-qrWyWqVopmMUC0sY9dmckm2Uba5Nkl1QfwepU-5KJRG9l_LVlpfA>
    <xmx:Q-qrW1lwDhdY6Y8ZYf-YWqyqckOvSPBVcp63Sn1jlNHEFPvpTP0bfA>
    <xmx:Q-qrW7bZC_gywo-2rJ9lZGUX1IdAeUo1zs9z5nmQ4NEAUv9dX9-VAQ>
    <xmx:Q-qrW4NEjaM8WOS1NjiNXMfEwA6ePUI8gf9edZBvbl6TXVgWGNylpA>
    <xmx:Q-qrW4YTuf7q6WYak8L9b77n2f2vxk6hlmB7C6TIUifwzmsItGt6SA>
    <xmx:ROqrWwcrjsoDolO2Bjys6EG8ea3LQTHhtSGM2d-LC_ptwSFaFw_C5A>
X-ME-Sender: <xms:Q-qrW8OMcoadssMY7ZLmxj8wQ3AGpdmrGvHW1L_ZvSrSlOl-iGMQVw>
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id B5E11E47C2;
        Wed, 26 Sep 2018 16:21:22 -0400 (EDT)
Date:   Wed, 26 Sep 2018 22:21:21 +0200
From:   Greg KH <gregkh@linux-foundation.org>
To:     maowenan <maowenan@huawei.com>
Cc:     netdev@vger.kernel.org, dwmw2@infradead.org,
        eric.dumazet@gmail.com, davem@davemloft.net,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable 4.4 V2 0/6] fix SegmentSmack in stable branch
 (CVE-2018-5390)
Message-ID: <20180926202121.GB23881@kroah.com>
References: <1536913450-12380-1-git-send-email-maowenan@huawei.com>
 <83856420-af5a-e469-5b5b-e24634fc290f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83856420-af5a-e469-5b5b-e24634fc290f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:10:15PM +0800, maowenan wrote:
> Hi Greg:
> 
> can you review this patch set?

It is still in the queue, don't worry.  It will take some more time to
properly review and test it.

Ideally you could get someone else to test this and provide a
"tested-by:" tag for it?

thanks,

greg k-h
