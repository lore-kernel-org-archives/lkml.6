Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6CFC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250182081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250182081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeKJNbx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 08:31:53 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:46339 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeKJNbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 08:31:53 -0500
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 9620C625DE;
        Sat, 10 Nov 2018 03:48:20 +0000 (UTC)
Received: from G9W9209.americas.hpqcorp.net (g9w9209.houston.hpecorp.net [16.220.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 1203F62;
        Sat, 10 Nov 2018 03:48:18 +0000 (UTC)
Received: from G2W6311.americas.hpqcorp.net (16.197.64.53) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 10 Nov 2018 03:48:17 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Sat, 10 Nov 2018 03:48:17 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.145) by
 AT5PR8401MB0900.NAMPRD84.PROD.OUTLOOK.COM (10.169.6.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Sat, 10 Nov 2018 03:48:14 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::548c:301b:e018:77e4]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::548c:301b:e018:77e4%5]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 03:48:14 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "aarcange@redhat.com" <aarcange@redhat.com>,
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
Thread-Index: AQHUdSj7cDxnfAHYlE+9G8mzBVcDKqVIX+eQ
Date:   Sat, 10 Nov 2018 03:48:14 +0000
Message-ID: <AT5PR8401MB1169798EBEF1EE5EBA3ABFFFABC70@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-12-daniel.m.jordan@oracle.com>
In-Reply-To: <20181105165558.11698-12-daniel.m.jordan@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elliott@hpe.com; 
x-originating-ip: [2601:2c3:877f:e23c:b435:c9b:bc11:d67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0900;6:NfifdvqR2VUjPu63JC8mThxmBbjxXbm7kFRPC5H8gc+G3Y0aKGmFUCZkcgZDveuRCFpNPE1b53hG0fBKJrAep8xGpI5ztjHIs3WEH27HQFRKWFBgHVM7K5Gfy0wSaUGvqYsagmTLbGv9TvLVOJgQHQFJyWpn/KQNiKto4Op9z7F8UG/5HoCPfLzNYHFuF6UB9eGiQitdCARo52dZnhTVCx762rb21RolyA4L9V7sUmB74y5nUac6X3THtoXzCYHSVH5RWKGEZKwxDLrxx+PJYyJ+DxEbMQRCS/a/jUkyqW70An7NYcrhJai1UBlFiWi9cL2xBn1jsTlFuO98A8suzSd4baXrumxoiDr5lZnHeDiYiYwB1DCTFq1fs4qPRgW8UjivQEvSTG8zJ96gYXCUGr8+bkMlesTEq8FDKB34WJEPihD6YdzOyzI8GrklSWhD7DOTWOJvwACw4XP6e1qXQQ==;5:H27+4tealfY0gJEoXab4CXVVlVKTcdXhNkFJlurA6a7VcSKLJvaWJbSyLmDYp+uQitoHjFwVL555+fdM0kS4OlzYDW6xlE5ulYZbYpxoVEWv044odXTIpgc+QsIeq1t9PAYbU7BjcOPIR+wmjjdwvE1CmA0oRQS8p3UgXkETEoE=;7:NS91gK7QwrG9ZMpL3F8DvXkQS3ih4xeljWCGZAvIutZvdnmvShS+ksk6DwBDbx5RlLEfXFI4mCFENgl8je6S0TxWuQEEoberYPw6xotUxqeXq/TfrC4UfqugCnRG6Kur5KhDMlYjfIFxhPJUPdeSZw==
x-ms-office365-filtering-correlation-id: fd0c9cca-141e-48b7-4793-08d646bf5796
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0900;
x-ms-traffictypediagnostic: AT5PR8401MB0900:
x-microsoft-antispam-prvs: <AT5PR8401MB09008D7A523C1A0C19B935FDABC70@AT5PR8401MB0900.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AT5PR8401MB0900;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0900;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(13464003)(186003)(46003)(7416002)(2501003)(2900100001)(97736004)(54906003)(6116002)(110136005)(9686003)(6306002)(8936002)(86362001)(229853002)(8676002)(2201001)(446003)(11346002)(316002)(486006)(55016002)(81156014)(81166006)(476003)(74316002)(6436002)(2906002)(99286004)(6246003)(53936002)(105586002)(106356001)(68736007)(14454004)(76176011)(7696005)(102836004)(6506007)(53546011)(305945005)(71200400001)(966005)(33656002)(5660300001)(71190400001)(7736002)(39060400002)(4326008)(217873002)(14444005)(25786009)(478600001)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0900;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: meckwpFBJdHs9IsXXFqyojLFu8q4HmAArTnw1vUmCwfcdOZtYD403Sg3Z4rk/KcYzHyWPnW7PNSNXrmWaVbVKi0Fq4qh5l/pnIRW8pO1BSatMt655N97UZp1+KYs6gX9sHjxEknuVWmJeeME/Fh3+SXmZh8G8NtP0vppcyFuSUlqLSLO8lHKL6Jwyrv2uvrnJ6IGHLCg9MFVq86EhMzxE1zzntZnZrA/C+p5NveiGuwgvOgy3e4SIvDBHVm2O9k1fuITLCh2ersMSpdVW1z3lVqvXiTeqAFexyNNLH/BzRXkkHiqbIX43OUX05n1e6aCywGyeHb3qXYMT26p01mAdIh6VJl9rZF15bclHUWsTS4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0c9cca-141e-48b7-4793-08d646bf5796
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 03:48:14.0730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0900
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Daniel Jordan
> Sent: Monday, November 05, 2018 10:56 AM
> Subject: [RFC PATCH v4 11/13] mm: parallelize deferred struct page
> initialization within each node
> 
> ...  The kernel doesn't
> know the memory bandwidth of a given system to get the most efficient
> number of threads, so there's some guesswork involved.  

The ACPI HMAT (Heterogeneous Memory Attribute Table) is designed to report
that kind of information, and could facilitate automatic tuning.

There was discussion last year about kernel support for it:
https://lore.kernel.org/lkml/20171214021019.13579-1-ross.zwisler@linux.intel.com/


> In testing, a reasonable value turned out to be about a quarter of the
> CPUs on the node.
...
> +	/*
> +	 * We'd like to know the memory bandwidth of the chip to
>         calculate the
> +	 * most efficient number of threads to start, but we can't.
> +	 * In testing, a good value for a variety of systems was a
>         quarter of the CPUs on the node.
> +	 */
> +	nr_node_cpus = DIV_ROUND_UP(cpumask_weight(cpumask), 4);


You might want to base that calculation on and limit the threads to
physical cores, not hyperthreaded cores.

---
Robert Elliott, HPE Persistent Memory


