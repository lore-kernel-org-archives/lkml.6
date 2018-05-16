Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbeEPKBX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:01:23 -0400
Received: from mail-eopbgr10063.outbound.protection.outlook.com ([40.107.1.63]:56126
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752274AbeEPKBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:01:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-12-git-send-email-vladbu@mellanox.com> <20180516095416.GH1972@nanopsycho>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 11/14] net: core: add new/replace rate estimator lock parameter
In-reply-to: <20180516095416.GH1972@nanopsycho>
Date: Wed, 16 May 2018 13:00:57 +0300
Message-ID: <vbf603n2a3q.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR0102CA0086.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::27) To HE1PR05MB4699.eurprd05.prod.outlook.com
 (2603:10a6:7:9a::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4699;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4699;3:itb8TIOb4isSQJGJD2+m8gpq0YpPzJN4wBrJAqWgjOgQJ3tQWhQEoq2kWy1NPBYZWRyEVSpp1LRxF6ShkCZ2wCqZyr4XulTaqo4D1Gikm3yOxmJXQY6ph8BaJ6twnJstXUpccRMsxEq2THDfEXr/eF6eAjkmNXwvX3LfWYENsJ4iBrlN9p8+f6s2uhXPlEjf/p/+i07+cl8LkebjyjsJuYAYFvkk5DL1W7WSJDd4dxQOmNCW4VLrqibZYKqzUOgv;25:JBtUbeFsCn4YvOULnzveDb5uMFaCrS1LwRBQsVZRF0392Qif4kgOiuq5ka11WD8hod2ts2Lp0CKzqa4GnX2ekPi6VIHbr+vWIJ2m8i5eCzcw0EskCOfIeSUzVvPi/+CekHqiSOHhiS/ddWz+ja7z3H4gPkdsptnU+VxoF+e93LGeIhejVgr/JdVQO6M2BUkYI0BsEgXAcmOqgoHXWakNg100Rc7Qi31eVZCB5ZvnqCb12BUdFL1XFHscA9SHnWhtwJwb0h1gm1eEE4eHkM5hMnjos65Tv6NDbWRKn6c7Yu0bi0QBXUbjfef5lZBUrW8tKWt/LQlC/8MGKJ2bgmuILw==;31:4YhtfIRkLWBzrWBOrTBYCslBmswiK2vpuN5NNbdf2HsrrgXLiYCvi5oEf5AdVzBlV/FTNSaFrl5K4scDzusse6CPCmUv7TCFUM13gDxMd6MMXkY3biPy7LVLkUoUSP8NRC7OaSvqNJ5Tn2fG4ridODe2cNYnYa5fTDmvDZPG5e4oPgv1GtaxV6eH/RrdIrUhO1I57UJ2mQidlJwOAzh/BsWEldXXJ1/VWNKl5Mu6Dqg=
X-MS-TrafficTypeDiagnostic: HE1PR05MB4699:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4699;20:AcHH7HgVU19Jkil++PG86z9wMesCbyjuN8LnggnWnloRFuH3On0apfBHqJaZE71gbxtG9fJ8KRO6lCiaDbWQVuYJy9xyRLHoUmnspohLyTs9TKpY7wJ5RR6IFKWXwhpr12AreSvWDqHDkM0UCaI9WdwrLFfhPARzMslSJDTej7/tWa5k23eL+6nY3fZ6DTq7ykUkF4z6NTpITjQQHalGX311H/P6akbrTCG59Fa73dL8ZgUbM165RQs5xCKZ4el84W0SNBok8w+YrUmvPC6sGSum2XvpF585QRrGZr2ZXRfQt0LsQUM2I8KaIrdXbRZLjUfIyKtTsy/PcykD1awoUioTT+CaaqJArZH5bjPodSbxXCGOR0X95fn4I09VcV72X2y9laa859XQi9crjNLmvl9XEQXxc0vK4PJqYxeCEqKhtQvcWTOApa3eYBJ2yi6pL7QkJlS3bHHtULu4oAXGZaDimmudG3tfBDoMxaoLvraiByF78ZzQbVPPlfcJXjqH;4:oAO1pTZe48H23eBSvtqPaCSQMrdxYCrG7NHhiXLAACkaqbAp+wpKXHPrcIM8ACCaLBOufNnfDBPfDh4VEMEVWk6GGa8jhw9QWWzkFh0NrogdJwmpf+8k3WEgVRuAHm+xeKU/oZlPvJhI0NOF3+Mypeseiw+uwpNrHa0wz/7XErIVIn4yboiP884lOOLC8OMBZE4L1LyMb2iO0QcAKFMAU+MRGfZEI2tDM8q2eD4lLFJPvWZD6yc3ioVpagBzna4dg+4tbaXhE6sK+x1QC8RBf1N+Bd4r1wYASXuX1x2DYnK25w8wwUaXd3Z8lw3rNT0h
X-Microsoft-Antispam-PRVS: <HE1PR05MB4699FC4A5F84EC9FDAD8B339AD920@HE1PR05MB4699.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR05MB4699;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4699;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(6486002)(7416002)(446003)(97736004)(229853002)(48376002)(5660300001)(58126008)(50466002)(16586007)(68736007)(316002)(105586002)(476003)(6116002)(486006)(3846002)(66066001)(956004)(11346002)(47776003)(478600001)(106356001)(6666003)(6916009)(25786009)(2906002)(16526019)(76176011)(52116002)(8936002)(51416003)(7696005)(59450400001)(86362001)(8676002)(7736002)(6512007)(107886003)(9686003)(6246003)(81156014)(81166006)(39060400002)(26005)(305945005)(386003)(4326008)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4699;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR05MB4699;23:hrmyDdK7iwTV6WR9DJNGAb9Mk/upwhNQ7E5tNctvk?=
 =?us-ascii?Q?mKeeZoLaGbpLxmnwd3JrBq58lgMzeBb/pGVJg39flPBP7E0cTVQUrLG6h+zY?=
 =?us-ascii?Q?Z/EIAugGJ8WSP61Znj8N4VgJO6Lc/XrL6bo8Z48pLRlJX7Ls5ALuA8NHlLKG?=
 =?us-ascii?Q?VMhcO6q+5rZZkmn0i8IOa01+deZSWFX7H0BiVAE5J8KJwbnhUfNhgF186FrL?=
 =?us-ascii?Q?1W35pdpHz4X3jvHwLaJVec+h60se9dFylOzfwPNamQCUAkprcsInpskkSfKN?=
 =?us-ascii?Q?YlRI2z+uc4xqmr3R/MV9RHs3Kc1cVU/PZzNlQvaL+N3OVtS6o1oQgF2CS56U?=
 =?us-ascii?Q?GrioLaUTo15hTQO9FhjhVegVmoizvlArK2Rl4wQHCj1MrPWhQHXW1kjwcrPr?=
 =?us-ascii?Q?X8AHLxW/WN4H6Jk6Vkk3GM91NdA3GSgWvrevb2Ns1AEbG4wUfsetzdypixM6?=
 =?us-ascii?Q?N1Bj6kza4Amj2mGyAbMZXX9A8KgmWyO63I9GALROZsHJNLrlf5tDphG9xRbE?=
 =?us-ascii?Q?xiCDZdQLTz9co3krdWjDEZs5y+PJh23xtO5c6CFPe89iXM0Rl0vkH9XpVCzd?=
 =?us-ascii?Q?kQiFmtmSt+9eLx69/OftT6qwpifrWXtrGwk0SO9wtmZ2nX2lius9HqgF3TKs?=
 =?us-ascii?Q?/vpuQwIOCPKx/sN8DC8jnpKr0wj4EU/DeNO3WN2J1hfb4ywSXtktYWj4nqtc?=
 =?us-ascii?Q?zWF5we5p+gpw2F0nvDQmxKg9VS/NotXofuSUmD6QWDJmiPJS+fVHPJLBuklh?=
 =?us-ascii?Q?ecStsF0CrbADRDuuv5DgvZuISPyFAb2mSDmqBuMBvXg1Z7acTO5J6TbKMq4m?=
 =?us-ascii?Q?7Eppaevsscl6+KgkZyT5Gxv1h2HLPWdgXXeC+sZewncBGvn1bqvm8Ml8oLOd?=
 =?us-ascii?Q?pHx4DHsOi889KwZ7+hALLwuUwmp1S7xQB6w93g4CcBI68Ui2lyG8Uj1f04q7?=
 =?us-ascii?Q?ChS2AFfyJRBK4409XUVCq/19MJcHfvgZL6DmZLEEL5KiGwGCVlQpbSR33AUt?=
 =?us-ascii?Q?hmBWvawKs1VJLPf7mnKpnhp6iKg/qcFIY9MeouMroiQ4E6Se8yIt3qRc1u6c?=
 =?us-ascii?Q?cUsxHmyEk468bXf0m2bMb8UYEZ6r/4xIO88WzGF2BXF86ciCCBxhL9pc4Zu3?=
 =?us-ascii?Q?ILDe30Cl23D6f1h/3KVnbCMdl9sxoyp8eGhsig+MUFPp9Zk/517MNxyfITD9?=
 =?us-ascii?Q?4KoGq+j9wrLTLLSGG/U9pWmuGD3W4ot/oJUx3FvyqoF83l9If5LjMkf9KqE5?=
 =?us-ascii?Q?PvmKP6b8LIUAHXxwF9yDJXgo0RREyIcw+/BWCsB?=
X-Microsoft-Antispam-Message-Info: FnS7L2qf7mWbUHe5W3IDo3GXs0cuSrfWuLb6em2NcgJg0h6iDSlPwrMmX+RSxzooec8NCd66lkq5DdEOQvy3P9wHOG45YfLOMWC0aouKj+9DyDlfnOKH5CCOovLuA0/juHROrcY45WYWB0CjU5ShVkjrxvzY5FEVC+tSf12t+1/L3gJXtvcUZNcfrj255ZmO
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4699;6:7Id4UCAeOWIYnlrI4rI48MAXT2TuoC2aBBrrdo/bpz/63IntrF6wNCWMfPTG91sTkV30Gf3p6tZErXFDXxpsFR9tAeKpbX1i3ft1VFP87JURQ8D2juNZGLE0q/lUKZ2iYTw52IkZwTe5gzvRuCS5alDcyvgZnkHnzOMByqIT7HQ9nC9wA9QwDQ8nzJRO+E9p7F+jljUZda6/riSDxtqnclXF5+wOmX2Ze6t2b+H43t7PFX/lY6W4jXEnW3kfOLuNwA8AiNeMa223QDIoxQDsC89lBjPGCUPvHogRLyZ/YvAkVf1vmo0A/5oWR9/bayq0zXdwkRP/pyJeKFxBpX92NHXmoV9X1ZaHBuBXNOYzJyXa6RQCo29bMziPOCe6zhsmgcE67YxX04RWUR5XJgqqsjcWyK5BipbQ2mf+V4VyzdeYCC1lLPcm13powbETWiKw/xOSjBclKD+Xch80aMnBAQ==;5:uc6XSqMll1ZlCUf2640d65jf3C9ZIhVg2d3FAAxzD9EP0Qreo46Bg1s7pG7WR6ACNoY/ENDYW8JUQqrsBxUODtBQTSTLLhcBJ74PiGadzLf319Sw/P6yCp43ySp+Jc/XRCsmH0mpd+QWK1hsqPjbq+gk8nt+UOl5tiJcSnW2XQI=;24:DROA7MpOIMEOJspQ3yf9NmI1wmbA0G0ZQ29Yv3PYlLHc6yLFYqS1zVEFVqyFU8+f/cofZoL9RXnzZ6vUQLMaHFtumaA8jha/u2et++aBqXE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4699;7:ILXGcw0f9kwRUoME9++Mfn1G2tOUZCod+q+XgNV9fkkQr9Luy9UDcEVNTuHZ/Bl/GWcJtIqbL4KHYG7BKsAsi3sWKJch3HgYljUj4qSa8L4jZLKMgq9c7yzRAeFEDaUnJEcm6oDs4t9U7dQV+uSurajZPfQNNtglM8pjJwmvVAfaYcLqpwNK3g7AyiH+j4TKhoWPy3bzn18TaU0sfU3O+kGzMfR14zhZUSh4Ov66iBEKH4CRgX+4w5mAMoqbPTFk
X-MS-Office365-Filtering-Correlation-Id: 857aef1b-6342-46be-9a9e-08d5bb13f1c7
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:01:05.0143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 857aef1b-6342-46be-9a9e-08d5bb13f1c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4699
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 16 May 2018 at 09:54, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, May 14, 2018 at 04:27:12PM CEST, vladbu@mellanox.com wrote:
>>Extend rate estimator new and replace APIs with additional spinlock
>>parameter used by lockless actions to protect rate_est pointer from
>>concurrent modification.
>>
>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>
> [...]
>
>
>> /**
>>  * gen_new_estimator - create a new rate estimator
>>  * @bstats: basic statistics
>>  * @cpu_bstats: bstats per cpu
>>  * @rate_est: rate estimator statistics
>>+ * @rate_est_lock: rate_est lock (might be NULL)
>
> I cannot find a place you actually use this new arg in this patchset.
> Did I miss it?

It is used by specific action init function. However, that code was
moved to next patchset due to patchset size limit.

>
>
>>  * @stats_lock: statistics lock
>>  * @running: qdisc running seqcount
>>  * @opt: rate estimator configuration TLV
>
> [...]
