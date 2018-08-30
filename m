Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00D4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AE720837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Leryho4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AE720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeH3Xjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:39:37 -0400
Received: from mail-dm3nam03on0121.outbound.protection.outlook.com ([104.47.41.121]:26752
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbeH3Xjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9O1ns402iQrWb4VCgnu0GrDSpT2eqtAay5GMjv19xU=;
 b=Leryho4AlCX8MmFfOT53vnZqFGEXbQEbOHTIBi0ByzEdPuQxcG7ssiEk+hZsGEPrArf0ImnaI7PWIvk/EQQvEm/BFU3TV+vnMxjV+1XsQkeunM5Kisph3bdGaAznWgkRkWSU4FHN13bsLTgaitLDlviIOWjDk2lXp7clbocaugI=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0506.namprd21.prod.outlook.com (10.172.91.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 19:35:49 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 19:35:49 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        John Allen <jallen@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH RFCv2 1/6] mm/memory_hotplug: make remove_memory() take
 the device_hotplug_lock
Thread-Topic: [PATCH RFCv2 1/6] mm/memory_hotplug: make remove_memory() take
 the device_hotplug_lock
Thread-Index: AQHUQJinKD+IAFJ3iEe+0XkLr+ptuQ==
Date:   Thu, 30 Aug 2018 19:35:48 +0000
Message-ID: <46a0119b-da16-0203-a8c2-d127738517f4@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-2-david@redhat.com>
In-Reply-To: <20180821104418.12710-2-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0506;6:EZPqcg/HeCZ4uD/2wBP3bE2IYCYUF8ZE+YZ1ahpFU5V9CNd5Sd8CsWDU56gu3hKthhnQ8yjAycNO4FGbZfU4vzTKPMP0TysP5Ts+ReRqcxJbB1LCWDgZIIcwXEg45KPvPaqPuCJAuh58K4paSKQ7eSys1pVeDjIWQ55P/+58dbDRZOZyDUOQG4VQ/y1uUSSxkvlxOVP4Qs2tBpNHobPjMEF9HVseV1nfzABJRTd04ky/QYT2ON8MriQwKpbhnfLv8YFu3sbibjtgRXy8SFbjz1AWyYBd1j+CdbU/aJ+4pRpO6yGRE96SMSFNnbliFjG8uMruIRK8Jsq0i0OT9sRMpzrkxO7XSl7rSqJJBJdkYfBGNWYqyJPEqIWqD6mCfYZAs8/IuHwXiSxIzqz2wbGRIeniflju8bZxtcVcqEpNhXT0pntnkXkxBPsnTrDpDMGILRkd6k/vCG3eOy2sW9Gu1Q==;5:thuOvVF6tlZDiC5vHcI2595Lbc8t6nJ1J8MiXUbazRr28HfQj9EuqI7Eie8p27ktb1QJrhRt+sVBONlStHWcirXpOJlYXUrj4W4XjrWJlVOUKrfyTiK6LwYwAvymcBi8PminRFi+GiqDMI4mext6+Bcs6PiiqcfrV1I0loyO9Mw=;7:WbRlCfUonbAJq6/K3Gexcs9BJhCV/OrcHY6S7gIaRqSwDIcqlhUd+J5jdsQi/lLYbhTHmalOyQBN4/2YI0hm0QMtC/ZBDopviGMdcYTGXd8hd++Yf6tm6BUiaOHRtN+Yk006lUDfSVV978bLQlnnPs1HV8k4yc/utIhzvRkVUG1HNWsMRNER7YFsuB3awkc8nAnC04tJesFI8tWwaus14Ma6rW4oLRZytrNhafKywt6p3WN6Lm+5HGIfP+NW/1NU
x-ms-office365-filtering-correlation-id: 8bf716b3-37c4-4fd0-3569-08d60eafca12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0506;
x-ms-traffictypediagnostic: DM5PR21MB0506:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB05066A817E30B2CB98DBA9CE9D080@DM5PR21MB0506.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0506;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0506;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(316002)(6486002)(54906003)(99286004)(102836004)(22452003)(110136005)(486006)(4326008)(2616005)(6436002)(476003)(229853002)(11346002)(14444005)(256004)(6512007)(53936002)(6506007)(36756003)(186003)(97736004)(2501003)(2900100001)(5250100002)(26005)(446003)(76176011)(6246003)(2906002)(6116002)(3846002)(72206003)(14454004)(7416002)(86612001)(31696002)(39060400002)(106356001)(10290500003)(86362001)(5660300001)(31686004)(8936002)(8676002)(7736002)(305945005)(105586002)(10090500001)(81156014)(81166006)(68736007)(66066001)(25786009)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0506;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /HHO9EAMD7K9FPILu2uLrHME7EPv2IxJ4muq72WBX9PDmuHbXQhP8v/KDRTLunJExONKM15BCDWHe6tKgw1eRyA+H6/cfjso9gzoAFDTZ6XOXp15MOTgS35jlgwKAtIUUiQ2H+wQHbU/gSBmsPlLkPZlBf+4c2LTFJZQ/HsoO0dkwi77LSPkavEvhsDCr8wFmpQ16tZtpv4uWccgAIBxngmsW7XAQ6FCei3jol3IrDRLWmjvknw6jtJM0dB92L4C7ebv1MvDpXUiV50YPs8rbmCGaknXLLQtj0zbgYKCDhm3cmm6AaEVsLMrqrKLwzgHfLr1IeS1eNJVurc27wum8LDpqwbJkF/IJngQDFKtavE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCFCA70729284F4B88E5C6C04E0B640A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf716b3-37c4-4fd0-3569-08d60eafca12
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 19:35:49.0029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiArDQo+ICt2b2lkIF9fcmVmIHJlbW92ZV9tZW1vcnkoaW50IG5pZCwgdTY0IHN0YXJ0LCB1NjQg
c2l6ZSkNCg0KUmVtb3ZlIF9fcmVmLCBvdGhlcndpc2UgbG9va3MgZ29vZDoNCg0KUmV2aWV3ZWQt
Ynk6IFBhdmVsIFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tPg0KDQo+ICt7
DQo+ICsJbG9ja19kZXZpY2VfaG90cGx1ZygpOw0KPiArCV9fcmVtb3ZlX21lbW9yeShuaWQsIHN0
YXJ0LCBzaXplKTsNCj4gKwl1bmxvY2tfZGV2aWNlX2hvdHBsdWcoKTsNCj4gK30NCj4gIEVYUE9S
VF9TWU1CT0xfR1BMKHJlbW92ZV9tZW1vcnkpOw0KPiAgI2VuZGlmIC8qIENPTkZJR19NRU1PUllf
SE9UUkVNT1ZFICovDQo+IA==
