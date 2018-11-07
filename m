Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2C1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD9420818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IM5VNyR0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="E2xGWc0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD9420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeKHFhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:37:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbeKHFhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:37:06 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA7K4xc5027776;
        Wed, 7 Nov 2018 12:05:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=fqvS7NtsxJFm5xfS5H0lRXf0c6B5f0iPJsj8130O+p4=;
 b=IM5VNyR0cBWG+gQkH8uNxvw2Zjn/pLdJ3mRu+TXFgQfmneNqp07FhAPZa1mtneH4uF1w
 WTqvafMibntwaJsgjR7UJ8fFmAh0WQGgnrcYI5CFA3wq4uS8L2tOXn4pIx+Phh+W4vKs
 g2V1fLVqKT1Ng2I0VFWJ2BL5nj5t13OOljQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nm5d6ga9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Nov 2018 12:05:00 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 7 Nov 2018 12:04:59 -0800
Received: from PRN-CHUB11.TheFacebook.com (2620:10d:c081:35::20) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Wed, 7 Nov 2018 12:04:59 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 7 Nov 2018 12:04:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqvS7NtsxJFm5xfS5H0lRXf0c6B5f0iPJsj8130O+p4=;
 b=E2xGWc0H35tnGItujeHRSBfD9M2Lu/FjrHa8Cv/aTn+9EosyWpNZOUwECK/FhsoQzWX5oY9HHUSbLKFJ0MoEwGLvutEOhJc1Ar1TI0ne40Czh8x1b7VXEj/J6pqbk2uHNbtaChaxDSUdkOEEwo6PUjGjVz0cIiNwAw3W0eXXPGk=
Received: from CY4PR15MB1463.namprd15.prod.outlook.com (10.172.161.20) by
 CY4PR15MB1672.namprd15.prod.outlook.com (10.175.120.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.32; Wed, 7 Nov 2018 20:04:58 +0000
Received: from CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::89c4:c15d:7a24:b9e2]) by CY4PR15MB1463.namprd15.prod.outlook.com
 ([fe80::89c4:c15d:7a24:b9e2%3]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 20:04:58 +0000
From:   Jens Axboe <axboe@fb.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
CC:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] block: respect virtual boundary mask in bvecs
Thread-Topic: [PATCH v2] block: respect virtual boundary mask in bvecs
Thread-Index: AQHUdqHz9/xlIwSBikG/w8X19B8jBKVEvQMA
Date:   Wed, 7 Nov 2018 20:04:58 +0000
Message-ID: <b557400b-4ef9-481f-ac0b-b80545e84a2f@fb.com>
References: <20181107135814.15727-1-jthumshirn@suse.de>
In-Reply-To: <20181107135814.15727-1-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:4:ae::36) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fe::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:ed44]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1672;20:D0eCVckpukBitvRAOC/+9tdZN58pjJS+3TmUdULzBLf/4A9ofNxctFA1ONjq1YbyNKJDzMCA7I3TLgu84SWd23RQo2N/6k39EIunnzlpA66GOz8IJ9F7xvDE0gASqGFKfIQAQknoxmrfzeuWpnP/5pCHroT1wuPGsHoscMTc6oY=
x-ms-office365-filtering-correlation-id: c458cd40-a82f-4730-695e-08d644ec4aa9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1672;
x-ms-traffictypediagnostic: CY4PR15MB1672:
x-microsoft-antispam-prvs: <CY4PR15MB1672EE394D2569D2664C1856C0C40@CY4PR15MB1672.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR15MB1672;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1672;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(8676002)(102836004)(478600001)(99286004)(4326008)(31686004)(8936002)(2900100001)(25786009)(7736002)(2906002)(76176011)(6506007)(305945005)(71190400001)(386003)(5660300001)(97736004)(6916009)(71200400001)(6116002)(81166006)(81156014)(14454004)(52116002)(186003)(2616005)(476003)(446003)(486006)(11346002)(68736007)(6246003)(53546011)(14444005)(106356001)(46003)(36756003)(105586002)(6486002)(6436002)(229853002)(256004)(6512007)(31696002)(53936002)(54906003)(86362001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1672;H:CY4PR15MB1463.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NC/SBQabeJGuDAD5HKfsLOAuZxwabd9C3wZjbpiitFJoxc8vg1jvIsI8RPW2rourTfizp1FA1FfYPFHJgK8jjWFViCGK07HygnlMeP/wewfWmpOiDpMWS63WrqzUCofKUlXhK1xxpfaAnenurIt2E6g1yHvS7pUdEOUHmUmzSSZyxl40l63tC+dnBdQGADwibtBhR7wfIaVPhgQucv5lExMo+olebqEwyQxZ8qdjIEYsmTN80GM/lpX+mln15ZbvSFkCPGiSDAOLfTsSPrFW4dajgjMh0de3Z8CxXw7uFXOAGdSVFjYgHhYqLlQIn6obYNN7s7ugUuXSwOVUQKosrZicLk3PDYiEmlb9yZU7OBM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D8E629754CC8A43ACEDD122F4D94BF5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c458cd40-a82f-4730-695e-08d644ec4aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 20:04:58.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1672
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNy8xOCA2OjU4IEFNLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+IFdpdGggZHJp
dmVycyB0aGF0IGFyZSBzZXR0dGluZyBhIHZpcnR1YWwgYm91bmRhcnkgY29uc3RyYWluLCB3ZSBh
cmUNCj4gc2VlaW5nIGEgbG90IG9mIGJpbyBzcGxpdHRpbmcgYW5kIHNtYWxsZXIgSS9PcyBiZWlu
ZyBzdWJtaXR0ZWQgdG8gdGhlDQo+IGRyaXZlci4NCj4gDQo+IFRoaXMgaGFwcGVucyBiZWNhdXNl
IHRoZSBiaW8gZ2FwIGRldGVjdGlvbiBjb2RlIGRvZXMgbm90IGFjY291bnQgY2FzZXMNCj4gd2hl
cmUgUEFHRV9TSVpFIC0gMSBpcyBiaWdnZXIgdGhhbiBxdWV1ZV92aXJ0X2JvdW5kYXJ5KCkgYW5k
IHRodXMgd2lsbA0KPiBzcGxpdCB0aGUgYmlvIHVubmVjZXNzYXJpbHkuDQoNClRoYW5rcywgYXBw
bGllZC4NCg0KLS0gDQpKZW5zIEF4Ym9lDQoNCg==
