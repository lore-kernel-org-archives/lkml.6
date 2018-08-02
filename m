Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F17BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6F7208A6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iKahuqDF";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BauiBf6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6F7208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbeHBCVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:21:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51360 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730601AbeHBCVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:21:11 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w720RlmE031549;
        Wed, 1 Aug 2018 17:32:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=X7lNMoLKVx4RDXVdRzjSX4rjxqkOtVhHwV6b42mLuoY=;
 b=iKahuqDFGcU/uFTy3FA1AZq/A5eRAl8Y8X9sWKSSZ6Cs+vVdBQPvnFwkma95vt0eFyGr
 1YhLG0amm9yM6e1Sd/hVplxnp0yh68Ogn7k+0KKybKH+DimAHrIWe6lq0ot2zVCMOTr2
 WtquhSD7xoKrZdIGFaqz8kZROUq4ltDlr0c= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kknssr7sp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 17:32:32 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.17) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 17:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7lNMoLKVx4RDXVdRzjSX4rjxqkOtVhHwV6b42mLuoY=;
 b=BauiBf6ZYOFzbN6QvIaKhSC1splA1mnMzJx+ThKPhC9FpuX6Ipd0juimEqhO/bXiPZJbGkiOZeRQ4P3TWU0Rj+mBIFM/MNnbuR02WxpHhKql0VTlPKcIGLf+gx2SznM1jQJKd5pCRwnbHbxvlNxjQ/x1toGq1oMrw1O0dL9ZYr0=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:2fa7) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 00:32:24 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 3/3] mm, oom: introduce memory.oom.group
Date:   Wed, 1 Aug 2018 17:32:01 -0700
Message-ID: <20180802003201.817-4-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180802003201.817-1-guro@fb.com>
References: <20180802003201.817-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:2fa7]
X-ClientProxiedBy: MWHPR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:300:16::16) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f724835-bdfc-40d6-2de1-08d5f80f6b59
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:uDCdlHiTx7a30WV8BD2Sq/2Iqiz5PPmP/eW60cjXQ8spkF7mDjyYC1ACCnjhcqORrJd05n6EtmWVCpHyHDaQncOBkd4AjZ8m0jNZXq4Znn8uPB9vvp/7fdjCoBDEpfQT1SIA9gKb/vgW2SSIRNz9BxXuKOChgmq6mXAmwiFZrC86vz4ADDoR09y54PRozqtu3KaMTED9Iic7IWQEhGo3g2qZwuvGH+k8WYinCUQmk5CYqUNwSnt+lCk24DevVopz;25:XwkwzEEwwkUuswYVLdI09i2iOyvSV6G9rRgkSBfqPDZuVVhjNgF8DW01ryVM+Xwn7zWYAhXoqY0jcA45gt1Epg4OdkzIYZ1asAR+rIuv6uMiq4GIXDWX+Ya/X7tRKZwYLGEvsP1CqkI7Y+ylwtyCLWa1I9ZWhPAbM2xSvhywfjEJTNAqDabbemi6h1f6MJ2X0obRwnUsiaf7OcpvzYOzZ3gmtV2DlTPi/M8PHk+DjC640DChpgoAv0BgMteCuIu1K6InDD3mW9xU/TawnNyY0DFbBOeexn9q9fCOVs9UmkyzinTsfCDfukC86KnHHSJv7SnMh1j0wsnSXoXE7BE9Xg==;31:QMajNhrh8MralI06NKoVe2WUeDtTOrrP/u1QAji7B5L9rmnMSELuAxpTUefAXcUrf4hwzwvZ78quG1JqWFc7T/QMZ94wdpqhCOw80k1TgbgboQ7Df4chIJ9mGb3kGpA7YxoMAeEN3vHINETCH0YeteauuI5icUXCs6IO8JuINwZSiKMNSNkxc6sPEGcvyEpJHdafglf5ItdkN3dlDxIOGsGuXzLBpe9OOwSSEe3DCEU=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:m39oIxP5PMiDU4H2vpgTIx/jliayvazTLhoPXAbl7SOWp4SMJJ6GeR40oM8NTAYAImXFPFXsxQWf43zMkrUd1mIJWMgwWTsv32HxYgJ5WtnH6SNNqNDz57qpnz68Cv7JjVrOkzw8nVE03U7xN4R4/XiAhR4DNSuIG4mBhyvW/HJZvh/Vimx7urK5qLRut432Vv4dZNqzR6yeDt2tQkmG8k0KwG9GQPkWiCJq4YwF3kDTOzvqGATWduMvb0T7TkqID0PpzkYYCoA51DIvFRrRzCN+QTYZbBR8fzpvABP8SdASyG5Aw7bQ4OyRLrHIVpHqfNnZcyb7QErjS+olDXMgboeqWDuHbkvvAQzCCtvxZrMEz8ilDlFNfwIffosiMQem9D2/G7xsaeG09yEa34k4Kvx14WyVLzT2tYspENVa5TfO1b1CpZfWaUP8TDLsHKX9on2NVsslBMu63HwU+3p4avdpGPlJIWVI0RgxCx93mNVmTOjDntClrGArD+jhv1FF;4:rDvO81UI66IgJJ4ZwCr08nVWpMIOM6c57LwhX78LOrk4JnRrKZZ6+UoSfBDaEJRSETZYAgC9EqWY1qgtW0yh/+Y9HEsstap9T72ZP5tIxtGf1KdU9JwpuJexnu42IFxCixfX5PXFTD6IJZ7eKqoY7K01h6VcyO8gUIPovUaOHmOTEhpfLSY0ra0BuoQxdD347Naez5NZe3DVugw9isW2G4NWazBl8McKz9/PLsMCBnJRqp8qJoM1BKnHsJeDarY7fJOpKbBERHQTUcnCbKFQTDheMU565Uil5DEy0LrsH8O0+CRZEHwjD/EBJEsTVuwADtGdLSOrsOwRdW6GBMzc5YIg4n+E6tnZn/+MU1SOxuYjgtIchy15MdbyRIDI7m/ezwRJ7bxWmFlr4mnPX/FArbVmrQCJXCYKWOnHfmHE0LI=
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167FD3456D0477EFDC590B3BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(274141268393343)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(366004)(376002)(346002)(136003)(396003)(57704003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(68736007)(16586007)(50226002)(316002)(53936002)(51416003)(76176011)(6486002)(6512007)(50466002)(52396003)(5660300001)(6506007)(386003)(4326008)(16526019)(478600001)(2361001)(186003)(6916009)(1076002)(305945005)(8676002)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(97736004)(8936002)(48376002)(446003)(2906002)(53416004)(86362001)(46003)(47776003)(69596002)(14444005)(106356001)(81156014)(81166006)(2616005)(105586002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:1d/ta/hHb+XFcF4BleTYUyymda5n3U8LSDGEZUPwv?=
 =?us-ascii?Q?kKvTDCpxZGo3gBVHeOqzQQNcUu8OmmJXRIeP37ysxEmq+g9/FdCf+0AMAZND?=
 =?us-ascii?Q?XtMSQx7D1ybfllchNXq8ZKSHWH/MLq6yYDkbLTkUsNyWTq39wKyJC5q6S8yl?=
 =?us-ascii?Q?pQXuEA2TUUye6r3C1NGCXDlFXQxltsnuSoOmb6pVc9+uUyixCAqNQQmRgNNd?=
 =?us-ascii?Q?9jXU78YCEUSKjsTJ1YDG+QNUXp52Bl3wEVfdgg1/DQYAxJrofSCNpTgzeCRZ?=
 =?us-ascii?Q?TjBchzja5BWvmhHVHUZT+VywYvGsNcysr2YXcdC3f3SUK2ByrURMboFBAyLS?=
 =?us-ascii?Q?MGQwMx80GxzdP08zZFzjprQB9Pmbpt4pLy9Ok6BOBWCRSOBgPUsyr6i3C18Z?=
 =?us-ascii?Q?z6hWQCiWwZLZXibiKpeh29d+34JeH0GDMg349iMSNR4hR4jUMEzL+ZzSfDnL?=
 =?us-ascii?Q?ZIgj09KDOqBxl01NbAY4xf+MZsmsxgn0br37DfoTJxIAkaLPr2jy+EHQso3U?=
 =?us-ascii?Q?/8R3s0f9jdCmTFS/75jsE3BgQu1dOblOVDGMlIgsw6xxZ8bAYnZZVuvHPRhb?=
 =?us-ascii?Q?BMWcbxwanLD05sdeC8t9FURYtYgi3H+mMKNqE+ABqhYqmKJebP4hSS4gNIdW?=
 =?us-ascii?Q?aSJgv6NASqCHtM9rJB1VZM9egwwbcls+fNOs1xVFaLmHbZw0ONhUQZEjqVI5?=
 =?us-ascii?Q?/FoBpQBSKsceX4Z61Z5nf8FD+8I2LC4KrkbOM/Irgsmi++u92dbsdTJigRK7?=
 =?us-ascii?Q?r2hCwMz7rvLStdJoZwdcoQqlzqe8ZrkFbpD386yG9FyOCib1Isj4mvNv+xLm?=
 =?us-ascii?Q?i4xCJHkox2WoMTAiGk7bk+dSxJnooVO6hgivx1YLNyA00+Ykiy9ORRHtur6B?=
 =?us-ascii?Q?HXQHM0fvchy4kkxCY9AuVHT2/hTKrJH/d76kTUKvs1qUTyD59FquCkgVm8Ua?=
 =?us-ascii?Q?9P4iP6/BAkJaiTwNzebcTC0+zCWDjoXUeYWDqtICO3f1nU8SX9kUABmfIm/p?=
 =?us-ascii?Q?xVhS9IL3pRq6GbbnNnrVpZTHDzDrq7tWvOIDkBuZRJCRIlRjvKR0FpC11F+x?=
 =?us-ascii?Q?PYjflMm1IYlhGZE4qNjDt45UC8JWWdQkhEthAY65IM3cwCf0/GaJztBgHABY?=
 =?us-ascii?Q?GE3ybtGEz5XJk2/3PR1Ff8FS6+yrpPpC5oZOCZ2HmFQg434tz3JiL0VyOrwO?=
 =?us-ascii?Q?YuDjvNFMkLWkPPUm/L0Fxrrv/FaQx8QxpHyR8JVOZDBK+oRP/34C76Iie/zv?=
 =?us-ascii?Q?6pQk3yDVzArS1N7U5FdZTmyiLkhq+w2+FU+juuAMYE4DF8PBVBvQrwpeDfjh?=
 =?us-ascii?Q?LHZBxiDcDXBifn+1xaydtx5cIh6FEYZBvjWePvj8ac/lp0ANTMX7OZu9zcXT?=
 =?us-ascii?Q?AkbR4oDcLzNrAYgYbPwVMcy6jzhzV4Gh/q5dw03lLkkgQ2sF8uWNhlKdfjas?=
 =?us-ascii?Q?07jgNiW/A=3D=3D?=
X-Microsoft-Antispam-Message-Info: dEbCs7Anh9yHayRJm6I2s/Xmp9fGw+KlJIW+yV/apr+IOy/ecNjovW2prQYeud3QA3pyVUCdtBI8YC3wPEbbp9XzI1TmEY/klkIOg1uZkhPvG+XrLF0gfm+UcZfmRwSnTW66pmJ7Nte0dd5MX1JPTEL8O7B4pd7yrTOpohtCEl6deCtkzD+XVzNhkWs1lvcfJBp/MN1PI1z4W9BYL+Xq1Hje5HmYYjUs+3jvR/FeqSTtdHsgrmbykTHcVBYR7oo3mzMrVV+GUr7OEvEmsenyxeqZeCB+TgFU7F4yc5qCARXJp7yZJhyj/sl68fAbeUVx5ah63YPssdvoU6+dLkUgXT7YbkHt6+16Xs4SDjzfawM=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:1uDM61rxNfsgo7U1vH0dIYOD4BO9fLHMk3+3gfagZdHd89mT1FjkZB0nmRMZvucqnY59UtDss16uDWSnBeTbW1sr3Lzfk3dEiaqtqZBGrjS2uDBkJ5J/0VXVlGtMiST+hTgJXwVHDawdZCGBRog8pT1KtQu4wxj8ia1SptccYKyZeBtAZxjk3U7DmX5FXzrDEFQXY07zhF/MRgh8Af6LKS8bP+1h288TXu/o6PmDYwjUKjw9YXy9H8kXvkrPx9r+Q9G8vBuuPkXr5nLC3edq+LQDi2v4G4nczyB6KV9CDwk4yUuR9KRqIyId5MVh9M1QNPopUyRZJS7zuZjDchpSM9q/cZ68TQfyZglrvMWyNJO3tR6LxHPMmNgrv5GjZr/UeDAylHLDuP6idbQ/XEk9OGQC9hpJyWJhTkAJIJVXlrr49xnER3ywlZLMxRl9ReCLFxLm9iwg5ifmuv3pzmBVeQ==;5:GUH+AQ6cjN9iNL3RMmXro9VmtSRVKqtr1F6uPMWx2U8BVMxjBPLzAL2SSbo8uLwB9HAriTLO6mVpnYtotqh8ard91msXlFRZVpfk4b+QI9jmNOSt5lwy+2qlEZ2sNplOjpzKXqFOhG/YU4A/rWS/U4ZyrySbgkLTnfKPJubFKWQ=;7:a/efSQvu/hkH8VHqVVFlvM+TGwgmMRa04oVUmcYwDoi1a1sNaVNQnf1yPWGjWyrc25E/Ee1K3OQoZeDT8Aj2AuSKaLC6gMOrRlKMRGKah4s9ncq4afLaNah4xbHTTdO/QtPq/fXgX7kbYDnWp3KH25iiNLsJPbAPv0hf9WCZk8oqOI3cEXRZoaIpBTbxOZzUXZExO8hRydq4Br2lW/Fb3feTLy5HoxgRJJX1F6BhA8nyaGOAcN/Tep2xADMCqURw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:vBL4Kb/Cv91GubWUSu5bXVrZyWtMPZRn9wLzbjLPAAEU0OxWVrZmFOU6sG6sF6PfyQxHhoA5WyR00kznHDB4iwK3gpIML7g3V5/fC6n4q1AcVMBCKM/BW3AISXPDU9fjxdFIDrkQzGiRZrmXhQoldrWH6gU6FCGAlCTSMQNt+ZM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 00:32:24.3249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f724835-bdfc-40d6-2de1-08d5f80f6b59
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some workloads an intervention from the OOM killer
can be painful. Killing a random task can bring
the workload into an inconsistent state.

Historically, there are two common solutions for this
problem:
1) enabling panic_on_oom,
2) using a userspace daemon to monitor OOMs and kill
   all outstanding processes.

Both approaches have their downsides:
rebooting on each OOM is an obvious waste of capacity,
and handling all in userspace is tricky and requires
a userspace agent, which will monitor all cgroups
for OOMs.

In most cases an in-kernel after-OOM cleaning-up
mechanism can eliminate the necessity of enabling
panic_on_oom. Also, it can simplify the cgroup
management for userspace applications.

This commit introduces a new knob for cgroup v2 memory
controller: memory.oom.group. The knob determines
whether the cgroup should be treated as an indivisible
workload by the OOM killer. If set, all tasks belonging
to the cgroup or to its descendants (if the memory cgroup
is not a leaf cgroup) are killed together or not at all.

To determine which cgroup has to be killed, we do
traverse the cgroup hierarchy from the victim task's
cgroup up to the OOMing cgroup (or root) and looking
for the highest-level cgroup with memory.oom.group set.

Tasks with the OOM protection (oom_score_adj set to -1000)
are treated as an exception and are never killed.

This patch doesn't change the OOM victim selection algorithm.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Tejun Heo <tj@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst | 18 +++++++
 include/linux/memcontrol.h              | 18 +++++++
 mm/memcontrol.c                         | 93 +++++++++++++++++++++++++++++++++
 mm/oom_kill.c                           | 30 +++++++++++
 4 files changed, 159 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8a2c52d5c53b..7b4364962fbb 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1069,6 +1069,24 @@ PAGE_SIZE multiple when read back.
 	high limit is used and monitored properly, this limit's
 	utility is limited to providing the final safety net.
 
+  memory.oom.group
+	A read-write single value file which exists on non-root
+	cgroups.  The default value is "0".
+
+	Determines whether the cgroup should be treated as
+	an indivisible workload by the OOM killer. If set,
+	all tasks belonging to the cgroup or to its descendants
+	(if the memory cgroup is not a leaf cgroup) are killed
+	together or not at all. This can be used to avoid
+	partial kills to guarantee workload integrity.
+
+	Tasks with the OOM protection (oom_score_adj set to -1000)
+	are treated as an exception and are never killed.
+
+	If the OOM killer is invoked in a cgroup, it's not going
+	to kill any tasks outside of this cgroup, regardless
+	memory.oom.group values of ancestor cgroups.
+
   memory.events
 	A read-only flat-keyed file which exists on non-root cgroups.
 	The following entries are defined.  Unless specified
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e53e00cdbe3f..5b26ab460565 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -213,6 +213,11 @@ struct mem_cgroup {
 	 */
 	bool use_hierarchy;
 
+	/*
+	 * Should the OOM killer kill all belonging tasks, had it kill one?
+	 */
+	bool oom_group;
+
 	/* protected by memcg_oom_lock */
 	bool		oom_lock;
 	int		under_oom;
@@ -517,6 +522,9 @@ static inline bool task_in_memcg_oom(struct task_struct *p)
 }
 
 bool mem_cgroup_oom_synchronize(bool wait);
+struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
+					    struct mem_cgroup *oom_domain);
+void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 
 #ifdef CONFIG_MEMCG_SWAP
 extern int do_swap_account;
@@ -951,6 +959,16 @@ static inline bool mem_cgroup_oom_synchronize(bool wait)
 	return false;
 }
 
+static inline struct mem_cgroup *mem_cgroup_get_oom_group(
+	struct task_struct *victim, struct mem_cgroup *oom_domain)
+{
+	return NULL;
+}
+
+static inline void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
+{
+}
+
 static inline unsigned long memcg_page_state(struct mem_cgroup *memcg,
 					     int idx)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c0280b3143e..23045398ad21 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1577,6 +1577,62 @@ bool mem_cgroup_oom_synchronize(bool handle)
 	return true;
 }
 
+/**
+ * mem_cgroup_get_oom_group - get a memory cgroup to clean up after OOM
+ * @victim: task to be killed by the OOM killer
+ * @oom_domain: memcg in case of memcg OOM, NULL in case of system-wide OOM
+ *
+ * Returns a pointer to a memory cgroup, which has to be cleaned up
+ * by killing all belonging OOM-killable tasks.
+ *
+ * Caller has to call mem_cgroup_put() on the returned non-NULL memcg.
+ */
+struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
+					    struct mem_cgroup *oom_domain)
+{
+	struct mem_cgroup *oom_group = NULL;
+	struct mem_cgroup *memcg;
+
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return NULL;
+
+	if (!oom_domain)
+		oom_domain = root_mem_cgroup;
+
+	rcu_read_lock();
+
+	memcg = mem_cgroup_from_task(victim);
+	if (memcg == root_mem_cgroup)
+		goto out;
+
+	/*
+	 * Traverse the memory cgroup hierarchy from the victim task's
+	 * cgroup up to the OOMing cgroup (or root) to find the
+	 * highest-level memory cgroup with oom.group set.
+	 */
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		if (memcg->oom_group)
+			oom_group = memcg;
+
+		if (memcg == oom_domain)
+			break;
+	}
+
+	if (oom_group)
+		css_get(&oom_group->css);
+out:
+	rcu_read_unlock();
+
+	return oom_group;
+}
+
+void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
+{
+	pr_info("Tasks in ");
+	pr_cont_cgroup_path(memcg->css.cgroup);
+	pr_cont(" are going to be killed due to memory.oom.group set\n");
+}
+
 /**
  * lock_page_memcg - lock a page->mem_cgroup binding
  * @page: the page
@@ -5328,6 +5384,37 @@ static int memory_stat_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int memory_oom_group_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
+
+	seq_printf(m, "%d\n", memcg->oom_group);
+
+	return 0;
+}
+
+static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
+				      char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int ret, oom_group;
+
+	buf = strstrip(buf);
+	if (!buf)
+		return -EINVAL;
+
+	ret = kstrtoint(buf, 0, &oom_group);
+	if (ret)
+		return ret;
+
+	if (oom_group != 0 && oom_group != 1)
+		return -EINVAL;
+
+	memcg->oom_group = oom_group;
+
+	return nbytes;
+}
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -5369,6 +5456,12 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = memory_stat_show,
 	},
+	{
+		.name = "oom.group",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_oom_group_show,
+		.write = memory_oom_group_write,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8bded6b3205b..f10eb301f6bf 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -914,6 +914,19 @@ static void __oom_kill_process(struct task_struct *victim)
 }
 #undef K
 
+/*
+ * Kill provided task unless it's secured by setting
+ * oom_score_adj to OOM_SCORE_ADJ_MIN.
+ */
+static int oom_kill_memcg_member(struct task_struct *task, void *unused)
+{
+	if (task->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
+		get_task_struct(task);
+		__oom_kill_process(task);
+	}
+	return 0;
+}
+
 static void oom_kill_process(struct oom_control *oc, const char *message)
 {
 	struct task_struct *p = oc->chosen;
@@ -921,6 +934,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	struct task_struct *victim = p;
 	struct task_struct *child;
 	struct task_struct *t;
+	struct mem_cgroup *oom_group;
 	unsigned int victim_points = 0;
 	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
 					      DEFAULT_RATELIMIT_BURST);
@@ -974,7 +988,23 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	}
 	read_unlock(&tasklist_lock);
 
+	/*
+	 * Do we need to kill the entire memory cgroup?
+	 * Or even one of the ancestor memory cgroups?
+	 * Check this out before killing the victim task.
+	 */
+	oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
+
 	__oom_kill_process(victim);
+
+	/*
+	 * If necessary, kill all tasks in the selected memory cgroup.
+	 */
+	if (oom_group) {
+		mem_cgroup_print_oom_group(oom_group);
+		mem_cgroup_scan_tasks(oom_group, oom_kill_memcg_member, NULL);
+		mem_cgroup_put(oom_group);
+	}
 }
 
 /*
-- 
2.14.4

