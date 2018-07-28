Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948E2C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 22:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F95320862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 22:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F95320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbeG1X1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:27:49 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:39950
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731330AbeG1X1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:27:48 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id jXEgfoPyRVktnjXEgf9FrL; Sat, 28 Jul 2018 14:58:50 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1fjXEg-0003bp-H3; Sat, 28 Jul 2018 14:58:50 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4/4] Drivers: hv: vmbus: add numa_node to sysfs
Date:   Sat, 28 Jul 2018 21:58:48 +0000
Message-Id: <20180728215848.13814-4-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180728215848.13814-1-kys@linuxonhyperv.com>
References: <20180728215630.13712-1-kys@linuxonhyperv.com>
 <20180728215848.13814-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfKmyjAN23z8Xx5yeTVnmWB6u/GLJ+CvcavpxuMCPoDhMib1e4KzELlxTg5fmcEfGvC7XFYrCgUXThHOMn4pYs8uv9f0T3H5s7JUR4noFlXRUHd+5af4Z
 x0w3OxDmlmow0HmSPlY92l5bPSjyx0/otVu+vacnFkzz9p9nFMjUpI+UurNBBrr0BrvkraxUBGlWzXB0xhOBHCu5KRMoypJevm3DxwzlBqOMsQOSWqOZhQBI
 UDURTf3WULeQzAiecH9loF9oBjlc33GCtIg7m1FGXkFFTuUEL6Sx9orYeYFNt7WrX90sRIEw+u2L9Alk+mh7SkakP2n+JoiT7LL55tLCrdFYAFBmLDUS6Ja8
 /cO3nuvKTOcJGEB/qg/vO0AA3p9VV0vOM8drlA0CxmZ0XpUmeMS1rRiZpUzzaRcp0xR+nSJKGtHlP/FhX1is/WGARpkY2Q1aMoyMSYJph3OLo5SxMsTdP9qU
 q0SGZkJfjDc2Q2nGsCQTamOUO6GGDVgrQ+804yYGu2jKLzFO4ycm05Fw5z6wjPIqLpdvB5D/i/s/UpzAtSPyqbIenJropy2mYBDS3Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>

Being able to find the numa_node for a device is useful for userspace
drivers (DPDK) and also for diagnosing performance issues.  This makes
vmbus similar to pci.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 Documentation/ABI/stable/sysfs-bus-vmbus |  7 +++++++
 drivers/hv/vmbus_drv.c                   | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 3eaffbb2d468..3fed8fdb873d 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -42,6 +42,13 @@ Contact:	K. Y. Srinivasan <kys@microsoft.com>
 Description:	The 16 bit vendor ID of the device
 Users:		tools/hv/lsvmbus and user level RDMA libraries
 
+What:		/sys/bus/vmbus/devices/<UUID>/numa_node
+Date:		Jul 2018
+KernelVersion:	4.19
+Contact:	Stephen Hemminger <sthemmin@microsoft.com>
+Description:	This NUMA node to which the VMBUS device is
+		attached, or -1 if the node is unknown.
+
 What:		/sys/bus/vmbus/devices/<UUID>/channels/<N>
 Date:		September. 2017
 KernelVersion:	4.14
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index db145e1a7049..b1b548a21f91 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -210,6 +210,20 @@ static ssize_t modalias_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(modalias);
 
+#ifdef CONFIG_NUMA
+static ssize_t numa_node_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct hv_device *hv_dev = device_to_hv_device(dev);
+
+	if (!hv_dev->channel)
+		return -ENODEV;
+
+	return sprintf(buf, "%d\n", hv_dev->channel->numa_node);
+}
+static DEVICE_ATTR_RO(numa_node);
+#endif
+
 static ssize_t server_monitor_pending_show(struct device *dev,
 					   struct device_attribute *dev_attr,
 					   char *buf)
@@ -492,6 +506,9 @@ static struct attribute *vmbus_dev_attrs[] = {
 	&dev_attr_class_id.attr,
 	&dev_attr_device_id.attr,
 	&dev_attr_modalias.attr,
+#ifdef CONFIG_NUMA
+	&dev_attr_numa_node.attr,
+#endif
 	&dev_attr_server_monitor_pending.attr,
 	&dev_attr_client_monitor_pending.attr,
 	&dev_attr_server_monitor_latency.attr,
-- 
2.17.1

