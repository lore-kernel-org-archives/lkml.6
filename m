Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80FAC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA4327387
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="tMiTIbor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA4327387
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966050AbeF1MsV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:48:21 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:19832 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966044AbeF1MsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1530190098; x=1561726098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=3LKZ5vsfMK9CTPi4WQ5DWJFT9uksAdxw/C700phFkGQ=;
  b=tMiTIborvH43ApHlfoJq7ppATL6wfTdPuI4MLY24D5+M/HYP+2PJxkfU
   7Wb7hRY/JzZJlrGw4Wo+YzoMb5DUwtwnaKIUhHvi/HB4CeQyzWvrMwVGU
   auOhlLD1pPrSEyXu3lyFPS4y2wdXYwEDdTWOw/Ypw+hnqqUhq7ITKd68t
   A=;
X-IronPort-AV: E=Sophos;i="5.51,283,1526342400"; 
   d="scan'208";a="740115893"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jun 2018 12:48:17 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5SCl2Nt075338
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 28 Jun 2018 12:47:02 GMT
Received: from EX13D02EUB002.ant.amazon.com (10.43.166.170) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:52 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D02EUB002.ant.amazon.com (10.43.166.170) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:51 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.28.85.80) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 28 Jun 2018 12:46:50 +0000
From:   Norbert Manthey <nmanthey@amazon.de>
To:     Norbert Manthey <nmanthey@amazon.de>,
        <linux-kernel@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>
Subject: [less-CONFIG_NET v2 6/8] bpf: avoid duplicate definitions
Date:   Thu, 28 Jun 2018 14:45:34 +0200
Message-ID: <1530189936-25780-7-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
References: <ef0fe0ef-3620-3628-2a7e-c8b73e466a21@amazon.de>
 <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the aim of making CONFIG_SECCOMP_FILTER independent of CONFIG_NET,
some bpf functions are not required to provide net functionality, as
already implemented in the header include/linux/bpf.h. However, the source
files assumed to be only included if CONFIG_NET is activated.

To be able to include the source files while CONFIG_NET is disabled, make
sure the functions defined in the header include/linux/bpf.h are not
included in the source file.

To reduce the amount of #ifdef CONFIG_NET guards, the position of the
functions __bpf_map_offload_destroy and bpf_map_offload_map_alloc has been
swapped.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
---
 kernel/bpf/offload.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index ac747d5..7042dbe 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -32,6 +32,7 @@ static DECLARE_RWSEM(bpf_devs_lock);
 static LIST_HEAD(bpf_prog_offload_devs);
 static LIST_HEAD(bpf_map_offload_devs);
 
+#ifdef CONFIG_NET
 static int bpf_dev_offload_check(struct net_device *netdev)
 {
 	if (!netdev)
@@ -84,6 +85,7 @@ int bpf_prog_offload_init(struct bpf_prog *prog, union bpf_attr *attr)
 	kfree(offload);
 	return err;
 }
+#endif // CONFIG_NET
 
 static int __bpf_offload_ndo(struct bpf_prog *prog, enum bpf_netdev_command cmd,
 			     struct netdev_bpf *data)
@@ -291,6 +293,16 @@ static int bpf_map_offload_ndo(struct bpf_offloaded_map *offmap,
 	return netdev->netdev_ops->ndo_bpf(netdev, &data);
 }
 
+static void __bpf_map_offload_destroy(struct bpf_offloaded_map *offmap)
+{
+	WARN_ON(bpf_map_offload_ndo(offmap, BPF_OFFLOAD_MAP_FREE));
+	/* Make sure BPF_MAP_GET_NEXT_ID can't find this dead map */
+	bpf_map_free_id(&offmap->map, true);
+	list_del_init(&offmap->offloads);
+	offmap->netdev = NULL;
+}
+
+#ifdef CONFIG_NET
 struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -333,15 +345,6 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
-static void __bpf_map_offload_destroy(struct bpf_offloaded_map *offmap)
-{
-	WARN_ON(bpf_map_offload_ndo(offmap, BPF_OFFLOAD_MAP_FREE));
-	/* Make sure BPF_MAP_GET_NEXT_ID can't find this dead map */
-	bpf_map_free_id(&offmap->map, true);
-	list_del_init(&offmap->offloads);
-	offmap->netdev = NULL;
-}
-
 void bpf_map_offload_map_free(struct bpf_map *map)
 {
 	struct bpf_offloaded_map *offmap = map_to_offmap(map);
@@ -355,6 +358,7 @@ void bpf_map_offload_map_free(struct bpf_map *map)
 
 	kfree(offmap);
 }
+#endif // CONFIG_NET
 
 int bpf_map_offload_lookup_elem(struct bpf_map *map, void *key, void *value)
 {
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

