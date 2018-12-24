Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB2FC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C560C21908
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="pU7I/mGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbeLXM5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:57:19 -0500
Received: from forward100j.mail.yandex.net ([5.45.198.240]:46364 "EHLO
        forward100j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbeLXM5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:57:19 -0500
Received: from mxback2o.mail.yandex.net (mxback2o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1c])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id D710820813D3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:57:15 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback2o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id tNZqorhhrB-vFoWXZiF;
        Mon, 24 Dec 2018 15:57:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1545656235;
        bh=Z4uSVTBLRgAM4AlUGVKfQwZKhnxzWsjeHrBKDYqpnVE=;
        h=From:To:Subject:Date:Message-Id;
        b=pU7I/mGyDH37HTRleX4MR+BprzE9Mc54Aya/05pKGUj+dFPB+aX0RdIr51bu5jZ9F
         yf3iacMs8Agxyn922NJVsjU9y6Wi3NijD0Cwox5k4REfik2mLzIs1cDTNRqQ4Dq/uZ
         U3rZRyE45yVP50BLBn3mZsP9BbygDNIaIa85p6Xg=
Authentication-Results: mxback2o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-02732547ccc0.qloud-c.yandex.net with HTTP;
        Mon, 24 Dec 2018 15:57:15 +0300
From:   Nazarov Sergey <s-nazarov@yandex.ru>
To:     linux-kernel@vger.kernel.org
Subject: Incorrect use IPCB in icmp_send code
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 24 Dec 2018 15:57:15 +0300
Message-Id: <9280561545656235@sas1-02732547ccc0.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
icmp_send routine calls ip_option_echo, which uses IPCB to take skbuff compiled IP options.
But icmp_send could be called from TCP level too (security_sock_rcv_skb - cipso_v4_error for INET stream connection, for example).
After moving IP header data to the end of the struct tcp_skb_cb, this could lead to memory corruption when IP options copying.
Thanks.

