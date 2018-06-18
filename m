Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F68C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDB220652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="COU8ZpJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDB220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965539AbeFRJqL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:46:11 -0400
Received: from mail-eopbgr30123.outbound.protection.outlook.com ([40.107.3.123]:45124
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965325AbeFRJqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXe7YKWjRmEZE3mUe/iW/B2RET+r4Nhkxtqtifjjkfw=;
 b=COU8ZpJ8ysoMgmf14MAm1O7V+9ykHr5HT0LiUg9y5vL0ySjz7w6pAHbT1w7uDiNTA3I+toiRx5V1vsBo2R34c3PMkNl8kpy79Qsli0+NdoDxcV1sWUPp1DUBeF9tpfvCJ2duOMSPU3VehCoJHum5A1eDZbMHJnwM1sv863t1YIk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 VI1PR0801MB1341.eurprd08.prod.outlook.com (2603:10a6:800:3a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.14; Mon, 18 Jun
 2018 09:46:01 +0000
Subject: [PATCH v7 REBASED 07/17] fs: Refactoring in alloc_super()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:45:58 +0300
Message-ID: <152931515883.28457.15515405237855359874.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::30)
 To VI1PR0801MB1341.eurprd08.prod.outlook.com (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fcae6d0-7b82-44c1-15d9-08d5d5004e61
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:/8dFkv7cfmTujrKTyU1qjE9jZ4O47b5h9/qdhXJrFpNXcisgPYk2oSs9VDoFQnNnZooBMPE2am0XIvx5vn+PtVue3URfUb3d+UiU49c3rEghkcz6qrc7MNGE8GB2D1eTmXXJmLQMI/pKyv0PuUqr6nPqN9Sy3UieQCE2lMIW/YZcjURkjqRNcc302kTh7EBdIPhD10k9VsCfGlzyu4p53+ZtKcLPSXPjes9yMJY5wFeQNtjN8l5z8T/Bl/0KskE3;25:xl+j/MyBwjsXTZRPJ7bDHhs8oyGwkm6JaM58XK5fr3ALRh3NSLNr3ClcBelUsswAZp+Ss6MsyzevC2O9OBXLMadPOYoZNcD4EPIh/2qtgsvKtrRAKcY/DRLkQ8fyiojeDxBr5ht11rxBapstxeTyRB7ZAMmi/jzes/cQfK7NmKegv/pLDGjR3wsbgY2iBM05vKFSq0SBsTuwZr22fnbb/iuqTjcz8THo7MSgAdh6RqP8rY9vmFUkOoxWWkS6L5cU427l1D9siyDxTdQQv84tXQdLToatnnviTZrtt01vIVllPW3S3nuBLDs1qKmOmp2xfaYqC6/MMxh/9t4I4jAktg==;31:Gpc9BuW8wGdTnk5jwNiiExh+Rua9wL+URtCCg4+XxsknRYHRDFZHF1krovzBt6sxwwh5B+quo3urc5c4qk71/xjBBorO4u/YXw9Q+DFmXwwUIqYiaprOYTMmb6E2GBs8v+rxAfgj500jisHGEzRhIeDmSqyYarlEdAY39P0ui6MbgANk3nnhdyZ1UqSSDsEOenUcZ2RFEwuL0hF0W6zoKpDh0lhgLHB0H2wEp8AVFBU=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:iYuK0LqJkOUyaO0NBQezWk7pRcZTcppxY1Q5Kkg52FjMn/037YaL3qF8ffkpLy1GvlRPWSnlWAo3ycuPoIWHFzmShfmBa4ADDLkjQ0K3eCURn+kR7bRWMZyaqb9qXxqdcmd0naPve/JNIynMzobwhqGHkSnFIyjtRqh7q7JgJnf2S+I5DyCl1WTidnSK5m3/dPs6H18be2x/oi3C2u9/g5DAIKXqlTME1x8VICagDkQnBqlvl91VP48918J+9gPfb0jbzjFHSgt831hOVU2MB+lgIv31nfKjEKI4WNis2fjgc08zp1V862FLi7ggCQHmd+DW9A8StOe8L/P1rTexle7xKsy9nmjWGx6L1X6KWlM2RVGk0l9g0UW+fTjRzDrP8KhBSDSNYrqbjw8HPsPMXrUD84l4y+tv4UoSTaLRTOx/aRNwb/oXQ0xePdqc3h0E0ceBj8gu9NNNCU98QaKFAsCxK/zZSp5hwFgNmL/x/bqi5pwcoBJOeF3Zq9ticiIw;4:Bxoxi17kwNCmJlN6AhNaAxjVx1IRAao5In9ZkQ9YEi8DVBf577u5wu9FgACbOLXSdnLMsvyp002Z2TzTlOywtf2DUbgIkEAHrt/NQFG889rBJGOoLie/PFd0huifbdnGQ14gQYsPJ7iRlN7wQHt+NW3WB8vg12l3nAimbcA3N5UUSgUkpZxj/8Pc6ZGmXbRhUu/nwbFokVhlOKeIeMvIpWMdrgZEKsismGA4co4YQwn9yCraaXesz/pxHM5zrfDg+SNsz6aWrFTkJeSHrz3Md3VzJeWa0NnsyLVEZrhIK4uE6JnjKuee+Csl3i3Rw3+Sp0G4ydPjjMIWweN/CwbJjUou/KHo498dhQA3yZtiziYQAi3uZ+7R6d4FbUJKk2Yt
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13410E2680C4A6071B0A395CCD710@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(376002)(396003)(39840400004)(366004)(346002)(189003)(199004)(2906002)(6116002)(3846002)(11346002)(956004)(6636002)(478600001)(486006)(5660300001)(86362001)(61506002)(81166006)(25786009)(6666003)(39060400002)(446003)(97736004)(476003)(53936002)(81156014)(106356001)(105586002)(9686003)(8676002)(230700001)(6506007)(386003)(8936002)(59450400001)(50466002)(47776003)(7416002)(55016002)(316002)(16526019)(68736007)(58126008)(26005)(186003)(23676004)(305945005)(66066001)(55236004)(2486003)(103116003)(7736002)(7696005)(52116002)(76176011)(33896004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6NWpaclMySVlCc3VRRHJMSnlZcUJZaFl4?=
 =?utf-8?B?Z0FnNTlGR0o2ekZMZHoxRkxwYnJzTGxkVEpzbkkzRDNKZEhQbEk0Q1hiUUUr?=
 =?utf-8?B?a3MwK0NLMFQ4NEV6M2pVSHNCaGlUVmwyVlY0Mk1ZbFdtQjlhSnFRV2o1cFkx?=
 =?utf-8?B?cmZHV2h2RVRlQUM2WEYrR25ocW9IVXZuajJZNXhHOWhuY2hxRW9NUDlQajJh?=
 =?utf-8?B?UU5Db0NQS0loUnM5dDREbU0yTEpRYkUvZFFtbnJ1Sk43TExSR3dsQlhtTUxa?=
 =?utf-8?B?RnU3ZTZtajdGS1JwRk1ienpDVWlMZ3MzU3duTTdkWnA1dlU3OWJqV2lQZ2xN?=
 =?utf-8?B?VUdKWHl6b1IwS01mVnN2RjZvMHNpQUkrckhIUDVEVDRXcXFzZHhKRHFaTXUx?=
 =?utf-8?B?K2pSNVJHT0xveWVKdXhQNVFubTczNW9vUkUvZUhJWFNPbm5jZWY3b04rb2Fz?=
 =?utf-8?B?L3lvMTRjR0RvK2ExNlF0dVBTUjgxVTZIYWpQdlA3WjVTREI2Z3RSQzJTYXd3?=
 =?utf-8?B?VmNwZ3FoSEFTWDM1c1hFQmRhcytsLy83RzNXa2s0aFVOZS9zMjJJN2o4aVBM?=
 =?utf-8?B?VEswSFVDdWgrencydGxOa1U5akwralcxNjlqK3pBL0JBQ2tVMGFlckUwRE95?=
 =?utf-8?B?MWYxQ28zSjNRQXNUWlBOdVRRZVIzaUNBeFN3OEhZRWVBYnNlSDU3UmJOTnMx?=
 =?utf-8?B?b0p5Z253cEFremN5dGJ6cnVKSjRiZW0raDJCNm03RnA1dDZZcHptL0xNWFI4?=
 =?utf-8?B?SWxpTDIxMnpNMGlicHhMdDRXeFpEempoVmtMTnNZRUNUdHhaZnJGT0o1QS9O?=
 =?utf-8?B?ckEvRTBWeVY4aVArelFqOWZadlZvS3Rra3c5NFZXbTNZZXkrV0tzNzZiZ2RR?=
 =?utf-8?B?cElLOG0rcFhFZTdCM3BiTlVqaWVxNkY0dWRXcEFOL0RRNUIxck0yRElMZWFU?=
 =?utf-8?B?enE3VWgrdUZjS3Q3QTFRaU1GL1JHRnVLYzJaUWFDRVdJYUU5NUtqU2kxMjFB?=
 =?utf-8?B?QWxRYXZPMXFvNDB4OFIxN3ZlRFhlRkdIcUNxbU9uS2xkRWNJUTdic2IrOVNq?=
 =?utf-8?B?T2FYcDFwYVBkSnJDY0dZTld4NDczYnhBTmRYREtyS0kxWi9xNzVTNHZLUnVm?=
 =?utf-8?B?NWpNZzFKUndZOHp4Tk16WDhyS3U4Mm42eGdSOFJLREZScUR3SWdFNlZVbEpn?=
 =?utf-8?B?T01EOEVYbkxQVkxsZGNVY3Q1REJ1N2FZcmc3SDJxbHJPWGx4QVFBRXMxNFRO?=
 =?utf-8?B?cHJObDQwSkg2c1FRQzd5VmNVVVdhWk9TcDg1QnNmTFhiMG9USjJzbVJTR3dx?=
 =?utf-8?B?Q2QvUGE3ZVRWVCtjUmFnRlNEMkVsakNQNWVWSG1TMjh4cG95ZkxERGJBNHZv?=
 =?utf-8?B?cTd6Ulh1ZG0zbjBFK2dIWXF2amJBV1JCSytjU3c1RWFjYXlXRHJvOVZ6OTcv?=
 =?utf-8?B?bFdsdncxZ081c2JXeUZjL2U1TmRKQnZIOFNQQXgyL3JBVUZKdkdVRUI3YnMv?=
 =?utf-8?B?QUhVUXhVT2czNHVOZUFrOHllZHhkaExlV2lWbzRUN09STTJocU1EU0N1Y2py?=
 =?utf-8?B?T2h3NkdHb3dBQnFFNUpuMmZzSS9SOVo5cGliWkQrd3BBc2xQV1U2WEFBZzRr?=
 =?utf-8?B?TzZzZlBnWEMveXJlYnNDMUJvWmFaL2F2ZzBoM01vNDJ5Ymp0eVFGSzR5UkxQ?=
 =?utf-8?B?UGVTZE04ZzlzSkp3TitGVXZUTGN0cDlGdWpoT0N4bEl4cG91T0xaZHpLUHVk?=
 =?utf-8?B?QmovUHBHTTJlV2RlVWxYa1czdnE5WDZ3SjR2TDRQdjdVMDg4K01zS1Z1cC8r?=
 =?utf-8?B?dU9JMlRrYzBxc3QwQnAwV1VpT0VMaUtJSS8ydDlwbllkR0tvZz09?=
X-Microsoft-Antispam-Message-Info: +pR27e1HSCDoTJO1hajBwMSr2jCoqMlCsm66FyAbkIgSL9ZO6PtHAJS+m2CGW9fhlBorKM75WP+bjzaZCr+APdTKeILiqg7LI8UBDkkvVM0A5ckKXrt1mSPgYWqklTcmdvtdUFW54WO1ORx/w5VOiJbfekVPo0Y1KEWvQXyQ2q9uYZ+05dzttEa91ASnLC4aAplA3Mnio2QRphMTML/EFeSe7HVnJkNgvnRHp0PNI/8ifQFA6HemmQKhVC6mQ7cga3kPmtBTDaXQMJ5whbmyLu6i2fMvsu9iYYoXoFwpJvpGN0shGlt1/zzNtzfaC/fg
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:+cvMjixvYd95jRNB830Ym/a/wTRRHTZTQZP2480IOYPRNkODGXOzY7nFPq0/CjuHBOSRvYFKKeX0mZwSmiptdQEgFoaFI3dE5FJWbiyrFzDPNbJKm7JUVJvEuK50Kn3/0ZUhy1xvB8Ne9LxV9kySOw/Gdj2mdM9MX5eqfjh7ikwd5cvuZKqO1UNDPhF7KNqmc6LukmOLwsX5mAq5/yxZZgSUJzDTmb7ceZ/3LyKnWgvqvoWyrGrB5kRxfwFiMpAW4PAU03w3DBuHfpK9+brw93HbS4DVCDF4BVn60QTrQbvr8mv3y9QiD8es+/CVpny1lXyuMVPUh9CvAnFJU6XkRTnrLfJ0rr9wbIZh8ILXhkqSFQGz4Tt96tGb9pwxnSqzPMNMHyCcMQ1gMUCZ1ujMKQEHbRIqoxzbMQt5Yg6vsZRTCQStNyG4TPng1a3/CWSwIVzphn8eVK+wCZ8XVBFQNg==;5:edwo57s4LQezWWkwybscF5diMT+46fMaxifK3Xg3jPNlZl4QGKMJwRyQ9T+XQb/J0smVDK5uQIEHIIkMPrA9fu3ZTE5ebbb70RdxD2BVsfDgOc5N9xU//3rjPE6bI+habI8swqFegOS4PSiWLQAxoR0dteflb2y8QRNLwnEMn+8=;24:VlHP0mbvxelL7TK9M8Hzxnn0ID1Y/iW6Zc0oEsk3//ltXLSX6OaO0OaK1Iyn2DT1hJMB7DjdyJRoVSgZp+lStcf5f95IMmwlxY1Q04aq9wU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:lzzZXxQuRp6B1JcYpk7UquoY7JtpjPy/9FsFKxe8yQC5zlWd57bPxrPcWhLLLtActhdrJtktWlXPd/8N32fbESMBniBCvzeNYPO90r+bF9YJpOj5mTx+lC6ML6kLoDSMltVvFYbcrCeK3CLCEE/Oufm2tsOnmY9f/e8VA3ZV3wKa0Tco2WlnUi+abTEEtQJ/W6VJG+6T/Qt4uSIeNTn0b1fTWOvqJY/XbUuIpQmBQhIB2CQz6FsWc4k7O4VZP31i;20:PabC+xCeKe2ugrhy3Va4Lrcf7CJQQcdyrX16NJAbuFpOXUAyh5WslXBIXuc2lUbYjBVLv91KheoWxy9FjKSh6roez+75UlhKJa2QId1+MsG3nkAhrZq/FYMZbp568lESdeVK09097n2XV1PNfb3a6Hosu1UzhnhqCa1Ks9iqKR0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:46:01.6720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcae6d0-7b82-44c1-15d9-08d5d5004e61
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do two list_lru_init_memcg() calls after prealloc_super().
destroy_unused_super() in fail path is OK with this.
Next patch needs such the order.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 fs/super.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 50728d9c1a05..78227c4ddb21 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -244,10 +244,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
 
-	if (list_lru_init_memcg(&s->s_dentry_lru))
-		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru))
-		goto fail;
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
 	mutex_init(&s->s_vfs_rename_mutex);
@@ -265,6 +261,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
+	if (list_lru_init_memcg(&s->s_dentry_lru))
+		goto fail;
+	if (list_lru_init_memcg(&s->s_inode_lru))
+		goto fail;
 	return s;
 
 fail:

