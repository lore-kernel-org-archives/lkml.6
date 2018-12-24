Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3BAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD75A21721
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="wh8wexbU";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="ob/n8NO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeLXIuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:50:02 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43378 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726842AbeLXIuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:50:02 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBO8noTb013700;
        Mon, 24 Dec 2018 00:49:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=LbitqDNZKpLMbfjbDm3DIJ91dPydzC4jDIYJEOYM4+g=;
 b=wh8wexbUzlss3Qt5Xe7PfjfHNwURuKFoYYNFzu8AuWns2TAjnUNqnxwss8EaeEjS1EcR
 nuRzZPdNHTGjJ2MY9xflwH3g9XqHIkWCvAhsh2ManxSxgLpdgUxoooubDVzF1Db/Ru6A
 9YnbvkY8l4jdkb4G4Go9AW12ApD22o60StN0QugDB2G3y+TYzs3bRmXzGiBbBytuc+Hi
 JiSQnNnIGhYzvQbKr/YcpPM4JcBlon11oIDyHFfl7+9dzQCAsY4DqNfrt9GM+d5rpFi4
 cOYowN6zJnPanolOb5RZhS7jxhslkiHANW1AWUfR7pVyXFHD8HKbMSZRXDSO0N5tfXk/ kw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2pjv9r0009-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Dec 2018 00:49:53 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Dec
 2018 00:49:52 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Dec 2018 00:49:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbitqDNZKpLMbfjbDm3DIJ91dPydzC4jDIYJEOYM4+g=;
 b=ob/n8NO8hrWqe0v3wwAQEGMfFpE/USDo7vwQvnhOCuPeKUA/bZBfqLgtV7wniM1qQzZ56vmQKMt/gWQw/GePFBVe6H7v7xDqOZuYqNiL5RHXPxlleOVwrue3TJGX3iQ7Av7vifTADXkoqsjEJKZKB3a4kUai6S5u6CdFjJOvDGk=
Received: from DM5PR18MB2134.namprd18.prod.outlook.com (52.132.143.31) by
 DM5PR18MB1482.namprd18.prod.outlook.com (10.173.214.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Mon, 24 Dec 2018 08:49:50 +0000
Received: from DM5PR18MB2134.namprd18.prod.outlook.com
 ([fe80::a062:accf:7e2c:8750]) by DM5PR18MB2134.namprd18.prod.outlook.com
 ([fe80::a062:accf:7e2c:8750%4]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 08:49:50 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "QLogic-Storage-Upstream@qlogic.com" 
        <QLogic-Storage-Upstream@qlogic.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [EXT] [PATCH -next] scsi: qla4xxx: check return code of
 qla4xxx_copy_from_fwddb_param
Thread-Topic: [EXT] [PATCH -next] scsi: qla4xxx: check return code of
 qla4xxx_copy_from_fwddb_param
Thread-Index: AQHUmBJzywVf+R8mw0iHay6myWDC/6WNmv5w
Date:   Mon, 24 Dec 2018 08:49:49 +0000
Message-ID: <DM5PR18MB21349BAF4AF8E373EE037969D8BB0@DM5PR18MB2134.namprd18.prod.outlook.com>
References: <20181220031607.10588-1-yuehaibing@huawei.com>
In-Reply-To: <20181220031607.10588-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR18MB1482;20:9ynzYSobtTjryK0V0SffLdNfZlBpB5NNmC7SkzI0f/0AZrCpb+y1EWCehOROLRR1X5abr7JbBb0L/+VCKEgqIJkhbgXzjLOv/4GgVbs0wAEHDVW7y0mjlTx30WirXPQ5QSKDFIUvJ4Vb2+PHmsySMO6FYT/Ictp3YeSj9OP4/Rg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 70a17c95-2741-4aad-d074-08d6697cc3c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB1482;
x-ms-traffictypediagnostic: DM5PR18MB1482:
x-microsoft-antispam-prvs: <DM5PR18MB1482AF9B5A2ABFCAC06A81BDD8BB0@DM5PR18MB1482.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR18MB1482;BCL:0;PCL:0;RULEID:;SRVR:DM5PR18MB1482;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(13464003)(5660300001)(68736007)(54906003)(316002)(105586002)(106356001)(478600001)(81166006)(81156014)(8936002)(110136005)(8676002)(14454004)(7696005)(76176011)(53546011)(26005)(102836004)(6506007)(66066001)(6436002)(71190400001)(7736002)(99286004)(71200400001)(186003)(11346002)(33656002)(446003)(6116002)(2501003)(3846002)(86362001)(256004)(25786009)(2906002)(4326008)(2201001)(305945005)(97736004)(53936002)(74316002)(9686003)(486006)(14444005)(6246003)(55016002)(476003)(229853002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1482;H:DM5PR18MB2134.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: neI56yClWu7npOZ5MZToDJfCFwQRmtC49/CMFz9tTYennccPGp9028rlKYmioowlqVkTX6zW5xzuPRnjRMU+Amg32Q1qpUBK/cjRqlhqgGLR/92+Zzg4RBXRV5gWa3zazu+Ic7G0Cf+0D+qZWhPoirxiis8MDEhgQSccdktPXT+jyKsFsmksmU+p7Qr0AAZHiUi5BNoWEYWs5hVc/OpaTObdTC1NMe+WXx5ayjyN5+BZUJZWIm/w+C56t7LqOgQI3YlDCsgOr08dLWyzfsoJSkY9PGn4dW5DxVC4VNPsBsZ5HG9Em5v3DJ0IohyF5+eW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a17c95-2741-4aad-d074-08d6697cc3c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 08:49:49.9896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1482
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-24_04:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812240080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: YueHaibing <yuehaibing@huawei.com>
> Sent: Thursday, December 20, 2018 8:46 AM
> To: QLogic-Storage-Upstream@qlogic.com; jejb@linux.ibm.com;
> martin.petersen@oracle.com
> Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org; YueHaibing
> <yuehaibing@huawei.com>
> Subject: [EXT] [PATCH -next] scsi: qla4xxx: check return code of
> qla4xxx_copy_from_fwddb_param
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> External Email
>=20
> The return code should be check while qla4xxx_copy_from_fwddb_param fails=
.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/scsi/qla4xxx/ql4_os.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.=
c index
> 949e186..1bc4db6 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -7232,6 +7232,8 @@ static int qla4xxx_sysfs_ddb_tgt_create(struct
> scsi_qla_host *ha,
>=20
>         rc =3D qla4xxx_copy_from_fwddb_param(fnode_sess, fnode_conn,
>                                            fw_ddb_entry);
> +       if (rc)
> +               goto free_sess;
>=20
>         ql4_printk(KERN_INFO, ha, "%s: sysfs entry %s created\n",
>                    __func__, fnode_sess->dev.kobj.name);
> --
> 2.7.0
>=20

Thanks
Acked-by: Manish Rangankar <mrangankar@marvell.com>

