Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77083C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F0C20890
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="catCZb7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F0C20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbeGYOj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbeGYOj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:39:29 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F4320893;
        Wed, 25 Jul 2018 13:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532525268;
        bh=4dshf+C7gcGIGamhmNQZV5GgiKbAAwQ8ii3Poo6QE9E=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=catCZb7Ll9MYNEkcqrfMkcOBIiA6UFaWVbsNsyg5GjhYxbDvBQyUTpukor1NWPyM4
         3eJSCBN3tCAR+KsULcKIYC7w/ngDMDPPgsH8qR/0m9Xb8hExHQphAXlCXlTk4g8KAm
         bCXZCltV4HC6G3a7e7Xy6AQx9U5rCQZnP0Y4UDNg=
Received: by mail-wr1-f51.google.com with SMTP id a3-v6so7429131wrt.2;
        Wed, 25 Jul 2018 06:27:48 -0700 (PDT)
X-Gm-Message-State: AOUpUlHsLCuUBSA/VEuQm0hInjxivZ9r55/wfQYINzAH3XMuPuA1gewJ
        2nsq2FD+ATLl/CgTeC5U7b7W+Sd/MdpPRaipDQg=
X-Google-Smtp-Source: AAOMgpfbXMWeDmcu2bcfm7/4KB9bD9N1HwJEWJT/jo8eBDVWkfIAjajdD9CWLJmTCReY2OZakttqGbB5G5t2M1QwwMo=
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr15091319wre.12.1532525266943;
 Wed, 25 Jul 2018 06:27:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 06:27:46
 -0700 (PDT)
In-Reply-To: <784782B0-A387-4D3B-A517-E85D851162B8@oracle.com>
References: <CAJKOXPd2rntNOpU1quR9Zm_J22+=pEaj4ZTC_tdZ0zcRYUciFg@mail.gmail.com>
 <CAPKp9uZ79ybkv7dMpcy2GQ9L+rWk+vdExQ48diWWQPOUdDQtSQ@mail.gmail.com>
 <CAJKOXPfX0CytKcYDaDAYYuCQjk-mcGjFRHfZco-wPQsc4G1agA@mail.gmail.com>
 <BCD39D7E-EEEC-4EB9-824E-63323C333C88@oracle.com> <CAJKOXPcw-i99_U-Ltuuf6w-WRK7V4gNqVSYkCMGFEXQG2DL2XQ@mail.gmail.com>
 <CAJKOXPf7V1z4pNZ2RsjkJmaVAgk34_rPOtQOc7J5KRMSRemrdg@mail.gmail.com>
 <082848F5-6360-4523-BA95-601777E17CF2@oracle.com> <CAJKOXPe4uqOZGd_zb_Mqq4Fspu63LHZky86O4tPaD3BZNCBS6w@mail.gmail.com>
 <6AAC5897-8762-4209-8718-67291B87AA00@oracle.com> <d617f8a85c3414230cd755fe0e4470c0f8bd17ff.camel@hammerspace.com>
 <26995E49-E8DD-421D-BABF-9E672B9383BD@oracle.com> <30a1455b6817361f8228c022628aef5cdee70c3e.camel@hammerspace.com>
 <784782B0-A387-4D3B-A517-E85D851162B8@oracle.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 25 Jul 2018 15:27:46 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfMiaGP9xqPcOQMs+a4RKvhK03v51e5r3GaUiFs0G=61Q@mail.gmail.com>
Message-ID: <CAJKOXPfMiaGP9xqPcOQMs+a4RKvhK03v51e5r3GaUiFs0G=61Q@mail.gmail.com>
Subject: Re: [BUG BISECT] NFSv4 client fails on Flush Journal to Persistent Storage
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 June 2018 at 18:20, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> The extra serialization appears to have a reproducible performance
> impact on RDMA, which no longer takes the reserve_lock when allocating
> a slot.
>
> I could put an xprt_alloc_xid call in xprt_alloc_slot, but that would
> only work for socket-based transports. Would it be OK if RDMA had its
> own XID allocation mechanism?

Hi,

On recent next the issue appeared again. My boards with NFSv4 root
timeout on 80% of boots. This time my NFS server is faster - Pi3 B+
:).

Is this know? Should I start long bisect or maybe you can point me to
possible causes?

Best regards,
Krzysztof
