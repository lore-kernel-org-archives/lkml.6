Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2638C5AC75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F672173B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SaL8mocm";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="JcuuQc+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbeLXO07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 09:26:59 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:48732 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbeLXO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 09:26:58 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBOEPZ8K023817;
        Mon, 24 Dec 2018 06:26:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=QXt797p20wXU4rlBRMuWK/49R4SDlhgzUptP4qBNWuQ=;
 b=SaL8mocmotqRSTiOnuBNaKj+xn3jSjlGnH3wFbmCa8ZuKaJBKtV4WCx7syz1IyM0m0xk
 Qq67B4UHm+UWU7PsxcnLysN8WUnSlvevQ3Ru/R/J73jjbHMSJFJzmPshXah98VYWOcvW
 ilJI87ho0ZXIc8oOAqCqYRvXj5xqva24MS4temYCQMrI1bMsThf2J7C+NfJvnoFzYo3k
 yPNdkcWWQEROD2nCCJqKMH67jrzviVwmpb+5QUpOjPnFtb4cNpbSFWMl4j8Kv5XOLfQM
 4CCFATijwC9dVA4LAdCZImQgAcgelR/wg9pslrwCifolV9LNLAexStQBPptz7JCwr1tS sQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2pjv9r193m-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Dec 2018 06:26:53 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Dec
 2018 06:26:52 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Dec 2018 06:26:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXt797p20wXU4rlBRMuWK/49R4SDlhgzUptP4qBNWuQ=;
 b=JcuuQc+tkdf3BAKdK61P4CmxICJ4W8fxU0QPCLTCEXLFW8agYehy/HlgnSpqOz/Q31Qdd8rL8MBzPyr/tADmsY+6TKYdqIqWT26GQxbFuy/pp5sdaAyvnlEi50FCG95X1q80w4ACLZ7TaMqFAunM0Q67emVUx+HUi8FqT5fXeVc=
Received: from CY4PR18MB1253.namprd18.prod.outlook.com (10.172.176.11) by
 CY4PR18MB0952.namprd18.prod.outlook.com (10.173.182.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 14:26:51 +0000
Received: from CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::d074:6c50:6559:3baa]) by CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::d074:6c50:6559:3baa%12]) with mapi id 15.20.1446.026; Mon, 24 Dec
 2018 14:26:51 +0000
From:   Sudarsana Reddy Kalluru <skalluru@marvell.com>
To:     Ivan Mironov <mironov.ivan@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Ariel Elior <ariel.elior@cavium.com>,
        Sudarsana Kalluru <sudarsana.kalluru@cavium.com>,
        "everest-linux-l2@cavium.com" <everest-linux-l2@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH v1] bnx2x: Fix NULL pointer dereference in
 bnx2x_del_all_vlans() on some hw
Thread-Topic: [EXT] [PATCH v1] bnx2x: Fix NULL pointer dereference in
 bnx2x_del_all_vlans() on some hw
Thread-Index: AQHUm3/AbyPTlJrRBkaIjxMw/hdMr6WN7DFw
Date:   Mon, 24 Dec 2018 14:26:51 +0000
Message-ID: <CY4PR18MB125333EFFE5875193E66927FD3BB0@CY4PR18MB1253.namprd18.prod.outlook.com>
References: <20181224115609.21752-1-mironov.ivan@gmail.com>
In-Reply-To: <20181224115609.21752-1-mironov.ivan@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2402:3a80:518:4801:dda5:10df:c5f6:ce95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB0952;20:tYKnltjtPvI/vll1/Q54MzkbbD2TGnN3PIauZuDtQSOv19R2o8QyLKLXRySx3VWMP906RiH4LAVT0VL9T/9/QxVuNppyiU1TxvLkYwRdi2NClDnIhd6bOBbj+puRxOX8ExnF2feH44e+2LYWmiBa56FL3xdMaNrwNFquB0fYePg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a81065c5-2b78-438f-7721-08d669abd898
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB0952;
x-ms-traffictypediagnostic: CY4PR18MB0952:
x-microsoft-antispam-prvs: <CY4PR18MB0952ECB9136972082825FA80D3BB0@CY4PR18MB0952.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR18MB0952;BCL:0;PCL:0;RULEID:;SRVR:CY4PR18MB0952;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(346002)(136003)(366004)(199004)(13464003)(189003)(2501003)(97736004)(25786009)(186003)(4326008)(71190400001)(71200400001)(99286004)(81156014)(81166006)(6116002)(575784001)(39060400002)(7736002)(486006)(229853002)(2906002)(8936002)(305945005)(86362001)(105586002)(316002)(5660300001)(102836004)(106356001)(54906003)(68736007)(110136005)(476003)(76176011)(14444005)(6506007)(53546011)(7696005)(6246003)(11346002)(446003)(256004)(8676002)(74316002)(6436002)(33656002)(46003)(9686003)(53936002)(478600001)(55016002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB0952;H:CY4PR18MB1253.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h5ewQHGJkxxdTsKLO7GOc6Bgr9NtOkDUEf7dcyQBlaxYaFdjTvAvam7/ktiAanhmGOkw0mzgwp0ZpJ0/VFxchyU8gu1EmasuMNgfNlPNoihHluguJdHP6y05Z3WZJ2mHTC49sHtm+lyK8/8qbNxqNZVCl9OuJ0QEJIKUDtjZ2h8i/S6/fEg9kTdsAOXQSRqw3CcnHsYzteAbgJ3NvLEYuZaKsi72w3ErXKod3lc6c9E8hOm5+9KZvInbhO/MzQZiAQH/C/5jaDLsaoOWIhg/xrZ6RcyLw9BcoTc2sIHsUrp1Ig3eYtUKs0HAgsW+7vDe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a81065c5-2b78-438f-7721-08d669abd898
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 14:26:51.2847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB0952
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-24_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812240128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Ivan Mironov [mailto:mironov.ivan@gmail.com]=20
Sent: 24 December 2018 17:26
To: netdev@vger.kernel.org
Cc: Ariel Elior <ariel.elior@cavium.com>; Sudarsana Kalluru <sudarsana.kall=
uru@cavium.com>; everest-linux-l2@cavium.com; David S. Miller <davem@daveml=
oft.net>; linux-kernel@vger.kernel.org; Ivan Mironov <mironov.ivan@gmail.co=
m>
Subject: [EXT] [PATCH v1] bnx2x: Fix NULL pointer dereference in bnx2x_del_=
all_vlans() on some hw

External Email

----------------------------------------------------------------------
External Email

This happened when I tried to boot normal Fedora 29 system with latest avai=
lable kernel (from fedora rawhide, plus some unrelated custom
patches):

        BUG: unable to handle kernel NULL pointer dereference at 0000000000=
000000
        PGD 0 P4D 0
        Oops: 0010 [#1] SMP PTI
        CPU: 6 PID: 1422 Comm: libvirtd Tainted: G          I       4.20.0-=
0.rc7.git3.hpsa2.1.fc29.x86_64 #1
        Hardware name: HP ProLiant BL460c G6, BIOS I24 05/21/2018
        RIP: 0010:          (null)
        Code: Bad RIP value.
        RSP: 0018:ffffa47ccdc9fbe0 EFLAGS: 00010246
        RAX: 0000000000000000 RBX: 00000000000003e8 RCX: ffffa47ccdc9fbf8
        RDX: ffffa47ccdc9fc00 RSI: ffff97d9ee7b01f8 RDI: ffff97d9f0150b80
        RBP: ffff97d9f0150b80 R08: 0000000000000000 R09: 0000000000000000
        R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
        R13: ffff97d9ef1e53e8 R14: 0000000000000009 R15: ffff97d9f0ac6730
        FS:  00007f4d224ef700(0000) GS:ffff97d9fa200000(0000) knlGS:0000000=
000000000
        CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
        CR2: ffffffffffffffd6 CR3: 00000011ece52006 CR4: 00000000000206e0
        Call Trace:
         ? bnx2x_chip_cleanup+0x195/0x610 [bnx2x]
         ? bnx2x_nic_unload+0x1e2/0x8f0 [bnx2x]
         ? bnx2x_reload_if_running+0x24/0x40 [bnx2x]
         ? bnx2x_set_features+0x79/0xa0 [bnx2x]
         ? __netdev_update_features+0x244/0x9e0
         ? netlink_broadcast_filtered+0x136/0x4b0
         ? netdev_update_features+0x22/0x60
         ? dev_disable_lro+0x1c/0xe0
         ? devinet_sysctl_forward+0x1c6/0x211
         ? proc_sys_call_handler+0xab/0x100
         ? __vfs_write+0x36/0x1a0
         ? rcu_read_lock_sched_held+0x79/0x80
         ? rcu_sync_lockdep_assert+0x2e/0x60
         ? __sb_start_write+0x14c/0x1b0
         ? vfs_write+0x159/0x1c0
         ? vfs_write+0xba/0x1c0
         ? ksys_write+0x52/0xc0
         ? do_syscall_64+0x60/0x1f0
         ? entry_SYSCALL_64_after_hwframe+0x49/0xbe

After some investigation I figured out that recently added cleanup code tri=
es to call VLAN filtering de-initialization function which exist only for n=
ewer hardware. Corresponding function pointer is not set (=3D=3D 0) for old=
er hardware, namely these chips:

        #define CHIP_NUM_57710                  0x164e
        #define CHIP_NUM_57711                  0x164f
        #define CHIP_NUM_57711E                 0x1650

And I have one of those in my test system:

        Broadcom Inc. and subsidiaries NetXtreme II BCM57711E 10-Gigabit PC=
Ie [14e4:1650]

Function bnx2x_init_vlan_mac_fp_objs() from drivers/net/ethernet/broadcom/b=
nx2x/bnx2x_cmn.h decides whether to initialize relevant pointers in bnx2x_s=
p_objs.vlan_obj or not.

This regression was introduced after v4.20-rc7, and still exists in v4.20 r=
elease.

Fixes: 04f05230c5c13 ("bnx2x: Remove configured vlans as part of unload seq=
uence.")
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
v1:
- Check for chip num instead of (vlan_obj->delete_all !=3D 0).
v0:
- Patch introduced.
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net=
/ethernet/broadcom/bnx2x/bnx2x_main.c
index b164f705709d..4d72e9948a58 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -8504,15 +8504,23 @@ int bnx2x_set_vlan_one(struct bnx2x *bp, u16 vlan, =
 static int bnx2x_del_all_vlans(struct bnx2x *bp)  {
        struct bnx2x_vlan_mac_obj *vlan_obj =3D &bp->sp_objs[0].vlan_obj;
-       unsigned long ramrod_flags =3D 0, vlan_flags =3D 0;
        struct bnx2x_vlan_entry *vlan;
-       int rc;

-       __set_bit(RAMROD_COMP_WAIT, &ramrod_flags);
-       __set_bit(BNX2X_VLAN, &vlan_flags);
-       rc =3D vlan_obj->delete_all(bp, vlan_obj, &vlan_flags, &ramrod_flag=
s);
-       if (rc)
-               return rc;
+       /* The whole *vlan_obj structure may be not initialized if VLAN
+        * filtering offload is not supported by hardware. Currently this i=
s
+        * true for all hardware covered by CHIP_IS_E1x().
+        */
+       if (!CHIP_IS_E1x(bp)) {
+               unsigned long ramrod_flags =3D 0, vlan_flags =3D 0;
+               int rc;
+
+               __set_bit(RAMROD_COMP_WAIT, &ramrod_flags);
+               __set_bit(BNX2X_VLAN, &vlan_flags);
+               rc =3D vlan_obj->delete_all(bp, vlan_obj, &vlan_flags,
+                                         &ramrod_flags);
+               if (rc)
+                       return rc;
+       }

        /* Mark that hw forgot all entries */
        list_for_each_entry(vlan, &bp->vlan_reg, link)
--
2.20.1

Thanks a lot for root-causing the issue and the patch.
Another (simpler) way to address this would be to invoke bnx2x_del_all_vlan=
s() only for the newer chips, e.g.,=20
+       if (!CHIP_IS_E1(bp)) {
	/* Remove all currently configured VLANs */
               rc =3D bnx2x_del_all_vlans(bp);
               if (rc < 0)
                       BNX2X_ERR("Failed to delete all VLANs\n");
+       }
Could you please check on this?
