Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F282CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FAC2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=catalogicsoftware.com header.i=@catalogicsoftware.com header.b="LKYzxGgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FAC2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=catalogicsoftware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeJPW2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:28:52 -0400
Received: from us-smtp-delivery-107.mimecast.com ([63.128.21.107]:27914 "EHLO
        us-smtp-delivery-107.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727016AbeJPW2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catalogicsoftware.com; s=mimecast20180821; t=1539700684; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding: in-reply-to:in-reply-to:references:references; bh=Sy7ls6M2qBDwQlXulMOh0/f1wKAKKszgsjoclO5s1v0=; b=LKYzxGgA2n4vAbVyqUD9fbcu48de2I8/aWM/h2kdZ0cgA5TPxjSM7S2uiHXI6751dvssyx/vC27W/acI6VDncJYXjsNAQxIk8Y1PPzB335Lv1V0KnaCFhJRrjHoB5ZVS0316wsCo12fobbsUy8YiyMVKKA3oMssoStIj4ESo1Ys=
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03lp0021.outbound.protection.outlook.com [216.32.181.21])
 (Using TLS) by us-smtp-1.mimecast.com with ESMTP id
 us-mta-196-VIfpF6j0M7im0AlI47C1RA-1; Tue, 16 Oct 2018 10:38:03 -0400
Received: from DM5PR01MB2348.prod.exchangelabs.com (10.168.192.138) by
 DM5PR01MB2842.prod.exchangelabs.com (10.172.186.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Tue, 16 Oct 2018 14:37:59 +0000
Received: from DM5PR01MB2348.prod.exchangelabs.com
 ([fe80::a16f:30df:2f13:edb1]) by DM5PR01MB2348.prod.exchangelabs.com
 ([fe80::a16f:30df:2f13:edb1%3]) with mapi id 15.20.1250.020; Tue, 16 Oct 2018
 14:37:59 +0000
From:   "Ly, Bryant" <bly@catalogicsoftware.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Mike Christie <mchristi@redhat.com>,
        target-devel <target-devel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with
 active signals
Thread-Topic: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with
 active signals
Thread-Index: AQHUYEiZqcAaFWCqE06ZzWwpCq+UtqUYtGqAgADZNoCAAHgcAIAHRwXegACuVwA=
Date:   Tue, 16 Oct 2018 14:37:58 +0000
Message-ID: <01F789A9-AF3F-4226-B9D1-9BB160AC4947@catalogicsoftware.com>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
 <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
 <5BBE2FBF.7080804@redhat.com>
 <1539237365.6150.32.camel@haakon3.daterainc.com>
 <F43269BA-4D7B-486C-87C6-0FB48FF890EA@catalogicsoftware.com>
 <yq1lg6yv899.fsf@oracle.com>
In-Reply-To: <yq1lg6yv899.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [96.42.214.145]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR01MB2842;20:ixPoZlygiZdr6ohrFGrRxzvR3a2rgDEtzcsCQ1sXlsYRz1idPZtQCLEaPudz3DQWyIqCpUgHw+Fbwy2rCL5oLWcBolLGVXG0k+Oj9BPZLBFdRkGW7PpRoou+7b629mrEZZGtdKVPxQJCfU8GB6wNQIfWKqUayeYEZxqXBZFQ0aw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 97c951ef-8680-4f7e-e39c-08d63374f835
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR01MB2842;
x-ms-traffictypediagnostic: DM5PR01MB2842:
x-microsoft-antispam-prvs: <DM5PR01MB284271C9303C3EB20A1D4B21B4FE0@DM5PR01MB2842.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:DM5PR01MB2842;BCL:0;PCL:0;RULEID:;SRVR:DM5PR01MB2842;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(396003)(136003)(376002)(366004)(189003)(199004)(486006)(7736002)(82746002)(305945005)(86362001)(5660300001)(6916009)(11346002)(7416002)(2616005)(68736007)(33656002)(446003)(99286004)(476003)(76176011)(4326008)(66066001)(97736004)(54906003)(93886005)(2906002)(106356001)(71200400001)(316002)(71190400001)(105586002)(6246003)(83716004)(6116002)(8936002)(2900100001)(14454004)(229853002)(102836004)(8676002)(3846002)(36756003)(81156014)(6436002)(6506007)(6486002)(81166006)(53546011)(25786009)(26005)(53936002)(478600001)(256004)(186003)(6512007)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR01MB2842;H:DM5PR01MB2348.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: XmPQ0Uy5Mz/fUUdMhDofvLYCU/jJ4sZPNDr+WRr54w/Ip/6MSJGnTcSJs+xG0+vsDHpxU3BewaZMlVDWejBITIw2ThI0zLs5gpwBHgSr7UWOfxnHks1KMo4nE/2ZB16OwRTYLa2ibeHaBgWXhsrKaCPRJ2SbNfg1Fv6/E4scbBKjs2rgqPQzB7BNvbY6azwshuHesf/xGOGQ6YvFqYL49EVMaA40OrkqB2cdhckWRSBrAD5VrGzPd0sdANN4XyeY2vFCkgZP1+JeGeyEGNzEu+TqDj6jVUcSmZEzfBx+2YxbjWXJX+qU4UkJtqQN4ucemFmGlSVRMZRl0s47O41fJY2bPdH//yrjL5GjorhTiD4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <10F2FAACA27E1E4D8895C09EDF922C47@prod.exchangelabs.com>
MIME-Version: 1.0
X-OriginatorOrg: catalogicsoftware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c951ef-8680-4f7e-e39c-08d63374f835
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 14:37:59.0225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ea3d63e8-dd40-410b-9496-d2ee49ccddc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2842
X-MC-Unique: VIfpF6j0M7im0AlI47C1RA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFydGluLCANCg0KPiBPbiBPY3QgMTUsIDIwMTgsIGF0IDExOjEzIFBNLCBNYXJ0aW4gSy4gUGV0
ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IA0KPiBCcnlh
bnQsDQo+IA0KPj4gVk1zIGRvIG5vdCByZW1vdmUgdGhlIElfVCBuZXh1cyB3aGlsZSB0aGUgVk0g
aXMgYWN0aXZlLCBzbyB3ZSBjYW4gcmVtb3ZlDQo+PiB0aGUgdGFyZ2V0X3dhaXRfZm9yX3Nlc3Nf
Y21kKCkgY2FsbC4gDQo+IA0KPiBQYXRjaCBmb3J0aGNvbWluZz8NCg0KSSBjYW4gcHV0IG91dCBh
IHBhdGNoLCBJ4oCZbSB0cnlpbmcgdG8gZ2V0IHNvbWVvbmUgYXQgSUJNIHRvIHRlc3QgaXQgdGhv
dWdoLg0KDQotQnJ5YW50

