Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA0C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DE42070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="wKYz7c3r";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="ZyNpkczz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfADNoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:44:34 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:33020 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbfADNod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:44:33 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x04Dfhv9004643;
        Fri, 4 Jan 2019 05:44:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=NPH4xznB9ploF17IuG46MV5f22Kgn+He9qoJSUPa5v4=;
 b=wKYz7c3rPsjLuB9io1KveL17A26hnno2zmL9ie3PBSBJYRNCvwd8eTvhiDKXByo1rNNd
 AajkT760+AGApKjByuZzecPWPu7qCDMdC1ZQJ9T3xDTUlhAH2ezDPoRP7e12B9/BEH+v
 8VJVoATTy8NMzDe5G5rmbD/J71jPuu727egCdP+zsVP1BHr12tA0Wd3/j+2PY3Mj8yZo
 sIuaOE3by0nOfa5N4Trh+cAeu6Qf7HLuIjJDcUQXfzX2YAKScYjqfCT2fmTMu4pOY+OW
 PS0J55XHG2N0h2NRBD5kaZ1frHBayuyFMHLXvsJXbgJT47/MMSgv3baeKTuEfD5p933L zw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2pt5868p5t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 04 Jan 2019 05:44:14 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 4 Jan
 2019 05:44:13 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.58) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 4 Jan 2019 05:44:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPH4xznB9ploF17IuG46MV5f22Kgn+He9qoJSUPa5v4=;
 b=ZyNpkczzNReshBVuPVT+c1jWMiZmdVqF/HPhv+zNhqJoN3idLG3z3i6LTBChj5MP+tjXwKdqSJKJsLEiuoACIQ61SqZDvU3gFyDzi1yPoERbKq4n5skTrmAIpCvsjX8T70kzXjGm3m32xYaDwuJ+tLw0ZD3c8do4qA4nn7VZ2TE=
Received: from DM6PR18MB2460.namprd18.prod.outlook.com (20.179.104.155) by
 DM6PR18MB2524.namprd18.prod.outlook.com (20.179.105.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Fri, 4 Jan 2019 13:44:12 +0000
Received: from DM6PR18MB2460.namprd18.prod.outlook.com
 ([fe80::3c7d:da4:1834:1b92]) by DM6PR18MB2460.namprd18.prod.outlook.com
 ([fe80::3c7d:da4:1834:1b92%2]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 13:44:11 +0000
From:   Shijith Thotton <sthotton@marvell.com>
To:     Steve Sistare <steven.sistare@oracle.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "subhra.mazumdar@oracle.com" <subhra.mazumdar@oracle.com>,
        "dhaval.giani@oracle.com" <dhaval.giani@oracle.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "pavel.tatashin@microsoft.com" <pavel.tatashin@microsoft.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "umgwanakikbuti@gmail.com" <umgwanakikbuti@gmail.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "jbacik@fb.com" <jbacik@fb.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "quentin.perret@arm.com" <quentin.perret@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>
Subject: Re: [PATCH v4 00/10] steal tasks to improve CPU utilization
Thread-Topic: [PATCH v4 00/10] steal tasks to improve CPU utilization
Thread-Index: AQHUpDOSZxJ32b3lhEuAP0n2vJQx6g==
Date:   Fri, 4 Jan 2019 13:44:11 +0000
Message-ID: <DM6PR18MB246030C5A36973675B7DF38ED98E0@DM6PR18MB2460.namprd18.prod.outlook.com>
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [106.51.107.105]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR18MB2524;20:IfXPuQlRKbcLtqcjA1XzynkV3X5+s5OfRAhXneLoJwwbbB9ZsvtTVz1QbhsOr6lQzHoQj8F2l26Bh9LLtjUQwhy3K3xcWPKAzEC7nv8Thqzd7ZfPe4IIfRhmRaA31aq6z1alZbjFsAZC4QjxG5Hx6ed1FT7pgwqI6FYbFutF1JA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(199004)(189003)(4744004)(9456002)(6346003)(6436002)(74316002)(256004)(14444005)(71200400001)(5024004)(19627235002)(105586002)(229853002)(25786009)(446003)(478600001)(186003)(78486014)(68736007)(71190400001)(26005)(476003)(486006)(76176011)(3846002)(66066001)(7696005)(6116002)(53546011)(97736004)(7736002)(55236004)(102836004)(6506007)(8676002)(8936002)(81166006)(81156014)(305945005)(5660300001)(6246003)(53936002)(2906002)(2501003)(33656002)(316002)(7416002)(39060400002)(107886003)(55016002)(14454004)(54906003)(99286004)(106356001)(2201001)(9686003)(4326008)(86362001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR18MB2524;H:DM6PR18MB2460.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 6e083d15-ef6b-484e-de1e-08d6724ab575
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR18MB2524;
x-ms-traffictypediagnostic: DM6PR18MB2524:
x-microsoft-antispam-prvs: <DM6PR18MB252472B16D9321BF5A600EC3D98E0@DM6PR18MB2524.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR18MB2524;BCL:0;PCL:0;RULEID:;SRVR:DM6PR18MB2524;
x-forefront-prvs: 0907F58A24
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KMIGq13MbXi8pM9+jGV1exaCxoF6fXQfDQIKey0gepb2ld6Ch75XPLxgOmBm3EYyNIHq7s20lyMIL88AO+mdJYXJlfIQjUZlFqW/K25kMBlo99iBn2+2u9IMVMfsGewNsGqSn2BKhVSFyI7RkVC/zScR66NTHCspg3XfhVdxAMRFLPxkNWkCk1jPjpoEXSJts7RvTo0hn7+xnJxkHRk9UPSEClctY3t8GCPFQ3bi/NWmYPNFI7YGT+fhmRpvgb53pkTtrXsx4A65ijSVgB1Hjb+pbBO5AHnFMY1J8GxW+KVMtkISSk9pvMTpzC0PcaMa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e083d15-ef6b-484e-de1e-08d6724ab575
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 13:44:11.5332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2524
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-04_05:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901040121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Dec-18 3:09 AM, Steve Sistare wrote:=0A=
> =0A=
> When a CPU has no more CFS tasks to run, and idle_balance() fails to=0A=
> find a task, then attempt to steal a task from an overloaded CPU in the=
=0A=
> same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently=0A=
> identify candidates.  To minimize search time, steal the first migratable=
=0A=
> task that is found when the bitmap is traversed.  For fairness, search=0A=
> for migratable tasks on an overloaded CPU in order of next to run.=0A=
> =0A=
> This simple stealing yields a higher CPU utilization than idle_balance()=
=0A=
> alone, because the search is cheap, so it may be called every time the CP=
U=0A=
> is about to go idle.  idle_balance() does more work because it searches=
=0A=
> widely for the busiest queue, so to limit its CPU consumption, it decline=
s=0A=
> to search if the system is too busy.  Simple stealing does not offload th=
e=0A=
> globally busiest queue, but it is much better than running nothing at all=
.=0A=
> =0A=
> The bitmap of overloaded CPUs is a new type of sparse bitmap, designed to=
=0A=
> reduce cache contention vs the usual bitmap when many threads concurrentl=
y=0A=
> set, clear, and visit elements.=0A=
> =0A=
> Patch 1 defines the sparsemask type and its operations.=0A=
> =0A=
> Patches 2, 3, and 4 implement the bitmap of overloaded CPUs.=0A=
> =0A=
> Patches 5 and 6 refactor existing code for a cleaner merge of later=0A=
>    patches.=0A=
> =0A=
> Patches 7 and 8 implement task stealing using the overloaded CPUs bitmap.=
=0A=
> =0A=
> Patch 9 disables stealing on systems with more than 2 NUMA nodes for the=
=0A=
> time being because of performance regressions that are not due to stealin=
g=0A=
> per-se.  See the patch description for details.=0A=
> =0A=
> Patch 10 adds schedstats for comparing the new behavior to the old, and=
=0A=
>    provided as a convenience for developers only, not for integration.=0A=
> =0A=
> The patch series is based on kernel 4.20.0-rc1.  It compiles, boots, and=
=0A=
> runs with/without each of CONFIG_SCHED_SMT, CONFIG_SMP, CONFIG_SCHED_DEBU=
G,=0A=
> and CONFIG_PREEMPT.  It runs without error with CONFIG_DEBUG_PREEMPT +=0A=
> CONFIG_SLUB_DEBUG + CONFIG_DEBUG_PAGEALLOC + CONFIG_DEBUG_MUTEXES +=0A=
> CONFIG_DEBUG_SPINLOCK + CONFIG_DEBUG_ATOMIC_SLEEP.  CPU hot plug and CPU=
=0A=
> bandwidth control were tested.=0A=
> =0A=
> Stealing improves utilization with only a modest CPU overhead in schedule=
r=0A=
> code.  In the following experiment, hackbench is run with varying numbers=
=0A=
> of groups (40 tasks per group), and the delta in /proc/schedstat is shown=
=0A=
> for each run, averaged per CPU, augmented with these non-standard stats:=
=0A=
> =0A=
>    %find - percent of time spent in old and new functions that search for=
=0A=
>      idle CPUs and tasks to steal and set the overloaded CPUs bitmap.=0A=
> =0A=
>    steal - number of times a task is stolen from another CPU.=0A=
> =0A=
> X6-2: 1 socket * 10 cores * 2 hyperthreads =3D 20 CPUs=0A=
> Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz=0A=
> hackbench <grps> process 100000=0A=
> sched_wakeup_granularity_ns=3D15000000=0A=
> =0A=
>    baseline=0A=
>    grps  time  %busy  slice   sched   idle     wake %find  steal=0A=
>    1    8.084  75.02   0.10  105476  46291    59183  0.31      0=0A=
>    2   13.892  85.33   0.10  190225  70958   119264  0.45      0=0A=
>    3   19.668  89.04   0.10  263896  87047   176850  0.49      0=0A=
>    4   25.279  91.28   0.10  322171  94691   227474  0.51      0=0A=
>    8   47.832  94.86   0.09  630636 144141   486322  0.56      0=0A=
> =0A=
>    new=0A=
>    grps  time  %busy  slice   sched   idle     wake %find  steal  %speedu=
p=0A=
>    1    5.938  96.80   0.24   31255   7190    24061  0.63   7433  36.1=0A=
>    2   11.491  99.23   0.16   74097   4578    69512  0.84  19463  20.9=0A=
>    3   16.987  99.66   0.15  115824   1985   113826  0.77  24707  15.8=0A=
>    4   22.504  99.80   0.14  167188   2385   164786  0.75  29353  12.3=0A=
>    8   44.441  99.86   0.11  389153   1616   387401  0.67  38190   7.6=0A=
> =0A=
> Elapsed time improves by 8 to 36%, and CPU busy utilization is up=0A=
> by 5 to 22% hitting 99% for 2 or more groups (80 or more tasks).=0A=
> The cost is at most 0.4% more find time.=0A=
> =0A=
> Additional performance results follow.  A negative "speedup" is a=0A=
> regression.  Note: for all hackbench runs, sched_wakeup_granularity_ns=0A=
> is set to 15 msec.  Otherwise, preemptions increase at higher loads and=
=0A=
> distort the comparison between baseline and new.=0A=
> =0A=
> ------------------ 1 Socket Results ------------------=0A=
> =0A=
> X6-2: 1 socket * 10 cores * 2 hyperthreads =3D 20 CPUs=0A=
> Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz=0A=
> Average of 10 runs of: hackbench <groups> process 100000=0A=
> =0A=
>              --- base --    --- new ---=0A=
>    groups    time %stdev    time %stdev  %speedup=0A=
>         1   8.008    0.1   5.905    0.2      35.6=0A=
>         2  13.814    0.2  11.438    0.1      20.7=0A=
>         3  19.488    0.2  16.919    0.1      15.1=0A=
>         4  25.059    0.1  22.409    0.1      11.8=0A=
>         8  47.478    0.1  44.221    0.1       7.3=0A=
> =0A=
> X6-2: 1 socket * 22 cores * 2 hyperthreads =3D 44 CPUs=0A=
> Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz=0A=
> Average of 10 runs of: hackbench <groups> process 100000=0A=
> =0A=
>              --- base --    --- new ---=0A=
>    groups    time %stdev    time %stdev  %speedup=0A=
>         1   4.586    0.8   4.596    0.6      -0.3=0A=
>         2   7.693    0.2   5.775    1.3      33.2=0A=
>         3  10.442    0.3   8.288    0.3      25.9=0A=
>         4  13.087    0.2  11.057    0.1      18.3=0A=
>         8  24.145    0.2  22.076    0.3       9.3=0A=
>        16  43.779    0.1  41.741    0.2       4.8=0A=
> =0A=
> KVM 4-cpu=0A=
> Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz=0A=
> tbench, average of 11 runs.=0A=
> =0A=
>    clients    %speedup=0A=
>          1        16.2=0A=
>          2        11.7=0A=
>          4         9.9=0A=
>          8        12.8=0A=
>         16        13.7=0A=
> =0A=
> KVM 2-cpu=0A=
> Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz=0A=
> =0A=
>    Benchmark                     %speedup=0A=
>    specjbb2015_critical_jops          5.7=0A=
>    mysql_sysb1.0.14_mutex_2          40.6=0A=
>    mysql_sysb1.0.14_oltp_2            3.9=0A=
> =0A=
> ------------------ 2 Socket Results ------------------=0A=
> =0A=
> X6-2: 2 sockets * 10 cores * 2 hyperthreads =3D 40 CPUs=0A=
> Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz=0A=
> Average of 10 runs of: hackbench <groups> process 100000=0A=
> =0A=
>              --- base --    --- new ---=0A=
>    groups    time %stdev    time %stdev  %speedup=0A=
>         1   7.945    0.2   7.219    8.7      10.0=0A=
>         2   8.444    0.4   6.689    1.5      26.2=0A=
>         3  12.100    1.1   9.962    2.0      21.4=0A=
>         4  15.001    0.4  13.109    1.1      14.4=0A=
>         8  27.960    0.2  26.127    0.3       7.0=0A=
> =0A=
> X6-2: 2 sockets * 22 cores * 2 hyperthreads =3D 88 CPUs=0A=
> Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz=0A=
> Average of 10 runs of: hackbench <groups> process 100000=0A=
> =0A=
>              --- base --    --- new ---=0A=
>    groups    time %stdev    time %stdev  %speedup=0A=
>         1   5.826    5.4   5.840    5.0      -0.3=0A=
>         2   5.041    5.3   6.171   23.4     -18.4=0A=
>         3   6.839    2.1   6.324    3.8       8.1=0A=
>         4   8.177    0.6   7.318    3.6      11.7=0A=
>         8  14.429    0.7  13.966    1.3       3.3=0A=
>        16  26.401    0.3  25.149    1.5       4.9=0A=
> =0A=
> =0A=
> X6-2: 2 sockets * 22 cores * 2 hyperthreads =3D 88 CPUs=0A=
> Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz=0A=
> Oracle database OLTP, logging disabled, NVRAM storage=0A=
> =0A=
>    Customers   Users   %speedup=0A=
>      1200000      40       -1.2=0A=
>      2400000      80        2.7=0A=
>      3600000     120        8.9=0A=
>      4800000     160        4.4=0A=
>      6000000     200        3.0=0A=
> =0A=
> X6-2: 2 sockets * 14 cores * 2 hyperthreads =3D 56 CPUs=0A=
> Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz=0A=
> Results from the Oracle "Performance PIT".=0A=
> =0A=
>    Benchmark                                           %speedup=0A=
> =0A=
>    mysql_sysb1.0.14_fileio_56_rndrd                        19.6=0A=
>    mysql_sysb1.0.14_fileio_56_seqrd                        12.1=0A=
>    mysql_sysb1.0.14_fileio_56_rndwr                         0.4=0A=
>    mysql_sysb1.0.14_fileio_56_seqrewr                      -0.3=0A=
> =0A=
>    pgsql_sysb1.0.14_fileio_56_rndrd                        19.5=0A=
>    pgsql_sysb1.0.14_fileio_56_seqrd                         8.6=0A=
>    pgsql_sysb1.0.14_fileio_56_rndwr                         1.0=0A=
>    pgsql_sysb1.0.14_fileio_56_seqrewr                       0.5=0A=
> =0A=
>    opatch_time_ASM_12.2.0.1.0_HP2M                          7.5=0A=
>    select-1_users-warm_asmm_ASM_12.2.0.1.0_HP2M             5.1=0A=
>    select-1_users_asmm_ASM_12.2.0.1.0_HP2M                  4.4=0A=
>    swingbenchv3_asmm_soebench_ASM_12.2.0.1.0_HP2M           5.8=0A=
> =0A=
>    lm3_memlat_L2                                            4.8=0A=
>    lm3_memlat_L1                                            0.0=0A=
> =0A=
>    ub_gcc_56CPUs-56copies_Pipe-based_Context_Switching     60.1=0A=
>    ub_gcc_56CPUs-56copies_Shell_Scripts_1_concurrent        5.2=0A=
>    ub_gcc_56CPUs-56copies_Shell_Scripts_8_concurrent       -3.0=0A=
>    ub_gcc_56CPUs-56copies_File_Copy_1024_bufsize_2000_maxblocks 2.4=0A=
> =0A=
> X5-2: 2 sockets * 18 cores * 2 hyperthreads =3D 72 CPUs=0A=
> Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz=0A=
> =0A=
>    NAS_OMP=0A=
>    bench class   ncpu    %improved(Mops)=0A=
>    dc    B       72      1.3=0A=
>    is    C       72      0.9=0A=
>    is    D       72      0.7=0A=
> =0A=
>    sysbench mysql, average of 24 runs=0A=
>            --- base ---     --- new ---=0A=
>    nthr   events  %stdev   events  %stdev %speedup=0A=
>       1    331.0    0.25    331.0    0.24     -0.1=0A=
>       2    661.3    0.22    661.8    0.22      0.0=0A=
>       4   1297.0    0.88   1300.5    0.82      0.2=0A=
>       8   2420.8    0.04   2420.5    0.04     -0.1=0A=
>      16   4826.3    0.07   4825.4    0.05     -0.1=0A=
>      32   8815.3    0.27   8830.2    0.18      0.1=0A=
>      64  12823.0    0.24  12823.6    0.26      0.0=0A=
> =0A=
> --------------------------------------------------------------=0A=
> =0A=
> Changes from v1 to v2:=0A=
>    - Remove stray find_time hunk from patch 5=0A=
>    - Fix "warning: label out defined but not used" for !CONFIG_SCHED_SMT=
=0A=
>    - Set SCHED_STEAL_NODE_LIMIT_DEFAULT to 2=0A=
>    - Steal iff avg_idle exceeds the cost of stealing=0A=
> =0A=
> Changes from v2 to v3:=0A=
>    - Update series for kernel 4.20.  Context changes only.=0A=
> =0A=
> Changes from v3 to v4:=0A=
>    - Avoid 64-bit division on 32-bit processors in compute_skid()=0A=
>    - Replace IF_SMP with inline functions to set idle_stamp=0A=
>    - Push ZALLOC_MASK body into calling function=0A=
>    - Set rq->cfs_overload_cpus in update_top_cache_domain instead of=0A=
>      cpu_attach_domain=0A=
>    - Rewrite sparsemask iterator for complete inlining=0A=
>    - Cull and clean up sparsemask functions and moved all into=0A=
>      sched/sparsemask.h=0A=
> =0A=
> Steve Sistare (10):=0A=
>    sched: Provide sparsemask, a reduced contention bitmap=0A=
>    sched/topology: Provide hooks to allocate data shared per LLC=0A=
>    sched/topology: Provide cfs_overload_cpus bitmap=0A=
>    sched/fair: Dynamically update cfs_overload_cpus=0A=
>    sched/fair: Hoist idle_stamp up from idle_balance=0A=
>    sched/fair: Generalize the detach_task interface=0A=
>    sched/fair: Provide can_migrate_task_llc=0A=
>    sched/fair: Steal work from an overloaded CPU when CPU goes idle=0A=
>    sched/fair: disable stealing if too many NUMA nodes=0A=
>    sched/fair: Provide idle search schedstats=0A=
> =0A=
>   include/linux/sched/topology.h |   1 +=0A=
>   kernel/sched/core.c            |  31 +++-=0A=
>   kernel/sched/fair.c            | 354 ++++++++++++++++++++++++++++++++++=
+++----=0A=
>   kernel/sched/features.h        |   6 +=0A=
>   kernel/sched/sched.h           |  13 +-=0A=
>   kernel/sched/sparsemask.h      | 210 ++++++++++++++++++++++++=0A=
>   kernel/sched/stats.c           |  11 +-=0A=
>   kernel/sched/stats.h           |  13 ++=0A=
>   kernel/sched/topology.c        | 121 +++++++++++++-=0A=
>   9 files changed, 726 insertions(+), 34 deletions(-)=0A=
>   create mode 100644 kernel/sched/sparsemask.h=0A=
> =0A=
> --=0A=
> 1.8.3.1=0A=
> =0A=
> =0A=
=0A=
Hi Steve,=0A=
=0A=
Tried your patchset on ThunderX2 with 2 nodes. Please find my observations =
below.=0A=
=0A=
Hackbench was run on single node due to variance on 2 nodes and it showed=
=0A=
improvement under load.=0A=
=0A=
Single node hackbench numbers:=0A=
group    old time       new time        steals          %change=0A=
1        6.717           7.275           21              -8.31=0A=
2        8.449           9.268           106             -9.69=0A=
3        12.035          12.761          173071          -6.03=0A=
4        14.648          9.787           595889           33.19=0A=
8        22.513          18.329          2397394          18.58=0A=
16       39.861          36.263          3949903          9.06=0A=
=0A=
column "new time" shows hackbench runtime in seconds with the patchset.=0A=
=0A=
Tried below benchmarks with 2 nodes, but no performance benefit/degradation=
 was=0A=
observed on multiple runs.=0A=
   - MySQL (read/write/PS etc with sysbench)=0A=
   - HHVM running oss-performance benchmarks=0A=
=0A=
Shijith=0A=
