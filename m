Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3758EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD4922B59
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Guhy0vf1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UH8u4wt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD4922B59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933105AbeGFV3v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:29:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39180 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932860AbeGFV3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:29:45 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66LSo3e020755;
        Fri, 6 Jul 2018 14:29:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=IBpEp0RFE6XJe9J2xqfKOq8EQ0vmVgq4uwnD4XQBDmA=;
 b=Guhy0vf1YEUQzNE48yijTZvtK5lxkKi5PjtmeeMAQnKijX3oddgXDvcXm4VvuA9gkXRq
 UGuzIzXfWi/9WGI1bNymO4PuL00VNOCcgCCUxYIrSmicjm1UeQauaQy0UkE/93HITKBM
 EYGNs7II0fvpg6TMlIr+idLVU9a+uod0I0Q= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k2cy58fr8-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Jul 2018 14:29:21 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 6 Jul 2018 17:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBpEp0RFE6XJe9J2xqfKOq8EQ0vmVgq4uwnD4XQBDmA=;
 b=UH8u4wt4BUuzW+sJ+7sSFkcxB5eW+gLT/on/VkuWjiK2u7TCBwAXVD+iPPD4iWpLXINiXViJ0LJY4SUDb0Gg5bVwMqaP82da5zhUvCOzlNOKs4Uc0sEoF4VXd+1N7aUUasvIKU0euMC4ElqIxVaXg/R0abs1LvV55XZYomwDrN4=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:3096) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Fri, 6 Jul
 2018 21:28:31 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Roman Gushchin <guro@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 1/3] bpftool: introduce cgroup tree command
Date:   Fri, 6 Jul 2018 14:28:14 -0700
Message-ID: <20180706212816.3760-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:3096]
X-ClientProxiedBy: MWHPR01CA0047.prod.exchangelabs.com (2603:10b6:300:101::33)
 To BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6b30aa3-c543-4d94-4c02-08d5e3876c89
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:4EkmaWzy983DlPBGfr2Pa3e7SRYUQvxRsfYcneujDgGap/XkVsklUjzkGTPtAnJaq2DeiQBBrwNyVHc8grGjn6WlZ1sLmialJ8KY0Lg3yG6X0Mts73hPB9dw1rKGSWyK0TB7znFrbA2jirEzHsoJMlI3rtPdv0LmDbWojq9v6a0SJmhs2NtGpg2dhQDkgDockP42qel8SRNpawO0CXyiF12FLyG3w8IZX+X7LWEmVCF9qQeGGY209Ne1Sok+XiUV;25:reXz2AOyILeknB9fHZLfTY5oJN/+dFGoPErcUFbFcyd70zA8SFPR2DvQ1xeXNqBnpBwdJiG6snYRyg1DQYbgLtkc/km/QfArur2EcSrnUTAKt7GB/OlFzPHXX/uXujOuhlgiXr61cP9t9ouOEwvajfs5ItdFenG9T7bXKdqxJJWza2Isq9VL1jpcnvjMwMvhFaY1CrlgoVDwc41yUbDQEQDXmIkNI3+GHbIp6is/AIXossE/E1ZsD2romSSBBUlE9NorV0nhUY5B5tJ3fP+EZdmGsEUOWSJjQ49hJNjXpT3sqrdGdxZKTv8u3Ma9vZdKjW6+2wre1ALeIT5hALdu5A==;31:p0RQrQLmk260h6YrdRHohLgPjsOjNRUOtAE/jXLtbw5zZzOgLfIU9sdKMhBzztugXM8/APc02II75Mcr8juS9TWeROEtdiBdyQSmhJABLPq5tp5FFaJO1QYqiwPRIHgifutl3wYI/D4VX7INy75+OjPaDijvwsYUXrL5ZIneD/oE4KyBI+cbDcagp/3yTD8u9gP9LPWcim1Ri58WgpEua6c9G5FjsCRNQG2js+0PgqU=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:GQxmQ8hIp9wkZ5OgYDwCh0+5v1ULPNyZPFCdB03pLJNDkFRqQoBWooD/0baANzRt/spA6jseyhBqfVS6CmclFYs/KuJJ0NbPTJ+IEfdcorOm6OgZGyBt7m6UP8RkTgldy3O9rJvctGzH/na8ptZsjo+j7QBcUsK4OEdawNqWB0TnsK/qJsNmllhn/Sz9vHDiY13mICIiJJgi+tw+nfV71OOk8B/mid2j9eJ2Lix8dBPzbuNbqd7RQjoFXixvboeGBEv7JV7aZprRr79a2W4FnaUFdjQFV8XwxXdxAvzXS8a8SmBvq07rtxLcP5trfmLSGpUf9vlQKe/bon8afiQNLuQDs3obTwWtS7FFfgXtNRFkRrmsEEbj+ijEt0ZPYbRIzchrpIQkx8gAeHAz21lvnuuFX0rzbmXXoS0PtaY7D5Ou/mapA3nLDeG6QtiYi3OxYjprDQNQYXUzoExxMZgLoCXSYZKLsNY/IvIAF7cZnZtfsM3X8oCUTFJni5h1cgAs;4:p+712m2eUjqcaVMeWhFVCStmi1435alqy8ZMebmZe2FqUbA+/u3ctCqD84XYBHRIFH8xfJnJr57Ioq7MvjsMhumI8v5Vf0hzsuEz6BeRC6qPxt/x/LfM9jpHJtl4G1mnnEAc2mItKI5K8aBIy8lVOU9ScFABucVo82nISxWs9jTIlFM2iq/xGyVgrzw8ie1VgBpVsYkRE87b7fTA8ceCftod6muJWAnhEBnWcMClg2U5Vpbv1D4WKQrI5FfPPyprGNdsRsECNlWlejlcSGgS5zPiOsul1pIdV8OMvjgdZMFHMePTMcSXlYcOlkhiDyLXLLeBzZo23EClN4NNGjf1KfFEVrivPsvYX2kWlNW9gOU=
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167D2540E8166167DFE1333BE470@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(81227570615382);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(105586002)(86362001)(2616005)(486006)(476003)(50226002)(8936002)(2906002)(7736002)(305945005)(81156014)(81166006)(2361001)(8676002)(316002)(69596002)(16586007)(68736007)(53416004)(54906003)(106356001)(36756003)(5660300001)(6916009)(6666003)(52396003)(51416003)(52116002)(6486002)(6506007)(386003)(46003)(14444005)(5024004)(186003)(97736004)(16526019)(47776003)(48376002)(50466002)(6512007)(6116002)(39060400002)(25786009)(4326008)(53936002)(1076002)(478600001)(2351001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:7awpoOmAJtgcvwLwYyNBVob08tG7J5dynPYnz77QP?=
 =?us-ascii?Q?JenC1rLFgnzOMCWFLv/Pxz5/fgh/910jI3pF9valwaXfuBLEtiwMxkftB70J?=
 =?us-ascii?Q?a21ugExU75LL2aN4OxW2tlwWE4zPFV/gs+h2oRu5sZKKzQSCwp1p/YLZ+14R?=
 =?us-ascii?Q?LS3jJWQRINEoAGu7Rf61cWR/he0tpWnLGFMjMPZTRpNT84YU1U6c0mPl8apU?=
 =?us-ascii?Q?3LUoZyucOC0TlnKAx2byRByahNKRspLtwdmxJa8BroJSkTZQZINyJ5CDzOIi?=
 =?us-ascii?Q?hLU2JBkKf1pn4jxnk65TdRgmnF+Ppu3TzraegfmbbUZwwxAbERwv2CknWXre?=
 =?us-ascii?Q?o6k1HdQ/x7+CuBpQDLPWbSfXmqyRNjbGJAHnVLrKYhkowFLm/F4qmZjml2bP?=
 =?us-ascii?Q?RKpZu9u+Q3jQTnkCQrr6zRW59bO+SCX5hZ9+jvDJ/xz/Fn/xWSZUcWB3tGJk?=
 =?us-ascii?Q?2v/kq2jucsSiglTXllV43uxTyXqU/QbMH7Qqt2Qxlns0CGG6H7Xj5JEn4mcS?=
 =?us-ascii?Q?JIoLcbpPCMqnTjj6uRw5sq4ofriGloMwdsWvGjFievtAoP1rTFFvOPEhG5eL?=
 =?us-ascii?Q?H6MSEscz/14U1knLoDBw1N6y+QPlWWWpPeRqSTgKWmOhVOdU2YJbUWy4NO+A?=
 =?us-ascii?Q?vzQ6Mqd52D02ABSgSMXdBIgI6jq0Frn/Jx064DYbUkbRUzfcFNC9EDFE6ymC?=
 =?us-ascii?Q?V9Bj6dgvqpwhUqDeV4sidbWUpbHZvQGmfhl4D9LYaBH5GSsp3FMOVXQ0snJP?=
 =?us-ascii?Q?EopCY88pOTyo3cldDVZwFaiGvADVgZ3axtJrA9qTj2BuFRxT+RI72O90aZg8?=
 =?us-ascii?Q?ZejkOPJw8pMYdUnk7krd4noiuTxdZbZtm3Ry7DejKLd0gROkAGjgGhQEF6Mz?=
 =?us-ascii?Q?aiwmXH5u9W3o7QAlGcpcgtaE8GrhSsW/gEz+EoXiTDaddaJjh/+nFNwh7rRy?=
 =?us-ascii?Q?kKsf7uKoHb7CBUMZiufoWslFIHRl9VbVxlotFwZCyodRrOV/dRYlxXOY5nPi?=
 =?us-ascii?Q?6Zzbr96AY/JGqJeUUmnIeHFsg2kHJhAAeoca0KkLcsiKNCFyZdOHWA9I6osY?=
 =?us-ascii?Q?WC95yoAcLauXxjvNNpQm+muWzeXJs/E4+SVjFAz/B0C1ynTAhirvXgK2SQq8?=
 =?us-ascii?Q?7mx19wWur/O6Y5cTsrDed2LayAdqfOUFhhS2UHIQF/U7/bXSwu6crxu3SHHz?=
 =?us-ascii?Q?0Fr39mCTQhAhvh3ZU+TZxEGWSxKHaNiEhuhvz0dpzkEJaUoU2nwFX4NfPQmT?=
 =?us-ascii?Q?XBtbYm4z6/g0ncJ8UMNvCojfzuXhkdTozSx5yDwVk0+cImTDGssNRkYa2R+C?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: ZkJwt+Bwel1hPeEFV4wimVb0MHhY5Hz6Ct60Y114sqscwllJa0SZniwLobVVpJ859aEi8JWl80gifnBA6hWXkWympxHbygG4OjO+agpjeN+wTC5u8bj+EcUI7A2B1ofUOF78drnsvIXuvLhisevMkAt0XFXpxlOerQawy2mpITUZa9qEC1mOikg8unRFv7VZaCu48R37BBz/DOXUQOl8t08X0DvMdEmf7bxFLP8uZKB+F6G5p6sVRftP6/B4tOiXoer+Kvwv9/+FUPMSYsyetIMCYE3EKgHLDLO5JWI19Ji2EGNQO7JHxHw0Xm6IFnGIsE1I9/zEjku2VlPg3x668i55mQ/Yd/wYyxLyjfFLXPE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:sa1OqOlmRltRiQi1jqAXDbj6qA/9d+bbDXITBSDfhqHkGOJgclvJur8K3lW50erhkUOwYPXZTWwAsZIqdrUzdkeAnWgo8hZlI9+gBFRJMvSsDBHZxRGszf0Xb4owaXAib6n0UKiiqI9T1zjs7EhJNqFhhfH1l5tYaElPnT/EXgXkxbaf4burWS27Zn5wDwM3P7Z9NpyDMHLit3n/GfqrNGime92URLJQS1bjOc8kLKElrSZvaj41f++Wm+8pC63/zPNMmQc1M+wGlMJFfxTi9Ps6io42fkpJ3LiMo0F0lvY2AjuThHaJyDGY1kmkqHW/6Vuz7O8gO93EtHU0V2o24L5pDsQjSzzB1dbqWJK35tLqrBwzbdJMzK8+GFOACigOW++SqgOzJ0csVM3H8jaIM3T3q9XFjy26aKFl4y0p4Aik1JDITH1M1+OQmQ+sGI3SbPEuaSMkVC7IvwE9lf9PSw==;5:yxzX8+9bEU2rFJWxywnBes0zsCaq4A81JKlrTo+noY2FVhNQ71fItd1STonun9l2Uq91genfa1qwoJYUt8FamFMYMucUvAIx804067dklLwvhgL1ul+0b926eM7e0JpoMu9GEdr+cjanWaMWInzBjQN1uPP/AbHpSglN+Ac27kA=;24:tczPzVcOp9V6CaxqYCgqhOV7/hIad2PZWMdTXwHs5P22EXNC/BIQrCkVGCSwwiDJASln5+tghE3wqnrZyXFqg4flZ65c53d08rT1jB3NNOM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;7:OAjuAWMqcEPtPyjvxnxQGJhaP/s8yIWcO3T2a3DDtqIxF0j14vh5fP6Hr30M+oPqCDQ9UJT6KairTgHtmyzlDUoGjkEEHHz/v3EA4jcVJqQy9mfGeb0P5OgpsjnPsqsKhckCP1qu8FINiR3pj8svWDx9qUNa7lYRtysb2Q1SVKFFvpe+2w/ANk3oP1LKaxXyQGqZ+Eu9BkxqfV10r56aKPKC76sZF9UlGla0LfgQhmA1dgRnI6g1m69/RZ8qX9QE;20:p/+5Ug4NF7ErZoivUXxkd6qrMurRsVoGffE2z/4SIFwHnhKoeEtTWCkts9yjnLKe6CFZhywgXOX3y4ERR4Wv+2ca8DtctRoTGf0UblP582qZdq7UJ+yXVMhkeZ6uknAuyYiERg7U3meiv05EnHTDUklQ6XzyzE9LnumqCyVBUqE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 21:28:31.7885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b30aa3-c543-4d94-4c02-08d5e3876c89
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a new bpftool command: cgroup tree.
The idea is to iterate over the whole cgroup tree and print
all attached programs.

I was debugging a bpf/systemd issue, and found, that there is
no simple way to listen all bpf programs attached to cgroups.
I did master something in bash, but after some time got tired of it,
and decided, that adding a dedicated bpftool command could be
a better idea.

So, here it is:
  $ sudo ./bpftool cgroup tree
  CgroupPath
  ID       AttachType      AttachFlags     Name
  /sys/fs/cgroup/system.slice/systemd-machined.service
      18       ingress
      17       egress
  /sys/fs/cgroup/system.slice/systemd-logind.service
      20       ingress
      19       egress
  /sys/fs/cgroup/system.slice/systemd-udevd.service
      16       ingress
      15       egress
  /sys/fs/cgroup/system.slice/systemd-journald.service
      14       ingress
      13       egress

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/cgroup.c | 170 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 16bee011e16c..ee7a9765c6b3 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -2,7 +2,12 @@
 // Copyright (C) 2017 Facebook
 // Author: Roman Gushchin <guro@fb.com>
 
+#define _XOPEN_SOURCE 500
+#include <errno.h>
 #include <fcntl.h>
+#include <ftw.h>
+#include <mntent.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/stat.h>
@@ -53,7 +58,8 @@ static enum bpf_attach_type parse_attach_type(const char *str)
 }
 
 static int show_bpf_prog(int id, const char *attach_type_str,
-			 const char *attach_flags_str)
+			 const char *attach_flags_str,
+			 int level)
 {
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
@@ -78,7 +84,8 @@ static int show_bpf_prog(int id, const char *attach_type_str,
 		jsonw_string_field(json_wtr, "name", info.name);
 		jsonw_end_object(json_wtr);
 	} else {
-		printf("%-8u %-15s %-15s %-15s\n", info.id,
+		printf("%s%-8u %-15s %-15s %-15s\n", level ? "    " : "",
+		       info.id,
 		       attach_type_str,
 		       attach_flags_str,
 		       info.name);
@@ -88,7 +95,20 @@ static int show_bpf_prog(int id, const char *attach_type_str,
 	return 0;
 }
 
-static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
+static int count_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
+{
+	__u32 prog_cnt = 0;
+	int ret;
+
+	ret = bpf_prog_query(cgroup_fd, type, 0, NULL, NULL, &prog_cnt);
+	if (ret)
+		return -1;
+
+	return prog_cnt;
+}
+
+static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
+				   int level)
 {
 	__u32 prog_ids[1024] = {0};
 	char *attach_flags_str;
@@ -123,7 +143,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
 
 	for (iter = 0; iter < prog_cnt; iter++)
 		show_bpf_prog(prog_ids[iter], attach_type_strings[type],
-			      attach_flags_str);
+			      attach_flags_str, level);
 
 	return 0;
 }
@@ -161,7 +181,7 @@ static int do_show(int argc, char **argv)
 		 * If we were able to get the show for at least one
 		 * attach type, let's return 0.
 		 */
-		if (show_attached_bpf_progs(cgroup_fd, type) == 0)
+		if (show_attached_bpf_progs(cgroup_fd, type, 0) == 0)
 			ret = 0;
 	}
 
@@ -173,6 +193,143 @@ static int do_show(int argc, char **argv)
 	return ret;
 }
 
+/*
+ * To distinguish nftw() errors and do_show_tree_fn() errors
+ * and avoid duplicating error messages, let's return -2
+ * from do_show_tree_fn() in case of error.
+ */
+#define NFTW_ERR		-1
+#define SHOW_TREE_FN_ERR	-2
+static int do_show_tree_fn(const char *fpath, const struct stat *sb,
+			   int typeflag, struct FTW *ftw)
+{
+	enum bpf_attach_type type;
+	bool skip = true;
+	int cgroup_fd;
+
+	if (typeflag != FTW_D)
+		return 0;
+
+	cgroup_fd = open(fpath, O_RDONLY);
+	if (cgroup_fd < 0) {
+		p_err("can't open cgroup %s: %s", fpath, strerror(errno));
+		return SHOW_TREE_FN_ERR;
+	}
+
+	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
+		int count = count_attached_bpf_progs(cgroup_fd, type);
+
+		if (count < 0 && errno != EINVAL) {
+			p_err("can't query bpf programs attached to %s: %s",
+			      fpath, strerror(errno));
+			close(cgroup_fd);
+			return SHOW_TREE_FN_ERR;
+		}
+		if (count > 0) {
+			skip = false;
+			break;
+		}
+	}
+
+	if (skip) {
+		close(cgroup_fd);
+		return 0;
+	}
+
+	if (json_output) {
+		jsonw_start_object(json_wtr);
+		jsonw_string_field(json_wtr, "cgroup", fpath);
+		jsonw_name(json_wtr, "programs");
+		jsonw_start_array(json_wtr);
+	} else {
+		printf("%s\n", fpath);
+	}
+
+	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++)
+		show_attached_bpf_progs(cgroup_fd, type, ftw->level);
+
+	if (json_output) {
+		jsonw_end_array(json_wtr);
+		jsonw_end_object(json_wtr);
+	}
+
+	close(cgroup_fd);
+
+	return 0;
+}
+
+static char *find_cgroup_root(void)
+{
+	struct mntent *mnt;
+	FILE *f;
+
+	f = fopen("/proc/mounts", "r");
+	if (f == NULL)
+		return NULL;
+
+	while ((mnt = getmntent(f))) {
+		if (strcmp(mnt->mnt_type, "cgroup2") == 0) {
+			fclose(f);
+			return strdup(mnt->mnt_dir);
+		}
+	}
+
+	fclose(f);
+	return NULL;
+}
+
+static int do_show_tree(int argc, char **argv)
+{
+	char *cgroup_root;
+	int ret;
+
+	switch (argc) {
+	case 0:
+		cgroup_root = find_cgroup_root();
+		if (!cgroup_root) {
+			p_err("cgroup v2 isn't mounted");
+			return -1;
+		}
+		break;
+	case 1:
+		cgroup_root = argv[0];
+		break;
+	default:
+		p_err("too many parameters for cgroup tree");
+		return -1;
+	}
+
+
+	if (json_output)
+		jsonw_start_array(json_wtr);
+	else
+		printf("%s\n"
+		       "%-8s %-15s %-15s %-15s\n",
+		       "CgroupPath",
+		       "ID", "AttachType", "AttachFlags", "Name");
+
+	switch (nftw(cgroup_root, do_show_tree_fn, 1024, FTW_MOUNT)) {
+	case NFTW_ERR:
+		p_err("can't iterate over %s: %s", cgroup_root,
+		      strerror(errno));
+		ret = -1;
+		break;
+	case SHOW_TREE_FN_ERR:
+		ret = -1;
+		break;
+	default:
+		ret = 0;
+	}
+
+	if (json_output)
+		jsonw_end_array(json_wtr);
+
+	if (argc == 0)
+		free(cgroup_root);
+
+	return ret;
+}
+
 static int do_attach(int argc, char **argv)
 {
 	enum bpf_attach_type attach_type;
@@ -289,6 +446,7 @@ static int do_help(int argc, char **argv)
 
 	fprintf(stderr,
 		"Usage: %s %s { show | list } CGROUP\n"
+		"       %s %s tree [CGROUP_ROOT]\n"
 		"       %s %s attach CGROUP ATTACH_TYPE PROG [ATTACH_FLAGS]\n"
 		"       %s %s detach CGROUP ATTACH_TYPE PROG\n"
 		"       %s %s help\n"
@@ -298,6 +456,7 @@ static int do_help(int argc, char **argv)
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
+		bin_name, argv[-2],
 		bin_name, argv[-2], bin_name, argv[-2],
 		bin_name, argv[-2], bin_name, argv[-2]);
 
@@ -307,6 +466,7 @@ static int do_help(int argc, char **argv)
 static const struct cmd cmds[] = {
 	{ "show",	do_show },
 	{ "list",	do_show },
+	{ "tree",       do_show_tree },
 	{ "attach",	do_attach },
 	{ "detach",	do_detach },
 	{ "help",	do_help },
-- 
2.14.4

