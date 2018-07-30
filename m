Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB823FC6121
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6952A208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Zc+blTtw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WUl7pWTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6952A208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbeG3TiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:38:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56232 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728666AbeG3TiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:38:03 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UHoupf014230;
        Mon, 30 Jul 2018 11:01:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=U3IAqHuTQI5+fGwBjPHzcpkTcIvEn3WUFGPMfJBQWoY=;
 b=Zc+blTtwIAB0+Dv3QcOYzni3BSOW2ON3h3xV+cZo8aYAPbd5PHRH0R1MHExdy8emw1te
 mJ1Se4Fv0VGrWxAAIg2914g7n8ydelqZLj7/Sy9zbh2LQXJtwHCsZxyBK/hBWZx2CiGl
 mXMVR4MNZmABP9Q0raCrDJrJ4/vMt81dZqI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kj57p0fjb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 30 Jul 2018 11:01:38 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 30 Jul 2018 14:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3IAqHuTQI5+fGwBjPHzcpkTcIvEn3WUFGPMfJBQWoY=;
 b=WUl7pWTa5r8TCrsLyLwpl8uDC6y7rQRy838H+06bVMk2xkAlGRECYzxMfVf12qwkF64IFQqSv+JnedMQTXaLV4L++Sj/wgyj7xntP6sgOjTE73aPMV0wyc8agULVuZf2cLOjXz2Ib5ErrR1QS3BFEQv/6RsX8+YgHM+2Oek+h98=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:484b) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Mon, 30 Jul
 2018 18:01:27 +0000
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
Subject: [PATCH 2/3] mm, oom: refactor oom_kill_process()
Date:   Mon, 30 Jul 2018 11:00:59 -0700
Message-ID: <20180730180100.25079-3-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180730180100.25079-1-guro@fb.com>
References: <20180730180100.25079-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:484b]
X-ClientProxiedBy: MWHPR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:301:4c::22) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a521c10-fc15-4dc1-9807-08d5f64679de
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:jhpNDoFxuGd2IoyjH20yxjr41KXDy3SpfgItPY71HpQjFhObS0Zzl5WMMFCkWR8T+RxEkOWFohEcvi/YSlckHrFHrBNVS+xaLbOnF2etN+oA3lgxyaimiGKHIO0j78HhW0HSBOD/aY+j/cN0m/gIkfdosaLtse4+AINvyyhTkWapidIJQKZQtj3JtQouW3b+h1+6sNmUb9Gd+vTEvSj3AxwyTxtjyiPgKLfFAVb9QzXhEbPbR5rP2T9/nQ6xxqUM;25:yPfb8+huXZUytdDHzE4zYsvvENAVs75vI7t9DPygbbRpwrGRi0eirP2QOuPjlDMG/fuEqupAE9eai2XUSnSo5qEND5FJLaG0xiyDt131qch/VjTWgMi7zURoowGxmDswUsCHAryIu09PjK+ucp1Jg8poA3bFNUqnnha0JkXQgIgjEGFIp9Kh4oi4uMGL2WTxNZuh9fJBPmQoNXvXzMSnlnQFDLtlafBBNI7dgW0pgTAnyitmt7QkugedOTWl9VTYQQyxbEOA4OGJxnRp9CDdsF8zxI8DLAkXxbpe9D3D3/no6ZxioGJLeftGRqbEFzoT7DWVmzv/AewfbdQwk1UFxw==;31:l+WyYchJoSbY/e20qu706z5WvrFLEqf9oInKcp8UuDDtXrS9+DQ7DD8/uor8/HtA6xi7mxqHtCBXyy1qgc91o38Qz+GxmKgJnb6X+eqi2FEWZcGBBl0BRFLdFS60ejA2APcZT9c25CnABB5+aOKowrI5VD3PkREr0gsSnRwgREUf0n/aaUN7J2M2NWeLVTQZqSdXKThFeCOl3EHP3zHaDEs1q+VgIH0w11Gjhro68Vc=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:1JTUl+yH6TDkJhtSZBh/pdwZ7FHLRdvvgx29AuY/1sztE2tBI9ZGo2Cn7egVridBM4Qnq1K+FLj/Q5w2JOia3l8t8VpjMlLwn7vJPz3tqAT7Z3nYIRIHATEApTKrrJl6F9pN0GVLGvnnoBBPYqglsdZYl0E+FotYvWL4vx0Z7TcaKfzm61n0nQxe4BlYKEF05krIuHaASUz//yPdPvB9HCu2ZXcsPR6mzIvizp5J4WQGFAY27wRb34hcmM8bPz+o1/anxFC4IFm0FvfgJzZX/GnDSbM2yiWV8e8KlyHIJAeSsV+W5rvLPRdBC56QF5TsKknOCI6LnmiE4jGvFn51mDKka5qdMFsynkrUJnbXKgzu6yipgh5rrFdgp5Jg+QbYkDVefn13etJXxjETG3q7TNEfCmxPY62bqXJSKNtWGtg09Y7aIEB7681UNpaxKp65Rs8TfeXc5nu/4oLC4RjN4m8jhtmAhXuhyma56NPMdPIvn68/X9JnNSxvUV3MxTU2
X-Microsoft-Antispam-PRVS: <SN1PR15MB0175129777F3A200FA3D2C79BE2F0@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(274141268393343)(85827821059158)(67672495146484)(211936372134217)(42068640409301)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;4:JYaptTCExKK1T1+XGXN7b+b2CT+TYsY4WBpkaUnuwi8crFmr8Yr8n4TDkg8+FcGhQ1H5icnrSFj4aXBRH89hGCmx7qXd5hz+ouroTcCvKTAtSLxv7t9mA/do/P9WmVV7eNdkAfkXJqIoEW+iPnZSij2brYudGBYWhYfSIDqmgC32i6c7A8qXjHKX0+NUiLD0Oqwj6xai/JUuU+EVTyqKTJsHqLiHF4y0Isu6VMUi5sVznCn9ksYQAs7vyRRIL4WXbkfhJBIXJ8nL0XJnXgB0voDMKOqSo4EOihzWvBP4nWCpPdtJZqfqffAZ0WGlkjZN0VPffreAlubWzb6S4bVFl+Kw57muxlhicLX5c7Gt2ue2YaaA8dT+U5vejTi7LQi2WUO4Q2cDqGN/nH33+RvoPBmvHRyvdYmGyI1vqczkQxo8kyKGUCcZhwT+AOyimmugABUjzPooJEocfYkX483LUoZehoSNe7Uwya+jur7m+Ko=
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(366004)(136003)(189003)(199004)(36756003)(6116002)(8676002)(6486002)(16526019)(6506007)(386003)(186003)(1076002)(86362001)(69596002)(76176011)(52116002)(51416003)(52396003)(81156014)(106356001)(966005)(2351001)(105586002)(97736004)(8936002)(81166006)(305945005)(7736002)(53936002)(6666003)(39060400002)(50226002)(25786009)(53416004)(478600001)(6512007)(6306002)(7416002)(5660300001)(2906002)(6916009)(14444005)(54906003)(2361001)(16586007)(316002)(11346002)(446003)(48376002)(50466002)(47776003)(476003)(4326008)(46003)(68736007)(2616005)(486006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:mCU3/R42/l/IAvx5XrFX/h2rLO466sG7zxKa+CEAn?=
 =?us-ascii?Q?zF2GX9QzPFebBFk+EjiCLQ0m4nvtugk9m2EI+p3s3AAkiXUKqcfdpRvIxvvS?=
 =?us-ascii?Q?84oxeZkj9usaKn29cu06EMjDazGGHUgQ62hA1YiyG0qt6zcFo4pPCGcumbqz?=
 =?us-ascii?Q?J6PtPyz1gtDqI7lBs7+vLBMV1h/j6dQQ3AwdMoRvmJVKmqKMtaX04t78jYK6?=
 =?us-ascii?Q?Hz9sMQ7ggL6vXsyNby0edr0Jrz4ZVnztIrbb+NfXybksXYD5TRyRNKd/ZPZn?=
 =?us-ascii?Q?aY6ZWYOAMXlifwhqwJQ9T4IgcjfDaT4lIjFaLE9yZ2e7nz2zzZWA63khTNiF?=
 =?us-ascii?Q?MvpCh7JOU1/eH0k8y62e77h8mgKgXk428NKfEFwKYKE/kaQFqgLx3WuS0TOl?=
 =?us-ascii?Q?+O++mG1Yu7xhRyUa4dmgSib3P4rWuW9e8vGlctI/rZTpcXWRHDlBYkJ58f4/?=
 =?us-ascii?Q?V955qNOD6Mgd7UQcbr0Lbr0G6I/BNnbSoACZSKUPAeZuoZhAWYs2FwCevE2W?=
 =?us-ascii?Q?Wev73i7jvR3pXpEgsu3za2gtOIPre4ci0tHZXpLQ4CbTmCqOFak7N2Htig1K?=
 =?us-ascii?Q?lo/rlocHwSt9a2KFaHqOkMw2FgV3o/f/bORaTl3Ll3S7D4pE+8xto/7XmzUh?=
 =?us-ascii?Q?3CtlbQ/MtejddtVIWRw6aSor9TYqLc+nv9eKTqK0/hcuNW9y1wbEiC1kjxGQ?=
 =?us-ascii?Q?aSBXRAwfDK5PAXLIPkeTIp8vG9P6qoNq+42g8XYpdDLKHb/j4YX8oREMoj16?=
 =?us-ascii?Q?IzkUoIQMSS1TuxDtBsDnqtaHovqu2A/aPxXtqako/WQrRf2KMHJFBU7wJ5Ty?=
 =?us-ascii?Q?udcbJny0ByOZ2YuFXP/ozAK3hFnj6TOl85Ue0srs/WDXG/2p7Yvn9m6o15R8?=
 =?us-ascii?Q?hrUmd8xIFjXZC2F46xP0t1k/N2uqqW+o+kPsFV9tjQ279RFpySwg112bH5Ce?=
 =?us-ascii?Q?4WM3zwQFLyO+kDE21AAKdIjiLL4AKuqaSzYCNO6MGKHCCG6+np0Xq+BpbBQQ?=
 =?us-ascii?Q?fjlEZ2njwSdn3dcQD03Zxkz2B+7kPnTeE9gKpv+wYodKabqkrzggd4PVZME5?=
 =?us-ascii?Q?VhBKRekx6sn0fJtS/5sfa1Qcx07upZpfs36hxbj9sGjYUdP/Bu1+QgPh54Qe?=
 =?us-ascii?Q?yI/lOyqCEconOedRxOAKkagtOGFhvhid7bC3u3XkDkHCHYv7+8eVNcwjTd5h?=
 =?us-ascii?Q?Hqadpm+K89WyqYxXkuh+WlebssKhUXMNDmRTKrNwGPphCKTHaQ+bhm0X8kIk?=
 =?us-ascii?Q?4eSewA7MfgzHP3xNZU79TmZ1kTmAa+c8EA91tFIQ9Ayi9B0Es7yJQq66JtyX?=
 =?us-ascii?Q?/dZoigJCmD8CcJ97MOuIozAsaAgXyflFsGCT4Jx7q7MXnZ5AbMVkzDGg42mr?=
 =?us-ascii?Q?OznohM6LqTDsru0p5qHpcpeQNg=3D?=
X-Microsoft-Antispam-Message-Info: rFufKv6swHrhYJ3IgN63qj/KEttKENqaty8CM/LrXsgK7vlQB+TKH2a5LWDX27SNUY+wDmec7Pw6qK0z67KfDspetqSinxc4hF/B6s+oD8yGnwkcmIvKiJlI+7FIy8sJqtyGSJXRw6GHobmtxU+MIZBzrJMrCX7KrZJinMJvHkdrTzY3D+HVaiJBDi+pE6F4lNRcopYGoHWP9Heowuq3uSeKVa509A0pRH1D3qrlfvZluYk9ctp83l9Jfi57kbTRZ2vaPKfL6tHjObPmRtuU9mDK3kMNWTbFZ+qj677lmOxvX1zi3tVxctQqvsIweeE65QnStLpiTDapv6wvU8V4JtrtmeyXgNC2Hohq7WJEbho=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:HNaDsjIX7o9hWPXQ2InWRK4seMVxBuKPlJSXxT/hDYPR85NEC/XxO01aNv1rw871nnaFXF8GDdO+Y5DE5SZtLiLEzNL9FpVzvlCNkChnEVNGqlWSEtgKTD3Y4fv7QVov95BcwpwOPrcSth+iwtixonGBZzrFGnWJ7ru8t2W+T5ZdzrL31OrM7gdZl4xs8rD4d7w5g5id3SY7fWaHqWqzOZ/no6tJFPpzHf0AZsVoHVTHwgAfjQzRW2wX8K1G0LcVvSuciwKXxwh1xQlP1x7F9aubJP6qD+Rdsw9imcqkgWsZzieLRkNLgSTwWtt/e/NjYK+iHuet0iRiz9XPW3p1rl4X/bZafxOnnmLzYmu1fvStNoA9EWaUkUByGjBSjvwDu3KoXtPEs6DDVRAGtRILrDnMMhadjzR7KAoOgNGTfZMN8uk+KqrJalIhqpYZyE6zWyraBbEmyXVfqimRsb1tLw==;5:7mGK7oLAmeFvuBM/u+exkn4hwpMe08VahAmjlrCLuv+A5pY9u4impWErvYRP37jNAZ9XGBPBwWfVo6Rn9K52IxV3DsW1EwnXYFAZnQTj+I3ehWP7bK39jIMDd1pAMs67IG6DvdvlO2GEJOola5IN2wXkvpyDD6CDbLtoARmHugE=;7:FMmb1PaIhh7bczH/01hrYcPChk1s2ooa42Z1AdB1lLMZ8zT4i6fwMZXI+IQh9RLekoa1yRfjbiArIIA87S4QZiBLqFFtipzXnfMVxQ5oa0CpjGH/DUXHyMEKJ2GOCqUcQcFrGd2CTjpunEyUSX7GsOLOouLcmrylDQAaybkPSQqTQHb1TNz2SG5BDVCb6MZP7aXoxo6NhGlEBgZP119HPTacUOGCY6Kfbu0JRhF96lAuRSsOfZeWI9c6eIZdHvK/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:VMhAl2E0iIj9Dw+dDdjB//j9etbi6PAhdE4Jr/wc6nd1nAmNpzx2QnVIl+x+E+KBF/zmOhXnkr0VgcUtqci7dXXDT+v+4mZqMsseiMaoFmAqKVKsAQyh0ChLUePNTaoFfTqCuuaFdWNyz52q+2SrhqPOIb7yzKqXUa29fL2hN64=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 18:01:27.9244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a521c10-fc15-4dc1-9807-08d5f64679de
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_08:,,
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

