Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B30C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 22:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2521520693
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 22:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2521520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeJNFoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 01:44:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbeJNFoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 01:44:15 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9DM3tLH004187
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 18:05:35 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n3k6dgrnc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 18:05:35 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mwb@linux.vnet.ibm.com>;
        Sat, 13 Oct 2018 18:05:34 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 13 Oct 2018 18:05:29 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9DM5SBP44105898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 Oct 2018 22:05:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33ADAB206A;
        Sat, 13 Oct 2018 18:03:26 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 147BFB205F;
        Sat, 13 Oct 2018 18:03:26 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (unknown [9.40.195.192])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 13 Oct 2018 18:03:26 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (localhost [IPv6:::1])
        by ltcalpine2-lp9.aus.stglabs.ibm.com (Postfix) with ESMTP id 06AB120FBAB7;
        Sat, 13 Oct 2018 17:05:28 -0500 (CDT)
Subject: [PATCH] net/sysfs: Remove devices without receive buffers
From:   Michael Bringmann <mwb@linux.vnet.ibm.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mwb@linux.vnet.ibm.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Joe Perches <joe@perches.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Decotigny <decot@googlers.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date:   Sat, 13 Oct 2018 17:05:28 -0500
User-Agent: StGit/0.18-105-g416a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101322-0064-0000-0000-0000035F0FB7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009874; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01102243; UDB=6.00570436; IPR=6.00882289;
 MB=3.00023746; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-13 22:05:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101322-0065-0000-0000-00003AF894DB
Message-Id: <20181013220451.6905.65084.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-13_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810130207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing ran into a case where a network device was created and
initialized, but then removed from the system before accepting
traffic through it.  In this case, no receive buffers were added
to the device prior to attempting to release the driver.  This
resulted in generation of a WARNING notice/stack trace in the
console log like,

kobject: '(null)' (c0000009e028a310): is not initialized, yet kobject_put() is being called.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 7689 at lib/kobject.c:661 kobject_put+0x2a8/0x370
Modules linked in: bonding iptable_filter rpadlpar_io rpaphp tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag btrfs raid6_pq pseries_rng xor sg ibmvnic nfsd auth_rpcgss nfs_acl lockd grace sunrpc binfmt_misc ip_tables xfs libcrc32c sd_mod crc_t10dif crct10dif_generic crct10dif_common ibmvscsi scsi_transport_srp ibmvfc scsi_transport_fc ibmveth scsi_tgt dm_mirror dm_region_hash dm_log dm_mod [last unloaded: bonding]
CPU: 1 PID: 7689 Comm: drmgr Kdump: loaded Not tainted 3.10.0-948.el7.ppc64le #1
task: c0000009ddb55c00 ti: c0000009daea8000 task.ti: c0000009daea8000
NIP: c000000000551ff8 LR: c000000000551ff4 CTR: 0000000000770c6c
REGS: c0000009daeab4a0 TRAP: 0700   Not tainted  (3.10.0-948.el7.ppc64le)
MSR: 8000000100029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28088822  XER: 0000000d
CFAR: c000000000a97f78 SOFTE: 1
00551ff4 c0000009daeab720 c0000000013e4d00 000000000000005c
0194a820 c00000000195d728 0000bc6bd731da26 00000000000000ec
00000007 0000000000000000 0000000000ad0000 0000000000000000
00008000 c000000007af0900 0000000000000000 0000000000000000
00000000 0000000000000000 0000000000000000 0000000000000000
00000000 0000000000000000 0000000000000000 0000000000000007
00d19c28 c000000000d19c50 0000000000000000 0000000000000000
d7dca000 c0000009e364da00 0000000000000005 c0000009e028a310
NIP [c000000000551ff8] kobject_put+0x2a8/0x370
LR [c000000000551ff4] kobject_put+0x2a4/0x370
Call Trace:
[c0000009daeab720] [c000000000551ff4] kobject_put+0x2a4/0x370 (unreliable)
[c0000009daeab7b0] [c000000000905ae8] net_rx_queue_update_kobjects+0x128/0x190
[c0000009daeab860] [c000000000905d78] netdev_unregister_kobject+0x48/0xa0
[c0000009daeab890] [c0000000008d35f4] rollback_registered_many+0x374/0x4e0
[c0000009daeab950] [c0000000008d38f8] unregister_netdev+0x68/0xf0
[c0000009daeab9d0] [d00000000aac95d4] ibmvnic_remove+0x54/0x190 [ibmvnic]
[c0000009daeaba10] [c00000000003f744] vio_bus_remove+0x64/0xf0
[c0000009daeaba50] [c0000000006b3a30] device_release_driver+0xf0/0x1b0
[c0000009daeaba90] [c0000000006b2d10] bus_remove_device+0x180/0x220
[c0000009daeabb10] [c0000000006ab9ac] device_del+0x1fc/0x3b0
[c0000009daeabba0] [c0000000006abb9c] device_unregister+0x3c/0xa0
[c0000009daeabc10] [c00000000003f49c] vio_unregister_device+0x2c/0x60
[c0000009daeabc40] [d00000000eb0093c] dlpar_remove_slot+0x28c/0x340 [rpadlpar_io]
[c0000009daeabcd0] [d00000000eb00b1c] remove_slot_store+0x8c/0xd0 [rpadlpar_io]
[c0000009daeabd40] [c0000000005516d0] kobj_attr_store+0x30/0x60
[c0000009daeabd60] [c00000000044c97c] sysfs_kf_write+0x6c/0xa0
[c0000009daeabd80] [c00000000044b7d0] kernfs_fop_write+0x150/0x1e0
[c0000009daeabdd0] [c000000000369e74] SyS_write+0x164/0x430
[c0000009daeabe30] [c00000000000a284] system_call+0x38/0xfc

This patch removes the warning for unitialized receive queues.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 net/core/net-sysfs.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index bd67c4d..a1d3f67 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -971,6 +971,8 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
 	while (--i >= new_num) {
 		struct kobject *kobj = &dev->_rx[i].kobj;
 
+		if (!kobj->state_initialized)
+			continue;
 		if (!refcount_read(&dev_net(dev)->count))
 			kobj->uevent_suppress = 1;
 		if (dev->sysfs_rx_queue_group)

