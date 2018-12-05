Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB8BC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D642208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D642208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeLEWyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:54:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbeLEWyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:54:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F3CCA7DD;
        Wed,  5 Dec 2018 22:54:15 +0000 (UTC)
Received: from redhat.com (ovpn-122-208.rdu2.redhat.com [10.10.122.208])
        by smtp.corp.redhat.com (Postfix) with SMTP id 17ABD5C69A;
        Wed,  5 Dec 2018 22:54:09 +0000 (UTC)
Date:   Wed, 5 Dec 2018 17:54:09 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     maxime.coquelin@redhat.com, tiwei.bie@intel.com, wexu@redhat.com,
        jfreimann@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC 0/2] virtio-net: interrupt related improvements
Message-ID: <20181205225323.12555-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 05 Dec 2018 22:54:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have brought the virtio overhead way down with a fast packed
ring implementation, we seem to be actually observing TCP drops
indicative of bufferbloat. So let's try to enable TSQ.  Note: it isn't
clear that the default pacing is great for the virt usecase. It's worth
trying to play with sk_pacing_shift_update to see what happens.

For this reason, and for a more important one that I didn't
have time to test it yet, sending as an RFC.

Michael S. Tsirkin (2):
  virtio-net: bql support
  virtio_net: bulk free tx skbs

 drivers/net/virtio_net.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

-- 
MST

