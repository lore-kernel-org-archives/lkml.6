Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5502AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065D92147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UKkt1Hv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065D92147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeGMGHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:07:40 -0400
Received: from mail-pu1apc01on0132.outbound.protection.outlook.com ([104.47.126.132]:50752
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbeGMGHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6cOeKhEHhMjC3+6lU+viUI8Qg78qHA6tePh3tLvoh8=;
 b=UKkt1Hv5VZDX488+T2FCFIjM1ooFJ5zdLLA/feeo7piM0RHqHhsVzl9TklFcDip4dLIhZEgA3p6nAiCoP1VKoAkII+fmlelvPoIJ3BduA3JWDZ1g19H2fW4lmBoWOHbJJVQfcarQRgTyW77cYIhynm3NsVry0sqkA3b4VmGakKM=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0140.APCP153.PROD.OUTLOOK.COM (10.170.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.11; Fri, 13 Jul 2018 05:53:28 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::2438:e6b5:1ad6:30ff]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::2438:e6b5:1ad6:30ff%6]) with mapi id 15.20.0973.011; Fri, 13 Jul 2018
 05:53:28 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'" 
        <driverdev-devel@linuxdriverproject.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: [PATCH] Drivers: hv: vmbus: Reset the channel callback in
 vmbus_onoffer_rescind()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Reset the channel callback in
 vmbus_onoffer_rescind()
Thread-Index: AdQabZD2BvGNy8mQSA6EBi8Sb0y3RA==
Date:   Fri, 13 Jul 2018 05:53:27 +0000
Message-ID: <PU1P153MB0169A44E23292552EF7CD317BF580@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-13T05:53:25.2012762Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a27f:df20:c18:421:f0a5:1a31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0140;6:dvhN8VekdOVOw34nwXg7Y4P2HH9BW/y0FlV2n7e3m9dr8FtYYKZSLVoyU17QaoW/o6/qQLmKyXYIbuwe852ADGTCCRMreGwyVRF99FJufPF3nptuP5+ZitIi7uLGODN1QipiISHb+rviaR1ElI1jsQJxzLiqb0fMlLO67SqwN87XWqYXeZIqoAEYHq2h1m1/RWkmT5kSDsQl8cr5O0pvSVnAEz0i11OHkRKeRHRYp/GPHccPiYc3oku+kMGk6DjuwJ/X5aoFBbognnN4xvTBySp9PsvtjaWpZuk7OZG7yFy4FTtM/c4/eDDSCsiidu90jhqYUOaZYljLHUKsIJBU7ilMvWL1OFDrAYRQnyYa60CG+ERd2s4xdVDX7HidQ7QvYfndLVFv1E6gVRrFhej4kjbjcJ17iufeS47y2Aiu5QBW38sAI9NpOiH3OOFVt89g4E7ACWJOvr7CCulSbDlFPA==;5:G2LbTrrLejwWPVR85edSjjwfePV4R+SVpcOq7sNHpqchk2PkQ1xJcsY2dZf7x6khR4ZUub7KY+twzR3cDOqoqSbw9qqeR9SR1L0do9KJUXBuJDLpft3yfIegTCNhdyx4lyh8Zc3ZJ+Fa5uSgLPYrlh2PFmeUtOOAqaonCQGBCZg=;7:CiykxCSvcmP6kwteV/rVqlMRgbsZaNO9UGR/dRm0MF9VWmAJrNkZdap58JQ6e8PbwjLuGsFKYh7hNG5oTpMpL8Mm2T7ImNk7+cfQjRMbO9lqZFdWJ7LNcyytqAU3+5txeESq79kLvEUqKbSvCxriAJaFK/Gq2hcFFhExgtmNL3M+N3elWwRSWuGCvQSENYrsiPotbhx9NISMoMeOJK5nD/767O7XrMoUKqNLS4HTEMbrffKq80CGDeYQMSlA1JZi
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5db91512-a988-455c-3f31-08d5e884f4a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:PU1P153MB0140;
x-ms-traffictypediagnostic: PU1P153MB0140:
x-microsoft-antispam-prvs: <PU1P153MB01404711A40306B0EC6C813DBF580@PU1P153MB0140.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:PU1P153MB0140;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0140;
x-forefront-prvs: 07326CFBC4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(5250100002)(1857600001)(86612001)(476003)(14444005)(486006)(186003)(2900100001)(99286004)(8990500004)(110136005)(7696005)(102836004)(316002)(22452003)(54906003)(86362001)(575784001)(6506007)(2906002)(256004)(55016002)(9686003)(74316002)(33656002)(1511001)(7736002)(305945005)(105586002)(97736004)(106356001)(68736007)(10290500003)(10090500001)(53936002)(478600001)(81166006)(6436002)(8676002)(8936002)(81156014)(4326008)(6116002)(5660300001)(25786009)(14454004)(46003)(6636002)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0140;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Sz5mrYOgnpQyByd5tubfG1Gi9Z4zzDMG4v2Wh+iqR6MahyIoFYavoSZz01eJRlyvnNzL7wJ6uTlibLfh5G+m9V425iXVKkhfqsBbe7VSwqHxD9PGVl8Cp44YNx/AhCcSMyQZWMr3fdyfpSZ/8t5/AKeX4TtSvwmrSQOeFNbNo+NqddJsRtbQ+Y8IuJ4z+NsmWhgy1iXAJeAzlrM3HSQTHSCgkVQERRN5d5NBCjrVGptRavzDwUbOceKS9h5UBsxkQCNxkInqCNZ9K3ewo+BH3Be+zOUzrM9uZ+iZ9Oqjg79Ell65KzDbL5B21mGZrCvcpfiVXlFKK3xz5HNhvVyzpl/T1o4JkXmRvzwnTyjBPGI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db91512-a988-455c-3f31-08d5e884f4a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2018 05:53:27.6240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Before setting channel->rescind in vmbus_rescind_cleanup(), we should make
sure the channel callback won't run any more, otherwise a high-level
driver like pci_hyperv, which may be infinitely waiting for the host VSP's
response and notices the channel has been rescinded, can't safely give
up: e.g., in hv_pci_protocol_negotiation() -> wait_for_response(), it's
unsafe to exit from wait_for_response() and proceed with the on-stack
variable "comp_pkt" popped. The issue was originally spotted by
Michael Kelley <mikelley@microsoft.com>.

In vmbus_close_internal(), the patch also minimizes the range protected by
disabling/enabling channel->callback_event: we don't really need that for
the whole function.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel.c      | 40 ++++++++++++++++++++++++----------------
 drivers/hv/channel_mgmt.c |  6 ++++++
 include/linux/hyperv.h    |  2 ++
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index ba0a092..c394922 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -558,11 +558,8 @@ static void reset_channel_cb(void *arg)
 	channel->onchannel_callback =3D NULL;
 }
=20
-static int vmbus_close_internal(struct vmbus_channel *channel)
+void vmbus_reset_channel_cb(struct vmbus_channel *channel)
 {
-	struct vmbus_channel_close_channel *msg;
-	int ret;
-
 	/*
 	 * vmbus_on_event(), running in the per-channel tasklet, can race
 	 * with vmbus_close_internal() in the case of SMP guest, e.g., when
@@ -572,6 +569,29 @@ static int vmbus_close_internal(struct vmbus_channel *=
channel)
 	 */
 	tasklet_disable(&channel->callback_event);
=20
+	channel->sc_creation_callback =3D NULL;
+
+	/* Stop the callback asap */
+	if (channel->target_cpu !=3D get_cpu()) {
+		put_cpu();
+		smp_call_function_single(channel->target_cpu, reset_channel_cb,
+					 channel, true);
+	} else {
+		reset_channel_cb(channel);
+		put_cpu();
+	}
+
+	/* Re-enable tasklet for use on re-open */
+	tasklet_enable(&channel->callback_event);
+}
+
+static int vmbus_close_internal(struct vmbus_channel *channel)
+{
+	struct vmbus_channel_close_channel *msg;
+	int ret;
+
+	vmbus_reset_channel_cb(channel);
+
 	/*
 	 * In case a device driver's probe() fails (e.g.,
 	 * util_probe() -> vmbus_open() returns -ENOMEM) and the device is
@@ -585,16 +605,6 @@ static int vmbus_close_internal(struct vmbus_channel *=
channel)
 	}
=20
 	channel->state =3D CHANNEL_OPEN_STATE;
-	channel->sc_creation_callback =3D NULL;
-	/* Stop callback and cancel the timer asap */
-	if (channel->target_cpu !=3D get_cpu()) {
-		put_cpu();
-		smp_call_function_single(channel->target_cpu, reset_channel_cb,
-					 channel, true);
-	} else {
-		reset_channel_cb(channel);
-		put_cpu();
-	}
=20
 	/* Send a closing message */
=20
@@ -639,8 +649,6 @@ static int vmbus_close_internal(struct vmbus_channel *c=
hannel)
 		get_order(channel->ringbuffer_pagecount * PAGE_SIZE));
=20
 out:
-	/* re-enable tasklet for use on re-open */
-	tasklet_enable(&channel->callback_event);
 	return ret;
 }
=20
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index ecc2bd2..9536b93 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -895,6 +895,12 @@ static void vmbus_onoffer_rescind(struct vmbus_channel=
_message_header *hdr)
 	}
=20
 	/*
+	 * Before setting channel->rescind in vmbus_rescind_cleanup(), we
+	 * should make sure the channel callback is not running any more.
+	 */
+	vmbus_reset_channel_cb(channel);
+
+	/*
 	 * Now wait for offer handling to complete.
 	 */
 	vmbus_rescind_cleanup(channel);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 3a3012f..5389012 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1046,6 +1046,8 @@ extern int vmbus_establish_gpadl(struct vmbus_channel=
 *channel,
 extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
 				     u32 gpadl_handle);
=20
+void vmbus_reset_channel_cb(struct vmbus_channel *channel);
+
 extern int vmbus_recvpacket(struct vmbus_channel *channel,
 				  void *buffer,
 				  u32 bufferlen,
--=20
2.7.4

