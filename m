Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6D7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C0E20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfAPV3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:29:36 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:42893 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbfAPV3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:29:30 -0500
Received: from [192.168.1.110] ([95.115.4.128]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mf0Ru-1hBoi51Hkw-00gZWN; Wed, 16 Jan 2019 22:29:27 +0100
To:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Pretzsch <apr@cn-eng.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject:  platform device initialization order
Organization: metux IT consult
Message-ID: <e5067620-a96c-fb87-2596-6cc10535c3aa@metux.net>
Date:   Wed, 16 Jan 2019 22:29:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lG5KdsBn0hdngY73fhY6bvabZRodznRVyrDn1iMkmDqzWr458vF
 ozwHUFJrJQKdMtDu0VUmjXs0IW95d8IeFy4nXZxksGfV7EJtOqfA/wbTWJW1CKfXf8EMfqn
 dvz5BU/PCP1gIpjKeSVfiF3MUyVyiHPiI/JUgFIJPzHbaDoF+cQLmeEgQJ0Nx/1NO0pE6xp
 Im/oU6QY/Ko0OceEA6f+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uAw/6lAmxc4=:gRy+/Fu4X8Kl9wEiqjNeWT
 vnNbUawy9elbZIXUNL0k76hYgAtKhwyM3z8cESKeJpzZ7PJ+yp27RPwnRXCD/S1om+L5Ib6wG
 i64OqF36ERLPaPBcOZW9CumCL3+RTxdA529oTXcyg0NObRGpxfdBpGTa11N+Lm9qOx1hzTuR/
 2HKVEIjDGi3huQ3Z2oZc/ntIAoaqCDhTl8zvC72XBk3QSTCFVvEnXUli0+GK02S+0xtUjBFR8
 vYGkNXndngZ618AB0uYWL5rP0vwGf2ztZU8EflquFvLPf3u2B9wCptbtxSofHBklmxrNGtJ/Z
 2eMpwp7jTOl9QfRQQDe5zPJkOlgGnxXjokWY35fwT3swYMMIKFu05wTu6ZCaC1si6pQ2tV9PF
 74l60nN4KpUSBLmpwhn6BqfRF308GZBO0bIDBiWuFNJKFv01vW001eCHcnUWfrDNm5eMlcxxM
 uU7vSFkD6ytS/4skcsGMx4VIWlQSl8Cj6+lLlUxdKhQfYa9py1sDcn4auNf+YnTGCRLEJyEOT
 4V3MjFexx1TkAt4PTNvZzX3zjY5J3Fi5PQapT6E7bRL0/hIeZilPF6uN63kMQOOJnKN3CHJmy
 Z6/dz1oNOZWBPe/14uou1PsnQSjS432cQ+spySQwaQfEfD17gpd3Mu/SffO+CUwwddium3jYF
 mrJpS7yrMBIXl/gB7kh4JWP7emosqtP5cit82DhlmpSWbE8C56++I/lDZQTxCIDDRHtqSlSmS
 X1AFJj8PmaX9ateJ8jD9Og9epQOh/uDOhGUkiZxhUdV80zXgLbylmWkc6FE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


I'm currently writing a x86 board driver which makes use of a gpio
chip driver, gpio-leds and gpio-keyboard driver.

The init function fist initializes the gpio device, then the others,
via platform_device_register_resndata().

Here my problem starts: when the gpio driver is built as a module,
the order is mixed up - gpio driver is probed *after* the others
that need the gpio's. So, the gpio's aren't available yet, thus the
other drivers cant be initialized. If it's built-in, the order is
correct. A nasty timing problem.

Is there any way I can force the correct initialization order ?


thx
--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
