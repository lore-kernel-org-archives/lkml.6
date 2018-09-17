Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03670ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B72214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AUk8BcLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B72214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbeIQI2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:01 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:22121
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729476AbeIQI17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPmwXFDy3ge+KebAwCDxAmnXN1pTRkAdPE4WiQ2xdq4=;
 b=AUk8BcLbMrMlv2n29BsXCmaHqPFz5Om9Ba37Fyrl3C1F3uQ8HVeDOxnvrgDGkzX9ChYz5hJkd7rdpNWqA7zKwKMpPCHXHcQ6NYSUg8UvfK2vNbDCnsKL0eH7arU5NBzZhJfBVOVaz/IoLuDmVjnNhXZO8pfD8qHPuj8IILS3anQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Eric Anholt <eric@anholt.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 106/136] drm/v3d: Take a lock across GPU
 scheduler job creation and queuing.
Thread-Topic: [PATCH AUTOSEL 4.18 106/136] drm/v3d: Take a lock across GPU
 scheduler job creation and queuing.
Thread-Index: AQHUTjK0CncCkZqjHEODQgX/S8k6XQ==
Date:   Mon, 17 Sep 2018 03:01:19 +0000
Message-ID: <20180917030006.245495-106-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:tiV5acyFp+QOve0YnD9aVv+6FWGOvIC0b9K3qQhhNrqsaXb8vmH73GG3+HElBuE/U3JeEhMKq3rmZpvXUnLZu2bLmm9D0gHF7tiE5txiZik6chSnUcbUl3YANr7wa7z/SSSNromnuHWnbE7JXFtrrVFMYvp9WG7IeAlzeLHhK1Grfu0cTdkCjXJpUI1PAxCJCihzHCSJQFB/ac+Ac6CENqa8c+q3N+NoZP2qJxMtWHtkgwzrBDuW/dvIyQrismPoDAK/rLbVh99P/VdrXSKKldfyXhGUcec+3ryE9Xixzo0LK5pXrkBO6recLFmKNYfooAhwepWHa6I+avilT8Hc7ROatH3gPvrbpyrReeEpUPvZCDtFJ03pJsyb6bUrI1WCDscb7O+Y+IOJgdEjhxgyOVgFs1aqb3hqZyFQAfFr4+iGysgsSFkZPHHIsyYmQKdlmmjdRsREqafYn/3Z8E6N7g==;5:8jM7gaV4wLzKZA1Wq/NHYicWDbBg7JsW+tNnC6doewJ/l92QveFjkrKHB6SEVOC/roQx+k7SU/QaH3bBx5TjvHK4yLaQ3b8FyGAYNTqAEm+anQ+9EjHraX+HhgyLAHDCpyI6j2RpCkHLnMiqKGIETOLx4tvZXPQmSgGbs38r4I0=;7:jRXhwJtSGKM+/P7QI/hKg5Qj6b+TJi19BlalqG5h08Fxh8V90iLuj8fSuvSnJAEsXG2r2t6jSszUpK7z1mrnGOsjgaU/1fLH50tI+X53F8t2iU61UiRO/PKorIEkluLa4ACQQY0r4yqyE2T73qpbpJ1HGS3KSi+KRFisvxjQwxwk+1AWDpwt87o1eh1vkoPsJjmwNRzW3fQilJVgI1cU6mZuYkidDQG3Raa8LIxMBYuROhtDZIQRulHLnc12jneE
x-ms-office365-filtering-correlation-id: 5807591f-e75f-4fbc-3ae1-08d61c4a0962
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB016845136DFE56F1C8127A2EFB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(966005)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(5024004)(6306002)(6512007)(2501003)(5250100002)(2900100001)(14444005)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: AGRbTvZYbcbs5qVgEV3NuN/TML6sqNbsyzaQhOLGUKP8VlCiPk9xyn7em/0K1hufJKHtlnIGGRwcUnqpY2k8kwPYPWUutG0Ko98z71spCj66QL+mbkSSoDUQswzT9xTqOAACKIuTLFdCqWJrZJmVRB/DuVN7luGRFYwHQHZZ/CTrZpkg+vizh8o5S7AwoY0jWnIWdrPfVx7+Joi6yi0Wdxr6+itHop/j0ZXJGxewpKk05XVhRUJhkDGRiNn48+Dr2SaogqsPJ0E42g45hr9SmmV94kgAwAMTteSiwsnq9X9i12gS8CckPnUbVJwIXjW9WyxcUl/i/LUTOFYl9Lt/SjCLZ+GNacLGYnV949VPUtU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5807591f-e75f-4fbc-3ae1-08d61c4a0962
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:19.0885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Anholt <eric@anholt.net>

[ Upstream commit 7122b68b8a9692dcc3acf89595f04c492872115f ]

Between creation and queueing of a job, you need to prevent any other
job from being created and queued.  Otherwise the scheduler's fences
may be signaled out of seqno order.

v2: move mutex unlock to the error label.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D =
V3.x+")
Link: https://patchwork.freedesktop.org/patch/msgid/20180606174851.12433-1-=
eric@anholt.net
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h | 5 +++++
 drivers/gpu/drm/v3d/v3d_gem.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index a043ac3aae98..26005abd9c5d 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -85,6 +85,11 @@ struct v3d_dev {
 	 */
 	struct mutex reset_lock;
=20
+	/* Lock taken when creating and pushing the GPU scheduler
+	 * jobs, to keep the sched-fence seqnos in order.
+	 */
+	struct mutex sched_lock;
+
 	struct {
 		u32 num_allocated;
 		u32 pages_allocated;
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index b513f9189caf..269fe16379c0 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -550,6 +550,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
=20
+	mutex_lock(&v3d->sched_lock);
 	if (exec->bin.start !=3D exec->bin.end) {
 		ret =3D drm_sched_job_init(&exec->bin.base,
 					 &v3d->queue[V3D_BIN].sched,
@@ -576,6 +577,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	kref_get(&exec->refcount); /* put by scheduler job completion */
 	drm_sched_entity_push_job(&exec->render.base,
 				  &v3d_priv->sched_entity[V3D_RENDER]);
+	mutex_unlock(&v3d->sched_lock);
=20
 	v3d_attach_object_fences(exec);
=20
@@ -594,6 +596,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	return 0;
=20
 fail_unreserve:
+	mutex_unlock(&v3d->sched_lock);
 	v3d_unlock_bo_reservations(dev, exec, &acquire_ctx);
 fail:
 	v3d_exec_put(exec);
@@ -615,6 +618,7 @@ v3d_gem_init(struct drm_device *dev)
 	spin_lock_init(&v3d->job_lock);
 	mutex_init(&v3d->bo_lock);
 	mutex_init(&v3d->reset_lock);
+	mutex_init(&v3d->sched_lock);
=20
 	/* Note: We don't allocate address 0.  Various bits of HW
 	 * treat 0 as special, such as the occlusion query counters
--=20
2.17.1
