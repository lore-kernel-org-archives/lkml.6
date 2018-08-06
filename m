Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC69DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9201A2172B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="XXhD8qqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9201A2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbeHFL02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:28 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:36440 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729717AbeHFL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:27 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BFW2008024;
        Mon, 6 Aug 2018 04:17:51 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0178.outbound.protection.outlook.com [216.32.181.178])
        by mx0b-00010702.pphosted.com with ESMTP id 2kn93xbp4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYwNA0Uom+PBqXfIgl9haPb9zUKaJziduwaf+yVM1cs=;
 b=XXhD8qqyLwHAO7+1tw1ZZ4vDIvzU48tRTmEgesh7xLKhKKxNNPr4s7lPLO1/NwQSHgdUTF1K5kY3Fd2Xw+f90RoXAOV6NKlJYgsSus1RzFSMGCVNQf982kV1zN7+2Eu0FI7aFHKDgN25I0aFt3flh/PJ8Y1XZEQwEM5KyU0SyUc=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 CY4PR04MB0966.namprd04.prod.outlook.com (2603:10b6:910:54::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Mon, 6 Aug 2018 09:17:48 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id 4022C302F67; Mon,  6 Aug 2018 04:17:39 -0500 (CDT)
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
Subject: [PATCH RT 21/22] seqlock: provide the same ordering semantics as mainline
Date:   Mon,  6 Aug 2018 04:17:37 -0500
Message-Id: <40aac5862b763fabc66d146390356347b82a8231.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: DM5PR21CA0051.namprd21.prod.outlook.com
 (2603:10b6:3:129::13) To CY4PR04MB0966.namprd04.prod.outlook.com
 (2603:10b6:910:54::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cfef9c7-a077-4d41-bd66-08d5fb7d7a55
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB0966;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;3:emhugZZuQo8VYx4UeTz6iqDsi5H6fuiYHaJ1UuH3BcZnxVxmeukBTIGJ4Hg1TMli2ezLG6J0DCmf11+pU8tL5jxrahL+i3x7N4eeryAjkAcg/d2RnW7izwYp8CzmE+FT8bpKazsdiEbLoKTs72Ici9PEYAy+x+pf+TAyL+EoLF6bpoKqDmKY/tZrUwRgM8u6QeWkOSLwLtWT/DBPgRvulMPozwbrueN+Yzi7CxUjA1tdAdPbAV0LiAFTiZhPLPVg;25:00irEVAAzfqpSAMs0np8Qm2FRo43UGXZ37LYxnGQwnCe9W2J+l5iLBpNuyCsDkjtkyZSWcTbPh6E9FraTZ7DM2RpG04vCz0JL0BTHfmKeeghZzng778PKWetG8DIa7+P/hYj0D+13qbSjTfZ4U3EL2IKP18xHN4Br2T6OztAHvAVAkZdQY0gElOMr/jpV7eQzWBKi/VfazQci8z5IgekjtBzJAra8cLnXzZaN6Yd0qlySAkOIUYpfink0BEEiDSSpQ+33RE/wK6a6quCZcvOqu7lqwLps/zrYRtR83aMOoaFnSH9wvlA4/neXqv9oQn5CqmQBruxaji+1xzvdxVH/A==;31:jAnH7hYs1JgXaOlCd+X/MKm/CTgRSNSKNdt9ajPy+n27eBHhsjD1jVbJcFwCj7/CLHUl39FWkVn7/2jrbuvqnF4oZYbaD2mSPs7UXLGvGPyuQ2dYcFzt+qqGBz73oHVCCzoIUstaODzbJENg9mGQqD0yzoVZXTQg8oV8zQzMYh5fU6XXJDrAsDGBuB+VdKdFOfc6/p4tsOWopdFZYw4zuoU9wT69giQArhIeEsv+3fU=
X-MS-TrafficTypeDiagnostic: CY4PR04MB0966:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;20:PP5urDkloizSgUvXJZ5MfiyCdbz1o1vFu3VbrNlcOT7gY1uTwh0qD9EdJxXMtyljzHlXLsMhZtMqMvYyerCok0JpdGKmeRXUUa+SLWXzA4n5CClV4JogJia26a+VyvUV/uI5abFJTO4e5DrGEXkEORb5R8c0V7i2iogfB9huYPkz1MOIJkJxqr5dOdX3ZOpVdBqboXYgMjiQIXhabv62sZEvtpyGSxGi3ssiOmnDI9T9NqQQHn1qHR1LY9cQLNFE7Cepqvfc7dIaevOwwb+VVy3NKOkMhQq/ATVw2NpagKArU5LYUm7PLMwFLMyUpDsOXuGpl9z1q3pkTXEmSpbjWeYo3pHSrn2XgeZTiETBpSvpB7PCT86HryKRd/lV+YC2HnZrZC9GfueMcRFjaDOVpH7zxicZEbdoUskeKp/kDVXjddvjbvpcDuzeu8jt9Wq9Bm9ZPZUnFBQ65uyqEjoe/EqiwPvzkbD1XT4TBGQHYd3AUK0SRmW2TH810DB45xTxgXDi7c6lh+XagsLy/Y6VAeBAhD12UgpzObywDuKLxG2gjrWrvspUIdinjvIBTSv35zEUYit/8IAmwvqv89jZ3XrtUMZxQS2G5lJ2xI/IVCU=
X-Microsoft-Antispam-PRVS: <CY4PR04MB09662A99E5092D376A83340EF4200@CY4PR04MB0966.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR04MB0966;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB0966;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;4:7P4gJWx94jNBhzMpHOw4Sphm5TyH+2AuHCcJICaX6gt/c5Vn13+X+1kC0DsBeIpTQr1XNIKdTkAlmUgrw59JugE/gPus3gs3R2SfnB14WIFCrUMbAvXl8gTkaMoj1ojcYnu0WSQkablZPY9JPgsOxCTft7BtMIe4CSc/+3tiPWR/W8hhvV/1wBKJ0llJMwisNYHkLOis4bl/j1YJ0cUp87SSsQvMblf93dj+OD41zTAQIa/lbXiHz00qVBxoc0nlZUaa5FYaXM2lkPyb41onPAv3/8NkrbSABt5dwE2tKaVp9F8x3ZQQ4RzvbRRKkT9j+JZ2Qkg26goAG/YmstIkPw==
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39850400004)(376002)(366004)(189003)(199004)(42186006)(51416003)(52116002)(316002)(53936002)(122856001)(76176011)(8676002)(2906002)(81156014)(105586002)(81166006)(106356001)(4326008)(16586007)(478600001)(54906003)(48376002)(5660300001)(50466002)(66066001)(118296001)(52956003)(446003)(50226002)(7416002)(90966002)(6266002)(68736007)(8936002)(47776003)(2616005)(26005)(186003)(11346002)(486006)(476003)(386003)(14444005)(3846002)(97736004)(36756003)(7736002)(6116002)(305945005)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0966;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR04MB0966;23:PPzGtiI1i2dRMNgITbrpjrPh4wbz148UyXuM7MfTD?=
 =?us-ascii?Q?Wi18BA/Cwvo1gxA57TAkOWP6OKYtcIZtPWeXV6jEf2fqCK1NKAE1kvO2zRdL?=
 =?us-ascii?Q?J6Xi1id7VaTqsM/f8KJIvFHNBve/RVLfA2Fls5kZ0sq39l1yKFN9atrq5w6f?=
 =?us-ascii?Q?8jOrhCwFgq7re2ApvUSlRuSHQSU5WOMFZ0ysZUlv+7iLSPJYhCX7nULlDchU?=
 =?us-ascii?Q?5UUohqmEImcrpsuWpVZpEcemJJAHc+wlT+jmed7LTxvHpkUwGHzSPHFXjWKI?=
 =?us-ascii?Q?nwMFOVwUPzKcBdA+gePyp6qMLnqzn64O1pEAeWHeUgsId24drEMLqfUeDfjX?=
 =?us-ascii?Q?5W6qmRivvrG/wyR9JIMRzYskp4ofdBfjcX1M0nHK2oi+hgwX6a+6IFE0sz7Y?=
 =?us-ascii?Q?FJwJvUHMDS5AgpuDiZTd+Hx+ZuVsKNWYZkw4uJdkO+Sxjo2Ob9CXTTnlzXdh?=
 =?us-ascii?Q?h3c0oJz+XS+SO1f7b6uMsdsjhgjxtUNijKwmEYg2xHQoCqmiHRA3zli9sprf?=
 =?us-ascii?Q?eYnLX0LUjhPTVSkPq3mnp+cMmuOcFKQOszDRn19F3RzaYWhmkPkIygMCXZ3n?=
 =?us-ascii?Q?xIQdUr3c2Evp6q0LgFthx5HgNUGCIlU5C4FtYiqDzBw11YMS8p7rDA2HNDYv?=
 =?us-ascii?Q?SKxffDuW6uLTzBtVZReKsbssUcLtstNCP2Osz3itxPDOilnN6SWWUZrOBQC6?=
 =?us-ascii?Q?B5Qv6THPBktKMSqh0xYpOKbCVnOvDbBoPlZtz58y+SHjz9DgErWlneaV0NWE?=
 =?us-ascii?Q?X9ICfht8cewGX08/Y0zgX1EYCYybYNXNjPk89SORj8Yt7yhoX8IBfqir89bS?=
 =?us-ascii?Q?7+M9a7A4c24SZkykyBj+em4H04TsN/jvWLoZOIqHrHzAeGx30567uJoEH1uf?=
 =?us-ascii?Q?5a7w/Z9JHdOgS5WR5U9oyowEEK8y5MKfnwx9/89M10kT133EewlBAgFDaIQ+?=
 =?us-ascii?Q?fs5L8k5H5XQxgMDfcSI+ys0VRqV7woqEq9qy7N3sTW2FxSZL1m0xfSG1FXMY?=
 =?us-ascii?Q?ZJLsukezn5UEBmF80maL6Hasyaxmp8O665aHBMvpokB9XznekrQHELeOZHGj?=
 =?us-ascii?Q?1spJHMlUet0/28DVPtSyK4Gfl2ddCeOkelXveFQ0BthjtxnUOjeSQtokwDhf?=
 =?us-ascii?Q?/lb+CKQg80WtO1MNwgltR/CS20mGSadB38aizgy0tRRBBd3fOey80qNPnyrE?=
 =?us-ascii?Q?t3kx7Ms7xW5kLzd4MPZhFEPKtpZqHcbisJR?=
X-Microsoft-Antispam-Message-Info: UWytaryuGXnC9kTtWtKRz5YaQbxx6UPdWd2sRSSexQBVUbJRp2/FRGYqSxjqjEdzpOSe3XcYwe89f6TA9F6w24HkMoDcOp6z6OFjCruVBOtA9/mJfZ8kihl9ty5d1NwA2EmtEa6Sklg9cPve6qBT+MsqDyULPLBAGANT741KncSVFTh5ySOfUzjDINe7Y8aLCQnJlkW6pXvKDPDuW3Wzwq6+w8kXgCrgZp8JQetXl41Y2MVeyCAsjb7uf599xOQ9VWQT/wurGZ5ewjvPU2oK9BVrWHnPvgVKgkA/i9QI1bzLIj4cz4UtJOXcbGT/WCAVU4WUenjFxO/DXLbrBkB+kIM9oS4filXYkIcP5X0cNxQ=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;6:WeuBVmFNOKHRIBwor4ndQWioa3MVQlsoN+xu+DXR5UCtLY2wgJa253pbaFndovSdt5CHqhqJr5MTtCrlruM5fo3vYs0+mC+IuKMgP1+FZXuTa1bEKH36Uz5PlSm5NC6hQg7uujnHU6Xdu/egjCtlmHlArOC683YF098C6XKCGylDe79amt0K5qujCMQ0bDUHSBNf/h9h909HXprVgQR3PW+Q1t3EFvgRAWn4wuA29o4Hv3wvRzTryWi1xn5oLu4nh0MHGcja7aeilDqnlHy4g+ITO86ABRT6X3tqGqYzfacv2xr3aF+FEPUNvw1b6p+Pkc3NSj5yknCgOch3H1Hx63qlB2dhCJvKt0niGP5Qy1SztWrGB4KvX3pU8D4S/ButjTxfInnj9pb6X8PgJlOEfKXBhwoUOGRWHDT7TGIx/A+YEpsrRbQEW8ryUy7+SQLXLWYZBaIbTZ5wKAd25QRNlA==;5:3YAZV4cBJB/kLGu0sp3a+3x7Sidm5effXPAgoDm4hNnDpbxjVvWIl1YNd6evq8sZwkni+3bRetv4dGB9pG6q3k5crnzAGHr1yLYndpO+H32nmOh8IYLgphQnIg0fCdaP5zLw0/17RFtEeifKsBUNn6M9nhRr2AxVTwjiEVeVjDc=;7:iLH4Dn4tYlExId68Yn7aKpSaigXKLuYT7mFYZXl25AcPHAiaelX86bLTbZY+Zo9UR86FO9FirvEMkpvujzOw0W0EVAfVL4gE5SNiI+7OFpo8A2QJWTh8GFL7uXWZS53zdzCYCo1PGAJ9AGhsrEOtDhQ2YPcTaIu1wq1n+eyp4+rpuZqTxkn/9pcVmoN8Z3b7P6XuJHLxsmGAwvGFk9XY4gCm7yuGqC8EH2POxo6QRZCOsXcVjguqyYPu2oQmWWa9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:48.4316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfef9c7-a077-4d41-bd66-08d5fb7d7a55
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0966
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

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
The mainline implementation of read_seqbegin() orders prior loads w.r.t.
the read-side critical section.  Fixup the RT writer-boosting
implementation to provide the same guarantee.

Also, while we're here, update the usage of ACCESS_ONCE() to use
READ_ONCE().

Fixes: e69f15cf77c23 ("seqlock: Prevent rt starvation")
Cc: stable-rt@vger.kernel.org
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit afa4c06b89a3c0fb7784ff900ccd707bef519cb7)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/seqlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 3d7223ffdd3b..de04d6d0face 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -461,6 +461,7 @@ static inline unsigned read_seqbegin(seqlock_t *sl)
 		spin_unlock_wait(&sl->lock);
 		goto repeat;
 	}
+	smp_rmb();
 	return ret;
 }
 #endif
-- 
2.18.0

