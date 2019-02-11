Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B8FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA3F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FjbmmeA+";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="F9D6UkVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfBKMV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:21:28 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36298 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726881AbfBKMV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:21:27 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BCID9R020414;
        Mon, 11 Feb 2019 04:21:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=9WBTWYqm4GoGLeNzV7/kFTAc3mmW/GW3lpx6Yy+KI/s=;
 b=FjbmmeA+CnMTljFzd6n/MbXqQgVDPSazubr7ZRBeFKmVcnQquS3iiBdo/4VhJQovskGR
 H6Dp0stwjVzud718fS67x7v6LwgxdyG3icjHT8sTV3SjW94n4U7kathnyIE37+HOcV38
 6SNGR8WpOFRLXApPQ/zNA04bs1ozBDBj8TPh9BXB2us2s3t85XuDKEYSh1CtQCxkx6gU
 xCr4ZDTPBFgtZB3Y9hShjMsIqxoIIWioPk2BG2iMj96YAcvwSairb254g+AQ17pPLLb1
 psRs0td8ZR+TAg4JYHkwa0GfS3SZYMDgCGMZE3HBzpqtFyTO0BLEEnIdFjfYeBFykTrR /w== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qk4mu8wmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 04:21:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WBTWYqm4GoGLeNzV7/kFTAc3mmW/GW3lpx6Yy+KI/s=;
 b=F9D6UkVQrFl8yozNAk1ZNv1P5ipL9ZyR7QwA9L+o7XNzQIcAfC/XTjQrJjR4cW61zyAWEmWtu4amk+O+p8ilO/mqGL5UJKacfKo7rnFdXx5cedaqQpn1E7w78NtY+teAQgVic4lvlRBWUOXMEe75/8g7VZsHJV4+vPr9LHVmSGo=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB6072.namprd07.prod.outlook.com (20.179.93.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Mon, 11 Feb 2019 12:21:01 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::c87c:4924:afa4:733a%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 12:21:01 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v3 4/6] usb:common Simplify usb_decode_get_set_descriptor
 function.
Thread-Topic: [PATCH v3 4/6] usb:common Simplify usb_decode_get_set_descriptor
 function.
Thread-Index: AQHUuVupGeuRRI9hYE2NIVnt7tBXh6XPjBQAgAsJYIA=
Date:   Mon, 11 Feb 2019 12:21:01 +0000
Message-ID: <BYAPR07MB4709A3ACFDC56A1B7B145A68DD640@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-5-git-send-email-pawell@cadence.com>
 <20190204114726.GC28608@kroah.com>
In-Reply-To: <20190204114726.GC28608@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctN2M5MjllMjEtMmRmNy0xMWU5LTg3MmUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDdjOTI5ZTIzLTJkZjctMTFlOS04NzJlLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNDE2IiB0PSIxMzE5NDM2MTI1OTM1NjExMzEiIGg9Ik5sQ1lvNDAxYkhPUzNWSlhYNHliTDNrRHV3bz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB6072;20:/vIvojI42ni/h0c9PEChFtp/CioowIEfBZ6JLQiL3+EbSf5cDYoZ9XokYlD8VDbrPYYYhR2C0cU2pUtehxgM7xefg0tYnxUNY4T5GUeCexCx7eMgbO0ppESJhQ5DAw5n+YvyZY5RhMG3/jZCggoXh2Hm/KkQd4M4Ah5285qfhQq89Pm3o2yJ2HvYYUNKTvoXKt2dW3QLPQo1IAWllvjc7qDmSnLe22s3qC1Q3kyRp01/A2wzVaLYVENpEce2oiWa
x-ms-office365-filtering-correlation-id: ee94a991-4b3d-4832-6add-08d6901b62eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB6072;
x-ms-traffictypediagnostic: BYAPR07MB6072:
x-microsoft-antispam-prvs: <BYAPR07MB6072BF395246268C35239B6FDD640@BYAPR07MB6072.namprd07.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(36092001)(189003)(26005)(305945005)(74316002)(66066001)(9686003)(6436002)(558084003)(229853002)(7736002)(71200400001)(102836004)(256004)(76176011)(7696005)(8676002)(25786009)(81166006)(81156014)(6506007)(4326008)(186003)(99286004)(107886003)(11346002)(86362001)(6246003)(106356001)(97736004)(2906002)(446003)(8936002)(476003)(7416002)(105586002)(316002)(53936002)(55016002)(486006)(3846002)(33656002)(6116002)(6916009)(14454004)(478600001)(68736007)(71190400001)(54906003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6072;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LGlxwDgoM5wXAsw+EOBSAx3aarsSzK9PzvWL1pHb+3YTwhsgGzjNta7Qj/SmKcM7j3sSI62rTNNtGKKQyKoEubJdnYBSe+nNPkmsMMCuPb9PKET+kpOmqejH3tIcjoT7hnY6/mAQ35jmKDb0SDZDPyuvTF900bxBpDsVw8ivhIcJJ00U0BQPFKiynmcexmHDJ1dsx1OfGsfg5tfTCVl7eYFc8bQd0yyt/Pwk93guwpT9gvQHlRYouj+MzOcDVAb0GHfjGJRpilgVPcwNodbzNPAiQRUHCxobKj93STZuqcNBTNliawzwejlP1fhl/bcfvgZW9V7zxbOKNfVFeLu5ZytIkvKmkZ6KpRt5GcaRxVOuQ+u/+zUQNxwnZ2e01Vl9ejBq9tTwVwomglLRaWTloOx+FiXgaxOQe2A8qzEtKOM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee94a991-4b3d-4832-6add-08d6901b62eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 12:21:01.5764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6072
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=513 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Jan 31, 2019 at 11:52:31AM +0000, Pawel Laszczak wrote:
>> Patch moves switch responsible for decoding descriptor type
>> outside snprintf. It's little improves code readability.
>
>Should that last sentence read: "It improves code readability a little"?
>
Yes, it should.=20
Thanks=20

Pawel
