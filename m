Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009DDC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BE7217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="v7TGi17L";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="KEs/n6IX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfAWIDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:03:30 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:50300 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbfAWID3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:03:29 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0N7oJuT019127;
        Wed, 23 Jan 2019 00:03:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=VulSOT0aq3fL08IrmtYWC5i5ESndWlhGc1Qi/pZYgl4=;
 b=v7TGi17Lfa9nIih1XK2h+HNYk4kJOLW29yiBbxogQdVm6xZcw4THIStjaPVKcA72hiGX
 20tH70FL+qqNMYoKYyXc9urZVFkqF9ZEikiff2x+G2jco23qwyJqDYpW8d21q+j1oNn8
 H3DPFxwW3+fnmyJisE+PSdks4cCajVcJGN8YrpyGDmRQe1zaAzXyhnPMNejFC7uRVZBA
 I+NMFAtZw07JGZ4GYmzVDnQOYVR5eQZGQuCMdy0OwzanR4DwKwhpb54C9rwutOeduMMe
 R42ODtjt7ikduz8DoADZWS/42/zJYKv+EALbCcOkESJcqRItyL1nPUE6h7jpRgClDRhF Ag== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2q6chtangg-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Jan 2019 00:03:16 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 23 Jan
 2019 00:03:14 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 23 Jan 2019 00:03:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VulSOT0aq3fL08IrmtYWC5i5ESndWlhGc1Qi/pZYgl4=;
 b=KEs/n6IXAPr65ONnzCCHHO6bAJ17MzXxEGyCF45TfIXHfL6/LoM0dbFbY1eR18whq0bOK3omD72lkx5YxBpoHiumgovHNOLURggtxh9etdSbgOm5oNMMXEEV20g8xuWEytyWMxVvVnlBe/GUlcGNaLAXo6rYapC9OKKLyUXRn94=
Received: from CY4PR18MB1253.namprd18.prod.outlook.com (10.172.176.11) by
 CY4PR18MB0950.namprd18.prod.outlook.com (10.173.182.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Wed, 23 Jan 2019 08:03:13 +0000
Received: from CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::81ab:3e62:ce9e:518b]) by CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::81ab:3e62:ce9e:518b%6]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 08:03:12 +0000
From:   Sudarsana Reddy Kalluru <skalluru@marvell.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Rasesh Mody <rasesh.mody@cavium.com>,
        Sudarsana Kalluru <sudarsana.kalluru@cavium.com>,
        "Dept-GELinuxNICDev@cavium.com" <Dept-GELinuxNICDev@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] bna: Mark expected switch fall-throughs
Thread-Topic: [PATCH net-next] bna: Mark expected switch fall-throughs
Thread-Index: AQHUsvEWcBzyEIQ2FEStrGxhuDrAr6W8fJsw
Date:   Wed, 23 Jan 2019 08:03:12 +0000
Message-ID: <CY4PR18MB125398716A4A84409D301F7AD3990@CY4PR18MB1253.namprd18.prod.outlook.com>
References: <20190123075328.GA25319@embeddedor>
In-Reply-To: <20190123075328.GA25319@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2402:3a80:527:a11a:dda5:10df:c5f6:ce95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB0950;20:zgaicmC72vI07CoeMJSFIvgSsuFdV01QIMjdQuvINtDhDhR2+wh15ySE4bp2AgT7s3KrgaD3YVu+8z5Dc4pY4lqAf0I1aH6MsZdOXOPoAzN0OUCFYgGUmm6o8zzPkP7zkO9lAH14bZ47SP7MbQ5k48oUR/8DgiNIo0y9RAz3AsA=
x-ms-office365-filtering-correlation-id: 0074e0b2-5bc1-4409-521a-08d6810938f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB0950;
x-ms-traffictypediagnostic: CY4PR18MB0950:
x-microsoft-antispam-prvs: <CY4PR18MB09508C0BA2120F438794C2F1D3990@CY4PR18MB0950.namprd18.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(13464003)(199004)(189003)(6506007)(102836004)(46003)(53546011)(81166006)(105586002)(4326008)(7696005)(14444005)(106356001)(186003)(8936002)(74316002)(6246003)(76176011)(71190400001)(256004)(14454004)(71200400001)(2906002)(6116002)(11346002)(476003)(99286004)(25786009)(6436002)(2501003)(478600001)(8676002)(68736007)(486006)(7736002)(97736004)(316002)(9686003)(55016002)(229853002)(54906003)(86362001)(110136005)(53936002)(305945005)(33656002)(446003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB0950;H:CY4PR18MB1253.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ry7Kcf91B39Erq5T7rcmCM742QvSTfM18gUIosa7xJ0ikSgY8SBwpqmWaBzK/45kDf1hc3g8Q/b7ybpgkU+V0JWMpZr5ggCkizdlyOOqWoUlVH02TrFFGq0tyzlWfIa5ZHaN/EpejmMTTsOhPj31KzKVjb8UBhLPGe8I/++T5y6X7ZpOMGxpWRc1YfKN+zzuo6rDn0iy5Dgee6KLzawk6LbLgzO9ftpjCFcAfqw0F8zqJhRDmy04Sw5TXGEV6Z77s+kTGygVVoXrO1PIMKBRLbVqXbYmSxXCXnCIMCF3v9qqUQKO7OTroMODwcnGM2F4KrSkjrEzmlAKpdIotWV4CwBg51JQjxKMMYDwshTMDlP4KTUICRCpDo9FjWrmkc7vbBzFIF7I+o6VnBnhEa3aUfvwhEj46JEg2gT+ntQrX7o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0074e0b2-5bc1-4409-521a-08d6810938f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 08:03:12.8922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB0950
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_04:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Gustavo A. R. Silva [mailto:gustavo@embeddedor.com]=20
Sent: 23 January 2019 13:23
To: Rasesh Mody <rasesh.mody@cavium.com>; Sudarsana Kalluru <sudarsana.kall=
uru@cavium.com>; Dept-GELinuxNICDev@cavium.com; David S. Miller <davem@dave=
mloft.net>
Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Gustavo A. R. Sil=
va <gustavo@embeddedor.com>
Subject: [PATCH net-next] bna: Mark expected switch fall-throughs

External Email

In preparation to enabling -Wimplicit-fallthrough, mark switch cases where =
we are expecting to fall through.

This patch fixes the following warnings:

drivers/net/ethernet/brocade/bna/bfa_ioc.c:790:3: warning: this statement m=
ay fall through [-Wimplicit-fallthrough=3D]
drivers/net/ethernet/brocade/bna/bfa_ioc.c:860:3: warning: this statement m=
ay fall through [-Wimplicit-fallthrough=3D]

Warning level 3 was used: -Wimplicit-fallthrough=3D3

This patch is part of the ongoing efforts to enabling -Wimplicit-fallthroug=
h

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/brocade/bna/bfa_ioc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ether=
net/brocade/bna/bfa_ioc.c
index a36e38676640..cbc9175d74c5 100644
--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -788,9 +788,8 @@ bfa_iocpf_sm_enabling(struct bfa_iocpf *iocpf, enum ioc=
pf_event event)

        case IOCPF_E_INITFAIL:
                del_timer(&ioc->iocpf_timer);
-               /*
-                * !!! fall through !!!
-                */
+               /* fall through */
+
        case IOCPF_E_TIMEOUT:
                bfa_nw_ioc_hw_sem_release(ioc);
                if (event =3D=3D IOCPF_E_TIMEOUT) @@ -858,9 +857,7 @@ bfa_i=
ocpf_sm_disabling(struct bfa_iocpf *iocpf, enum iocpf_event event)

        case IOCPF_E_FAIL:
                del_timer(&ioc->iocpf_timer);
-               /*
-                * !!! fall through !!!
-                */
+               /* fall through*/

        case IOCPF_E_TIMEOUT:
                bfa_ioc_set_cur_ioc_fwstate(ioc, BFI_IOC_FAIL);
--
2.20.1

Acked-by: Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>
