Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbeETK7q (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 06:59:46 -0400
Received: from mail-he1eur01on0073.outbound.protection.outlook.com ([104.47.0.73]:13341
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750928AbeETK7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 06:59:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-7-git-send-email-vladbu@mellanox.com> <20180519214327.GC5488@localhost.localdomain> <20180520062242.GB2255@nanopsycho.orion>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 06/14] net: sched: implement reference counted action release
In-reply-to: <20180520062242.GB2255@nanopsycho.orion>
Date: Sun, 20 May 2018 13:59:29 +0300
Message-ID: <vbfr2m6a8z2.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR0902CA0021.eurprd09.prod.outlook.com
 (2603:10a6:800:d7::31) To VI1PR05MB4701.eurprd05.prod.outlook.com
 (2603:10a6:802:60::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4701;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4701;3:QdWqVs8bhwn0a3UswzKNgI3f4kg64jvL5BEtn+Y29qnM2Y1kBziM4Bg2QyW1TWJ8EolFSVVgc00Ndue9PXxiuydqp07TtSzPFPxoFsDDGGsFkxbzmnHNZ4zSHWMwI2Ot7xD3BtMkYm2WE3FMXT639CgHCFVpAipB6GPBFmjliK0m1it6hfj2pPbnz8iE/OlUCyATiK+toeNbMcapo9YDpxDBH/mtPbWn+dvTR4lcxY4eVrQSPNTKXKCsI0ZGpYqB;25:js9eDIMBlCjJQRjNst5wYndqjWDC/0BEOOXGPtvhIrXYDaHyTu7A1dBWTjFPXFQkx+AVvGjlWZEYG1HMGxzt6uOXay+IIh7XCyu0saHB1CAwcj6yK5cWWOdXBSCMLeQ/U3DNBSXLigx106/3qdClnw8ADcUGcoeOOMqekVT0o0FPdFWqgCpFoYmf2gCE4Xe9jKy+M0oy7eK8iWedidGbwbwL2dQm4e6yL4tXvKmq+SsvApiQu5nqarShWNvMvP0x/DOeDZ1KMETRm6KkRCge+N4mPnlTn000L+EdymCJQQsBbAwzss+RgbnM1+Nmyim+CoML3ZwSr2AZR8XrNyBhJA==;31:2tUmMge7SKls1xvwmcQ11Eq3sCwUROu+SKPd+FFkJJY+pxywwWldTPodAzinaM20/oJjOBx/CHQ5XWoc49ZgDCY01vEKfy8QuNOtlyu8ES7lVECoX1xXite4El+3JLv7Mqu9Vs0ZppF1G7MfWI8kVmbhLguGNEwxvBbF8jf9RwpIfkq+ZnReOJWWxOs1JI7JOlfM4PwwdsOOXOqe59YYSswUIpRfIc3Iv1kALsOEiTM=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4701:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4701;20:Kct5NU8fsrs5DyUJKEllaejGaYq5oUapZtTjkQtMdkWIg46YmrzHzTiMKvtX5JEmJAdL8ZK2pGaTe59EwgEazMgIekfe5GArRzwhPGHZmOTZeZ3ME8StGEH9id1mRxyXSqQcRa0PrwHzc0yo1BB3tlEuHWho/oSoBr9C/0RWcLgfYdVa3z1cePNERbJZnNn0Dv5iPiaVqgdDgRzaOnrVsiIL4Pr9gDbmLZOyLerYbijo8xS0caYWse0ZTuNOOmHwL8cgJwmtlxCHUu09KmcGFSPcJ2/cWeHe3jLyvzJge3AhAYTqoh/PhnSB9DNmk55QiyNfzWUuhriEeWHZQCNZuffDcHH13y+BH9s+PkJ7pKZcjWLRPiR1QEpdj04IqpfGYPZrv9JfjnfwlaT8HDCnwUOCbgqLitvZKvhVVeDyEHD21peo4q1xZKjMqLhjnt1WdD2F47ZMDmCmOxN/jn5uGbKpGwZCXj1zIfOkaUPVlji4PPWny9J0DSPO1H/2Fibr;4:kHj4heRLq5GbTgTI8g4f+BbTBJD+eeQrcz13VJtX7Kn6EuPreLcnewgIFTInoL8GhnNBSzoXJeqhyA9ZK2eN1kTvKJe6THwllDysxdT7do4X6teZsXD7PM5NZJio+RKioudb6pTnfR/USCFRfkhfpT16K5Zcn7+Viss52ft7BmZEsXNSLaDwpVEUFQgkBRBhpmkM80axtMq/os22AjkrXplCJa1rRIxpLZIzXynwp5G0DMJ5D4yChdy7/nn1PH+5/sxunccmA4+vJEm2iZdOl1lypC6Vv8uzFIqlUaawVoKGIoV5h6MQW3yGGG+/xAAT
X-Microsoft-Antispam-PRVS: <VI1PR05MB470156745F30E218F58B75FEAD960@VI1PR05MB4701.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4701;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4701;
X-Forefront-PRVS: 06780E24F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(39860400002)(376002)(346002)(189003)(199004)(25786009)(386003)(26005)(2906002)(478600001)(105586002)(8676002)(81156014)(76176011)(52116002)(81166006)(7696005)(68736007)(86362001)(6916009)(51416003)(8936002)(7736002)(59450400001)(16526019)(305945005)(6666003)(7416002)(106356001)(107886003)(476003)(66066001)(3846002)(486006)(446003)(6116002)(97736004)(229853002)(316002)(39060400002)(9686003)(6512007)(53936002)(48376002)(50466002)(4326008)(6246003)(956004)(11346002)(47776003)(6486002)(5660300001)(93886005)(58126008)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4701;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4701;23:pZC+oQ4sq2prxxVYf71yBtlwN+FLu8q81+h3kPg7h?=
 =?us-ascii?Q?wyLx2KJGJkIV03yDyleWuM46KUqiT+gkR5kM5YGRuzdglyQNYCFUNouvP+7U?=
 =?us-ascii?Q?rKIDYM6NVWgxVi1OsU6fGGMBstC+EkXhSojY+EU9hTQDM8AQAPy1JsiDtcq4?=
 =?us-ascii?Q?tCics7VnNFwCQxWWGB5Zvr0fQtfp8fHBfsX2RiHWD2S8vJK/M2j+EOqgftVg?=
 =?us-ascii?Q?T2B1v3CRKy/CR7Hd7q6VNEkOxfUGP1QL9BH7JAmFZh6XeY35LNVu4IrPl/RW?=
 =?us-ascii?Q?yjOCzRa5ibVCo2idrnk30ljA+6xjRmlD3uhZNNHI+GObDyRs/rNaIdpZUqy9?=
 =?us-ascii?Q?T1Txcu5YNKsUHUVsSjTTHmirJLML/uz1GNFaGUUQIEf6nZyj0G1Q0mDbNLN6?=
 =?us-ascii?Q?UJ5L2gGV4MwQh/P2WhPEBnht3He2aFlshu6d/fP0eiYUQ2vqPQxciD3+16pv?=
 =?us-ascii?Q?H/I6emlIafDt4XMvfrioUM9rk0MmrGhzBUnqir58aNwewtS1fMDDcTjsnpWi?=
 =?us-ascii?Q?bzfRJ0wCqjjnLad9xYWce1/t3i+LSQdcCuKg4IsuInr4SbGEQrJHb2nbBGee?=
 =?us-ascii?Q?/WAm4xzW0r6HwwoLsBB8HJyhqGQ6xWpUVX4h8hylHvyFfmGGsxSc4jU1Iich?=
 =?us-ascii?Q?aWr3AKh2oRWpK3xOf/EiDLb/EcySAOOj94I+4GnGGEvI1oOZ4FVxPX6ScNa5?=
 =?us-ascii?Q?THRAZKu96o/x1aEQBq/ie9qKZ+/zSuWB9DuWJv0koL5nE7U4to8SmkMQE6BY?=
 =?us-ascii?Q?BfmLsC4e6LRjbf9e3fyj8uUnbxtRW5VM893t60j4U507uEDmyv2Xx0jM7FJk?=
 =?us-ascii?Q?g6U5NbNwImRl6SxmueCK6Je4MbufyN3H4rytMtiOjoXOVOTPa1FGuwTb834B?=
 =?us-ascii?Q?XlhtJc7VLRsp40mu79BD8iZm903rYgpIkdGV9fPEvuL7ieyfWYiDU6ytZJ1p?=
 =?us-ascii?Q?0ShWy0W6+933+qJx34SuHhu0L1kwGKn+e3rRXge1wsOhBPOn9pVXB48mHGVq?=
 =?us-ascii?Q?ntpwKMUwmpzF6rZjeJIvtwC3y7XHWhL6POp+8M4b+2zvCc8wdGDHq0Ukw5ug?=
 =?us-ascii?Q?49SnXUuRW2HrIy5cR6r9RxSyOn72XM0FfNTVnl4HlP0UUNFpMhyQmajYFiMO?=
 =?us-ascii?Q?6RTP3RmN7lM/KCCfMa3bEuJx4Zu6kPiYYiS5zkafNKSLXmiwFOgipLKo/uDu?=
 =?us-ascii?Q?J6q7lN97m1qSyCYda/kT5s6VQg2YOq3LrbwjwNsCN7pkrK7OnZ6C+wYiFw+y?=
 =?us-ascii?Q?HRpGikYtuYp71xrTO/eOqnTn+fpXfeVybGJWML6FYfvxZ4oLh9zrBVkJkKKN?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: qs4pFkecjV+4IVB4S2Fy2SIv5+0UUmh722c/qVztfJjQ0k1soLALcDQss4UDn13Sizj8/hrt3ROZexKkPqAadcIotiuSRlS6CNKIEYOOSOb8/CWAOFALm8VU6rm/5G7haEbcaYoEyXv28UuI8dHnxMJ8NbwPlIwHK/1G1EKFZzqyrw/NC0ucz76jR/3AIIqR
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4701;6:sQmhzL7BnENZBCEw195RopZQGdV2/1yVgVSlU/0hqZGU83gKZ2OuLlJutCythvzxD7kZNQKcMPe86JV1a1X7rTjmHtTuKR2tfvNdqWtdhQ1USmr79gZzIRpIPpTSlaim2rAoPVG+mDhMXCOMmd7mXYAT29B0tGUuqtv/3IJMVKzudCLDCmDHL7bZujYiF6PsNfwnvdmkru+ulUFEC7di5fwcD/sHZQm9SRSoErfND5gtCGIX0iNzyHdBP/G3ZNB5hPaN7Xcs0USVGPILFF6s5Si4yd1yQLknzi3l27YAtdkNu6mBWBAXWxZE91ACIWaKMszF7GaRgu3Nh8ZptffVAA0KUT31Arb8o0Rasql0IHLc6qKH4Dy2HoZSKCqHv+3sTD3U6dFByd+vxqgVwBDL2warSIVkESXZNEDt9WyNTMaQOwVZQc2uyhJ+3DnGbwxzEctyxbXYeDCLtOZ5WlCjtg==;5:5FmaWIYVQF4W0MuFVIL8xNsAKofyxsHPW5RGGFE+z6ZnzUID1BEWbAeK4lFE/kGyqpmoJ0DG4+uIooD3Or/J+Fi1PoP0ewKemSW0RslOZ0oeKkQYCFbf9yPMMIkBxtlxTZYt4jGU6NDiEmQywe/1cnl/U8bxw7As4e/ygIYba28=;24:fhAh+zSdwlG0ad9DKly38mott9paHlHCkbKTpqCe9kIWwK1/zQ8yYnuLyK9zyhRvBSxw9DMJ7F9CC7fazOMP9ZStOm8CY4AnLpjH+tdmWRM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4701;7:Aggr1Kz5QBof58/diLBdYxAvgBUe3tXA/w/rCXg3s4x4TitYhSTE9sQUX9ahYn4YXDEt0ygSMXmGZMesv96cNWzxcyh6JBDbB4dZ1+XWvBMuxTa6tKUR1slj67vaPT4B/UvIdiLpSMs2UQtOqP8+XYg7qBS+y9c120+PfsKOWN2F18bIL1rB0BEaFcmoaPW0b3SKvCsIDUKgnm7//srVmkM+0bVOrF83ZuLJHRPpIPcOavWS/fZamqZnkdKvGQxD
X-MS-Office365-Filtering-Correlation-Id: 94008f02-85e7-4931-141f-08d5be40c698
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2018 10:59:34.0114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94008f02-85e7-4931-141f-08d5be40c698
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4701
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 20 May 2018 at 06:22, Jiri Pirko <jiri@resnulli.us> wrote:
> Sat, May 19, 2018 at 11:43:27PM CEST, marcelo.leitner@gmail.com wrote:
>>On Mon, May 14, 2018 at 05:27:07PM +0300, Vlad Buslov wrote:
>>...
>>> @@ -1052,6 +1088,36 @@ static int tca_action_flush(struct net *net, struct nlattr *nla,
>>>  	return err;
>>>  }
>>>
>>> +static int tcf_action_delete(struct net *net, struct list_head *actions,
>>> +			     struct netlink_ext_ack *extack)
>>> +{
>>> +	int ret;
>>
>>Reverse christmass tree.. this line should be the last in variable
>>declarations.
>>
>>> +	struct tc_action *a, *tmp;
>>> +	char kind[IFNAMSIZ];
>>> +	u32 act_index;
>>> +
>>> +	list_for_each_entry_safe(a, tmp, actions, list) {
>>> +		const struct tc_action_ops *ops = a->ops;
>>> +
>>> +		/* Actions can be deleted concurrently
>>> +		 * so we must save their type and id to search again
>>> +		 * after reference is released.
>>> +		 */
>>> +		strncpy(kind, a->ops->kind, sizeof(kind) - 1);
>>
>>This may be problematic. Why strncpy here?
>
> This is not necessary if Vlad is going to hold module referece, ops
> cannot disappear.

Yes, I've already refactored this code to reuse ops.

>
>
>>
>>a->ops->kind is also of size IFNAMSIZ. If a->ops->kind is actually
>>IFNAMSIZ-1 long, kind here won't be NULL terminated, as kind is not
>>initialized and strncpy won't add the NULL.
>>
>>> +		act_index = a->tcfa_index;
>>> +
>>> +		list_del(&a->list);
>>> +		if (tcf_action_put(a))
>>> +			module_put(ops->owner);
>>> +
>>> +		/* now do the delete */
>>> +		ret = tcf_action_del_1(net, kind, act_index, extack);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +	}
>>> +	return 0;
>>> +}
