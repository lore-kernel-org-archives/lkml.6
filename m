Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7961C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69287219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="KXD9Ggc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69287219E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbeHFL0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:22 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47280 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729221AbeHFL0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:21 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BDSx013912;
        Mon, 6 Aug 2018 04:17:46 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp0119.outbound.protection.outlook.com [216.32.181.119])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn9nruytx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1j9EBacGngYbYwz5UBFlW/IpujOzb6zVmiTFbxrniM=;
 b=KXD9Ggc5i/uFR5LoZp41Jes8eXRPKpJkhpCnaTD0O3hH4gwB6xooT4grZGmsIp29+lap6Y7om5wqKgE3JZn5Qnhqv6zrGnQ4BELsk5/4RruIkRARylwKgiV/NujTuaKLijGtqf8lKev2XfDr4ANErI48eWAV7HbwfTh8ZhZHsWY=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:55::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:43 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id D3A73302D75; Mon,  6 Aug 2018 04:17:38 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RT 06/22] rcu: Do not include rtmutex_common.h unconditionally
Date:   Mon,  6 Aug 2018 04:17:22 -0500
Message-Id: <de65a1a830c790099a8e27238566ec8785c7a3b8.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: CY4PR1201CA0015.namprd12.prod.outlook.com
 (2603:10b6:910:16::25) To CY4PR04MB0968.namprd04.prod.outlook.com
 (2603:10b6:910:55::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e46f3b27-5cc9-40d7-0e4a-08d5fb7d77a1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB0968;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;3:wpUL2pn4FmXm6PZxGfK2eB84RLz9r9YTvkvWMj5JIGYL+t7D89jrybR6d4GqUZ/ncZzMGOgifh/XfR/p3W/ubHJxYMpFF2zEGd1DbJgLCgQh6XLtvv977496zVu9TFRAylFqVION+67EodFJc1cGDZKpTTkLBaEELH+jNkaMVgKvM+RuJLfEvai8jaShi+fnOXKqJpILz74+tK/Byzv463dPq4gRzTqiyV+tpTtA2c9BMG3tB9w4LJbeb9jdfoIm;25:Ek0zy2W+5Sw97kMaFGVtE2JO7sFFC6IXqR+clvsF0hXF+dJq0y4x029Oq7q8OtTXLjrYN5y7fmnmPFVgjLFIpMn4W24b7zDsg6oOBTgfI4EjVjr1wRMpIVXoKnRRa75zgeRAaqmFNzyiiwiL80aEEKF/z9DQUjYWZbLMowN8MwcmAbka+bbrNTD98KOfW1/08YQQaH8j6WKWc/5yxicAZ34o4s69BRWGYVEQHGQwLkIwmZZM1hVHMVH4A/XkKgKZiU4Hqoc3QhED6fkYRrDVsmiXyUdg60J2kanYky0YQhfjl/lLi9S9E2aFBJcJXQGzME3OjCCODBFQZtpUgYF3Ig==;31:EW2ZTsbZiMltZr3xd1dtanTVMRP0PLitrZ938KAwcdF/Bt/1AOZ/546OlgIN2qWKkYLw5Kd+rddVwE8/1JTgg7XIzXYtk9rsm+PFnlAFyg7493cHv4PYh9Ynb2SDGbDAfGuQWn6LedWnXndkikdU1PbDYQaMiZ9bjWObVOmvpRcM6fNn9BiuoqBSU2GuaBTEBqUEvJTErSnMMCoBHzHg73gC9xuozH0F3S3sxmbudiE=
X-MS-TrafficTypeDiagnostic: CY4PR04MB0968:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;20:zXtpiR6QW2W1Gd/pQsJ/p7XJg7YJRsJ+fRZ0rMlQ9ScFRNedaIcRiUlb3Rj4ZfLrEwOlAG9UUe+AVsYXdxamD+T5P6hkjNys3RXb0HyUIRNCx+tYZJFMLkRx7RxaoczwQENvTGM/xc7c7R5Yo4vZTFn48ZcvNJyfTZ7oPFBO07Rg7r9JmAugCfkk3dLfMA46mQoHR1HdBTji3DXL3XDhvrAHX0lx/nXSnW0fxnPwS0sHPliXOx6/cY3LqfGJj0TzaH+/Bhroi84G9cnYS5f4toUzfR0e6qVVw7J5kFxyGpk9dDm9KuAFz39IxW3Tav1vR+mscWFyjWTGg4ITgF24+Jf3KwMtWV7tLtioiaQCaet87I3syvK080EsLXVIEgNUpuF74Ni4PEg+kjJErqr+Lz+5H80vvgjKWFqdSFT/rqy6JCB3cR18K6DQZmPKwsQxkza6V8zuCa47WQ7bPjah6IPYD2cpZlseeXs8xLAzgWH+BDRDy6xUt6R7B8+009JYsvBds3935w1C3F3cTBP4sx/djgPK134mS/MzVJM5bcuPI2T8gU+mqIHz0UiORmlnPVirJpm0amMwsiD07NXlMtJSWuwiIgADvReca6ef+a0=
X-Microsoft-Antispam-PRVS: <CY4PR04MB096883F5AEF2111C28FD2CD2F4200@CY4PR04MB0968.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319)(228905959029699)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR04MB0968;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB0968;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;4:sMNhoqAgZTE8i7ouYU+SP/7+/IG02VNhgotU4PXfgcn0iXO8ROLHSsuPHoegCkDO0dxdRUuXv/FozsZV3Chvwkg5kdsTwR9WqodRHw0/Zbe++UK/jOjFpjt9tLsicjTqhlfc81OdrTyaTvEwPq4gjDoDUd6B1VTnGijS9ETimwn9JKivKhUuUHyUCB03MDB7QrNmyx/LvJlvuTucclUkIghjm2p8NWeDWa9RLRa/3IloJnnlNcyuMDIw+86UA55OSepyR40YKcrdV1S8cxJCfaRMps+kcUyOohKZXy5w/uOQvCLEkrO2I7d5E7zCLkQ80tPvSQhGfRK9R25ymIDukJ2Dc7tQPSQTYiwZ4gQ9aFysDYlSFnyFL3nU6NipAYRR
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(136003)(346002)(376002)(199004)(189003)(6266002)(47776003)(66066001)(575784001)(54906003)(478600001)(476003)(386003)(97736004)(26005)(6666003)(16586007)(3846002)(42186006)(6116002)(122856001)(50226002)(316002)(446003)(2616005)(4326008)(186003)(106356001)(52116002)(51416003)(5660300001)(68736007)(36756003)(105586002)(11346002)(305945005)(50466002)(8936002)(7736002)(48376002)(81166006)(486006)(81156014)(118296001)(76176011)(52956003)(8676002)(2906002)(7416002)(90966002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0968;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR04MB0968;23:GyYFS+sSDfgBIfm5cH+nW+NZImCXHuyqYC1Uiva4u?=
 =?us-ascii?Q?IgUaODGUdoKiK8jR4QJKREMHEEljBripyP+9ksdZRh/AGBxBLqOef8lkyM8I?=
 =?us-ascii?Q?9a/qPRk2m8t1nBr7rKB6dTlgmlEMHikvxD2OsAb1sdjrBnyhO8K5favWb7JT?=
 =?us-ascii?Q?fipplgxna0XbYFag7dU8AmqAp/yjmnO4IG/eoCyLfaEs1j3PPHQ1uIebQ/AG?=
 =?us-ascii?Q?Gbm+yV9mrY5q69rWHoxP6dlM76+2s3sedHIYA+EGz9uHJ05Ri6R9e0qTX56l?=
 =?us-ascii?Q?hdKvaAJceFqw/JpvhXsy/sNCOpAfrCKCSlLqfJw3sgu/NBOKyu4bE6Q1NEwf?=
 =?us-ascii?Q?1hkotxMqXv704zN6lsTlh7Al70ZeW638BM5EXTBuV84Tu4C9ayGfTKIfLV8T?=
 =?us-ascii?Q?pNyFniRaDyybml1pym9G15+273HH1bHURtCYaemHPzBHNInrAj7O054Di3kI?=
 =?us-ascii?Q?H1l+ltYOGhjDT6CddrDrRwFOWm99zeiF1VfEGEHTRfto5571q7NANumj9fi0?=
 =?us-ascii?Q?eFyIwcJ0mXqRxlGRmekOEueXL2XSTvSApjPf/ULaFvKuG1YnVYQdOMbOaeY3?=
 =?us-ascii?Q?a6xaCipnmVt0nq2qXSaMgfnt9Xa82Fm9ovXEtWVAdwPVXMFxsoYPbychSZMb?=
 =?us-ascii?Q?pYmLfMuHfM0qaYXND7VnGtM2s/siPziVfadoMp/nrmMb9j5gvIHdPqe/4m6s?=
 =?us-ascii?Q?QAXzU0PQtdw9mrJVyDAYo396xf6KemWS0YHyoo8h4nrSiWRkvig++3VHiDXv?=
 =?us-ascii?Q?EVzuw4kVpLO+s0vZYKzUcTL5DoikCj3GzlvMqk85Xhc0gLF0BTSifZd90fhN?=
 =?us-ascii?Q?y0E1fQHDkOQlEBhruuk72wZdo62GeZ3ZmqJ+grq2rsX3Y+2l/s3L2XrGykcC?=
 =?us-ascii?Q?wh/zKhvwmtVPUxe0YvOPdAu1FKbulqFsbtyVGrw7lhfkAjrVwS/VXNxEIU8J?=
 =?us-ascii?Q?bOH79JuA5AofTvISqq6TR7ed1FsYzWtvIAHrSLPPapvlLoilMbmhgTMejZDn?=
 =?us-ascii?Q?78YgzWtsLvD5q3V+4xt6NaudyERG85cPzezd7RagG00P0nTJ/B2pjZ1l+I/a?=
 =?us-ascii?Q?nnfp95OJx0DeX3UCLBUkC8lBCUAks7G4DNa5EiiMLSuU/+2mKTG0a46koe5f?=
 =?us-ascii?Q?87k4uJIiildqJyYeb74O55MdQXiI25l11aeJ8QfSc51yKE4pnmAKW9KAshoO?=
 =?us-ascii?Q?+gXxJ4uOiHsuby6/E1Qdz3fcQTxQQ/DsrXl?=
X-Microsoft-Antispam-Message-Info: O7lgPfio4G6Pa05PQD1g2tRwXXKzb2MnUtDvO+0IroDjM06u+lF9DmYPWeSJQZVlHd4X71UT2eVqDy7izhVV1mZT0GfR3ivAeEG5EEbLZ/MOltqEeoUHwJL59NfChNG+WdgDdXnDhhAHCNlSjeRCVLGw9MR6wORbpFSQ5cpymly4KcFSdC5fZ1Hpt88mN4kpCur4CkUBBdbCSV5rF2VyRxjlacG5aPFlfqYTK4ofhujRwWi7datTNXpXRKbiqTIIfreU+zj23kvN5p2KNTFgUBGPJ3sXpvqMlmVctT4QAdaN7raPXCyYCscGtWmVWzH9RXHF9QY+NGGfNZUoxBzFRbCMEk5XKE3bAMtVLwM4Jcs=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0968;6:oi4agf1hBudc+EM0M7fG+Suf2vERDQx1oziA78HVsiZFwoAj0T9J+9unXDB/6a2INOUhSpp9z/qO81PCQWYRCZImuBXdykzLrfmCRIJJwTZFvLUrm7qHmDbnZv0iuY68r+eOgbREyD6wdc7k27RfNWiQzfwtjEUuXvqRrkMh0IOPwHogVbOOGnAJvtqYMyaayE/Ru+uxPnJDII0hOMzYgm/jw/lQ0gsXvXDWhynCoH37l8YOuCYgkyq4SEsPPE6uW2EuwY1ljJ4P2kmhsfBwxY1Ko7GP10XR84i/0A2WQ8NoJbcrrYDCcoF9zQ4V3Ll88sJFRaGp/NHJ7AfQ4X+IPSTltK6obvQlhGPjSeJ5u43+FhZQ9ssScLLfqZU1E5ax0+PjYu+m5XkCqeD1JWlevFgFyCTnWluWHwmdhMQ67V+q4cz+SEe3fvaYHgP6gViT56EwDFkH5k+q1ely8JsVTA==;5:8idM9/veRAysACN0O5U1L1tSAke3F8xQxcc2UO9x9LgRGAxKz3AwEDHTxG2/Nc3ZAU77q0g+q5f08HUH0ourNdmYsRwn3rFnFDLzObJ5z1rSljRpA0pAfsFQ2J0Xn9qf96xaXmkEukQN62dhgaLr4WIDxW2fS0s9Pu8woeOyj84=;7:sCO9wP/ZRkWkpYpilHiJ85OqUcSPSgIfYYramSWjqny/TQpbjpTeEpQUtNOG9jYE/GTz89BVGaze7Kn6AdgB8cit4uXE4XCGbdiQ4Lych95v0SiAb379bNCaFjnoCXu0yNuJ1fBt1xjJL0M4I4Upv3pnw/xb/E2aunoz60kg0yPqLzpdE911FAH50TomndhUFvMpR79/ChCndZ4cdrw636q/Zg7KLyLCKcURikBnA23VkOiFh0LGCI2ITkoh6iRq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:43.8960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e46f3b27-5cc9-40d7-0e4a-08d5fb7d77a1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0968
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
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
[ upstream commit b88697810d7c1d102a529990f9071b0f14cfe6df ]

This commit adjusts include files and provides definitions in preparation
for suppressing lockdep false-positive ->boost_mtx complaints.  Without
this preparation, architectures not supporting rt_mutex will get build
failures.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/rcu/tree_plugin.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index a1a7bafcce15..3d18d08e8382 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -37,6 +37,7 @@
  * This probably needs to be excluded from -rt builds.
  */
 #define rt_mutex_owner(a) ({ WARN_ON_ONCE(1); NULL; })
+#define rt_mutex_futex_unlock(x) WARN_ON_ONCE(1)
 
 #endif /* #else #ifdef CONFIG_RCU_BOOST */
 
@@ -834,8 +835,6 @@ static void rcu_cpu_kthread_setup(unsigned int cpu)
 
 #ifdef CONFIG_RCU_BOOST
 
-#include "../locking/rtmutex_common.h"
-
 #ifdef CONFIG_RCU_TRACE
 
 static void rcu_initiate_boost_trace(struct rcu_node *rnp)
-- 
2.18.0

