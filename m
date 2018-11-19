Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15BCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455542086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0DbZVIFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455542086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeKTGKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:10:25 -0500
Received: from mail-eopbgr700079.outbound.protection.outlook.com ([40.107.70.79]:63712
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbeKTGKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs0NvFcUJxnHUvsqBpDe00I6FfdfD4FknGEFh4wDtZw=;
 b=0DbZVIFlv50Lcpv8CRz+f286BnQGIkali5/XTuiGU8/S3RNrR3fuptQYpvE12iawXWw20L40d9OlaAatmjP/xiw4xSzGyW+4uYmkYZ3qqvc3W8wAbAtTjy4dpBkPaZqIGP5p3daJqDyRzKZOQNAxY56+prEP2BDi1TXmio39Kkk=
Received: from BY1PR12MB0406.namprd12.prod.outlook.com (10.162.146.27) by
 BY1PR12MB0469.namprd12.prod.outlook.com (10.162.147.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Mon, 19 Nov 2018 19:45:16 +0000
Received: from BY1PR12MB0406.namprd12.prod.outlook.com
 ([fe80::94cb:cedf:281:79f2]) by BY1PR12MB0406.namprd12.prod.outlook.com
 ([fe80::94cb:cedf:281:79f2%6]) with mapi id 15.20.1339.026; Mon, 19 Nov 2018
 19:44:55 +0000
From:   "Zuo, Jerry" <Jerry.Zuo@amd.com>
To:     Lyude Paul <lyude@redhat.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Li, Roman" <Roman.Li@amd.com>, "Cheng, Tony" <Tony.Cheng@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "S, Shirish" <Shirish.S@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] drm/amd/dm: Understand why attaching path/tile
 properties are needed
Thread-Topic: [PATCH 2/2] drm/amd/dm: Understand why attaching path/tile
 properties are needed
Thread-Index: AQHUfgOYyVVCIfDxYkK68ANZTiJrdKVXgzAQ
Date:   Mon, 19 Nov 2018 19:44:55 +0000
Message-ID: <BY1PR12MB0406A41977791358BD0C0C0DE5D80@BY1PR12MB0406.namprd12.prod.outlook.com>
References: <20181116232443.1709-1-lyude@redhat.com>
 <20181116232443.1709-3-lyude@redhat.com>
In-Reply-To: <20181116232443.1709-3-lyude@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerry.Zuo@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR12MB0469;20:f6ZtcW9i12vxo+AYpDkJWtV9Lngt4rV6CAq0eZKVLTzaeCtIoy+vXi7v+6DBAuQyFJbNqRvZnWLI2D62OWgccFKMYKQ+X8wwHTb+5OFhYA6jWnAAEkMGTkFVIU0bda4Kr+wzngmgLe9WgyuoAch4WOi6XPmdrCO4yMZLsq9dDLliDUUeMVqU3M+J5hlFDphu3UHF8VBm3Y8XDCSY4yagJ/bZ47dNm8n1ivu3Nns0Gm78o+5Izx+ysU09hyLn+6eH
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(13464003)(199004)(189003)(53936002)(71200400001)(575784001)(99286004)(71190400001)(4326008)(25786009)(6246003)(54906003)(3846002)(110136005)(6116002)(486006)(11346002)(68736007)(305945005)(2906002)(476003)(446003)(9686003)(86362001)(66066001)(55016002)(7736002)(316002)(5024004)(74316002)(256004)(72206003)(6436002)(186003)(105586002)(106356001)(478600001)(5660300001)(14454004)(26005)(7696005)(76176011)(2501003)(53546011)(2900100001)(229853002)(6506007)(81166006)(8676002)(81156014)(97736004)(102836004)(8936002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR12MB0469;H:BY1PR12MB0406.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 9aadaf73-76e7-4c62-a35c-08d64e577b23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY1PR12MB0469;
x-ms-traffictypediagnostic: BY1PR12MB0469:
x-microsoft-antispam-prvs: <BY1PR12MB046992F1FA3448C114FB7946E5D80@BY1PR12MB0469.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231415)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY1PR12MB0469;BCL:0;PCL:0;RULEID:;SRVR:BY1PR12MB0469;
x-forefront-prvs: 08617F610C
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TZN6AfIIiCswPEPgNdD5xTzzDhuM23U+HJaXb24kVk+kFKGJAz3H8YqBBsADkuPDlxbezC76+vcQVsxJcHQ19MZJiEdnLj4F5ksj/uG8PmzvKXgg78LjJXoQftL6acECX6+Xk7GHvmMrk/5NnDei0t9+H+1R4tgfGfkRMf4+04lxBS1tMoAP87m4ajOmimHnNs1aQGvnIZg08V/2JVIyc1IprPvSaW53yKR/fTIAS5AydBS92FNHScqSGWFUFyO/d59ZA8ORw6OxInL3ytZg8kWnYgYEf5WOmKx3RADC7SXMdjcU7h6rJdfttx7fYgk3d6RPI3/beMws/gv85BaRUZRPT/9RIevraGlvfXueyGM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aadaf73-76e7-4c62-a35c-08d64e577b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 19:44:55.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Lyude Paul <lyude@redhat.com>=20
Sent: November 16, 2018 6:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christi=
an <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>;=
 David Airlie <airlied@linux.ie>; Zuo, Jerry <Jerry.Zuo@amd.com>; Li, Roman=
 <Roman.Li@amd.com>; Cheng, Tony <Tony.Cheng@amd.com>; Daniel Vetter <danie=
l.vetter@ffwll.ch>; S, Shirish <Shirish.S@amd.com>; dri-devel@lists.freedes=
ktop.org; linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/dm: Understand why attaching path/tile propert=
ies are needed

Path property is used for userspace to know what MST connector goes to what=
 actual DRM DisplayPort connector, the tiling property is for tiling config=
urations. Not sure what else there is to figure out.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 0cca1809fdcd..1b0d209d8367 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -345,9 +345,6 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr =
*mgr,
 	drm_connector_attach_encoder(&aconnector->base,
 				     &aconnector->mst_encoder->base);
=20
-	/*
-	 * TODO: understand why this one is needed
-	 */
 	drm_object_attach_property(
 		&connector->base,
 		dev->mode_config.path_property,
--
2.19.1

