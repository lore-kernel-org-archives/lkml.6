Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1FAB8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41CB208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41CB208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754391AbeFLUZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:25:01 -0400
Received: from www62.your-server.de ([213.133.104.62]:37764 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeFLUZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:25:00 -0400
Received: from [178.197.248.16] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fSpqW-0005Oh-KU; Tue, 12 Jun 2018 22:24:52 +0200
Subject: Re: [BUG] cc5b114dcf bpf, i40e: add meta data support
To:     Keith Busch <keith.busch@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        John Fastabend <john.fastabend@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        linux-kernel@vger.kernel.org
References: <20180612161739.GA3303@localhost.localdomain>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <dc3176ae-5b16-ffa8-c8c8-595a0ede57f4@iogearbox.net>
Date:   Tue, 12 Jun 2018 22:24:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180612161739.GA3303@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24656/Tue Jun 12 14:35:50 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 06:17 PM, Keith Busch wrote:
> My server's i40e no longer obtains an IP address on linux
> mainline. Bisected to the following:
> 
> commit cc5b114dcf986bfd8e4c37bf65d1b7b1e5290ac6
> Author: Daniel Borkmann <daniel@iogearbox.net>
> Date:   Mon May 28 11:07:20 2018 +0200
> 
>     bpf, i40e: add meta data support
> 
> Reverting on mainline resolves the issue.
> 
> Is there something wrong with my i40e adapter, or is the patch possibly
> doing something wrong? Or any other information I can get to help
> understand why it's stopped working with this feature?
> 
> An excert from "journalctl -xe" on on the failing network adapter
> is below.

Thanks for the report & sorry for the issue, Keith! Instead of revert,
could you give the below fix a try?

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8ffb745..ed6dbcf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2103,9 +2103,8 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
 	unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
 #else
 	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
-				SKB_DATA_ALIGN(I40E_SKB_PAD +
-					       (xdp->data_end -
-						xdp->data_hard_start));
+				SKB_DATA_ALIGN(xdp->data_end -
+					       xdp->data_hard_start);
 #endif
 	struct sk_buff *skb;

@@ -2124,7 +2123,7 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
 		return NULL;

 	/* update pointers within the skb to store the data */
-	skb_reserve(skb, I40E_SKB_PAD + (xdp->data - xdp->data_hard_start));
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	__skb_put(skb, xdp->data_end - xdp->data);
 	if (metasize)
 		skb_metadata_set(skb, metasize);

Thanks,
Daniel
