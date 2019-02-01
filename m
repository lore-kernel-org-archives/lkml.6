Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09389C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85FC218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbfBALmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:42:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfBALmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:42:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 960AE552C7;
        Fri,  1 Feb 2019 11:42:16 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-116.ams2.redhat.com [10.36.117.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 743F01001F3C;
        Fri,  1 Feb 2019 11:42:08 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] vsock/virtio: fix issues on device hot-unplug
Date:   Fri,  1 Feb 2019 12:42:05 +0100
Message-Id: <20190201114207.97217-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 01 Feb 2019 11:42:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches try to handle the hot-unplug of vsock virtio transport device in
a proper way.

Maybe move the vsock_core_init()/vsock_core_exit() functions in the module_init
and module_exit of vsock_virtio_transport module can't be the best way, but the
architecture of vsock_core forces us to this approach for now.

The vsock_core proto_ops expect a valid pointer to the transport device, so we
can't call vsock_core_exit() until there are open sockets.

v2 -> v3:
 - Rebased on master

v1 -> v2:
 - Fixed commit message of patch 1.
 - Added Reviewed-by, Acked-by tags by Stefan

Stefano Garzarella (2):
  vsock/virtio: fix kernel panic after device hot-unplug
  vsock/virtio: reset connected sockets on device removal

 net/vmw_vsock/virtio_transport.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

-- 
2.20.1

