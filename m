Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeDGLZV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 07:25:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43552 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeDGLZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 07:25:19 -0400
From: Dongli Zhang <dongli.zhang@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, jgross@suse.com, ian.jackson@eu.citrix.com,
        wei.liu2@citrix.com, srinivas.eeda@oracle.com
Subject: [RFC 0/2] To introduce xenwatch multithreading (xen mtwatch)
Date: Sat,  7 Apr 2018 19:25:53 +0800
Message-Id: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8855 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804070121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to introduce "xenwatch multithreading" (or "multithreaded xenwatch",
abbreviated as 'mtwatch'). The implementation of xen mtwatch involves below
components:

* dom0 linux kernel
* xen toolstack

Here are what the RFC is going to discuss:

- what is the problem
- what is the objective
- what is the solution
- where is the challenge
- patch set


what is the problem
===================

xenwatch_thread is a single kernel thread processing the callback function for
subscribed xenwatch events successively. The xenwatch is stalled in 'D' state
if any of callback function is stalled and uninterruptible.

The domU create/destroy is failed if xenwatch is stalled in 'D' state as the
paravirtual driver init/uninit cannot complete. Usually, the only option is to
reboot dom0 server unless there is solution/workaround to move forward and
complete the stalled xenwatch event callback function. Below is the output of
'xl create' when xenwatch is stalled (the issue is reproduced on purpose by
hooking netif_receive_skb() to intercept an sk_buff sent out from vifX.Y on
dom0 with patch at
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


Three scenarios are discussed below to demonstrate the limitation of
single-threaded xenwatch:


scenario 1
----------

In this scenario, xenwatch is stalled at kthread_stop() as it is waiting for
xenvif_dealloc_kthread() to exit. However, unless all inflight packets (sent
out from xen-netback with SKBTX_DEV_ZEROCOPY set) are released successfully and
correctly (e.g., by bond/vlan/bridge/tap/NIC), xenvif_dealloc_kthread() would
never stop and exit. Below is the call stack of xenwatch thread:

---------------------------------------------
xenwatch call stack:
[<0>] kthread_stop
[<0>] xenvif_disconnect_data
[<0>] set_backend_state
[<0>] frontend_changed
[<0>] xenwatch_thread
[<0>] kthread
[<0>] ret_from_fork
---------------------------------------------

Similar issue has been reported and discussed in xen-devel in the past as shown
below.

https://lists.xenproject.org/archives/html/xen-devel/2016-06/msg00195.html


scenario 2
----------

In this scenario, xenwatch is stalled at kthread_stop() waiting for
xen_blkif_schedule() to complete all pending I/O requests. When there is issue
with loop device used by xen-blkback, xen_blkif_schedule() cannot complete and
exit. xenwatch is stalled unless xen_blkif_schedule() is able to finish all
pending I/O requests. Below is the call stack of xenwatch when it is stalled:

---------------------------------------------
xenwatch call stack:
[<0>] kthread_stop
[<0>] xen_blkif_disconnect
[<0>] xen_blkbk_remove
[<0>] xenbus_dev_remove
[<0>] __device_release_driver
[<0>] device_release_driver
[<0>] bus_remove_device
[<0>] device_del
[<0>] device_unregister
[<0>] frontend_changed
[<0>] xenbus_otherend_changed
[<0>] frontend_changed
[<0>] xenwatch_thread
[<0>] kthread
[<0>] ret_from_fork
---------------------------------------------


scenario 3
----------

In this scenario, xenwatch is stalled at gnttab_unmap_refs_sync() when some
persistent pages (of xen-blkback) are still mapped and used by dom0 filesystem
or block layer. When there is issue with filesystem or block layer, the
persistent pages assigned to the submitted bio is not released successfully or
correctly so that xenwatch is stalled forever. Below is the call stack of
stalled xenwatch:

---------------------------------------------
xenwatch call stack:
[<0>] gnttab_unmap_refs_sync
[<0>] free_persistent_gnts
[<0>] xen_blkbk_free_caches
[<0>] xen_blkif_disconnect
[<0>] xen_blkbk_remove
[<0>] xenbus_dev_remove
[<0>] __device_release_driver
[<0>] device_release_driver
[<0>] bus_remove_device
[<0>] device_del
[<0>] device_unregister
[<0>] frontend_changed
[<0>] xenbus_otherend_changed
[<0>] frontend_changed
[<0>] xenwatch_thread
[<0>] kthread
[<0>] ret_from_fork
---------------------------------------------

>From above scenarios, we may conclude that the stability of xenwatch heavily
relies on xenwatch callback function, that is, the stability of other dom0
kernel components such as networking, NIC, filesystem or block. When xenwatch
is stalled, people would always blame xen although the root cause is on xen
side.


what is the objective
=====================

The objective of this RFC is to guarantee xenwatch is always able to respond to
coming xenwatch event, even any of callback function is already stalled, to
avoid the immediate dom0 reboot. We should guarantee that only the per-domU
xenwatch thread is stalled when the event callback function hangs.

The xenwatch stall issue on domU is not as significant as on dom0, which is the
privileged management domain responsible for domain create/destroy, as reboot
domU is not a severe issue. However, It is always necessary for the
administrator to schedule a downtime to reboot dom0. Therefore, we only cover
the dom0 xenwatch stall issue in this RFC.


what is the solution
====================

The general idea of the solution is to create a kernel thread for every domU in
addition to the default xenwatch thread.

For each coming xenwatch event, xenwatch_thread() first calculates the domid
that this event belong to. The event is forwarded to per-domU thread according
to the result of domid calculation. The xenwatch event is processed by per-domU
watch thread if the domid is not 0. Otherwise, it is processed by default
xenwatch_thread().

As this issue is only significant to dom0, the solution would only cover dom0.
The domU (including driver domain) is not considered in this RFC.

A kernel parameter 'xen_mtwatch' is introduced to control whether the featue is
enabled or not. The feature is disabled by default if 'xen_mtwatch' is not set
in grub.


where is the challenge
======================

There are two challenges during the design of xen mtwatch:

1. The calculation of domid given the xenwatch event path.

2. When to create/destroy per-domU kthread.

About domid calculation, instead of having a single intelligent function to
calculate the domid for all event path, a new callback function .get_domid() is
introduced as a member of 'struct xenbus_watch' as shown below:

/* Register callback to watch this node. */
 struct xenbus_watch
 {
         struct list_head list;

         /* Path being watched. */
         const char *node;

         /* Callback (executed in a process context with no locks held). */
         void (*callback)(struct xenbus_watch *,
                          const char *path, const char *token);
+
+        /* Callback to help calculate the domid the path belongs to */
+        domid_t (*get_domid)(struct xenbus_watch *watch,
+                             const char *path, const char *token);
+
+        /* Get the owner's domid if the watch is for a specific domain */
+        domid_t (*get_owner)(struct xenbus_watch *watch);
 };

Below is a sample implementation of .get_domid() method for xenwatch at
xenstore entry 'state'

+static domid_t otherend_get_domid(struct xenbus_watch *watch,
+				  const char *path,
+				  const char *token)
+{
+	struct xenbus_device *xendev =
+		container_of(watch, struct xenbus_device, otherend_watch);
+
+	return xendev->otherend_id;
+}

 static int watch_otherend(struct xenbus_device *dev)
 {
        struct xen_bus_type *bus =
                container_of(dev->dev.bus, struct xen_bus_type, bus);
 
+	dev->otherend_watch.get_domid = otherend_get_domid;

Therefore, the xenwatch subscriber is expected to implement the callback
function to calculate the domid. The xenwatch event is processed by default
xenwatch thread if the .get_domid() is not implemented.


About per-domU xenwatch thread create/destroy, a new type of xenstore node is
introduced: '/local/domain/0/mtwatch/<domid>'.

Suppose the new domid id 7. During the domU (domid=7) creation, the xen
toolstack writes '/local/domain/0/mtwatch/7' to xenstore before the insertion
of '/local/domain/7'. When the domid=7 is destroyed, the last xenstore
operation by xen toolstack is to remove '/local/domain/0/mtwatch/7'.

The dom0 kernel subscribes a watch at node '/local/domain/0/mtwatch'.  Kernel
thread [xen-mtwatch-7] is created when '/local/domain/0/mtwatch/7' is inserted,
while this kernel thread is destroyed when the corresponding xenstore node is
removed.


patch set
=========

There is one linux patch and one xen patch following this RFC to help
understand the idea:

[RFC PATCH linux 1/2] xenbus: introduce xenwatch multithreading to dom0 linux kernel
[RFC PATCH xen 2/2] libxl: introduce xenwatch multithreading to xen toolstack

Below patch can help reproduce the issue on purpose:

https://github.com/finallyjustice/patchset/blob/master/xenwatch-stall-by-vif.patch

Please let me know your input on this RFC. Thank you very much!

Dongli Zhang
