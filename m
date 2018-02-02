Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBBHCC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:02:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35978 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeBBHBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:01:45 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6]nvme-pci: fixes on nvme_timeout and nvme_dev_disable
Date: Fri,  2 Feb 2018 15:00:43 +0800
Message-Id: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020080
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, Keith and Sagi

Please consider and comment on the following patchset.
That's really appreciated.

There is a complicated relationship between nvme_timeout and nvme_dev_disable.
 - nvme_timeout has to invoke nvme_dev_disable to stop the
   controller doing DMA access before free the request.
 - nvme_dev_disable has to depend on nvme_timeout to complete
   adminq requests to set HMB or delete sq/cq when the controller
   has no response.
 - nvme_dev_disable will race with nvme_timeout when cancels the
   outstanding requests.
We have found some issues introduced by them, please refer the following link

http://lists.infradead.org/pipermail/linux-nvme/2018-January/015053.html 
http://lists.infradead.org/pipermail/linux-nvme/2018-January/015276.html
http://lists.infradead.org/pipermail/linux-nvme/2018-January/015328.html
Even we cannot ensure there is no other issue.

The best way to fix them is to break up the relationship between them.
With this patch, we could avoid nvme_dev_disable to be invoked
by nvme_timeout and eliminate the race between nvme_timeout and
nvme_dev_disable on outstanding requests.


There are 6 patches:

1st ~ 3th patches does some preparation for the 4th one.
4th is to avoid nvme_dev_disable to be invoked by nvme_timeout, and implement
the synchronization between them. More details, please refer to the comment of
this patch.
5th fixes a bug after 4th patch is introduced. It let nvme_delete_io_queues can
only be wakeup by completion path.
6th fixes a bug found when test, it is not related with 4th patch.

This patchset was tested under debug patch for some days.
And some bugfix have been done.
The debug patch and other patches are available in following it branch:
https://github.com/jianchwa/linux-blcok.git nvme_fixes_test

Jianchao Wang (6)
0001-nvme-pci-move-clearing-host-mem-behind-stopping-queu.patch
0002-nvme-pci-fix-the-freeze-and-quiesce-for-shutdown-and.patch
0003-blk-mq-make-blk_mq_rq_update_aborted_gstate-a-extern.patch
0004-nvme-pci-break-up-nvme_timeout-and-nvme_dev_disable.patch
0005-nvme-pci-discard-wait-timeout-when-delete-cq-sq.patch
0006-nvme-pci-suspend-queues-based-on-online_queues.patch

diff stat following:
 block/blk-mq.c          |   3 +-
 drivers/nvme/host/pci.c | 225 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------
 include/linux/blk-mq.h  |   1 +
 3 files changed, 169 insertions(+), 60 deletions(-)

Thanks
Jianchao
