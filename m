Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeC0JbB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:31:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:43559 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeC0JbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:31:00 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        marting@netapp.com, Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] nvme: don't send keep-alives to the discovery controller
Date: Tue, 27 Mar 2018 11:28:48 +0200
Message-Id: <20180327092848.10404-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMe over Fabrics 1.0 Section 5.2 "Discovery Controller Properties and
Command Support" Figure 31 "Discovery Controller – Admin Commands"
explicitly listst all commands but "Get Log Page" and "Identify" as
reserved, but NetApp report the Linux host is sending Keep Alive
commands to the discovery controller, which is a violation of the
Spec.

We're already checking for discovery controllers when configuring the
keep alive timeout but when creating a discovery controller we're not
hard wiring the keep alive timeout to 0 and thus remain on
NVME_DEFAULT_KATO for the discovery controller.

This can be easily remproduced when issuing a direct connect to the
discovery susbsystem using:
'nvme connect [...] --nqn=nqn.2014-08.org.nvmexpress.discovery'

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Fixes: 07bfcd09a288 ("nvme-fabrics: add a generic NVMe over Fabrics library")
Reported-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/fabrics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8f0f34d06d46..3583f9492a45 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -608,8 +608,10 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			opts->discovery_nqn =
 				!(strcmp(opts->subsysnqn,
 					 NVME_DISC_SUBSYS_NAME));
-			if (opts->discovery_nqn)
+			if (opts->discovery_nqn) {
+				opts->kato = 0;
 				opts->nr_io_queues = 0;
+			}
 			break;
 		case NVMF_OPT_TRADDR:
 			p = match_strdup(args);
-- 
2.12.3
