Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932300AbeDZSTs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:19:48 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:52232 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755998AbeDZSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:19:41 -0400
X-Google-Smtp-Source: AB8JxZo+n/2W7OeOJreHmeakPpk4VBm6r/JVZOGWy1OhV8AF4C7Qb4oS64lR/xRgu7lCmGM0Ch0emM75z5h9
MIME-Version: 1.0
Date: Thu, 26 Apr 2018 11:19:29 -0700
Message-Id: <20180426181935.32977-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH 0/6] IB: make INFINIBAND_ADDR_TRANS configurable
From: Greg Thelen <gthelen@google.com>
To: Bart.VanAssche@wdc.com, hch@lst.de, dledford@redhat.com, jgg@ziepe.ca,
        axboe@fb.com, keith.busch@intel.com, sagi@grimberg.me,
        sfrench@samba.org, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, gthelen@google.com
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allows for CONFIG_INFINIBAND without
CONFIG_INFINIBAND_ADDR_TRANS (aka RDMA communication manager).
Fuzzing has been finding fair number of CM bugs.
So provide an option to disable it in systems which don't need it.

Changes since last posting (https://lkml.org/lkml/2018/4/25/1266):
- added ("ib_srp: depend on INFINIBAND_ADDR_TRANS") patch

This series passed the 0-day builder.

I perfomed manual static analysis of this series based on next-20180424,
looking for dependencies.

$ git grep -w CONFIG_INFINIBAND_ADDR_TRANS
drivers/infiniband/core/Makefile:infiniband-$(CONFIG_INFINIBAND_ADDR_TRANS)     := rdma_cm.o
drivers/infiniband/core/Makefile:user_access-$(CONFIG_INFINIBAND_ADDR_TRANS)    := rdma_ucm.o

$ grep -w -e rdma_cm -e rdma_ucm drivers/infiniband/core/Makefile
infiniband-$(CONFIG_INFINIBAND_ADDR_TRANS)      := rdma_cm.o
user_access-$(CONFIG_INFINIBAND_ADDR_TRANS)     := rdma_ucm.o
rdma_cm-y :=                    cma.o
rdma_cm-$(CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS) += cma_configfs.o
rdma_ucm-y :=                   ucma.o

$ grep EXPORT drivers/infiniband/core/{cma,ucma}.c
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_event_msg);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_reject_msg);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_is_consumer_reject);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_consumer_reject_data);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(__rdma_create_id);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_create_qp);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_destroy_qp);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_init_qp_attr);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_destroy_id);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_get_service_id);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_read_gids);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_set_service_type);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_set_ib_path);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_resolve_route);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_resolve_addr);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_set_reuseaddr);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_set_afonly);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_listen);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_bind_addr);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_connect);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(__rdma_accept);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_notify);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_reject);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_disconnect);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_join_multicast);
drivers/infiniband/core/cma.c:EXPORT_SYMBOL(rdma_leave_multicast);

$ git grep -lw \
  -e __rdma_accept \
  -e __rdma_create_id \
  -e rdma_bind_addr \
  -e rdma_connect \
  -e rdma_consumer_reject_data \
  -e rdma_create_qp \
  -e rdma_destroy_id \
  -e rdma_destroy_qp \
  -e rdma_disconnect \
  -e rdma_event_msg \
  -e rdma_get_service_id \
  -e rdma_init_qp_attr \
  -e rdma_is_consumer_reject \
  -e rdma_join_multicast \
  -e rdma_leave_multicast \
  -e rdma_listen \
  -e rdma_notify \
  -e rdma_read_gids \
  -e rdma_reject \
  -e rdma_reject_msg \
  -e rdma_resolve_addr \
  -e rdma_resolve_route \
  -e rdma_set_afonly \
  -e rdma_set_ib_path \
  -e rdma_set_reuseaddr \
  -e rdma_set_service_type
drivers/infiniband/core/cma.c
drivers/infiniband/core/ucma.c
drivers/infiniband/hw/qedr/verbs.c
drivers/infiniband/ulp/iser/iser_verbs.c
drivers/infiniband/ulp/isert/ib_isert.c
drivers/infiniband/ulp/srp/ib_srp.c
drivers/infiniband/ulp/srpt/ib_srpt.c
drivers/net/ethernet/qlogic/qed/qed_rdma.c
drivers/nvme/host/rdma.c
drivers/nvme/target/rdma.c
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
fs/cifs/smbdirect.c
include/linux/qed/qed_rdma_if.h
include/rdma/rdma_cm.h
include/rdma/rdma_cm_ib.h
net/9p/trans_rdma.c
net/rds/ib.c
net/rds/ib_cm.c
net/rds/rdma_transport.c
net/sunrpc/xprtrdma/svc_rdma_transport.c
net/sunrpc/xprtrdma/transport.c
net/sunrpc/xprtrdma/verbs.c

# analysis of each file:
drivers/infiniband/hw/qedr/verbs.c
drivers/net/ethernet/qlogic/qed/qed_rdma.c
include/linux/qed/qed_rdma_if.h
  - not a direct function call
include/rdma/rdma_cm.h
include/rdma/rdma_cm_ib.h
  - just prototypes
drivers/infiniband/core/cma.c
drivers/infiniband/core/ucma.c
  - depends on INFINIBAND_ADDR_TRANS
drivers/infiniband/ulp/iser/iser_verbs.c
  - depends on INFINIBAND_ISER => INFINIBAND_ADDR_TRANS
drivers/infiniband/ulp/isert/ib_isert.c
  - depends on INFINIBAND_ISERT => INFINIBAND_ADDR_TRANS
drivers/infiniband/ulp/srp/ib_srp.c
  - depends on INFINIBAND_SRP => INFINIBAND_ADDR_TRANS
    per this series' "ib_srp: depend on INFINIBAND_ADDR_TRANS"
drivers/infiniband/ulp/srpt/ib_srpt.c
  - depends on INFINIBAND_SRPT => INFINIBAND_ADDR_TRANS
    per this series' "ib_srpt: depend on INFINIBAND_ADDR_TRANS"
drivers/nvme/host/rdma.c
  - depends on NVME_RDMA => INFINIBAND_ADDR_TRANS
    per this series' "nvme: depend on INFINIBAND_ADDR_TRANS"
drivers/nvme/target/rdma.c
  - depends on NVME_TARGET_RDMA => INFINIBAND_ADDR_TRANS
    per this series' "nvmet-rdma: depend on INFINIBAND_ADDR_TRANS"
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h
drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
  - depends on LNET_XPRT_IB => INFINIBAND_ADDR_TRANS
fs/cifs/smbdirect.c
  - depends on CIFS_SMB_DIRECT => INFINIBAND_ADDR_TRANS
    per this series' "cifs: smbd: depend on INFINIBAND_ADDR_TRANS"
net/9p/trans_rdma.c
  - depends on NET_9P_RDMA => INFINIBAND_ADDR_TRANS
net/rds/ib.c
net/rds/ib_cm.c
net/rds/rdma_transport.c
  - depends on RDS_RDMA => INFINIBAND_ADDR_TRANS
net/sunrpc/xprtrdma/svc_rdma_transport.c
net/sunrpc/xprtrdma/transport.c
net/sunrpc/xprtrdma/verbs.c
  - depends on SUNRPC_XPRT_RDMA => INFINIBAND_ADDR_TRANS

Greg Thelen (6):
  nvme: depend on INFINIBAND_ADDR_TRANS
  nvmet-rdma: depend on INFINIBAND_ADDR_TRANS
  ib_srpt: depend on INFINIBAND_ADDR_TRANS
  cifs: smbd: depend on INFINIBAND_ADDR_TRANS
  ib_srp: depend on INFINIBAND_ADDR_TRANS
  IB: make INFINIBAND_ADDR_TRANS configurable

 drivers/infiniband/Kconfig          | 5 ++++-
 drivers/infiniband/ulp/srp/Kconfig  | 2 +-
 drivers/infiniband/ulp/srpt/Kconfig | 2 +-
 drivers/nvme/host/Kconfig           | 2 +-
 drivers/nvme/target/Kconfig         | 2 +-
 fs/cifs/Kconfig                     | 2 +-
 6 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.17.0.484.g0c8726318c-goog
