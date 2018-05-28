Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165278AbeE1NRt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163596AbeE1KuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 197/496] nvme: pci: pass max vectors as num_possible_cpus() to pci_alloc_irq_vectors
Date: Mon, 28 May 2018 11:59:42 +0200
Message-Id: <20180528100328.228187488@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 16ccfff2897613007b5eda9e29d65303c6280026 ]

84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
has switched to do irq vectors spread among all possible CPUs, so
pass num_possible_cpus() as max vecotrs to be assigned.

For example, in a 8 cores system, 0~3 online, 4~8 offline/not present,
see 'lscpu':

        [ming@box]$lscpu
        Architecture:          x86_64
        CPU op-mode(s):        32-bit, 64-bit
        Byte Order:            Little Endian
        CPU(s):                4
        On-line CPU(s) list:   0-3
        Thread(s) per core:    1
        Core(s) per socket:    2
        Socket(s):             2
        NUMA node(s):          2
        ...
        NUMA node0 CPU(s):     0-3
        NUMA node1 CPU(s):
        ...

1) before this patch, follows the allocated vectors and their affinity:
	irq 47, cpu list 0,4
	irq 48, cpu list 1,6
	irq 49, cpu list 2,5
	irq 50, cpu list 3,7

2) after this patch, follows the allocated vectors and their affinity:
	irq 43, cpu list 0
	irq 44, cpu list 1
	irq 45, cpu list 2
	irq 46, cpu list 3
	irq 47, cpu list 4
	irq 48, cpu list 6
	irq 49, cpu list 5
	irq 50, cpu list 7

Cc: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1770,7 +1770,7 @@ static int nvme_setup_io_queues(struct n
 	int result, nr_io_queues;
 	unsigned long size;
 
-	nr_io_queues = num_present_cpus();
+	nr_io_queues = num_possible_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
