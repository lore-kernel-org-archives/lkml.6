Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8662AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2186321581
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ij8AdDh3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kHI6ySmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2186321581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbeHBXXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:23:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49826 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732280AbeHBXWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:22:55 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LSxYj015349;
        Thu, 2 Aug 2018 14:29:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ccUkIiuy+r9fHc6FqtW+NV/batrBqZJEIjW+tLZ/ydU=;
 b=ij8AdDh3POYCWHGyZomlLyj486JAWIvRDaVKX9KGRi0Qw/rw2Q7/KWp+I8sgmDxhlnz4
 VojGNRC7S3k+id5vkvX/i8Itt5i9rW0fUTWb5gkR4hzuquC7kT9N3LsQ1EjmKr460PRG
 UL8frHTTz05CPYVUABRk/sC1Q0zGiYOyOVs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2km91w0510-12
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:29:37 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB15.TheFacebook.com (2620:10d:c081:35::27) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 2 Aug 2018 14:29:30 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccUkIiuy+r9fHc6FqtW+NV/batrBqZJEIjW+tLZ/ydU=;
 b=kHI6ySmb8tHgSYlwWG/GrSXJzNV3max5cGd4ZoRrtk+YYNVbYmSYCZBr1N4OhsqEgWlcg022kXFBF/9uPaeINiaCBDezLh5ushs07UC6nkR6a066N4BcmcTwNdulL+HdO7bLUqYe44ilFP/Z1TvINPXONTaXUpbXaUzdGiRzWdE=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:28:09 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 14/14] samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage
Date:   Thu, 2 Aug 2018 14:27:30 -0700
Message-ID: <20180802212730.18579-15-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180802212730.18579-1-guro@fb.com>
References: <20180802212730.18579-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:300:94::20) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9140d947-5dca-47a3-fb0c-08d5f8bed841
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:GZEeCKoXtEf6WJRB4SSDjeoEdM8/EVyVEqXB6GB7M4cnAuRsFaJEpY2gdS4lpvJkUkHasyulRR62BLuWqgjkqYSdyqGcD8X/DBGZC5LdQ46YFAKzaOGtsgVo8QFq8klhBStB75NnXZ8hRqvV4goFLNL4KCzHls68DYztyt/5HTfog5vTTb2ZMhEihMfdt8N7GMh13xgL5XeQ0A/0BECEcwdOBeh+2G/qguTuyAyaHINpjtCtUN6AGCtlvQDPPD7+;25:S0x51iU72MfoIW/0htp5fTEnWkZaaHQyJygIFCMsaTWtpXx8CoxW/EAZcgqz6EShvJ6jlwGZfSylCTI0SQsFMv4ZBab7eb+MhIp9iWPtr/ZqaXG5Ssrhh77Fv5p0joOu5C1TnvbKLn/eRDYEXkQ39LX+L1+I4GgPDtorzA17ckn8wMlxG20ZObDDeuovayC2V+4AzFkmqGtj6283KG5PH7pwRgk6GXuxkJ4TkD1sb9e/PhUjRAVTMDB4zxFndAsNVKRZBWDLboCfTc8hK4a4dYIwgN1azdVcTx3J0iU7Zk6pdcMsfOJvvuH2n+6c3EItx8k707fG3k/vUZlk+AwD8Q==;31:nP2SuvUi+rDxT8+/TKdZtdShuVBCFBOXl9LPo2cvQFeg1DDD1726CghDEEZE/ZO8NHO1TO39T2XAKQX8ReFDAMRt0j23uMsMMUkcnyAOumKCTj0/orzoOBgsEHx7Az5p6PYgO8dBRzQe+2LRSEuGWrrWsflkNyhiN3ChLHAr3AlJLMofWVdsl94zD+xSIRJVK71XkdWHCeH1XVgPtlXQU4V+CmRIMoOxUj9Kibqr+0I=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:Soq9fWYbgFCWeOCSDDqbXhsVo354dnw5zE9Ud2oCOQYMdRyrndBZnXfdGFfUaUQlappNospHcMNoYbMGXHjyIPIxbUeQy4vykBbdycL/G0To9RNfA81AbU6X8rLYWUMBLJKvE7RfxFtYujSiULYusisWjs5X/XNjAG3aWvpKs8xuPVN1vhbcb1nG32Drth51kwHDWgYu4zsXI5Tu8Oy2vWzBy8sXj4bvd76hrnTqBMBOASt1AqNvBq+IOTsKTwakbMDOfgcThlo0V3b+FkJTIGxF8bL3rWDuCY8xMOTwdcz30D9A7N+J7muPa5AMsC3zmHPYrv9nLQ8IDGYMB7G0sLAA4HvXCRd/bvuqlufzY4Y73EzMFbX9TXARiGVK3CV/HZ00AehXTD+2HkdQYfa0BjMT7Y/LaDOT+rUMhMqE/I+5nndUjHBpvyA2BfCGoCXi+iJRvC01fltoMe2jYT/AgLkxsgUOSU7exnynb9feNf+8VgNhxWijK8OijqwjyUPv;4:eYFHcF1zKxsfpSZS95/lkDZWKDqhXFEruK6VNPutaSJxk7mMBam77zALtgltnQ7I5PlgMhZyviLObnvrarU6qqHzNO+UkNT0/oQcG/FDABjuzplvGTcXso6eQO/92EfHreD7U1upLnnLIyKcXxNYkEjIzj+J4kUEyarMHf0A+I0OY/OTobBROTPAum/+IGiccY5nMsoP0xIVOnGWiyZOaKwv6wl5zv0oNOcfrh7RWP30bGzehi6C6f0Yn9r/claeQmpQDexZiB5FWa3sRG8/clEK+yLE8B4ariK2jDgb7TijLl8KinyUKN1lXhVmeIZJ
X-Microsoft-Antispam-PRVS: <BY2PR15MB01671803C2DDA46E4B458BB8BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(5024004)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(15760500003)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:gK8odwrWomdD7Ql1+Zs66G5qK1AXQguW6okkIsg8Z?=
 =?us-ascii?Q?YOnQpmu6ZmgeKf2Bqi3E5h/Eio1HqZTpEMvwQktahg4HroqPghaac6hSxAWe?=
 =?us-ascii?Q?Zmk581pSDSIOhnm+HyJYl4HJZaJnT10woAREHom7A963w/ltSAO3ewn8vwwZ?=
 =?us-ascii?Q?MvGHCVX8EuxG0Qn0Yn2Jh0Yk4pb84isIhkwQlAH9jiNIwwYSDb5o6x9YMlJh?=
 =?us-ascii?Q?yi5rYKJKiop7zbeXI8+tQUm2gjpT0lSCkI2mnTgvVaUKAxTSK4PV88iZghHX?=
 =?us-ascii?Q?BuDprY+fs95qynE8C9/aHRpjnhatuOw9yqIiTzlZQvBgIV1A/vPIXlaDvD5H?=
 =?us-ascii?Q?WYpaX1n8xYfPyYJGWEZUOlCQ/TTLoO3iyM/OIBpObDb11hnlrOQXpWDmdvFQ?=
 =?us-ascii?Q?GuywQnMTg77UYhqxFEsOq4g9NQtc26jU9JCiQ1ahUZar/Zpk9Py3TNPWUFda?=
 =?us-ascii?Q?7efH/v5dEJtWnrAiD4ABowqSjuFRfkU75Jh4j6xeLXEaEj1ZfzaJcUPiYiu1?=
 =?us-ascii?Q?eclZTEv9qHhKcAAsO/GNDny4P42bgqgofXQjxMW5KT/dZIn9CnqlOzPhzCyv?=
 =?us-ascii?Q?kjPEmzD4YIllvx5KtsNNPi2V0yPZi7FMQdpvXVM/mywAQKeBgbQk/ck5IQPj?=
 =?us-ascii?Q?4WI6tKEMkM1DmtkVXmQGR5+M530Cyy+OqtNG+UV2ASdwpJtCsNq7+bakyY/s?=
 =?us-ascii?Q?9j/LvglBCCi/fhLfRt2wJOb1efGosBabpla5HWba21aFKiaaxfQRlVg7O9YW?=
 =?us-ascii?Q?wtDdfjbGtUnkOHG9pOXrpWm53cDqpmQEnHFKTBeWsOKfQAA2P8N9lnfBRRTc?=
 =?us-ascii?Q?Iss7QfRH7asvNH8Zg+Mjk0kvCZV/lo0c1AC9jG7mp/Z9GeBcmk4yXzOVBEFX?=
 =?us-ascii?Q?O2L1QcfpReGGQaanb27EaVCr+vY4qaO+hFo7pC0CVP/SSnEoqNdqlduQrbVL?=
 =?us-ascii?Q?fv2bMQw6hHD9L4EknXPXdrjeNAL3Ct38sTndG7fc38JASQuLVVLeKzk0TOzd?=
 =?us-ascii?Q?shYRLijk+Q0TElckRWMtbZWCc4Bl4rvurwl1BgkfMEvxFbnzsPEMn6ajSRaZ?=
 =?us-ascii?Q?S72cXoMhc4C9LMYaO499trijDg+BGJBWHj18FnGIBKqkIjnQdF592l7FWL1h?=
 =?us-ascii?Q?l+GpVwLoTeN2WNtc4PO7icHPsCF1+rcxwMlyA6cqdEhFwNKgxLYn1wUDH5bZ?=
 =?us-ascii?Q?9RwRAGYcyi/BJaMe82PbsyQs2SzH+KWUF6a1J8ijWRQdmdtMpqFJBiCfImYe?=
 =?us-ascii?Q?1+tgJpT8XFQW5iQgyjredwi7swTD4KBMge6KYC32/mtxBWUlgblSbFiTze9n?=
 =?us-ascii?Q?b9hviSSpkfrrVCOYeIhKWlfgoH6vyRZsGtX0DQhP6zedB7u+SmmAXzGMcHrq?=
 =?us-ascii?Q?KJxEw=3D=3D?=
X-Microsoft-Antispam-Message-Info: dzYJ7KdRgBizS6K+ijTKPwGSGSlMqAf/LQrtWtJ1oW/8LPm9cKV3ksww/pD2NEMsifp8bvjhtGxE3U806klPlTukEWsN1E7dXqXsCIxIdQuq1PfkYIjYaMItUJ7NPNm2fJqxzIxVboTfaWA/mH3FRkzT6rZHoKPvtoF7a1CwF6JigZi5UZIQ/hDjCZ8xDyfD64uXjUQL2toumj0YPbEsFL9TFkqL9LPcqDVIdKsNdijWYaBXWqyEZySm+MksNLOdxCRC02G75Xnot9Ewp8pzGwqZOSt6Rxi3eYZn99CQsQ522PNkJwjdZZzqBMkHx4uJrWvWoXCzsAsi5hPJ7KAc5udmFT6l128YRN8lqemI0yg=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:Du+Dxizmx/5eYp3y17+C8Z0Xk9j9paY5+SGPjnZTBG6Ewbs900TVjmSh1V57GlH8jVFqd5aXP5be57IH0A6BAENHsEYJQeMtfMWkd0QM1PTvZILmKwvV4I3V6QNmqwZkDWO9t1aBn/rKnigF93zHF0dCaBA8IsiBOGAqPzLZB2HWXOxFbF8ZEd0JL6k+7nOrHNqwwIIRb1D30db3j6AXEb25MQo8qvM7NZmotgM8wr/kqAnf2jA9A7w6fEds2hBXymm8mZEtClIafwiCxuBIx1PoeyKTUytieCYLIFUYosCEML5Xx66t32gTGj1CpylPiJ+JEI69RWQ+9Y8OxxLZCBFtyb3uxyVs6Y5rXwYsYYPYrvwMS8M+pUByNQHHCHUFRGGo445PLRxbpkaTLiqbTCIXTQIKbeBjTfz5U7D7kN+HJdyYXDYt3QgqxALuge7TYoobDcjHQDtRwPX9h0nVtQ==;5:nbOid0nadscLGeO72XYATnAkUcXfOAjAFRNiQZgP8MMTo00swexnNJrft7FiLqcdD7lAIRLhH1QPkXeqyqF7H0a8eEkEovnZrLBcCrKo/i9NsL6LRw9z8WAsqp5nlBg5WS8oUfzQJPvxs2jqKb1jFNEj4t17Vp86HAZM9ZYDkn8=;7:GnBtdLw3iaH+pVk6bLJCeZDMLG7qYm7cj50+hXf1IWIk0FWNkvcPUu+g74h8hiRfjXBpczfk2sxhp0u10QED9cotklX3VPyWNW7QRr9I1hZx8D7DOJIYwuhK/0eZPsl0eZfNGknX+TDDPWKXolNcQx5PB+MQZkUW4U9vvrIp5UHYrbibWY6zZvQYXACHeMEfHF3hSzb/V08ad1SH2KPNcuoTDdPl8jXxHKY9IzMugip7SVTe9+WeIT2PN4Ws2muI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:LNToaar1PmHkXV/IRj75DT5XBYDaeBcEpnG/YLhvJCiYm7haUy0GoxJsD/U+JSyIzTlIygQKPpM9UwO7qcB31tV6xnot1V56i5m8CBom3KZdIdLi+B0+LyLtBi5IiaXrwrgriOz6eUA6uYjFfGUS+YBrYEGN3jNBz+ts1iYOT4w=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:28:09.1514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9140d947-5dca-47a3-fb0c-08d5f8bed841
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_cgrp2_attach test covers bpf cgroup attachment code well,
so let's re-use it for testing allocation/releasing of cgroup storage.

The extension is pretty straightforward: the bpf program will use
the cgroup storage to save the number of transmitted bytes.

Expected output:
  $ ./test_cgrp2_attach2
  Attached DROP prog. This ping in cgroup /foo should fail...
  ping: sendmsg: Operation not permitted
  Attached DROP prog. This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS prog. This ping in cgroup /foo/bar should pass...
  Detached PASS from /foo/bar while DROP is attached to /foo.
  This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS from /foo/bar and detached DROP from /foo.
  This ping in cgroup /foo/bar should pass...
  ### override:PASS
  ### multi:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 samples/bpf/test_cgrp2_attach2.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_attach2.c b/samples/bpf/test_cgrp2_attach2.c
index b453e6a161be..180f9d813bca 100644
--- a/samples/bpf/test_cgrp2_attach2.c
+++ b/samples/bpf/test_cgrp2_attach2.c
@@ -8,7 +8,8 @@
  *   information. The number of invocations of the program, which maps
  *   to the number of packets received, is stored to key 0. Key 1 is
  *   incremented on each iteration by the number of bytes stored in
- *   the skb.
+ *   the skb. The program also stores the number of received bytes
+ *   in the cgroup storage.
  *
  * - Attaches the new program to a cgroup using BPF_PROG_ATTACH
  *
@@ -21,12 +22,15 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <assert.h>
+#include <sys/resource.h>
+#include <sys/time.h>
 #include <unistd.h>
 
 #include <linux/bpf.h>
 #include <bpf/bpf.h>
 
 #include "bpf_insn.h"
+#include "bpf_rlimit.h"
 #include "cgroup_helpers.h"
 
 #define FOO		"/foo"
@@ -205,6 +209,8 @@ static int map_fd = -1;
 
 static int prog_load_cnt(int verdict, int val)
 {
+	int cgroup_storage_fd;
+
 	if (map_fd < 0)
 		map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 8, 1, 0);
 	if (map_fd < 0) {
@@ -212,6 +218,13 @@ static int prog_load_cnt(int verdict, int val)
 		return -1;
 	}
 
+	cgroup_storage_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
+				sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
+	if (cgroup_storage_fd < 0) {
+		printf("failed to create map '%s'\n", strerror(errno));
+		return -1;
+	}
+
 	struct bpf_insn prog[] = {
 		BPF_MOV32_IMM(BPF_REG_0, 0),
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
@@ -222,6 +235,11 @@ static int prog_load_cnt(int verdict, int val)
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = 1 */
 		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /* xadd r0 += r1 */
+		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
+		BPF_MOV64_IMM(BPF_REG_2, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+		BPF_MOV64_IMM(BPF_REG_1, val),
+		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_W, BPF_REG_0, BPF_REG_1, 0, 0),
 		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
 		BPF_EXIT_INSN(),
 	};
@@ -237,6 +255,7 @@ static int prog_load_cnt(int verdict, int val)
 		printf("Output from verifier:\n%s\n-------\n", bpf_log_buf);
 		return 0;
 	}
+	close(cgroup_storage_fd);
 	return ret;
 }
 
-- 
2.14.4

