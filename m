Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D36C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFC920880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Y5urSkVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFC920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeIJVzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:55:35 -0400
Received: from mail-eopbgr730083.outbound.protection.outlook.com ([40.107.73.83]:10560
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728163AbeIJVze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEQ/H+PnvZpchU/POeC+7arIYbN6s9NAEltPb1m7oWc=;
 b=Y5urSkVt7pmICq48crFpMzusU+lDg+7bSWIHPTamidwYmJ8nIREp3E3b9B0fMTeE56s+N0owwEGIqDzB1f1UGzLu8WizIH3r//Wjz6I90vlpx6C/YXXViHrvvwrSx1FAdXN4ZLYlHP8cSWttWNbYK2s5ulqcwwXD6ug2G3WsQ3g=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4246.namprd05.prod.outlook.com (20.176.252.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Mon, 10 Sep 2018 17:00:28 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::4d7f:773c:89:28ae]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::4d7f:773c:89:28ae%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 17:00:28 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH v7 00/10] x86: macrofying inline asm for better
 compilation
Thread-Topic: [PATCH v7 00/10] x86: macrofying inline asm for better
 compilation
Thread-Index: AQHUMB4G8Q2B7h5OjUe7mTMkYteFXKTghQ0AgAknNoCAAEMIAA==
Date:   Mon, 10 Sep 2018 17:00:27 +0000
Message-ID: <BF02CA61-278E-4F34-B03B-5B098260136E@vmware.com>
References: <20180809201554.168804-1-namit@vmware.com>
 <4EDCB9E5-22C4-4168-A80A-4EC81ECE43EF@vmware.com>
 <20180910130029.GA66583@gmail.com>
In-Reply-To: <20180910130029.GA66583@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4246;20:fa+spPq0eG0C05XSSbtzxlQ9VdJeutCUL57Pv97uvdkVdtq/qHWu9lBkjfBNwGJBvrGZrK37hS/DkCBh3JfvvBmAczMgKyZB69ELKQ+tdxxXEotX1WKQPfcF+BcSO80gYXwp/k2n3rpJlgc7yp4d147ywT+j0I1TsQKKmU0KDFE=
x-ms-office365-filtering-correlation-id: 14f3ace7-c8dd-4e41-37d2-08d6173ee8df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4246;
x-ms-traffictypediagnostic: BYAPR05MB4246:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB424659FFAB6B6F92B9635433D0050@BYAPR05MB4246.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR05MB4246;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4246;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(396003)(376002)(189003)(199004)(4326008)(6506007)(3846002)(53936002)(66066001)(229853002)(6916009)(102836004)(86362001)(97736004)(8936002)(36756003)(486006)(2906002)(5250100002)(6116002)(26005)(446003)(11346002)(25786009)(6436002)(39060400002)(6512007)(186003)(81156014)(6246003)(6486002)(105586002)(106356001)(81166006)(99286004)(83716003)(558084003)(476003)(14454004)(33656002)(305945005)(2616005)(68736007)(256004)(2900100001)(54906003)(7736002)(316002)(76176011)(8676002)(5660300001)(478600001)(7416002)(82746002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4246;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M+SGNp1RaZ6Qphtdi+F6Y7jgxNRaPfXVwQC2IpSw2HvZn20liwun186sSAkDkoDJXI9JkBn8C0SJCOeKelWSwyE6yIW+ZdglBAag4g3J/4rta+pdmHqvfRC/6wcHsXiTdofqi7WGEsLc7Cmp01UxrPmgCOCvxAozo/Y5o9LMZKqqb6viZ9MoJ1XaXjaknt8+IonIl8O/Ht1STJYeAX9uJOIuYAzo1zwP1aPoz39PAsV2n8IOewssFUbXAht37QfKnYk+YzcIbz4W58JvEgJPouzCzlhcLS24LuCSynhSZbbC2mq4Gosypz4xz1Bz4E76IkCC41gxk22xjtf8KM9byQ9WCXc7/5mznkkTZxqvx9s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4C8D195D72F1843A1714B0DE469F771@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f3ace7-c8dd-4e41-37d2-08d6173ee8df
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 17:00:27.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgNjowMCBBTSwgSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQo+IA0K
PiAqIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPiANCj4+IFBpbmcuDQo+
IA0KPiBNYXNhaGlybyBZYW1hZGEgbm90ZWQgdGhhdCBzb21lIFJldmlld2VkLWJ5IHRhZ3Mgd2Vy
ZSBub3QgYWRkZWQgLSBjb3VsZCB5b3UgcGxlYXNlIGRvdWJsZSBjaGVjayANCj4gcGFzdCBtYWls
cyBhbmQgYWRkIHRoZW0gYW5kIHJlLXNlbmQgYWdhaW5zdCB0aGUgbGF0ZXN0IGtlcm5lbD8NCg0K
T25lIChoaXMpIHdhcyBtaXNzaW5nLiBJ4oCZbGwgYWRkIGl0LCByZWJhc2UgYW5kIHNlbmQuDQoN
Cg==
