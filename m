Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC4F217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="FGTHfUUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfB0QnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:43:23 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:46252 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbfB0QnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:43:23 -0500
X-Greylist: delayed 1961 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2019 11:43:21 EST
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RG5JCX016259;
        Wed, 27 Feb 2019 08:10:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=M+MdiuUnKvhbnDCBrpHamOnKuk0JEck9qrRnxgnAE5M=;
 b=FGTHfUUWwoKTvmcNs3i+qYDgdDL/7Dt0By8gIHEmMvSFcmc0rLGO2VlUYfTsPhFx5ueh
 VsNi78KMoc4ulOCGD2w8PNEGHoO8ARRrOQtQqcn8v7jOYYCtYQdH4NPMyh9xQJZJtgZ0
 OqZ0mIZN1hY6bBNyIRtSLSjYriOHXn92HVKYUy8T9Rs9ElHfLLIIXDfzM8PkgkdCBJWf
 lm/qEbcRXXn2G1vOyCQ5kGRrgixRsYRvCKe4LVlqLDqCp1LNjplGTmjapxkWPVkIqPfH
 OcF6dLOG8CWjEeJzm3VUD1nshB0cDBGoqiRLeQCwWk/RKnZSTpe3FMuKTQeXeg5UMtue TA== 
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2052.outbound.protection.outlook.com [104.47.41.52])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2qu55nf8e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Feb 2019 08:10:37 -0800
Received: from DM5PR02MB2650.namprd02.prod.outlook.com (10.168.196.16) by
 DM5PR02MB2890.namprd02.prod.outlook.com (10.175.86.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Wed, 27 Feb 2019 16:10:35 +0000
Received: from DM5PR02MB2650.namprd02.prod.outlook.com
 ([fe80::ed96:4b4b:be07:2718]) by DM5PR02MB2650.namprd02.prod.outlook.com
 ([fe80::ed96:4b4b:be07:2718%4]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 16:10:35 +0000
From:   Felipe Franciosi <felipe@nutanix.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Franciosi <felipe@nutanix.com>
Subject: [PATCH] scsi: virtio_scsi: don't send sc payload with tmfs
Thread-Topic: [PATCH] scsi: virtio_scsi: don't send sc payload with tmfs
Thread-Index: AQHUzrb4/YuhwjVx0EiUmJ2BDa/6dA==
Date:   Wed, 27 Feb 2019 16:10:34 +0000
Message-ID: <1550403730-27876-1-git-send-email-felipe@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:40::42) To DM5PR02MB2650.namprd02.prod.outlook.com
 (2603:10b6:3:41::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.5
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e0e2f65-c0df-486c-17ef-08d69cce1ad7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR02MB2890;
x-ms-traffictypediagnostic: DM5PR02MB2890:
x-proofpoint-crosstenant: true
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtETTVQUjAyTUIyODkwOzIzOnNwSktMSnhKdm9ibU15NUxKSlJJUll3TEdw?=
 =?utf-8?B?MStGN0sxbGRLUkZKWmVOcGFERWhXWC9zNjNMcWFiaHY0KzB4RHFSdTZMTjlv?=
 =?utf-8?B?SnFTVkZCZDA0V2x3SUNFK2k2VnRkSFl5Vkt0VmZrOUFlYXBBcUNoN1JURFBx?=
 =?utf-8?B?NnFmNlo4bzJicXhBVWVqSG1ZUmRZUzNpdExEREl0aFlzTTZkdmtXU3IyOVJk?=
 =?utf-8?B?bmRVeFpLK2pKNXJkNlI5OHZwSE1TN2xMTlcyMy9IcDBCa2U1ZzhMR3pUa3Ja?=
 =?utf-8?B?MnVzdVl5cHdLYmRYczhLNFZZZkhRRnBBeDFRams0ZWNCYlVCaTJQd0lHWGtk?=
 =?utf-8?B?MUZHZUpRY0crMFdzVE5YSS9qaTRjK2FJWWlvQU1rU0FFb2xnNTlaVzZjWC93?=
 =?utf-8?B?VS80K24xSUNjdXRic2lON0hQbFRINkJxMUhlOEwvcWx3Q0p3Tk5FV3U4d1kr?=
 =?utf-8?B?ZXk0OGFnTThjYW44VGFPOVYyeUFVT01hN1Q4VWxuVExFSm91Vjc0N3FYUHBr?=
 =?utf-8?B?M1MwbjVXVDhoRmNnckRoTEcxS21qckZlM3UxdVRLalVYWVlKUjczL1p2NXhu?=
 =?utf-8?B?MFNlVVFodXQ0cHVYYmE5YXRvQWVCZlA4cks2dmV5bnZNYkhUSE5ReDByRXc4?=
 =?utf-8?B?UGNDTnVjM004OTRSN1R1VmY4Y1owVi8remQwTjByOG5BSGZNVzJhOWhkQ1dX?=
 =?utf-8?B?bU80TjY1OUxXOUV2OHZjRUJLQi9vL3haU0x2V09PL2ttTFB6OTFJWUIwZDBs?=
 =?utf-8?B?NUg0YmJ0dk9GUlZQbWFIY3FYaFhXTWk4TW5yT0hOeWZZMXAvbGpEMldoaXdQ?=
 =?utf-8?B?WTA0bGhCK1FWNlhsVzhWVVh3dU1uRWV0S0pySzJXRzB2Nk9WMlVRVTV1V2k2?=
 =?utf-8?B?RXBLaUZnUTBuRS9ieHVZM29jY09WaWhwYzdkcjFtQ0ZVZnpjcW0yMXc2eVY3?=
 =?utf-8?B?blM3ZjV0RWZOVWMvNDRqeGlLdVd6WkxIMUZnYnFveGFaVjhpbmxZemlsNHNh?=
 =?utf-8?B?QnZ5OHh3Wllhd040aXViTCt0VklNblA2UWJjeXRyYzhTWGJmNzhIYXFxQ2VR?=
 =?utf-8?B?ODJPQ2tkYWV3SXJ6OElpOWUyTDQvVUwva3dHZmFiRCtzZmVmaUdybHRlV0to?=
 =?utf-8?B?VFM4c2UrMFJ1Q2FJbDBGSmp0K2RZTVpaVjJkTDZiRzRTNlc0dmJHelBrNWlW?=
 =?utf-8?B?UlRwcTB4MHkvRmp3QjhDTDF6ZHVlQVF4dUlJQnNCb2lVTzl5TXd5MWdRTjAr?=
 =?utf-8?B?eGl0U2RqVTZSb0VVNXNrZWxDSUovUGFmcUFmQmt2bVZoWVFCYWpjeWRaQXBI?=
 =?utf-8?B?Q2pyZTNyanU0N0dkdHdieFJOOE4zbFlmVUFWaWtkb1pMeGt2elNQSzNFRmhs?=
 =?utf-8?B?SHhjQUg3YnB4S3lEUENqNWdjUVRyZ0x1VDFFSy94K05pV0JsakFJQkQ4SmZy?=
 =?utf-8?B?QnBBUEZJb3owZXZDMlROekhDblN3QnVmSHBYb2cvMGdUaC8xbktveWg2Ritv?=
 =?utf-8?B?VHl0YTRxWmVuQlB3d0lKUDRJVlFnNU9JQitoandZbGp1a3drU1d3WlMrZ0Ex?=
 =?utf-8?Q?+FVIrGXL0nAxktdTUKvSvmTJqEjl7m58Uyy3uCVAPsjM=3D?=
x-microsoft-antispam-prvs: <DM5PR02MB2890DFFC9C362528CCDE6063D7740@DM5PR02MB2890.namprd02.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(106356001)(105586002)(386003)(8936002)(102836004)(50226002)(53936002)(26005)(36756003)(6486002)(68736007)(305945005)(8676002)(2906002)(81166006)(186003)(6506007)(256004)(14454004)(97736004)(486006)(86362001)(6512007)(2616005)(476003)(6436002)(7736002)(81156014)(478600001)(66066001)(316002)(5660300002)(54906003)(4326008)(110136005)(3846002)(6116002)(71190400001)(25786009)(71200400001)(52116002)(107886003)(99286004)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR02MB2890;H:DM5PR02MB2650.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WkQYF7X69jjOkxXD04O/EaiwxdEkCxL5mG1cbdxy5GvubsvS3jmvyaEzx3SXlXYwd/95z4wc7bZ0mW0cNtjc/rPhnohb7czl/8nLruTMUJs8VKiyMEvXg2Z/0l7RxQkU/G3Ld95+E5zKZdXG3YOq8gPnFBd8rt+wTwLXhGveHxEn+xVpQMvf4p0uyOmwXLSyxS+TgvSqz0nZhUbusaS901lDEAyrGaWuUcbDnvd2I4tqizNN+YM4OCP6cgtBive6YcM7jgtFI5pqgeLqUlBatlhRx6ElentRq8eUcDHVm9kvXu1XUMK5w7SnSabHgXn+YnbqFJC9+dkMEhjuxT8LYj89YkoaE65rHEOFjEHHlGq/Z1pHG7U+4Er2IY8J4+GqNZZfcXVRohV1DxvYSaQg2w0WWBxeInlDKFKWcbuex9E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0e2f65-c0df-486c-17ef-08d69cce1ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 16:10:33.3352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2890
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHZpcnRpbyBzY3NpIHNwZWMgZGVmaW5lcyBzdHJ1Y3QgdmlydGlvX3Njc2lfY3RybF90bWYg
YXMgYSBzZXQgb2YNCmRldmljZS1yZWFkYWJsZSByZWNvcmRzIGFuZCBhIHNpbmdsZSBkZXZpY2Ut
d3JpdGFibGUgcmVzcG9uc2UgZW50cnk6DQoNCiAgICBzdHJ1Y3QgdmlydGlvX3Njc2lfY3RybF90
bWYNCiAgICB7DQogICAgICAgIC8vIERldmljZS1yZWFkYWJsZSBwYXJ0DQogICAgICAgIGxlMzIg
dHlwZTsNCiAgICAgICAgbGUzMiBzdWJ0eXBlOw0KICAgICAgICB1OCBsdW5bOF07DQogICAgICAg
IGxlNjQgaWQ7DQogICAgICAgIC8vIERldmljZS13cml0YWJsZSBwYXJ0DQogICAgICAgIHU4IHJl
c3BvbnNlOw0KICAgIH0NCg0KVGhlIGFib3ZlIHNob3VsZCBiZSBvcmdhbmlzZWQgYXMgdHdvIGRl
c2NyaXB0b3IgZW50cmllcyAob3IgcG90ZW50aWFsbHkNCm1vcmUgaWYgdXNpbmcgVklSVElPX0Zf
QU5ZX0xBWU9VVCksIGJ1dCB3aXRob3V0IGFueSBleHRyYSBkYXRhIGFmdGVyDQoibGU2NCBpZCIg
b3IgYWZ0ZXIgInU4IHJlc3BvbnNlIi4NCg0KVGhlIExpbnV4IGRyaXZlciBkb2Vzbid0IHJlc3Bl
Y3QgdGhhdCwgd2l0aCB2aXJ0c2NzaV9hYm9ydCgpIGFuZA0KdmlydHNjc2lfZGV2aWNlX3Jlc2V0
KCkgc2V0dGluZyBjbWQtPnNjIGJlZm9yZSBjYWxsaW5nIHZpcnRzY3NpX3RtZigpLg0KSXQgcmVz
dWx0cyBpbiB0aGUgb3JpZ2luYWwgc2NzaSBjb21tYW5kIHBheWxvYWQgKG9yIHdyaXRhYmxlIGJ1
ZmZlcnMpDQphZGRlZCB0byB0aGUgdG1mLg0KDQpUaGlzIGZpeGVzIHRoZSBwcm9ibGVtIGJ5IGxl
YXZpbmcgY21kLT5zYyB6ZXJvZWQgb3V0LCB3aGljaCBtYWtlcw0KdmlydHNjc2lfa2lja19jbWQo
KSBhZGQgdGhlIHRtZiB0byB0aGUgY29udHJvbCB2cSB3aXRob3V0IGFueSBwYXlsb2FkLg0KDQpT
aWduZWQtb2ZmLWJ5OiBGZWxpcGUgRnJhbmNpb3NpIDxmZWxpcGVAbnV0YW5peC5jb20+DQotLS0N
CiBkcml2ZXJzL3Njc2kvdmlydGlvX3Njc2kuYyB8IDIgLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS92aXJ0aW9fc2NzaS5jIGIv
ZHJpdmVycy9zY3NpL3ZpcnRpb19zY3NpLmMNCmluZGV4IDc3MmI5NzYuLjQ2NGNiYTUgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3Njc2kvdmlydGlvX3Njc2kuYw0KKysrIGIvZHJpdmVycy9zY3NpL3Zp
cnRpb19zY3NpLmMNCkBAIC01OTQsNyArNTk0LDYgQEAgc3RhdGljIGludCB2aXJ0c2NzaV9kZXZp
Y2VfcmVzZXQoc3RydWN0IHNjc2lfY21uZCAqc2MpDQogCQlyZXR1cm4gRkFJTEVEOw0KIA0KIAlt
ZW1zZXQoY21kLCAwLCBzaXplb2YoKmNtZCkpOw0KLQljbWQtPnNjID0gc2M7DQogCWNtZC0+cmVx
LnRtZiA9IChzdHJ1Y3QgdmlydGlvX3Njc2lfY3RybF90bWZfcmVxKXsNCiAJCS50eXBlID0gVklS
VElPX1NDU0lfVF9UTUYsDQogCQkuc3VidHlwZSA9IGNwdV90b192aXJ0aW8zMih2c2NzaS0+dmRl
diwNCkBAIC02NTMsNyArNjUyLDYgQEAgc3RhdGljIGludCB2aXJ0c2NzaV9hYm9ydChzdHJ1Y3Qg
c2NzaV9jbW5kICpzYykNCiAJCXJldHVybiBGQUlMRUQ7DQogDQogCW1lbXNldChjbWQsIDAsIHNp
emVvZigqY21kKSk7DQotCWNtZC0+c2MgPSBzYzsNCiAJY21kLT5yZXEudG1mID0gKHN0cnVjdCB2
aXJ0aW9fc2NzaV9jdHJsX3RtZl9yZXEpew0KIAkJLnR5cGUgPSBWSVJUSU9fU0NTSV9UX1RNRiwN
CiAJCS5zdWJ0eXBlID0gVklSVElPX1NDU0lfVF9UTUZfQUJPUlRfVEFTSywNCi0tIA0KMS45LjUN
Cg0K
