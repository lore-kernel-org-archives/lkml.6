Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55423C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E3421841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391979AbfAKPIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:08:14 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:43278 "EHLO
        cdptpa-cmomta01.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388440AbfAKO2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:28:03 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2019 09:28:02 EST
Received: from [192.168.86.39] ([98.26.25.200])
        by cmsmtp with ESMTPA
        id hxf3gm14oSv2qhxf5gVXZm; Fri, 11 Jan 2019 14:19:52 +0000
To:     linux-kernel@vger.kernel.org
From:   bnv@nc.rr.com
Subject: DTLS and UDP servers
Message-ID: <b2c00870-c2bf-bd62-0476-4140c3a5a4e6@nc.rr.com>
Date:   Fri, 11 Jan 2019 09:19:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4wfFDlV5M0as7J3+SAEzCbQ+NRtOTDvxNNdY4NJkedeQgHnISpVUe+WBSYzArlUU6O6rnjv1Wph6QXl1KOSWmgFq78kmIYGCaCScXUpnT1xu8onHKTq0Cw
 e5+El654pRIfZ6XqTd7GAGIcowOUy4iR+IC1LA/dMEmFyW6ZNXGtxf3E
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Due to list volume, this address is not subscribed.  Please CC with any 
replies]

Standard practice when using DTLS on a UDP server is to bind and connect 
a new socket upon receipt of a valid ClientHello on the listener 
socket.  SO_REUSEPORT is required to ensure new sockets can bind to the 
same port as the listener socket.

This works because the listener socket will see nothing but ClientHello 
messages, and clients will block on a ServerHello message which is sent 
after the new connected socket is created.

However, there is a window of opportunity between the bind and connect 
calls, where the new socket temporarily takes over the port from the 
listener socket.  Ingress ClientHello messages will get delivered to the 
queue of the new socket within this window. The result is that 
authentication fails for the new client, and isn't begun for the other 
clients whose ClientHello messages were diverted.

Arguably, this is UDP so clients should not expect reliability and 
simply try again.However, this issue is addressable if a mechanism 
existed to bind and connect simultaneously.  Is it feasible?

Note: This would benefit the unsecured UDP server case as well, where it 
is desired to move a new "session" off the listener descriptor to its 
own for better scaling.  SO_REUSEPORT addresses this to a degree, but is 
modeled on multiple server processes rather than multiple threads within 
a single server process.

Regards, BH


