Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66292ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E6F20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mvczQkQo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CtP5vUDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E6F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbeGTSgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:36:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38278 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388084AbeGTSgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:36:06 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhh0q025812;
        Fri, 20 Jul 2018 10:46:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=nhWywkFX6IxVsNEfqqLpZ74YgnutblIE82xvToSZxes=;
 b=mvczQkQoiI4c6svFr0SQNZ8TSG2AEpvrsDZtIeyNKbELQlMdezZ7uMM2CVNsheoKokk7
 f2J1o7VdYuM/ESnwr7s8KecNI5XNnq0fOMOIzQUuhqHojr2UFfzMDzr3AHFitu4SXL1w
 dIJR0A928b8MmGOuBDi62flL9EkCHpU7pfI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbmbv80dv-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:46:25 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 13:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhWywkFX6IxVsNEfqqLpZ74YgnutblIE82xvToSZxes=;
 b=CtP5vUDm+LAgAMDbVoy1cseIckD/g9/S6IFcHix3D/Y/VYGAo3eUMMruBy+ARuk2r5wausSCM9LZjd1D563gp7e8lBFCP9YpKbdtgd6gMR3CRDbiHJY6XfENk2qAKC/SHbHP0Yp6lPZuKAxcZBDXaa7WP3nH+vWVNKR+zZ46FrE=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:18 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 05/14] bpf: extend bpf_prog_array to store pointers to the cgroup storage
Date:   Fri, 20 Jul 2018 10:45:49 -0700
Message-ID: <20180720174558.5829-6-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720174558.5829-1-guro@fb.com>
References: <20180720174558.5829-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:ca05]
X-ClientProxiedBy: MWHPR17CA0096.namprd17.prod.outlook.com
 (2603:10b6:300:c2::34) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 913193fe-52db-4d6c-051a-08d5ee68b350
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:DqNhFULyznIoc7SxE0yCs1NPRlFt3aCrTBvFksKK3RhM7aGJ6PklLRkpMPBqIJqOUTsOOch4vOquGClYs7rLxu8GtRVZ7Cb3vDfTJ0vbBiT5xqyGmNItU4+/rifE9VwMC9Hu2TotmqVhLQ29EpTXmE1wqnbpgde++AMqAAPQI15OciR9924VfkO3u9ZNLI4tY4czpYiyknyzNQNy2nwWoXkW9c7gKPp14QnWXHj+U9MJmGOlJK682W33BKNCHxZq;25:wWlFiyfOnSH5LtCj5rdiWkaMxGnLYwOXP6fAY5JeSu7qeMpCwOwhh8QBIM+P6GDu/cz5mJhMrKV+H9rnuwysQwyVM6OjdXaQgK1hdku+5aIJNtKMRc/X6gdOKbOKVMR6ud+1IPGi58B5U2erPPggbrdOFgXbv9SkwSOx6O1T3cQ3dITXnJF21AXlPDknk4zyt6krEbeYpI4vOIiDDr7rqgN4Sq1ztGsC7veWr/xynEfMUfzINxtpu7B1JK0kL7LnbT5UIEYhnqzWZ5IEUC1YB+jGbQxg7DQUDGxOzzrmG8kF21fhoX7rUnidgrw+CFNAiJ9fY783EX9zsd+hEQdxwg==;31:jPopD0CHu7mqGij2fbL3ZUFNGjBO0g7h7XeeVGFdMbXDCOM3INja6Ks8Q/UlQLTwIswpXGQc/ayLZA8Bq8p9h+pid5HM9LytDeSDY54SVoHW6s1yJc7LNFn+FLbgcixwafHBJaM15LmmZHZ6SEbK7xJHCmjtGZGwsB7v84G+ES/eSjMZfgY0np1aHVmtohA1KmLem1QGxy3ZGoEAO5gWcTDaoerGckw+/Zi32uybCik=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:08VZwTn22IKF7jlLLzNF+ySSHo7fxt+p99w+suqpHrKl45sKm0jVyemLbHnNZrQUGYbJwkQDEqFPVPcAwqsrWe9pQ7MVDF0/GE49z5NRaAF6PfYEC5WGomyA4CioHzNdUSUZWUF1x5BTi9BljPgrgPF8w37rHXqElQ3zxTNYAGy5GYji7jrqj/s+56EY7iiJdNa12nwhfnHyxAxuq2CKUbWc/R2sKh0RJG7wLXp/Bo2WJM0V3yCN14TgGGHgKpxuUhEvTiqOFi5YzUAjEAX/f7EpJbyU5QTuZc9lKvdkInHZeA8AXtg8TiHCe1aEx/LxZcf9Y9egR3tcyR40G5W8wzetzHCXdVzxf929WR51ntlEYqB/ILk3Cx6I0pj5Y+Lcg55jHjwD007FZ/u2kOY/Ge9gHPihPFSNm9gZRPFljhcX9nFXgE+Ixrl2SZjxgZiU5Dngei9htRx+wbyete2q75sCdg7cjmICWTjmQqomfqhR7l/uiiYDIyHjRXVuX6KD;4:smFdN89ZQIGoypxueg26meq/u4FR2OLRqBTb9VVM8eD67MWFo1gDAoWZmyf+YPa91dmUIw3FecRPcNE094s+ItyJp6HiFMXL36U7ZfKimj6kl19AIryeccUK5yDbn8Sh1N0Aj2JAynJq0epgcqwGHY67z8YjpErUoMeFolK/Se5PBYfkmtU7dmEzXumHz48a2Xs6tERdYKo1LgGJzexjVmZbVTQsrBUKK5KS3+nZ3VFiqCe3/L0QXtw58U0kj8aXcnuACnHnWVtIKM26JHf8L3zAHaTaHpWBqXPcy8NsAAWdNE//VIP/N5JeS8Pfg7tL
X-Microsoft-Antispam-PRVS: <SN1PR15MB017554B3686A383A551509BFBE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(5024004)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:jN6kGdl8sHIKuvNhoZvvKjcPHLQMXHpU57IQLMIgz?=
 =?us-ascii?Q?kB/ExaEdcfFBU76gxnIQFE3baWpPtuVARFFDUuSwYtBKNgtukTdFR3MUAYzq?=
 =?us-ascii?Q?cB4xBRxcHudXj0THk47UpLKZWsOe/7Rspc56A/mD6cShZAK/SZzNVYwrIZB8?=
 =?us-ascii?Q?BJj64tybW8O9x/xIRuDXNoR1B/c1ApNgEiKsPHO6lPLk6o3CpELaNXMsjVV3?=
 =?us-ascii?Q?Wneg5Tyz2tHszwKjj8tZ1pyugGOcK6KdfqbZ6Zo31DIFtGiZ9dAmNpD5o0GK?=
 =?us-ascii?Q?MzluZ3fgWJmRTFmDjX3yPZWOUEevK8SK6TTu58w2xRNgQN3jvOEOWU/ecm5x?=
 =?us-ascii?Q?4PDxZiNMO3tNhlc8jz1xKEZvID6rt1G2ctPbYwZrndxCIVmz9IFgS2zpuy0j?=
 =?us-ascii?Q?fPx1JToWWiouqYWjaamTbDuNqqoFLXTSoabrG66nOGJNHZopMkUhSd8Txr+2?=
 =?us-ascii?Q?Jh+zlZTf8Xofk9H5c49SBkYS3Iw/FnNSo+n9shoQEi7+KM0qvEbg8+LRYq3Q?=
 =?us-ascii?Q?F1F5DY7CdOpqRK4gKeEOKT2htR9nYUQIG1CZ5mhOMHxsL9+T41jJu90ITSt4?=
 =?us-ascii?Q?ULEtNvrsXuWqko1WPBRS3ZXo2FfiOH/mxrG05efEFeG1CBYIYf24lY3E1pHz?=
 =?us-ascii?Q?tnUKJjssD4Wa0II4pSkOlIER2O72SaphND8MGLUyKOPfFdJd3svlpfEPE8ut?=
 =?us-ascii?Q?97Q5BHRBxlrwJ4B2SsnXbMTMjRbAYOdLzHlpHPNjcsaPZ7aTyq6iyzuZK+RF?=
 =?us-ascii?Q?GcuDLsWC8WgYRHjARnbZ3fjbMk8SBOR9EZK+BLfIF2cOjxpwBu9t9zh8Zjrq?=
 =?us-ascii?Q?uT1q0BkacI7nPTj+7No8tVdV7jENx8cXYV2H3TBHbFkPRNDGOrCL9kQlg433?=
 =?us-ascii?Q?BhhAYRBn/wrLTaDf8FvvWVEsn52SmXUXQ0scCmzxKDRSnpfNHrXPCHnXr1p7?=
 =?us-ascii?Q?74cNV/58pugmz7RFb0DzTOY7AHqzP6N8EdIhQEay7O0aBK3D5YXgbHRP47p9?=
 =?us-ascii?Q?HxOTfjrbjOOayTgS8fpkBp926oOyyQsaelrt08FjmzNddo90LGUfVpnd3P2s?=
 =?us-ascii?Q?4mZ3NE/xG+LotuZL4zmc9TRuIKFcVMeQAV9IHL/erHm9NTUBXmPxOGyUouRx?=
 =?us-ascii?Q?awXYW/qbA+UNkXxPKy9gp/HyZjpm76av34MjeaEGwa16hTwcsh6Jc3NbsLMY?=
 =?us-ascii?Q?zN355aTnDIOZSEynjX9MIfVpMQJkUwVJZT6gLuzY3s4ze8eQSpf5rsAW3/Lr?=
 =?us-ascii?Q?+u9Ag51xE95sx21F4Z1AV3e2dj5Qb2gTRZ8L9fW+XX6luGz9+A9EzWuuegnG?=
 =?us-ascii?Q?txLEpnjGJBFB/VsK7Re+eI=3D?=
X-Microsoft-Antispam-Message-Info: DrtsES7tDLlNWlVGyw5lvNX9cftdpaMd3aBxsRaU1s88U9uLr4Tj1bjCBKcTwuPjI7Mbs1tB4joFUmFqOG4w4ig2b5Br3CmqXnzXtsW7dBZTDV6RFdTTVoEH2A40IDJSDb5Fi9HE+dNR4saZK8JPrHdatWmmRVNxzu4yr1gueE+c2bPdmTzUTHRy0GtMn6gXrraPVGil5eVuCGRhp0JPFx06N3Oi4CDX1Oq/Nf1OOp7khWmuBL50u+dBQFQaA8828G+7L+445f3ayBQ4r/CtSsgZJcdY9JVGsf70o8kiq0N8g7e/R+FqxGCa2ENqfIffN7Lwamfuz0lafbfmz2kY/UMgtxCB7PcMDJaRpX2UgzY=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:RZXHQ/W4abeJk/xaiBxN4OpYmjyX07lvm7+TtYl8eXJEIp/mUyq4gEjrQOc1DujSZXCfPb1x0oPuZz+vGFhHXuAsqaahsrNG2LJsLyl0NnGu1uIt+JgS/fW1H87nMCkTrBpCsX0OY89FiarZ3xnYbOgIEFG43WCM5fBay4C/G/8gJtcyKCLVrV0hwbf2czoWRAsuESAK+zt4Ip+j3gyN7QLTfI8mSLZv3YF90cxHcMeUUzQNVAgIzHVsVmD3ipz22erwMp+hlR9qe+/hpzVsPqHBsedatWFeKNsqfj4g5lgvQAeGq03NFbXOc4jTJv8UTV9nyi/vxxYiOxuR6ZBfhqaxSciQ9Gvxh9a/ycS1Dtrl9HrTRcJ/vecYLsarfZjpJKhUI2JuqZ+/YoxQGLx9d5y5qq9rehyKHY7BCsqqqc7EH+O8jsBxdEdOrOBiVliy+wXEWOkVnY0/Q/R7hQMDEw==;5:kYYhtbbZCeO+bHumeVm1theYvtyX8DnMU0HVzj1NnUlhBrfA1lX1QocjPiY3yqzAnyzZgFZqdKpCz6fMMfV0frK6C9jJbvEeKH+T2uUM8UhqarchXa0fhm0UM991yIqDRnrbLc/Lh4EoJ9z7N4caCskerNtkvq5YgCPLNk0UBWk=;7:IOi537nAgozJlGWuHlxyGP9/MkMuYRAc+pTpssyTacrObKSeSgQNVbZUyYjjQiSCO/cTy7iENeUDCOQ8OVulZRBr1CjHo6dKrRxDdQzmup7Wf+hng4bNESi/lkhHZ2IBc9ASR+12Naz2hUNMdTpjsHO6TSeHu0KehD3RtOGcFGFVLfUFNZzHFFxgrdCLlIrGd5fNbEdwGRsunc8PI2OqRGsTdgK9QmeY8oIDPO2XbXMPaw4jc+Ms6uEf6a8jN7L5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:z8A/bR5Nhn80MlxpoqsMnN6R6dg2xzM8T146ERx5/8SxZ0w0+JIjJB8YX/r2gXL/ntxTMZDDCytWadrzfrdOZ7MZgSDyjMS+mgN34Cluv3yA766C6LsUH4gZ+2YHcTxpKI2TgLAv2g5JHlwYymfXnVd537FXnsDg1uNuQ3q+UdQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:18.8142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 913193fe-52db-4d6c-051a-08d5ee68b350
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts bpf_prog_array from an array of prog pointers
to the array of struct bpf_prog_array_item elements.

This allows to save a cgroup storage pointer for each bpf program
efficiently attached to a cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 drivers/media/rc/bpf-lirc.c | 10 +++---
 include/linux/bpf.h         | 19 ++++++++----
 kernel/bpf/cgroup.c         | 21 +++++++------
 kernel/bpf/core.c           | 76 +++++++++++++++++++++++----------------------
 4 files changed, 70 insertions(+), 56 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index fcfab6635f9c..8c26df9b96c1 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -195,14 +195,16 @@ void lirc_bpf_run(struct rc_dev *rcdev, u32 sample)
  */
 void lirc_bpf_free(struct rc_dev *rcdev)
 {
-	struct bpf_prog **progs;
+	struct bpf_prog_array_item *item;
 
 	if (!rcdev->raw->progs)
 		return;
 
-	progs = rcu_dereference(rcdev->raw->progs)->progs;
-	while (*progs)
-		bpf_prog_put(*progs++);
+	item = rcu_dereference(rcdev->raw->progs)->items;
+	while (item->prog) {
+		bpf_prog_put(item->prog);
+		item++;
+	}
 
 	bpf_prog_array_free(rcdev->raw->progs);
 }
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9d1e4727495e..16be67888c30 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -349,9 +349,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
  * The 'struct bpf_prog_array *' should only be replaced with xchg()
  * since other cpus are walking the array of pointers in parallel.
  */
+struct bpf_prog_array_item {
+	struct bpf_prog *prog;
+	struct bpf_cgroup_storage *cgroup_storage;
+};
+
 struct bpf_prog_array {
 	struct rcu_head rcu;
-	struct bpf_prog *progs[0];
+	struct bpf_prog_array_item items[0];
 };
 
 struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
@@ -372,7 +377,8 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 
 #define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null)	\
 	({						\
-		struct bpf_prog **_prog, *__prog;	\
+		struct bpf_prog_array_item *_item;	\
+		struct bpf_prog *_prog;			\
 		struct bpf_prog_array *_array;		\
 		u32 _ret = 1;				\
 		preempt_disable();			\
@@ -380,10 +386,11 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 		_array = rcu_dereference(array);	\
 		if (unlikely(check_non_null && !_array))\
 			goto _out;			\
-		_prog = _array->progs;			\
-		while ((__prog = READ_ONCE(*_prog))) {	\
-			_ret &= func(__prog, ctx);	\
-			_prog++;			\
+		_item = &_array->items[0];		\
+		while ((_prog = READ_ONCE(_item->prog))) {		\
+			bpf_cgroup_storage_set(_item->cgroup_storage);	\
+			_ret &= func(_prog, ctx);	\
+			_item++;			\
 		}					\
 _out:							\
 		rcu_read_unlock();			\
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 986ff18ef92e..ac480086effd 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -117,15 +117,18 @@ static int compute_effective_progs(struct cgroup *cgrp,
 	cnt = 0;
 	p = cgrp;
 	do {
-		if (cnt == 0 || (p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
-			list_for_each_entry(pl,
-					    &p->bpf.progs[type], node) {
-				if (!pl->prog)
-					continue;
-				progs->progs[cnt++] = pl->prog;
-			}
-		p = cgroup_parent(p);
-	} while (p);
+		if (cnt > 0 && !(p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
+			continue;
+
+		list_for_each_entry(pl, &p->bpf.progs[type], node) {
+			if (!pl->prog)
+				continue;
+
+			progs->items[cnt].prog = pl->prog;
+			progs->items[cnt].cgroup_storage = pl->storage;
+			cnt++;
+		}
+	} while ((p = cgroup_parent(p)));
 
 	rcu_assign_pointer(*array, progs);
 	return 0;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 253aa8e79c7b..9abcf25ebf9f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1542,7 +1542,8 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 {
 	if (prog_cnt)
 		return kzalloc(sizeof(struct bpf_prog_array) +
-			       sizeof(struct bpf_prog *) * (prog_cnt + 1),
+			       sizeof(struct bpf_prog_array_item) *
+			       (prog_cnt + 1),
 			       flags);
 
 	return &empty_prog_array.hdr;
@@ -1556,43 +1557,45 @@ void bpf_prog_array_free(struct bpf_prog_array __rcu *progs)
 	kfree_rcu(progs, rcu);
 }
 
-int bpf_prog_array_length(struct bpf_prog_array __rcu *progs)
+int bpf_prog_array_length(struct bpf_prog_array __rcu *array)
 {
-	struct bpf_prog **prog;
+	struct bpf_prog_array_item *item;
 	u32 cnt = 0;
 
 	rcu_read_lock();
-	prog = rcu_dereference(progs)->progs;
-	for (; *prog; prog++)
-		if (*prog != &dummy_bpf_prog.prog)
+	item = rcu_dereference(array)->items;
+	for (; item->prog; item++)
+		if (item->prog != &dummy_bpf_prog.prog)
 			cnt++;
 	rcu_read_unlock();
 	return cnt;
 }
 
-static bool bpf_prog_array_copy_core(struct bpf_prog **prog,
+
+static bool bpf_prog_array_copy_core(struct bpf_prog_array __rcu *array,
 				     u32 *prog_ids,
 				     u32 request_cnt)
 {
+	struct bpf_prog_array_item *item;
 	int i = 0;
 
-	for (; *prog; prog++) {
-		if (*prog == &dummy_bpf_prog.prog)
+	item = rcu_dereference(array)->items;
+	for (; item->prog; item++) {
+		if (item->prog == &dummy_bpf_prog.prog)
 			continue;
-		prog_ids[i] = (*prog)->aux->id;
+		prog_ids[i] = item->prog->aux->id;
 		if (++i == request_cnt) {
-			prog++;
+			item++;
 			break;
 		}
 	}
 
-	return !!(*prog);
+	return !!(item->prog);
 }
 
-int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
+int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *array,
 				__u32 __user *prog_ids, u32 cnt)
 {
-	struct bpf_prog **prog;
 	unsigned long err = 0;
 	bool nospc;
 	u32 *ids;
@@ -1611,8 +1614,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 	if (!ids)
 		return -ENOMEM;
 	rcu_read_lock();
-	prog = rcu_dereference(progs)->progs;
-	nospc = bpf_prog_array_copy_core(prog, ids, cnt);
+	nospc = bpf_prog_array_copy_core(array, ids, cnt);
 	rcu_read_unlock();
 	err = copy_to_user(prog_ids, ids, cnt * sizeof(u32));
 	kfree(ids);
@@ -1623,14 +1625,14 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 	return 0;
 }
 
-void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
+void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *array,
 				struct bpf_prog *old_prog)
 {
-	struct bpf_prog **prog = progs->progs;
+	struct bpf_prog_array_item *item = array->items;
 
-	for (; *prog; prog++)
-		if (*prog == old_prog) {
-			WRITE_ONCE(*prog, &dummy_bpf_prog.prog);
+	for (; item->prog; item++)
+		if (item->prog == old_prog) {
+			WRITE_ONCE(item->prog, &dummy_bpf_prog.prog);
 			break;
 		}
 }
@@ -1641,7 +1643,7 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 			struct bpf_prog_array **new_array)
 {
 	int new_prog_cnt, carry_prog_cnt = 0;
-	struct bpf_prog **existing_prog;
+	struct bpf_prog_array_item *existing;
 	struct bpf_prog_array *array;
 	bool found_exclude = false;
 	int new_prog_idx = 0;
@@ -1650,15 +1652,15 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 	 * the new array.
 	 */
 	if (old_array) {
-		existing_prog = old_array->progs;
-		for (; *existing_prog; existing_prog++) {
-			if (*existing_prog == exclude_prog) {
+		existing = old_array->items;
+		for (; existing->prog; existing++) {
+			if (existing->prog == exclude_prog) {
 				found_exclude = true;
 				continue;
 			}
-			if (*existing_prog != &dummy_bpf_prog.prog)
+			if (existing->prog != &dummy_bpf_prog.prog)
 				carry_prog_cnt++;
-			if (*existing_prog == include_prog)
+			if (existing->prog == include_prog)
 				return -EEXIST;
 		}
 	}
@@ -1684,15 +1686,17 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 
 	/* Fill in the new prog array */
 	if (carry_prog_cnt) {
-		existing_prog = old_array->progs;
-		for (; *existing_prog; existing_prog++)
-			if (*existing_prog != exclude_prog &&
-			    *existing_prog != &dummy_bpf_prog.prog)
-				array->progs[new_prog_idx++] = *existing_prog;
+		existing = old_array->items;
+		for (; existing->prog; existing++)
+			if (existing->prog != exclude_prog &&
+			    existing->prog != &dummy_bpf_prog.prog) {
+				array->items[new_prog_idx++].prog =
+					existing->prog;
+			}
 	}
 	if (include_prog)
-		array->progs[new_prog_idx++] = include_prog;
-	array->progs[new_prog_idx] = NULL;
+		array->items[new_prog_idx++].prog = include_prog;
+	array->items[new_prog_idx].prog = NULL;
 	*new_array = array;
 	return 0;
 }
@@ -1701,7 +1705,6 @@ int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 			     u32 *prog_ids, u32 request_cnt,
 			     u32 *prog_cnt)
 {
-	struct bpf_prog **prog;
 	u32 cnt = 0;
 
 	if (array)
@@ -1714,8 +1717,7 @@ int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 		return 0;
 
 	/* this function is called under trace/bpf_trace.c: bpf_event_mutex */
-	prog = rcu_dereference_check(array, 1)->progs;
-	return bpf_prog_array_copy_core(prog, prog_ids, request_cnt) ? -ENOSPC
+	return bpf_prog_array_copy_core(array, prog_ids, request_cnt) ? -ENOSPC
 								     : 0;
 }
 
-- 
2.14.4

