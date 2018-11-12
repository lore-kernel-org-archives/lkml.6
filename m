Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10CCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B462243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B462243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbeKMILA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:11:00 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:19606 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbeKMIK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:10:59 -0500
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 27EEF1372;
        Mon, 12 Nov 2018 22:15:52 +0000 (UTC)
Received: from G1W8107.americas.hpqcorp.net (g1w8107.austin.hp.com [16.193.72.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id D70A5A9;
        Mon, 12 Nov 2018 22:15:50 +0000 (UTC)
Received: from G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) by
 G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Mon, 12 Nov 2018 22:15:50 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W8453.americas.hpqcorp.net (16.216.160.211) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3 via Frontend Transport; Mon, 12 Nov 2018 22:15:50 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.145) by
 AT5PR8401MB0321.NAMPRD84.PROD.OUTLOOK.COM (10.169.2.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 12 Nov 2018 22:15:46 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::548c:301b:e018:77e4]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::548c:301b:e018:77e4%5]) with mapi id 15.20.1294.045; Mon, 12 Nov 2018
 22:15:46 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "bsd@redhat.com" <bsd@redhat.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jgg@mellanox.com" <jgg@mellanox.com>,
        "jwadams@google.com" <jwadams@google.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Pavel.Tatashin@microsoft.com" <Pavel.Tatashin@microsoft.com>,
        "prasad.singamsetty@oracle.com" <prasad.singamsetty@oracle.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "tim.c.chen@intel.com" <tim.c.chen@intel.com>,
        "tj@kernel.org" <tj@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>
Subject: RE: [RFC PATCH v4 11/13] mm: parallelize deferred struct page
 initialization within each node
Thread-Topic: [RFC PATCH v4 11/13] mm: parallelize deferred struct page
 initialization within each node
Thread-Index: AQHUdSj7cDxnfAHYlE+9G8mzBVcDKqVIX+eQgAQGcwCAAFfMgA==
Date:   Mon, 12 Nov 2018 22:15:46 +0000
Message-ID: <AT5PR8401MB1169B05F889BCF8EF113E053ABC10@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-12-daniel.m.jordan@oracle.com>
 <AT5PR8401MB1169798EBEF1EE5EBA3ABFFFABC70@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <20181112165412.vizeiv6oimsuxkbk@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20181112165412.vizeiv6oimsuxkbk@ca-dmjordan1.us.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elliott@hpe.com; 
x-originating-ip: [108.188.176.171]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0321;6:rcNjvXa8Nlaxev/FpDvPs+CZMplgr+0QIWHzdgrF+PiPin+XmdIUmA44yDf1Y60+znn9cqvF8MuBLQwdYFGwqPCSqDgYwKLaF5l9qSl7SpKWH46Fh9Pxg1k62hSvEClxOBX1k1OOjCDjxR8lT+eoJy/dByfbDX9HYc2fsri2BDRzDwCVgA5beJNotkmVSETDu/koswdKYDgxfZn270JoSRwMONPqF3a1AnwlDOvhu7dsO0lyn1n/1CaHQ51qWjHx0ugAXv6dZkL9r5GJrpFvGRG4I8QgEQDe1jWKGMIedtfRVJ6P2JbqOS9tc3XbxZWHWERIMmGMrSkfL6V7Fr8hcmVkIAaOmWhOLwdhIdiBCQeK7evYFOe4PgbSj5uHlZIe2DN/bnI7QbQ6BAzzBFx4nXFlBh98W66B8GBjBKuqIH7g3QjxpcVYivjcIKfoKhseF89aPxWcB4r1EICrSx4elA==;5:eSRvGwJkRbnI6CtmJUfBjjD1WzeKp4ktLuD9nWgQlrtz3M8v25Gnlmo60wyAxH5/GkTCm3Hx3VvqT5uFSdpqruw3sNjmfsTjFQT4tSKSmygvkLT53MdPuPKLCsdGHOHnQnUp1LZGiHT2Ezdg79ppCKc4Ytemdyie+fxkVynmZB4=;7:ayBtlNP0znmAwTmqkDPH6J4/kyvi4nODQkiOWJqp/OAPdAY1Qw4FEcwHhZL6FE0NE3XL0gTNZ2m+JdWyjG9epkdRXBjOkI2BrkL9IhrCRLYEsaTxpdpbMDPAhqW3ZskQJzoQra1wktWDUx1LwYTV4A==
x-ms-office365-filtering-correlation-id: 51f658dd-2555-43b8-7622-08d648ec652c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0321;
x-ms-traffictypediagnostic: AT5PR8401MB0321:
x-microsoft-antispam-prvs: <AT5PR8401MB032107F460A3EC103D9E7603ABC10@AT5PR8401MB0321.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699)(146099531331640)(211936372134217)(85827821059158)(28532068793085)(222181515654134)(227479698468861);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AT5PR8401MB0321;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0321;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(346002)(136003)(51444003)(189003)(199004)(13464003)(2906002)(71200400001)(39060400002)(106356001)(217873002)(105586002)(71190400001)(4326008)(6436002)(9686003)(53936002)(486006)(6916009)(476003)(5660300001)(6116002)(7416002)(3846002)(446003)(66066001)(11346002)(86362001)(74316002)(305945005)(2900100001)(478600001)(7736002)(97736004)(81156014)(8676002)(54906003)(7696005)(26005)(8936002)(6506007)(53546011)(76176011)(45080400002)(316002)(256004)(14444005)(68736007)(6246003)(55016002)(93886005)(14454004)(102836004)(186003)(99286004)(33656002)(229853002)(25786009)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0321;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iRd/YnWW8+NMOYlZPFkwS82B7ASaHwKkASZ3tBq+aZ4g210hBKvQHPEHNJkKEX0TRheF58iyS23lTfkHXO8cjrTdKiRp3ZnQtqHEWfhvT0ORtqhze1Wrq9z4FCpggFhAj0c21ZFtbV/ytKzoAKDm+4gJyINlgJ/C2IEWfwEOVdG+CQuXUASdEX4vD57C9sJehvr1SGsZV/dbT8vtyglS37wmitQCOhgcy46zm12jPBOWAZcfZbXXIitqc8yHN5c62H5aWH0l26ObsZQ5kpg/HKIFj/R6HkqUtWGVj+uFYEyqIih22yVpTu8qtWKmUzZGPTYF5rAu/iU+Dr5mzisqct9kLRihYMcOnutnFKfOm54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f658dd-2555-43b8-7622-08d648ec652c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 22:15:46.5304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0321
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Daniel Jordan <daniel.m.jordan@oracle.com>
> Sent: Monday, November 12, 2018 11:54 AM
> To: Elliott, Robert (Persistent Memory) <elliott@hpe.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>; linux-mm@kvack.org;
> kvm@vger.kernel.org; linux-kernel@vger.kernel.org; aarcange@redhat.com;
> aaron.lu@intel.com; akpm@linux-foundation.org; alex.williamson@redhat.com;
> bsd@redhat.com; darrick.wong@oracle.com; dave.hansen@linux.intel.com;
> jgg@mellanox.com; jwadams@google.com; jiangshanlai@gmail.com;
> mhocko@kernel.org; mike.kravetz@oracle.com; Pavel.Tatashin@microsoft.com;
> prasad.singamsetty@oracle.com; rdunlap@infradead.org;
> steven.sistare@oracle.com; tim.c.chen@intel.com; tj@kernel.org;
> vbabka@suse.cz
> Subject: Re: [RFC PATCH v4 11/13] mm: parallelize deferred struct page
> initialization within each node
> 
> On Sat, Nov 10, 2018 at 03:48:14AM +0000, Elliott, Robert (Persistent
> Memory) wrote:
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > > owner@vger.kernel.org> On Behalf Of Daniel Jordan
> > > Sent: Monday, November 05, 2018 10:56 AM
> > > Subject: [RFC PATCH v4 11/13] mm: parallelize deferred struct page
> > > initialization within each node
> > >
...
> > > In testing, a reasonable value turned out to be about a quarter of the
> > > CPUs on the node.
> > ...
> > > +	/*
> > > +	 * We'd like to know the memory bandwidth of the chip to
> > >         calculate the
> > > +	 * most efficient number of threads to start, but we can't.
> > > +	 * In testing, a good value for a variety of systems was a
> > >         quarter of the CPUs on the node.
> > > +	 */
> > > +	nr_node_cpus = DIV_ROUND_UP(cpumask_weight(cpumask), 4);
> >
> >
> > You might want to base that calculation on and limit the threads to
> > physical cores, not hyperthreaded cores.
> 
> Why?  Hyperthreads can be beneficial when waiting on memory.  That said, I
> don't have data that shows that in this case.

I think that's only if there are some register-based calculations to do while
waiting. If both threads are just doing memory accesses, they'll both stall, and
there doesn't seem to be any benefit in having two contexts generate the IOs
rather than one (at least on the systems I've used). I think it takes longer
to switch contexts than to just turnaround the next IO.


---
Robert Elliott, HPE Persistent Memory



