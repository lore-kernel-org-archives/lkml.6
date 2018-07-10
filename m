Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3D6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13E020881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WGDBnPlm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bZiOxF6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13E020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754604AbeGJCAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:00:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55464 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754523AbeGJB77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:59:59 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6A1urPa029313;
        Mon, 9 Jul 2018 18:59:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=U6xbkvbZTl4yse9PAQWmYOVP4pUztKPcpi3WuScW8G8=;
 b=WGDBnPlmVlvWjgJUAhM4rzTlCuhWgM+jUuy5EECwhkzPIpsrWTyELaZwPQQQYaqOjTJs
 2UWFOPdy5/PTkJkIf2jNUefWSLm61PZpRUgDhvE1VKV5Z3gBsZZIAB08QqZkKY8fQIWR
 g4XqSXDaxa7wswlQQZKbN41REyc534gYrCQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2k4f1q8kjd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 09 Jul 2018 18:59:36 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 9 Jul 2018 18:59:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6xbkvbZTl4yse9PAQWmYOVP4pUztKPcpi3WuScW8G8=;
 b=bZiOxF6B/STxOxWWQA7GvQHg8uV1M4/0nf8gpVJHntqK21tRD8z9JVTE7LjJQVMBPiWosT6kj7AhzjXw4W8GoRD4McBxIc61ENwxqonly/o7FSKGI11PJ2/o6WS78S171NZ2U0Xz8ZNkEFzKNgPpTnT7wBNEdUL4Qtay4aDAPM4=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:9f14) by
 SN1PR15MB0174.namprd15.prod.outlook.com (2a01:111:e400:58cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Tue, 10 Jul
 2018 01:59:31 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf] bpf: fix some bad __rcu annotations in bpf/core.c
Date:   Mon, 9 Jul 2018 18:59:15 -0700
Message-ID: <20180710015915.26358-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:9f14]
X-ClientProxiedBy: MWHPR1301CA0004.namprd13.prod.outlook.com
 (2603:10b6:301:29::17) To SN1PR15MB0174.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e18cd401-5889-467e-35b9-08d5e608c72c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0174;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0174;3:WrOmBlP0GjF8u3lJkMMQyxrUopkQra5I9H4RLJ1ySRIZ5j9k4kg/UaeGpCEMTjbbDnWdP0GzymnIcVt48wHr9m14sYRCcXK85Tv7bRq9iR76cQdYc7l+/8Z8EGOCLyOEWA2RhIgN1B57xm8jX8pJe1bC1yNx+P9xDxlAoRxJWj+E+3q6Cpd2fJhSZ0q6E3uhPoKhIKDOjfFZLjOWAu9Dk3tyBseaIDcnpEuCDggOQZUWbm0JZklxELbfip4y8FD4;25:7N46zaW2EkZSSOikRCvaz1gjoUaDlx8UvKV4mjr27m6jmN/QXD75NupsEFVHvbISmsQOB/o2BU90CgNXNdmz2Nk84qPovZa8NZRB9U4JAMccgHQWNx3hE/Ov6qwoheKD+qKWFfsVKBRbue2svv6wmD8vxWKFNfST5+pQG9CSmQYKmNM7wnZbetXWWo0xf6Ge2BhMjmLTtLJX8zYAcXr1RsvOa6p0WjBfzAnjjVdlF5fw3AyiMz7tAKUjAunyqbhjNylkD+bNLchKuNjFFjGCgnXtMvGH+KJa26YCxMC420dIy8Ra5n9zggJ9lk4/DnZociWu2TFWzpVYSL7g8hpP4Q==;31:kB6eUSonKRUue7WYSu0lbdtbCKmRkHClxZ0GJ0q3vJ+28AP16+6ktkJY86eUOVwmpZ0rM/FEHFcDA8EbWq4FmV2ZwN5aJaUhNl3i/JPkCvylxmmrs7rdT9/rQN0TlIGWY/pULbzKEhUMRgvJtHMSZym7JOYITwflrmtnsiGbHPdVjLzdkTr02aOXyZ/6d4yWpfWQr+IFeR/VIvnoDcO6b7oxsKMMSIc3uSFsf70QxGI=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0174:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0174;20:q/b0zW0BIrA+PjqdJFiwGhW7/aZ0oI7l9aHfE8wqwDXKTO/xtW+CASZvCVJOwnuietoq80UkDNT/+Tg575KVfZT18o1Mmh/QnidzS1SfaEXtAzaPfGzQ+ncpDH+OHias+YTHEuKcpp+kMLR9W0OlcM0uu4UQXMsuEMLQ5cgoC+DsDYt52h1yzR+O5Ik0FGd+lFBNd2p67SMXn29RSLu5mpuA5HSmPs+6y6NiD+oXosMlKxV4xRNDxB5a/o3O1NZU+fm7xAdm6SX5LghhlJmkFhdZN+KQDQRhcroFek/VSddZGckiQGx0LcV7VwaiwjYzcKR1LpQQVgcWZbLD9JPenJBzVRrdOSRAhBK/7QLSGRaU486VbOxbcpT2AMfyIauTzHI/q/DEnKbZXzN4LSzR3d14CkG8HDW/ry1ATLpmuX9CLDbtVdWvVm5gqm9YjyLV8Uh5/MyFMAc125SYXE+pivTPrJjJevcw0FXbeLQrqDRgieQjovNblDmHLJDA52Aa;4:nMNmlB54WjUa4BFouxfbFGq7kWhVQ9jrM5SLU2jN1t0cujV9YJkuIIF+jRuxCWQKYNgwspX6fbryS3+NyyOjKfcSQUBKfKhQsYJ1ZSa2ZuSXM9xfcPdg51g1PMhWPrLhnllezyNcpxH1+NvepYgsnYOn6mKT7hh3sIjSQRXiD6Bn8Yd0lWAUXr6aooFncnYgTuWhAgn7QiOFwO6DZidMt52LBr0BYHyskHGWRHkRZlcdF2CJSz3jlzKHDRXhcIBqFt7J4P/VbG8dIr3I8jzh9q2LOV/Bbc58ucV0aYna8W0TsRZ9bWHS/X3vWg2T5Sep
X-Microsoft-Antispam-PRVS: <SN1PR15MB017452E745A297151C825AF1BE5B0@SN1PR15MB0174.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0174;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0174;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(6116002)(54906003)(50466002)(2361001)(16526019)(48376002)(186003)(305945005)(5024004)(7736002)(1076002)(14444005)(106356001)(105586002)(6666003)(5660300001)(6916009)(53416004)(6506007)(478600001)(2351001)(81166006)(81156014)(47776003)(8676002)(16586007)(316002)(386003)(52116002)(6512007)(52396003)(36756003)(69596002)(25786009)(68736007)(2906002)(86362001)(486006)(6486002)(50226002)(575784001)(2616005)(476003)(53936002)(97736004)(46003)(4326008)(51416003)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0174;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0174;23:AfPXZwSD9ftacp2rXsbTR6uWOxKJkIPQLGQYq9qWk?=
 =?us-ascii?Q?T1Vp8ogFXaNPXkRaizOb+vcTKPI8yzLgJc1Wz1oXvFOy3wMWmLCLHuwipdKT?=
 =?us-ascii?Q?9Cwe48z5ENdqNMzeqXDvWsFHs6YLE2ahiX1/SxRV/ZoD6ZVgI+yZlThrtGLK?=
 =?us-ascii?Q?YxE3ZQN9LpK9/OG9rKUNITtIep3z5o7L3rSxDwkdUdkKu0EpJ8yzAfiTvGvO?=
 =?us-ascii?Q?4vSqRWOYsKulPUg9aSJO2OZ361fTQsCCPgPi/xEZrt7EDrjFXBSdd25SiqBC?=
 =?us-ascii?Q?MQWZsnZlQTi9THtg5d14PujPlghU+1aomGGaPT4Ffd3DSBNwsboWoYeFgMU9?=
 =?us-ascii?Q?QFuvNgL6wwGTV3REOIJ6AW3Tq2dmly4IsP+LdT3MtfO01CC2vCci1lzODaVq?=
 =?us-ascii?Q?DvGQqg5e83Rl8+N89qMdr8M4is8Xnt2wf+zW14GtZBgVqygC4m56iPN8KYqN?=
 =?us-ascii?Q?gI9DPcsXz3lF54fP64U4oSS59GDA2wgXmmPnz+tFW3XoChnMs+wspaANZLzi?=
 =?us-ascii?Q?aAxVy81kqEYppzXouM3QZE4aCJXtZVrPE1sGBSLdX0FP/Yt0DIsvwjLSjJCS?=
 =?us-ascii?Q?N6OGcVUO3ZRoUSQMmB+YZzaLRAmoIrlKOjGzZR6OGcSG9A7ZtQXiaQ8Gsjlj?=
 =?us-ascii?Q?BOFkEGZHASOyBMmjiBC7wka8QSu7XKO4IF1Wq/tVywHTk4cdkyG/XUrcVYqj?=
 =?us-ascii?Q?Q9ZSvG2EiIpmqhqIus+xsyKlw8fDV2BWWQVN5hnSLI5js78D+DybBAUSd392?=
 =?us-ascii?Q?/rdGXWgYQgMlUbZbaCPaMduVYYNK3j8kPMWVdvPeKhzTMhQP8hOxeCEr7Wii?=
 =?us-ascii?Q?29CppDjjr4UtpxKLJZJJ3EMNSY1zbmjGHehkCZkN5mZOYUSGLM6hd908exUb?=
 =?us-ascii?Q?nLSzrhAq3Cakrm9Zk/6ZeH04BNptvJXnPmcyOq0lp+dWJahD7E7op3NaoIzW?=
 =?us-ascii?Q?Z/uPjjiO6guV15DW8iJKwIEcJ88ZHffsEaYYkaVDlNS8/TuUfiFh23N4y7dd?=
 =?us-ascii?Q?dx14tTkVMKsX31gyjMlAXGpNX2F6Fyst6FsgmFz4CCWUYUI92CTGhMLBHfmJ?=
 =?us-ascii?Q?IZ5XmvDToCi/TNiOO9pdploG1dlUWMv3juv7Za6CMaHDGl5vYPcEHYfkkoP1?=
 =?us-ascii?Q?myjp/FOVS3sYl5gAY+KKSh1hfx3kcEW6FohKTPlFUSPoLanJZpiqcuotValn?=
 =?us-ascii?Q?eJpkbeT8Xd3sJ+/ZTUz5uP8wKl64Ra/38rj0pTCnv1eiQh/XzwUbSRZsLPd/?=
 =?us-ascii?Q?yfbLmMB+ySi46l/oyEmVp51nQm9uG4AO9AgdKjY?=
X-Microsoft-Antispam-Message-Info: PcCsec1jqMBer5Y5yBKur4Vmkvko8Ocjt3/GlkP+APvyqnNucH2EFsgqaa2tRU+6HnIH5lVqpoOgeSd7dEboUDqPVsy335yr40xBTkG3AhW899caPY8TdYHTC2Hwb5BMvGyuRFPzq/gJPIXxTyL5jO0Ks9rkKsRRyQfiykEYgefowDCuzPUDVSJCXAnNysND+oGmoxST2mW1aWb2L1f9lZi7DqQiWTU/8mFWbmiulaz6J+J4X32/s7GfqCeAuPlZjElGVqnbXgxFe9ZoHH4irPP/wqpbs34c41DRVAC+iqV7H28XQMnDnffE/3fM+G2lM4M/9DWu6blKBIqJSoVzSh9Vdy6ID29Sfm2Vpv/vzOM=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0174;6:EjXrps5GXmxKuqrrrImtp0J25hGxEIZ6fSOVKhzNviCjR59BlpxZI180kdDTLOicn9jZaiwB+Rmhsduxrn7HqfK9Wf199vnEvRgo9T66NLmKF2BUnNnDZ1dx5Ru6Vumvml6/4PB42jEREXKgxpQVc4da3xb95GwrK6b2RKt8xLTnpXOOC80HnyWrcWx8WNbEvyCUwsPceKMxFmZnv7JGSOFjj/i2mEQD+Kl+Dd5Y4symXW4hmZx5UT9ubESkp5ynkI7l1JN6VTzuPTf581wDyDvV1sYV4P/agCqBx3IgLsFLpF4G7u155cvHM9Yph+nQ/QB0hEuKHjXog8oh8e3hfR80uwdt3gPuGSHTFCupMkd9F9n4TI6yuPgwIeBRXTpSnFIaSykO6ppn9y6rJUs9EBIqs4qqqrwUyhVUoY9UtcGzY+F2H55Icd0OW0twlAferNHUSdXaUvbKuOLvnnOc2w==;5:pAaAmajZfLS/fnyGH3yApu1vBVdYbC/tTmB+HRL/F5I+3jDl8fVpoPUM3AkuWL6rpaWxgYl/IxxW3ltN81FWarVceP+kRIILauWv2wvu/74Fho53xE9HFUsxYKKeFR2fv6NEoMMYnW8UAdEO786K3HLsuDKltaYqWpQWegvg/n8=;24:W+Ov9SYXwkqWduVo3f4BfHbYgJAvMTkKyZdLbGAykHIGlEWY1rOFUT9yfd/luhcrR/D042ug2j3G3rzmtAxf2AGh59EQuAeGLGht1ZZuTyE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0174;7:x5KI+NfuHIK+aG8q7ViK81ZWUaT2iiRofW1YjwAt5U4/qWbkNU98iIO2TNqMK7/PE0xHq/gKoYW5nkC8DACIg7iBW2BZDo8Es+Kg53xX5R7hD0KfnjD3tiQjMGjjPVk6DySed46bMu720ElcMf1eDC4w840TaFci+l7UXurCMaj14OSamkThRYfUenMj0fzvtbxvFQrranvJz2+pFniEtYaZAsQ3FR8QwoP3XW0j4J5Gc84Y+XaGfWioB+C1pzAo;20:BZz7SR+gwFMVpGsyD20Pi6lAmrmTbp2tTHuFPly/SRP7QnmJPT+JzxKqACrp06ob17tFi68T3dr3wzI8Kuju1Mr1zKgbTttntLeTPOLqNXrtA7FpshpEZ7F9PIGlNUFoogDT3dRAZtrUECwmQhaud/4vfDLrLulNzlFsDWlkiV8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 01:59:31.1567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e18cd401-5889-467e-35b9-08d5e608c72c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0174
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse shows some "incorrect type" warnings in the bpf core code.

They are caused by bad __rcu annotations:
1) bpf_prog_array_alloc() returns an __rcu pointer, which isn't true.
   At that moment it's obviously an exclusive "owning" pointer,
   which is valid for an infinite amount of time, so __rcu is
   meaningless.
2) The progs local variable in compute_effective_progs should be
   marked as __bpf too, it's a local variable, not shared with anyone
   else at all. The real __rcu variable is array pointer, which should
   be assigned with rcu_assign_pointer.
3) __rcu progs argument of bpf_prog_array_free() should be casted
   to a simple pointer before calling kfree_rcu().
4) There is a missing rcu_dereference() annotation in
   bpf_prog_array_copy_to_user().
5) old_array __rcu pointer in bpf_prog_array_copy() is used as
   a "normal" non-__rcu pointer.

These changes remove the following sparse warnings:
kernel/bpf/core.c:1544:31: warning: incorrect type in return expression (different address spaces)
kernel/bpf/core.c:1544:31:    expected struct bpf_prog_array [noderef] <asn:4>*
kernel/bpf/core.c:1544:31:    got void *
kernel/bpf/core.c:1548:17: warning: incorrect type in return expression (different address spaces)
kernel/bpf/core.c:1548:17:    expected struct bpf_prog_array [noderef] <asn:4>*
kernel/bpf/core.c:1548:17:    got struct bpf_prog_array *<noident>
kernel/bpf/core.c:1556:9: warning: incorrect type in argument 1 (different address spaces)
kernel/bpf/core.c:1556:9:    expected struct callback_head *head
kernel/bpf/core.c:1556:9:    got struct callback_head [noderef] <asn:4>*<noident>
kernel/bpf/core.c:1629:34: warning: incorrect type in initializer (different address spaces)
kernel/bpf/core.c:1629:34:    expected struct bpf_prog **prog
kernel/bpf/core.c:1629:34:    got struct bpf_prog *[noderef] <asn:4>*<noident>
kernel/bpf/core.c:1653:31: warning: incorrect type in assignment (different address spaces)
kernel/bpf/core.c:1653:31:    expected struct bpf_prog **existing_prog
kernel/bpf/core.c:1653:31:    got struct bpf_prog *[noderef] <asn:4>*<noident>
kernel/bpf/core.c:1681:15: warning: incorrect type in assignment (different address spaces)
kernel/bpf/core.c:1681:15:    expected struct bpf_prog_array *array
kernel/bpf/core.c:1681:15:    got struct bpf_prog_array [noderef] <asn:4>*
kernel/bpf/core.c:1687:31: warning: incorrect type in assignment (different address spaces)
kernel/bpf/core.c:1687:31:    expected struct bpf_prog **[assigned] existing_prog
kernel/bpf/core.c:1687:31:    got struct bpf_prog *[noderef] <asn:4>*<noident>

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h |  2 +-
 kernel/bpf/cgroup.c |  7 +++----
 kernel/bpf/core.c   | 14 ++++++++------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8827e797ff97..943fb08d8287 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -352,7 +352,7 @@ struct bpf_prog_array {
 	struct bpf_prog *progs[0];
 };
 
-struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
+struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
 void bpf_prog_array_free(struct bpf_prog_array __rcu *progs);
 int bpf_prog_array_length(struct bpf_prog_array __rcu *progs);
 int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 3d83ee7df381..badabb0b435c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -95,7 +95,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				   enum bpf_attach_type type,
 				   struct bpf_prog_array __rcu **array)
 {
-	struct bpf_prog_array __rcu *progs;
+	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
 	struct cgroup *p = cgrp;
 	int cnt = 0;
@@ -120,13 +120,12 @@ static int compute_effective_progs(struct cgroup *cgrp,
 					    &p->bpf.progs[type], node) {
 				if (!pl->prog)
 					continue;
-				rcu_dereference_protected(progs, 1)->
-					progs[cnt++] = pl->prog;
+				progs->progs[cnt++] = pl->prog;
 			}
 		p = cgroup_parent(p);
 	} while (p);
 
-	*array = progs;
+	rcu_assign_pointer(*array, progs);
 	return 0;
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1e5625d46414..f6e5b207a0d7 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1538,7 +1538,7 @@ static struct {
 	.null_prog = NULL,
 };
 
-struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
+struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 {
 	if (prog_cnt)
 		return kzalloc(sizeof(struct bpf_prog_array) +
@@ -1550,10 +1550,11 @@ struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 
 void bpf_prog_array_free(struct bpf_prog_array __rcu *progs)
 {
-	if (!progs ||
-	    progs == (struct bpf_prog_array __rcu *)&empty_prog_array.hdr)
+	struct bpf_prog_array *array = rcu_access_pointer(progs);
+
+	if (!array || array == &empty_prog_array.hdr)
 		return;
-	kfree_rcu(progs, rcu);
+	kfree_rcu(array, rcu);
 }
 
 int bpf_prog_array_length(struct bpf_prog_array __rcu *progs)
@@ -1626,7 +1627,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
 				struct bpf_prog *old_prog)
 {
-	struct bpf_prog **prog = progs->progs;
+	struct bpf_prog **prog = rcu_dereference(progs)->progs;
 
 	for (; *prog; prog++)
 		if (*prog == old_prog) {
@@ -1635,11 +1636,12 @@ void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
 		}
 }
 
-int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
+int bpf_prog_array_copy(struct bpf_prog_array __rcu *__old_array,
 			struct bpf_prog *exclude_prog,
 			struct bpf_prog *include_prog,
 			struct bpf_prog_array **new_array)
 {
+	struct bpf_prog_array *old_array = rcu_access_pointer(__old_array);
 	int new_prog_cnt, carry_prog_cnt = 0;
 	struct bpf_prog **existing_prog;
 	struct bpf_prog_array *array;
-- 
2.14.4

