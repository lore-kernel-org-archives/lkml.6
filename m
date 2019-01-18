Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A129C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A40B2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfARKtK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:49:10 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49007 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfARKtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:49:09 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1BD80CEE14;
        Fri, 18 Jan 2019 11:56:54 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] Bluetooth: Fix locking in bt_accept_enqueue() for BH
 context
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190103001120.177784-1-mka@chromium.org>
Date:   Fri, 18 Jan 2019 11:49:07 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dean Jenkins <Dean_Jenkins@mentor.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <49E47F95-44F6-4A1E-8595-924EE40AF1A8@holtmann.org>
References: <20190103001120.177784-1-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> With commit e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket
> atomically") lock_sock[_nested]() is used to acquire the socket lock
> before manipulating the socket. lock_sock[_nested]() may block, which
> is problematic since bt_accept_enqueue() can be called in bottom half
> context (e.g. from rfcomm_connect_ind()):
> 
> [<ffffff80080d81ec>] __might_sleep+0x4c/0x80
> [<ffffff800876c7b0>] lock_sock_nested+0x24/0x58
> [<ffffff8000d7c27c>] bt_accept_enqueue+0x48/0xd4 [bluetooth]
> [<ffffff8000e67d8c>] rfcomm_connect_ind+0x190/0x218 [rfcomm]
> 
> Add a parameter to bt_accept_enqueue() to indicate whether the
> function is called from BH context, and acquire the socket lock
> with bh_lock_sock_nested() if that's the case.
> 
> Also adapt all callers of bt_accept_enqueue() to pass the new
> parameter:
> 
> - l2cap_sock_new_connection_cb()
>  - uses lock_sock() to lock the parent socket => process context
> 
> - rfcomm_connect_ind()
>  - acquires the parent socket lock with bh_lock_sock() => BH
>    context
> 
> - __sco_chan_add()
>  - called from sco_chan_add(), which is called from sco_connect().
>    parent is NULL, hence bt_accept_enqueue() isn't called in this
>    code path and we can ignore it
>  - also called from sco_conn_ready(). uses bh_lock_sock() to acquire
>    the parent lock => BH context
> 
> Fixes: e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket atomically")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - use parameter in bt_accept_enqueue() to decide which lock to
>  acquire and adapt all callers
> - updated commit message
> ---
> include/net/bluetooth/bluetooth.h |  2 +-
> net/bluetooth/af_bluetooth.c      | 16 +++++++++++++---
> net/bluetooth/l2cap_sock.c        |  2 +-
> net/bluetooth/rfcomm/sock.c       |  2 +-
> net/bluetooth/sco.c               |  2 +-
> 5 files changed, 17 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

