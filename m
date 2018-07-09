Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2EFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D96208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="e701/q9x";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RbuIOcXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D96208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934155AbeGISFd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:05:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53162 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933703AbeGISFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:05:32 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69HxH91030505;
        Mon, 9 Jul 2018 11:04:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YfcKRVUof4/exrsnFKL39kI8arL0/pHZPGcoK+eURvY=;
 b=e701/q9xoYI0dHpbCifjaCsJu8bX9o6U2cdy+QL8aT5FO2rAvzZ6zcwgkrtcIaKzC4kS
 qHh+EEUJi3TDYl5f4LVgDgzUeBSr1fpy8CNVeQrKV5E6u3UgpTYBOWqntx0KawcggyJJ
 GxeiQX/KpXSSPveCIOi93Q2XHRe1e9GPSjY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k4a880hrq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 09 Jul 2018 11:04:45 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 9 Jul 2018 14:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfcKRVUof4/exrsnFKL39kI8arL0/pHZPGcoK+eURvY=;
 b=RbuIOcXEbR72EBzMdGd3FkJ4lBHNd/RhpLQglvZtjZUjcJRfsJuVcPn4/ICaNe9o3zmPegpOuZdXvnTRocaea9KMXHPTKkKrGuDjNETKq3LnFLfwLYbA244mezjK1LeYJHrQJZYD7uZpJSTStjUAs+wqg0Jh8ptM3uUs0x1WzMU=
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com (52.132.149.157) by
 MW2PR1501MB2073.namprd15.prod.outlook.com (52.132.150.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Mon, 9 Jul 2018 18:04:40 +0000
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::69f0:c85e:5fc:721e]) by MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::69f0:c85e:5fc:721e%4]) with mapi id 15.20.0930.022; Mon, 9 Jul 2018
 18:04:40 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Nick Terrell <terrelln@fb.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Kernel Team" <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Rene Rebe <rene@exactcode.com>,
        Adam Borowski <kilobyte@angband.pl>,
        "Julian Andres Klode" <julian.klode@canonical.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Thread-Topic: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
Thread-Index: AQHTwX4w5Tc/5RmZHUq3duJllyvimaSH2sIA
Date:   Mon, 9 Jul 2018 18:04:39 +0000
Message-ID: <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com>
References: <20180322012943.4145794-1-terrelln@fb.com>
In-Reply-To: <20180322012943.4145794-1-terrelln@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:ebd3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR1501MB2073;7:K5kOgimDMuxeYy+WgaiUBBAuoSPMfQHEyPV00UaDSY4Oqh5qUPdPXiYkbtjnmSlJytUbTS8w22bFvNr34kSiV2bg6ukKV5kNR2VG8pEWztHMrfz2meg/+p/roWm51ioMdvx0wCKlyM1rSqxXgDSyb5cuid8ye/HybYi2JoTX7SDh5RKcNbJk9scsWC6aMsLdP26+irpY3b1V1+fTQS5hcg1+zwuDArv6XZagS6EArSl/HE6qe4SAZ0VgtdUQcmtl;20:IUJQ5PsQp4HFEfgvj7xXufX2zrqKaAcz/YIXNujkHPEk6VfPi4LXHjuVb6/5KEhxAwBRB1/aCDJMN2Wc+O0BddYA6U5PhUOB6TB0zbrQUYVfE1lGOs1YuN+lpdCO3oH50/J9loNBP9Oq8CgxC7tzINg2quP8bnQo7WDFy5WFtBI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: d179b026-7a94-42ad-d9e5-08d5e5c670ba
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:MW2PR1501MB2073;
x-ms-traffictypediagnostic: MW2PR1501MB2073:
x-microsoft-antispam-prvs: <MW2PR1501MB2073133EB1D37CEC84141170AB440@MW2PR1501MB2073.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR1501MB2073;BCL:0;PCL:0;RULEID:;SRVR:MW2PR1501MB2073;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(53754006)(189003)(199004)(102836004)(6512007)(46003)(36756003)(6436002)(11346002)(6200100001)(5250100002)(76176011)(6506007)(53546011)(83716003)(305945005)(476003)(4326008)(7736002)(2616005)(486006)(53936002)(446003)(82746002)(86362001)(6246003)(25786009)(6862004)(14454004)(106356001)(37006003)(6116002)(256004)(54906003)(8676002)(478600001)(8936002)(81156014)(81166006)(229853002)(6486002)(33656002)(68736007)(316002)(2906002)(105586002)(99286004)(2900100001)(97736004)(5660300001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR1501MB2073;H:MW2PR1501MB1993.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hjiBi1JzyD0UuwgBjWK1FgS6v45+Nx863/JPJ0IOliRC8IUihiLr4d/sqS4LN58MJWbwdj4rBkP+eB26QWKefbnGcPFOAaddXWTRq8hDrLQ+nVka3iGhrQslAdcXZGbZry2wlJIxl97PCfUruBr89tt7jQUg8qwFPUlZf/vN0U7khE8JsDPmxGV8W34J7sCuYOeuKTVSIXKP8C3+On1iFsfYTs6yqL7ChCQUWi61z8RggCvGJ92GTQF6DZrIPvymlDyUivD+YM9bZLNwwpuJg2lnNxd5Yri8ypKIYJPE65JyNNfnblTiKMzmBKZcM98pxNc8YcqRg+2phjHz64vOt5cjyB0pjLXpG8FYUifz8SI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2718B34592DCF94684AD0F36D69C5FF1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d179b026-7a94-42ad-d9e5-08d5e5c670ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 18:04:39.7690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2073
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mar 21, 2018, at 6:29 PM, Nick Terrell <terrelln@fb.com> wrote:
> This patch set adds support for a ZSTD-compressed kernel and ramdisk
> images in the kernel boot process. It only integrates the support with
> x86, though the first patch is generic to all architectures.

Hi all,

Is there anything blocking this from getting merged?
Please let me know if there is anything I can do to help move this patch fo=
rward.

Thanks,
Nick=
