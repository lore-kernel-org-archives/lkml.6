Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76272C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AF220651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfAOFhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:37:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54018 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728108AbfAOFht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:37:49 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D0C4883C5D4F46436013;
        Tue, 15 Jan 2019 13:37:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.216.125) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 15 Jan 2019
 13:37:37 +0800
From:   Weilong Chen <chenweilong@huawei.com>
Subject: Problem of TCP bandwidth drops when change MTU to a small value
To:     David Miller <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <sd@queasysnail.net>
CC:     Netdev <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <weiyongjun1@huawei.com>
Message-ID: <c5e705e9-fbfe-489d-c2b6-85eebf9f241f@huawei.com>
Date:   Tue, 15 Jan 2019 13:37:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.216.125]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, when we change the mtu to a small value, for example, ifconfig eth0 
mtu 68, IPERF test shows there's a great bandwidth drop while previous 
kernel versions don't.
Git bisect find the differences is from the patch 
28d35bcdd3925e7293408cdb8aa5f2aac5f0d6e3 (net: ipv4: don't let PMTU 
updates increase route MTU). After this patch, the stack send packets 
use a small mtu.

This problem can be reproduced easily on a qemu-kvm platform with virt 
nic E1000:
# ethtool -i eth0
driver: e1000
version: 7.3.21-k8-NAPI
firmware-version:
expansion-rom-version:
bus-info: 0000:00:03.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no
# # iperf -c 9.81.3.11 -t 3
------------------------------------------------------------
Client connecting to 9.81.3.11, TCP port 5001
TCP window size: 85.0 KByte (default)
------------------------------------------------------------
[  3] local 9.83.1.202 port 44644 connected with 9.81.3.11 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 3.0 sec   336 MBytes   938 Mbits/sec
# ifconfig eth0 mtu 68
# iperf -c 9.81.3.11 -t 3
------------------------------------------------------------
Client connecting to 9.81.3.11, TCP port 5001
TCP window size: 85.0 KByte (default)
------------------------------------------------------------
[  3] local 9.83.1.202 port 44646 connected with 9.81.3.11 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 3.3 sec  3.62 MBytes  9.18 Mbits/sec

