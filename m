Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A98F9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6947520891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6947520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934732AbeFMQOn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:14:43 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:47328 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754498AbeFMQOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:14:41 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fT8Pr-0002eL-2i; Wed, 13 Jun 2018 17:14:35 +0100
Message-ID: <1528906474.2289.155.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 110/268] nvme-pci: Fix nvme queue cleanup if IRQ
 setup fails
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Jun 2018 17:14:34 +0100
In-Reply-To: <20180528100214.621806271@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100214.621806271@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 12:01 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Jianchao Wang <jianchao.w.wang@oracle.com>
> 
> [ Upstream commit f25a2dfc20e3a3ed8fe6618c331799dd7bd01190 ]
> 
> This patch fixes nvme queue cleanup if requesting an IRQ handler for
> the queue's vector fails. It does this by resetting the cq_vector to
> the uninitialized value of -1 so it is ignored for a controller reset.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> [changelog updates, removed misc whitespace changes]
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/nvme/host/pci.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1583,7 +1583,7 @@ static int nvme_create_queue(struct nvme
>  	nvmeq->cq_vector = qid - 1;
>  	result = adapter_alloc_cq(dev, qid, nvmeq);
>  	if (result < 0)
> -		return result;
> +		goto release_vector;
>  
>  	result = adapter_alloc_sq(dev, qid, nvmeq);
>  	if (result < 0)
> @@ -1597,9 +1597,12 @@ static int nvme_create_queue(struct nvme
>  	return result;
>  
>   release_sq:
> +	dev->online_queues--;

This addition looks wrong.  dev->online_queues is incremented by
nvme_init_queue(), but this function only calls that at a point where
it is sure to succeed.  So why would a failure path need to decrement
it?

Ben.

>  	adapter_delete_sq(dev, qid);
>   release_cq:
>  	adapter_delete_cq(dev, qid);
> + release_vector:
> +	nvmeq->cq_vector = -1;
>  	return result;
>  }
>  
> 
> 
> 
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
