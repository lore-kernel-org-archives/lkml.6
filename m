Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D65C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81B3217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AYX1MPA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeLZI3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:29:40 -0500
Received: from mail-eopbgr710042.outbound.protection.outlook.com ([40.107.71.42]:9952
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbeLZI3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fznmrNfyz6+o7shDXCFsxZP/g9SwJIk+CCgw3uYxJRE=;
 b=AYX1MPA4AWN/By029FLziToi4tlKgNbWttsASogxN8v3BytE001RtXqK+X5dBggR80DaCqlSkLu3wm7ZpcnNWONCDqm+dm5qEOIOpMljn52hTkjeHh/KFc2QYgGBhe+kWYUH9Rcw1oWBgEWYP9ACWE+1e9w/dBfk6vq27A816zU=
Received: from BYAPR12MB3016.namprd12.prod.outlook.com (20.178.53.141) by
 BYAPR12MB3382.namprd12.prod.outlook.com (20.178.55.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Wed, 26 Dec 2018 08:29:33 +0000
Received: from BYAPR12MB3016.namprd12.prod.outlook.com
 ([fe80::240d:fc9e:71fd:cdad]) by BYAPR12MB3016.namprd12.prod.outlook.com
 ([fe80::240d:fc9e:71fd:cdad%4]) with mapi id 15.20.1471.019; Wed, 26 Dec 2018
 08:29:29 +0000
From:   "Huang, Ray" <Ray.Huang@amd.com>
To:     Kangjie Lu <kjlu@umn.edu>
CC:     "pakki001@umn.edu" <pakki001@umn.edu>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, "Zhu, Rex" <Rex.Zhu@amd.com>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>,
        "Xu, Feifei" <Feifei.Xu@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpu: drm: fix an improper check of
 amdgpu_bo_create_kernel
Thread-Topic: [PATCH] gpu: drm: fix an improper check of
 amdgpu_bo_create_kernel
Thread-Index: AQHUnOOoEcshgKVKEU2ZwQMEVbCPbaWQrnog
Date:   Wed, 26 Dec 2018 08:29:29 +0000
Message-ID: <BYAPR12MB3016F58D77B4574AED72C0D4ECB50@BYAPR12MB3016.namprd12.prod.outlook.com>
References: <20181226062348.75519-1-kjlu@umn.edu>
In-Reply-To: <20181226062348.75519-1-kjlu@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3382;20:ifCNrw7QabdGqoH8q1aJ+BH58p/CvMoBXFFKbMyP+vSjYoGY6XyqHOVDunjKAJDEEnWbZCdqes/r9DHjhwyhJ7ZBgo2E1JMm6QDdO6MKO2C5w7m6dtQiZQCX7P11If0Hxq4aScSp/JK5bOVu9NB36hmdy9EeZjjiK3ba7tQZIsd0a+3+zhHA2O6mO3qx/zjuth633pNjgHsERUFy/4VozpWuvKLTOBo8CbEoEQ1AjezwiT6cTApVxHAxNTjvd0Ha
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(13464003)(199004)(189003)(6246003)(4326008)(74316002)(55016002)(25786009)(54906003)(6436002)(186003)(26005)(305945005)(72206003)(99286004)(33656002)(53936002)(5660300001)(9686003)(53546011)(2171002)(7736002)(86362001)(6916009)(68736007)(6506007)(256004)(102836004)(316002)(446003)(97736004)(106356001)(3846002)(6116002)(14454004)(229853002)(81156014)(76176011)(2906002)(81166006)(105586002)(11346002)(478600001)(66066001)(8676002)(476003)(8936002)(486006)(7696005)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3382;H:BYAPR12MB3016.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 3cd9defc-81cb-42e1-eadf-08d66b0c4107
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3382;
x-ms-traffictypediagnostic: BYAPR12MB3382:
x-microsoft-antispam-prvs: <BYAPR12MB338278B88091B131950466DBECB50@BYAPR12MB3382.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR12MB3382;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB3382;
x-forefront-prvs: 0898A6E028
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s4xqjMB9MsGRb3TK7Q6Lc90OG0jj3tDzP90h2p8cKLT7hOzYfZBYJTN+9CUyhiv30ZPlV30JvsuSJzLYbXJjAXJxbpcuPsv7ydayuhakWrc+eDRCrAWVWma/CMLhALqElUzTTzcL8s8b3kZUzqQPXBDVYINCCS+K2nt4OkcNzjT0oiN1B+p+EwokUgmsnNV3PypY0Dg+HVk6ykW0Aleo8UjFN5M0vfUKUX0bN1pnUlvJUFLBMaHhEyP/qWXJbzSmZxBkK+1ZIMnSTvr+RaD6IdLy2K0NKSnkUrW4Z0+VmqCmadZbA9Jx1315iao++ejf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd9defc-81cb-42e1-eadf-08d66b0c4107
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2018 08:29:29.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3382
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Kangjie Lu [mailto:kjlu@umn.edu]
> Sent: Wednesday, December 26, 2018 2:24 PM
> To: kjlu@umn.edu
> Cc: pakki001@umn.edu; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter
> <daniel@ffwll.ch>; Zhu, Rex <Rex.Zhu@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu,
> Feifei <Feifei.Xu@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Francis,
> David <David.Francis@amd.com>; amd-gfx@lists.freedesktop.org; dri-
> devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] gpu: drm: fix an improper check of
> amdgpu_bo_create_kernel
>=20
> adev->firmware.fw_buf being not NULL may not indicate kernel buffer is
> created successful. A better way is to check the status (return value)
> of it. The fix does so.

Actually, it is the same. If bo is created successfully, the amdgpu_bo obje=
ct will be created.
But using "ret" to align with other function should be better as the return=
 status.  Thanks.

Reviewed-by: Huang Rui <ray.huang@amd.com>

>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 7b33867036e7..ba3c1cfb2c35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -422,13 +422,19 @@ static int amdgpu_ucode_patch_jt(struct
> amdgpu_firmware_info *ucode,
>=20
>  int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
>  {
> +	int ret;
> +
>  	if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_DIRECT) {
> -		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size,
> PAGE_SIZE,
> -			amdgpu_sriov_vf(adev) ?
> AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
> -			&adev->firmware.fw_buf,
> -			&adev->firmware.fw_buf_mc,
> -			&adev->firmware.fw_buf_ptr);
> -		if (!adev->firmware.fw_buf) {
> +		ret =3D
> +			amdgpu_bo_create_kernel(adev,
> +			  adev->firmware.fw_size,
> +			  PAGE_SIZE,
> +			  amdgpu_sriov_vf(adev) ?
> AMDGPU_GEM_DOMAIN_VRAM :
> +				AMDGPU_GEM_DOMAIN_GTT,
> +			  &adev->firmware.fw_buf,
> +			  &adev->firmware.fw_buf_mc,
> +				&adev->firmware.fw_buf_ptr);
> +		if (ret) {
>  			dev_err(adev->dev, "failed to create kernel buffer
> for firmware.fw_buf\n");
>  			return -ENOMEM;
>  		} else if (amdgpu_sriov_vf(adev)) {
> --
> 2.17.2 (Apple Git-113)

