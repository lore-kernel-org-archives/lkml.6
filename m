Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeEPJyq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:54:46 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:51392
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752956AbeEPJym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:54:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-14-git-send-email-vladbu@mellanox.com> <20180516095057.GG1972@nanopsycho>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 13/14] net: sched: use unique idr insert function in unlocked actions
In-reply-to: <20180516095057.GG1972@nanopsycho>
Date: Wed, 16 May 2018 12:54:29 +0300
Message-ID: <vbf8t8k0vu2.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1P195CA0059.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::48) To AM0PR05MB4691.eurprd05.prod.outlook.com
 (2603:10a6:208:af::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4691;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4691;3:Ua69Z7k3viIe5ORZhrG5TnPW9Plear7zxFxBTtgxw5sjTesO7uIRZPiOsydJfmgwhQid053BMkL44cYxe4qt7A2zpYrtZ2cic5RzrSkT4YYMJN1vSPs7f+5AaHHwCGrlWcJRWelX8dk4VNp5TZUQ8NOEDfY2FIiMTy6C4Scf0gO22ntFR1Pt6Iq06T3amCZiN+tOS40YzsRjfF2IonX46vxdVWcDqDGUzycQmUUNhjnYOk+zK55eReX/20fZRNWP;25:IRikI+Imvgxb8YmVbP6j2yANfF0ud/n5YKgSiO6PTIOfqnue/eVyMU3n16VM7b5VVE5g3e6N8fzV+zR1pVSiy/0m4BnAMqCno4Xm1fsa7V72pWhmVGp+plnxlluytcCwxDxt+Xx1ZmT9OIJ8N8MhhDEZJFKAoQvj1qVw3S3K5a+jKiiPPZEBqiDFA6XJHf6biz59b4aW37G8cJceWlt2L98xvnQyjQKiaClibAcclLaxCtHE9UJLFllZV2DKPRlPhJOtEz5b4dppIFZQUR6wc2MUgZS0WiWHhrJd+VJRS3LZwOs8e2pantwEc4TJ6a1bGwzgetN/U3jOmNbs8FTP0g==;31:Ngmddnxr+OSfP2mpqYTVr8BbmFfqPgeeKCEIH13JlGOaG7Es3wQxmzU+r7cB22ecbTUbGD1IQJT8ZQ+Hjqq6YX8PlnSFSoUwYazVOT3I+UYlubY7PHyUeModYAfBc9EHTdO7rFIc5Oijk/rU/Fh1SP/MN+qY6UNHBh3DkHuzCuFH1p4PqvYYX8iSI1gPugDCuOfY66oQU/M8BCGe//T5Ae+UFh7iVgNAUkjY0HR4MK4=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4691:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4691;20:dUtKSsXsdn49jgBmherBV6Qbadq1gOW5i7D8KF5Ne5+aC06njH5JsloYyWoGe7pgfB15IFPY9xIaHYzjhttjq57zLDUJTNxsZf9g/hz8F/nLuBWQw7jT6HAPryH7iPkXmkSbRhifL38Q941hB+hmFFvZkSbucBSq4VJBIxFc7A6qZFHAFkmdrh49kFcAr2TZK8gvSSyXuZhDleE85CmB6oQsohBskNlBEmTZVtwEb5shw8CIfTb3m7AXyVuIalXKiYwalMHIqn0frGx+iU4sSlnCjw+S9K41ka8RAHcT/bRSDawtp26Bwzt0UsLIvXOe+M+luEUyo3LCZObFc6/NbS/txuJj9OxOu1gN33+F1LTMwI/euFQHZkTlCidroba+zxDML6Q9jPeFxW6C1ROX6iPJe5aw7eskmOz+WQ9cDvN74kNYx4uI6fEn9iSM3k7fXPxeRZ6Di9fMfNYl7Sk8G732y0NZxpk0UcxHiTH1j1SrVampz3251M11q6XXHmJj;4:J9ErSSzQgIKcLYHtkYgITCRlVXjM1gibXSmG4vxA6CLfxxPphTo7F3tu6b3ny6qDbSgVPXeMoryXBBK2UnXuLcNOWsq5te7squyr9KPWCS73qDtaui/2tXYE2SgMJdwx5nb92ImzDZBgGcEojCrk1ex8IqN4XUpB1IwfXMP0SJXGcEDt0X10UQ2g5/9oYtqQv+Mng2oC3UaiK7cWgMEwJ5UHdt98UZSjAg1t7dndO4HTy9GWzpsh7pW0f59aMzY2QCU0vQoVHIRYxL1ZX8ThDQ==
X-Microsoft-Antispam-PRVS: <AM0PR05MB4691CDC9622CABE8173D987FAD920@AM0PR05MB4691.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:AM0PR05MB4691;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4691;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(39380400002)(396003)(376002)(346002)(189003)(199004)(51444003)(3846002)(7736002)(6916009)(478600001)(305945005)(8676002)(6116002)(6666003)(8936002)(81166006)(81156014)(97736004)(50466002)(25786009)(39060400002)(229853002)(107886003)(6246003)(6512007)(9686003)(6486002)(4326008)(53936002)(106356001)(66066001)(68736007)(105586002)(7696005)(386003)(51416003)(26005)(16526019)(486006)(76176011)(52116002)(5660300001)(86362001)(47776003)(2906002)(11346002)(58126008)(16586007)(316002)(48376002)(446003)(7416002)(956004)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4691;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4691;23:Lwd0nqiBZOOmXnOG0dJwc8P2IkqnPBj9uGVS37dAo?=
 =?us-ascii?Q?QTTQqx89aJIl/KMaBCASqzhjSLbQIZ7hvRP2P+XLdngWOfy5Gdg371Ms7oF8?=
 =?us-ascii?Q?R3RDZH2zvdKZe/ZIha7s1Ltk7Rnd3UA3EQfNhpI2kdEJO9BYQ8xMZBSu7gsO?=
 =?us-ascii?Q?mDgUCQ2c067ORToP3mX7lGQIezKVzcT8MM30F3IN/br75WtsifbKeFAfAEr8?=
 =?us-ascii?Q?XdQTwlLJhNOIg+S1UOugAJqMBQf9b40VAn0y6+An0i9dZzvYsRoi3t01PCsA?=
 =?us-ascii?Q?7Rcpjio4ubkNDxm4/vXJJLVwmNGg9Gn0UMgVvONmRG/G9UqaPk0LUw36t6Jg?=
 =?us-ascii?Q?lY1VWTUjvpnOfcwCct4PkHpodxZdnjoVqRkZtOy94ve7Rt0JceiJ+1nbKkYc?=
 =?us-ascii?Q?ankRjOfW1cb8CvFsbMOI8wguDxlSbQj+1aajUMfI1B/BFhqgl+49jPMlA2E6?=
 =?us-ascii?Q?dn+J63Cc/mBzl4CAq4GG0cMPJrBJh3uci5NfTQXsNK9BD7IFcHgYOb/k3E78?=
 =?us-ascii?Q?Uzv/Ym6y9EPZZ0T8G81EOqm5K1rnt/N6yRrJMa9maKtnt3E5WV4+LQCzZCay?=
 =?us-ascii?Q?ISI7Mq1gbAOl5HZD38qDpSqCY0TxEclXkQFqUaciEUKC9QowKLgWGqytHBdf?=
 =?us-ascii?Q?5k0X/CbX2vmbNzKGjdZTuOoldbWH1a9jt9BAjwmOtl+sUYmBwxfhf+4rIS9z?=
 =?us-ascii?Q?LMYgFKAff+9b40wq5olZ5AZPodY8MY2W0Nv1CsTVhI4NDbLAIKYvQJJOFb0X?=
 =?us-ascii?Q?CeLaylpL5mFwbNJtCrE2qHPPLHiOO0UP8ZLDNNCAqThBzz0NlDL/tPgJyQO2?=
 =?us-ascii?Q?hfGMYFEvvL5IRuza2NXlXJhifX7yMMOzNvgYgfHbbvRSVcMMKzi59GpNQSHV?=
 =?us-ascii?Q?WWUeP8iOANIQN53X8ZPtjQSxe7xJ/X04mxN0L6Ge4nPOMBPAl3OFzWAnOhp8?=
 =?us-ascii?Q?SNNi7dc4ivAFjInI2/iwuyL97hz59GiKrZDgU1+DE5uFgs3iXrnLj9x3cj66?=
 =?us-ascii?Q?bXov2DQJ4594WwNhBOyxFEDG0BNLavf4pT8CGOgNOHWnGpVyI3krYeLijYsn?=
 =?us-ascii?Q?rJ8eDMF3t/gkoMy9m99ZWGo7YL6NqbaePJUJxES2KDwm3lQcxkz5G6YbvFyZ?=
 =?us-ascii?Q?TDYfB240+A4F10bEoiy+B6lFq8X0zokxV4WopUJ/336nOnUQRk6peoqpWzrg?=
 =?us-ascii?Q?XyJVt2WhC5+eK/YuplUHBOotj7PVoankvErLcegQw3okjfBsuiXV4XZ3+zxt?=
 =?us-ascii?Q?poWXtfxF+GwkO0Z97+GY7B4vQhj9KNukpxWn/8r?=
X-Microsoft-Antispam-Message-Info: PxY/LPA1E0ADGXwwggMbNJkRmR6iNkikiV89UIEELvy0uLERR8E0DNtLPfm8ue1ataLNS5NxSiPglUoom5DS7zl7N+Hdo2J1AR1vUnBiPhlwfo3pL+3WHbHEQpkbAcRfzEPb+31NfWFF7NAxlh+8plwiT3FFzht6FGE4qu5BtGZXTwQzhmlSSCmz4kuqouxY
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4691;6:KHCb4OAk3kq1l5Tuu95F4LKGKXisaV+UPUVafMa5L6Cdvf3OSMih6lubWcP011OAl/dJ2oFTVnnFFMDH5snCRWzKIzZzg4UlVvDsDkMMxG5oGKViAIZpZaD/3Kb3cVWiO9JF3LkVPhmbiHDVGu7OMDhZHMieSMaWYuVmwU0Qxk+53zi7TjOVqpCrzsmqpXmZSBpohnInzKfdARAhyTzpUB/GRFk6KTh0ohvovmgwuO4iBe0W0CWfeBiEdItY7iJj3uJZkRJkdLHdhW5hPUwzb28q6/ww6rxLtzJb4nFiwdA0TVGaLYMW21OK3jz8E015dQdCiPGOx3ORC0S0F98XJFaPd6RAvdC86irramVaBqETYHkOz4NONmU2YBsU5pbBJdm9n/DN0YvFb7RY9BVYCY7MJiuE9g2x1m3AuGPF8LF7ELj09PUN31gx5FRwL0Nwg4sZqtkQbbjgZUgjWW07UQ==;5:Bc+6G4T3u+1e+EWkEoXbja342piFfQ2R9gitYWTpgrJAw4J9bWFvhh1376WT4KV2BD6DRJ16Hx3C1tm+0qmqEQAn3RNQ2eYkb8oCE++hQhMFW0gIf1UEjkxyGXDkMSKFVAsodoe0FvZ91Wq2ThAbr58bTfMch3lst41qIy1ec7Y=;24:zQigJGkjvxP6aWo339vG80UFjKMGEbYJa4nrlLrkayi5HAT9l4ok0D5TF+Hz5b+yeZOCOlCEuqFeEpwLN7v8ch8BHmfGECTjx94BYh5L7E0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4691;7:7uTqSJAt2UkPQaGREzYHpLJ3YGMAuXWBOwvOBdtODvAWS7COv4Y0lKwFc1na9eouZa0q31fJ5l1PLLbVZjFGNQ5HkRV8x+tDiMNPQMFAcCEX+I40SxF4E2u6TRGLrMqCekBPRai5wNVguWYEXGy5fcyMiSebEE56nI8aOyOdNNAfMWO7KcoI3hj88f11qLvAlZ/vix3jbWHaIPrUWWRN9fRs8DC6N2xwAzqpRAi1aTu/XIhfGD9isgsm2joDoLlE
X-MS-Office365-Filtering-Correlation-Id: 06194399-be1b-4326-02e1-08d5bb130972
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 09:54:35.6438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06194399-be1b-4326-02e1-08d5bb130972
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4691
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 16 May 2018 at 09:50, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, May 14, 2018 at 04:27:14PM CEST, vladbu@mellanox.com wrote:
>>Substitute calls to action insert function with calls to action insert
>>unique function that warns if insertion overwrites index in idr.
>>
>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>---
>> net/sched/act_bpf.c        | 2 +-
>> net/sched/act_connmark.c   | 2 +-
>> net/sched/act_csum.c       | 2 +-
>> net/sched/act_gact.c       | 2 +-
>> net/sched/act_ife.c        | 2 +-
>> net/sched/act_ipt.c        | 2 +-
>> net/sched/act_mirred.c     | 2 +-
>> net/sched/act_nat.c        | 2 +-
>> net/sched/act_pedit.c      | 2 +-
>> net/sched/act_police.c     | 2 +-
>> net/sched/act_sample.c     | 2 +-
>> net/sched/act_simple.c     | 2 +-
>> net/sched/act_skbedit.c    | 2 +-
>> net/sched/act_skbmod.c     | 2 +-
>> net/sched/act_tunnel_key.c | 2 +-
>> net/sched/act_vlan.c       | 2 +-
>> 16 files changed, 16 insertions(+), 16 deletions(-)
>>
>>diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
>>index 7e20fdc..0bf4ecf 100644
>>--- a/net/sched/act_bpf.c
>>+++ b/net/sched/act_bpf.c
>>@@ -354,7 +354,7 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
>> 	rcu_assign_pointer(prog->filter, cfg.filter);
>> 
>> 	if (res == ACT_P_CREATED) {
>>-		tcf_idr_insert(tn, *act);
>>+		tcf_idr_insert_unique(tn, *act);
>
> Seems to me that tcf_idr_insert() is unused after this patch. If that is
> the case, I think that you don't need to introduce
> tcf_idr_insert_unique() and just do what you need to do in
> tcf_idr_insert()

Got it.

>
> [...]
