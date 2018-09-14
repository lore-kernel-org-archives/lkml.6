Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEAEC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7977F20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kWlPb4dD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7977F20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeINMrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:47:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60736 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeINMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:47:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8E7TFEr077176;
        Fri, 14 Sep 2018 07:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ZnerUsFJiwj5E1pHLXUuYIDlLF6LkzVIpT9kIMBiIAU=;
 b=kWlPb4dDLeVkTXv7z/EyGAU6f1Ub/M/hS7pyKC/3XfK4J+i3PdXkULHGjQsOok+N9Yq7
 MDvYJKxv3fTfWr700ESSwcX2GCe8OkVbnFrcipb42gjN0bnoWy4Yr+fcQX1P5Rk4BcG9
 LMUDWKp81Vjri6/R/y4J6XIDoRNmh1hoGwJ1xNrW3a7leXDQgEWxUOKRoKc5foXXJBby
 3jJXRas7MEV4ARsAFWp/96AOvq6Fx29cMuO1Y+V3I7aNgwKOBOGsypeLophKKEiXVOEW
 FLrAUdhV++Poq2d45szXUk5W7BEK2zLFWClnQ7zugnMsbx66t/LdBR1NDiApuvsDdNMH 2A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mc72r5bq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 07:33:49 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8E7XmZS019380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 07:33:48 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8E7XlP7019412;
        Fri, 14 Sep 2018 07:33:47 GMT
Received: from linux.cn.oracle.com (/10.182.70.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 07:33:46 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        paul.durrant@citrix.com, wei.liu2@citrix.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com,
        srinivas.eeda@oracle.com
Subject: Introduce xenwatch multithreading (mtwatch)
Date:   Fri, 14 Sep 2018 15:34:10 +0800
Message-Id: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set introduces xenwatch multithreading (mtwatch) based on the
below xen summit 2018 design session notes:

https://lists.xenproject.org/archives/html/xen-devel/2018-07/msg00017.html


xenwatch_thread is a single kernel thread processing the callback function
for subscribed xenwatch events successively. The xenwatch is stalled in 'D'
state if any of callback function is stalled and uninterruptible.

The domU create/destroy is failed if xenwatch is stalled in 'D' state as
the paravirtual driver init/uninit cannot complete. Usually, the only
option is to reboot dom0 server unless there is solution/workaround to
move forward and complete the stalled xenwatch event callback function.
Below is the output of 'xl create' when xenwatch is stalled (the issue is
reproduced on purpose by hooking netif_receive_skb() to intercept an
sk_buff sent out from vifX.Y on dom0 with patch at
https://github.com/finallyjustice/patchset/blob/master/xenwatch-stall-by-vif.patch):

# xl create pv.cfg 
Parsing config from pv.cfg
libxl: error: libxl_device.c:1080:device_backend_callback: Domain 2:unable to add device with path /local/domain/0/backend/vbd/2/51712
libxl: error: libxl_create.c:1278:domcreate_launch_dm: Domain 2:unable to add disk devices
libxl: error: libxl_device.c:1080:device_backend_callback: Domain 2:unable to remove device with path /local/domain/0/backend/vbd/2/51712
libxl: error: libxl_domain.c:1073:devices_destroy_cb: Domain 2:libxl__devices_destroy failed
libxl: error: libxl_domain.c:1000:libxl__destroy_domid: Domain 2:Non-existant domain
libxl: error: libxl_domain.c:959:domain_destroy_callback: Domain 2:Unable to destroy guest
libxl: error: libxl_domain.c:886:domain_destroy_cb: Domain 2:Destruction of domain failed


The idea of this patch set is to create a per-domU xenwatch thread for each
domid. The per-domid thread is created when the 1st pv backend device (for
this domid and with xenwatch multithreading enabled) is created, while this
thread is destroyed when the last pv backend device (for this domid and
with xenwatch multithreading enabled) is removed. Per-domid xs_watch_event
is never put on the default event list, but is put on the per-domid event
list directly.


For more details, please refer to the xen summit 2018 design session notes
and presentation slides:

https://lists.xenproject.org/archives/html/xen-devel/2018-07/msg00017.html
http://www.donglizhang.org/xenwatch_multithreading.pdf

----------------------------------------------------------------

Dongli Zhang (6):
    xenbus: prepare data structures and parameter for xenwatch multithreading
    xenbus: implement the xenwatch multithreading framework
    xenbus: dispatch per-domU watch event to per-domU xenwatch thread
    xenbus: process otherend_watch event at 'state' entry in xenwatch multithreading
    xenbus: process be_watch events in xenwatch multithreading
    drivers: enable xenwatch multithreading for xen-netback and xen-blkback driver

 Documentation/admin-guide/kernel-parameters.txt |   3 +
 drivers/block/xen-blkback/xenbus.c              |   3 +-
 drivers/net/xen-netback/xenbus.c                |   1 +
 drivers/xen/xenbus/xenbus_probe.c               |  24 +-
 drivers/xen/xenbus/xenbus_probe_backend.c       |  32 +++
 drivers/xen/xenbus/xenbus_xs.c                  | 357 +++++++++++++++++++++++-
 include/xen/xenbus.h                            |  70 +++++
 7 files changed, 484 insertions(+), 6 deletions(-)

Thank you very much!

Dongli Zhang

