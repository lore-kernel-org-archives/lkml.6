Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6811113F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1456E20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1456E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbeG3O1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:27:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:48968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731700AbeG3O1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:27:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7CCAAF54;
        Mon, 30 Jul 2018 12:52:57 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 6C09AA0BE8; Mon, 30 Jul 2018 14:52:57 +0200 (CEST)
Message-Id: <b0a6a8fd66eb610a30f5f4af7143ffa3a27fcee3.1532953989.git.mkubecek@suse.cz>
In-Reply-To: <cover.1532953989.git.mkubecek@suse.cz>
References: <cover.1532953989.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v2 03/17] ethtool: introduce ethtool netlink
 interface
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Mon, 30 Jul 2018 14:52:57 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No function implemented yet, only genetlink and module infrastructure.
Register/unregister genetlink family "ethtool" and allow the module to be
autoloaded by genetlink code (if built as a module, distributions would
probably prefer "y").

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 Documentation/networking/ethtool-netlink.txt | 168 +++++++++++++++++++
 include/linux/ethtool_netlink.h              |   9 +
 include/uapi/linux/ethtool_netlink.h         |  19 +++
 net/Kconfig                                  |   7 +
 net/ethtool/Makefile                         |   6 +-
 net/ethtool/netlink.c                        |  41 +++++
 net/ethtool/netlink.h                        |  12 ++
 7 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/networking/ethtool-netlink.txt
 create mode 100644 include/linux/ethtool_netlink.h
 create mode 100644 include/uapi/linux/ethtool_netlink.h
 create mode 100644 net/ethtool/netlink.c
 create mode 100644 net/ethtool/netlink.h

diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
new file mode 100644
index 000000000000..120376e0f91b
--- /dev/null
+++ b/Documentation/networking/ethtool-netlink.txt
@@ -0,0 +1,168 @@
+                        Netlink interface for ethtool
+                        =============================
+
+
+Basic information
+-----------------
+
+Netlink interface for ethtool uses generic netlink family "ethtool" (userspace
+application should use macros ETHTOOL_GENL_NAME and ETHTOOL_GENL_VERSION
+defined in <linux/ethtool_netlink.h> uapi header). This family does not use
+a specific header, all information in requests and replies is passed using
+netlink attributes.
+
+In requests, device can be identified by ifindex or by name; if both are used,
+they must match. In replies, kernel fills both. The meaning of flags,
+info_mask and index fields depends on request type.
+
+The ethtool netlink interface uses extended ACK for error and warning
+reporting, userspace application developers are encouraged to make these
+messages available to user in a suitable way.
+
+Requests can be divided into three categories: "get" (retrieving information),
+"set" (setting parameters) and "action" (invoking an action).
+
+All "set" and "action" type requests require admin privileges (CAP_NET_ADMIN
+in the namespace). Most "get" type request are allowed for anyone but there
+are exceptions (where the response contains sensitive information). In some
+cases, the request as such is allowed for anyone but unprivileged users have
+attributes with sensitive information (e.g. wake-on-lan password) omitted.
+
+
+Conventions
+-----------
+
+Attributes which represent a boolean value usually use u8 type so that we can
+distinguish three states: "on", "off" and "not present" (meaning the
+information is not available in "get" requests or value is not to be changed
+in "set" requests). For these attributes, the "true" value should be passed as
+number 1 but any non-zero value should be understood as "true" by recipient.
+
+Some request types allow passing an attribute named ETHA_*_INFOMASK with
+a bitmask telling kernel that we are only interested in some parts of the
+information. If info mask is omitted, all available information is returned.
+Meaning of info mask bits depends on request type and is listed below.
+
+
+Device identification
+---------------------
+
+When appropriate, network device is identified by a nested attribute named
+ETHA_*_DEV. This attribute can contain
+
+    ETHA_DEV_INDEX	(u32)		device ifindex
+    ETHA_DEV_NAME	(string)	device name
+
+In device related requests, one of these is sufficient; if both are used, they
+must match (i.e. identify the same device). In device related replies both are
+provided by kernel. In dump requests, device is not specified and kernel
+replies with one message per network device (only those for which the request
+is supported).
+
+List of message types
+---------------------
+
+All constants use ETHNL_CMD_ prefix, usually followed by "GET", "SET" or "ACT"
+to indicate the type.
+
+Messages of type "get" are used by userspace to request information and
+usually do not contain any attributes (that may be added later for dump
+filtering). Kernel response is in the form of corresponding "set" message;
+the same message can be also used to set (some of) the parameters, except for
+messages marked as "response only" in the table above. "Get" messages with
+NLM_F_DUMP flags and no device identification dump the information for all
+devices supporting the request.
+
+Later sections describe the format and semantics of these request messages.
+
+
+Request translation
+-------------------
+
+The following table maps iosctl commands to netlink commands providing their
+functionality. Entries with "n/a" in right column are commands which do not
+have their netlink replacement yet.
+
+ioctl command			netlink command
+---------------------------------------------------------------------
+ETHTOOL_GSET			n/a
+ETHTOOL_SSET			n/a
+ETHTOOL_GDRVINFO		n/a
+ETHTOOL_GREGS			n/a
+ETHTOOL_GWOL			n/a
+ETHTOOL_SWOL			n/a
+ETHTOOL_GMSGLVL			n/a
+ETHTOOL_SMSGLVL			n/a
+ETHTOOL_NWAY_RST		n/a
+ETHTOOL_GLINK			n/a
+ETHTOOL_GEEPROM			n/a
+ETHTOOL_SEEPROM			n/a
+ETHTOOL_GCOALESCE		n/a
+ETHTOOL_SCOALESCE		n/a
+ETHTOOL_GRINGPARAM		n/a
+ETHTOOL_SRINGPARAM		n/a
+ETHTOOL_GPAUSEPARAM		n/a
+ETHTOOL_SPAUSEPARAM		n/a
+ETHTOOL_GRXCSUM			n/a
+ETHTOOL_SRXCSUM			n/a
+ETHTOOL_GTXCSUM			n/a
+ETHTOOL_STXCSUM			n/a
+ETHTOOL_GSG			n/a
+ETHTOOL_SSG			n/a
+ETHTOOL_TEST			n/a
+ETHTOOL_GSTRINGS		n/a
+ETHTOOL_PHYS_ID			n/a
+ETHTOOL_GSTATS			n/a
+ETHTOOL_GTSO			n/a
+ETHTOOL_STSO			n/a
+ETHTOOL_GPERMADDR		n/a
+ETHTOOL_GUFO			n/a
+ETHTOOL_SUFO			n/a
+ETHTOOL_GGSO			n/a
+ETHTOOL_SGSO			n/a
+ETHTOOL_GFLAGS			n/a
+ETHTOOL_SFLAGS			n/a
+ETHTOOL_GPFLAGS			n/a
+ETHTOOL_SPFLAGS			n/a
+ETHTOOL_GRXFH			n/a
+ETHTOOL_SRXFH			n/a
+ETHTOOL_GGRO			n/a
+ETHTOOL_SGRO			n/a
+ETHTOOL_GRXRINGS		n/a
+ETHTOOL_GRXCLSRLCNT		n/a
+ETHTOOL_GRXCLSRULE		n/a
+ETHTOOL_GRXCLSRLALL		n/a
+ETHTOOL_SRXCLSRLDEL		n/a
+ETHTOOL_SRXCLSRLINS		n/a
+ETHTOOL_FLASHDEV		n/a
+ETHTOOL_RESET			n/a
+ETHTOOL_SRXNTUPLE		n/a
+ETHTOOL_GRXNTUPLE		n/a
+ETHTOOL_GSSET_INFO		n/a
+ETHTOOL_GRXFHINDIR		n/a
+ETHTOOL_SRXFHINDIR		n/a
+ETHTOOL_GFEATURES		n/a
+ETHTOOL_SFEATURES		n/a
+ETHTOOL_GCHANNELS		n/a
+ETHTOOL_SCHANNELS		n/a
+ETHTOOL_SET_DUMP		n/a
+ETHTOOL_GET_DUMP_FLAG		n/a
+ETHTOOL_GET_DUMP_DATA		n/a
+ETHTOOL_GET_TS_INFO		n/a
+ETHTOOL_GMODULEINFO		n/a
+ETHTOOL_GMODULEEEPROM		n/a
+ETHTOOL_GEEE			n/a
+ETHTOOL_SEEE			n/a
+ETHTOOL_GRSSH			n/a
+ETHTOOL_SRSSH			n/a
+ETHTOOL_GTUNABLE		n/a
+ETHTOOL_STUNABLE		n/a
+ETHTOOL_GPHYSTATS		n/a
+ETHTOOL_PERQUEUE		n/a
+ETHTOOL_GLINKSETTINGS		n/a
+ETHTOOL_SLINKSETTINGS		n/a
+ETHTOOL_PHY_GTUNABLE		n/a
+ETHTOOL_PHY_STUNABLE		n/a
+ETHTOOL_GFECPARAM		n/a
+ETHTOOL_SFECPARAM		n/a
+
diff --git a/include/linux/ethtool_netlink.h b/include/linux/ethtool_netlink.h
new file mode 100644
index 000000000000..0412adb4f42f
--- /dev/null
+++ b/include/linux/ethtool_netlink.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _LINUX_ETHTOOL_NETLINK_H_
+#define _LINUX_ETHTOOL_NETLINK_H_
+
+#include <uapi/linux/ethtool_netlink.h>
+#include <linux/ethtool.h>
+
+#endif /* _LINUX_ETHTOOL_NETLINK_H_ */
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
new file mode 100644
index 000000000000..3c0c5c70692b
--- /dev/null
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_LINUX_ETHTOOL_NETLINK_H_
+#define _UAPI_LINUX_ETHTOOL_NETLINK_H_
+
+#include <linux/ethtool.h>
+
+enum {
+	ETHNL_CMD_NOOP,
+
+	__ETHNL_CMD_MAX,
+	ETHNL_CMD_MAX = (__ETHNL_CMD_MAX - 1)
+};
+
+/* generic netlink info */
+#define ETHTOOL_GENL_NAME "ethtool"
+#define ETHTOOL_GENL_VERSION 1
+
+#endif /* _UAPI_LINUX_ETHTOOL_NETLINK_H_ */
diff --git a/net/Kconfig b/net/Kconfig
index 228dfa382eec..12e763449525 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -445,6 +445,13 @@ config FAILOVER
 	  migration of VMs with direct attached VFs by failing over to the
 	  paravirtual datapath when the VF is unplugged.
 
+config ETHTOOL_NETLINK
+	tristate "Netlink interface for ethtool"
+	default m
+	help
+	   New netlink based interface for ethtool which is going to obsolete
+	   the old ioctl based one once it provides all features.
+
 endif   # if NET
 
 # Used by archs to tell that they support BPF JIT compiler plus which flavour.
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 3ebfab2bca66..f30e0da88be5 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -1,3 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y		+= ioctl.o
+obj-y				+= ioctl.o
+
+obj-$(CONFIG_ETHTOOL_NETLINK)	+= ethtool_nl.o
+
+ethtool_nl-y	:= netlink.o
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
new file mode 100644
index 000000000000..1c6efb9b2eae
--- /dev/null
+++ b/net/ethtool/netlink.c
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#include <linux/module.h>
+#include <linux/ethtool_netlink.h>
+#include "netlink.h"
+
+/* genetlink setup */
+
+static const struct genl_ops ethtool_genl_ops[] = {
+};
+
+struct genl_family ethtool_genl_family = {
+	.hdrsize	= 0,
+	.name		= ETHTOOL_GENL_NAME,
+	.version	= ETHTOOL_GENL_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.ops		= ethtool_genl_ops,
+	.n_ops		= ARRAY_SIZE(ethtool_genl_ops),
+};
+
+/* module setup */
+
+static int __init ethtool_nl_init(void)
+{
+	return genl_register_family(&ethtool_genl_family);
+}
+
+static void __exit ethtool_nl_exit(void)
+{
+	genl_unregister_family(&ethtool_genl_family);
+}
+
+module_init(ethtool_nl_init);
+module_exit(ethtool_nl_exit);
+
+/* alias for module autoload */
+MODULE_ALIAS_GENL_FAMILY(ETHTOOL_GENL_NAME);
+MODULE_AUTHOR("Michal Kubecek <mkubecek@suse.cz>");
+MODULE_DESCRIPTION("Netlink interface for ethtool");
+MODULE_LICENSE("GPL");
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
new file mode 100644
index 000000000000..63063b582ca2
--- /dev/null
+++ b/net/ethtool/netlink.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _NET_ETHTOOL_NETLINK_H
+#define _NET_ETHTOOL_NETLINK_H
+
+#include <linux/ethtool_netlink.h>
+#include <linux/netdevice.h>
+#include <net/genetlink.h>
+
+extern struct genl_family ethtool_genl_family;
+
+#endif /* _NET_ETHTOOL_NETLINK_H */
-- 
2.18.0

