Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755893AbeBOUmd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:42:33 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:51482 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755879AbeBOUma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:42:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 4C2832F880C
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: TCP and BBR: reproducibly low cwnd and bandwidth
Date: Thu, 15 Feb 2018 21:42:26 +0100
Message-ID: <1697118.nv5eASg0nx@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1518727347;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding;
        bh=UfhYGqNvxVp6r5MUMW3unOsBVjmhOFKCusZgs2veaPE=;
        b=HUr4t5ofq88DM6UgbQCyw1xCTio9Fk4B8AdPbQvcbdd3H6RbPpjD28pzz8sswCSXTOgUgs
        lsTrqRgCI0cgt1O5WyvBOvBoJigIDXoiWEGKH8iGYH1VlV+9f4WlV3v9Layh9AdbA7TgCl
        iNQf7FieOtVI75AnhcQ01uDI4/Gr4GU=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1518727347; a=rsa-sha256;
        cv=none;
        b=OF+x+Esoru81t27NDw0z1DNee9UOFhP/1iOMJUCL9R8ygRhDN10qtBzX6nT52wVtnwAhDBRRoy8Gebb/DI3ks2zP8LeCdhNyZRDlPYQZwMhy0XCPKCFRnVGtY+Y/wCUBM4oozlIBZsNBjnAFEe1RaRFNe2CBRODDQnxOg2e1HG4=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I've faced an issue with a limited TCP bandwidth between my laptop and a 
server in my 1 Gbps LAN while using BBR as a congestion control mechanism. To 
verify my observations, I've set up 2 KVM VMs with the following parameters:

1) Linux v4.15.3
2) virtio NICs
3) 128 MiB of RAM
4) 2 vCPUs
5) tested on both non-PREEMPT/100 Hz and PREEMPT/1000 Hz

The VMs are interconnected via host bridge (-netdev bridge). I was running 
iperf3 in the default and reverse mode. Here are the results:

1) BBR on both VMs

upload: 3.42 Gbits/sec, cwnd ~ 320 KBytes
download: 3.39 Gbits/sec, cwnd ~ 320 KBytes

2) Reno on both VMs

upload: 5.50 Gbits/sec, cwnd = 976 KBytes (constant)
download: 5.22 Gbits/sec, cwnd = 1.20 MBytes (constant)

3) Reno on client, BBR on server

upload: 5.29 Gbits/sec, cwnd = 952 KBytes (constant)
download: 3.45 Gbits/sec, cwnd ~ 320 KBytes

4) BBR on client, Reno on server

upload: 3.36 Gbits/sec, cwnd ~ 370 KBytes
download: 5.21 Gbits/sec, cwnd = 887 KBytes (constant)

So, as you may see, when BBR is in use, upload rate is bad and cwnd is low. If 
using real HW (1 Gbps LAN, laptop and server), BBR limits the throughput to 
~100 Mbps (verifiable not only by iperf3, but also by scp while transferring 
some files between hosts).

Also, I've tried to use YeAH instead of Reno, and it gives me the same results 
as Reno (IOW, YeAH works fine too).

Questions:

1) is this expected?
2) or am I missing some extra BBR tuneable?
3) if it is not a regression (I don't have any previous data to compare with), 
how can I fix this?
4) if it is a bug in BBR, what else should I provide or check for a proper 
investigation?

Thanks.

Regards,
  Oleksandr
