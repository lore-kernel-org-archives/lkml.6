Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CE0C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C0523FEA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rMS6bR2h";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Wm0EsDS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C0523FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932158AbeGEUxk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:53:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51726 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754363AbeGEUwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:45 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65Km7et005933;
        Thu, 5 Jul 2018 13:52:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=cKQG0CMEAsoJMedIhmEy7BnXo0h0UXd6qsQx+9xY5W0=;
 b=rMS6bR2h1gIxkdb0HVvgn1U4erSlQmvbWRU8PL2WYThEC2hCJKqGPFbYtnLWVS8Nraqm
 krJObC3Gsjdx1BFLbFbu4KdONRAS2AGe3XOVaVQhErPw4pLjdWHmnRv7GPA433W1z9Bu
 HZ+EE+/8I6rRJAncW55hdPyaNUN/xDeZ/7s= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k1pub8spk-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:23 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 16:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKQG0CMEAsoJMedIhmEy7BnXo0h0UXd6qsQx+9xY5W0=;
 b=Wm0EsDS3yNT5hSISiif0rAJOyo/hKsHfCQZP48aTgxyxWKyg1X9tFHBLM/aNgjpNe0kwlRSOmbi5gOPrvBtXHnspS77mqu/F62uA19JfZzUaisgMyTvHyeX4kA033F+rBvD+DkJpWgsyRW3x5zUwsjTkUDPBi0GEVuaOzil61lI=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:19 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 12/14] selftests/bpf: add verifier cgroup storage tests
Date:   Thu, 5 Jul 2018 13:51:37 -0700
Message-ID: <20180705205139.3462-13-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180705205139.3462-1-guro@fb.com>
References: <20180705205139.3462-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:9a3d]
X-ClientProxiedBy: MWHPR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:300:95::11) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ea5ee19-1d39-4b70-1c45-08d5e2b93351
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:mTg4bH1DvS/x+M9RVVW+l6m66o+EcXMj8I0ZKuVn3o8cYhwso0JKt7W1quXlJKWr0rXZar5cBAD8E8Rh8kSkovrb576UduPEY7gO91DuxRzNGz7EVFCbBsFKy5rOdw0d9a45vZYV0PTBl+kYBpsmAlx+vkFWWTIBNvk1yIt16UOY52+xO9Yjw208D1HoRp4kMjr5FAkO1SQzHRMXd2yhGR9wlI598+J326wGYzLza+OpEKqpjUwtkeSvS4bl0b4N;25:TUVYXu2yZD0ePARTRaiMEqLNXm9eARViLi1qhUcga1lY2t49FaHTwr89E8X87hUanyJxIPXFI2TSGwnTxUJe6uPzAxmdRMnXfJmeDORMtTmX+bJnf94Np4RXts9WJ+k6MzEyTRFwZbcOp4AFitj7UpbPRpU6qFsr5vuJpD5mZL14kPoSZnYExMzudkW9eL3LGuSz05iAH2nY+lCKzgnogifoIB/0eznyq3NKNbrNwdAX/zActpytypPejZ3M8dMWsNeF3mIpM4zVEi5fgNH1s4Xd4Su53t7sZ7kQal5mRrDpj1f/89yjSxmuM/pP5ED96YGoDQJ9wd9/pcJwi2TmZA==;31:T+eymdN1FIFtkg6b2ZGKmRyDzrMbnaKKXldc938EE3O6rRkm0eh4NZajh9YDu6etCKrycy99wiBLvHYiJ4IyUCZKS1x3cHYBU3ykf8HbzhWZBP5eCdxCXNWcnF+AF0dLnae/LjMIvxNSZyYZSaHjrm0kwLLZPBg7j3sZDhr+WHlMuHshAGNf3wzW93VCbBx1TF8jY3qC5q88nrrISUjmpZlUybnZgKp0EeA1WBJz6Rw=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:+eyNCKsdWGjuHUn72jwAQhpp7ZgIK/4aWiVYnHDTCjWmcVOkYQL7MYI+9UKNwUIrh1eNXHF5++Yd8QYqhodOEnTehOMs4HROIGkpfkRx7MrkE9hATc6mw+Rc6cI5ZM2xmQ7n4C0YyQKqXepoaRFWQlKSxIL2khebozg2pU5gA3ztiLH/SHwf1M+mVwzh0Gjpqz3RvdBydm8k986G63+gD4T17GC/JXdTjknB4ja0L4GPJDGwbxAsGrC6tTosffBoeziNICzBf1GFOC5Wpx9tmZ679CAklKIdtn0IyR4E0HAtsYIRZ5ZZihbIDiPeEtTj43uUV+1gaivDhpJlnxN6/WCtsU7ajl2dKqxaInFIRolx03i/6ZqVbq6rnrHsP9Zbhu5/K527fdZQiJjXimVcF0qIhvKX3ofnSjdFMriFeGkKkU3YdJDpV44V4yrMSXzls5WyC55+Ij7pMZ/45A/fJtN8OV/JK+w0CEyPE/29Nw3hXkbxJYSRj1FOuyu9t7UA;4:z0UpuPU+StwqoSiw0RvIaZKWMPtehbNoRJGstFr4l98w3hsCloo9GWfdCzUeZnlY6i0WB7FUPab0i5cDs0BQUWOnBI1U58+e3DOTsZVMugQyaor9KxsLf9lR5KkmzC6PnZO9Q9rKEd7JOdSfzlyThFsuzIXGVmBFvqZASCJjMUh5tnVvzHclIMH61nQZW30xDp+RXGgh0YB6faTjWGSwFyF7B5bGhIqyz0v6VZWRWVS1sMOWg2f9jh8cscTYHFDpom2dw2Vp4dl11fMAxCDxWDaP9hG12XZlt3Aldl0I2egxWSLli5r0UoPYHBJ/3Xpw
X-Microsoft-Antispam-PRVS: <BY2PR15MB01660B5F1DBD6292CDA1A53EBE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:pC4dnnLVl/5KpYE31C/SP/KIagf1aCspldQkZVrIi?=
 =?us-ascii?Q?1ZkLcm41zT7lfZ4rI6p14gtNsUoZbj4ZWZ1NY2XxZX9MGK/Im9j5ANPX3QxC?=
 =?us-ascii?Q?MSoPDEA4ldEmBtW3Rf/1GDKVXzdbSp2bODZtWDKf7X5y/i3M8+z0eUWm64wh?=
 =?us-ascii?Q?FlLSTMHken64npkJHUiVTltRKm594MRhNsOp7SQcnww1QAu1QqD+iSeMUME9?=
 =?us-ascii?Q?pVIDaHJ+6QS+h66HR9yhaq85dNOVZBb6xIScXEE54Z5D5BEFq/80t7FV4+CV?=
 =?us-ascii?Q?KFvbJMdnEgux4DY+JcVoERPw1TCCjc6Gg1/QJ9ieB7uTLFZ2dMF8E/nA/maj?=
 =?us-ascii?Q?HLoQOy0A/3LdHOoqa2TFddgcXZVqAmtimP65rk7hkT/jgGTWwEbNpVDuds86?=
 =?us-ascii?Q?fEVmwhFOYaIrSF+kohb87E0hZGg5QmoDSvS7D8tMFHZuRLrxDVVltBGVFkZm?=
 =?us-ascii?Q?mNAfrE++MZXlwvgQeNZlS9QEAU2vg89ykut1TShgsXxfil6r7Adl514NAGuc?=
 =?us-ascii?Q?fPJEyN4B6cY8//AavcR/vTEn1JyWSnKvLMB78OqQPE3e1NaXu0w/YnXprzEH?=
 =?us-ascii?Q?fyXZ9ciCppsgBWF7tX/b9qqSlWQMEzo1k1/AkYPemWsXKV2RwaEWg7/CeIuJ?=
 =?us-ascii?Q?6NeJcg3inj6WBtqvqUAWqG7H6r3BL3QIhviwdvXGiSS2QCSaI1chTzzKbpsN?=
 =?us-ascii?Q?Y6fbkUVzenS6kzEvpThaPNHqejWH7vqLc3A6u8B9TMGiR7d17i0G6A3ZAyeQ?=
 =?us-ascii?Q?YP9QusDZMxMrrtiRvYlWULscflD67wE1HvACvUD94vUCoO1KmHMZq3smqt1c?=
 =?us-ascii?Q?W8Qq50kj4+TG8GCCKaA6BIMllGHj29ePRVb8pRsSdtKMmA+vYt3c3g1KKo55?=
 =?us-ascii?Q?8jvm+m8jwesXH2CPuL1e5lyk7cZgt6SNhCA2XnrzfnVqvcFtqXZhs/W+xoCJ?=
 =?us-ascii?Q?P/odJNldAmvxYnGrQEqXXEDjdG2aNuRWvWvXIzWlK+lhQEgGoPU8SZzYh5tG?=
 =?us-ascii?Q?X+1/4cU2RmFOTLn8kl5z9yYFcvnuAdYkM6w1sj1inGYPE+opSehvOc2ZF3xm?=
 =?us-ascii?Q?4M3P418AowkYs+puvTXHmtuTAyPqB6dY5ts2LgZy6GGDaDi7Z0hl5WTMOAhs?=
 =?us-ascii?Q?1TxVU8wkrnBrz8vXFRuGFjVJcejlp/aNA4NvCYa2qGvFawTfNNjpEsJy2QDc?=
 =?us-ascii?Q?Wx67FsbNjuQ2k7gk4JUGRudvEXKeIohFH0WTDN60yUOZgyHUDiCLiW88ZnMz?=
 =?us-ascii?Q?/pmNma4mrEciqBcTjvDT1PbjkQNfwVIW0PYCnX/+nluz8ur/BnMrZcEr+6Jl?=
 =?us-ascii?Q?m9v9xe+2oWhpv4FLuq8n0E=3D?=
X-Microsoft-Antispam-Message-Info: ivHyLLt+mz+ctVNcUIO3yoMYTcv/U5lREYcvTzlEsWjVlojvHeyVRCZ95QS7n6cJTHcmHLnmp/HN/ZF/XgJoeYcDFYiCKxdmVzzLQ3bwt2Dg3f9DA08dvIOM0K1OSUPGrmOWgQDyx3VmJ++mtQBzPTOKYWDO4xHd4Aj2eC7TN3mvQ7wcARJ/Yf6GTPsf//0nYEahQ3K4gDUWsEMvvTLpiQ/iKR79HtBLgWsLsdZfbAonO0EC0z11Gd3YiSkL/IDbJ3FmqgvpPBwybdfI2nsHQ78tO0i3b2n6qQsZO5Mu5KUXENHMrufVTp6BoRqyh+hLYz20Y7fuFT9CodAV6mBTHX34caSSDzqCeZzapyCwyS4=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:AZH5MmyinwWwx0t8C5zHtjYYvONKrhDx5Iq/3gcK/6Cjk8IAnO2iR+kPGCQL5Fy3YCtWo5qEHYqhAz4gWMhdQjYCy6wZile5zcc1glqjHqh0/NMV3V+y+zOQkiz8gomO6XadBHVOdRyQpr3A031FDrz9+bfIgA6AaZL5kPVFJi8yKfJlvCKKKKhh6M82oDxb5oLmt++An/QHlg299T4zAHuc8a7qdLC7uOi1uRCzfp+4cYBci43KxAKUNJfi9CWLbIRCFz9ZjFeiFBYIxW//OBAhUPcscXUm8URoZgFU2ylbGoohQ5O+/FYBkhvoFckPrdUoOshlyuEEQGBgpJU/Fg7IIOfo7mTcczWR/2Vm/HVGZpYc89iY94xwGrrEGBI56h7yT/QzJazHqodwJXnCoi7TnCQmybT7XdRvDNvwMjMcnqGKy7cpvWd6P9pZGU1dF2/G1noFMPqA23ttwl7RhQ==;5:n7NXAfTOHVzxPVmMuzSWOwj3akwDCKQ6UtNYLGPhIvZUgmseAI7Kkx3k2C98uNbiXbwuQ4mjtdCP+OPV/9H1iTyGLPQNI6qASVpNY/qJXDSo27gjJXKd2lhZuWp8P+7q4rXl2/l+3An9y1LrQHePtx+bUiHbc9JNokywtIX5vGM=;24:omkD6nz4atU6/FfHNEm0uRE2X/CVYfSw1E8dOIF8nnGE1c1lvk++kFTgmvVHtu1Fol3MsEPs6rf//bfJDm5j5OkkYz0Wk6V1M7R9c3aC08c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:thNwrqvk+Ec1+v7DSRtuARPHSdHwN+C1VXfXDAcz3XQOzJnubj4ecQtr9PED+p0uuYDA2aAD3JuvZhBGFeQ/szbB8cde+ghqHjI7kxWV3+3GUm1BjhrI12DGo+7Dogrm4w+jDB4sc0zeHZLh3VlTT4TWTuqznwD5bjjeXPfz79aUqu3TtCe/G39sfLMA2n/MiXKWqqbNz+Y/r37hyY6p04OwcEEymH00Mk7SFZo7mTQUU3A29PAaTk/Dp8C4t1iv;20:s6xvQYqFKHp5lYw33gmnQASDKw9wBP3CPAdipGU8mPlQy/5N6G55SGoNb206Gyf7AnYOSgvEDRsSQYcMrik81o8BLhOqRLqEvrp3mBzd6ZBx1w3O8zI3hQ8IGy963kMHHrayX2jd5J49iOLR1vs9giVqNUdVmatBnoGMIg+3pAY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:19.4858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea5ee19-1d39-4b70-1c45-08d5e2b93351
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following verifier tests to cover the cgroup storage
functionality:
1) valid access to the cgroup storage
2) invalid access: use regular hashmap instead of cgroup storage map
3) invalid access: use invalid map fd
4) invalid access: try access memory after the cgroup storage
5) invalid access: try access memory before the cgroup storage
6) invalid access: call get_local_storage() with non-zero flags

For tests 2)-6) check returned error strings.

Expected output:
  $ ./test_verifier
  #0/u add+sub+mul OK
  #0/p add+sub+mul OK
  #1/u DIV32 by 0, zero check 1 OK
  ...
  #280/p valid cgroup storage access OK
  #281/p invalid cgroup storage access 1 OK
  #282/p invalid cgroup storage access 2 OK
  #283/p invalid per-cgroup storage access 3 OK
  #284/p invalid cgroup storage access 4 OK
  #285/p invalid cgroup storage access 5 OK
  ...
  #649/p pass modified ctx pointer to helper, 2 OK
  #650/p pass modified ctx pointer to helper, 3 OK
  Summary: 901 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h   |   2 +
 tools/testing/selftests/bpf/test_verifier.c | 123 +++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index f2f28b6c8915..ccd959fd940e 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -133,6 +133,8 @@ static int (*bpf_rc_keydown)(void *ctx, unsigned int protocol,
 	(void *) BPF_FUNC_rc_keydown;
 static unsigned long long (*bpf_get_current_cgroup_id)(void) =
 	(void *) BPF_FUNC_get_current_cgroup_id;
+static void *(*bpf_get_local_storage)(void *map, unsigned long long flags) =
+	(void *) BPF_FUNC_get_local_storage;
 
 /* llvm builtin functions that eBPF C program may use to
  * emit BPF_LD_ABS and BPF_LD_IND instructions
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 2ecd27b670d7..7016fb2964a1 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -50,7 +50,7 @@
 
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	7
+#define MAX_NR_MAPS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
 
@@ -70,6 +70,7 @@ struct bpf_test {
 	int fixup_prog1[MAX_FIXUPS];
 	int fixup_prog2[MAX_FIXUPS];
 	int fixup_map_in_map[MAX_FIXUPS];
+	int fixup_cgroup_storage[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval;
@@ -4630,6 +4631,104 @@ static struct bpf_test tests[] = {
 		.result = REJECT,
 		.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 	},
+	{
+		"valid cgroup storage access",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = ACCEPT,
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 1",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_map1 = { 1 },
+		.result = REJECT,
+		.errstr = "cannot pass map_type 1 into func bpf_get_local_storage",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 2",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 1),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.result = REJECT,
+		.errstr = "fd 1 is not pointing to valid bpf_map",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cgroup storage access 3",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 256),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "invalid access to map value, value_size=64 off=256 size=4",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 4",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, -2),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "invalid access to map value, value_size=64 off=-2 size=4",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid cgroup storage access 5",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_2, 7),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage = { 1 },
+		.result = REJECT,
+		.errstr = "get_local_storage() doesn't support non-zero flags",
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	},
 	{
 		"multiple registers share map_lookup_elem result",
 		.insns = {
@@ -12418,6 +12517,19 @@ static int create_map_in_map(void)
 	return outer_map_fd;
 }
 
+static int create_cgroup_storage(void)
+{
+	int fd;
+
+	fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
+			    sizeof(struct bpf_cgroup_storage_key),
+			    TEST_DATA_LEN, 0, 0);
+	if (fd < 0)
+		printf("Failed to create array '%s'!\n", strerror(errno));
+
+	return fd;
+}
+
 static char bpf_vlog[UINT_MAX >> 8];
 
 static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
@@ -12430,6 +12542,7 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 	int *fixup_prog1 = test->fixup_prog1;
 	int *fixup_prog2 = test->fixup_prog2;
 	int *fixup_map_in_map = test->fixup_map_in_map;
+	int *fixup_cgroup_storage = test->fixup_cgroup_storage;
 
 	if (test->fill_helper)
 		test->fill_helper(test);
@@ -12497,6 +12610,14 @@ static void do_test_fixup(struct bpf_test *test, struct bpf_insn *prog,
 			fixup_map_in_map++;
 		} while (*fixup_map_in_map);
 	}
+
+	if (*fixup_cgroup_storage) {
+		map_fds[7] = create_cgroup_storage();
+		do {
+			prog[*fixup_cgroup_storage].imm = map_fds[7];
+			fixup_cgroup_storage++;
+		} while (*fixup_cgroup_storage);
+	}
 }
 
 static void do_test_single(struct bpf_test *test, bool unpriv,
-- 
2.14.4

