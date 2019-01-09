Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C598BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761F9206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Ixoe6mkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfAIN2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:28:40 -0500
Received: from mail-eopbgr10043.outbound.protection.outlook.com ([40.107.1.43]:20160
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727627AbfAIN2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie2+6mFwD2awbmawBQqznfOVxDQzPGKyzD9UHZUDjwA=;
 b=Ixoe6mkZvLwTKzQ6kAzvRUowpoA8fe/gJH4zAI+MbV6GzqDqPS185rNHGZ6clCeRmcVdp2IhQSBXNYIusemUMrOZYQjpkjhTuL/i0rKfQShGzlhf3H0b6yTxqdbOA0+h9MeDdyNZiSrNdmGpoyjDBnK4ulyoGI1v1AQ34DsFgiE=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2510.eurprd05.prod.outlook.com (10.168.136.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 9 Jan 2019 13:28:34 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::d0e:3a7b:424e:9a71]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::d0e:3a7b:424e:9a71%5]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 13:28:34 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Myungho Jung <mhjungk@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/cma: Rollback source IP address if failing to
 acquire device
Thread-Topic: [PATCH] RDMA/cma: Rollback source IP address if failing to
 acquire device
Thread-Index: AQHUo/kkAnK838CbPEyzFpAIDBPdsaWm9UYg
Date:   Wed, 9 Jan 2019 13:28:34 +0000
Message-ID: <VI1PR0501MB2271AA04707AE880E8362933D18B0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <20190104064537.GA352@myunghoj-Precision-5530>
In-Reply-To: <20190104064537.GA352@myunghoj-Precision-5530>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec80:6500:452f:277b:31ab:2665]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2510;6:3GH5Q0mW1htZZ+InpXQ172BFyUEyXsCJvxsSKgLPDETZmolX8xsvwn4PBVRZ91y3qgHiC6NxMtuLkCy8uVaCwN4uFl+hx9vFjCV11w8ZfOQZkRA0Uhaf2TLw0uj/H0iWq1EJzkaMd2LmeexkQwYFUu07A0crt8FsV/Yx8VJH6XAmi8RhoJp2EZUb9SaMLX6ed2BhWNKkzs7+6AFpfakoVxd0UcQCwPybfkJnEU2JTod3oe+KmVBVzAnff9nsDHDpMHMJ8IMRoBr5vZWLf9BOHABNZkRWXSX0BfQ8LSnx4NJc/76ZzAwPtPe2f8oMFR+uWuFnBw2Y8zLZgAwJqzF17q8pbzWiKiYX72Z1d1nZTbtjyuAVMFee6gn1rKwXFx3toXeFQF7+bUtmVBjtrpcLZewLypjr+M8u9U8rE75C6a4jG4YRRf51UsgrcwHbezoJpH7qfgISB+PUhYhj1G7mSQ==;5:mPMUvFBdKX1/VVrKujKSuTIS1unjtQyUo6MSC28AkvK1nZtEoNrhDKs0B8H/HRZr5PckR/cvVmzzPRYEBDnfwonXFGQb4yHgq+axMMu1+mt3MfgfJBFc+PxaNmdqaq1eFat844rxTUGk4Y1WSUBWZESUWg35gwx5HAH1H2FLjEHC5phMHEfIiTycRukYOp21hhT0bwGUq/vZOTXsJ0WORg==;7:3PRbWEKhQ8BIr/9jPUuBmn+iCTLr5bl7PzRMPvliDr3+Ic7bILvxJwg3tEm7tX5VS/FD6G4PbqoL52IezB6kntmzE3Lkoim8cL5jOac2tYJBi01Mn1EqV6nTLOZHVL7VA9roFtnYixmdI91OyDE0Zw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8fef5985-f2b4-450e-be1e-08d676365b04
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2510;
x-ms-traffictypediagnostic: VI1PR0501MB2510:
x-microsoft-antispam-prvs: <VI1PR0501MB25107EEAB02CA8C47E9016B2D18B0@VI1PR0501MB2510.eurprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0501MB2510;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2510;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(39860400002)(346002)(199004)(189003)(13464003)(71200400001)(54906003)(86362001)(6116002)(229853002)(55016002)(9686003)(53936002)(97736004)(486006)(6436002)(14454004)(110136005)(46003)(68736007)(14444005)(39060400002)(256004)(53546011)(6506007)(305945005)(76176011)(74316002)(4326008)(186003)(5660300001)(102836004)(33656002)(8676002)(8936002)(105586002)(478600001)(476003)(11346002)(81166006)(81156014)(99286004)(6246003)(7696005)(316002)(25786009)(71190400001)(106356001)(446003)(7736002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2510;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tuTXM2aut3zCLUZloEFapTPovOk/r2im+2huN/vxlrxe8mwcnFZFglM+9RkFZlVGz2hFDQgLKnWZvkQe+0wkKwnv1boNmD2NW9ZuwV/YODIt9tcsYiMFxdHKjqK+cypajYJQLyGruOw9vi4MAeNccc9U5lyvN5NM2+pIfIx5cdir57l8UDx2onLIw5aTYC6OrKEGtkJNStWVV8q9jiR+CcD+cuwXqq3lzfWrxZYCfWPemL8uXzuIsep7ZmIbK2d6Vr4+lvJbcRnLDDlCJOEi+8XzPpFDGhm3Az5T2Db12+Knqng4xBevy1xx+G0YHVMi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fef5985-f2b4-450e-be1e-08d676365b04
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 13:28:34.6540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Myungho Jung
> Sent: Friday, January 4, 2019 12:46 AM
> To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] RDMA/cma: Rollback source IP address if failing to acqui=
re
> device
>=20
> If cma_acquire_dev_by_src_ip() returns error in addr_handler(), the devic=
e
> state changes back to RDMA_CM_ADDR_BOUND but the resolved source IP
> address is still left. After that, if rdma_destroy_id() is called after
> rdma_listen(), the device is freed without removed from listen_any_list i=
n
> cma_cancel_operation(). Revert to the previous IP address if acquiring de=
vice
> fails.
>=20
> Reported-by: syzbot+f3ce716af730c8f96637@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> ---
>  drivers/infiniband/core/cma.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.=
c
> index 63a7cc00bae0..d27c3b154e71 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -2963,13 +2963,17 @@ static void addr_handler(int status, struct
> sockaddr *src_addr,  {
>  	struct rdma_id_private *id_priv =3D context;
>  	struct rdma_cm_event event =3D {};
> +	struct sockaddr *addr;
> +	struct sockaddr_storage old_addr;
>=20
>  	mutex_lock(&id_priv->handler_mutex);
>  	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY,
>  			   RDMA_CM_ADDR_RESOLVED))
>  		goto out;
>=20
> -	memcpy(cma_src_addr(id_priv), src_addr,
> rdma_addr_size(src_addr));
> +	addr =3D cma_src_addr(id_priv);
> +	memcpy(&old_addr, addr, rdma_addr_size(addr));
Please add a comment here in the patch, why we need to store the old src ad=
dress and restore back.
/*
  * Store the previous src address, so that if we fail to acquire matching =
rdma device,
  * old address can be restored back, which helps to cancel the cma listen =
operation
  * correctly.
  */
> +	memcpy(addr, src_addr, rdma_addr_size(src_addr));
>  	if (!status && !id_priv->cma_dev) {
>  		status =3D cma_acquire_dev_by_src_ip(id_priv);
>  		if (status)
> @@ -2980,6 +2984,8 @@ static void addr_handler(int status, struct sockadd=
r
> *src_addr,
>  	}
>=20
>  	if (status) {
> +		memcpy(addr, &old_addr,
> +		       rdma_addr_size((struct sockaddr *)&old_addr));
>  		if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_RESOLVED,
>  				   RDMA_CM_ADDR_BOUND))
>  			goto out;
> --
> 2.17.1

Reviewed-by: Parav Pandit <parav@mellanox.com>
