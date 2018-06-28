Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB2DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250F827334
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CuHlPTsz";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="F9EM0uDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250F827334
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935885AbeF1QuC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:50:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56956 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935796AbeF1Qsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:33 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGkYvf013481;
        Thu, 28 Jun 2018 09:48:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=bORC1JD0YP835z1QFQWDyQXRjeP3qHZESb5m6qq3qEU=;
 b=CuHlPTszo/5kKA4q6gOxq0a09fAEiSYvz/k0YsQTo4lVHBWlRDCh90I/1ii+u4MwJsm5
 qe3nBOJjNGV4vJvwZ/bdfqK3fIQT6W7K9fuW5Pu8zuWivrRdLFetLWM/ecTt1Wk7RSsh
 1eWOcbI5egpDY0C6SnPEYB/jE8wsW+p0Xeg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2jw2u00757-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:13 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bORC1JD0YP835z1QFQWDyQXRjeP3qHZESb5m6qq3qEU=;
 b=F9EM0uDeIt4r4KX0xGMDJyaXJxNHgFN1uLJpc3yibWqrRmDbH0+c0mGjuCYYjBKu87mGeuuY6ITPJLA5gR3idAW9ryHISDaJ44ILB/p2rIAyLX36/NIl6x+Xa67+sFS7motFQM8aYg8dwOFqNQM0Zg98/LzmG3tyxg6UPktG+74=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:48:08 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 11/14] bpf/test_run: support cgroup local storage
Date:   Thu, 28 Jun 2018 09:47:16 -0700
Message-ID: <20180628164719.28215-12-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628164719.28215-1-guro@fb.com>
References: <20180628164719.28215-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4716]
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cddd9c3-d1e7-4356-c9ee-08d5dd16edab
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:AxRhajtYXT60kMwyUS5UCy5XwAYb/L2G/4M15G3wYAB+BdPsEkzg0KCHuzCC7b3e7EILK/xlnqSfDS3LaFk+GWk9eYxVbWlURFaZEBmoM8CibrGJoRsgK560cZkhIhvA0OAvriFyMo1EwLRb0SeIlGxcQvtp2/5gZJMJe1h8U/rbhCfgxjMTNI0G9GNi763WbZpamBo0W5F6SGdLGnBKTNmydFnZ8xWkwMuhV+FVWusv/oskkK3ZbHZqgrEy0H0r;25:xvdo/mbmmybbV70Sip1WhROlf7BIIPxSY7h7FwiMAo2pmEQa1BoEJo7blpEopTWNIdHDhlbvE6GtyaIE3zCderncBResVgWpzOQ0U/NykD0q/5UJ5XAHY5CROWjF8kJAOLyCFUs/kBvnLkuE5sh0KEc9N1b2GDBIySQ9uSdZCTIPzSwmym12+xg0zWtFzIwKRIxj4HEdtb8QYv5tFmMDIRJAJZC3Jw3W3x1xqFVrM41YN9VX+1com4LTTTIzXxG49eVSSbZ6bZ3AV4jiIycTxUq5AUNrXcFgBsbz5MH/k+ifBZvNtJ47DvJavCfi5O6HGzssWhdNpoLcJQVE+L8EPg==;31:22rwbx1AAvRWePUWdmdNAXgjYZL3BmppVb75ZozDM8GM94WpqC/1kQ38NIOVuIGYPqIc9eBs0Zhi+A9hABKvSOKDEfJrYL8dlWj5vFvrez1O8mvsrEGM13Bsx5tym6LErSNDeiyvKZc6KsRV9mZ9rIC3hTOfxKIlfI1VEA0ytSdSzSxtyO+92pNz1bw4p52mA2G+NmuTcZ06e8b2f+3XosZGjKfCcfhT7y8TnbdO8IU=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:8BAMS1XeqHm4aT2f/C8Ar9jXJv/sIeePn6SkaO2yJsMKCoIIozraNEZ4tSgKKTnobcQaVqWA3WCbCSPYHjx2cBJ90Zb4lHCP2fHJcPlZNOy06QQqzJxXrf5vG2Ik3BSGqZCitRpQxYyuCd65QK8XP3U+LZQIYHkHk/3wj7YnmC0MuuuPpg5CNUvoOT7HJEFM6+nEySz9kNuky5JE+fzEmKDC8lsZEJS6jsdb1924vdAea9YYetYEm9KW4BSJPwWUxO719QpiW1a4M1aROKoCUIz8DU2IYZcjlgGEZ+iWuZRjE0Hnhx4T9GLZ9RC5MSEBJmSY/HsIc0phdEl9w2d8su+LO9WEjF1zWqmRLGLOna3UC85otAg39KmJdQTc31iE1a39CpA67Yv5KxIY2v1geyllBv5NqXOaqN3KDGHm3ZmS1Fl878iPsVVrnww8xqC9HGe62OXJ7xUyp55AUXrrNJn8pzK+gyprsbNyzNZbHNKwCQOetb0DCURpUhQqrdhK;4:5QLLgtTtASGR5LhYdBNGBO8wSTKIpVPuRDCsiB5V5+3eoCr92B3laphJW30i3duV0CiginlXQXZ4epiCuwpPeEY9AkPf0E5AceRzhPg+1VZY8fkGx8bFMXu6+I91eMXn9TGhfMdFskLFnJH8wigq4QMrScZc6OnjtIoF0UKpjwLc9ufOErS/FP+Zxhph3iQt/SYUYd5tjMjVw7OYTwFmMCdqKLGnN1L2PaXbZqQkP7+6adGZNDHiWl2E/vlS3+5pNMWBi6hu0GvjVcXkfnoZpSIPNj+SFqUvIPMFicavGA7Js531134reh3vJ3nOJhQE
X-Microsoft-Antispam-PRVS: <DM3PR15MB108116B3BA1B3AAE4C785949BE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(6666003)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(5024004)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:hJzaqfLaL8v7e6P0B/EOKrbawspFJQgljVuoX2ztf?=
 =?us-ascii?Q?+rn35zfjADxVZ+CnhtHV3JZrWmsGWTYxfYSrtVaYQKDkcQTZKO1ymjNVJGGw?=
 =?us-ascii?Q?2K6yn6VcgyqYY6q0/t5+PthWo73PorI/XfLbEtCE0g31yuwsrrFXOPHzULKR?=
 =?us-ascii?Q?jmFzKaIDzQqA+cQkJCaS0PSxlLL50OpaLwhM78zd5UaqQ6xCoEu0NQrLmRO6?=
 =?us-ascii?Q?xqZVKhF/HTJKKI7hWiK1DyEiJOMz82ZYO+kSBgIY3amb6zdYy6uB1AMuwmgY?=
 =?us-ascii?Q?ewuP5+jwKCYc+U9x3sMJoX6tDlfdx+jpPfhfJ7lcwXjYmk4Anqm2g7ufX2ga?=
 =?us-ascii?Q?GuJw1uezTK4LEWIs/LNwAbK8jNX8L811aKZmV7+gx/FW8o+YfrMVvTASGp++?=
 =?us-ascii?Q?xQOuRQR4XhQjjXtYdqO6+dIuRO7zXjWwI1H+CGRhZdNW2NVDwNp6y4ZdRfap?=
 =?us-ascii?Q?W5/8+3OOIQUUUXAFgBaET71S+L49PFRTfVE1OppaC0wd2AjzMZI/oDV6W4Tx?=
 =?us-ascii?Q?ehcqCG6EZcbXCOLWUQh68bl5QBlzjjE/ug196IMuI+p3h5u9IW6zhEmAwiBF?=
 =?us-ascii?Q?p4xoWTzD8PmoezZXm8ETstCIXkCUqjANQVmrKYAfnMp1XPDCOeTwDCjoXE1P?=
 =?us-ascii?Q?NzWxVLdQcs5h8DuswE+72QTTVrLtO8H9AFM1X/Pz+YK/tJbdydk/kbgf7uTc?=
 =?us-ascii?Q?hb4WUff4IjwXmJPu9KQUt23Mg/8GlxjZMdaoGMCAT9/LXxan6dzs9mSZJnS+?=
 =?us-ascii?Q?ZUXB3xPa+T2VEgDXYt6gbJ/wTB5wMjkZTzNYeT0uq6NFqj9b1xHJ5EpspXNN?=
 =?us-ascii?Q?VLCnkNfEitbRyEVyf85ckDKrRDjeMnOTM6HXND4a7Nd/04xpaBTZhhztc8Rn?=
 =?us-ascii?Q?FWDjpgzY2ICpfa/HZvIOtkwFs9tvWkX86H3+QH4sc0FYOV+PtBTdfTALT0BT?=
 =?us-ascii?Q?RQTLDo+PvTl+BOFpEpVCTm5APyMlTZefoFFrGXw6gQ8lbyNJDDuZxs79/AHd?=
 =?us-ascii?Q?STym6vknxUTqM4Tu7G06y7gVmtGmCS8DeL8gstWT6HsfeSgdD2Ls1q3ofwbT?=
 =?us-ascii?Q?SekKkgQPOFCTXo8EJ7w1EAP7HAQTsVydrKP2tM6Y//Z/mGgMMQEaxfezX8f4?=
 =?us-ascii?Q?ARiM2xHuQ3/sfF73rxOurmdEOKbUcdtZGZNZqctI+GcoPXrEHR5idP6Dj+tw?=
 =?us-ascii?Q?AzKwkG82wRYDtnNu93bhhxKYd0EDQKKZK8jtjMGOX828MXB5g/ZlUCSkMmyu?=
 =?us-ascii?Q?ecFz0GEwwA3CAIywh7h2UdGe9/QkXnvtWcWyo5gs/eAHN3D9jZwHaZxIGOI3?=
 =?us-ascii?Q?JYSIC5JFYX9f/4ketnD7DQ=3D?=
X-Microsoft-Antispam-Message-Info: 5PHpGxcEBY3yu6KdIuZP3+MDKiZEDpG3HvAVzRNkrDa9HXB971jSBSYb6yzDLr7O0F4q689YykG6uB1zJDrac3XBOXHEbSxRIto0J1GXeoOk7woXEKdtfIoNrYE3DrpDXBFILc5bI/XdrDqUrjAqyD3Ibhvwt6tLmbkDmd0CMq2JsJODGPsTMnVAHX0BBlkewotp1xogvVa4P+DEfttyVS6A/LAjbZVKtgl616rSKLOLlJJ0MymGJ4rN9ysC2nDzKXBBVNgZa7vS/96iZ8NGljOD/Fh8hrFx3K4zGvx+dLTztS/0GDhT9tzNWvLfzDaNwFwG1fIhMBw1vOAquCZKg/Hh4dUEYx1iCDNbVl3I508=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:Qh2XZNSj4pJ2P53R9YLE1wQKBPLkpt4iueF5UMRaBFR+W6v+FZxqNtc3VHZZ0/1bCErNFMGdUNq6QRWe4RomgyqHkxmD0f50hAuAMXVhjnGYZSVPfohR8WlNGnva8hK5ruuSbI9VS+07W2W6WqqrXzltwzoK1ASDLkB/Zzo5icJ420PJMOMKax3SwrSVjUgV8RoNrVFvanaNpt16h++kT8BmlOW1hTK0/w1kj5Q9glkY+siOF8pKO2P1IcM7tY8S262JWoVq4uyn/tuIdksQEmuCyJxPIgiTfBpg0IVwLkb3O8PXg1qhNtP3zJPKPc9+H056fgcRNxxEM91e2r1xXTb+52YTZqx/8yp/6Y8V4ABpF7qb2vxa5NrcvGFmAlP+upiW4P5UerUkCEoIbH+nVKpGfWb3VSjDU2tL//aZ9p163LwRi74DtWSrHaTlfunrF/O8GSbbsiVOSlDY4Yydww==;5:XUQxsXTGIQizig6ro0xDHgnMEYHlACJe1QbY7KzNQbd5MTgyFyHLRVvseOEtJZhTfw42pIF5ZazdqhHq0HsjbClSuEbmy1h6qWm9ixW71J34iuaRl29ZbiiX4vkBFjLHGqUmrSrCwRzk42U7I03bjCtmFDD9IRifSal/hHVGPhI=;24:g7fqbGOWEzNsinIhfOHu/zXDjPp+SQk2TZ/1NQBHG4Nxl4SBamcwHAXIO3JDFV0ivfaea8C+mAN+NbAShcQhffnK581l0wQsGrqMwWpl8Zk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:cNcUI3o/0g3zoyw29qnrRdqmDhnFNPamdp07er4/ojeJcJQkpFYFKFJd4gKCyP4wVbM0aqPdtdmUuwoKNO3/fqPi45iKPKbd+/9RzEyP20CuP9W9mN5SENVYpFr1ekld56h5XfLI8JfyPMf8OsrIbL9/F3/zrktGthXq8z+Dy6WDlwSmFdnhTWsOeQtmIElUXLVeeLkfQR8MLMmWb7IzPFGpD80g1Y6AgqwprtqfocWMM+gcGw90EkSCUnzzUg/v;20:TWLxHonUxpJSWihZ4E/p2yYSq39DZcy5tC1VBNf+lENX5STnvtA3feGqSOjqcoGc1QCS68WkLRhCZj1dDCbgufKD/rOuR7p4JqFuqu2bdAIn1zBQGvbhMRO7oQjVKCFXQYO19EnsCBfpIM4luiPQn/n5lvwkWwgLscdVV0MhYvk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:48:08.0520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cddd9c3-d1e7-4356-c9ee-08d5dd16edab
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

Allocate a temporary cgroup storage to use for bpf program test runs.

Because the test program is not actually attached to a cgroup,
the storage is allocated manually just for the execution
of the bpf program.

If the program is executed multiple times, the storage is not zeroed
on each run, emulating multiple runs of the program, attached to
a real cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 net/bpf/test_run.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 68c3578343b4..74971a9b7cfb 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -11,12 +11,14 @@
 #include <linux/filter.h>
 #include <linux/sched/signal.h>
 
-static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx)
+static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
+					    struct bpf_cgroup_storage *storage)
 {
 	u32 ret;
 
 	preempt_disable();
 	rcu_read_lock();
+	bpf_cgroup_storage_set(storage);
 	ret = BPF_PROG_RUN(prog, ctx);
 	rcu_read_unlock();
 	preempt_enable();
@@ -26,14 +28,19 @@ static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx)
 
 static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
 {
+	struct bpf_cgroup_storage *storage = NULL;
 	u64 time_start, time_spent = 0;
 	u32 ret = 0, i;
 
+	storage = bpf_cgroup_storage_alloc(prog);
+	if (IS_ERR(storage))
+		return PTR_ERR(storage);
+
 	if (!repeat)
 		repeat = 1;
 	time_start = ktime_get_ns();
 	for (i = 0; i < repeat; i++) {
-		ret = bpf_test_run_one(prog, ctx);
+		ret = bpf_test_run_one(prog, ctx, storage);
 		if (need_resched()) {
 			if (signal_pending(current))
 				break;
@@ -46,6 +53,8 @@ static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
 	do_div(time_spent, repeat);
 	*time = time_spent > U32_MAX ? U32_MAX : (u32)time_spent;
 
+	bpf_cgroup_storage_free(storage);
+
 	return ret;
 }
 
-- 
2.14.4

