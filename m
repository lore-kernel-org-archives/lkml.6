Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85871C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B7621571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="itCAWAc7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bnAnW+Ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B7621571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbeHBXWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:22:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59144 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727260AbeHBXVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:21:24 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LROUZ012185;
        Thu, 2 Aug 2018 14:28:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=xDVNSCZsAkPVeZmd9Qg8VSg2K4ImaXA2OktwX6VKhCE=;
 b=itCAWAc71equ3T1q5DFeSAe1kAPEwtlFRlg/evndUztSimqU+HoMVfvUA2mheiD550/A
 3f/YeXX9DejWRqlPyf9VnwyuUe11eYS1idTJUNoJCPGTbzpJUz6lBuMPzDT4Ob41OWaV
 8fhWOzy3/UCsnDipIyAb4rfPWXJtY0Ki8/4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2km6jy8nt5-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:28:05 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDVNSCZsAkPVeZmd9Qg8VSg2K4ImaXA2OktwX6VKhCE=;
 b=bnAnW+Ru7cPZSy3bbS5CwLwSAnRmLZFGeVToOUiPEQB6bHkKEpKLFx/cmcDa6Epyll26v/4Iehpb3Y7osmqKMzIRY6cBU0xI2qyZLblIfLQDrNEejuwLvylNzbeJBhallUXJM3rhscuIjaBgFJHgt2hQGz8yaqVAJwg3/eKxOaw=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:27:54 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 02/14] bpf: introduce cgroup storage maps
Date:   Thu, 2 Aug 2018 14:27:18 -0700
Message-ID: <20180802212730.18579-3-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 03f7840e-33e9-473e-5bc7-08d5f8becf5c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:NxeGGlAMJ66IumHeEIvxbr78F1aFUmE63q+nFok+d25t5fCnjbmZfpOnJU1BYAKIz8QzouLGtBb11wq98ycUx4bDCYcF7TLrVwo/rRzl2hFJE052KJzbeAlkZ53PdOktQJIYnuXzn0175MGSCCjrYgjGdF6JKL5yh968SAw2VdMMRQr7EHLqZTXZIVfT7nwM25UZ1Lne1tEjvVpOFDH9mGYIzS9UQ2i+O3GYv9bu8DQVGHFP4+LALRSDJ+UT25sr;25:fUuammQTH8mUQ2+MBo4PT9tqyCgI67mv46m6xUahphn9LMzBe6fbMW3Up2z6APOTfT5GE6PYe3m06lX8c2fPVSGTnYPNUj/buj3hXjHFktYA+5RerD4c2+3++t5JsYl5sm6czsZUygA0zoTvuJyJCvqsedfG30TbTSXQGE242i82Ypg8MWRXD75Z9ZSWC1+NKj4cks7P2kSc+0N0jaZR72ZQY6FcIMOVyY4s443WMGnsZAOAeuEfhRKeYMbg0I7sR1A2/MUyLtLEsiCSxm2KhZIOoM0866r6hTYulZM6LjSLhtIaRR+CcgWW84fCPBWTg4DIuZgqIcfa6M+B+KcXaA==;31:aSEr9Tq1/ob0EfZ8fQIJNZ2GAiFBj0aTquHv7gdrT8tiArYBu9t8S+GZ6oBt5iWzN7PQLjRSy2DvB+KvtTcMztddNvbp1fllqZ0nsfYDs+Ymt0+IOxtS3zTuFHHXQzT9VKkF17zepkRU23xEnAM1UzLFnzcNhN0Yv7ZKECWPs1tTmssDpX8HRBS/dDy89xsT0ugNcxuUhCxHkAKadRTbW5Z84J7Kwvrut6hpRF1pLZ4=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:gRNPnJK7p9OQvH3oBNuzwzKoPgYv/jmWJmhG0Ns84fod60PLvVn+wnSKGIwH3HgKXx/Ohori9JHoCI7sRpn9uWRtrB/RrRhyu+T3MD0Gzck7p9MGHeQYiOUJ5V0sWxgghD6KBUJJE5XFSoZSU9BL7Xok3v+Z47C2SImMeUCj8WJQmwtzY7yiTouCsmDGHyUanjNDs5vfcilZTDC1gSrjg8/GSOFvqUi3sQeYgHKxj42XQWmOr6s7Ntl46D2gOpUPLuDi5DfX+OZX7tXz9viaWZg2gyi42aMTROMzswfYNz58HSpscUOH4mOAILnGpjTp+iUzGhaMzPNE2A9AHFo6F8Dpt9gGvWzT/WveiSTQxlhvn2SjBmH9ACMEpRdN++QhB2OrWm8bBWEis3/c9NyphvYByI9OBCtjPQR5CqrPgCv9figZDt22sfrEUJMtqjE0VhS1oOcH9ve87OrDf/IyVA0p9WeDwIv+m43OC3P1YfjWf/Oqh4c5kZQzWjNIyr8d;4:EJcxB3oxj0m5T6i9MFwhqCTCXgkrfxgJgVC2X19HvYo1BfEICSI73lJM6FV6ouE4pkaAUI9nHb6s/zIBBnbEDtGCt3eg3kIw8gNBGXS1gqH+6I8WGOX4Zm2UkvB65QMwgJpcBk/KCzc4xIY/2W4zyMPbE0p5dDkfr3qwBr6ev9b0HSMdx6ESaMJvzrP7dNzUGnT9eSYOCZ22YpoamBxvPl2qesrHr/Q+VVxquuWXtJQJyPqNj2+YbdMb/BTe4VvVMqJh2f0EZ8OboDIjXtofLrVJhgzU9x3VkZFEphNPdF6PHBW9Q827aZI6rMhafwP45dS/1eLCsDqq6RIx/S8oQQ==
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167D3301256C261B61AEE19BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(5024004)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(575784001)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:XkcvAgoohkj2Bi9CIEEHG+n/s7HVZ7NF+isin9Pj2?=
 =?us-ascii?Q?u1SPY8kDru7KtftN033S+AHbTOWt7uJf8zFCuZ3MI3diAprxTz0oFyZrr/We?=
 =?us-ascii?Q?yim8LnTeYgbGKafx1gK+hGA4SnTC9MOZ4KjbiqDgYYGIpa4TycPchssxPGMB?=
 =?us-ascii?Q?grn9AKFmTWlsZamHg8cUm5vQ6aGwpCIQpZGHrofcShdXp821Buogb2ux1QOn?=
 =?us-ascii?Q?1e/uKaWgLqnXHSH704D2P7KlGWvLgwGRakhyRkO4X90A2K/aRVXUHjBQm4tO?=
 =?us-ascii?Q?Cb7AscqmzCAGevzOfErMnKulACsJSQ99Eq9W+NculeYI8/KWsU4pcgUWwSkR?=
 =?us-ascii?Q?rZZ1dr9aV7hGa3D7NIcSS7pVrrlc15OVzABJoXKZsei9+yYRbhh5C3AzwLnf?=
 =?us-ascii?Q?jv3BO7swi7ipc47orUJjhDXjUqKs/bHC/HyEsDfepUYiypMCbM5fkj5KLWIQ?=
 =?us-ascii?Q?JoxGVBX3nsfjDSmKSdMg224lfIQHJ31Ih2+Iqm59dicNP2YGhQobcj0hPhV4?=
 =?us-ascii?Q?Jq1DTN0Ghh0WvxkiyN6i5V5ZEs5XvHbAmlligJ6VVZc3D2XWaP4AIbG2l+Fb?=
 =?us-ascii?Q?s0Ajr/UdEJlT3Dwkc74dSQgPiInl3BtlU7yF/ibgD5LwE9ieIp2J7pEq8Hd5?=
 =?us-ascii?Q?w7rWAk6n85JwBYWHfGNmq2agDelnO+drZ9eJrYHpX7RL3/gfWVdm0H5dGcB0?=
 =?us-ascii?Q?LruRc/D66mC5bU7gKXyhAo5/BUR3G+8NYkQrqBgfm4yJU2BwopgLCMxbjzBg?=
 =?us-ascii?Q?HxkUAUVvTFR8AXz2baex6PQFZvVdgIskvPHwkYYCp+SkIGBxo9YBSXeRuEEb?=
 =?us-ascii?Q?iTg0eDidtRH2y9aB19u5MYlCLdlA0MU/ew4/iqsUpxjDadqIfNQeWfVDGq6F?=
 =?us-ascii?Q?Y9iIOregiRmMf2Jfe2gl3H0uq7ufMpsw14fX749B5c5GK3TqSx7kVZ7IQ4q9?=
 =?us-ascii?Q?P7F0yH+gRpdthXpDYksBY/Vz4tvJseJpHHV4T1EBmEYmtZ+U5pPQPFljR4vz?=
 =?us-ascii?Q?nOkiz8v6wS3u+NrQID1NCsbcDfYxVjybd6qpavkczfkzZVkgGgGCs3pl+xul?=
 =?us-ascii?Q?TeDZWRcVoKOEoOm5ga+1Xp42ojZIu9kgoCRK0JoSf1wTTKZBb6DgI9MySftp?=
 =?us-ascii?Q?9B6KojuqhkDy1Z1f/H2ynA/GYXHDfdjCFfqTkrrH6ToE31XpbQtNR0J0Pef1?=
 =?us-ascii?Q?LHaOZhNSTNIPdG/nxeEqM1nLLjtJTPvfzQVEfZSquJ7jO5HCHIvz60YDJeCU?=
 =?us-ascii?Q?+47y8vw3gaSFCB9IXEA36GDGxKamLroXeZv6piLeaQd3HeR0wGFzXh8CfjMJ?=
 =?us-ascii?Q?uyTTbsjYWj6OZEByh0SRY4jo4TkJijKFbZ+Y3eNsRL2?=
X-Microsoft-Antispam-Message-Info: +quzTIwHVNto5NP2sgROskKyY4f3EJjmTWPORRE+KXqy3z6B7F02pOYMEtADezDhqcuhOFVGeJ19pLp0FzZWcIPfI+0xf5yG7gaxiMvnZxPHqyBeu0gw7cSCTpM3A9SmmlfggAjDqzxynzHATqZGd+h64N64i8+Wu+iaC4RjeK/o5Y/Bdn7gnKD//nsYdhrTCQ/cFllWCAz1J2nqhP6vubmYD+ivikWuoxJ5U6N/hSJCyJBPuAMo4eYrYyLaR9WHXW3fLPS35q8PjpZQACRmGIe+/f39l0kAk9T8SBN2gbSBlLGTVCoJVEfNknk6YAP1hTkrQ/VpC3U+MeoHxYsUI76aJE6h1nIfcU5xVwC4Vhk=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:s+d51Z4YNcQ6yiaSSHHnRBbyczZYE273awfeMdzT4VfE9IrfYTubWx3rJy9bJ9dtw6r1iWv8YFz5AMhX31JzVBby6/evuEU6FBGdmvJnT4VMckyXBugPTqLbx7NXXn30kYSbB8tpX1uThSIpKcFjFCv9yz+s5EGpHN0kIGPIK6jdt0lD+zYA/kfF42J/7sLXX+o7UWulmQqOLEsKeGu0aw2B4UFkp6RgeR28a0Uf56e2LQazyZSeWL/VJW2fgtFCgwBIA3LsfrX69SIabSm98Sw3F5K+EABqkaCdJFRaCaI8cTrwCjyyRqdLE6z4iXwckZXIIX/HXri44wvEkvQ9l8PSoyLYMgMA9Am/ogc8YnkQ1jNx8E1i7VvtGjtfdEPwQ+thXLO+0c28ECuhtVNExJpRKf51LJBIPXMkjj/Zz5Fmlxln9+Gpbrml+b949MCXUwFwz3W4MDzI5gAo8w4DVA==;5:lhslxVJUzR6Kn0sfhmXjdxBsfyQH7UwH3Q9usASzZJV5tLlwkYg2+EmNxZODOajqK5ERLyJSsdbvJ61lczDNjSp4uit6OoHSMW97yu2ivobWkWbIfdBGWMIRJZp5mho0nmulGCKcmqtmM/5+cqkYvffIiC9ZWLc4/CPVRvmnHHQ=;7:Bauv2wIOrHIf9iNA/pARdVkK8brTIIjloUXqDtXV8p4zbh/+ts8u/bRMCVBHuKUKx8sCtnjhK4E/eUOMFmMlKAKyEBcntxOmK2Kntnm36nY9dB7yEUEzEHt5TIzgE+6nf4xz3A3ap3tQRaKs6+pto6QNqot6iGUjGIdYYxH/f8bVt+CvWoG6WTXDHBNPoHkRB9h3Cl459D/rD11RYoZBEUHVDNj038EFaWNbxGWGkW1CDoN02JQOn+jtjJAAZGaI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:sAAjiF7tC/wehRW5tdFHtw8lehmaLwTU+v5yWyjEgFZeL9gTLhgZw5lCi+fw8ZQVdaCI0RlMpKqRGEoOIOltB5rJtduLeVwp/OquMtd8gyJkPTI50INHG1BGXrd67FPrPc39emTznO5ZYG6vqaILxZRyPEW0Nj0utZ1NaEBVBIo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:27:54.2188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f7840e-33e9-473e-5bc7-08d5f8becf5c
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

This commit introduces BPF_MAP_TYPE_CGROUP_STORAGE maps:
a special type of maps which are implementing the cgroup storage.

From the userspace point of view it's almost a generic
hash map with the (cgroup inode id, attachment type) pair
used as a key.

The only difference is that some operations are restricted:
  1) a user can't create new entries,
  2) a user can't remove existing entries.

The lookup from userspace is o(log(n)).

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h |  38 +++++
 include/linux/bpf.h        |   1 +
 include/linux/bpf_types.h  |   3 +
 include/uapi/linux/bpf.h   |   6 +
 kernel/bpf/Makefile        |   1 +
 kernel/bpf/local_storage.c | 376 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c       |   3 +
 kernel/bpf/verifier.c      |  12 ++
 8 files changed, 440 insertions(+)
 create mode 100644 kernel/bpf/local_storage.c

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index d50c2f0a655a..7d00d58869ed 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -4,19 +4,39 @@
 
 #include <linux/errno.h>
 #include <linux/jump_label.h>
+#include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
 struct sock;
 struct sockaddr;
 struct cgroup;
 struct sk_buff;
+struct bpf_map;
+struct bpf_prog;
 struct bpf_sock_ops_kern;
+struct bpf_cgroup_storage;
 
 #ifdef CONFIG_CGROUP_BPF
 
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
+struct bpf_cgroup_storage_map;
+
+struct bpf_storage_buffer {
+	struct rcu_head rcu;
+	char data[0];
+};
+
+struct bpf_cgroup_storage {
+	struct bpf_storage_buffer *buf;
+	struct bpf_cgroup_storage_map *map;
+	struct bpf_cgroup_storage_key key;
+	struct list_head list;
+	struct rb_node node;
+	struct rcu_head rcu;
+};
+
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
@@ -77,6 +97,15 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
+void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
+void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
+			     struct cgroup *cgroup,
+			     enum bpf_attach_type type);
+void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
+int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *map);
+void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *map);
+
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
@@ -221,6 +250,15 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
+					    struct bpf_map *map) { return 0; }
+static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
+					      struct bpf_map *map) {}
+static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
+	struct bpf_prog *prog) { return 0; }
+static inline void bpf_cgroup_storage_free(
+	struct bpf_cgroup_storage *storage) {}
+
 #define cgroup_bpf_enabled (0)
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk,skb) ({ 0; })
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5a4a256473c3..9d1e4727495e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -282,6 +282,7 @@ struct bpf_prog_aux {
 	struct bpf_prog *prog;
 	struct user_struct *user;
 	u64 load_time; /* ns since boottime */
+	struct bpf_map *cgroup_storage;
 	char name[BPF_OBJ_NAME_LEN];
 #ifdef CONFIG_SECURITY
 	void *security;
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index c5700c2d5549..add08be53b6f 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -37,6 +37,9 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_PERF_EVENT_ARRAY, perf_event_array_map_ops)
 #ifdef CONFIG_CGROUPS
 BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
 #endif
+#ifdef CONFIG_CGROUP_BPF
+BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
+#endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_LRU_HASH, htab_lru_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0ebaaf7f3568..b10118ee5afe 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -75,6 +75,11 @@ struct bpf_lpm_trie_key {
 	__u8	data[0];	/* Arbitrary size */
 };
 
+struct bpf_cgroup_storage_key {
+	__u64	cgroup_inode_id;	/* cgroup inode id */
+	__u32	attach_type;		/* program attach type */
+};
+
 /* BPF syscall commands, see bpf(2) man-page for details. */
 enum bpf_cmd {
 	BPF_MAP_CREATE,
@@ -120,6 +125,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CPUMAP,
 	BPF_MAP_TYPE_XSKMAP,
 	BPF_MAP_TYPE_SOCKHASH,
+	BPF_MAP_TYPE_CGROUP_STORAGE,
 };
 
 enum bpf_prog_type {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f27f5496d6fe..e8906cbad81f 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -3,6 +3,7 @@ obj-y := core.o
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
+obj-$(CONFIG_BPF_SYSCALL) += local_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o
 ifeq ($(CONFIG_NET),y)
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
new file mode 100644
index 000000000000..f23d3fdeba23
--- /dev/null
+++ b/kernel/bpf/local_storage.c
@@ -0,0 +1,376 @@
+//SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf-cgroup.h>
+#include <linux/bpf.h>
+#include <linux/bug.h>
+#include <linux/filter.h>
+#include <linux/mm.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+
+#ifdef CONFIG_CGROUP_BPF
+
+#define LOCAL_STORAGE_CREATE_FLAG_MASK					\
+	(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
+
+struct bpf_cgroup_storage_map {
+	struct bpf_map map;
+
+	spinlock_t lock;
+	struct bpf_prog *prog;
+	struct rb_root root;
+	struct list_head list;
+};
+
+static struct bpf_cgroup_storage_map *map_to_storage(struct bpf_map *map)
+{
+	return container_of(map, struct bpf_cgroup_storage_map, map);
+}
+
+static int bpf_cgroup_storage_key_cmp(
+	const struct bpf_cgroup_storage_key *key1,
+	const struct bpf_cgroup_storage_key *key2)
+{
+	if (key1->cgroup_inode_id < key2->cgroup_inode_id)
+		return -1;
+	else if (key1->cgroup_inode_id > key2->cgroup_inode_id)
+		return 1;
+	else if (key1->attach_type < key2->attach_type)
+		return -1;
+	else if (key1->attach_type > key2->attach_type)
+		return 1;
+	return 0;
+}
+
+static struct bpf_cgroup_storage *cgroup_storage_lookup(
+	struct bpf_cgroup_storage_map *map, struct bpf_cgroup_storage_key *key,
+	bool locked)
+{
+	struct rb_root *root = &map->root;
+	struct rb_node *node;
+
+	if (!locked)
+		spin_lock_bh(&map->lock);
+
+	node = root->rb_node;
+	while (node) {
+		struct bpf_cgroup_storage *storage;
+
+		storage = container_of(node, struct bpf_cgroup_storage, node);
+
+		switch (bpf_cgroup_storage_key_cmp(key, &storage->key)) {
+		case -1:
+			node = node->rb_left;
+			break;
+		case 1:
+			node = node->rb_right;
+			break;
+		default:
+			if (!locked)
+				spin_unlock_bh(&map->lock);
+			return storage;
+		}
+	}
+
+	if (!locked)
+		spin_unlock_bh(&map->lock);
+
+	return NULL;
+}
+
+static int cgroup_storage_insert(struct bpf_cgroup_storage_map *map,
+				 struct bpf_cgroup_storage *storage)
+{
+	struct rb_root *root = &map->root;
+	struct rb_node **new = &(root->rb_node), *parent = NULL;
+
+	while (*new) {
+		struct bpf_cgroup_storage *this;
+
+		this = container_of(*new, struct bpf_cgroup_storage, node);
+
+		parent = *new;
+		switch (bpf_cgroup_storage_key_cmp(&storage->key, &this->key)) {
+		case -1:
+			new = &((*new)->rb_left);
+			break;
+		case 1:
+			new = &((*new)->rb_right);
+			break;
+		default:
+			return -EEXIST;
+		}
+	}
+
+	rb_link_node(&storage->node, parent, new);
+	rb_insert_color(&storage->node, root);
+
+	return 0;
+}
+
+static void *cgroup_storage_lookup_elem(struct bpf_map *_map, void *_key)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+
+	storage = cgroup_storage_lookup(map, key, false);
+	if (!storage)
+		return NULL;
+
+	return &READ_ONCE(storage->buf)->data[0];
+}
+
+static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
+				      void *value, u64 flags)
+{
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+	struct bpf_storage_buffer *new;
+
+	if (flags & BPF_NOEXIST)
+		return -EINVAL;
+
+	storage = cgroup_storage_lookup((struct bpf_cgroup_storage_map *)map,
+					key, false);
+	if (!storage)
+		return -ENOENT;
+
+	new = kmalloc_node(sizeof(struct bpf_storage_buffer) +
+			   map->value_size, __GFP_ZERO | GFP_USER,
+			   map->numa_node);
+	if (!new)
+		return -ENOMEM;
+
+	memcpy(&new->data[0], value, map->value_size);
+
+	new = xchg(&storage->buf, new);
+	kfree_rcu(new, rcu);
+
+	return 0;
+}
+
+static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
+				       void *_next_key)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage_key *next = _next_key;
+	struct bpf_cgroup_storage *storage;
+
+	spin_lock_bh(&map->lock);
+
+	if (list_empty(&map->list))
+		goto enoent;
+
+	if (key) {
+		storage = cgroup_storage_lookup(map, key, true);
+		if (!storage)
+			goto enoent;
+
+		storage = list_next_entry(storage, list);
+		if (!storage)
+			goto enoent;
+	} else {
+		storage = list_first_entry(&map->list,
+					 struct bpf_cgroup_storage, list);
+	}
+
+	spin_unlock_bh(&map->lock);
+	next->attach_type = storage->key.attach_type;
+	next->cgroup_inode_id = storage->key.cgroup_inode_id;
+	return 0;
+
+enoent:
+	spin_unlock_bh(&map->lock);
+	return -ENOENT;
+}
+
+static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
+{
+	int numa_node = bpf_map_attr_numa_node(attr);
+	struct bpf_cgroup_storage_map *map;
+
+	if (attr->key_size != sizeof(struct bpf_cgroup_storage_key))
+		return ERR_PTR(-EINVAL);
+
+	if (attr->value_size > PAGE_SIZE)
+		return ERR_PTR(-E2BIG);
+
+	if (attr->map_flags & ~LOCAL_STORAGE_CREATE_FLAG_MASK)
+		/* reserved bits should not be used */
+		return ERR_PTR(-EINVAL);
+
+	if (attr->max_entries)
+		/* max_entries is not used and enforced to be 0 */
+		return ERR_PTR(-EINVAL);
+
+	map = kmalloc_node(sizeof(struct bpf_cgroup_storage_map),
+			   __GFP_ZERO | GFP_USER, numa_node);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	map->map.pages = round_up(sizeof(struct bpf_cgroup_storage_map),
+				  PAGE_SIZE) >> PAGE_SHIFT;
+
+	/* copy mandatory map attributes */
+	bpf_map_init_from_attr(&map->map, attr);
+
+	spin_lock_init(&map->lock);
+	map->root = RB_ROOT;
+	INIT_LIST_HEAD(&map->list);
+
+	return &map->map;
+}
+
+static void cgroup_storage_map_free(struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	WARN_ON(!RB_EMPTY_ROOT(&map->root));
+	WARN_ON(!list_empty(&map->list));
+
+	kfree(map);
+}
+
+static int cgroup_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	return -EINVAL;
+}
+
+const struct bpf_map_ops cgroup_storage_map_ops = {
+	.map_alloc = cgroup_storage_map_alloc,
+	.map_free = cgroup_storage_map_free,
+	.map_get_next_key = cgroup_storage_get_next_key,
+	.map_lookup_elem = cgroup_storage_lookup_elem,
+	.map_update_elem = cgroup_storage_update_elem,
+	.map_delete_elem = cgroup_storage_delete_elem,
+};
+
+int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	int ret = -EBUSY;
+
+	spin_lock_bh(&map->lock);
+
+	if (map->prog && map->prog != prog)
+		goto unlock;
+	if (prog->aux->cgroup_storage && prog->aux->cgroup_storage != _map)
+		goto unlock;
+
+	map->prog = prog;
+	prog->aux->cgroup_storage = _map;
+	ret = 0;
+unlock:
+	spin_unlock_bh(&map->lock);
+
+	return ret;
+}
+
+void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	spin_lock_bh(&map->lock);
+	if (map->prog == prog) {
+		WARN_ON(prog->aux->cgroup_storage != _map);
+		map->prog = NULL;
+		prog->aux->cgroup_storage = NULL;
+	}
+	spin_unlock_bh(&map->lock);
+}
+
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog)
+{
+	struct bpf_cgroup_storage *storage;
+	struct bpf_map *map;
+	u32 pages;
+
+	map = prog->aux->cgroup_storage;
+	if (!map)
+		return NULL;
+
+	pages = round_up(sizeof(struct bpf_cgroup_storage) +
+			 sizeof(struct bpf_storage_buffer) +
+			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	if (bpf_map_charge_memlock(map, pages))
+		return ERR_PTR(-EPERM);
+
+	storage = kmalloc_node(sizeof(struct bpf_cgroup_storage),
+			       __GFP_ZERO | GFP_USER, map->numa_node);
+	if (!storage) {
+		bpf_map_uncharge_memlock(map, pages);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	storage->buf = kmalloc_node(sizeof(struct bpf_storage_buffer) +
+				    map->value_size, __GFP_ZERO | GFP_USER,
+				    map->numa_node);
+	if (!storage->buf) {
+		bpf_map_uncharge_memlock(map, pages);
+		kfree(storage);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	storage->map = (struct bpf_cgroup_storage_map *)map;
+
+	return storage;
+}
+
+void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
+{
+	u32 pages;
+	struct bpf_map *map;
+
+	if (!storage)
+		return;
+
+	map = &storage->map->map;
+	pages = round_up(sizeof(struct bpf_cgroup_storage) +
+			 sizeof(struct bpf_storage_buffer) +
+			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	bpf_map_uncharge_memlock(map, pages);
+
+	kfree_rcu(storage->buf, rcu);
+	kfree_rcu(storage, rcu);
+}
+
+void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
+			     struct cgroup *cgroup,
+			     enum bpf_attach_type type)
+{
+	struct bpf_cgroup_storage_map *map;
+
+	if (!storage)
+		return;
+
+	storage->key.attach_type = type;
+	storage->key.cgroup_inode_id = cgroup->kn->id.id;
+
+	map = storage->map;
+
+	spin_lock_bh(&map->lock);
+	WARN_ON(cgroup_storage_insert(map, storage));
+	list_add(&storage->list, &map->list);
+	spin_unlock_bh(&map->lock);
+}
+
+void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage)
+{
+	struct bpf_cgroup_storage_map *map;
+	struct rb_root *root;
+
+	if (!storage)
+		return;
+
+	map = storage->map;
+
+	spin_lock_bh(&map->lock);
+	root = &map->root;
+	rb_erase(&storage->node, root);
+
+	list_del(&storage->list);
+	spin_unlock_bh(&map->lock);
+}
+
+#endif
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7958252a4d29..5af4e9e2722d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -957,6 +957,9 @@ static void free_used_maps(struct bpf_prog_aux *aux)
 {
 	int i;
 
+	if (aux->cgroup_storage)
+		bpf_cgroup_storage_release(aux->prog, aux->cgroup_storage);
+
 	for (i = 0; i < aux->used_map_cnt; i++)
 		bpf_map_put(aux->used_maps[i]);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e948303a0ea8..7e75434a9e54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5154,6 +5154,14 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 			}
 			env->used_maps[env->used_map_cnt++] = map;
 
+			if (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE &&
+			    bpf_cgroup_storage_assign(env->prog, map)) {
+				verbose(env,
+					"only one cgroup storage is allowed\n");
+				fdput(f);
+				return -EBUSY;
+			}
+
 			fdput(f);
 next_insn:
 			insn++;
@@ -5180,6 +5188,10 @@ static void release_maps(struct bpf_verifier_env *env)
 {
 	int i;
 
+	if (env->prog->aux->cgroup_storage)
+		bpf_cgroup_storage_release(env->prog,
+					   env->prog->aux->cgroup_storage);
+
 	for (i = 0; i < env->used_map_cnt; i++)
 		bpf_map_put(env->used_maps[i]);
 }
-- 
2.14.4

