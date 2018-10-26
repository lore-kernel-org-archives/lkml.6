Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A531C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 02:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEED02083E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 02:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="nmyBncH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEED02083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeJZKhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 06:37:31 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48134 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeJZKhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 06:37:31 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 030A58781F;
        Fri, 26 Oct 2018 15:02:26 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1540519346;
        bh=dR7Hjyj/IhUWyAunytb9VrooialhH/lzpsqbVqb15gM=;
        h=From:To:Cc:Subject:Date;
        b=nmyBncH5Bco4aPByp8wBiFm/xH/yG4fl1pNpuAjEDxZAeIgtnkxTAoWJPOzzTXHBT
         U3cfpbLcAoRI4440Nmin/YKTA4VcsThGNWBdfwMJuNK1lvnemtWydXudGNZhCh6C+j
         g54XcI7yCJGua+EPakrcFXjJtVaPUFSn0vCV+l9gt6HVcXllM7XzsF7ZyFmSPih+Gt
         KS+LOv9NKhWaclAt7Xu/GWb3r9Qx+H5bsfCsCvjX0Et0oEUL+FzQWUu707dv6TC8cV
         ysMJ2cwc06D6KQ45Lnx3Fo4Q3UZbrPrl51Oa60HmrK/LtD6fSfA9nOZdcXC9rBXlTd
         2/W0Mkv4cMxdw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bd275b20000>; Fri, 26 Oct 2018 15:02:26 +1300
Received: from brodieg-dl.ws.atlnz.lc (brodieg-dl.ws.atlnz.lc [10.33.22.16])
        by smtp (Postfix) with ESMTP id 86A6613ECD5;
        Fri, 26 Oct 2018 15:02:30 +1300 (NZDT)
Received: by brodieg-dl.ws.atlnz.lc (Postfix, from userid 1718)
        id B8962500471; Fri, 26 Oct 2018 15:02:25 +1300 (NZDT)
From:   Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.packham@alliedtelesis.co.nz,
        luuk.paulussen@alliedtelesis.co.nz,
        Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
Subject: [PATCH 1/1] ipmr: Make cache queue length configurable
Date:   Fri, 26 Oct 2018 15:02:19 +1300
Message-Id: <20181026020219.22401-2-brodie.greenfield@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to be able to keep more spaces available in our queue for
processing incoming multicast traffic (adding (S,G) entries) - this lets
us learn more groups faster, rather than dropping them at this stage.

Signed-off-by: Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
---
=20Documentation/networking/ip-sysctl.txt | 7 +++++++
=20include/net/netns/ipv4.h               | 1 +
=20include/uapi/linux/sysctl.h            | 1 +
=20kernel/sysctl_binary.c                 | 1 +
=20net/ipv4/af_inet.c                     | 2 ++
=20net/ipv4/ipmr.c                        | 4 +++-
=20net/ipv4/sysctl_net_ipv4.c             | 7 +++++++
=207 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/netwo=
rking/ip-sysctl.txt
index 960de8fe3f40..dfc70ef6c42b 100644
--- a/Documentation/networking/ip-sysctl.txt
+++ b/Documentation/networking/ip-sysctl.txt
@@ -864,6 +864,13 @@ ip_local_reserved_ports - list of comma separated ra=
nges
=20
=20	Default: Empty
=20
+ip_mr_cache_queue_length - INTEGER
+	Limit the number of multicast packets we can have in the queue to be
+	resolved.
+	Bear in mind that this causes an O(n) traversal of the same size when
+	the queue is full. This should be considered if increasing.
+	Default: 10
+
=20ip_unprivileged_port_start - INTEGER
=20	This is a per-namespace sysctl.  It defines the first
=20	unprivileged port in the network namespace.  Privileged ports
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index e47503b4e4d1..1ca5cabe2d3b 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -184,6 +184,7 @@ struct netns_ipv4 {
=20	int sysctl_igmp_max_msf;
=20	int sysctl_igmp_llm_reports;
=20	int sysctl_igmp_qrv;
+	int sysctl_ip_mr_cache_queue_length;
=20
=20	struct ping_group_range ping_group_range;
=20
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index d71013fffaf6..32e32d4904cd 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -425,6 +425,7 @@ enum
=20	NET_TCP_ALLOWED_CONG_CONTROL=3D123,
=20	NET_TCP_MAX_SSTHRESH=3D124,
=20	NET_TCP_FRTO_RESPONSE=3D125,
+	NET_IPV4_IP_MR_CACHE_QUEUE_LENGTH=3D126,
=20};
=20
=20enum {
diff --git a/kernel/sysctl_binary.c b/kernel/sysctl_binary.c
index 07148b497451..8db94e8d97ed 100644
--- a/kernel/sysctl_binary.c
+++ b/kernel/sysctl_binary.c
@@ -367,6 +367,7 @@ static const struct bin_table bin_net_ipv4_table[] =3D=
=20{
=20	{ CTL_INT,	NET_IPV4_LOCAL_PORT_RANGE,		"ip_local_port_range" },
=20	{ CTL_INT,	NET_IPV4_IGMP_MAX_MEMBERSHIPS,		"igmp_max_memberships" },
=20	{ CTL_INT,	NET_IPV4_IGMP_MAX_MSF,			"igmp_max_msf" },
+	{ CTL_INT,	NET_IPV4_IP_MR_CACHE_QUEUE_LENGTH,	"ip_mr_cache_queue_length=
" },
=20	{ CTL_INT,	NET_IPV4_INET_PEER_THRESHOLD,		"inet_peer_threshold" },
=20	{ CTL_INT,	NET_IPV4_INET_PEER_MINTTL,		"inet_peer_minttl" },
=20	{ CTL_INT,	NET_IPV4_INET_PEER_MAXTTL,		"inet_peer_maxttl" },
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 1fbe2f815474..4b78d12aca36 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1818,6 +1818,8 @@ static __net_init int inet_init_net(struct net *net=
)
=20	net->ipv4.sysctl_igmp_llm_reports =3D 1;
=20	net->ipv4.sysctl_igmp_qrv =3D 2;
=20
+	/* ipmr unresolved queue length max */
+	net->ipv4.sysctl_ip_mr_cache_queue_length =3D 10;
=20	return 0;
=20}
=20
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 5660adcf7a04..2864f80e2f2a 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1128,6 +1128,7 @@ static int ipmr_cache_unresolved(struct mr_table *m=
rt, vifi_t vifi,
=20	struct mfc_cache *c;
=20	bool found =3D false;
=20	int err;
+	struct net *net =3D dev_net(dev);
=20
=20	spin_lock_bh(&mfc_unres_lock);
=20	list_for_each_entry(c, &mrt->mfc_unres_queue, _c.list) {
@@ -1140,7 +1141,8 @@ static int ipmr_cache_unresolved(struct mr_table *m=
rt, vifi_t vifi,
=20
=20	if (!found) {
=20		/* Create a new entry if allowable */
-		if (atomic_read(&mrt->cache_resolve_queue_len) >=3D 10 ||
+		if (atomic_read(&mrt->cache_resolve_queue_len) >=3D
+		    net->ipv4.sysctl_ip_mr_cache_queue_length ||
=20		    (c =3D ipmr_cache_alloc_unres()) =3D=3D NULL) {
=20			spin_unlock_bh(&mfc_unres_lock);
=20
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 891ed2f91467..b249932ee24e 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -772,6 +772,13 @@ static struct ctl_table ipv4_net_table[] =3D {
=20		.mode		=3D 0644,
=20		.proc_handler	=3D proc_dointvec
=20	},
+	{
+		.procname	=3D "ip_mr_cache_queue_length",
+		.data		=3D &init_net.ipv4.sysctl_ip_mr_cache_queue_length,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec
+	},
=20#ifdef CONFIG_IP_MULTICAST
=20	{
=20		.procname	=3D "igmp_qrv",
--=20
2.19.1
