Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 16503C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2E1208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="npJ1fTEL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bYEvQ/Ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2E1208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934107AbeFKRzU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:55:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57812 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933087AbeFKRzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:55:15 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5BHnOsE008293;
        Mon, 11 Jun 2018 10:55:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=0F0hmiikZCZEpzpQjv6NKpEt9e00TVa3fL6JUAehAfI=;
 b=npJ1fTELEC0W2uIg1mNGliiWvRDC6b/tiS7+piSO/FCTJxxYBtXaJm07T8+OpUiPsx69
 cxPGXdldav9GZHtzF93MgZId6Y5mP4ugiZYctFyQhSX2tWXB2NLbeGXkvmF9x64cSkNi
 RvcTy1gGMVODlVXhamBIcbVLr1RagWRYko4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jhw72g4mg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Jun 2018 10:55:01 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 11 Jun 2018 10:54:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0F0hmiikZCZEpzpQjv6NKpEt9e00TVa3fL6JUAehAfI=;
 b=bYEvQ/Dszq4Hl3MbKBwchPFtbm+ngQervFMqShMM5ePgtMQvIwlcll/eURc1EH8UQI9tAOguQQlglVRveCeSOtlUKEiF8CVvindRhyIIKbwQZtvno1CRKEtbS/yW/CGbZG6zkciZ9Q5k+1eccF6ILNxsFEZnfS5PJdjNwbTW75Q=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:49ec) by
 DM3PR15MB1083.namprd15.prod.outlook.com (2603:10b6:0:12::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Mon, 11 Jun 2018 17:54:42 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>
Subject: [PATCH v2 2/3] mm, memcg: propagate memory effective protection on setting memory.min/low
Date:   Mon, 11 Jun 2018 10:54:17 -0700
Message-ID: <20180611175418.7007-3-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180611175418.7007-1-guro@fb.com>
References: <20180611175418.7007-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:49ec]
X-ClientProxiedBy: MWHPR0201CA0080.namprd02.prod.outlook.com
 (2603:10b6:301:75::21) To DM3PR15MB1083.namprd15.prod.outlook.com
 (2603:10b6:0:12::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1083;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;3:MpvrDcd1WFDQQeB6KxJp1zBCzuPMwa7lxXp8MwVRpHKJa2vddtRBAMezvWLqFuj+JET4TQX2+MMlTSlYlajoZ79zFsBG1eD/IvI7iMxxDzeQVvJCZ4md53B4TGrGqhr3pnwYW8SdCQXbTs9hh45zUohKWmZ8zNCAcgP/+oAWv/+bUEYMmYqTIJxo+IQMF4wPkQj4xFkogo4KlQWD58yg4RZyT7bM9Xpaz0nxHi41gWKFuoOIEeQlRx9XMbeLkOfq;25:ZbWDDpUJQ5tUF2ZjJ3jINo3JvTuFmuHXF91jkw6rP3+oinTuMKYqpIR0VzXCia60UJ0Cz8rFVKWa4ustJ3G/AFQ7Tjd/g/fVYscteh8BmRqdh+AVJzLDixF4Tqh6UWXhbo/oTeTCuR6Pdw+b4iTuQTCGShHpxypNbalwGK3gw0Qwqk1pqgjibVX1Y74kqXEG/faoxVk+Oh4RqjgJ6RcqebR3xewYpbyCr2YUKbzLWygF3V2fFXojIZWVfK3q+VWnNudHWE2Ca5Gg1ZpgDWwZwPwFokHTZVFrrGmzAgS1LXnyymUA0C9cBQTIEr9vB5XVSu09Wk0UpakTey6guDXQoQ==;31:H/84QsUAVoEJyAWnInTXHERq6RK7b67csvyE4r/XG6xayOx3dG2a2MqQqc25Vm+o0nV82Bykss7IX40mDKM5BudDn5apFazhdy1szkf4u63Qoml0CPIQTXSYYFk4qUiHyoDfWrhx9zd33uTpm6BUEl76+kCCZR97/2TVr5/jXbDZ27NV8GOadq8AQDwByqHkjvwrr6DlCS10JMJtqi/3SCogms9INVlILcInga/eOaQ=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1083:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;20:cz1ShvnvfxU+bedpnvVA2KomTveBKOzXMxNtap0QBw2E9g8Bdye7UQ/1ITuTV8xDtq5fSh9U8XRvwm1fcuvnjRBcWAIvgzoVMopkHBTCQ49X1F9jeRx7dIkR0iZdl1opNPY7p1i2BCK+zmWFV4U7iCNJ/m7LV+bVIXCXNnUng6qfmC3ptufY2g36q14yNSufMf7aTQm4+d/g3IbIWbVR/cccbA+GULcdyUFDSGxtVtXbI0I6+OFVIc1H1mLXGs96D/6UK/PGybXt6YIBY8BP20xdutndHQEoP3C2PdXnXcoIW5VEKKWEHwhcKXIFuuStbSWIay6oo7eebi5y0yUSKKoHBQF2c/4ubBwapnkKvLmDa+aqRrI6IivntjmvDNeQfUOdI80z7PIc8V8+fUoRHMsD9sa4ccIRGjPm8syzDW4VZpnra/NeZVfrCvWbCI4Bv+YqsQUrWysMBaVl5StZiw6P0DjXoADP+v7itZq6xWk4vVxvI4PM16MWj6wqbRqm
X-Microsoft-Antispam-PRVS: <DM3PR15MB108310CF74E1764DD3C166A7BE780@DM3PR15MB1083.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(42068640409301)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1083;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1083;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;4:oskz9UyXQ9USROWo4OQBfrvP/M4p0MwUlO9d/1l/Of1FN27r+0+97Lo2PjvswxQ+sSL//FkxzgN1tXKDgKHMygyHILYNpswffGRx1vA2pdXCCammH1vKsWSEzDFs6Jb5qRLuvL/BuY7ygQFtTLpIF6FymsIaPOrrAGOLpjKu9FRX3YE8QoOcQ5a0H1vbL8aFFReUKU6aHl0z5OikuqjQvRovoVm5xFnb46DlfbCTrmlbi1JfOZ4am7owpDq6p/Lr7rauob55VH13CVlsQM+lIVrEBvGUL2G9I7as/9YR0ZFDPHqWdvl+4K9EkwfAzlNvC8QYKtTqb8yyFg5brJ4bBHSzuH3VFFxZtQCn2l1mN7e5fthsg1uwB+YXex3MKV43eXARtk3WlkX3LcaRjSdtqhHU0Es5jdxSK92bcyGSetueW/ZbchC+xUnRUwOOx1Xnr6Xxb04/RRGP2CANVSG2JQ==
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(7416002)(316002)(53416004)(25786009)(50466002)(39060400002)(68736007)(2906002)(6116002)(48376002)(6916009)(6666003)(1076002)(6306002)(86362001)(50226002)(6512007)(53936002)(7736002)(305945005)(8936002)(81166006)(81156014)(4326008)(47776003)(97736004)(6506007)(46003)(11346002)(105586002)(486006)(446003)(2616005)(476003)(106356001)(52396003)(52116002)(59450400001)(69596002)(5660300001)(8676002)(16526019)(186003)(386003)(54906003)(76176011)(966005)(16586007)(478600001)(36756003)(6486002)(51416003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1083;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1083;23:kZUdm6N2fL8NnHM/VTJK0sC4o3UipF6KFa2RvjZht?=
 =?us-ascii?Q?lcXMIFzZCxPEaPnK0I9mYKtCFF2dOVOg1iy62hWRn34zGWxbQ0knPDBFbRGj?=
 =?us-ascii?Q?SlnK9mSgVLJPE8chW2q5HHq/St3GdvcS7j42QViJfBXG6BZAOtCBV/+aI+dN?=
 =?us-ascii?Q?0NNK/33eyJiSg1vKmA/lc22W37VI9Rg/m9/UVBZjwPTIDPs+1OlG6FeZpUHj?=
 =?us-ascii?Q?olltACmLKguznga7sgU31rXq80Cl8Ze8nFUd/ANyD8TzbSCgl+oGkn39vbB6?=
 =?us-ascii?Q?t9sif1mynzYX+0b1o6p2BB1GxYRDEbPo7uFEHjTEaz6cWtDxUxp+KmTqJ9Bc?=
 =?us-ascii?Q?Z8NleksXcDhOfMJefqW4tw00eFaBkGt3zU9P9nWDL1ryRR+hdO412Iuf+c5n?=
 =?us-ascii?Q?D8puCxkrbJypp1l5eCL3UrvbIX8VmGGQKYoXc7dkfH1UVsBG/VRoQOhklFzV?=
 =?us-ascii?Q?qIRIDTSzSCaiRcw/8Px9yk9/XIXUN+wbCfXf0mtVqd9Xtf7J2RIavjmxHf+g?=
 =?us-ascii?Q?KD5hUceZxAb29fRBJfvgvRNGsdUHwSp3Td+1S3952E1aTWQTrqG22AqyATZE?=
 =?us-ascii?Q?aj3lmr+XbsPr+CmGpg1AIkLSzyLMAYna9CFBgraHiuDy8HVWLwFvLJwcQ62/?=
 =?us-ascii?Q?ofy7Tsu8/7h17OHkeK789gIXobnWLFprtB93R8GrwyIB301F/zwl57ssgtbw?=
 =?us-ascii?Q?dGU3y+hmzkqm30BFO1Je4NemoGAFjWim0A3UyeK3btIjidQ6V5RWhz3W7Qde?=
 =?us-ascii?Q?EQLGiLoNKcuS8s80xVaH2RSjVcyPi8ScuxZnWEa/K1kf6oBwU8UkT4qnpr6c?=
 =?us-ascii?Q?gkzSb4/hv1N7geu2rOmkAc6UzgcHaQQ6lVrJz6imSnnjzhHXMNsR1yOZCIzw?=
 =?us-ascii?Q?eNgQafLCM2ufhxExeZGLSpNBflKoBa0+jIGv/+LoSMXiq1nUqgrHrm6FSKq+?=
 =?us-ascii?Q?4wjyxarcB4b9FPd1uo+Imu5d3R2KYeCj+T6uHHwoV9fn7b0mT/0wuDd+ewpd?=
 =?us-ascii?Q?GPj3Kv6u0wFD/AWU/ZNDoZBa8H0Jb+91VYoP6GUWtfkHAw04/hAA6i9J99nz?=
 =?us-ascii?Q?7H7AJfT+Topbx5eH9ufVGFQIyp06IqJldks391GVH2ZXPANjjdR0mYLEvRtN?=
 =?us-ascii?Q?CGe4GJDaUZ3CcSrdZzQkDtdpHXVcL1k9VD5R4GsA3mhwgRfKGL9QJDq/1H+X?=
 =?us-ascii?Q?AzfkPGujsnbe0N0K3iFDO5FiuAcri4KoJCk2Bn4/UxlTJ7E3tVUB2iYseVTN?=
 =?us-ascii?Q?WSzoZOlFaNEYqN6P6eU+900MLdH8ddpH5ziRmeTmuLEMrWDE611RfMG5RYQV?=
 =?us-ascii?Q?i7bNLyC5pByHTXfmlvWzS1gXI03t8chrHtjPsSaxqqNTZlANgPe13G5TsXtW?=
 =?us-ascii?Q?ytZ7g=3D=3D?=
X-Microsoft-Antispam-Message-Info: h5MVZXCFmyFSSuNDGkmpWJTHJTWRYmyVh1typBBS7ol+3zP1/QU0B6g15uPUXh/mvXj1FMZeCXhCiR4ofqzkW8JiJdSBh4el+CE/aqeD13r3qq0291ZyUenHuucXLU1GZRXAIFyGRi9k9vJEZDMQEHAxYmWPxnOAwOiiEJyghuM1/ty2VoGmBvjoMz4laquc
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;6:6eztQJM1qH7evee6FlTUaEk6iMKDJi15ic4UPjo+keE+J3XTk/dL3Yuk3j8U2SZ0HlrgPhrJKLrvFVnyNJpZ5zMa/KAZZDUukFGesKfa+iXi0fj8PQZlYk8PCXhcmYKWKPZpuu89fpohu/kXuJOrDqxelQPhGwtS14m2RGQsp6k+ZWePtWyL6JlJzAizC8I8tX8HkrNGjNwD6GHdOr+S49qKXpGrI0/z0w5g7AbfVhxV4XJxrjpVzbBZWAW6ZKNF5x7ZLY0WJ/+bneIDdynZfJEjLEbGwGC0qJxi/NFYwNHGF1d9wBvnVH0dGKCm1G+VFp75p18k57xpT2qus3h5Rn7bXMiuukcVq+oWOnO3MZVi7GDNUrQMT/u9uqd9YDGXE+8u4ngfos88D/4+/dB/x+9v/1J6EZodMxNOAHACu2QCybIX6zn80d3g/r3pgLnK1OpD2DpXsQSfKLDBkrSoHg==;5:K/d9natiCyfP2JvUXSc8Ez50PXvcugSAdslGFtTJZGTg5/jIoJ0W2AOtektqAj1Pymc3xTqjTOaTl9nLBZNKF6rN6r7HVf+cIUkR5aCACTyn0szku0d+f214HZiWksXvQuMwbq6ZKJonBv9++2+oHslzJf/SHs6uXE2zQJt0L0A=;24:E5rkwzHQnp86lu094Fd9JTwH9+oTjONBcuWtKZ9Z/CFzn0xYdm6x5bZFX5RILQfwIZP7JY3P2W8v1OnV92O5cvTvgztWzOSAu8T87iBAhzI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;7:w50HUMVe9R48wTbFGadcUlxppH55yNtwgsmn3abJthIXZL+rup8MCXU9Cvjk4/Ugcn0sDHMtArs7jsiYshpyHQ5v6LAs1ugkmEwh9AhagauNPD/M7ZA49QnJGl0GT0pCKM4cxMiepBVDcRnHZcNATJB0X522bsnf2dQ8ngAwFb7Gxg1Nz9uQQv+6Sic8SPGXKYi9oUhs8RQmEQzqv7scxQiXJWbwEVmuQMZF6wbvjIyyZY+ver8Vv0fIp12aTQzF;20:SD1vjvYolG/SKT7EjPga/nrf51IOjN2FAMHAtmsuAHz8CR0xUbeGQMpBuesMN49kueHicHc1IBfKflZft/uxGXQ02Sq4XxrlzvOss0dc20qE1N9esOrKKzwQmu4ulwbyHuU1juKkDYkyc6/pqv1hsMZwJesT6mrSny0Av/dxGs8=
X-MS-Office365-Filtering-Correlation-Id: c18f0541-5a32-4b19-fd1e-08d5cfc469ce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 17:54:42.7266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c18f0541-5a32-4b19-fd1e-08d5cfc469ce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1083
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly propagate effective memory min/low values down by the tree.

If there is the global memory pressure, it's not really necessary.
Effective memory guarantees will be propagated automatically as we
traverse memory cgroup tree in the reclaim path.

But if there is no global memory pressure, effective memory protection
still matters for local (memcg-scoped) memory pressure.  So, we have to
update effective limits in the subtree, if a user changes memory.min and
memory.low values.

Link: http://lkml.kernel.org/r/20180522132528.23769-1-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linuxfoundation.org>
---
 mm/memcontrol.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5a3873e9d657..485df6f63d26 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5084,7 +5084,7 @@ static int memory_min_show(struct seq_file *m, void *v)
 static ssize_t memory_min_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct mem_cgroup *iter, *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned long min;
 	int err;
 
@@ -5095,6 +5095,11 @@ static ssize_t memory_min_write(struct kernfs_open_file *of,
 
 	page_counter_set_min(&memcg->memory, min);
 
+	rcu_read_lock();
+	for_each_mem_cgroup_tree(iter, memcg)
+		mem_cgroup_protected(NULL, iter);
+	rcu_read_unlock();
+
 	return nbytes;
 }
 
@@ -5114,7 +5119,7 @@ static int memory_low_show(struct seq_file *m, void *v)
 static ssize_t memory_low_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct mem_cgroup *iter, *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned long low;
 	int err;
 
@@ -5125,6 +5130,11 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 
 	page_counter_set_low(&memcg->memory, low);
 
+	rcu_read_lock();
+	for_each_mem_cgroup_tree(iter, memcg)
+		mem_cgroup_protected(NULL, iter);
+	rcu_read_unlock();
+
 	return nbytes;
 }
 
-- 
2.14.4

