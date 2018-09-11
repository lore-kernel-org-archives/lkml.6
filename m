Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA559C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474D32086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QYJLYdxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474D32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeIKPLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:11:05 -0400
Received: from mail-ve1eur01on0112.outbound.protection.outlook.com ([104.47.1.112]:40416
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbeIKPLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUDrMj2YxatT8kZQG8JHcY6CQX7U3Z00A4nVD06wGGI=;
 b=QYJLYdxVkuhhGwV6whidn/s7x27RwJe/K5yN4T8D4xPT6sFEH692l7i1HfugVkZGNR5QsZSwBGpvDVOnCpX7ftJFHkeLPAdrDn/Vm+is7u56Gz28LNoryC3171jJPduZmVxQpYe/ijpYnNov6PSut9IP56mHDzBuefYCjXvuu+c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB2017.eurprd08.prod.outlook.com (2603:10a6:203:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Tue, 11 Sep
 2018 10:12:18 +0000
Subject: [PATCH 3/3] fuse: Use hash table to link processing request
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, kuznet@virtuozzo.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Sep 2018 13:12:14 +0300
Message-ID: <153666073461.19117.1958730317836145457.stgit@localhost.localdomain>
In-Reply-To: <153666041612.19117.14667042009014596105.stgit@localhost.localdomain>
References: <153666041612.19117.14667042009014596105.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0155.eurprd05.prod.outlook.com
 (2603:10a6:7:28::42) To AM5PR0801MB2017.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22d944d2-a857-4b4c-aa0b-08d617cf0ee2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2017;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;3:59/XzLUc9dT+d2r2Zy/yQ6aBYw0puY0U1nBQWWDh+011XUOPLLcZHNhJov/BP9AcT6XhmInLiKYNCCapsWIaAXRDOkwzVFkZcIMBrHRQLq9C8R9GOqcQBgr/G9m/Kbc1DHwSizGSq2P//bFlAdVGh/ZdWp2nVe7EOeChY7Ebe5/ZYaoaIo9LdslLmIWhWnLSXDz761pmWUSXkriksWaSH3VyqONv1LM4KvrtXi5GSBAi+3VpQ9S1Mi+8f6hQ594l;25:yEsI2Fivyr6oJgYyeINdG/RiDtbTZ3e33CnMOUSq2jXliURjIw8or38LQR9wPuoNXcAvq/tl3UZ/gJptRLQPLeZrlMWCkzNS1PS2j1iEIRAUVEV5Hqy6Cqq3/M94S/vv4WWoWAwTGVF2BBHU74qcpa4WQoquWhQuMOwd4i0zlMa4eO/S0DON5Cx69ul7gUoUd0txQG5lM5dwwcOkcr7gUUyDtHFcsqUrWy+4Ax+wyP/qwq27GyNO3PEUazTI8FLKcdf01B6l5NkMfyMkfTZH3eIbyP2EZlh9ZEI9l2bJw77wWR1T21IBJit2Z222gvr1ZBqXcjwXqSIGvwJjLIKlHQ==;31:gtUL9yisJu1arZp+MCXQP0vAD/xl8j5RnHRw7Bc4he60qvb0DpFhGKO7aWEzUzEjm9xf2ggNznyN3iADDoIA6ze779OYQ0KFRwLybop4FjQKMfsNwdRFr5z5OK7LzaXx/gy1UfFMn+QfKBBh4NbsIlZ+IrZropjtsyPmGcdRl4WcbLE2SoIa9XNI2uPAI2iRJ/RFnePSW3oSM/aa5Irja1We/CqPzLeU+wH06hATRdk=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2017:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;20:/bovS8SbCfpTrIc/G6k2LcJZKD7zJoYQihe1KF7KQJdO9TTSfSgSnzL9HeU5FTgvYheBCsqSP4I/HpYGEesy5cl5jQ7rRiztzcIoO8YyW0IgXE19P5Lt4KpTtGRPEiO+L+r3Z7eiJopqSUJDU3h/bNQ6R0nP/Z3DOZVj7lPFj4F/ob9pxdJaPFdsAh0o+qg8zCcJv0UIII1z69QppeF5fP6o5mPEnCcntTiAMqMnHhzS7ZAXKppTC52gT7pm0p7JcST/CCgs41bLZrh3KKLLzf/7lNP2ZAZQZ0QSHMq4Kjv5om4wzrXakABUq2aoxIDxk06f2cAMVbX+r+Lij0oR1uJSbSPfYXHNmOSApg38FLeOA3DDcAYhL+oTQL24yRetHLBTQbUBlM2p+P3unLXfEOxObhqEL4yf3fbL9u88FTQdRYXrL4GEfjxbFNCPUVkUb2FifNEPTGiw4S4OaIuMJ/myXclFsWfSZ1jZAosGJDqnej5xFXfzhEEc1GqpZdzT;4:5KqFG76guGC5bnm3am+G82cTASG1QQYXGstEtnewEpd+7oSMTli3fUhg1GGdUs+5ESSFy5Vu6F9jjRA5Ps3vCLkBrh8wrPc9GMuCzh9HTm+LrTaVtohTA6779/xaT3QM7qKa7skCmRasnmzUkmY5BlnWQ7Ef6Uy6AUT2FXuxKArKatMndhz6+7FIzsoy3PZvx14ZWdmmyYVe+c47w6efN4sfJ8FyxbEfEEl2PDv6m3jFGzcNtFFbIP1S4FkeQnt50wSH/Lq7PFna5cPo67YSA1zaDo5YzSRx+1ICF6e/LQFKyuJe9kit57cFDm0wqioz
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2017FC1F3ADE8E76F0DB560ECD040@AM5PR0801MB2017.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:AM5PR0801MB2017;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2017;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(346002)(136003)(376002)(39850400004)(366004)(189003)(199004)(106356001)(2486003)(103116003)(105586002)(50466002)(186003)(16526019)(52116002)(26005)(23676004)(6506007)(386003)(7696005)(33896004)(76176011)(478600001)(2906002)(58126008)(14444005)(230700001)(7736002)(25786009)(8936002)(305945005)(8676002)(68736007)(81166006)(81156014)(476003)(97736004)(3846002)(6116002)(9686003)(6666003)(55016002)(53936002)(316002)(5660300001)(486006)(61506002)(446003)(86362001)(956004)(47776003)(66066001)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2017;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTc7MjM6K05VTG0wcmpteDhkcmtWSDk0Z2hGU1Rj?=
 =?utf-8?B?cVhnYVdjeFdGOEcxTitQM1pTUE90TlEwVHh0b2JRSmJJeWpXSENvR3ZhT21m?=
 =?utf-8?B?K1FGclBhUE9OM2lybnFsVk05WDN4M2NHNkVUWUFXNmg0UmpiSHNVeDQyK2Z6?=
 =?utf-8?B?UWd0am51elRDdTVxZzRrdEdkb0QzQVFFUmZqUzJjd2JZOE5lRWgvclNsVG9k?=
 =?utf-8?B?OSt4OGZlUTczQ0JwUTkvRGtGdTVRK01YMEJHdVJ3QlQzNnJveDk0WGJPS0d1?=
 =?utf-8?B?OXMwUjRsUlZuWHU5VzJZODBkS3E1bDFMWC8vcXZsVms0YlhmSTBNYkpVdWhR?=
 =?utf-8?B?dVpUcU5CUWZqL2FYbmVldkllZktpWDF6NjYyU0lRU2xOdGFEaDhxQzIrTWdu?=
 =?utf-8?B?UWJCcVJlWVB3aElPVjE0UERqU0RoOTcyU1RUTjVKKzFuZTBWRzJqVkdRN1Qx?=
 =?utf-8?B?VWVrZ2o4YUUxQVBISUtpeVpVaEpCak0xNCtkTTdId3p4NUxTNHhmTWwzd05H?=
 =?utf-8?B?citxN0d3M3ZFNWtLNDR4a2c5Qy8wNks4K1YzVDk3RUVsRUNvR1ZiRHNVeE5j?=
 =?utf-8?B?Mi8xVDc0dkhHNjViQlBqTVljUWxxVmJnS1RhUTdCM0RsSDZCTW9GWWU4YVVY?=
 =?utf-8?B?SUlUM2hPMFVlamVwUUVoSnRqUVlITHRKb3NGVEdNMHhFdktkVkZrOEp3ZXF2?=
 =?utf-8?B?U1FjUE5kK29FbXB5bFF6ZkNNa3NDSWxORDJ0K0YvVDltQzB1ZGhUT2s2b29C?=
 =?utf-8?B?bHo2SEJvT21Vand5cFI2SEVWcVdNa09JM1dMd1RGSExjaDh3aFpjcGZLZEFw?=
 =?utf-8?B?c0ZXNnRFeUtiNHhpeXpONm5sUURnVlVKaWF5YTBSMy8wZTRsSis1ZDV1am5C?=
 =?utf-8?B?Yks5dXczYjgxeGwvYU8vM0N0RERINWJCMlUxV2pvSkNLNml5bXJCWlJJSTNt?=
 =?utf-8?B?SWJqWGJXY0Znb29YUkUyUno4bnRnR2l2Wi9mNjg1ZERqOXFWQTVnN1poWFB6?=
 =?utf-8?B?aDZCbVhvTUlXay9hR2xFWjNncGVGdHJEQWdKRDEvYVRwVC9XdERaa3pZcVVL?=
 =?utf-8?B?WEdVRDdwYldTVGZ3RkZXbkhYQjduWTJXUFMrem5zbm1qMHY2SGZXNmx1NHUr?=
 =?utf-8?B?UjYyZWtmZjB5eERlK3hRNlFabEpaMXRFR3M0TE9TZVEzczhxWHFVUnZZQ3Nt?=
 =?utf-8?B?bldNUXRCOVQvSUZOTU83SkdzbzF2RWltVFJPRERtcGVvTTMxWVFNMVpiamZr?=
 =?utf-8?B?WFBPM2huc0xHN3U2T2NSekpOYklLQ2hVb0E2MUpaVTI2ajYxZW9ZRkZFUnZj?=
 =?utf-8?B?NmxaS3dGb0hZNHpVdWI1MWhKc2FKR1JNOE9oR2dkMGF5S1BQazd1dE4zZkdh?=
 =?utf-8?B?clQ0SDFQWHhqUHhuYUZJaHlpb2VTQXRrNzhoVnJOb2JGZGxmVWNkRDg1Yzg3?=
 =?utf-8?B?bWdUenFtMWNNNXNtVCsrWjNIcFhBbGdydXM0YWV3aVBYbHl2aHhPT2xDa0VE?=
 =?utf-8?B?UHV1U05TWWY5YXh5cDFWRzVBWSs2Uk9JSXRhOWVPV1lLQ0pTM0IzOVRYN2Fx?=
 =?utf-8?B?SmkyajhoU1JiOGFaeDlsaCtzMEhhMXFhY2NIYXlKQ1RzUGkyc3dyZStLUmpp?=
 =?utf-8?Q?rOpbks4fg1nWy+hysbBsPT?=
X-Microsoft-Antispam-Message-Info: Ai8GPA3U91jA6IXWxqKP2dYGgjkeQK13xVDTIBpG6w9H/r39x85Mj0goOgi8RV/C0msuA98mHv7Vfj4bMhW/EcXm2e7uj9R2uAyDw8YLTjF4H7YHu5xPpJ3bfjDth5MxoWWTSrRt6aw6Oa2FSD77vdTFGfBT9KzqaeDJG74+zOQbQydbTjQPLW7HzYcWJfVAY42f1ZMJ2aR3sp6jDlfFxoWpb1raPD8GHGBoZ4PwgeYVjYGHL+i1ooXPMGb3Dsc4oo53QNzBCh/jtM0bxzV3RsYa+9nftcAIAymgF8qDsu+fqYrv5b+TL8ufj/suiXLvJXf9onKaz1v6Znv74NE3/qycHNd6j1g/CDpOff5FwUA=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;6:844M8C8HQOdvNUx7k2QlHPgDKdyUbY3MjOnkKPcVGREWuDN0A23nkXFMlD5DYipvF2NIP3Zz6sQm1N73NaeUdoHuqjEwlxPoNSPlFZOF5g0YaVvl5YLFuqU+JG2WbODU1120wA5TfO3VE9iFFlTqQusymhaQh3qHfzOEpyyaSUtELsaw5m69fJRVc24YpsM/T43ZRmgjeKX6S96J3P1Nb8b9uKopnO6yjKkIMbn0B2TK0sN+UCDAKXpWTemcN5XSINStRW4wo964xJMHc9pZgTn7CXrN0lLt3yJSAAkESIA3uULHYZFAjVPJH7fTU3gLJ3n0PULlyE7N65lx7CuPnq3hZr3vZ/vFJ/YZXxjgKq1HMDzYZ+gERhAiCMi3QsmLoYmZPpfhVwkIR7sf6bJar0mdweU5h11CtF1nmkJhmV3M7+WuxuGrZAqYiP69tS/5GX40NLBUlvj5KnR7aSaz7A==;5:Qforgy5kZ+8dCNVrU7trNeRmKwhpBpRyHCprf8j4KKLHctJDGVBaj0B4QhhHoBwMDfsihozavSrCreN7Zp1fyGUn3IBZSlkt3lM78HMgA1MWH+PKNoFpGhaUDH+G5KUpdHCPljTIIlqTO1dKsSx/JARa1YVv6KhpJatURoGteXo=;7:PxjHFkbjHghkE7jBSttgnnXW+o10qP2HR+rGVmk/cGU+ANKpP+OqEX98ZQuTByzMVyXXtBcwu3uxJ4shHJ+RaqvrUuIO8gdL//V2T8E5p+OlwocRBU41pUt0IHIHBhCave6IiiK/B8AcOoC3tr8LD3Z9F47rZYacPn4rLAj1H7OjCv3c+itQKDJ356wgkKUh4qYQSbj0HjjB3QFNoOMPoVJPBWsymD6Ix6OUP2hsIJB1EZI6jU7/77xg/pqf5ys2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2017;20:Fk5h+6onG/DapqzZ3Fr6MrmisngW/xOa0XK2yO4PCgPG/BieIBRIp+6ZAzPpVtWTQGzCJId2p8d0oJwQTzpuInvf/VnHe5mY28+LiBA+YTD9IJT3ZV8o5shT+gJkgf0oiA7ghH+MsJGvo+5UEoyWAsiZfI/tmiAVWFZi4qcxL0o=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 10:12:18.9595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d944d2-a857-4b4c-aa0b-08d617cf0ee2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We noticed the performance bottle neck in FUSE running our
Virtuozzo storage over rdma. On some types of workload
we observe 20% of times pent in request_find() in profiler.
This function is iterating over long requests list, and it
scales bad.

The patch introduces hash table to reduce the number
of iterations, we do in this function. Hash generating
algorithm is taken from hash_add() function, while
512 lines table is used to store pending requests.
This fixes problem and improves the performance.

Reported-by: Alexey Kuznetsov <kuznet@virtuozzo.com>
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c    |   29 +++++++++++++++++++++++++----
 fs/fuse/fuse_i.h |    8 +++++---
 fs/fuse/inode.c  |    5 ++++-
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index dda177b57ea2..867825cd04fa 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -327,6 +327,20 @@ static u64 fuse_get_unique(struct fuse_iqueue *fiq)
 	return fiq->reqctr;
 }
 
+static unsigned int __fuse_req_hash(u64 unique)
+{
+	unique &= ~FUSE_INT_REQ_BIT;
+
+	/* Borrowed from hash_add() */
+	return hash_min(unique,
+			HASH_BITS(((struct fuse_pqueue *)0)->processing));
+}
+
+static unsigned int fuse_req_hash(struct fuse_req *req)
+{
+	return __fuse_req_hash(req->in.h.unique);
+}
+
 static void queue_request(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	req->in.h.len = sizeof(struct fuse_in_header) +
@@ -1314,7 +1328,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 		err = reqsize;
 		goto out_end;
 	}
-	list_move_tail(&req->list, &fpq->processing);
+	list_move_tail(&req->list, &fpq->processing[fuse_req_hash(req)]);
 	spin_unlock(&fpq->lock);
 	set_bit(FR_SENT, &req->flags);
 	/* matches barrier in request_wait_answer() */
@@ -1797,10 +1811,12 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 static struct fuse_req *request_find(struct fuse_pqueue *fpq, u64 unique)
 {
 	struct fuse_req *req;
+	unsigned int hash;
 
 	unique &= ~FUSE_INT_REQ_BIT;
+	hash = __fuse_req_hash(unique);
 
-	list_for_each_entry(req, &fpq->processing, list) {
+	list_for_each_entry(req, &fpq->processing[hash], list) {
 		if (req->in.h.unique == unique)
 			return req;
 	}
@@ -2108,6 +2124,7 @@ void fuse_abort_conn(struct fuse_conn *fc, bool is_abort)
 		struct fuse_dev *fud;
 		struct fuse_req *req, *next;
 		LIST_HEAD(to_end);
+		int i;
 
 		fc->connected = 0;
 		fc->blocked = 0;
@@ -2129,7 +2146,9 @@ void fuse_abort_conn(struct fuse_conn *fc, bool is_abort)
 				}
 				spin_unlock(&req->waitq.lock);
 			}
-			list_splice_tail_init(&fpq->processing, &to_end);
+			for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+				list_splice_tail_init(&fpq->processing[i],
+						      &to_end);
 			spin_unlock(&fpq->lock);
 		}
 		fc->max_background = UINT_MAX;
@@ -2169,10 +2188,12 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 		struct fuse_conn *fc = fud->fc;
 		struct fuse_pqueue *fpq = &fud->pq;
 		LIST_HEAD(to_end);
+		int i;
 
 		spin_lock(&fpq->lock);
 		WARN_ON(!list_empty(&fpq->io));
-		list_splice_init(&fpq->processing, &to_end);
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+			list_splice_init(&fpq->processing[i], &to_end);
 		spin_unlock(&fpq->lock);
 
 		end_requests(fc, &to_end);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f72e4974b3bb..ed69e1530216 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -408,6 +408,8 @@ struct fuse_iqueue {
 	struct fasync_struct *fasync;
 };
 
+#define FUSE_PQ_HASH_SIZE 512
+
 struct fuse_pqueue {
 	/** Connection established */
 	unsigned connected;
@@ -415,11 +417,11 @@ struct fuse_pqueue {
 	/** Lock protecting accessess to  members of this structure */
 	spinlock_t lock;
 
-	/** The list of requests being processed */
-	struct list_head processing;
-
 	/** The list of requests under I/O */
 	struct list_head io;
+
+	/** The lists of requests being processed */
+	struct list_head processing[FUSE_PQ_HASH_SIZE];
 };
 
 /**
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index db9e60b7eb69..b28412e75c18 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -594,9 +594,12 @@ static void fuse_iqueue_init(struct fuse_iqueue *fiq)
 
 static void fuse_pqueue_init(struct fuse_pqueue *fpq)
 {
+	int i;
+
 	memset(fpq, 0, sizeof(struct fuse_pqueue));
 	spin_lock_init(&fpq->lock);
-	INIT_LIST_HEAD(&fpq->processing);
+	for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+		INIT_LIST_HEAD(&fpq->processing[i]);
 	INIT_LIST_HEAD(&fpq->io);
 	fpq->connected = 1;
 }

