Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC99C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5360E208A6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lQlIHJQI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="G03L2VbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5360E208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbeHBCVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:21:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50178 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732322AbeHBCVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:21:11 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w720WQtq007291;
        Wed, 1 Aug 2018 17:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=arGdBWfo+OeE2DLlb78edCGjzCW3AhGuBJnoonsOX2A=;
 b=lQlIHJQIgAFNDS1qsWiwMUB9Q0lH3+7767qIRXmCKP7lbGrrdDSmGH2n12DL0GUXgo9M
 1NjV/zqPRvcrXmMercBUBZUXYdTfq5aFwfjhImjnnuPC3map8BOsYLLY0NcQ+MtWgyPv
 jV4TkNp7cfaSSQHjOxA0KVB8vhD/7VK0owI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2kkfcvhh45-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 17:32:29 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 20:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arGdBWfo+OeE2DLlb78edCGjzCW3AhGuBJnoonsOX2A=;
 b=G03L2VbH/6Wa0LhtvWt5L2W9cxLz8LQXLUxSDrk81fX2f75cAEpfvjHynGXqFok/Niogse4OrUkTTLYr3lWKdXnHtMrvHZ8UC05ldLnk5ts46Krypufusg/7tD2XBGgZh05zqCcmgC8jZL0DO4L8RztsUlrXQfQyHTcDtaml0D0=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:2fa7) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 00:32:19 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 1/3] mm: introduce mem_cgroup_put() helper
Date:   Wed, 1 Aug 2018 17:31:59 -0700
Message-ID: <20180802003201.817-2-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: cbd51d0a-ebf6-4290-cdec-08d5f80f689d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:NMiuizapGXlDHbhmLDZdNG86ba6h95VQ/6JDejBBGb4KxRFGic75E7jJW7r5VZBnXqLLCk2sC74H79XCuP3v69xG/DXIrakRg4ULlEMNgZO54cgXMSX05M+zWHFfuUUmH/5ngJHwvPprFtwHQxwjZUI1ftBXZqfyMev/53Pptoy1gq+4h5huEieIGnBqgd94EETdIdXF7vYScB4mpvvkEfn7aP0JQwh18nXZs+vk+NPr8J1/phedhgGG6PjTDatn;25:OpUe2DwTS3YwgYhg9wyEX88UYIhsbDEUpWwdd66Ml9vvu/+ZnuWRxYvsHkX7LBUK6dbYidKnI5OziW2R4cTdCjSMIoVUiWlHp3iZOBJ4oPPRxk3ds6423G5rW6p/QCAeDP15wP26IAuLuE9DXt4UsPjvjLR21IABUDkb75TXD19U/UTrUNGWAL5ojNYSCjGK/R/+Bi1dlBiKf82frIf1reJ0x1qz808n74pHzw3yMiiQFqukI4OyEHT56Euqz15UPJiCkkMdip9A1sFO+YueLs/YF8hIEQjbGsmQPwtdKfYJIlIN4Jk76OXuCU4WbLNBF9x1Kwu0ETBtduGtFKs21g==;31:6H0xx1Px985gQ8S7RJuX57/IQX/0Vnwl7K5FfrlEe6xTNWJM0ViaVXnLCKbMERI1VFi2L9bRSx5SrqFTyuJZfYcqRPiPgfnpyakwC1h3j+WWaZvddWk+AZpXV3k8KEYD2088JxD5A2PwQ/hv3SVVEdhzlyUsHFM4uG7AqIQ2W8afeLlat3K82nKqY093iR8MxIHPpol2Fdn8/7eP/KEwN4pu4AdMRKNValy8M6RL+K4=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:fhDT+8tnGacn0QhMFv7H5tBMjmdX1++mMBevidXghc2a0/yg47LV8gBDsXF8pqz5tssTChPoQSLPLOCxTtqWBvl3yfNOMFHZLa7EHOrUGyotXu3fCjnhGHCkeqGjPJOiP1TNHwVgQEInQfOPwzPfb4Y4+cywpwKiPgqR3c8ScdaY0PcNQKIH2QGutZeXcILMpVdkVFYjBaZfzTahkLxJNYVIwPruMxJKodSpGc7vTjvdV+yGcf0zKTHZetQcBVYNa11BUDKGhJwg1QBI46gdeZEjt79n2nWzcyRq36Qm03H7ErjSnfDJ1HNvY1cgD8tcDLqrWQsOPSXr+jkqa0nTCKVaZhz2Rev1X1k4xune7XqYA+39nR+M21f9dS20NIyQDNfg0xVbcfXeAgcJYmOU3jfcSDGkT2bDhR1nJhdDCljkhj1RaBxYbic8DJYWC3vti2zUb7xoAn4CGMSN7OPjhcypxYKaJwcbUF6SDn6aAFuGZplaGX+h+6xtFrQymtpd;4:9RGpASvPzbKYiiX22zEYu5KAEQdkSn7PnDehWS5vDsO86+rcTYoqMRpIS4r7xaHnfY4uZQ4oJoAqRBdGwXJwZRqiOtzB/AAKL0ebYuDeoYGEk+ApC8VDELlV70pFA4Sq+xvYYUlDN05EPL5bgttGsi+MDEAsKMmaSPggG9ZhHO9pqhqK1p2RZS7pdnYrYk7DNrx6YkBG5vJqxNRvjHdcOvqanGo/g83dIKuse6EgvRzFuNVBGNVKB+WxJZuRlx8xzOBgVKWaX3t/Lq5a54yyhclYSnDVi54Iljm9PVIdiWcQ61R+WVxM5lQ2Jb953d5ktM6/8iM04b8CkDjKvlSgXIsq6f2b2y4dtOb+JhJC7eSXi8StjhBYR4veJxa5hbWjDy37BO4mq2lLawUEYngu5Ao4AM1ECN1Vvbq0p9Lcd6s=
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167E44A43C5A80A681EF5C9BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(42068640409301)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(68736007)(16586007)(50226002)(316002)(6306002)(53936002)(51416003)(76176011)(6486002)(6512007)(50466002)(52396003)(966005)(5660300001)(6506007)(386003)(4326008)(16526019)(478600001)(2361001)(186003)(6916009)(1076002)(305945005)(8676002)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(97736004)(8936002)(48376002)(446003)(2906002)(53416004)(86362001)(46003)(47776003)(69596002)(106356001)(81156014)(81166006)(2616005)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:MTj7RsKvi4oilZN69o4ONv4jVKjLmTC1NSF0Ghoez?=
 =?us-ascii?Q?Px0PUjesaX57O4h659zHRXkx4FQk0Vep/fb+32pjiH+V4dOuguKpPdD17oyn?=
 =?us-ascii?Q?pJRelCZvPolOuofgj6514j8M8QXu/gw3Nk+h2BPuGiwIoBU0AzRxyD9t4xrZ?=
 =?us-ascii?Q?Aer6M35SfWg1OiubMDVVNLZDtFpYcZeJq1OBah4ZVDuVNThQS+15uJERWj+v?=
 =?us-ascii?Q?c8f3cxIv9oAq6BG9ZGH1fBTfzxHAz8udmGqwkiZtR5A/fK6FmH8jHX4Lf0yB?=
 =?us-ascii?Q?2ubrHuiHPv8BIIAAAJeJXk7XQeSQxy+F6eZcSp9EIRBlpu8eqvseVrR21U/f?=
 =?us-ascii?Q?SgpXAw2gKssVmkppIh/6Yy662DBY3FYgGisV7L14CSPmOH631j1mNxgurV0y?=
 =?us-ascii?Q?/fbEXhtdY2dAhND1dCM6gwYoK/FEE3d0ZCwoyBd4f4oCnjAt0h6MHn3+jyzQ?=
 =?us-ascii?Q?BWAIwjhnzR+MM1wnpY6eG820mQl0VSoaPQow7JArC2QkFLHNj1VYnEV2GUbQ?=
 =?us-ascii?Q?YDWFlg/kwa0GN7CjpyWExCNve6iUfOPgjdvP++5SSkY7gsfScT0A1kiZoVQc?=
 =?us-ascii?Q?8mU1DDHENff2eGdUGqT6E72iH2b+PF0JaxW5DKi151WwolraqvUTmsW6/l8u?=
 =?us-ascii?Q?gfMaVJAbH+AgkPfhfl6frsOyArFzy3ePcsvDDQgm7vVT4nHU8sPSA8G4NUp7?=
 =?us-ascii?Q?GoccOHERiuAtiyBNCYiiymihSOBwBcMSezG685ioSwplVvy5Vxa4vYDcotl1?=
 =?us-ascii?Q?0uBny+5bmWDAyQXCGNDDXhRcoXuhmGq4u8VTtnGr2Dzy1s7aawBjw2XOdxzp?=
 =?us-ascii?Q?Q+Qhmddlam10dbSm84lvBiWq3E4+6fGoJZdFZCE6//TPWKNwhH0iHFXgfWkB?=
 =?us-ascii?Q?3VYOeOsOSMRyYtiv7uHhr46841Fx3Qkt2A2/Ib9lusjkGU/sDCttp/pGzmMs?=
 =?us-ascii?Q?QY9AmswHibny0klJpIXRrjklxkX6HZgonenl+srqy95j2lwDbdCTDk9QJi/f?=
 =?us-ascii?Q?XRNfC6eYR5LYJl64WaD9OF6HEwdzMpxXblwuVqcFtMLufoCensSOakQK9eiO?=
 =?us-ascii?Q?S5us+ANPBaoyjLWYktaqm49UrgpD/E/e+jhBw+//GS2LVzRFy1bLV+I6VCSj?=
 =?us-ascii?Q?I4H3ljUPDI25/5O/stsxeEDqEISMp66HRD6XzdBDoxmP/rr2VxZ7o04QRGTi?=
 =?us-ascii?Q?U6kxRB4EawHu8/WfzbgqD4zHxfCtO8GpFhxyyDWsNWmPBbQtPv9yeqyLpp5a?=
 =?us-ascii?Q?ZYidzNzypAhI/nt4CHcz3Vb4BUzIe09b4Qv3H/X2xpzXIS1Xp6HyL6O9a+Di?=
 =?us-ascii?Q?XoSvbM01sYj3B8aXM9z/ds=3D?=
X-Microsoft-Antispam-Message-Info: Bp3RUoSFmVET5C+Z3Q/gR+6zj9J6aVNcfglj1/SfS4do8JzaPlP0lSA36PvpaZ3/RmV7a24PRIZ/H7/A/gPqZLcy/NQoBcjsK7W36eIJY6OzQ5tFeXZ6cmLDkP2HZMGXX7FhkwZ+stf1biLXudU/F5dcdv2WuQrU5Q4d/kYt4ic/eYYQt6ZK1QzKL62Mj+HfcX6h8F1nikbBxkHszJzVwIznn6VA6Vggo4F8iQsgH73CYRdqekLbUl7nFzo+h0VJa+dBvmpooma1K70DV3jSmHt0hFbGGPwJijPDJq7Z0/RmPZVe7xSGQPk1YnSayvUV+42uGdr2YWkrlAvQ7HNNnDOYMnVAkrNDMb3fp7dTPHQ=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:O1jcI+Vl7XW5M+pYKX4LR6O2cVCLF8mWBV/fokFAvtd7rRUtkoSp0EtxI/ytvnzQnXIBwEAopTx8rhC514oGxq30xQwupBsGhq43llH+dhZnbK6jmUauyZzO95fkoYXGs6aArRgKk5NwUPaBpdCBFvhoZb6z+nlOqzBrsqYGR16W5eWOqyVBnzgFy0tsrMdH9bb7JAdE0nmhKWLt3+zs8Z8Yeg/zc6nU6EQ9W5tzeTSwucNGlkL954s1nWcai9PWgqqBbidKWurtFAeYCR18wQfj1NwAf3B+RsLexf0n+B4zpzLgLK4BQ9NNzfUhlxJhOpa8yl94Akq5TrfVGUOoW98YGH7G9MallV+oKsbMqtS0uRfWAxdCOvK1DC1GzHM021kYkw37ksqrMRnBQIup49zFow563eiyZHcsngs0C1+IoVY9DlLkxrIXhuT+vMqCalg69SYRKOFWYWscmAdTYA==;5:WdC+wCZ4Zvkj1hBE/U+2+8mCFNPfO6BTR2IyRTJOYU3PDMO3MpF/0enW0FVjGEbomBVlMHioXHWFHppdhR/on9r2Vay57MTbna3lZM2OuXrIETc1h5R//DWoRsjLrTboClNARXyPEZTtPgRc7HrS1+1A9q+3fInhsCz1BCljYDw=;7:S4nBksOjazGe9LdwGMfxt3Iv4M+51ZPmoXuvK53aaFKCMf5cQP6r16LT7t7959DleqZnVmUtEU3d7j6iGuk/c6MhpqKM3OI5hvo2VPzdNODDVXh5g4zKQABJBFpDTm8rwoEft5NvCEvYlwMc8eYSyNiWxiCz5qPjiblIyX2nkSEtAepbcJqJhd0TVKn5xGrL0F0vWi8YM+Zen3jO+Rytr6kOPr4vOtJd1T+hTGU7I/HjlZhNgaGfxykA40sU+AGM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:OgQxfKDkKUSLj6e7wiySGGK74RDy6Iu6AGeTq4CWsO0X3GjhreBgfGNnyWRnUbNHVlu7wqnTp5/JVLuoJW83yDPxd443DpiGJbX37jVxdW6L6YC1KIjpSx4YJB2u21v6gYUcrjhOGkjJtNX9oLYIvag3hUQI2V8vNgSDKEIehNs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 00:32:19.5212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd51d0a-ebf6-4290-cdec-08d5f80f689d
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

Introduce the mem_cgroup_put() helper, which helps to eliminate guarding
memcg css release with "#ifdef CONFIG_MEMCG" in multiple places.

Link: http://lkml.kernel.org/r/20180623000600.5818-2-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/memcontrol.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6c6fb116e925..e53e00cdbe3f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -375,6 +375,11 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
 }
 
+static inline void mem_cgroup_put(struct mem_cgroup *memcg)
+{
+	css_put(&memcg->css);
+}
+
 #define mem_cgroup_from_counter(counter, member)	\
 	container_of(counter, struct mem_cgroup, member)
 
@@ -837,6 +842,10 @@ static inline bool task_in_mem_cgroup(struct task_struct *task,
 	return true;
 }
 
+static inline void mem_cgroup_put(struct mem_cgroup *memcg)
+{
+}
+
 static inline struct mem_cgroup *
 mem_cgroup_iter(struct mem_cgroup *root,
 		struct mem_cgroup *prev,
-- 
2.14.4

