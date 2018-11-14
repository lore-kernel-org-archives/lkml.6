Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F602C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEF122419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="H15JmMBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEF122419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeKOJDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:03:15 -0500
Received: from mail-eopbgr770077.outbound.protection.outlook.com ([40.107.77.77]:54084
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727264AbeKOJDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xpGdvescWP3LrHUgpRKa1vg45gs/ylbZNH2ZHEPJ40=;
 b=H15JmMBerbBJ6MFeIAPXci/rFx81pqzHSsIYFGC3XIZpF21oaO2qN4flSHNfosdFNZDJ/1OmThsY48s8Xs9ayRWmv34QZLs5W20CMem3X+YxTe7HNA3ha6PiztiZXgmxyEK+5GGBBv0VsUdbUvWvKSSZ3+kNq6EHDuuRD6XJLlU=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB3992.namprd05.prod.outlook.com (52.135.199.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.17; Wed, 14 Nov 2018 22:57:51 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.021; Wed, 14 Nov 2018
 22:57:51 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christian Hansen <chansen3@cisco.com>,
        Dave Young <dyoung@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juergen Gross <jgross@suse.com>,
        Kairui Song <kasong@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Len Brown <len.brown@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Omar Sandoval <osandov@fb.com>, Pavel Machek <pavel@ucw.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Julien Freche <jfreche@vmware.com>
Subject: Re: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are
 logically offline
Thread-Topic: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are
 logically offline
Thread-Index: AQHUfG14AtUUXm8lq0WDadIpB+L9nQ==
Date:   Wed, 14 Nov 2018 22:57:51 +0000
Message-ID: <8932E1F4-A5A9-4462-9800-CAC1EF85AC5D@vmware.com>
References: <20181114211704.6381-1-david@redhat.com>
In-Reply-To: <20181114211704.6381-1-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB3992;20:689ymwZ6ohxKL013HXigJUZPZrl7O7yanyp/Afxmwtmbiiqf8FSCACQ5F7Sd697tZNiZnNBbX4JWDQgWVvxIC9GwySGb/Hm/VNp95YgRJVtVuKh0tpnS6U2Fu0P194OeoGxWGrumaADZFgN2hzKW5JHqczYxGEjfiTdevQG6g80=
x-ms-office365-filtering-correlation-id: 3f620901-a23e-4660-9197-08d64a849b23
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB3992;
x-ms-traffictypediagnostic: BYAPR05MB3992:
x-microsoft-antispam-prvs: <BYAPR05MB3992A3BA4EAEF4A2F86EE793D0C30@BYAPR05MB3992.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB3992;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB3992;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(7736002)(4326008)(217873002)(71190400001)(2906002)(107886003)(71200400001)(6486002)(6246003)(39060400002)(83716004)(316002)(478600001)(82746002)(54906003)(25786009)(8676002)(305945005)(8936002)(81166006)(11346002)(256004)(446003)(110136005)(81156014)(105586002)(6436002)(36756003)(68736007)(106356001)(486006)(33656002)(53936002)(229853002)(476003)(6506007)(53546011)(99286004)(5660300001)(14454004)(76176011)(86362001)(6512007)(26005)(2900100001)(2616005)(7406005)(7416002)(66066001)(97736004)(6116002)(3846002)(102836004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3992;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wevEr1sOZMJYdzxtBr2O7m+XEHOnJeQg9xrBJkfcGxwcPJjiNtPInmerI7PGT5PNLobYFkVecrvdVOeurk8M8Ls4orwOykFPgh3A/7DhUWvXhER9sAxdrkmgQvYoTO4Q75f1H/018hIOnmgm0kBQ+TACNUXJxcJF4tOfYNhQQT0GaAZ1UcNZ/GXmYyuLZsAD5iD++qvCaRLGGz3wR55a3Jy7HrfY/vfEuj9zf4NCy3ep/dNgK9rC/PqL+3iOS+JxVyw327TB24w8BkIBQ/mrlo8BnuwLkW5H6C7CDenLDwoB64zRAZ4yGDU3ODq6RdA+0/g4+StSoWLPSzFqUm2uznBdDAClVTvFV/id+kJrQPo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8127D4BDFD768A4B9EE74019E7FFB6E1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f620901-a23e-4660-9197-08d64a849b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 22:57:51.3910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3992
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand
Sent: November 14, 2018 at 9:16:58 PM GMT
> Subject: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are logica=
lly offline
>=20
>=20
> Right now, pages inflated as part of a balloon driver will be dumped
> by dump tools like makedumpfile. While XEN is able to check in the
> crash kernel whether a certain pfn is actuall backed by memory in the
> hypervisor (see xen_oldmem_pfn_is_ram) and optimize this case, dumps of
> virtio-balloon and hv-balloon inflated memory will essentially result in
> zero pages getting allocated by the hypervisor and the dump getting
> filled with this data.

Is there any reason that VMware balloon driver is not mentioned?

