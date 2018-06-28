Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD70C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71433276E5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KcbiM0AL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GpUCb+qC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71433276E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030341AbeF1QvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:51:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56920 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935746AbeF1Qs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:26 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGka5S013501;
        Thu, 28 Jun 2018 09:48:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=nEUoZRJfdIEN94t2lsS0TnlTolZ1eb7i4yJqbLfohws=;
 b=KcbiM0ALGCJClEm3hnlUe+IHRa4JWTzFoVKe9JCG53Zq4yZuJTDaPdmp4bs8Q4xhMqAL
 1Sa9NE1KwDR8INDgghcoQLLLaYMc7eCe0iKPcAoyrTj/bvdTbqxbHqMmFcbSRlZz2dCT
 jTndv92YaGV1ega+ID+dYyYHSLxSLyGU9NE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2jw2u0074v-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:05 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEUoZRJfdIEN94t2lsS0TnlTolZ1eb7i4yJqbLfohws=;
 b=GpUCb+qCh9mG1zq82ODQQhSMkitMTtx+FgJ9YWjaSZF5uy9JyI6q8kLvNdwGnBhW9PMGAUQqNXKzQbNSOnbIyLT0va/GwJqhkZqiinskF4TZ/jFESyFCHvk/smBpH/xfjDyNPwFvw6exMMg3+6gHBXDDLES6hz/WyYJt47bdkCo=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:47:57 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 03/14] bpf: pass a pointer to a cgroup storage using pcpu variable
Date:   Thu, 28 Jun 2018 09:47:08 -0700
Message-ID: <20180628164719.28215-4-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a2d6803-1552-4ba9-1539-08d5dd16e792
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:IFN2VQKloua4fcHYxqeneJAVKi1wXBwE3MTwSgTTIDDgrBZ7BczQW66hsiQ+WKRZM3Zf4iBJlYCPqLkRXsrFpSuwQJFh0ROCFYCz7taydvY6pRqczbLO8YdchCRQvlOSu/YDbhwsSshf00wO3N/PSD9ORlj88W6BhyH1lcX+M+N6Jze+mTHwrg8RzfTcec8qfNMBj3iheLEpXLvsRwq66Xv/+zHVsHrMloQAV8VB8S7YL3gGRvTmAmbIOHPldCd6;25:X/eqYdDooH43299w3LIbDAQqQboduZu+u9gsSkT3qRVi8ocTAgcdc3cxwzTeDQ5N2NxIZkbN6oCgrT5mgNyeoAjlKDq3SFWPj36De0mzSLHP1vDHgNs23dktGcVRz+p3NM8dAUVMOtnaciUxqcv0C9igJQEQ12wiavQ2+XKpb3axCqsTSL9070ECa+PeXwpmB+CqeIX3qcRxg+vNq8L7EbGoAiGIovSswA14bzHHCLGaGOJ1lYXufngV1R72e9xmJ0z8M99wQSXvx8UcMKBRUD6bHclGpGPMNyCmfdEFZe+CpX0sf0AVodLBL+Wq6g8Ts3puyvRopF+m3v9ouUAtyg==;31:Kee8bmyKiEVWtXjYMMKFHv8asriFyp9ViZk1AVa79CWdK79H+dpZda7wQ10eSKTvPiN9abACO9Q/1Fx9qv8IHIruuREg9WnELI5lKLa7r4oAEUHntK//qBDlOeIoopTKYb8EURq01l4qmi6DxZ6olnCnknfR4kOpFnfpBaCIjioJZC9V5NonyCFo8Z5wDnEdDHkI5bddCOP32OlhKPuLkVQmxMQGTDMGKEk5J0q24EU=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:dVOzAaJK4R9xUMx9DTvtc7zpgaAo+G39/WUTWiAy1o1eLBr31mxVr0sGl8iyLzI7pYDvvm7DK5xNqvvYcAEufB+pPmo9S2jkzBiGPXRqK0E1vqFzvFVi1B3bq979+4IztSxmRuMIOAK4DdhaxIofVNyN8AIc0n94T+5PA8Bib/33ycG9IpD5jUcPD6ro93ahMxr5XOSnNBy3jWV3/1luJX9YhKVOU2utuZa29XNVVQUnEMN/acsuJvSjec7FVQj5O8/qzb6xeGPlHJUxspYpzlehZJcoYNz0kDX6OKi1Hm55L9BW6oRv9WkcpvYmgUw//WU6D2TwsxjnxpPuf07Vz1mFXc5thXujDabDPLrnBscLv93I05xZ0MtXIfw+6k2BRk6fM1TsAQug2LW/y/xedlfzE4J5Zdw+G9iL8ovh1CpNf2V3e6gPPzvo5M5VY6Olm4ftx11+nJqJXlrUpWsVxm52SjeJQ9rnMfacIzkx1EAQVJ7jaLwDmwGGKKeVGEgG;4:YItO87/JTVMd8YpVc89DIvu9GEd/vX77InxvAUpOQLHb6ACE2yT0y/5wUDiNfwqqRFaypZfABPigDh7sfisyNrUNRGCH7cXMRkYPDyMqocbtJELJCUN4+45QnukMZcvN2RIwzhnomfLbSccIZbY6axbsW6ssZSzZ5i7sbRB/eoF3BE2+N/xlaIsXsokap+neg+sXse6dktCnZ6CDfJ/OmbOMfxo5fa4S6u5sJFOb+6jgZz/oc5LqySSwYyd2Wok3pfzRcNxqTXNThk+qPOiAu34x+ldjxkDpbNFYDnrlxoeiaKUjLUZlawmzo49QnmgU
X-Microsoft-Antispam-PRVS: <DM3PR15MB1081D540CAEFE290DE0A5C57BE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(6666003)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(575784001)(5024004)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:RMYmbsxav3fYuVGNDPpBvuCqoRBga90bldOLaqW0h?=
 =?us-ascii?Q?7G5sJFxvhZw/1QvVJ3yksJBgloYrJsLUb++CCrUJyGRB3XfbtwCQaC+Y6wih?=
 =?us-ascii?Q?zEee1NcOEMlilHCEjcU6f9pfAJDblHXZAUnZDDXFRgctJzZBEp0CoBrQTmVl?=
 =?us-ascii?Q?1NJXOEmoT8EBVropvh3o2qEXHQUBShlonw0o4lxEvHwmI5kCKQz8t7vM1hyr?=
 =?us-ascii?Q?VFOX1fRYTCH0unBJIAry3TSP4sv5vzpGfdmBmFY5J2SOKDrU8q0XZFcU+Psu?=
 =?us-ascii?Q?kNcWV6cF52Bqi1nL88BpW+zs6TeURGG2D1AdjM0R1YsCJhK+h5USEhA1ojgH?=
 =?us-ascii?Q?hmzTNCOrkUEckOMOE2tM3fX0jKo1Ax3XwB+Y0fvqfQXS+Etn96ymyMCNt/ZG?=
 =?us-ascii?Q?cc8c1kFCDvOHy7wlEiMkoUFS+LLmkz7ADPkUOwQzYaDCf4XtnIYNkPHefd1X?=
 =?us-ascii?Q?Vn+fdrd6Ygv03apH6jaWWsD1p2iDrZblJ2WowN7kZBy+e1Dwry1uPIL+WdjJ?=
 =?us-ascii?Q?aHspin8Ugu2DRFC8zXjnHgcZSfwdLaFLu9jRYmrAdTLHFudcDsn/v9fqpdjt?=
 =?us-ascii?Q?L9635IOHQ2m8/p2Di8dmbvJM+FNBs4RW7+evARurrEO4JNIMCEj/j4BVBTmh?=
 =?us-ascii?Q?gvaljrpt2gbKrK2fE6i2Z/dwpD3uLtdVZsyWnRk/bh7AOKiYWCr3pJIhnkyb?=
 =?us-ascii?Q?t9E1xkEGD3uKS9dgoa0QgVgeElaKNrdRDXNJ4hvsYP4M9yrkT2VgIEbwGb7x?=
 =?us-ascii?Q?WEwcUuJ0fD5ePvTkceCs+4XEekpQeOgryFrdN83I9bmcWXAC2BuxfCs9b8Xa?=
 =?us-ascii?Q?qAUhkaZZh6XLVOrdXZTN4DtZXyCVHAg/ayC8TvLm8uWDvfCjanp3BQBLEjRB?=
 =?us-ascii?Q?KsBV+oBcUZIGCZUOC6W2rfl9wGrqDFxZ+0WdhXBxVV5ABlLzHzuTfrs/3n9E?=
 =?us-ascii?Q?G4dG1qpFEF5LuXi+lryLduhTdl4dqi1wVZavnxMFRl0v0iyhp/Z6Enr2prvd?=
 =?us-ascii?Q?L7d6tBKUZ7oCXVTXpawlo8MqlOgwO7Hiwnl1eT9yfz1gg26t5VyYLAd3lZSP?=
 =?us-ascii?Q?7DVNrqt8/AM9VpCCP7qtbmslizC492Wqs5FzLiyWUXMYXvYnqlT5j5L3CkoR?=
 =?us-ascii?Q?JpNg3NeD+I60PypiVxIEdzgcRFQWAWjMJHZhC1jRH7JkSJYovjyiuTowyzXX?=
 =?us-ascii?Q?t9ze7ZzIy943LqQxVnMJkSVs6TnZdx10zEJ2p7yq3MH37dcXpmTvdseeJzP0?=
 =?us-ascii?Q?lQHOOjAnewU67ma5d8gKH0pIs0d535sGSqt/zvniUYfvrPHSxQJ1Hx78drFQ?=
 =?us-ascii?Q?oNEKbVPNcH4esFnZ/wewQ9xwN7OaFJ/LZmLxKgIH0Y6?=
X-Microsoft-Antispam-Message-Info: cq89GfEwZ0XNKvozM4T7shrMMzPqu9FyHm72CqGmfcR3c97A+IQl9pkPeDE1STnJSXrhbxqjVRd18ZIvn9edoCAZBofnUwPuur+f9PcfTRaol+AQnF1axUaMPmTvFHpup5YPnYnML+rEFIjE4zAEeW1jPBLR6gS+Mo9TkVkOrUXSG4hPYUMIC2GwJDViX7m0Zfoq5BpMaLrOmf5hBsSSb6PI87oMThCz/L7E89riJ6xmfFxSKYulmzLwnjKHjPjpLt7CRJ+G9e8m+wbP5CeYxLtGdyFuuc6WiDVu47hb/FeaEXEhCFO1IJhn9B2ITncuzsV0QQwFvjqf+5Of7By+LQhNzwLsk0/UTtw4KXfZ5tU=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:H/FY6H+9Vi9VEfFFfnbzcbiDog43QwJyh9vHuLXo+m0otlQzEv/sWgtFS+px8h7FlqwcLrWelZNK/yxrjhdT52tbRvWBaq6D4iziSXiPYKS5W0iJIAPuMfNFezTYh2d/AfrPuiPUOyJAC3xjvoXy4ydBc9lsSR1dR0JE+WO6YFH49VT/mP3oBq3r3x8X+Enk9UuRtXJmQRWMpCYGultL0CZixAktgGm8J7YFo0cZwQbqXoFohDJIwj6pa6NYaDmT/rdjjmwyAxD+OacgrKyBlE/BUxzQOd1JC5Btxpql5RFcjyedrE7TNk/ce9FAp/4xV7yWGtCA/PsGPKyR08lIQMpzufcpOL4eBk8pWi+eIK/BEKhtdYKWMwU2YRwUoGv/ItQT+6pkASq57wfHjdknxsIL+cRcfDL6dLP6mkCFdtV+PBbKlTWqaXRoHZaFXuypgu6sHiHxRNYFsPpV3W2Ssg==;5:3iO2VV/v502vEXpb7aFFW6IztyZWg5TGcdWl2M26cxRDML2q5KDHyjYXwjHYN4U86HqIaPk2zg3HWUKmc9vSYoNWZ8fLuikqs28Aj2IGURfxgRztuaAvtZcLErpz5Q3fbgh5maRT0bP/gGS01XizmdJmf3+4t60kn/Ul7UrpVEE=;24:J/vd4efSJsqn6aNZp/Qh6pSVwm3Fy7F1AVOYs62tv7bzMafy9w+7UjxsfJdaJXisa62YVh98rM3IbnR/f5IDOgV7LD0qClc4OCLy0Tim2aI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:HIgZ/ekR152/UsKqtKiex4wWG98Y9g48JO8z6LsbVgygPf1UtS0/09IDct1LQwlUFQSa5JoYxrv+m1c6Lfr+bUJCVq4iJnxH5d56NcWv+qBZapp4SYIwKrcnH3QVCqCxNI8UbSPI3zPEH6JU/UTCS+2GLYYainyADhkcjRVgmUU5kg98KXV9RIrvza2+RdYYGfPAQP77rUNgdAmwnPCs8E77rdAYa2w6IreM01icNl2RJe/czWDmKR/dsCVe8NO2;20:mZ1V2zP08g/gXQ9CYP1xEiP52dpr7Dmqjkfo8fBVJ7q1YW7SmzXgpAjv5jvo8UxTtcPQBQ+oOxrtfFXFjWWdVYzZmv0MMCxKYs1MgdpZijU3MO1NGKcWP8wOj2svSWzsdWcewuKEY9S+Dsdg8Uqd7lh1xpom9iq5qmetYt28Ogo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:47:57.9735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2d6803-1552-4ba9-1539-08d5dd16e792
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

This commit introduces the bpf_cgroup_storage_set() helper,
which will be used to pass a pointer to a cgroup storage
to the bpf helper.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h | 14 ++++++++++++++
 kernel/bpf/local_storage.c |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index b4e2e42c1d2a..128fb0e39b4d 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -20,6 +20,8 @@ struct bpf_cgroup_storage;
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
+DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+
 struct bpf_cgroup_storage_map;
 
 struct bpf_storage_buffer {
@@ -96,6 +98,17 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage)
+{
+	struct bpf_storage_buffer *buf;
+
+	if (!storage)
+		return;
+
+	buf = rcu_dereference(storage->buf);
+	this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
+}
+
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
@@ -223,6 +236,7 @@ struct cgroup_bpf {};
 static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 static inline int cgroup_bpf_inherit(struct cgroup *cgrp) { return 0; }
 
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
 					    struct bpf_map *map) { return 0; }
 static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 940889eda2c7..38810a712971 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -7,6 +7,8 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 
+DEFINE_PER_CPU(void*, bpf_cgroup_storage);
+
 #ifdef CONFIG_CGROUP_BPF
 
 struct bpf_cgroup_storage_map {
-- 
2.14.4

