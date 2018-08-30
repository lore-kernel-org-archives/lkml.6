Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F04C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9482A20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="I1kVH3dX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9482A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeH3Va1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:30:27 -0400
Received: from mail-pu1apc01on0120.outbound.protection.outlook.com ([104.47.126.120]:46720
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726235AbeH3Va1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUYz4lCwT/fjBo8qZSI8hW0n9Sxwf0fFQ64Ru+HEgRk=;
 b=I1kVH3dXodsRbwceZyXDzcV03M+Hr+uSD/4sq6ywV04fPy3GHNxW1m9ukQuTNFu+WMhQhGmr0ZRUqmg8Q3TylbbYO5oYCwIbiMx4ebjnfHCrNM8YHgdM9EEUTQOy+QfnGkUzFb7RucD6AaoW9V0njof5uylvTfU4OMHfIonAOv8=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0201.APCP153.PROD.OUTLOOK.COM (10.170.190.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 17:27:08 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1%2]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 17:27:08 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'" 
        <driverdev-devel@linuxdriverproject.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Use raw_smp_processor_id() in
 vmbus_connect()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Use raw_smp_processor_id() in
 vmbus_connect()
Thread-Index: AdQ7H/34qAH7zeGBQLegJ1KnxB9zFAFWLlUAAAM1tsA=
Date:   Thu, 30 Aug 2018 17:27:08 +0000
Message-ID: <PU1P153MB016943FAF912D00D54F46493BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01694E53D6A6192A46EA3214BF370@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <MW2PR2101MB11138A251E48BC8C6B859BF1A0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB11138A251E48BC8C6B859BF1A0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-30T17:27:03.2043393Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a27f:df20:5d83:f0e3:72fb:2536]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0201;6:k6mtO2hvrd9iS0XTuLaWvPAB8PagpeR7SDIpqacrNyuHT5ltphgKTgSJiR19DfNFv+7IniYbfKrXf4MqVCyuxbmxqnBaew/342bx1pgdQqVPFex74z7u3pTQUqDnWH3T/TlUM4TKTRMuF4dAXd1tEh2ZO4BTkAeMqY3IiM/8dKCsiD+esZaASBFiv/hFqT8HTSYPjkSpSgAfqsVJ2jxoLDYXD1LqX8t6WpPE3EpsN9A6BgcVe8xJ1Stv1Fvo0BcRf2CwO00lBC/UD/5eUhrFhB32uYyTheWf4uOksucIuRmb1boHVmP75ZoidsRY5CCZrvw/3iMIYj5JQ0IDLR+9iiFqQR/wtmiSKaYLpY7QY0Rru56dEv/tstd3JV7NeIhyr8fbAWRnuv7VyJjDYVGqWnuyCfRb9eItp7aOxFC9NHHznLZMMhTBKeqnAXsbz27sWwOxqw7op0EU2+nNa5HBDw==;5:X7Ex5p20RyqItf3H6VFEAh4CYoJiBTaHkmeV5XxWNd8KYdO4pH9YfA1T+wAXRJhxZMEpGeSiQa5iZ+z+qkWXkKDfzDB7JW4Auw70Wxwxp5Ngn1F/JoBmfsNyH5G9oyvQI6ZqdFU9Tz2ww/35I/pGQStOJDvzfKefFTXktHCRtMs=;7:H1EKrXQn+hfW59tHodzYPNPZwSF/NhnqMNriauSKU7sACbWgRpHrkeDCq+9Apyq9D/Uq/wy/ErY2mN4vFJQu+Kjo7hHJ021Elei/JHW+eWa7uUZUh0y8H65ibiKYqDeZ9DjOL4wURUNc/cht2uMGPvpo+xbKZ7B7025YM6jccWDXzu0M5Hdw2W5pMHzRRdMRakWuNyOMZRn0Pvpjl2MZcIQskJxVioOc+SGi499wy0bz8tVocjh5HTg2XyciFrLz
x-ms-office365-filtering-correlation-id: 47be73ad-e922-405b-ed81-08d60e9dd06f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0201;
x-ms-traffictypediagnostic: PU1P153MB0201:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0201EB640C3B1871435A0B57BF080@PU1P153MB0201.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(21532816269658);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:PU1P153MB0201;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0201;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(136003)(346002)(396003)(189003)(199004)(5660300001)(6246003)(8676002)(81156014)(4326008)(74316002)(6436002)(1511001)(25786009)(478600001)(10290500003)(229853002)(14454004)(7736002)(33656002)(305945005)(6636002)(105586002)(68736007)(86362001)(76176011)(8936002)(8990500004)(81166006)(2906002)(2900100001)(6116002)(106356001)(86612001)(9686003)(5250100002)(476003)(316002)(11346002)(22452003)(486006)(6506007)(10090500001)(53936002)(102836004)(14444005)(99286004)(55016002)(7696005)(446003)(110136005)(97736004)(46003)(256004)(54906003)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0201;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: D4++xb8B4MejYlLk9g67F367MafAUYV7WMOCKkaQteABxqMRIyg/Z78pzBgbo87EQA3lElHPc0ftTF6IWUlboTK8+iheBCLCC2stS7LiYozMBYZwiL6mpzx3jyYTaSYg6di5NYyJXHxlj8HRk9lHzeN3r6SQiqZB65fq+xkJWi/lTnt33+LtBOTUofHYG9uDOd2YyQ/fLOyfOB1Nq2bFvsRQ5IdY4JGTq+X+BsVWukOBQM8jg3N4vhw0J7Whbc5X8f/AKlvYgrIHsStGVGBD/CLYaQ0TiOI+ewDZi/zEtvlSWQzt6JJNRxFd3gYTk/QtWE9vVOA2atqO55MhaiNk78QPnv7zPKebCzwibPrWYeM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47be73ad-e922-405b-ed81-08d60e9dd06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 17:27:08.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: KY Srinivasan
> Sent: Thursday, August 30, 2018 09:28
> ...
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> @@ -119,8 +119,9 @@ static int vmbus_negotiate_version(struct
> vmbus_channel_msginfo *msginfo,
>          */
>    if (version >=3D VERSION_WIN8_1) {
>        msg->target_vcpu =3D
> -            hv_cpu_number_to_vp_number(smp_processor_id());
> -       vmbus_connection.connect_cpu =3D smp_processor_id();

> +       hv_cpu_number_to_vp_number(get_cpu());
> +       vmbus_connection.connect_cpu =3D msg->target_vcpu;
> +       put_cpu();

While the warning " BUG: using smp_processor_id() in preemptible" can also
be avoided, the line=20
+	vmbus_connection.connect_cpu =3D msg->target_vcpu;
seems incorrect, as the "connect_cpu" should reflect Linux CPU numbering
rather than Hyper-V's vCPU numbering.

-- Dexuan
