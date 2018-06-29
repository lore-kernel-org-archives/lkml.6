Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC16C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6956D27AA9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i6WY8K5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6956D27AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966259AbeF2SZ7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:25:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44776 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966039AbeF2SZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:25:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TIOr0K123664;
        Fri, 29 Jun 2018 18:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2017-10-26;
 bh=KeASJQQcGDUKBrjHplCkBQw74bQZtxm6DL5RXhZjfbw=;
 b=i6WY8K5sNbQJ2VWq3qnsRSH/6/8oMJZogbbvODAWP6Wc8tXUY+DHC1eS5r8YWFeTM7ie
 9UT1IDgB+bT/RGFwX33KhEb2bzYBsyCRgYNbZRUkzBMVM4fQEnklGGcIxUN9iZc7yNTL
 2vJyyFP2JfNOAQvjQIlKLLaAw926JRa6SFOyyqr9deZtbxlcd9noQRKNfjVNdGGILuN+
 qzmk/yrZbm2BBB/C+OyEbPEEdFuNdKwdCUz1h1+l7u8qJrqfUAF29+IjP1oIAAv/N6hH
 RSQTk4ZlSYG/eNq1eWH2nfaT/JfnzbE0gxBxlE+yvSst2AAmVxit/w8yg6lfN/u3v3vD nQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jukmu7mxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 18:25:48 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5TIPlGI017092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 18:25:47 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5TIPksn031695;
        Fri, 29 Jun 2018 18:25:46 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 11:25:45 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.duyck@gmail.com, tobin@apporbit.com,
        andy.shevchenko@gmail.com
Subject: [PATCH v6 0/3] multi-threading device shutdown
Date:   Fri, 29 Jun 2018 14:25:38 -0400
Message-Id: <20180629182541.6735-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v6 - v5
	- Added Review-by from Andy.
	- Synced with mainline
v4 - v5
	- Addressed comments from Andy Shevchenko and Greg
	  Kroah-Hartman
	- Split the patch into a series of 3 patches in order to
	  provide a better bisecting, and facilitate with reviewing.
v3 - v4
	- Added device_shutdown_serial kernel parameter to disable
	  multi-threading as suggested by Greg Kroah-Hartman

v2 - v3
	- Fixed warning from kbuild test.
	- Moved device_lock/device_unlock inside device_shutdown_tree().

v1 - v2
	- It turns out we cannot lock more than MAX_LOCK_DEPTH by a single
	  thread. (By default this value is 48), and is used to detect
	  deadlocks. So, I re-wrote the code to only lock one devices per
	  thread instead of pre-locking all devices by the main thread.
	- Addressed comments from Tobin C. Harding.
	- As suggested by Alexander Duyck removed ixgbe changes. It can be
	  done as a separate work scaling RTNL mutex.

Do a faster shutdown by calling dev->*->shutdown(dev) in parallel.
device_shutdown() calls these functions for every single device but
only using one thread.

Since, nothing else is running on the machine by the time
device_shutdown() is called, there is no reason not to utilize all the
available CPU resources.

Pavel Tatashin (3):
  drivers core: refactor device_shutdown
  drivers core: prepare device_shutdown for multi-threading
  drivers core: multi-threading device shutdown

 drivers/base/core.c | 290 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 243 insertions(+), 47 deletions(-)

-- 
2.18.0

