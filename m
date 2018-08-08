Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D880BC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EF021722
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="bFda4Qfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EF021722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeHHLyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:54:15 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:47804 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726625AbeHHLyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:54:15 -0400
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:10])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 423E821826;
        Wed,  8 Aug 2018 12:35:19 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtpcorp1p.mail.yandex.net (Yandex) with ESMTP id 3ABEB6E40C95;
        Wed,  8 Aug 2018 12:35:19 +0300 (MSK)
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:854c:7dcd:9203:76a5])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id hjLu9lJ7SX-ZJwiH4B1;
        Wed, 08 Aug 2018 12:35:19 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1533720919; bh=/qzqOdZaLLsNypSbl+Doq2A9HC/89yPi8DE04cHzM3U=;
        h=To:From:Subject:Message-ID:Date;
        b=bFda4QfzQ8b1aoyb8Ko9aXal7koN7JLvPjOpau8WdKCTJ6TNT4dBo5n4XsYkaYnJd
         2jbbPidPNOpomjTywyazkl4aLhuTFlZ6DTDCnuusWjWeCPEt5YHxXyZ803Il6vHTml
         5PZ5LnJnPzMiimmfwfL6PilaWZhxqKFPEuLq96VI=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
To:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [BUG] sleep in atomic in bt/rfcomm
Message-ID: <4fed5a55-29d2-0b02-edd9-186765968ac9@yandex-team.ru>
Date:   Wed, 8 Aug 2018 12:35:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[906107.213068] BUG: sleeping function called from invalid context at net/core/sock.c:2764
[906107.213073] in_atomic(): 1, irqs_disabled(): 0, pid: 2032, name: krfcommd
[906107.213077] CPU: 3 PID: 2032 Comm: krfcommd Tainted: G        W       4.14.52-17 #1
[906107.213078] Hardware name: LENOVO 20FCS1DW00/20FCS1DW00, BIOS N1FET43W (1.17 ) 08/02/2016
[906107.213078] Call Trace:
[906107.213088]  dump_stack+0x5c/0x7e
[906107.213093]  ___might_sleep+0xec/0x110
[906107.213097]  lock_sock_nested+0x1c/0x70
[906107.213114]  bt_accept_enqueue+0x29/0x90 [bluetooth]
[906107.213122]  rfcomm_connect_ind+0x23e/0x2b4 [rfcomm]
[906107.213127]  rfcomm_run+0x149b/0x18d0 [rfcomm]
[906107.213131]  ? do_wait_intr_irq+0x90/0x90
[906107.213134]  kthread+0x10a/0x140
[906107.213138]  ? rfcomm_check_accept+0xa0/0xa0 [rfcomm]
[906107.213142]  ? kthread_create_on_node+0x40/0x40
[906107.213145]  ? SyS_exit+0x13/0x20
[906107.213149]  ret_from_fork+0x35/0x40

rfcomm_connect_ind() under bh-safe bh_lock_sock(parent) allocates new socket and
calls bt_accept_enqueue(parent, sk) for it which calls sleeping lock_sock(sk)

whole bt_accept_enqueue() looks highly dubious

void bt_accept_enqueue(struct sock *parent, struct sock *sk)
{
	BT_DBG("parent %p, sk %p", parent, sk);

	sock_hold(sk);
	lock_sock(sk);
	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
	bt_sk(sk)->parent = parent;
	release_sock(sk);
	parent->sk_ack_backlog++;
}
