Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25749C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BFB219EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="KEVAkuNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BFB219EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbeHFL0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:21 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48012 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726572AbeHFL0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:20 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BGSG009132;
        Mon, 6 Aug 2018 04:17:52 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp0018.outbound.protection.outlook.com [216.32.180.18])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn85wc4us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAdFmgmHPCQfgB2/p2yi48kliyqb2nSQL0WYb0gWzb0=;
 b=KEVAkuNcuaH4NXgZHrg4IhImGdz72K0hoJbLzQeA4tyhvGDLo+3rR/tHuSNSBEEL1yytTrN6VVkFJOk0enrutkABEfCbR1t1xOzptoTazEQoGtQnlK95f0o0jswKY0GjSc0blInMNy63PHARZhW7UTHYOUdhdaRrKxrtyDhAIZA=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 BN6PR04MB0963.namprd04.prod.outlook.com (2603:10b6:405:43::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Mon, 6 Aug 2018 09:17:50 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id 249F7302F63; Mon,  6 Aug 2018 04:17:39 -0500 (CDT)
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
Subject: [PATCH RT 17/22] alarmtimer: Prevent live lock in alarm_cancel()
Date:   Mon,  6 Aug 2018 04:17:33 -0500
Message-Id: <9288cdf3d1c3fede611a471fcd94f8b9c1b306ed.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: CO2PR07CA0059.namprd07.prod.outlook.com (2603:10b6:100::27)
 To BN6PR04MB0963.namprd04.prod.outlook.com (2603:10b6:405:43::35)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73b186b0-8e5a-474f-eeb3-08d5fb7d7b64
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0963;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;3:k0aj5FVQWUi5H1R3qcx+WRQyboGcxElsKgwV1OnrOf0AG8WkKomhj45zssrb4zldoDcExcyUQfzqjai/OXIAu5o+oocARrW5oaofZqzmq/uuDu/1YCsF31t71oUscqYtquiO2dY82/5Z5YQFoHoFuKB58r7S5NEuXULmRueGlOhrRoL8E4Q7EEQDKMzmRD3be5unOs2DxtEoN+ERwtBxPOTlRDCjcHstnt+rONE31GMUsr4y91RBqXcqfo83lbsq;25:GmtHszrzSyvYDywRvwj2p3x6GDIv0kFL0l+DXgom5FbJp+hnRb7H7kTq3I8GFkJSulRE6sHjyHRD6SozKiNzlpj/aFoa2Z4Q7LQVbJ9+d+KEdNL1pAolUIg+5gSNFWi/LQd8LyXXVaFV0mxxtzKqqXHxeNWmMt5hMU9VlJQ6c8jm8oNSgOpnjHJiod4iPGXsp0n0UlcZfPN7BvMXsfsVUi4QVBkOoneb4n9keO6aIQmnXWc9v9480gPGOamHbuVUQIQy5tn+Y8V0KYyxqaI9Q+qM64n8KGqm5Z0+vbvs+abPeS24yTT64eHM5ZsaYSbkgbXDEI58hs6+W7uwW8a3LA==;31:x4V99B0MryHJkW8629zbMOsB5dGYdQeuO2wdnfNyk2zeQkXttS3FJEbF62XKHRmV6rF0Ib3BHlWJE0gd77WAefpEu2/3K+G8bFgy3/XC4gPbX/wLuEQExbLB6SlJO7mjYERldgzEVGnc+79F1LtFbHeiJgusbefG9psrry1+wQK6ULBp+Tzz83ziMBaryEtXur+XGeAnqQCjXKHwUm/WAQqzgoSSxwOXBbgj/HpooJc=
X-MS-TrafficTypeDiagnostic: BN6PR04MB0963:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;20:gW4IVXvkxedvlAWC06EJyKOCy3z3H1laq9gCX5VMWg4QG5Oc1EYSkb/1ZRIhPtzwohxw5Ja/N4HFkylJ3pjOJ9r95FEkZcHW/wotURT8Um6md4i1lTOZK4/za7NP9+cru9gpjvmBrRhS2jzJrHnA4VLM0S/+ZaYskdKZWqEXir0cYucF5LtBFNUW/I6yLv9FBbU9+Z1lmc/FOoDawhQR2L+zuuq9C3ko2GOWok7qnnzB/63T3Apa3R+1TGUI4YejvbKXRyGOEsyfvp1a1nKRecyk0FDQEVe3dtJqKNzakTtPTqCHtpCV4zCIeE29lK8fpvB4ym6htgNzqSLgUgbH01md5i6ey6hfFJ/+5yMdYel99LhnnM0Qt532iiSIk+LPF5dd7TUud7JZMOk8SyVat5Rc5N2LkPg5xrNL4uqZ3p47ury8aTzhGL0MDwJ5GclHhM33L1WIhCL3EsVecot3g4tr3FDRM/h8re1xF0OpEtn8Nsk3lUL2SeRPMNKIfFyMmjhcjD+Oy/gl8vniBjs9sbCHyPrF81Y6Dyvfav3j/TPpf1/+VZolUPTAHEckjm02PSf8wqVSdgKZwUsGFMVoA8mS84Cy84GcYv5l/kMQDwA=
X-Microsoft-Antispam-PRVS: <BN6PR04MB0963B3FE7883596BD15C4D74F4200@BN6PR04MB0963.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR04MB0963;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB0963;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;4:JBiRm1RX9rHb3lU/17Cuu41OjI62I979MxofyuFcdZiBfjdNUSpE+YXvP+WN0D8FmmgvnwXimA6Zb2kMPnM1DKQ/U2nhQFVcslUkCh02sWhmL8A7LpkesQ4CPWIZhmI6gCuySg/9AJk+zEK2/Ji9kRu/jLbAphwKeS3B3G/OXmTiQrVTR69lSy8LycphD8rJc60VDZ+k6dPAGGbKLlu3oPpj6JnSeLFKDoW15MIhm62B/ad+pupZ+c0AAk3O8/+fnrFSLfDN81sPKBTwYVa8e7KXpjzq+FWp+JGwhwlqkjaWzeKlgvx2/haZb+IHeY2FMW1+WsQP765hgrJZKIBORHh58FJ/P1q86gZ/GdGdZr0=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39850400004)(396003)(199004)(189003)(305945005)(6116002)(76176011)(2906002)(186003)(97736004)(7736002)(50466002)(48376002)(52116002)(51416003)(81166006)(26005)(478600001)(36756003)(8676002)(81156014)(122856001)(3846002)(316002)(106356001)(53936002)(16586007)(105586002)(6666003)(42186006)(52956003)(7416002)(68736007)(66066001)(47776003)(6266002)(14444005)(118296001)(11346002)(5660300001)(4326008)(50226002)(446003)(2616005)(386003)(476003)(486006)(8936002)(90966002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0963;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR04MB0963;23:7g5UruX7wCbFgpTXZDFynYiE8QEAJH7xoIdx3/3NU?=
 =?us-ascii?Q?r/qSXQNi0kYriiVCzIwbIo+9xKli5oEz3SLg3VWeF8vPQYcbt2lH1Isarp2J?=
 =?us-ascii?Q?VsQ2/TYS5mZWUycEc2GyqAgdIJe5b0O8kEQnyqf0TV2ConlzRpsBuegkvHnx?=
 =?us-ascii?Q?MtXtG1Zm3uxcmb/OPGPSU4E+68/gQFbEyzBz2E/iCNVaokIoTuRrFae03agK?=
 =?us-ascii?Q?KNRKvrFSfAYdgTODhh8PnVoLwFMU23cVJz05V0q3Pb91ks/N4wZ/M3Yp/VBP?=
 =?us-ascii?Q?6ZrNyrljLJWYoTKwXQeZaZGMBe95ASaHAl3BobnMz0YTku6hBnQvmgrK1tJj?=
 =?us-ascii?Q?Rb6F+aVpMIP5//8wXc+7E/Tjeq6bGLOq+oSfkxE+u4jIU0YiGPQ0yLUYMuRG?=
 =?us-ascii?Q?0DVqG+kuvPH0WWyIQ9N1xQ146S0tAjjh8KwRfJ6qPExOXsnWRPnsVaKLHwJm?=
 =?us-ascii?Q?SNC4JG2NxfqI/IFj3b2OR959x7s/cl/cktmqqAx18GxSU29IJU3n6RbOYJZ+?=
 =?us-ascii?Q?AeHZCtmLPVv+CmZRrmW0HN8b3H3gpAW51C+Dp32WfHrdtPHjDi5XZ5dhUJYL?=
 =?us-ascii?Q?cpTV964uLJaMiWbz/n9Y87WRTfJAQUJsknJD4AATzSNNsYWIcs/gCywka/ay?=
 =?us-ascii?Q?DZ7VI6qmd9/sJbG6ZegsI13W/VWsLa0wLsp+EK6OoniyKQrLiFddWMCr23Yv?=
 =?us-ascii?Q?fkFJpR30AwOMYS22q46OlQtD+HxwZZrRCe/4AJR2kaBy3x7sbQe+SNdsY6v7?=
 =?us-ascii?Q?NgWZYXkvJgFS7NVy4XgdjWoTjX6kVzXFmFJHC1qyJqHpI5z6f2WUikkST6oC?=
 =?us-ascii?Q?AOgW84cCT18t3l6YGNuX+kb5ZCe7PyAvaIyfOAvBE9RgvzQj0kdCapWB4T3z?=
 =?us-ascii?Q?YDoOUcwgRmNlUF3m1ASVpOu68Sh4IWTfNh5N8ZqHDGHDBPhMittJ0RFX7GyV?=
 =?us-ascii?Q?B7AbHEnUiBspKsd0H/5SkXJKV3on4hWoqbzR340fZ7GBhnhNfF+5Fnvq32de?=
 =?us-ascii?Q?Qb2fo3MAUikDW5vVNedP1wM1QkliZMM901QPWcmTMze1m5fowYvqIRDccf9M?=
 =?us-ascii?Q?wFszLoy53aycH3o8ouiKdXBhlVxmcAWHO14f1C6PXQS6M9XZjoHn7R4bIc5n?=
 =?us-ascii?Q?XAOLYiznwk6vP9OyqO+VcubEZLFYtWS3+OjlgPuErXFJKaIfprQG2rBX6m/u?=
 =?us-ascii?Q?OBuDzRVdvXMmgCRZ0d/1+N0uNkjANYbND70?=
X-Microsoft-Antispam-Message-Info: kBdH8WRzXxieYydd48DehNyVNv5ZaBthGoUukFRRAUvl+d/lthEa/4cBlw2EPsMuyKKez7CqVUtjYXooPi3H7or/HwueMTuwgWnyiiFJmv4/l3JqTnykW1Xp7ZS3j2m38xblV5pKth9F0KbSl8rQnY8cJdHUKl5/0A/R5MYeLnB7QMh5Lr8a1Ya7RBfWOtdpZFgp39aSBZ0tLhCA/41suhPeL57gjSOnmVuqcrT7g+jgNXStz/1LEkCeO0kayl0gAgFGdBzdeV78r2QRIqUb0Zh9VN1xzwGidBMkDwP/EWABax2qiYeKkyrK1hGfBpc+boJtHTQwkDRSnzSvHSPyzfzrYwOkY0/dnIHhJrsLRqU=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;6:/+HJ4/q5odTyIDZqdfhqI5aHDPR+rLoaKx61J/BbaPIk02q2eB7Xq+YsZ/DvjHRgrgEYLsY8ZagyKscygiaSAH6xzTSnagBwElB1sn0+sFYh5JoF0F68hIZ4jKCkxwdfHcLwaWrLgUzqU9Fa+VoxD4CGG9GNfeefrP0c6tuPcbd6gqtltYVCCZMd6u/GEi5X9psg3fEjer/dzMOfWUpjyE/qI9VB9fmzutJurUrISwkhkqCmh/aeKswqYErjh8f5eGWc3EmnZ7oWQNpIlAO04//mN+4sRcrzvsp1qG6ywrwc/xxzyeO2K+RIz5CfWgF9PSj3L+1FibUEVvcK1MopbbBkgLEvEXqI9PZE+4nrWd798PZrAthQF5SPRoUqMA9pwRsvbZVOeYkFKOvIG+oS04UwzYAq9ZKlqkdBLRJUmHzLfekN+LX4psQjvT5we0XKA8spWtoDLGimx/NgOYxPYw==;5:sr1DX41WtBmvi5SEecCS3i3strklFM2a4qsbYZyDb+zfjze+UEY2KDZtNSc+cG4qZFomjaLs3V160wOjjkfzehV5Nj4u2cfHtnvvpBj2IaZGl7izhWKxd7ybrrwXBHxRdhIWN6hWB0MMpu3xKn7MlYyX7eg1BcD4cjeSFVgyi3g=;7:JSFZ/t0s5E9RQ7clAWdB8WGbk+BCdj9UpuTaL51MqPXuqjDAMHrVj5IzomonQ3hfQoW2XioE+k4oQwb5IsK0wYB6HRDLWXIIk3iwCTuTuqJdUY0o+UoKkNBrMoOF6Fq/S5x7W6GojJWpQQ9URw3MxUNO1cpQ+Z1WLeDvuQxFRlJbGNJ4XZAU7gIlMp66N3diOdMXFxXeTRoksI2j61TV+BZ7+IVR5kyiJahs3o+zCjHUe2VZ/red+FlcxcTcsACf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:50.1239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b186b0-8e5a-474f-eeb3-08d5fb7d7b64
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0963
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
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
If alarm_try_to_cancel() requires a retry, then depending on the
priority setting the retry loop might prevent timer callback completion
on RT. Prevent that by waiting for completion on RT, no change for a
non RT kernel.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 51e376c469bf05f32cb1ceb9e39d31bb92f1f6c8)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index d67ef56ca9bc..61b20a656863 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -407,7 +407,7 @@ int alarm_cancel(struct alarm *alarm)
 		int ret = alarm_try_to_cancel(alarm);
 		if (ret >= 0)
 			return ret;
-		cpu_relax();
+		hrtimer_wait_for_timer(&alarm->timer);
 	}
 }
 EXPORT_SYMBOL_GPL(alarm_cancel);
-- 
2.18.0

