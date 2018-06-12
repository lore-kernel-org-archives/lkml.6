Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6839BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1447020693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Aw/C8qFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1447020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933755AbeFLHwc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:52:32 -0400
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:20038
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933579AbeFLHw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJkA8yfJzOSZDPS9AMvej8RDSwg6tzqhsqn72l1Ae4E=;
 b=Aw/C8qFpJxylJEa3c7v7PsVeSi/wXS/O/mqukwMA9MLU6wYBjJsxfzVa/FKB5JjeZuwSl0glYP8ZG+8yiqvH4dLXPcBM1WCQH2IbhiKdazC+mQzqRTecJtzBFYw3dWzKNIAVgt/7uBI5rJi1txkPks9IdWWlQWXA18AeqGIE46I=
Received: from MW2PR07MB4042.namprd07.prod.outlook.com (52.132.179.25) by
 MW2PR07MB3897.namprd07.prod.outlook.com (52.132.178.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Tue, 12 Jun 2018 07:52:26 +0000
Received: from MW2PR07MB4042.namprd07.prod.outlook.com
 ([fe80::7964:8ea4:50eb:9c8]) by MW2PR07MB4042.namprd07.prod.outlook.com
 ([fe80::7964:8ea4:50eb:9c8%6]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 07:52:26 +0000
From:   "Rangankar, Manish" <Manish.Rangankar@cavium.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
CC:     Dept-Eng QLogic Storage Upstream 
        <QLogic-Storage-Upstream@cavium.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: qla4xxx: add error handling for try_module_get
Thread-Topic: [PATCH] scsi: qla4xxx: add error handling for try_module_get
Thread-Index: AQHUAgihB6fXFNrGakWj0uw9sx/DdaRcQFiw
Date:   Tue, 12 Jun 2018 07:52:26 +0000
Message-ID: <MW2PR07MB4042EC187A6945E4F39D97FAE37F0@MW2PR07MB4042.namprd07.prod.outlook.com>
References: <1528778910-42113-1-git-send-email-jiazhouyang09@gmail.com>
In-Reply-To: <1528778910-42113-1-git-send-email-jiazhouyang09@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Manish.Rangankar@cavium.com; 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR07MB3897;7:RznhcmePZechoYnj5V56B8GpCewJrebZq1ti2+cruDizhl2bv8hHKUsLzxDf230Cxv8ENqnhO1b4vI0h9Sqo3lVLYdDyEdRNewbFnj1+BrOxee5srDbDhzSgktVh+7Ec/0PrI/jFS3lEfcU5txpXs6RigeC4bKgO1EnuN2rQd8/SdBCGW/ElzuDBF6iIUkAAShnTJbN+FkYrzRFJlqHH2Nb2j91tyZHCm83iw9qLXgwiOpZUCcjaSQ1OMrOd0XOo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MW2PR07MB3897;
x-ms-traffictypediagnostic: MW2PR07MB3897:
x-microsoft-antispam-prvs: <MW2PR07MB38973E8510FFE29C43016F29E37F0@MW2PR07MB3897.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR07MB3897;BCL:0;PCL:0;RULEID:;SRVR:MW2PR07MB3897;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39380400002)(39860400002)(396003)(199004)(189003)(13464003)(5660300001)(39060400002)(105586002)(8936002)(186003)(26005)(478600001)(72206003)(14454004)(106356001)(1411001)(2900100001)(7696005)(6916009)(486006)(476003)(11346002)(446003)(25786009)(59450400001)(5250100002)(6506007)(6246003)(4326008)(7736002)(9686003)(102836004)(229853002)(76176011)(53936002)(6436002)(55016002)(2906002)(3660700001)(316002)(305945005)(66066001)(33656002)(86362001)(99286004)(8676002)(81166006)(97736004)(81156014)(54906003)(3846002)(74316002)(6116002)(3280700002)(68736007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB3897;H:MW2PR07MB4042.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c4ZlVWiy3PZOJR1i8zjt72bRDO/9cPQzyiMndtiRqkfsMfW2zDLfh4e+PaL+H1FUvqul3zPqaBIGrOtl7Lt1X2qJgIp71gwP1b4W8pszrM8ehnhI5ik8VMNOh4hro4xem8NE34gGXeJYTHsZ/O2RtzRDZW858+cd+nR3GvZOsFVGeiJ3VpX+Z9NbrVig6hU+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d8e38898-039f-4db7-e230-08d5d0397099
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e38898-039f-4db7-e230-08d5d0397099
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 07:52:26.2638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Zhouyang Jia <jiazhouyang09@gmail.com>
> Sent: Tuesday, June 12, 2018 10:18 AM
> Cc: Zhouyang Jia <jiazhouyang09@gmail.com>; Dept-Eng QLogic Storage
> Upstream <QLogic-Storage-Upstream@cavium.com>; James E.J. Bottomley
> <jejb@linux.vnet.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com=
>;
> linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] scsi: qla4xxx: add error handling for try_module_get
>=20
> When try_module_get fails, the lack of error-handling code may cause
> unexpected results.
>=20
> This patch adds error-handling code after calling try_module_get.
>=20
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/scsi/qla4xxx/ql4_os.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.=
c index
> 0e13349..6b677ab 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -7687,7 +7687,10 @@ static int qla4xxx_sysfs_ddb_logout_sid(struct
> iscsi_cls_session *cls_sess)
>  	 * to be seamless without actually destroying the
>  	 * session
>  	 **/
> -	try_module_get(qla4xxx_iscsi_transport.owner);
> +	if (!try_module_get(qla4xxx_iscsi_transport.owner))
> +		ql4_printk(KERN_WARNING, ha,
> +			"%s: cannot get module.\n", __func__);
> +
>  	iscsi_destroy_endpoint(ddb_entry->conn->ep);
>=20
>  	spin_lock_irqsave(&ha->hardware_lock, flags); @@ -8970,7 +8973,9
> @@ static void qla4xxx_destroy_fw_ddb_session(struct scsi_qla_host *ha)
>  			 * to be seamless without actually destroying the
>  			 * session
>  			 **/
> -			try_module_get(qla4xxx_iscsi_transport.owner);
> +			if (!try_module_get(qla4xxx_iscsi_transport.owner))
> +				ql4_printk(KERN_WARNING, ha,
> +					"%s: cannot get module.\n",
> __func__);
>  			iscsi_destroy_endpoint(ddb_entry->conn->ep);
>  			qla4xxx_free_ddb(ha, ddb_entry);
>  			iscsi_session_teardown(ddb_entry->sess);
> --
> 2.7.4

Thanks,

Acked-by: Manish Rangankar <Manish.Rangankar@cavium.com>
