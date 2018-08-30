Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9330C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805BA20645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EElcNPiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805BA20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeH3T50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:57:26 -0400
Received: from mail-cys01nam02on0113.outbound.protection.outlook.com ([104.47.37.113]:45319
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727098AbeH3T50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlV0T/LveRYaoFRFJjBbkV/cS1B7DELahFkctVd7qDk=;
 b=EElcNPiuthnuHcd+dfXR2B9RSRrUXigoMELmC3mmd3h+kNzlXiMwJFirJluwYjuYb/iYVx7TxA+TUDqoWWWxm3JrExZLhlN1w54nPfQArI8sMa/F3l+23Y/m1eKVydfhiyPi9rIjtc9IVjCG+QX6xACJu9qV7FX239q52a0/gNg=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0170.namprd21.prod.outlook.com (10.173.173.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Thu, 30 Aug 2018 15:54:31 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 15:54:30 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Allen <jallen@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Michal Hocko <mhocko@suse.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Subject: Re: [PATCH RFCv2 0/6] mm: online/offline_pages called w.o.
 mem_hotplug_lock
Thread-Topic: [PATCH RFCv2 0/6] mm: online/offline_pages called w.o.
 mem_hotplug_lock
Thread-Index: AQHUQHm8B/6idujVk0SgU6qC1BCMWA==
Date:   Thu, 30 Aug 2018 15:54:30 +0000
Message-ID: <b9eb96e7-3846-1aaa-d257-895ca142b1ef@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <37ea507e-b16d-ae8d-4da8-128b621869f2@redhat.com>
In-Reply-To: <37ea507e-b16d-ae8d-4da8-128b621869f2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0170;6:YJylFLJ5IFXq+rVy0IUdgUv30SJ7Kn7m3ik6XQMh2fYiP/cRQ0PaEikZc2SG8KcUReHkYkqhwLySYHRXPjKNVznug45HEe1XQgeEHsyE1EC6JaZ09zK+ynVuVXoh8wpCgohCo+XG55WITsec9f7dHjOJMVUn7TPFGjfIqtJ2xBHMh+jGguCvAriSgKSXog/vHx4uK5ASE3NBzsyJCv/VUfQopeeanVVKYliC0/PF62Ffmk2a7HKLf337qa3gVUt7r8Zo3TjnCrgMapYghPNvnBGQfsPSTO2Mq2UyKc8dALpwlvwCgQ3837hfecp2UX/IQOKJzh2Cb+xEReyw0a/IHgjItnilrmnx/ZNDspxNSXNUo6D6LzaNp6JGHKdOidry6loQfbrROrwCRUy+KO2WXS/3uetwuRau4M0R9xqMAQzsozq+tmX4jlzZFb41Um4lkFrxOvidNMaTAe0KuETgqA==;5:QJYnU41sHdehdo7eguRfvvznE94p0rK7gPXK/itQ8cXQw7AmBRlBpCmcn32Vu6Ox8hteLMlCgeKvc7NyCYQmH7cD0KrlVMd/XE4FYmKWn7vneMon222EaE2ybwZnlA0/TQdqlpw37mhWZfKppBOJVGrW2We23UwzcgB2anzb1No=;7:BuNAjHViWbQsiAIK4K3q6UTdF+03CJaOhDZM9wQyNHbmyGu856zZTUjs2/ykJdJQbL5nyc7H6BL0mhJC8tSvCHW+JLjyoAPkR8IHIWkGUuFr+gkpuk0EHE5uwbK/qMmJy+gdKcqCGEq+j+xyHKUEAYAb5vmr0tjAfBXkm0fuixPzeYNKwuZUnogWm/GpGKdWFwrppPoIT/L9A4VeYP0N049HskEUcGsgu8Tqv6X0hTPRXZG2qdm0zEM182bcK125
x-ms-office365-filtering-correlation-id: a076ade8-1419-4df1-90be-08d60e90dfa3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0170;
x-ms-traffictypediagnostic: DM5PR21MB0170:
x-microsoft-antispam-prvs: <DM5PR21MB0170C1984147EC8A29C212E99D080@DM5PR21MB0170.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0170;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0170;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(2501003)(53546011)(6506007)(256004)(97736004)(5250100002)(6346003)(25786009)(26005)(68736007)(2900100001)(478600001)(4326008)(76176011)(3846002)(81156014)(14444005)(186003)(39060400002)(7406005)(7416002)(5660300001)(102836004)(6116002)(305945005)(6246003)(10090500001)(81166006)(7736002)(86362001)(36756003)(8676002)(11346002)(229853002)(446003)(31696002)(6512007)(53936002)(486006)(106356001)(31686004)(54906003)(110136005)(105586002)(316002)(66066001)(22452003)(99286004)(10290500003)(8936002)(2906002)(86612001)(14454004)(6486002)(476003)(6436002)(72206003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0170;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: egVaV7kEVOshS7L+JMXuIPxfk0bi68hy5MkSfYUsHjRysa8waQDdyZli90EmYJyovMgpGGkx2GEXg14fjY26k6vuXl2pBNfjTmyjeAa6Xb2NU1rjwxgoTeFx6EzYXX/wCPuG2/ipeGmhjy0I1q/MUYyEErdyx6Vd7jFNTGn+TdCHeGJ7wE3xMtb+rdtpuRI9MZoQHmHFfvTJQhsPrQaS7kbJbT7KHnaupz2hU0jfpXYy8Js8Tp2vN1hEvei2pGLdag6KUKOj2FOV5XSlR6IMcjfupE4sxu9TSuoBS8UlUxYquiVSqzmExYKUDuijKo+iwGhDDcQpyve5TOrEBBo3wiHpW7Y/TVw5/E6sQ7b/cVU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3DB3B11124F444D8932C0F350E2E1D9@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a076ade8-1419-4df1-90be-08d60e90dfa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 15:54:30.6779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDgvMzAvMTggODozMSBBTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+IE9uIDIx
LjA4LjIwMTggMTI6NDQsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4gVGhpcyBpcyB0aGUg
c2FtZSBhcHByb2FjaCBhcyBpbiB0aGUgZmlyc3QgUkZDLCBidXQgdGhpcyB0aW1lIHdpdGhvdXQN
Cj4+IGV4cG9ydGluZyBkZXZpY2VfaG90cGx1Z19sb2NrIChyZXF1ZXN0ZWQgYnkgR3JlZykgYW5k
IHdpdGggc29tZSBtb3JlDQo+PiBkZXRhaWxzIGFuZCBkb2N1bWVudGF0aW9uIHJlZ2FyZGluZyBs
b2NraW5nLiBUZXN0ZWQgb25seSBvbiB4ODYgc28gZmFyLg0KPj4NCj4gDQo+IEknbGwgYmUgb24g
dmFjYXRpb24gZm9yIHR3byB3ZWVrcyBzdGFydGluZyBvbiBTYXR1cmRheS4gSWYgdGhlcmUgYXJl
IG5vDQo+IGNvbW1lbnRzIEknbGwgc2VuZCB0aGlzIGFzICFSRkMgb25jZSBJIHJldHVybi4NCj4N
CkkgYW0gc3R1ZHlpbmcgdGhpcyBzZXJpZXMsIHdpbGwgc2VuZCBteSBjb21tZW50cyBsYXRlciB0
b2RheS4NCg0KUGF2ZWw=
