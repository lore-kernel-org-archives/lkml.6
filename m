Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D536BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7797823D74
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="h9t+cGz+";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OCjl4HM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7797823D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935836AbeF1Qsn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:48:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49078 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752157AbeF1Qsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:38 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGhUmh028544;
        Thu, 28 Jun 2018 09:48:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=49C5o5ozauIj9HRTdNUrEwudY2mFh9X56WT0lrsY9mg=;
 b=h9t+cGz+rhOT9669JBLqEdTunqX2Lf9uh3Jdv7SBCutgfyVO/Xm67WTvR1Hv3fHjApJh
 AMjH8WgluLMNXmdW3FiP1uXS1ZrLBTNwgeK/YST+mDN2cVhy2IXJ3ClW4jBDTByabz6H
 XMZzxk3xr+ckdBu9daJmYP503r32/WTRd3A= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jw36e842s-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:17 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49C5o5ozauIj9HRTdNUrEwudY2mFh9X56WT0lrsY9mg=;
 b=OCjl4HM2Hk6xxrFXyyWJimHKPN7cVzSpSPCvpNaVttd6N52UrLukndiGXPLmiNHo7aphYlfVMnBqBhDW0RFFg4lm7LElezG+rPjFIYVDMlvxjRAe5QMLupdsoEdSYZz7wz2WnYIyjUnN5q7+famXaC1yjc7sQ7mOe7iXjFIqSC4=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:47:54 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 00/14] bpf: cgroup local storage
Date:   Thu, 28 Jun 2018 09:47:05 -0700
Message-ID: <20180628164719.28215-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4716]
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d9c582e-2328-411b-1404-08d5dd16e58f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:K5oPKIKzCfifJVO/e8Dw/gHdwUcnHJ3mUwTwon2jGXXEbtpYwH6bOhJfpE3gN3IOdYKn83xSK9CsRSG2BdCqpV15MmO36RSG2KAdAZzrX8+59JJ8ivHZ+bjZL+Kbnz+lhXGK26oelcDyKv+mi4vtPgoQVX7nuB4OcxSVf+NjUNVqP08zET24L29BZ7VIXSBzHnFNso7qX2FzYu3+yeG10faLmQv8wBRa0N8B5li4KRTnC6DMaJGY1AxMuPJvqAeJ;25:nEhmEICcwEOYNf4YM9ztuFSVnOgyXMBgAlYK6DGFLqyYQaTinIN4wjzwDOoyUmktjV55dZpZ9YPkFRMdV3q6ouI+vAGtU88qyTkokTL+nVnOEK8GEaRyw1+A3hiBu1o51xaIP5kbaAl/nXp40pADOHcig8CRX6sjsBLwZj+JCX/jVNQQjza6vtlhnLV3yOGR3Nv892OdkgjudytzFua8ES3T7KtDQt0C0aI3bnTnkha6bcsaUDkuxqh3NDd2o/4nH8honf4illJJtq40pZOAujhBkEGz1dtvtcVcDN2ajwsg5KN3vH6VuAO7XlVObS0GowhS3jTCq0WwoUq+mtHZRQ==;31:E/MgmtLbu6AsgbAvoESLOPZp8i8puDE3Fl+GGtFB6sT/fi+zxQ/319amXMjB99ahUL7JTDDmBesrijZaqPwJnlgwYD9kVowMWhAGu/FlQEFu89Q4pT/Y1LKMj5Ju8mmHDmjlzL3S39SVItzIqoTloSAlFqU+xyL5zh5+FoHWFQ9DqX3Fbw1+rVBRXMPgSs2X+aB2nYrA+st4IDhmUuXSgacQxgDxGs0zsxCfP0f1TU0=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:Y6ycapIUJpSLCWPrnD/IiYl4b/GFWpKh7gtWsf85JWRkY5HPAK+3KdfYk0N+wOjTe8vEkkL5CgOiXNULRi+1XXO6f91hZBvyBcSoA5wwpq3e58TovCZK+WL0Bsp0ApuDwhM0fVw+d0/Wg9Mjib4nBhZTkSkXb931TKb3p7LncQo0PzWAjP3lS8Z75plryu2FyMs0Q2wVpHrH0qCBdj3SHfvVC667hOg0IOigFSm0iIoyXtHgqdIx17kDJ0F8uy7VmvB5MckCW63w0y5PbQX6aoK7E+XSbU7GrBpM8AHp13ptREj6NjNLOFLEaF9b8mA2uBw/lf6LZrBCkPfvhB5xvTpdllYvk557kvXv83Bc5qjch+QdD2CdgFeGSMO682+A5n6lV4x6j/+z1Y/xds2pMudySV+twnoAtmO3GLDrRruBZCfvqKl/XHqoIF4rGsSt3ADRwgl4TVd4GJFnC3Bb1JBGjzEbcaQda1BIFluRRqXCxHTW0iVypmvJAw4WyySU;4:fmQ8GYdidFQqYbjLByhW63VsHEutZV8ffR9riWb+n+gajK63e/3kUmLSTvTB76Fy1RExSc9GJINWMhAGwHE3Cl4J1uuK1UARV8UM9L0MArZqXR/UP23rqTAdN5Foschjc1a0Ehb0THnrimt+Huv+pieW/5IMyjvVZOpOXwxfWxoXNStgrIvvfGYuw3rl3GKkSBdN5egr2qc9OHR62F+LWqRRFOebO2qmwVmkLCjId3M2M7Q8r/8Btk3YU76Ok4ST6EV9XBktHK1bJdGpd1dUhXZvMOxD51QOzJ1SEqBaNzeh9FNoBeNBPhlBv5d7yvb0
X-Microsoft-Antispam-PRVS: <DM3PR15MB1081AC4779765DD1CC89FE25BE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(6666003)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(5024004)(14444005)(16586007)(54906003)(46003)(476003)(486006)(2351001)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:GQNuy18cvoSjcDDryFmS5E4OAbpEPyM3QBeijF1/M?=
 =?us-ascii?Q?x/MT0bqj6MfzgId0RR99TMmAUO40+5IC5bIjG+btEGqKZeh69NVXYV+s6LYS?=
 =?us-ascii?Q?zPWUgd+A+3NHtGmie8OEySsPlBCPLK+HH4Qno4c7kbWJDaokLgYl13aghoJV?=
 =?us-ascii?Q?763C0VK82535zPXMLXXBsSamWB/z2a1P1izfCT9YpKdQRybJz5GsDS39A7ME?=
 =?us-ascii?Q?j+5qd0PlPb5HIHCiAp2TqcdzHpv4sJ1Bh9GqCSqt7Sg/rjEV32LHJnpTLqcp?=
 =?us-ascii?Q?2iowsa5ykDO2B4Uw5/b5KMoREGgMrSkMnP7Zm9+zS2HQXFzymeXE6kIUjTyE?=
 =?us-ascii?Q?d6yEjX3i4fykHaZPzAqEZ59qduzasZXjAaLptu3YspoO7bs1Yh92WVmeK6zP?=
 =?us-ascii?Q?2qFCeM+1qnel4o5IIrDAIS2O1A08ujuuWRTbSfL8vojgkXKzgW+/wOOIUtyU?=
 =?us-ascii?Q?qb2VhyUsBJavJpSnpn2fqiphPaD95qeiul2qp8dm1qLXsuuRI9HhOCpb+th+?=
 =?us-ascii?Q?7rebVWy62j3cOpHH3WeWeQgFlLxHLSnF8su1JEh3oOQb4x1lVSfFKF2a98pI?=
 =?us-ascii?Q?1j4lhX9snWwZJb1pzaadh+ddg4dA8+evVyaOI7aAj28RyRF83MeAyiYCuYjv?=
 =?us-ascii?Q?m84yk4B8llZUDXw72fCj/53PqoCNOmixLi0MEKdsMupdPELKpqZofMUwdepV?=
 =?us-ascii?Q?dNRZhGcxGn3sUfGd061qeaHp1HSvH9t75Yrm3dKOZiUCjKg5TR+1SFuBBXoT?=
 =?us-ascii?Q?Uh+NORbk9OKU79QvCyHDr8S8hBAeQnBLCUe+ZhQOPxqpmRlAa6uHLI7X5f9b?=
 =?us-ascii?Q?VGHz0wj1sHG8uOprMktVRpYEnBce+YqwZaRjDKBniUwgKiWlQBHtzZwjoDCI?=
 =?us-ascii?Q?BqnNoHFex7UrBDoQ7rSna4BBBO4fqCyNOUCtTPTjb8iDQCDcqZ8DkMIz4TnW?=
 =?us-ascii?Q?QhiH361DNVp96Tu74hE6mslTh3wldOMF/bdEXrM+QlJQx9gTuKexrOlYSqPl?=
 =?us-ascii?Q?dk4yxP13z9QX/c6b6aC12ceMKPOjHOJH12NvCyyqFEQoAB+WqxZswSnY9kMN?=
 =?us-ascii?Q?Aw1lovxyEhvdkY4pH/DhxaGnZqpTpYcdJIZuVMHLpSkH05fXgpC8KlDR1+rL?=
 =?us-ascii?Q?qvL5V5bpZmuvO9d3/YM4IlkT/ak+CtmO0JBeT01Yz5Xse5wpmzZQ++okeC4A?=
 =?us-ascii?Q?It5wwOKZL5E+Huj1zKB3g1qM0OR3S2rFp7HcL7bL6iuTc73wb13HuSS2cHBJ?=
 =?us-ascii?Q?vma2NK8dFJ50PvU0mk=3D?=
X-Microsoft-Antispam-Message-Info: BreWuLcuot+6CBAlLipmOXjm/vz5nGikYbaMMdt7Sn2ZkdgtfzaIRUFz5nIzLKPtFDUILSunmNvQgLgM4sCQhfz0pqZG3G62Ve2kQFmuDv5EAkK5ZoR/JlIbuLx4nK78qN7Vz065BitNImqYlbsmcSw6sGv6AG0d+tIMKGnj3fonjP5fETPoRqBdOaYEoEc/sGWp7MEYJlR14yj8JAGTli1Woh0l06olftm2tVlUP5DJsWekqPjngUNFuH27BRATg6Rbi1IOckTPptDAxPDkhI3Lj+GaFYMzAECJ/wf2Inum6D70XyzWaTEiDcNgcGmHotLrYJGEE8ZgLiz3CL2nF9kulZ57TW9NyBEVVHgrqvc=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:wM7MA1vhSs+DfmPShGT5fuK2qbmo3vHp3ts3jhBE69wVsy2ZqhXQd0EuQX21AwDUhMqy2ysKNgOhdD+qKiGOqvotBjX17+78+5w2LMjBmJWItRTuVb4Fr9TskcT3byL61qdTiWG6RkdPBgG5qauP8f4RKCio6olORnhwR3tegEXo8GsYZuFZ31Z4l/SB5na7jQ8zvFzH1rCKa9AfJ87mE1AihnbRNfzOb4MZpgq2OGDSNltMuv/tk2n2IrGKMzEnhVvAP0g3cj1EbebyonEtJa9JAiGbcyCrcPQVpinSXPuK/E+bPtiosyfP7lRAnY9U6X35o5uWhoGmskvML00e/Sj4od5Y7CFcU0PBd4akQ/8YntQ6Pjk+rnqyJo9aerL62pr0RqoVqmaZ3nCpdZ/TGfrHxMwhCSNE0MVtsfbKIcvfBCDp+/olTaZxnpbI9euhK74ywE97eSMO1KpV7yaEMg==;5:KkuevtxtUz9Ry1aS17bdh5GMAUIMyrHVu48M6fCVhMvpvWmwL+vDraVPrElg1vYtYG/tEgMH3VzJfbF6cKFkEQJc/zp8g0MtpH45bSCs8iAKe+BiN6QH+njG3UmqiD0dqmfP41T5+xqul3rjH7RXyA3EjAtfp/as2asRz8UfLBQ=;24:KMhtb/1snGest9APPOmbdw9CY/+9jPameWSc2tRnmZll4MihEhv+6KfP8FGJwwU0MTDWJvlbotjKAiwZK1mY2MVEiLQxnx3NZUEDkAxHtyM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:R+lSrZyEFehsWnYGoJUQi7xPZ8ir5rMCbLGR5K3uF+L9NcVBM5pN/A8J/RKyNDY4RtcyH+c969XSD3gOSqspW5Owv8y5luC7py4fn34DQF+6XwWiNbQe/GC1ZwsxG1PyTeJFhtR6vrbD534EHNSzqzxJU2+UYzQmSNNoKrXYilGaoEiKgEgqczi/kMbF5zgl9ZUrrFoU37fp873vARGNtURdTeOhAEcTdLp/kNh2JbcmA/ZKfQ/t7h+OGbgXzF9O;20:aTRookr8vTd3Vl6TNUSVBL1UfuSjIMZgo3rAf/GehlBtzScpMVIPgTXPt9s7V//756H9VFgJonQ42vXeOTJ2uost0/fXlRUisqMhTxH6Yc7aIaTWDPd6QNFHNr76Tv9+3QK8rmGCdpfotK8HBWvvSvGNJJaFUi9wsRf5vj53tVA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:47:54.5046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9c582e-2328-411b-1404-08d5dd16e58f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1081
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements cgroup local storage for bpf programs.
The main idea is to provide a fast accessible memory for storing
various per-cgroup data, e.g. number of transmitted packets.

Cgroup local storage looks as a special type of map for userspace,
and is accessible using generic bpf maps API for reading and
updating of the data. The (cgroup inode id, attachment type) pair
is used as a map key.

A user can't create new entries or destroy existing entries;
it happens automatically when a user attaches/detaches a bpf program
to a cgroup.

From a bpf program's point of view, cgroup storage is accessible
without lookup using the special get_local_storage() helper function.
It takes a map fd as an argument. It always returns a valid pointer
to the corresponding memory area.
To implement such a lookup-free access a pointer to the cgroup
storage is saved for an attachment of a bpf program to a cgroup,
if required by the program. Before running the program, it's saved
in a special global per-cpu variable, which is accessible from the
get_local_storage() helper.

This patchset implement only cgroup local storage, however the API
is intentionally made extensible to support other local storage types
further: e.g. thread local storage, socket local storage, etc.

Patch (1) adds an ability to charge bpf maps for consuming memory
dynamically.
Patch (2) introduces cgroup storage maps.
Patch (3) implements a mechanism to pass cgroup storage pointer
to a bpf program.
Patch (4) implements allocation/releasing of cgroup local storage
on attaching/detaching of a bpf program to/from a cgroup.
Patch (5) extends bpf_prog_array to store cgroup storage pointers.
Patch (6) introduces BPF_PTR_TO_MAP_VALUE, required to skip
non-necessary NULL-check in bpf programs.
Patch (7) disables creation of maps of cgroup storage maps.
Patch (8) introduces the get_local_storage() helper.
Patch (9) syncs bpf.h to tools/.
Patch (10) adds cgroup storage maps support to bpftool.
Patch (11) adds support for testing programs which are using
cgroup storage without actually attaching them to cgroups.
Patches (12), (13) and (14) are adding necessary tests.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>

Roman Gushchin (14):
  bpf: add ability to charge bpf maps memory dynamically
  bpf: introduce cgroup storage maps
  bpf: pass a pointer to a cgroup storage using pcpu variable
  bpf: allocate cgroup storage entries on attaching bpf programs
  bpf: extend bpf_prog_array to store pointers to the cgroup storage
  bpf/verifier: introduce BPF_PTR_TO_MAP_VALUE
  bpf: don't allow create maps of cgroup local storages
  bpf: introduce the bpf_get_local_storage() helper function
  bpf: sync bpf.h to tools/
  bpftool: add support for CGROUP_STORAGE maps
  bpf/test_run: support cgroup local storage
  selftests/bpf: add verifier cgroup storage tests
  selftests/bpf: add a cgroup storage test
  samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage

 include/linux/bpf-cgroup.h                        |  53 ++++
 include/linux/bpf.h                               |  25 +-
 include/linux/bpf_types.h                         |   3 +
 include/uapi/linux/bpf.h                          |  19 +-
 kernel/bpf/Makefile                               |   1 +
 kernel/bpf/cgroup.c                               |  54 +++-
 kernel/bpf/core.c                                 |  76 ++---
 kernel/bpf/helpers.c                              |  20 ++
 kernel/bpf/local_storage.c                        | 369 ++++++++++++++++++++++
 kernel/bpf/map_in_map.c                           |   3 +-
 kernel/bpf/syscall.c                              |  53 +++-
 kernel/bpf/verifier.c                             |  38 ++-
 net/bpf/test_run.c                                |  13 +-
 net/core/filter.c                                 |  23 +-
 samples/bpf/test_cgrp2_attach2.c                  |  27 +-
 tools/bpf/bpftool/map.c                           |   1 +
 tools/include/uapi/linux/bpf.h                    |   9 +-
 tools/testing/selftests/bpf/Makefile              |   4 +-
 tools/testing/selftests/bpf/bpf_helpers.h         |   2 +
 tools/testing/selftests/bpf/test_cgroup_storage.c | 130 ++++++++
 tools/testing/selftests/bpf/test_verifier.c       | 123 +++++++-
 21 files changed, 965 insertions(+), 81 deletions(-)
 create mode 100644 kernel/bpf/local_storage.c
 create mode 100644 tools/testing/selftests/bpf/test_cgroup_storage.c

-- 
2.14.4

