Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeEOMAo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:00:44 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:62976
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752975AbeEOMAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:00:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-8-git-send-email-vladbu@mellanox.com> <20180515112404.GL2134@nanopsycho.orion> <vbflgclm9wc.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <20180515113954.GM2134@nanopsycho.orion> <vbfk1s5m9hi.fsf@reg-r-vrt-018-180.mtr.labs.mlnx> <20180515115739.GN2134@nanopsycho.orion>
User-agent: mu4e 0.9.16; emacs 25.2.1
From: Vlad Buslov <vladbu@mellanox.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 07/14] net: sched: use reference counting action init
In-reply-to: <20180515115739.GN2134@nanopsycho.orion>
Date: Tue, 15 May 2018 15:00:28 +0300
Message-ID: <vbffu2tm8mb.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR08CA0088.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::14) To VI1PR05MB4701.eurprd05.prod.outlook.com
 (2603:10a6:802:60::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4701;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4701;3:bE/QtPDqqTAJulCo20hw4+gZCjGOIAJipYhM/JAdV+rJCmDULLC0vXc6UjBsBOPv10JWU8T4/QsNN3H4ChP+WCrtt/w2366Mi2HcNEm2+Tjsio7+XbrYrkWTTyvUoWqWGBAWuNls0qLVMjNzbAMPr8pAbWNYrgcUy5XRSrSTPn7hBE9yGqfCkECJobMifAlOpQ5PvuF9T9gOud7ArvuDwoi4YmFk4AmxJQGMPNzxixobx4/H061BXRMalBe6e2cX;25:5M+GMlu7fDZYeahnMs2JU3pCHxDjuseXP+lWoVfy9UdEZQNZ1IFmrvBTz5270vGvwd1mOK82mfY+DfcmHGCJhfKbxvy1EnrZaxsA5NC95PEjBXH8wH/Ta+aNlPeLkVdimWFnM3GPvxP0NTNQ1fgwArJYjcy0EhsTM/QzecVdEHqAZuNEdSvq1KGwSd8YAuowUI6dxggjKG86f13grPVPpJK4zSvvdNzJIsh3jedRCgFwkPMsA17nhKTDj/0iE0aDmfbH3GvX27zTHku5qQAzX03KucCzYHiSbHb6z1wVJdd6Yj7Djc7AZQGT6ENB/Xo/1DyCEwPKKuWeltkhLuywlQ==;31:PupQ37FHlMuhF02px9W3AnO6O2VoqpDBVbOk/GvJO8MHuiAy9aiPAzf0999B3mVAl/RX/j+L/v9ovy0PLy9jFOriEZtjwPi54OuufsEUx+FKTRmxERINRQsqfqwz5H8ySwfHV78RhvtY+NanIP0Op7sQ6y3fOlscoWEVRfK7PJNeYt9SvoMeB/MbEahcd/k3DK0iP44TCBF+9AlT/LTKpR5Yz2eqgW0QKkM6LF5CRR0=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4701:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4701;20:EEmKgzY5soEql3CH2K7MNbRVGvS7JpCBP0WyNTl+qDQuEAKZ0sB0QYzyW+7QF1lXhHjnV3AX9rm35rKwR5ymd2gXocyPEUeJUsn/SxTQ/uKuI9pk+LcDqce1hvQ+4CQrylN78mfyz508d4bU58RXJ5OgzcD3zyppGCcjG4PO2N7bh0aTHPAnQluzIc49N9BQw2/Ss8P0cTtgkz4HCESJ4ee/MkpTHHTxSzcaCuHT1U5iPZ1XimVJpujvZRf+mDNdSibykOLSkfGjQ17ChmEdTwCqNFa1cmv78ZXGtuoMiNDJiG6V3h4Uz2s85wdfhvRCPbrQ9anzbE86EBp8VA8XNQ798RMHwHrkp/0wv7dglFhnHfzQSwTo3Z8lhK+MSF9JtcyxFbOuikleVUUCPoKv+WCoG2rjzxZzHIYMG1Zq8LukEtLv/3PDE8yVc/uUJsBiGy1mLSwgkBCLW74qy54fce7cXHNChakQnGTWFno+NVbf+s0oKYRhxW2VLXq99aOO;4:6uaCkkSFMlEPhzYjJQxwrZ3uE8ceO9Qa05OUsPqd6Jjg/MUfubGLaG91bkKFQ2DxGLbxcbA+UE6uY1NvaNL4JgyKX2PpOp8NI9rOR4GWsxUfmna5ic2M6cMStbjV/di8cst7qbdAEQ3v8dQ7we2R96M3YK1t/PT3Ia34Gxhn62SQJ0CmVWuMIVdJSvUBD8Yf5qDYZVeQqjkad4DkxkVg3Prn2+BKBG2Hgu7CSQuua1F/X6fdPEtVh0g81MTyO04IQ8n7lpYXvfPk2JdPDdrkIA==
X-Microsoft-Antispam-PRVS: <VI1PR05MB47019937C6428814376CDD1BAD930@VI1PR05MB4701.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR05MB4701;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4701;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(6116002)(6512007)(58126008)(9686003)(3846002)(6246003)(68736007)(16586007)(47776003)(50466002)(106356001)(486006)(476003)(446003)(66066001)(48376002)(11346002)(956004)(2906002)(6666003)(5660300001)(6916009)(229853002)(105586002)(107886003)(53936002)(39060400002)(6486002)(316002)(93886005)(4326008)(86362001)(305945005)(76176011)(59450400001)(52116002)(97736004)(51416003)(7696005)(81166006)(16526019)(8936002)(7736002)(8676002)(386003)(81156014)(25786009)(26005)(478600001)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4701;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4701;23:BYDV2iO9ImVhVHZzO+Hmvsc9rptxxFLNXoubXtHzV?=
 =?us-ascii?Q?hJxE8nIuIpIw8xZAyHwoytRBfPHhNWRvmvhzhWwAHist0yoZoFnIbLX8HWGL?=
 =?us-ascii?Q?hUQYfsYy3K8Fq88g7BbnwL9YGmSBH92rYr2GvsJMdowcEP/F8t/wVfbe7snW?=
 =?us-ascii?Q?vY4xzNqbVt6eRUGN53L+wNa2fO/73bERDOP9BbqG052biAFzwl+t7znVs0a6?=
 =?us-ascii?Q?tzI44nhKhOefgwf5yhzOeCcsFqU/Qz+NNWYy/MEBgS9gblhBicF8sfxoJf0u?=
 =?us-ascii?Q?ajxmP8sJKKeHU2v/rLMj+gmLaIaQOdCJ8YcS0E0Llpleb2ouC5mbx+6f2iX2?=
 =?us-ascii?Q?eHM296hb+gQG1MqMkoNsI3XKHKaMmAVfsUYY3Uo3FjsbVXeVlT+TigzNVmIf?=
 =?us-ascii?Q?E4zTxxouzRKUUC4mWXK4+DopPiOIXHfoWNkQOAQT9/GrnPVbYCFGmzMZpOiL?=
 =?us-ascii?Q?g0MRmJxBWD44hK+0xrNjgD53yQPQ5a2wVcOqLZmnRGWc0Z+QUkW/VZHvlts4?=
 =?us-ascii?Q?9kuZx4QcWEpgO7DkEziKxiE6Lr7KQptanLt7teXA5UnVwEnd3cvSQdJKrbY8?=
 =?us-ascii?Q?STzN/grY0wqMEq3sZYoQQIOC6/5Sc4iZa0vMqzmTX5rFhZgRvngvWnGNagqw?=
 =?us-ascii?Q?r0cvELjCiHlryI5p9uF23//GSyR7ofoETO6FYhnxUsEwOBc9gHTJiVoJ8EjW?=
 =?us-ascii?Q?GgKIoAI+xnNhC/H9AnEnrKGZkdj5nmtlvkZiVWntOmr8BNdQ47vVehY6IBkR?=
 =?us-ascii?Q?9dkFrTY6+ARKdc61OWGVjBmTH3C+PlS8cr8PnIF+tEjiIeDuvrANj9XpEBSP?=
 =?us-ascii?Q?yDC3BZt08kiZLj+1GfMFW7/6VF+JU4jvNHdy74f+RN3ypGkOHe0Fr+2CyYUM?=
 =?us-ascii?Q?xo5cM/FRb0Bi08tdmvkHXrIoUuSsFapeShCQefLpdrYztY459L82MmgEqOpB?=
 =?us-ascii?Q?xehyU1Hu5ZDcCmPcP3r+qUxidbtkQZkP7noladYqFqgXQFA00pToUfRWosgG?=
 =?us-ascii?Q?UvCKj/2o3w1Rh1EctWyBN5j/Rwpn8XkSC60nvhcLLPnbBw8yN1kHe2vUQQ67?=
 =?us-ascii?Q?B2MuH2izZc31G9gaCY4XVBF2edrBDybaTKOyqcDu3JdBYgm8W4K/oSQ4ggwl?=
 =?us-ascii?Q?IOECuJ13d+xL3SyNgi0MML/2+JLSXvNfOeTmEcN/7G0x6jtenJbKCA/MYusi?=
 =?us-ascii?Q?FAoblc3HcSNwNGYwJmXSPcrwG3hwoClaU/4LONrJrbcotdisrX9SIV0bGfDZ?=
 =?us-ascii?Q?bEL255T8o+yuiwMyja63CZb08+HTTfCYKetTim5+yeMYwqZA+8qHOfDuw7MF?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: FDTO0Zhu84irPninvug20JCflELZBrHNU+/lu9oSoNCjTdDRUdO55TABQ092XkLLTpAvQM/lnlCSFj0svQr+PO9WWG03goizvKbgCxY/hbg+1nZ90/SBP934spwRp/gShxy8joUf0hkZFUwlMY6u8OnV+WcL11KnilyyfAPMNBl4m8NZyXFcQvnXqZoXaba5
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4701;6:nTBI++0pyowNO/yftYJBtAlR8ocwxLUL68cFRQEP0B0HlI+tiNCgIw8ib8QQdZElqFoQcC70pkX/12QzKrCwxEfkjxJb8Cn2jOq7c4t20mlxJAmSWNHUEoTuUuL+1+YxAyOPTGKJGEnTQj8eaxAdTACg1t6zef3asxCUmWxJg2H6D4Qdc0CVFuHlA1QZkplNzTLxQJ9hWqt40or9gOLaDz1hSfIsnv+Sp5nlTHFVM1y/ZqYQm75A/3VnipG/gkfC5YxKYdlDiJVgRoVTP3ETHMNwtdOJd/1fTkFtp1/aN2nuCcWMSrGwN1P9tqcxVcchr0texTl86XCPL3bJatNX14HThnlkPopFWzTi1PVruoPkYw5EDP+D65tr+vqkHbvlDC8H7kblJVsN1qZWbOtqzOsldPsC68VOZ8o/odZkLesMdcK535DB17OPiyibBN1vf/bWjFV5pRiz2gOJbnJ60w==;5:ze0wF2OxULI4jkLCPB964IosY5gWVKVrZLpn+neh52+Uw3MDAB7556GYLsa+gDv7Vbb8d32Kt/wKwi8iMLhlr5nxsjvnUSkwOAtQv0zufbNPuBUokkboFYq5iYiTWBngqxsgMsXWn5ZhDoj1YDm8oJlhEWwIqNAAIsjOyJzBXcs=;24:COz76M5KABq4OL8efxKzjUWkcj0saFkBkbtpUixJDMj8rDKwkuAGGULl84/+y/4dEcNGIMH0TQEYfcLNqyDa2X6gIeu74n9x+C7uIw7AqT4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4701;7:6cQrqdqWGHHGkF2TNGdkA7BMJMn3max5XAfYi0mYjQtz7SZDz/l849zDmk2Vc+G2fJs+5+3AYg2c3IM14FyIBJ1x3f1mWVzeUOujayQtU3dmcxFGb+oJLLWWVZ73d57lXBfWJ0znlcpMNLCJvbS4LzL8wlZUMkqaM7cUsd62sddzC4ycXTIQmkLS0OeW5NI4/7z4899jjobhvs5+Ttm9b1LqZiJUVjEHtwFcBcp/+nUXaL+Jd69kZhnZIE1+NwiX
X-MS-Office365-Filtering-Correlation-Id: f99abdaf-4b3c-404a-347d-08d5ba5b78b5
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 12:00:35.0537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f99abdaf-4b3c-404a-347d-08d5ba5b78b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4701
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 15 May 2018 at 11:57, Jiri Pirko <jiri@resnulli.us> wrote:
> Tue, May 15, 2018 at 01:41:45PM CEST, vladbu@mellanox.com wrote:
>>
>>On Tue 15 May 2018 at 11:39, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Tue, May 15, 2018 at 01:32:51PM CEST, vladbu@mellanox.com wrote:
>>>>
>>>>On Tue 15 May 2018 at 11:24, Jiri Pirko <jiri@resnulli.us> wrote:
>>>>> Mon, May 14, 2018 at 04:27:08PM CEST, vladbu@mellanox.com wrote:
>>>>>>Change action API to assume that action init function always takes
>>>>>>reference to action, even when overwriting existing action. This is
>>>>>>necessary because action API continues to use action pointer after init
>>>>>>function is done. At this point action becomes accessible for concurrent
>>>>>>modifications so user must always hold reference to it.
>>>>>>
>>>>>>Implement helper put list function to atomically release list of actions
>>>>>>after action API init code is done using them.
>>>>>>
>>>>>>Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
>>>>>>---
>>>>>> net/sched/act_api.c | 38 +++++++++++++++++---------------------
>>>>>> 1 file changed, 17 insertions(+), 21 deletions(-)
>>>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>
>>>>>>@@ -1196,8 +1190,7 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
>>>>>> 		return ret;
>>>>>> 	}
>>>>>> err:
>>>>>>-	if (event != RTM_GETACTION)
>>>>>
>>>>> Howcome you do this for RTM_GETACTION now too? Where is the related
>>>>> "get"?
>>>>
>>>>In patch 5. There is always a possibility of concurrent delete without
>>>>rtnl lock so all usages of action pointers were converted to hold
>>>>reference to action.
>>>
>>> So that means that if you run kernel in between, with patch 5 but
>>> without patch 7 and you do RTM_GETACTION, you leak a reference, right?
>>
>>Right.
>
> That is an issue. You need to make sure that the code is without bugs
> like this after every applied patch. You need to make sure the code is
> bisectable.

Got it. Will fix in V2.

>
> Thanks.
