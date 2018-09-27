Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07258C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E7B216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="VVkg3/TV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E7B216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=eikelenboom.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbeI1BS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:18:56 -0400
Received: from server.eikelenboom.it ([91.121.65.215]:58978 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeI1BS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:18:56 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 21:18:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gh6VTgfzZcC3RhcHwipxf1HCSu5ZDWQgXPtXhfAQimg=; b=VVkg3/TVP4fLmOH/bMb/BCVJ+9
        UpLwocLfUaRimsE7nbdXFFAJhHnt6E5j7+S0XlSRm+PtoAz1s0yx/136HOiXFcLpIN/PO5YEtpNOF
        qXhPqBWlNI/+LP4iVT60KHxdcgT3AYr+cdqiC0U4OW6K8Yj7la/i/gIUmLw8EUDOZJhM=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:54386 helo=[172.16.1.49])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@eikelenboom.it>)
        id 1g5bOo-0006kd-JH; Thu, 27 Sep 2018 20:52:30 +0200
Subject: Re: [Xen-devel] [PATCH] xen/blkfront: When purging persistent grants,
 keep them in the buffer
To:     Jens Axboe <axboe@kernel.dk>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180922195549.27953-1-boris.ostrovsky@oracle.com>
 <28aa9249-7406-21c6-f509-65411828e2d7@suse.com>
 <5bd1a695-50c6-e79f-38dd-c980fc2138ad@kernel.dk>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <00030538-e1ce-28ad-3548-8e3b07083b05@eikelenboom.it>
Date:   Thu, 27 Sep 2018 20:52:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5bd1a695-50c6-e79f-38dd-c980fc2138ad@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/18 16:26, Jens Axboe wrote:
> On 9/27/18 1:12 AM, Juergen Gross wrote:
>> On 22/09/18 21:55, Boris Ostrovsky wrote:
>>> Commit a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>>> added support for purging persistent grants when they are not in use. As
>>> part of the purge, the grants were removed from the grant buffer, This
>>> eventually causes the buffer to become empty, with BUG_ON triggered in
>>> get_free_grant(). This can be observed even on an idle system, within
>>> 20-30 minutes.
>>>
>>> We should keep the grants in the buffer when purging, and only free the
>>> grant ref.
>>>
>>> Fixes: a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>
>> Reviewed-by: Juergen Gross <jgross@suse.com>
> 
> Since Konrad is out, I'm going to queue this up for 4.19.
> 

Hi Boris/Juergen.

Last week i tested a linux-4.19-rc4 kernel with xen-next and this patch from Boris pulled on top. 
Unfortunately it made a VM hang (probably because it's rootFS is shuffled from under it's feet 
and it gave these in dom0 dmesg:

[ 9251.696090] xen-blkback: requesting a grant already in use
[ 9251.705861] xen-blkback: trying to add a gref that's already in the tree
[ 9251.715781] xen-blkback: requesting a grant already in use
[ 9251.725756] xen-blkback: trying to add a gref that's already in the tree
[ 9251.735698] xen-blkback: requesting a grant already in use
[ 9251.745573] xen-blkback: trying to add a gref that's already in the tree

The VM was a HVM with 4 vcpu's and 2 phy disks:
xen-blkback: backend/vbd/14/768: using 4 queues, protocol 1 (x86_64-abi) persistent grants
xen-blkback: backend/vbd/14/832: using 4 queues, protocol 1 (x86_64-abi) persistent grants


Currently i have been running 4.19-rc5 with xen-next on top and commit a46b53672b2c reverted,
for a couple of days. That seems to run stable for me (since it's a small box so i'm not hit
by what a46b53672b2c tried to fix.

If you can come up with a debug patch i can give that a spin tomorrow evening or in the weekend,
so we are hopefully still in time for the 4.19 release.

--
Sander
