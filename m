Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF3C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3581424A35
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mqEAahs9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Gw4lPLqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3581424A35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934416AbeFWAGn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 20:06:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35072 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933987AbeFWAGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 20:06:38 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MNxRG8015066;
        Fri, 22 Jun 2018 17:06:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=MWZxNmun151cjq/FkqsdWNDH49tV+VdYLY8U5dMeAs8=;
 b=mqEAahs98hJJDUAtFK7Ka4tr2l3sUdz/IVaDt4uew+ghuClxuEd0n4dDmLyn1gnXhpHE
 lyqI1+73BW0vGdyAmbvVFR9g/vG0kkzr7mV52w3FbPAtDqGndFq3sk1bLJN1FtHcQKw1
 xeH2FLeGWr9mMkI7H0dUnSGL+u8CFmkIy6k= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jsb1a01ax-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Jun 2018 17:06:27 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 22 Jun 2018 20:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWZxNmun151cjq/FkqsdWNDH49tV+VdYLY8U5dMeAs8=;
 b=Gw4lPLqFs9/6Iq55NikQEr1uMdP018zEun0TwY8oU/yEvHOLAFUaMkjYXTQDLUZ7hP6uMvofj9JpEqNmiz0R1VJao0g7kOeZL1y5cdD53u13lruo1n9aLTYnqwLdbPNgytISQNZYaoj27Q5brzCd6YeMwhV4+BzBZWa1olprNCE=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:d066) by
 BL2PR15MB1076.namprd15.prod.outlook.com (2603:10b6:201:17::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Sat, 23 Jun 2018 00:06:22 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <shakeelb@google.com>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH 2/2] mm: introduce mem_cgroup_put() helper
Date:   Fri, 22 Jun 2018 17:06:00 -0700
Message-ID: <20180623000600.5818-2-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180623000600.5818-1-guro@fb.com>
References: <CALvZod7G-ggYTpmdDsNeQRf4upYa34ccOerVmEkEkLOVFrBr2w@mail.gmail.com>
 <20180623000600.5818-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:d066]
X-ClientProxiedBy: MWHPR1701CA0021.namprd17.prod.outlook.com
 (2603:10b6:301:14::31) To BL2PR15MB1076.namprd15.prod.outlook.com
 (2603:10b6:201:17::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8461d43a-42e8-4858-d836-08d5d89d2816
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1076;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;3:PJLNA79PHx7h0T/UPmadzi1BXW9l91jAPSwgxgnYkq4IowNzArkQAF558BI6chapq59ysyDnxGy2CthUVMILgVFlQ7Fl3QW2pgFqrgijZ9HpaYqlDNgMWdwJW66ATER/0aE0QD25ALsmG1f2MuoXGmizoTufNue3LD/Kb07OjIQwMkvv4JKWbTw5gIQ8vMddFC3ArmDI5DTxeDA2jHpkCOZ8LcKS5BhrTJtL6sNuL8LX37YcCd2n9h2UzYxVv+jz;25:9ii/5a1vKgdjG7CVY0ngprgU98wUZAm04lOfjqvKOjdmq8qxbIHF80Xr3m1NF7K5cuzltxh2QqwqHfIdq+CAsmEMo+how06FIOhmmbr5GoyAX8SHOfhLL2hLe3alVObDBtFqYuLsMSlEXHExFg1Wc/nf/iC90qg/RBIWxn+LUxvntt9QbvpBrgUTMnpk6LAcVxnPATEa95TaN+d0V4g0MKA26iHjT50Vi1Bob87IVlqKOGdXzxJ0CGkf6eCmES7HXsaDinDT2T3ilIZ2ka6fv8xasToo12kq/ZkJIxgiaLiHrOP/03Y+MiVSnf/qgWDAjbkkmp9tY8WH1BeDxdhI4g==;31:/HQlUIeSfyYUV6XLwpHwbL+Em3D4sMYuLB22riXVCo1d9oDM8hKiNfWvbSZpAIge0VPe7lNMVRP2DF/kNLTz7juXswNW9UNRhM9X9YzIMysX0WkWF2YztLEPX8olvi9qWkiH5FN0nr9dyUXq1A0bmVfkibueseA1/BjF0D0QV9b20/c+yLcBMpJblXCSRxP5zAoX45vSZjHBZ+js2LWx6CKzTDfWvFBw5gBU3wqgfio=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1076:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:3nLf+jUIK6fYoCCcpkVGK1W8yRmkylLQAY5xTR5uh09iuPvncTaEwH7gSuEoBIbnGMe8p+NH2xC08BKgNLZs/fT0RanSUDwhgTLJ1qH9/Yrjpeg+eP42cNXSoTi7Uin8NQFwfaEPD34Nysceecy1kpISrcc6V3H2dp+7yEQRYpBE3v9rAWETdm4R5JDesj2fJSA1P73a3NppyNjsncLQCEFi/XOPR2H/4lob7H3oZCxtGnVqImqLYjqETkGtMjjNWe8aZ7vhH7Hs4E9iG/0RbXpv5K0tKTJTdtpDd95mFN3F2dH2FLVl+8/mImrWHbOn+LPduCdL8HK71RwXZQYVoztkkAdmrGgvGrVRkm7pn/miVZTfcoIxOsYJZXy0L03G1HnPvTrWwM4xm3PXtSFw63p/aYOUddWuqh6PY5IHOppEFNr2ZT/+IuFvVJeAjW0pkW+xdQEvIgy8gkjBUTwlAK1+oOiZtHICAd20sO9G2fXMQdvKfvYhcmmXB4PZ557O;4:1LdRw/ZY5Olqed53QREgXj3VEScPxz66zYcRX04+2Xl1XjYsD8UIij8ELT1+6q3yxsCGgsFJKrw+yvX2qFTndeYh/flV8XtQSUBP6JvHkiCaK3gHz8xTMIoNi2Tm6LhvxNX4+i3s/2XkuI8jFGx8v3mKDXgijC7DxrWeeoj5ihNoU5iq800CfLAKMC0oVHyUMbyIiZlh37CgiiPzn8/A6lkO1qx0FMniXIQQUVuHeWMfL8mR1Hl9zPZhwuwnMl2qCLKc/sUV25CKat04UlxoK+/nDhm+HoTaQMpUve7iwGJZGC/4hA3fXIELr639+dhVJntMXRYHJFrAToxNE85BtC2WXlhgenu+wU8mJhhyjUENCp81l/vcPfJVGSLhPbKd
X-Microsoft-Antispam-PRVS: <BL2PR15MB10763DE642B2B89E7E8E92F3BE740@BL2PR15MB1076.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL2PR15MB1076;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1076;
X-Forefront-PRVS: 07126E493C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(396003)(376002)(199004)(189003)(8676002)(50226002)(446003)(316002)(6486002)(86362001)(2361001)(76176011)(69596002)(81156014)(48376002)(11346002)(81166006)(8936002)(4326008)(186003)(53936002)(16526019)(47776003)(25786009)(50466002)(52116002)(106356001)(6506007)(16586007)(7736002)(51416003)(386003)(52396003)(2616005)(305945005)(6916009)(5660300001)(6116002)(2906002)(1076002)(105586002)(2351001)(6666003)(68736007)(53416004)(36756003)(476003)(486006)(46003)(97736004)(6512007)(478600001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1076;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1076;23:co0qm1/B9hzkifUOljotX31MVv4YYbap7eVQL0Lpg?=
 =?us-ascii?Q?N66gSufiO7czze97A2QdXMqYU++1VrEl48tSmHah5UrOjdbITOMoooXOdzJr?=
 =?us-ascii?Q?Axk3OAthU+pkpRgd26aOWOiOX+d8q7vlS2yJpxrni1gF4N6fTzaiUoBOInr7?=
 =?us-ascii?Q?VdE2oc82qVM1XB2ULmFj4v1Gu1Rx4bM+01ZnCeEQuuc9sTDaQuhG8LIQFdlR?=
 =?us-ascii?Q?k25vCCPbp6PoJAWFdg+p/rQVzZa87yR34pvHy0QnrgPI9g/93ALCBTOoXLHw?=
 =?us-ascii?Q?v91HD+5J3ofpOD+RSiOxLIgaTZPMevPn0x9qQIb4dpxOTQlz/neoVpPSwGdW?=
 =?us-ascii?Q?KhMA9KyRxD262Ng4bbBqLpewLKsK02cdjN9F+FfVBEcopTLRbi6oCj2gDdYL?=
 =?us-ascii?Q?x0HGiZCQns52C5Msy1GWOtpIuCGZ8EINZmidqTmkJNf0AhR2yZ3Ihh0EDvSt?=
 =?us-ascii?Q?Ov+J0lI6wPinpibktNfInJBbdsYAwssAAAP2Ha4I5+dMWedgoIELD3vyOoJ2?=
 =?us-ascii?Q?y6CjaUW7AvZp8dzWWZGhhrUoqlnSDQ6LJYOEtZZqsRo4CvmgbcUYgLZbypl1?=
 =?us-ascii?Q?R3LLe57ok7JHXKpNvZXUZuNgg8cYhY1b+SS0o+hO8D8B1lEOJkd/hRIYUZsJ?=
 =?us-ascii?Q?SrJitcHYtTRMTx3TLQre+g4A+UtMKa8YhA4YEw9QqqVk7U8p72RMkioC/TW/?=
 =?us-ascii?Q?yE1cUlzOTjF7ctNaiqieuN2p6GO5WOEHOAykzfQH7RuLtKlTmLZKKV/nSCyW?=
 =?us-ascii?Q?GQUKAx2s+yLgV8VG5e1SExH+VuFOGGT6utMsPkUp/i13r5wtBaSKWIwsci2C?=
 =?us-ascii?Q?64H1Wp4AK8lQzWJQeCKOpRaYYQeelps7x3l20Xxh/dJtwfvkv3lWJazw3dBW?=
 =?us-ascii?Q?5WGrDk5I5WefxuHnXfpa6ei1zxBVbdJ2JOUGhjFjJ0P+RN2Noz6gFwOjdn31?=
 =?us-ascii?Q?907IGLVRIyIozBVy/pLlwM9WYYbWeSKUroXWOYMxJ6+I0ETZ1F4fYTfsPLK/?=
 =?us-ascii?Q?teUZCEpzQJQdufK4eZAyIvECqZZbyuFZj3w3XUjJFhhVlBO/3Mu8rit3ji/R?=
 =?us-ascii?Q?7YCN4qd2Gjw9N+ugA/eStmHAa8taNuj79LqXq+O1EJnxhe7tPST2nMlUSY9w?=
 =?us-ascii?Q?nlF+MnA58NLCTGG4U0AEDR55HwWAFrk9upZ9OM9X13tQe0RYL1Loyr2b1jKu?=
 =?us-ascii?Q?Jo/lnCL7S+su9hKaq8XmE08Hr/7K0+ijafEP7XQADsuLluAKEIw3ScxKs0PB?=
 =?us-ascii?Q?X079jRshS5yD/lMocMvlb1euFVB98p8PsDOI2iA?=
X-Microsoft-Antispam-Message-Info: g+5/g4nLYjCPbQOgbli8qaV81X8uzXJD9/sA8LMW8qxjNPkT/3UExIyMGWOZ2+guQU4CJlwaQr7laxgJVqFWitjmB4Br7W7+KZALVxgg6zsKojQzsfYehpg+57W02nOvX5yIEiDeyzKqcWzUQbVjM0pDyH2uw/i6OmQhY+hjxF2POrwzd4oH8oaSWmjbC1muk++UMXp8PDEENfY9TXuSjnexbYLwRki0U8g4+xmNunDdjzK00BYqfW6cZe14Hdey6XG3o5QUmjRoBNy/gb1VURTyw0iFfYsCChdD7UfW0Da175lXn7A7wqBD/l80JLAbMrLxkXH8LAiInZBIoFlzlM0YHEcwU6w5+VMwOzbWd+c=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;6:hedtA6ViSYGAvmxYIMRyKX6ai73iCNi4ssPpfQlDoK5vRIzjJf5h2UJ6EViOC4SyBf0HAb1cNgNA47s/GSMSgkkFa3hPsqCGWFA2HEtXLCOoBn/Z4JdIwP89AtLBdxM0IGhf78sdAzuDhoR2i3ydUvFq/wdDFJv47W3gCs4WoTEWM2Ou0vU9a+dOnQosK0YL+YfJ7eN9ZohLMxaOiss5CsZlKdOAzqq44pc1wgU//PaMy041XTmM555TdqSqDuJi9wfo/XDEpV7kz+pm+DH7EhNHT50g8ua6EyUIJv5uE/Xv/+eOq+9+iQhDuZw8QChFttXa9SNdwaFYxXIgfM0Uu3lF+VbrtjOhHhvzMh+z+nZfIzt2mCacp4oRGrU509XagC71tuMjL6DKwZIN2uVeAt7NpKKzkL2zPdz+2MDD936Us7kZ9t5mkcqeZR0/LBuQlYfUBecqmhBTZjscOkbuEA==;5:Bkm2jn8L5OA137uvM1INIhwVc114wilJJwInM3uE0jHHosqoLqs/LxuMOD1adQIyIhJK6hv93W4iBKZJige8awtLYRReOyo+oVIjDdEgCnm6GhimhCmfGkTRmnbkrzvN810TfVxPUahyjpc5stzz0h7upR6nVvTZ+diJ92QAxZs=;24:SPSgr8dSuMbSV0Q1UBtERfGupr6HSHZV3Oaa4BotwPzVhcdkIgDb1zMtCmYcUZ3QzLv6DlatMdouTUrS+cJIydOePmP2G1SXQc1DiFmiqpo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;7:Fp/7WcmB7aklYwYYrjamcf8yMhQvRID+NPEgMxEwYga+tuk/EkAmLjz7bUQblhYOd8ot9mhrIjLEervu6YnF+hzoObnCy+4eUh4+DuPS6yCTMtfXgvomkO3L3Fr4XxG79vo/Uwjs4eJzM5dcPedQel8VC0+ta6sA0ZpMLN6lmhKR2ISIMBYtx7uFyLet8FcMgzvCMN0qIQzCjervI7OQG7tsPRA8uEziDexuhW/0gV6Dk0gcMb0Y1C/XdKyCn3xT;20:+gKpcnCDpCZMfYg6nanULDZCjVrsGJW8HCXUzttqOunPsRhadXmb4YbyhO+Te9DPNZJRjZK7txARTJj3hG6j4bUzaPj+LgIDm1Rpbbf4c7EyQC1oRHSrC3/jMqv/yvTN45mn7pcYjIy6K99FOYcegFJ4G4z1lN/YNNG/RngsGso=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2018 00:06:22.5593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8461d43a-42e8-4858-d836-08d5d89d2816
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the mem_cgroup_put() helper, which helps to eliminate
guarding memcg css release with "#ifdef CONFIG_MEMCG" in multiple
places.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/memcontrol.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index cf1c3555328f..3607913032be 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -383,6 +383,11 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
 }
 
+static inline void mem_cgroup_put(struct mem_cgroup *memcg)
+{
+	css_put(&memcg->css);
+}
+
 #define mem_cgroup_from_counter(counter, member)	\
 	container_of(counter, struct mem_cgroup, member)
 
@@ -852,6 +857,10 @@ static inline bool task_in_mem_cgroup(struct task_struct *task,
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

