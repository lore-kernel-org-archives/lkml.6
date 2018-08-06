Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5193C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DF52172B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="jDTUNoZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DF52172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbeHFL0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:22 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47270 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729220AbeHFL0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:21 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BDT3013912;
        Mon, 6 Aug 2018 04:17:51 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp0083.outbound.protection.outlook.com [216.32.181.83])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn9nruyu6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY194zrqDzzedNYy3/R4Y3ZLQeBhwJYaqi8/0UkW7Hw=;
 b=jDTUNoZN/39LL/9v1AGQk4uoTup0160Ue38cauOtWtDIZYyQZJC2i3aQd2X7Pz7wOXYmO7lfTJK3MxboJj3TZCveNM70RzUZzPVlcl/u+bvteY3Dc+Mj9QfejCjKdHKkiZFU7ulM7NlzoLBoidZmgugM2T9EB/MfbGRrrsfBAGs=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 MWHPR04MB0976.namprd04.prod.outlook.com (2603:10b6:301:43::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:48 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id 2C2AC302F64; Mon,  6 Aug 2018 04:17:39 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
Subject: [PATCH RT 18/22] posix-timers: move the rcu head out of the union
Date:   Mon,  6 Aug 2018 04:17:34 -0500
Message-Id: <63db6ca7324ab08eaad12613bf865382e54cd6c0.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: SN4PR0201CA0013.namprd02.prod.outlook.com
 (2603:10b6:803:2b::23) To MWHPR04MB0976.namprd04.prod.outlook.com
 (2603:10b6:301:43::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0f088a3-f938-4e0a-6308-08d5fb7d7a49
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0976;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0976;3:WtbMtoAQXgTFo4JJPiTJgSp4gJ+uO767W+2kSNy71+Hk6PoPf+7tyNdgGMUduivL47eTMX1gIIt4FhQq8xQQIIB4Rw6dXTX2Q7Yvle8r0173a/KASfFXGChdzgAmsLPKmCKEADnGeARrU9ozz8sBz+FVs5hmQGGo05nV1Jhp5UW/4tIfhDeieg382JFvtc2ATnqhREV7bPxaPh5cW+jW9yHDkppV/09PlleBI7lV0f5WkY+WJIq8EGVnNwPRijpM;25:2SnE7xlLLJP0IlXm1ei5h6Ww3Xi9s+nC8pBEZefd5MMXkBipgPEy5twmVZbF3vMrs1EqGwaQmLjvvuzkVQK8B9GAUu1rARqnXVTIbS62EBx5krCQEi0EaMeiKofFU1gp77xTS7on+DJwm08q18FICMVyt/CcZJgfMYir41LciHBYiKDIURXbFKUpHv6a7jTO5Bc0OeHPtj7etRCfMChzkq7OHwciHttq6xYp5hYtl8LEoKJZNFOqFjJrZ3i5TgkVSjZsTVwdRYvLXcsLmPOCLFRX2MqE6q6WrrmLKRAMbgROJ8OANzPnd8aiChzG8CJqrY+Nk96vvdBAquqpyxPpww==;31:gZm0YuVQ2Hw/IA7x54KlVKw09gOdV6gJ0sCkmsA7uasCGxROjShvZprep3kEFyCZTOB5Oj0DCVSlmurzozEIvqSgGnBwSe7yroxQMVkL5iwOi9hWx4TRHzBErOnfJUdGAhIRuqBwfz1coPOMplh4o+gWmOrkVGcLbB7FaDYfYWpQuUFZbPKOgJU8o1oRtW511ZUPhSXv7q/o1D/bt7SGGw0i7+AObKDTnskLmDb+9Ls=
X-MS-TrafficTypeDiagnostic: MWHPR04MB0976:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0976;20:vbgSeT0GvUQ6p2QXYU+YlIsaC0PU25E6TlDsOhcUkuV2tEwn+ovII9M+f9mNC60RLRvO6VMTb5r3EzPzAAS0IjqH3IfpqCxC4KtZr7fpP2xnbq126qCdAz1J78PcbgDuFrRI98FfXgw7FfEHCr6OOj9O0bBR2XQ1q21m59vjLYvA4qhUq8pYHPilQoWDVrn4VTvuaafKiawF8BncvnqycbAHEminplUJDdcj1PKpzy1j2HrnHtyIBALU5qBdYY9m+TunK/4URwlyfrkvdbQ+KOWc0GOvOEkgV9Z8MG2wa//HcS3rphwgA57WjSoYweF5zn9P4K0vzozvG/q7NdByxGC9crZIZ7pmcUj4kmcwVRgyTmmAXgblqGF1NNCr2brYIbKLZeLPKhJ3C8U+M5uFx1Nh6z8gebWSLEJc9wN6c1riSVuDy68KezHeLt9Y4RTEMGdlXPvLiCpr45x/JQnCsrVuJcSt+lQ/7WF/ID2rzadRERTNNhpi2GyzuC/E42q3OzFRI1dmqDrejA4Fqw7A+m99I4l6w2pxPpfVqXGQrc+keIXccwvU4geg3Mbq7ILMCRGTHLt/V1NS44wiARwgdlYD9UWyn2XwyQiyF4aQ5n8=
X-Microsoft-Antispam-PRVS: <MWHPR04MB09761E9C2F3C268A7AD7C109F4200@MWHPR04MB0976.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0976;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0976;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0976;4:PWjEd6pNXgFHe1WohgJDlnrDmu0VO3oXdET4R7gqYeh6BwVkPNbS8qtgOG6g0VYDhtbpRH4wywtbdalLqmH6NkLX12mJ5RsZuUCfwysjkCsifNo5lbkwDSm9a/FVIo9fHKWJ/1VMEN4pqrGZG+BJIVjm9TzHJKxrzF21hLi+ly8A/4SFCpxujRCsbfjoUh3exdS9iGPULs3PGcgAWr5CDL9Qb73l+jgSG2Og8bgtWzLJ9ICcM4pGXG52vAtUhZ0+qwJqJFMQEkDE4d8J9prlPf0joe/tB2PoL6PiI8jBKMgB+zfarxY42P1OCCbOt88wpjFiktqtS4/aIAKgvy9QyrXYKHLUTJJOb8W+jjvx0Fc=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39850400004)(189003)(199004)(186003)(50226002)(50466002)(68736007)(66066001)(47776003)(26005)(478600001)(2616005)(446003)(11346002)(476003)(486006)(48376002)(122856001)(16586007)(97736004)(42186006)(6666003)(36756003)(54906003)(14444005)(81156014)(4326008)(2906002)(386003)(575784001)(51416003)(106356001)(305945005)(90966002)(3846002)(81166006)(53936002)(118296001)(6116002)(52116002)(5660300001)(6266002)(105586002)(8676002)(52956003)(7736002)(7416002)(8936002)(76176011)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0976;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR04MB0976;23:evj0begFnQj0gUQjuzuWZAk2WkJ7rBLILwI7KFhs0?=
 =?us-ascii?Q?K3BiIrUhSqktUfbi9lNUCy5b1XppanyyeYyeHc0gK9Uc/Skckj9yvEFkmLvB?=
 =?us-ascii?Q?QWjlQIAjmitT6eDFmwiJwySgNLhf0V0IdN8owQF1jzkvri0kZkndw0OiKE7w?=
 =?us-ascii?Q?uJ+lpDjrjErW22b5o9J4DGR3HyR3tPXqnqSnE6SL9UzO/9JAOLb5xpoYcyIq?=
 =?us-ascii?Q?7skvZt0uO0bWwSFIgUXDC3IYT331/Qc1TghlEyW56sQzONXlXFBPh51FbBQl?=
 =?us-ascii?Q?UmkWXE4rU4FCL/gVMDPGG4xvX8dsHWtuiafgyutqAC3xxL9SGOy7kHvK6RLl?=
 =?us-ascii?Q?U9PlKeCH9302tDvjooCiLhw3tW3gcPgjtIc9xS908QuYEJnmrjMzLhN0bHCn?=
 =?us-ascii?Q?rlTrQcXJNce2nXJ0UDVYHwziTo60xSRluQsd99oAev+5evXbhtUOP08KXJ+F?=
 =?us-ascii?Q?N7G2PfbmbiqIWGFwuTTJ1elSDSxYAwa4Qt522rORO1g/WurtbBGtihgjH3mG?=
 =?us-ascii?Q?KOahu1sKrPSLLI1p+MkZ24A8LzyUHE2nI3q09oQbu8dmmMls6oVBz5lWOiKK?=
 =?us-ascii?Q?Lbm5gVayk8RlzpUYhUmLhlTXPlkGHxH+Greo68+tZV+nDDkuHlOUxfAW/nLs?=
 =?us-ascii?Q?lsdUjdDkxlvXbT4+3pwKcGBGf1DQygONjbF1Jh3MtC6yx6butQnjXDAeF6gP?=
 =?us-ascii?Q?2aYQwSQQ27z9VHP89iWcvMQUxMjGPLCVxEw/sv6rMINbMpPpU3p0Z9alMhBA?=
 =?us-ascii?Q?W1ReK6lME1U9mZTzlog4NW+tnTqSpmBsY0A5EwqIVqSRrzmluU6tyv0ITJfn?=
 =?us-ascii?Q?dDU2QKEh0ul+BrftvlDogl4suHLz18FCMt5ZOmFDW2EJ0Z86LUE+iPPr0V4/?=
 =?us-ascii?Q?Y/F/S4OTdy2286/5I2q7ZVLqRNTuMP82xOeUHjRecwlGYkHUtyJwYYbXc6Ot?=
 =?us-ascii?Q?PVWXTcrwKA09qAkbaYposi8XE9tMyR5NzdRNm2CdpjV9P6dPIvlpDJV/5gqG?=
 =?us-ascii?Q?3tzUySawDrgSXvL1jMCdMMECueSXB33Q48eM4xvDHO45MGA6cxMJ1LkvjKzr?=
 =?us-ascii?Q?86SeancnOaoiKfOPn3gzDSgRWNNJDV5ZkqkZyo2wtaCC512dpeVH+QtGim8M?=
 =?us-ascii?Q?u/9IQwTmlc9HhtRmnfyvjS5WDiEqyrvP0bVQYass6/9bCbq6/9NRNJBCy1oK?=
 =?us-ascii?Q?1ES8rIpKlr5N7+6TsbMnerjGJcM9uf+pCb5+5iBsCcPc51cneBFY92Iow=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: ++Gh3AWLQ1virrhDJVaeUiwCI1gNqbQA0PCKG72hZ71t5Jn0lNd8xcEUpXHCA2+IDeS/4D8kKpaRnZRiizr5DTetKdHgB+MX0cd1c7Z8qjX7+LVH6S97MKhTcop9KaLb8Quj3WZlRTdsGan7mK1LTQquMdd1ujD8nRUO2pAodMZq9h6WAE5g0KzujSvJbhPRiTlzAF6xH2idNb16bE6EePfEar2Kd10fju8FJw/hzmD/vaojDF2TZqZQZMkcMPni7nqgwQ+gAz0H2yUgdQYJhGrC6OCIGGBjmavPZkL3uwSC56BFCFh6jJFuNC7iSSJuEci3+UObTuNK5JHVqJx6CYkS1CHa3dm0ZvTflv4mggE=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0976;6:R6zjp9n0QT7xmB8DJUhSRfRcoogKTIw2Lxi0rUvQ9q7PRvwAyn4gWGBryeqq+NMWXRnZg9agNeUr5bcEIaSAWJpcZmk0EbngDUy3la7xx3CxuopWsIRoY+bjZ+Ik3mzcx8SDdgENoZmZE7njchYah7yqxwtVascmL0fNFilhOiA1Nrfvt+Pq5UreF2qDTWhl/e9YN9Yxu8DbfFdxFHIQ//jNyxqPEBwm4zkVuIF7CPsrFBjZKFlSaD1nvEdGsEM3UWHt8WJENcPBw2OYG13N2FbTcUwOByKpCDC2IxxYSK8WIiQre5Neb5IZxVAmgGGs69/YCrE1g4vEKU+FD8BRJfL2oGdX6fkJIpLhIWV5MFlT+w1id3ilRl0en66Vz/yMobiYLRnVhKqcSKNTRREQagjUJCDfHgbJVCuM+EDm3r22OBn8v8j6PDCMIrWlcvgg2dGYc4lKZrQlSA5gg6rubA==;5:EPR0BpkNJ1WHt4RYCelH9ZVWfxhjzT7DEOjV6tEdGMMxXvDtHIGIC6phT6k2t0w/ORwLy/5t+zPBUhJw7szFvjDYxFMNCjDKcBzpHKEdQU1yXGuJEXk+rGN89uF4FAjZ0QEhd8N4HlM04dqGi1WFiP0OUolorWS2y73xj6lkcrk=;7:IBgRsTAuOtxJnAuYzWXXIzfO9160tlTCKBiQHKODDrPxdI/C1lmW+5CuHdvNOW45p3gsE9o/VFCo/I69BpPR5BUUpm/V1eGgzxcqS3g82fFaQ9WLK2CaksssVLQVZ+AZEGUZwLPhmbHDqp1qBBUdWJx+EsbM+0GOlj1o/rLo6DA/zdlju0f95pbjHxiXevERbSGdjYdOFUhfnbe3jpsm3bXvQri5c/Anfi3po4d5kO1bh+QMFPGS9lsK03RX8V/m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:48.3256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f088a3-f938-4e0a-6308-08d5fb7d7a49
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0976
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
On RT the timer can be preempted while running and therefore we wait
with timer_wait_for_callback() for the timer to complete (instead of
busy looping). The RCU-readlock is held to ensure that this posix timer
is not removed while we wait on it.
If the timer is removed then it invokes call_rcu() with a pointer that
is shared with the hrtimer because it is part of the same union.
In order to avoid any possible side effects I am moving the rcu pointer
out of the union.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit b8401365af110949f12c7cf1fa86b4c0ea069bbd)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/posix-timers.h | 2 +-
 kernel/time/posix-timers.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 62d44c176071..cbd3f9334543 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -92,8 +92,8 @@ struct k_itimer {
 			struct alarm alarmtimer;
 			ktime_t interval;
 		} alarm;
-		struct rcu_head rcu;
 	} it;
+	struct rcu_head		rcu;
 };
 
 struct k_clock {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 6084618436fd..45d8033caec4 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -568,7 +568,7 @@ static struct k_itimer * alloc_posix_timer(void)
 
 static void k_itimer_rcu_free(struct rcu_head *head)
 {
-	struct k_itimer *tmr = container_of(head, struct k_itimer, it.rcu);
+	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
 
 	kmem_cache_free(posix_timers_cache, tmr);
 }
@@ -585,7 +585,7 @@ static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->it.rcu, k_itimer_rcu_free);
+	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
 
 static struct k_clock *clockid_to_kclock(const clockid_t id)
-- 
2.18.0

