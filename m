Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCB0C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA4421581
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="X3V0DQpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA4421581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbeHFL0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:45 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:36220 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728147AbeHFL0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:44 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BH36000422;
        Mon, 6 Aug 2018 04:17:54 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp0083.outbound.protection.outlook.com [216.32.181.83])
        by mx0b-00010702.pphosted.com with ESMTP id 2kn9y5kk7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhXOnm/+Df0T8LUW5D/0bgP5ZPODFdrO8CtIVQ56ET0=;
 b=X3V0DQpfh0L+2xnvDijv/NBVoWyj1kGrTm5RqvnRiVaidGbhhV4xfrqiLy1l1+DST0MAqDS8CBXHybhqDwbMcoUEfRCqYF/39L0CMlhD8+bvxIN1+9+uj03uUEJIC1Zvk/hwg+DOYj4WSNNp6aInHijkQaDH6Uzs4Qx2M1Gm9RM=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 MWHPR04MB0975.namprd04.prod.outlook.com (2603:10b6:301:43::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:43 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id C8606302D73; Mon,  6 Aug 2018 04:17:38 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@us.ibm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH RT 04/22] futex: Fix OWNER_DEAD fixup
Date:   Mon,  6 Aug 2018 04:17:20 -0500
Message-Id: <464abec1c5e435a618d3dcd6a05f207e8456d53d.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: MWHPR1701CA0022.namprd17.prod.outlook.com
 (2603:10b6:301:14::32) To MWHPR04MB0975.namprd04.prod.outlook.com
 (2603:10b6:301:43::36)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35e662b2-c779-482f-5768-08d5fb7d773c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0975;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0975;3:uvUg+Rj2IecLXbFR4LIparoldNZoirQW8R35ZwU4sP7XU5vwFjQ2I6nZPav6aqpksXmeShcrIVd8V6WyikW0MLqk9OU0iCiuI5ViV4bVOvlagGpjVQ/e6YsX74G2VU6+niNPjm1aiSBSH8I9thpyBDcVjKmbKeVhBSXb6Bmth9xbiF3Oko0QNR5AiFexAJq39EgL24BvzwCbujz7NSMtrj46NZJxWhAXIE20Et5BoIoKFLjftuJnUK71IoCf2n4F;25:8sN8jPz5TOBdDtmSE+YIrM4DH81gmI3+GlV13urIC2GQViQLMOi4IB8XvPcUglkPtWhP+sn4NsLE5CzFSaYn4CBC3k74Z77QIeUVlyjF4UAxmk0GjQinCb7dEWb5HzD9o+RyA/uh+7RG681S0c1NB+r9Vf/hVRl+QcJJTJpJjWomDw5Z1sW2M3xhOaEFoBNfbWBFzzjzZum/waL4iu0x399neGEvdRfwZcjWBeXWByhdE12PmXrjUtUjE1OSUYyWn0nZsZXV0gTSeJObRqXZCD1RqmYOyu3xf/tnd+D1yC8qa4QGbgyY4fAXcMg5dipddM4BmZQHwmMNNwJfr4s0dA==;31:HcKguxmgVGZCCXLrlGBpks6z0HokPn1xBDQrm4AwToTQhgX/Lxawcc+T6lJRtKAry6G7+U5jQ5WWp+w0fC3qPxvMzhH+dXiKtGFwgPb80i0wGyL8VLyUAwsvmZ/N6HwlTfGdBZ+ZOsMN+pjiHDfuoQwxG0VXlvY6D9mCLkAqD3uWj19JSleBt1sVGiUQbyD7tT/A4yncPf9DPbj0/ztcrHeU0IT4nULn6Mf1IF0Gk28=
X-MS-TrafficTypeDiagnostic: MWHPR04MB0975:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0975;20:Uck/D5qjuFqz76P0ecuyP5AduXchXIyLO5ggEPB9cA+rGMgn1q4BV553PY3oDySzzmLc1dCxO0Upbw1iEYvgCCOg2EfxDWVS1KX/LbKZcQrAIbY8ATUxAXusmnZbVSHdxLhykW2bT1mDmj7klDqFc7gDF5aENNJaVJHowCO3uiGUCpaDsfZ2y3oWNJg7lRJTv3wbvJ8mpIuOCmcQB2k66QcvYpJyrBwYJEPhb6F+trQPC3HqXAaLPA4+xUSevLW3gzHxGRZjF/jpS3r0mlRdx4qtoOj8TRpKass5sE79f8GP0nIEnmmrjHVQbJH7udi6di5p9eb3xKxSI7IrdVfDpDYEmgQCkgUc8c3xT21ORpohHMceNsjVk5OIV9To4oItlRDHAK8Wj+HH+qF9Ky/npzcwoPbHGMXTZzn+okc/2dY0u7Ufr1odr9YujtRrcjwwAStjqrGrD+37me8EnXC1dKdwXVfeXJTxe5aVF23vLC4OuWMGle5HW/kJJS31vyxO+XXi9G5CvItT3G4aKC6xkW9lcV335st0zB63WrxGOpclOOy/km7TeR3LjbHduXwjDZMJ1yDtjxqzo/ohlEo9OYP89hvadkAiGlvCzremx6g=
X-Microsoft-Antispam-PRVS: <MWHPR04MB0975E78F3DCC45EB52BE849EF4200@MWHPR04MB0975.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42068640409301)(274839183919467)(104084551191319)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0975;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0975;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0975;4:EgSbUtH0J2lwcncVfKHD7Dv52tiNtrAgNua8uzkxhGawsSnRRSCSJ7nb2JYfn7HwuodzUNQ88q/OLzqtwMh5QUFigdBQbX8Dnd2Ba2j+Plu/nddwEy83ip2Pk6p2xoD/XhZJQ3poWhXivjQWNdPhMlcW7FFYJOdAeaj7zCUgKd/BMrNsVmpSlmb2APkgGxdlB8gTSbwQEHxKuS9XpQzTDIP/iTGKTJzHj22YWckhGq/BiF0XeK6tpHkB5wdZLTFU2gkOp08B24ReVuFkhWD+Yj62YfXGjX658jlxjlTif1taK2zvE2ycrFVWugYn/7DHCuaYGwj2vF+eDsp3w+o1YGtpSDWLWvaZt8DULJXVMkREjuPQ9mybJCeS+eZhHUREGGhkJhM6hSOlcSVJzEQyjkBPHr7tCdv+HrInIkr1/Kk=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39850400004)(396003)(136003)(189003)(199004)(478600001)(53936002)(4326008)(6116002)(3846002)(6266002)(105586002)(106356001)(118296001)(47776003)(97736004)(50226002)(8936002)(66066001)(966005)(2906002)(316002)(68736007)(42186006)(486006)(476003)(36756003)(2616005)(6666003)(48376002)(52956003)(16586007)(14444005)(54906003)(11346002)(446003)(122856001)(76176011)(386003)(186003)(26005)(6306002)(90966002)(81156014)(51416003)(52116002)(7736002)(5660300001)(81166006)(305945005)(575784001)(7416002)(8676002)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0975;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR04MB0975;23:NJtZb5wNhLdVK1iC6Z03AguMegDegO3ZayGkxA+0O?=
 =?us-ascii?Q?KoDPieRnpNEs+cuscCO6Vr2OS+uwVTHNbfT431T5Awqfe59YVfhgSrkFTA2m?=
 =?us-ascii?Q?TYqGfe9WWMqhPX739p+oQPw3mJRtsXLf8ZZnKUUO9vAwWAXByUC4LA4THoWM?=
 =?us-ascii?Q?CFw4uT/+TtF8LPr5o0iTCu8CLZ4D/k3KcRHBoqO9ZLfzwasuHGbv6Gkg/Piq?=
 =?us-ascii?Q?Z8Eafvcrc23w5ZAHKCj/H/AGU57g6dg3NCM70Mniwly9LqtA6yX1Cal/2W3V?=
 =?us-ascii?Q?Gd2W3sjGIHt3z7tyKPhyFiJqlu6ZSUQzjV/BA6ISh/TgxOxBTNhlcaop27rC?=
 =?us-ascii?Q?G/virdZ+ZYSYj0PWEXJF/lBw6VbAmw6ZsCYa68I1YFTfxi04Dhmmi7MZoGrr?=
 =?us-ascii?Q?41RJqCSTv2hkaGeKDX0+s/TycfT44ggFLRFUUzENfZCn3aJ7B58qzp+im+U7?=
 =?us-ascii?Q?yN0Ltv6H5+vS5YI5Uet5/O9XEL/CAPIPdCadaNzza6U4MVA4jZQU/sH0aouw?=
 =?us-ascii?Q?hYTFqBbuDn5vwfZJfVox/pwr6IKtBJgSfpTY9BWyf3VDvODyoRS3B+2dR0fw?=
 =?us-ascii?Q?p6lSlv3u8deS406b/7OQ3GB6VCAvIrK7q4UPM2ts8ycktl3j9l+Y2A7g5rPV?=
 =?us-ascii?Q?X2mUmjyP7o6TB++hRGj+fcH/p68TZRWSm3rr0R+DfGQaRuriziVgw/RozDfs?=
 =?us-ascii?Q?P1AJyrMNwJBMjbqXnXUNWMuFjaxlFjjNYZa33Zp5wjzj459YS+fZKm+jkBjL?=
 =?us-ascii?Q?Xw0Y7eLufubkxs+wU8sHwGkc/fCxvkKTCpB3uIrHgKxWG4uvtXBh+uvLUI6Y?=
 =?us-ascii?Q?SBwswAbvgIHc9MKTRLQc9Vr2tfuywbPxEpISakO9mjWDuvMJeUbcB+MWufKf?=
 =?us-ascii?Q?UARbzJuJxbx2yiP1Zwqsu9OXKkF+0x5dV0CYYNGG7I5Xb+SbkZknDxPkkGcB?=
 =?us-ascii?Q?Cl25wWwYww1idKtOnPH83WZn+nD/n8f+WLoun7BtTlNVG4xHc5zHsYZ63xDL?=
 =?us-ascii?Q?LlPpfo+1sm0aGLvjAUC9QYP3MGtj0NJ57ferq/8GrZmaJZnI9MOy9kRuHI3+?=
 =?us-ascii?Q?pKE2as89FDtU4kcmmUHogopnh2NO2If1gN/SNlV4ZfddkSjG5/SpPh8m+I/y?=
 =?us-ascii?Q?aOgHCzd+0sWt2AKhnhLI6WNorS+Gw4A78q7/6bDmh97zEZrWB5E28xSCdjqm?=
 =?us-ascii?Q?85Rlf79DvYJG04oOBzg3kf3HnE2ZQx2n+oFre4ykO/nioxvQnY8hUKW1VAMf?=
 =?us-ascii?Q?3Z/vjP76UfljgAszVU=3D?=
X-Microsoft-Antispam-Message-Info: WAb++P9OtG4Zs3WWAasqkC1lHIKmJ/Lv9+KqootIzQjyDAp2yFK1UZcJwvKEdn/jII5iI25ZlNonOkNNEG9/uS89PbpH2TX6J4QTBNTf4dhgo/N2eyCl+gSBDX9BmH2dlmnTUiLEVuSof27wWW+OjVjk6EnPQt8ScWS8J8ZfkjWImpErne4/EReLRXEDXJH2dI/b1yKqtArEFzkv6rTP190VHszBTx8t9MHWAogbKqq9C3z/j/Qe4w0ktuCpS+n6DCPcC8votbBpnjGG7wVNGUnkaggHyeD33FhE22BENevNSHVKT3IC++nbTmRk+5bUnJpjmNXuWagdooB/78A5fd/1cdicIBooI2+4p6zypZo=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0975;6:D3fz3bYG9lqdQHJCM7RXNyUGp/pT+9ZZInky1ZglXfrhOuN0nLmhFq+nUmAJefkT/XWNYSN7VC/PtRAswFWiWh9fQRRH6QVLA7jjXT1VNrMU3BAyOCAfyW0jVCeqme6ihWeuaFJ0oH57PpMaWk2iIqKmJCY8MmIf98y5rcslN4P8JWuoFbcJnSgUOL4HgAhkghYGx6vm1vzPkFs/O4yh+lVdcCYHt4qYHecRHDSvWu/fBbhA4d0zNazmt2I3Hg5vsVLgWfq1Fxbk9VuG+u+vyyT/W9RSlakyrWiMosgssbZl/SKvY/W6foM+J9x+Ec0asdperb3LylV4mzOYplTBP7qdEK+fp7cUXv3RybG07KIYrCQ1rO51uNwcFQ7z/PYShok+qxjDQL9R0ZTUcKHQIYN11uGT3LGb8Kw8wLTQh1pe+OpwxqOiMYIyYFj/0V1NBDL6WGyu6I4A6vjsUfPTAg==;5:LNJx6tA9HgHGOConCDONCobPvy1AqnZ39vcDed7P/v+KXcobW6OLAtKWBTYy5f9U6B+MmnjaDYFDzFxSFOT/oZ8CPaPLEMUnQ1szaxsrP1hhBzyEvGiEdBMX2WVn/NCoXvx/3RahaKTpEwpCR3+CiFeG49zUE5ckHLrwwCKXi0s=;7:xI1AqkMPT8hIBcvujMkKMcOiVV9q3EywJzjj5woKqLAEeqe1S0Rh0R+sR1v8j0H6xhurXMJwoIjSG25cS50GzHGTP4kQZbIEb02onVoQYo7f2NrgKm+OMvPV6OU7AL/pyMt99gH0xj4Mt3yf6wEkqwUMjChaXfXKsMn+qpmVvnGuobc2cE4N3JeAXaLZLvVFa+v+QvE4RvWwS3E2U8ypA4+uIZkAJHNTkReFttA31qFnjff4XqlLPybeqc3mrS19
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:43.2095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e662b2-c779-482f-5768-08d5fb7d773c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0975
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

From: Peter Zijlstra <peterz@infradead.org>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
[ Upstream commit a97cb0e7b3f4c6297fd857055ae8e895f402f501 ]

Both Geert and DaveJ reported that the recent futex commit:

  c1e2f0eaf015 ("futex: Avoid violating the 10th rule of futex")

introduced a problem with setting OWNER_DEAD. We set the bit on an
uninitialized variable and then entirely optimize it away as a
dead-store.

Move the setting of the bit to where it is more useful.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: c1e2f0eaf015 ("futex: Avoid violating the 10th rule of futex")
Link: http://lkml.kernel.org/r/20180122103947.GD2228@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/futex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index cdd68ba6e3a6..57038131ad3f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2301,9 +2301,6 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 
 	oldowner = pi_state->owner;
-	/* Owner died? */
-	if (!pi_state->owner)
-		newtid |= FUTEX_OWNER_DIED;
 
 	/*
 	 * We are here because either:
@@ -2364,6 +2361,9 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	}
 
 	newtid = task_pid_vnr(newowner) | FUTEX_WAITERS;
+	/* Owner died? */
+	if (!pi_state->owner)
+		newtid |= FUTEX_OWNER_DIED;
 
 	if (get_futex_value_locked(&uval, uaddr))
 		goto handle_fault;
-- 
2.18.0

