Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A4EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76AF208A6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DTaCxZXM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EHsgPVsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76AF208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeHBCVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:21:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51362 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728135AbeHBCVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:21:12 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w720RlmF031549;
        Wed, 1 Aug 2018 17:32:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=U3IAqHuTQI5+fGwBjPHzcpkTcIvEn3WUFGPMfJBQWoY=;
 b=DTaCxZXMCetWwQyJgWZNeSRRI6gUPcaT/N2bYQ82Keu41tKXcXOpX4ljyhE3e55AC6SC
 y0oMYvjqK+8qPQMYb7TQPiCN6z5YWEbQ6ATLTNTI0sVQZ6/h0i27iT8wIOIibFrQa/yn
 W83r4qy3r0l4wH0tbdVTnN3cLC/syRADM5Q= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kknssr7sp-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 17:32:33 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.17) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 17:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3IAqHuTQI5+fGwBjPHzcpkTcIvEn3WUFGPMfJBQWoY=;
 b=EHsgPVsbY3ThwFrL3ZiOQdeX8xC0mRDjEWq/nxbWHISmgYAGxHp0ZzzIVMqitVxHhe57tdFEUJbmIksUDtpNA9tKoWkh3smKlswTyqdpKMI31iVB9vJisnuEdqz9k3QmNTpTLH/HRV/xoF0R+uMTDublclhNd3QZBnktL6eRi0k=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:2fa7) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 00:32:22 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/3] mm, oom: refactor oom_kill_process()
Date:   Wed, 1 Aug 2018 17:32:00 -0700
Message-ID: <20180802003201.817-3-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9348a694-726a-4afe-f8e0-08d5f80f6a8c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:RD1BNDJnTcFkgMwPv1JOu457LVZhQ3QvZXiWaYNoNMnXlj70TWlKk8/hYF3dCM11irznJutDQbwDmF/pcSW+2ZPxxIppVOLHtGQabNqbyJ2zXgWJI0yvQ4AgE3ecil2HdArTS9Pos+RAaksS0UhrhB3JYnVyEk5faJaxr2iNadkE3rfDM5URDkLozXBVMroNGl85QAmIhoix60v6qxG4XoSWlioUUZlArJ0AD23KScBRkWvb4RZQ81zl7WRXz3//;25:ij8N2cB//IS/OWATYa5067apxqGWDrYiY9KivMIvuK747zpwB+Zq7h0nXGHQ8+le7hj2hvZ5Q+ABkSfQ28p52mul+WQHBkfNyMDbMITzxVxC+1Jm0AnEZYiawJxPu9Yhmy00XYFLhD+zGrEOZpxuCF/bHJJKDT7ssOSduh0S538sW5lUZO6R/vK/0dtpDuyj2yoVDo98CGiezVSKXJpfe8bMcCuR81lEqEw6vWVspok8CiPVgub1o394TtNIFSnfnBD2XsjXQzsK1lS4TA9Mx1eg2RvX10UP/iYlAhmtS8j5ZHoduEGtEDZjrx3XciTk6lGD+z0l4JjQIPY6JzCCMA==;31:ah0Y/wEkPVja7wyvy3pihV9mYxa29Vr31Xkq2UImF/D9DLM5kuVUW9V5wC0lQfi0PZk6BSW4Zqd+U+5ICOpXtqEK17raEukkeHxsI3LeAZRa5m2IWhQyVe8c5owhTl0XgisGeArZfTvp0a9prshgn1CoKnAuN9YSsKf3M/M8yBOrdIB+f+prqVRaQldBCs1b1yi6t10phWvrR8IYlk3OAjRHsQho7YgiuZfHSXXF1X8=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:KJuJJI1ObBakii0s0y2XJHsiSIDmhYE4n6pgvL22tjEaRRH6qq1ZIyifBV4P6V17yQgk9eBZGcyMvvxC8L0x7V0+MQWtqzEcD0187zXUdHPajSK59AG8MEUwqjg//1hi1kRsy268OwqQ+hhQgEUbXf96ZEIUglvCxj7yiRAwkoiQrCSmm28uRFQyB8So73+kt+pdSqT6dUUJvyANWO7CG527zjZvf5JBL4vq6SyNjy+vV0pzYW5e9mdwSjdEnH424fBKGenzNG1C4uI+lMezjysPGlkYyuwKQUFmDShD72j2cG5kRj4DvP/IX36gCfEtIuiY8TXxtQ37Ye+FqmOpSP1HMVcLjFkOb2EooCjxxK/T3Wt5YfXzKZX2ijROCDhiaFaw3GQPG+Aa4MZj1Ed858NG8eJnnTm3YLx9ROj5lGbx1LMLr67zBz0pBiOz4HLdjwDWepjJM+VnvJKrred6ULllsJnqVpzMve9m3wiDQIONHcHa06r3ORbS+FreeYtE
X-Microsoft-Antispam-PRVS: <BY2PR15MB016704177C5F03C59541D807BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(274141268393343)(85827821059158)(67672495146484)(211936372134217)(42068640409301)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;4:j2OabNnVdGG4l5qwM81A8MBJFQ/HxvZ1prLZKebx77X02H5JAGArYP0PkcquYeEvxy3D+HFW4rNyrgVKH5S8FVLVQY/jmjOqK05gB5DeS0i7oBF271AYXbc2+1L4BX8rnMoRKpzslFgDrSI3fYwE7VVIm9P6saDLkYfWw2Dd4QjS9xQ2q1+VAeYGFOjVbmbrJfHD5ebf/1VkGweJepVmTDwdA/v5xFCb/NC+Z5+O9SaVLr4XjW/aZzVypl6GQ/PGyK7OvCdSs+mCaeP/EWgjJ6dPiiiJQ4CBtMkdNMoNCAyhTxN91qW0ACv1b2+J5lZ2YFXmpltkOSV14DN1cT1l0Lz8095G3VEmTj4NtvozkWOcdECnbnvf7du2IR+K1EH8LVg1aGLVK+4sU4/6xSoMyAXXuACg5zLc4dh92M0UNR/2LxPpzK+3+oPptUowmTwkaAPxVbJF4/QWRFkQj2TwL6IGwm8VxZiCbokeoRr1eGA=
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(68736007)(16586007)(50226002)(316002)(6306002)(53936002)(39060400002)(51416003)(76176011)(6486002)(6512007)(50466002)(52396003)(966005)(7416002)(5660300001)(6506007)(386003)(4326008)(16526019)(478600001)(2361001)(186003)(6916009)(1076002)(305945005)(8676002)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(97736004)(8936002)(48376002)(446003)(2906002)(53416004)(86362001)(46003)(47776003)(69596002)(14444005)(106356001)(81156014)(81166006)(2616005)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:eEMcX77e5JcmKzhVviUUnm35ejlcDqSHxWRuMiZuI?=
 =?us-ascii?Q?5F5O8EAGZjEx/gljNzwQQ6Aa66Hx3ClXV0deH48fZfpDHHSHUkz1Sgnopg83?=
 =?us-ascii?Q?VMhoBzPZZUyG3PxlE/tf137F80cBjWsmnmgNniAp1gD/5ftkfDCz5PmN+j7h?=
 =?us-ascii?Q?FI76meI2BbpQwmi+IBOL3Kc7t/TqYZJBr4gzQvKXC9a4Rkssv0PD80Yp4ms8?=
 =?us-ascii?Q?YfbU7gLSPhnB4WJDOC+rqLCDFzypz94LojcGKI3vVWNGDY5c6fRhkjfBNBjs?=
 =?us-ascii?Q?ICjihHrk/jmmGiyyjhOF7/Rescf5GoaOQ6WzIAAjPku5MoiUUeLheCL7Kuxq?=
 =?us-ascii?Q?NS6RxxlhPRVOLx48zPvV91vQRezJsajY2XpPyYgmZmJe1MaUqgEUFQ9NhvgF?=
 =?us-ascii?Q?mDx6nr0YgOAmaQGhSYH1v1I8Y29VVqyXOlMqwZ/ZPEW0h7gXh4JXyEkbpKZ4?=
 =?us-ascii?Q?ecTGm693qeQXXY/ucdPJMPUiq/VtF0tIgKYgYnLElTaukkhQDBlxKXpGHTld?=
 =?us-ascii?Q?iCxM5sr08dnyDPboIl6LF/rmsg6P4a6GosqUD7umEVs4eu3LMqrYH5Ewth4S?=
 =?us-ascii?Q?jYZCR0OnQezdzQf9k/i9imDUPE7H6DnhzG3cD3dB5t5wLuIzHp2Zm55fm8aX?=
 =?us-ascii?Q?8+ArNXw4XCV9H4k1bDbvjVIFwTvBkOEh73EM4OjDqUxGRPh2gebaiBCvAUaH?=
 =?us-ascii?Q?2kBfWHs52Cd+O8iwoZB2PKn0/vpA3g5hRMkvvACpRgbulMBjfjtMooarXgA6?=
 =?us-ascii?Q?uuoyeyvaiyzc5UDa6X4ThOy4nnNJSjV5F07S8nxmHxGblgl3p7KWwlp42whJ?=
 =?us-ascii?Q?5oRu8buaqMnLpubbcM67ajJjKPdOfenHyhlUZ3ym/duvRl2aPwjNiDSpPaKi?=
 =?us-ascii?Q?lNOXIF6rC1PPIjLb382qtF4epNIvLK0avU6bqQSrnOSZXly30jlPdNYKeOnl?=
 =?us-ascii?Q?tNi1pZjkxbTCLHBwJIs3/ChRWVxQi1HylEhtMGk8MqgYsRlG8Z9zT4p898Pa?=
 =?us-ascii?Q?+lqhDWjD2pgyFi+cPN/kkMQswVG3ScEEhjoy5gzeqAz7/lSV1FJXxwfBGjJk?=
 =?us-ascii?Q?4H3TLlnjJw0DvuyCIIUwnV8A8/8rwSIL2W+/asaS9XjuwX07riSp/tOACll0?=
 =?us-ascii?Q?4f/Lp6m/vGx07XPR05QEEtnh6tLyvAaotsfCYL72YFTjEmfduqEVRVRxG4pO?=
 =?us-ascii?Q?RlPkQ7YcvKHjjheuzvtBJG56edpEZ+rv4oVgM3jhtQxBa40VvGniFSROaBLv?=
 =?us-ascii?Q?jTa1JTK/g8n8nfK8hsnKlnhoWjXZWRr3raeHPzEOkcz3wOx7IJxXQDXDQ0Qh?=
 =?us-ascii?Q?hvJwtHlk4xIwil6TxWzGWD4KbWanrsF5AkQuwlD6odV6aAf/CUqFkBCOUftJ?=
 =?us-ascii?Q?4TI/nE9/qYpkPDkaPhNu4CFLng=3D?=
X-Microsoft-Antispam-Message-Info: WEyz0BvZdUHqa1Ec1C93RV9iVRrZp+pJh+SrRqsW9dLLKH1rSa0/TsICIIvpEkXcwsv1wMuvvg1j51tloXrjphdtT4nXdhgZSfZLDP4x3O+AH0C0Xih0DkPlTbF70cTy9KxO8iCzj7FACdssrOd/YvIVH4flzmY6tkEjN/iXhkXzPdZAxt3xpzzoRW5BiVHuEreaR1AZBuJWzNHffoJjZod9fVK6xJnSjC1xmiJOKI9071wbmZ9Ot7Tf9NxoPcCIg+3HwKxVG59uOYtkyY6ognwF8qV7WtMn5yUjRqDZmMM7bp5AcfPLiFwGkSPgnd7kR/O0qQzyHrwZnXHTsaxGE8XOMwrHnNC+NBnylhOKSRc=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:wu14/Y5lxb5uSF5Lrjri+VptOwxOVLZpmUa7EcFWZCUKTT18d0x++CjKYxH+uonei6+5bl1cg+NnxZjqQcSr2apPl+pEq85SA81hLXoUBZDcblKOQSld3r7OytGYze0d96I3VtoxEBa2mR4hu8S726nEJQ5qsTpC+LrPd6XypEPrKeMJGohis2goZvcHoxcw6t7i/30fLYi+mE5xP79Cj/vfagIhvvSIxfUOw0lF3Qka20521tZQZJ1C2PmsyzYI6EtXxSCvATZeh6tXQkqbKsVZ1F0t+xX8Cgnq3P/UO/GVf2K9Qq7tp4fiF70ynKGTzjGeFSpjPeId/Pj25xQkCJhwIsoURpfqsbMNAjsmSrP5Cm6BWLgpSzFqUyPqznjeyfpwlYLGO0Bf0Wc0CmTFwvVkEPmDsWDv1P4b5G6MU6AchjJfQqXyzj2Jhm/Whvgq0yz1dH0Q42UJrzMA6OB2Kg==;5:QAYBiNp0ivOOgikKFf3Q8XiRhK8gz8t1AsriO4U3s4kYVIYUA7IuVR9DvA5+/OLUZEQkhjjKW6vg2wovf5spjhGQthkkKshT7t9kjbS7Q4Kw0kkqjC7AepDr+H6kx1+WezZprVY5Bh1/ph+sCVafVD2+8+YrTpYr4pXSL71TWzc=;7:o883EyR/KsExRU16RBSyYmJOgDNuHeWZcLQ7FYpfuL+nlxuzO52d8K18oEV+7TIWqif7nj/D11AEhoVlQx4n5VQkpanUMQ4AvvZX4Oj0sJj1X1gOyNrN1+DDctumUs5ZorPxXiHEx2y78AKdpPSCRwyY0x6lzMePYWg0SwX0ZpFqoy+k3297WxcSG3vxTyU5oIordWOy7R+rEUCZmkb9m5ZJPR7fqbHE+6UlCfzwI6CUJ2u65QdeobCpnta1smI6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:FUhSzAf0sGyThyPPzAnJ/hFW/2oUYn2GMqsLv13tp0LdUBvhAfaWr5aJNuKRgtpHItf2if5lUhfUC8NY0SGqaX/oIRakIHEXU6hbNSIw0pgQiVbzRfFTLwx+Px7cmelHg4lqVwD2zN2LXO0j7MveitPFqozhjri9qLGNM2xVk58=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 00:32:22.7474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9348a694-726a-4afe-f8e0-08d5f80f6a8c
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

oom_kill_process() consists of two logical parts: the first one is
responsible for considering task's children as a potential victim and
printing the debug information.  The second half is responsible for
sending SIGKILL to all tasks sharing the mm struct with the given victim.

This commit splits oom_kill_process() with an intention to re-use the the
second half: __oom_kill_process().

The cgroup-aware OOM killer will kill multiple tasks belonging to the
victim cgroup.  We don't need to print the debug information for the each
task, as well as play with task selection (considering task's children),
so we can't use the existing oom_kill_process().

Link: http://lkml.kernel.org/r/20171130152824.1591-2-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: David Rientjes <rientjes@google.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: David Rientjes <rientjes@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/oom_kill.c | 123 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 65 insertions(+), 58 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 84081e77bc51..8bded6b3205b 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -835,68 +835,12 @@ static bool task_will_free_mem(struct task_struct *task)
 	return ret;
 }
 
-static void oom_kill_process(struct oom_control *oc, const char *message)
+static void __oom_kill_process(struct task_struct *victim)
 {
-	struct task_struct *p = oc->chosen;
-	unsigned int points = oc->chosen_points;
-	struct task_struct *victim = p;
-	struct task_struct *child;
-	struct task_struct *t;
+	struct task_struct *p;
 	struct mm_struct *mm;
-	unsigned int victim_points = 0;
-	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
-					      DEFAULT_RATELIMIT_BURST);
 	bool can_oom_reap = true;
 
-	/*
-	 * If the task is already exiting, don't alarm the sysadmin or kill
-	 * its children or threads, just give it access to memory reserves
-	 * so it can die quickly
-	 */
-	task_lock(p);
-	if (task_will_free_mem(p)) {
-		mark_oom_victim(p);
-		wake_oom_reaper(p);
-		task_unlock(p);
-		put_task_struct(p);
-		return;
-	}
-	task_unlock(p);
-
-	if (__ratelimit(&oom_rs))
-		dump_header(oc, p);
-
-	pr_err("%s: Kill process %d (%s) score %u or sacrifice child\n",
-		message, task_pid_nr(p), p->comm, points);
-
-	/*
-	 * If any of p's children has a different mm and is eligible for kill,
-	 * the one with the highest oom_badness() score is sacrificed for its
-	 * parent.  This attempts to lose the minimal amount of work done while
-	 * still freeing memory.
-	 */
-	read_lock(&tasklist_lock);
-	for_each_thread(p, t) {
-		list_for_each_entry(child, &t->children, sibling) {
-			unsigned int child_points;
-
-			if (process_shares_mm(child, p->mm))
-				continue;
-			/*
-			 * oom_badness() returns 0 if the thread is unkillable
-			 */
-			child_points = oom_badness(child,
-				oc->memcg, oc->nodemask, oc->totalpages);
-			if (child_points > victim_points) {
-				put_task_struct(victim);
-				victim = child;
-				victim_points = child_points;
-				get_task_struct(victim);
-			}
-		}
-	}
-	read_unlock(&tasklist_lock);
-
 	p = find_lock_task_mm(victim);
 	if (!p) {
 		put_task_struct(victim);
@@ -970,6 +914,69 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 }
 #undef K
 
+static void oom_kill_process(struct oom_control *oc, const char *message)
+{
+	struct task_struct *p = oc->chosen;
+	unsigned int points = oc->chosen_points;
+	struct task_struct *victim = p;
+	struct task_struct *child;
+	struct task_struct *t;
+	unsigned int victim_points = 0;
+	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
+					      DEFAULT_RATELIMIT_BURST);
+
+	/*
+	 * If the task is already exiting, don't alarm the sysadmin or kill
+	 * its children or threads, just give it access to memory reserves
+	 * so it can die quickly
+	 */
+	task_lock(p);
+	if (task_will_free_mem(p)) {
+		mark_oom_victim(p);
+		wake_oom_reaper(p);
+		task_unlock(p);
+		put_task_struct(p);
+		return;
+	}
+	task_unlock(p);
+
+	if (__ratelimit(&oom_rs))
+		dump_header(oc, p);
+
+	pr_err("%s: Kill process %d (%s) score %u or sacrifice child\n",
+		message, task_pid_nr(p), p->comm, points);
+
+	/*
+	 * If any of p's children has a different mm and is eligible for kill,
+	 * the one with the highest oom_badness() score is sacrificed for its
+	 * parent.  This attempts to lose the minimal amount of work done while
+	 * still freeing memory.
+	 */
+	read_lock(&tasklist_lock);
+	for_each_thread(p, t) {
+		list_for_each_entry(child, &t->children, sibling) {
+			unsigned int child_points;
+
+			if (process_shares_mm(child, p->mm))
+				continue;
+			/*
+			 * oom_badness() returns 0 if the thread is unkillable
+			 */
+			child_points = oom_badness(child,
+				oc->memcg, oc->nodemask, oc->totalpages);
+			if (child_points > victim_points) {
+				put_task_struct(victim);
+				victim = child;
+				victim_points = child_points;
+				get_task_struct(victim);
+			}
+		}
+	}
+	read_unlock(&tasklist_lock);
+
+	__oom_kill_process(victim);
+}
+
 /*
  * Determines whether the kernel must panic because of the panic_on_oom sysctl.
  */
-- 
2.14.4

