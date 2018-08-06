Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FE3C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB52219E8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="iYSZ2y9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB52219E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeHFL2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:28:24 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:36138 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729230AbeHFL0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:21 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BDsG000403;
        Mon, 6 Aug 2018 04:17:49 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp0114.outbound.protection.outlook.com [216.32.180.114])
        by mx0b-00010702.pphosted.com with ESMTP id 2kn9y5kk7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cNEaEdqAw3Jg++MUhSKQMz+PsBbPNX9OnNY4KXV7iQ=;
 b=iYSZ2y9EMRpe9G0HFZ6hN1n/ZncsI1AtwwXsUUzRg1LxpqGw4OUmacihcCynUu6iAV7auF7UQ0z+bWklsGERpCmU10IBH2wOtc9xrxAfHLVYjZAQc9sjamLu7o4F8wkDXHxZNZ71WCnb6xtwKHTB4sbojfFuk3feKoyaDDrlkjE=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 BN6PR04MB0964.namprd04.prod.outlook.com (2603:10b6:405:43::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:47 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id 3304D302F65; Mon,  6 Aug 2018 04:17:39 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 19/22] locallock: provide {get,put}_locked_ptr() variants
Date:   Mon,  6 Aug 2018 04:17:35 -0500
Message-Id: <2b33e3060bad998f3b93d170659ba05e4c50f4b1.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: BN6PR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:404:b9::17) To BN6PR04MB0964.namprd04.prod.outlook.com
 (2603:10b6:405:43::36)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1146dee6-eb61-43a6-e049-08d5fb7d79d7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0964;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0964;3:qu4W5p1pcvYySWU//XqFhn77Ayk4ptXkLNpoxsLWwy9X6tAwUVohqXprw+ubdI/a2ylsSBiHzldjd1jyso7SGiC4c9GP6ji84vPR8CLVq1T52NuxPFum6ZioXPS5mSUxfqtMNBfJsVyj7nJOnCC7hkqeZ862NCSB9ZnWfXv9sidoS9oPqDLMA1zGU9R1nWyRBIVhezQp1rnCGNjpvzPkIcwqYBfIT47NgJzPxWtEsmE1mINf1vsPMFdiqj6hGCiP;25:zgXaN6SZuXfrd84i3PS1dmmkGiI4YThFd4wqXorR0HIOVHyLlpI5i74nNFYeyeNOVuPQ1cJz9MssBrIa3yTJWnyA5nappf+sYFR1B3FLOLWsnl9QtImigzBZfy3ZVKCx+/7EjcMQY5alYe5TgpevL3R/TtaZn4Qi3bx4bS7QQ1U1S+zZnwrPQW611mYLV9Y147MGjptZvgf/dTjpWyX0pjhMWyVzQc8c+fE+2Pvsw/oQKpRuleKZeJo/kpJaMjm/ceM7vOlnUbVP7qeV16GVdhZ3c01plDtP5RkJ9Vj0EvVyS8OnfWhNwedDmUaOqsOJJbLcSgu26PCfCvpkRIDilQ==;31:gbJ7FM8UM3N5lgDMLM5hj4N0+17tRBVFhTv96+cehbk87AEc89MVR8mHLGg+P3B0XL5jKXpLrzrZJcAFpBCNeaQKDSCKPF6nt4Tn9dH3JADJlVqcDrXtBY05CABKxuabxQURYG9YfKIZSvSnR6wY1sW77EjmENKCmdJ5w6TbcRgGjepJbdxRdnVcT3OxnMltsNdo27jppzgXb3ysmWiyWwBfsiqLfDArUhYv7BU+Fdc=
X-MS-TrafficTypeDiagnostic: BN6PR04MB0964:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0964;20:Y0P8UNReCe06n52c3SA9jXwui9M/3WPdq2IuafodcMpFkxSja/qqmxSUaFEpEX//gLdZrS8aTyb55QCE1QqkahKYIl4IRl9SYL8W0yLRnH7GOHKqJnK5Dt4i4wzjcQUEi+PllGCpyHGkpD5woW0ygrtCLNvrnGmK3d9PKlel/PKj3ihaW8oEx396OprWrN4zpiG3t8zPFx3fgiA4+s78S2ducWyFazEzzNxu2QLk/nUx9zAPsr/NdSc74eyYs1aXjlRMS28nwsYxlz2RtwX2RjXnIUES3M9d3hA7eIKYLvjy4wJK+Y0q1v6dJEpJajDZdoVS9TGFuAsy1jeot8KOm4RebOLBmxaNbakbMXMJMeFXc+LcXa+mLAauLNQIR9yDOph0B6nPpisEltmbBuBQywcJPlqzOOjxxcLKTTZnubN6KYnkoGjSf1yhT4/PUoKRFAm74+pq4ZFFsiL3EpTnJgONyu7U+sqU1Sz3WdJWUIuoZz+AVJwilGgIybzcc9M7AocRIznG8NiDBmSEYkfgkAB0pgtemaox64RpMFPKpEEX7i+stO4uYd3uLvrH/G9qgxW/cQCM8CUrXLPDplx7vO9qmq0P0fQJPq+sY+rpxBY=;4:AhLL5flfAsnxkTnmcWzmtUXUtR5TXnNCWMJeUpOLv7VLCZuvsPwf5xftiYukSvly3nG0WPa2qk/fCbhfeHX9lLlW09a+J4psS+Dkz7DSaQbHUQzMwElYJpmpf+mLlB8K/7FnBN1Nks9KI99TR//9Sj1qAxG/OgIDMh5sek0OEGTDZ1eI0i/fpfFYFefagDl6lZ3InmuudBsiQRpRkSzCi0bsbQfLdu+tGfZP7B32XkKEPSFqlHVbJX1rSd/FcWF+Wa12p27GFFA+MDxkTNxVVi0VCrMpQgVtT8fxpCNS5EyI50azdGqEnVZkaehSx8YC
X-Microsoft-Antispam-PRVS: <BN6PR04MB0964F1C96E666865F85EBF6AF4200@BN6PR04MB0964.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR04MB0964;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB0964;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39850400004)(346002)(376002)(396003)(199004)(189003)(118296001)(76176011)(81166006)(446003)(6116002)(305945005)(7736002)(8936002)(54906003)(386003)(316002)(53936002)(52116002)(97736004)(50226002)(51416003)(81156014)(105586002)(8676002)(66066001)(47776003)(16586007)(106356001)(42186006)(6666003)(36756003)(6266002)(11346002)(90966002)(4326008)(5660300001)(14444005)(3846002)(122856001)(476003)(2616005)(7416002)(68736007)(50466002)(48376002)(26005)(2906002)(575784001)(186003)(486006)(52956003)(478600001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0964;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR04MB0964;23:7+ZFYhHPek0yrIj2235MGo29+4TWLC3JeMk+pr6OZ?=
 =?us-ascii?Q?KuNMmatFrMTXbX96MWBaulrmwiDNfe8DC2EaGZLepCRcQczIRRxLGVxs4lDB?=
 =?us-ascii?Q?bxkm+s136KkrEenTJbV15pJCXPyjNV7HcSxCOoDf45RaKFojiz+72EWMI8oA?=
 =?us-ascii?Q?G5BJACD3fwXuXEYrFJG0Lvo6vG1yqlVGRQww+hOlcxGl7WOakKjtsy/rDl39?=
 =?us-ascii?Q?PqrFHCRcgqzxI54T18vTBa2yL9ogE5BfocUAhWi0RlVLTnCQNvVK8o+891KA?=
 =?us-ascii?Q?E3O58HYFVnz5tCg61//88fDLAU1zncTcF+Bo8bCsZHpdyKA+3gSAJd4Aiimo?=
 =?us-ascii?Q?5Ad4CErnLMpjANOWjURbUV2AW4yXA6inDoSghCeK7PFEShNZMu3C5wn8RWaT?=
 =?us-ascii?Q?nxdynJtW2rzdR9Dgd0XBUKm3AijTvLEHyF3XfqfLKTGJqOpnkagtpqf6rkjO?=
 =?us-ascii?Q?MnnEPMbzMajpghr/qGF5J56xoZUS6MhtBflaIXsWW7MPn8YK+LudyJNOIhCd?=
 =?us-ascii?Q?gAoCPdyiE22CHoEtbq5HE/EcgnNlcC3vRoP5KODttJcu4MxxjRoAkWU0qvy0?=
 =?us-ascii?Q?YTGmkrQ5+CPyeE+WBqHY2laLvb2/garJZPsR+zd83nbINOHNPrpJF6T2vKzO?=
 =?us-ascii?Q?SbBAwGboM6spnhHDz3l81xpwFbtnLfCOqqALm3xZuhUvnn+YqYnLwdUu7q0e?=
 =?us-ascii?Q?n+FqshyNyGOujZQLsDJiTN+0A4ESj+WC9AVkFVk8PEwJ4kQdi9r9zIdUGcO4?=
 =?us-ascii?Q?AlGzbhrTiR205erCVMxT/IoPBoawCWB6KgN8ntjywZwHWF/YWg3fVimpTsB3?=
 =?us-ascii?Q?DC2E2liWqHAdbHRwCn8pGcMLEMamsLzGb05UZX00XyUAbGjaXId20fRN8rkq?=
 =?us-ascii?Q?wvW7ZFKFEki6zO71TwSKjcDBsJ3FuoQywJHk122jj0uA2L0JfPV7nNBKnCdb?=
 =?us-ascii?Q?VuvTZGDkzm6Uau97bi+Ve9CT0e7Cfx0go0u9vUd9JP+Eab8V3NFejZaUsKGk?=
 =?us-ascii?Q?D94Am6TqAc9PrTJS6gFmpZrtqbjm26k0/Els4YkYQ76imfkxk2aN9HjK4JQG?=
 =?us-ascii?Q?GM12ORSNEcm612ScdHNqpGcUTJSOVIjv33Iyyj5osF567Go7W+gfi4SuYTQP?=
 =?us-ascii?Q?Iri+VUr/gNVGmzU6svYYEHZ9MllGmRIC2GV2XruU/hGfhHUz8jM5lTOpNCg8?=
 =?us-ascii?Q?mAfuTKgBckZ63tsVemdKBvCa/geVQDhOe94+QqB7+fWDYK2AjUOA+i6hsXBa?=
 =?us-ascii?Q?jcFrbfGH+pBTxiy5Dg=3D?=
X-Microsoft-Antispam-Message-Info: rV9hvn26kbEaBmjnUwuDoUfGIHIGGIvVuI8P7399hcHzb1xKDpTPHm+Dz7RNwOYMdwilqZAFpbmnmlhE7dIkj2AVLYdJDKmbhexRIPX2tE78T/MKlqKjZ4mETBLWqhqLlXvHfhtRAPrjhnMGHP9FX9f8US5aHvtMcqHm/Rhaglio89Z28HL2L10UZjZ+E+jx4XQSIG1bgP2YTd2HntcHu/MFbjAYDn630P12ShCOF0eEDqW6T+eXAWGkUT9+GoB4BLuy8CtCQ/awcUPOYApP5AW6X9ca9niEPVlgcLohz8W0q9bUEtQOHmYficRybR0p0lQ22U8iidea8+MU7iqbU6sF9rL6EjqLUGf8L4+CoIA=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0964;6:U9kaZY2PA3TN6EGOBi+Z7/tbDM0esDrQQmfpwQUsemSgspwKW4jCxqAh7EPZAWKz2J2adhEWFVC97i2WGaMYHPAx1NcYvBJh4+7WvS0UCCj/cXrYFGMgPKIRpMYw0FaOz/cKCadSHKW0Cpaoi+pBndgLNOB+jYD6upFJPqE6HlJcgTL68HVShtIm2QZWf8RSh8nVmSFkJVxEIj7ZkIWoRgsCiUGUssKHTmkk3aBxHWxSsBHDXz34rM1s1YnZdtStVRcYjAioCuI6VsnBTTlDPGStUKnsVnt0k9qBDO2dvSTA/nAlFt8LaID1oq9aS7faCQsXYqmfWYlteGekMBzljgbw9Pc1bOUZmS2slQW4Sl19sErYpQdPmDpps/xfdu+5BIo6dQt3wQYxfSpR9VlKjtvQWcFCkOPBLGEg59aNOq1+9wpNCK8coTh52Ibqk9R+2QJmNIrlssthziJmXbcc/A==;5:yf0AwSM4G/4Sy3Pi+aF8mB5Ezc8Il9UVNKwxy50XGXTnF3mQlML/zY5/SX3hGPc3WUTigR1C/75lURb5B0MgeSsBDWiU+uf4+/4Flf0hdEMb+8IAeA+uOQGSIAJXxGySJJVlqUPzg+PPPi5EnVPVSglGBG0JLvZ/wAE/1eWkhKs=;7:1cOp+O9vx22PVmwXqTDOxCEPKsCHGhj7eGHiShxQs2ETui0BaVWUDIgbzBMUBnNrePrfHFiWe9wsr7Sr8ObifQEpYWIKyLisgiWvQSvyH6WRrsx4BYezmgkA7OB9Wxj6Rz0j0lyL2Dbdiq8g1+1oU1briFWf3Hcyysh30COyVeFX1gRDO25Y6s2PAEHh8ZMju02C+9uXNr+pny81fFcOszlq6ZiFnQWVgXkFI10kmo+wrWJQN4dNFCvQptIV12OQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:47.6155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1146dee6-eb61-43a6-e049-08d5fb7d79d7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0964
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
Provide a set of locallocked accessors for pointers to per-CPU data;
this is useful for dynamically-allocated per-CPU regions, for example.

These are symmetric with the {get,put}_cpu_ptr() per-CPU accessor
variants.

Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 3d45cf23db4f76cd356ebb0aa4cdaa7d92d1a64e)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/locallock.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 280f884a05a3..0c3ff5b23f6a 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -238,6 +238,14 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 #define put_locked_var(lvar, var)	local_unlock(lvar);
 
+#define get_locked_ptr(lvar, var)					\
+	({								\
+		local_lock(lvar);					\
+		this_cpu_ptr(var);					\
+	})
+
+#define put_locked_ptr(lvar, var)	local_unlock(lvar);
+
 #define local_lock_cpu(lvar)						\
 	({								\
 		local_lock(lvar);					\
@@ -278,6 +286,8 @@ static inline void local_irq_lock_init(int lvar) { }
 
 #define get_locked_var(lvar, var)		get_cpu_var(var)
 #define put_locked_var(lvar, var)		put_cpu_var(var)
+#define get_locked_ptr(lvar, var)		get_cpu_ptr(var)
+#define put_locked_ptr(lvar, var)		put_cpu_ptr(var)
 
 #define local_lock_cpu(lvar)			get_cpu()
 #define local_unlock_cpu(lvar)			put_cpu()
-- 
2.18.0

