Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BD7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2CD21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2CD21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeK0LI3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:08:29 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:1652 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeK0LI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:08:29 -0500
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id B9A59708;
        Tue, 27 Nov 2018 00:12:32 +0000 (UTC)
Received: from G4W10204.americas.hpqcorp.net (g4w10204.houston.hpecorp.net [16.207.82.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id 8F7B5E3;
        Tue, 27 Nov 2018 00:12:31 +0000 (UTC)
Received: from G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) by
 G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 27 Nov 2018 00:12:31 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W10204.americas.hpqcorp.net (16.207.82.16) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 27 Nov 2018 00:12:31 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.145) by
 AT5PR8401MB0788.NAMPRD84.PROD.OUTLOOK.COM (10.169.6.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Tue, 27 Nov 2018 00:12:28 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac27:c64c:76db:414a]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac27:c64c:76db:414a%7]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 00:12:28 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     'Daniel Jordan' <daniel.m.jordan@oracle.com>
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
Thread-Index: AQHUdSj7cDxnfAHYlE+9G8mzBVcDKqVIX+eQgAQGcwCAAFfMgIAKmdYAgAt4pHA=
Date:   Tue, 27 Nov 2018 00:12:28 +0000
Message-ID: <AT5PR8401MB1169AA00F542BA2E3204FC24ABD00@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-12-daniel.m.jordan@oracle.com>
 <AT5PR8401MB1169798EBEF1EE5EBA3ABFFFABC70@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <20181112165412.vizeiv6oimsuxkbk@ca-dmjordan1.us.oracle.com>
 <AT5PR8401MB1169B05F889BCF8EF113E053ABC10@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <20181119160137.72zha7dbsr3adkfs@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20181119160137.72zha7dbsr3adkfs@ca-dmjordan1.us.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elliott@hpe.com; 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0788;6:exXJpX+YK2QBsemD59ECcYGXwJWMsbQHBWwaoYU5bKOqIuN0znMT+3MZALs/pdGGHVEStxmzMfx/n5xh3ZjagdJ34KVHMNpnvOWBqfLIGwwLqa/qQ3B6m+CBTAouh0+bg+gIM4NjrWn0DlexNYCyPb6bQg5SrXM0O2678y2wJtBZ/OFkM/UdkGyeg8qPvORwPlGtk+pzEZfEsNIrPl5DEcLEUsc37s+2qT0jW8GvLR5yd9t2eng79vyLwvoeKU8pLTHJtG6Ny/sHnnAx+5ST8MtTC6WQTT/QA+BIDpWfu7JsLiA3zrETfBnK1mtlqbF8ZCW69SGHiiCAJjMBEGjDBTQGuwvCLvUDPorrvpBATSPZnAWnFnSzDV6Rgq+ZPnMBMwh324G6QpgMwfpyTOZPSjaG0LMlVziDdr6a8i/a8lfmUtyX4VDWG2D7tawBWdkfo4MAZPBvWPSRRkMlqfzKqw==;5:Z4DFhCaHNpTLnKCAINfQQ5d17u4RoQwvQn+dhL6R5mctiHlmJFEWFHVZRUkuSDXlWjr7Ugbf9MuEAbhGPbW2vkcCzaQJIsDfKmdHb3pwTjGlEg7W3b6qvG/tUcFPUQchPkIB0NR0FYve+cxjikAZ3x+DSpOzm76pU3SfG69ff3w=;7:10/fKhgAxC0sFPyFN2xlVA1EKH3S54wYbzpQBJRwJjQiHIIunXTXTRQHkQ2sRamnII7fCwHmPYUdHL05jOKCTVvtM0NjnkXwOCBv1GucfkunsEMrsuxUOUhPWiBLfS8jnUbl2lzTDb7xmgoKySkPdQ==
x-ms-office365-filtering-correlation-id: 2a8c98d8-972e-471f-5c58-08d653fd046e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0788;
x-ms-traffictypediagnostic: AT5PR8401MB0788:
x-microsoft-antispam-prvs: <AT5PR8401MB0788BC2421058FEBCDBD3623ABD00@AT5PR8401MB0788.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231443)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AT5PR8401MB0788;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0788;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(51444003)(13464003)(486006)(316002)(93886005)(97736004)(3846002)(6116002)(54906003)(71200400001)(71190400001)(86362001)(106356001)(76176011)(55016002)(186003)(26005)(7696005)(53546011)(102836004)(6506007)(11346002)(446003)(99286004)(256004)(9686003)(66066001)(478600001)(33656002)(68736007)(53936002)(5660300001)(14444005)(39060400002)(6916009)(7416002)(6246003)(8676002)(217873002)(305945005)(7736002)(74316002)(6436002)(4326008)(105586002)(25786009)(14454004)(229853002)(2906002)(476003)(81166006)(8936002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0788;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9PYvwuE9svhGi3Qjbj0CtEKE8rlA42da18NgEHXot8KPfrUTNiIMnSfR3xrP/2nfWrE1B9/dZVrZW5xWgXYwfctOZNZ70CoiL25qH1qrJBl3WSB418ePBSfjlb18wL559icOh96kvks1METBdRBb5ejXK+yMbF+rY0Cm/LuJDxlpvdSSLF//VxDpN/vGg3/AD4NvIQC0yHp7NbAvCtrR0GnmA5Vur6HFPoqUhPK0yS5hgGXAx2ji3bK+kmg6rSxCeNVpERK85iD/s8+PtU8Gl2BRL24fmjLg4oCNQxYZIgMbSjJBpMLdrz0MfMwEoiIKumXA5nCCO3E81RToWcSYHsuVpp3gfM+pSboLVzU3NCU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8c98d8-972e-471f-5c58-08d653fd046e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 00:12:28.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0788
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Daniel Jordan [mailto:daniel.m.jordan@oracle.com]
> Sent: Monday, November 19, 2018 10:02 AM
> On Mon, Nov 12, 2018 at 10:15:46PM +0000, Elliott, Robert (Persistent Memory) wrote:
> >
> > > -----Original Message-----
> > > From: Daniel Jordan <daniel.m.jordan@oracle.com>
> > > Sent: Monday, November 12, 2018 11:54 AM
> > >
> > > On Sat, Nov 10, 2018 at 03:48:14AM +0000, Elliott, Robert (Persistent
> > > Memory) wrote:
> > > > > -----Original Message-----
> > > > > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > > > > owner@vger.kernel.org> On Behalf Of Daniel Jordan
> > > > > Sent: Monday, November 05, 2018 10:56 AM
> > > > > Subject: [RFC PATCH v4 11/13] mm: parallelize deferred struct page
> > > > > initialization within each node
> > > > >
> > ...
> > > > > In testing, a reasonable value turned out to be about a quarter of the
> > > > > CPUs on the node.
> > > > ...
> > > > > +	/*
> > > > > +	 * We'd like to know the memory bandwidth of the chip to
> > > > >         calculate the
> > > > > +	 * most efficient number of threads to start, but we can't.
> > > > > +	 * In testing, a good value for a variety of systems was a
> > > > >         quarter of the CPUs on the node.
> > > > > +	 */
> > > > > +	nr_node_cpus = DIV_ROUND_UP(cpumask_weight(cpumask), 4);
> > > >
> > > >
> > > > You might want to base that calculation on and limit the threads to
> > > > physical cores, not hyperthreaded cores.
> > >
> > > Why?  Hyperthreads can be beneficial when waiting on memory.  That said, I
> > > don't have data that shows that in this case.
> >
> > I think that's only if there are some register-based calculations to do while
> > waiting. If both threads are just doing memory accesses, they'll both stall, and
> > there doesn't seem to be any benefit in having two contexts generate the IOs
> > rather than one (at least on the systems I've used). I think it takes longer
> > to switch contexts than to just turnaround the next IO.
> 
> (Sorry for the delay, Plumbers is over now...)
> 
> I guess we're both just waving our hands without data.  I've only got x86, so
> using a quarter of the CPUs rules out HT on my end.  Do you have a system that
> you can test this on, where using a quarter of the CPUs will involve HT?

I ran a short test with:
* HPE ProLiant DL360 Gen9 system
* Intel Xeon E5-2699 CPU with 18 physical cores (0-17) and 
  18 hyperthreaded cores (36-53)
* DDR4 NVDIMM-Ns (which run at regular DRAM DIMM speeds)
* fio workload generator
* cores on one CPU socket talking to a pmem device on the same CPU
* large (1 MiB) random writes (to minimize the threads getting CPU cache
  hits from each other)

Results:
* 31.7 GB/s    four threads, four physical cores (0,1,2,3)
* 22.2 GB/s    four threads, two physical cores (0,1,36,37)
* 21.4 GB/s    two threads, two physical cores (0,1)
* 12.1 GB/s    two threads, one physical core (0,36)
* 11.2 GB/s    one thread, one physical core (0)

So, I think it's important that the initialization threads run on
separate physical cores.

For the number of cores to use, one approach is:
    memory bandwidth (number of interleaved channels * speed)
divided by 
    CPU core max sustained write bandwidth

For example, this 2133 MT/s system is roughly:
    68 GB/s    (4 * 17 GB/s nominal)
divided by
    11.2 GB/s  (one core's performance)
which is 
    6 cores

ACPI HMAT will report that 68 GB/s number.  I'm not sure of
a good way to discover the 11.2 GB/s number.


fio job file:
[global]
direct=1
ioengine=sync
norandommap
randrepeat=0
bs=1M
runtime=20
time_based=1
group_reporting
thread
gtod_reduce=1
zero_buffers
cpus_allowed_policy=split
# pick the desired number of threads
numjobs=4
numjobs=2
numjobs=1

# CPU0: cores 0-17, hyperthreaded cores 36-53
[pmem0]
filename=/dev/pmem0
# pick the desired cpus_allowed list
cpus_allowed=0,1,2,3
cpus_allowed=0,1,36,37
cpus_allowed=0,36
cpus_allowed=0,1
cpus_allowed=0
rw=randwrite

Although most CPU time is in movnti instructions (non-temporal stores),
there is overhead in clearing the page cache and in the pmem block
driver; those won't be present in your initialization function. 
perf top shows:
  82.00%  [kernel]                [k] memcpy_flushcache
   5.23%  [kernel]                [k] gup_pgd_range
   3.41%  [kernel]                [k] __blkdev_direct_IO_simple
   2.38%  [kernel]                [k] pmem_make_request
   1.46%  [kernel]                [k] write_pmem
   1.29%  [kernel]                [k] pmem_do_bvec


---
Robert Elliott, HPE Persistent Memory



