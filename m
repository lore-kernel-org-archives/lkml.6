Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeEPClQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 22:41:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38112 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbeEPCkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 22:40:23 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.duyck@gmail.com, tobin@apporbit.com,
        andy.shevchenko@gmail.com
Subject: [PATCH v5 0/3] multi-threading device shutdown
Date: Tue, 15 May 2018 22:40:01 -0400
Message-Id: <20180516024004.28977-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805160023
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
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
2.17.0
