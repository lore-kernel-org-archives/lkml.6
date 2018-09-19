Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4ACC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA3A2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EbVAsohB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA3A2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbeISSGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:06:46 -0400
Received: from mail-eopbgr10136.outbound.protection.outlook.com ([40.107.1.136]:42640
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731070AbeISSGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzHepjPSnr7G5BmsgkqjT245YgxxNzxSJPFIQK2sFTg=;
 b=EbVAsohBzHefvWdjqEQsj0mopcVYvdYHj09oHh/wvG5ISpliypIK259u7PpHTm0CTtX4WDFuwCDevTxNsPQuE5qi/vXbZxeXC/IphSaIvxCPCuNsmx42FQQEf+tRcgEhr4e8rgIlO+ex1msy7nTCVA8GcKsYf1uF5QWHwzdjqPc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB2027.eurprd08.prod.outlook.com (2603:10a6:3:50::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Wed, 19 Sep 2018 12:28:57 +0000
Subject: [RFC] net;sched: Try to find idle cpu for RPS to handle packets
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     peterz@infradead.org, davem@davemloft.net, daniel@iogearbox.net,
        edumazet@google.com, tom@quantonium.net, ktkhai@virtuozzo.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Sep 2018 15:28:54 +0300
Message-ID: <153736009982.24033.13696245431713246950.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:205::28)
 To HE1PR0801MB2027.eurprd08.prod.outlook.com (2603:10a6:3:50::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61c39c5e-9989-4963-6731-08d61e2b7929
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2027;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;3:ojckWMo5fSDTVGsLg4OR3tVpvmi3MEWceYsdVwY6I9nppAwfK/sZku5CJSjZBfIjTs7qzgeQQoccm8u9ew56E4xWIQcXq4tdmDFTsWDbefXDEOksCm46NXlmmSkD2bjVGN8sQgU7B1y78vRSPa9wfeMXVK40wBwvS5mO2+ZWwh850YQq7/SvsApJI4F5WIQct4eZvKHSPHnHgG/ByBUtjpF+qvDkeKa7UnlDS6j2HPdIbEPlhkwmS4C3ms/vw6BL;25:i0BWeaVXzb27zMGKpWsS+P+I3ZSQs473+r6DHQFU70GqgKjgXv+3anI8Y2v9BwTPAdC85nsmrzvsmUvYoO6pRzp4JAxDh+jknMM2OtSSy1H6hb9SGyYhRDJMZJMc5kZr/sOjqbFKni9VZ6KaLEJNl8K6EowaQxkX3fts1lA07yL+p3Te+76WtJtqh2zcMMuhwyOmp5snCb2Iq+u3jipYLWSDmhblbcrrTmbqyW37gixt67iXBPh5czYZ3VLNCTAO/exfUzLjDmXiIvd3UzTgd/NVTTt/5+X8tCDn43eiIr5+7RYm64jtb0TYkjArJCzn8bk35geOHo86QbCEmMtXjg==;31:TpSOIBmPWLwYxY/7IrpGzjm5Vo24C7ifYsa1RV1IYMMYgwjQ454Y7sKPzVbGsF8dOWhlUoHqiREfkZllLc0J+d0e/HLWTPV5ZjARb60sICoy8lCGvT3BvTUn5IF+u51x+Ld+nwUygqE2WMFyaiA9YHUahvSqyyELUB+sWP19P868aBYwUiFzg+LkuYD5yu68B8RbmN8g54HUQOU4nkQnI351XeJYimH7XgL2y0QJatU=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2027:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;20:xRa1CQa76Z9ymNE/woZ26pWGEoCJtXpCxXN2hYB4DD9GwYidkvTCGdAxE4Qd/gyqqdlskt8NXib6S4kSueFq38/vqmxibXEGtrFyuYDGxaXTi0N/VFhHH7jrJiy4y1eePtGM6+/zT4Q/MQvqoFBR95QzvkjilsBVfTNCOYR3TwvQPDdwEaBrriIzdRjjpW4F3fESfxW4+7j9pDQA3Ns4FrBuNOyDCdwzRK8QcMHUEw4l2IaEqbxOL1kBb6yqrV1Wu68YEdLEL6wX7qHauutbsjH6jIHRLhTMIexMlW8bBwRJJDPipv+ecMtKftVrPGZBs1dDLnW4Pg0ooQIYP1d71fDcEhZv1MCQLAubrOF6gBoSxEU9MuxLE6wVhENS+PlmW3xFTHUb6uvcSzy4bC2IaMxoAExO8+7OPyHPJtIJNoEc2EE5RpLo0DGlUd/xijSPgKAZeipQmy11XV4Drh8RGsrRnNeqTZDIcKQ/tldJxVVOUbVMS9AbEcWalDtxmPiB;4:Pws/Yw+Jpx+FH9GlLDe405iYnf+Hw28H8GV1XFH5pW3S4WqLE8iQQTzMqw0vNpObG1Fc1tN2W1tIv4nNEANXKUmBlMKESHByKqMwLBc+4+17b/3yCaPHgyNA0t/XbDDBiENtip7hUx3ul8nK0CDxabcMEln7jpqaewbLSINexakXze9tX/mvJisT/g9gzzZKsPUgjxlcSa8lYNifJihORe+ks4h2nPDp6U5G613kOqehDXPqQLxtUhCqdFXQnxkZ+SPJB0D90TaG4Y5j3uayjW9+7hYQqfPIBvJ/jIIVHCkUR3VLGQGo9mx8HO5CGbXvpfzP3YpwNdSNSlQO2I6bEU+StF/Lf2//bEKZymzHe5w=
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2027C171B91CF3DA599F3C36CD1C0@HE1PR0801MB2027.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:HE1PR0801MB2027;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2027;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(376002)(136003)(39850400004)(396003)(189003)(199004)(476003)(52116002)(956004)(66066001)(9686003)(305945005)(6666003)(7736002)(25786009)(55016002)(3846002)(6116002)(8676002)(61506002)(50466002)(53936002)(86362001)(68736007)(8936002)(5660300001)(26005)(186003)(47776003)(58126008)(2486003)(478600001)(81156014)(2906002)(230700001)(33896004)(105586002)(6506007)(16526019)(81166006)(23676004)(97736004)(7696005)(486006)(316002)(106356001)(103116003)(386003)(14444005)(37363001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2027;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjc7MjM6c3phVElHbWZyenRQRTZQREhudkxVSkRL?=
 =?utf-8?B?bklNbHc4SElNdHFpUm1xM3hkYSs4UURWSTZER2laaEM2NEw5bGRNeFUvdHZl?=
 =?utf-8?B?dWVUbElMenk2UmF6dXRnQVpjT21YYnJETlNsNVA1T0ZRayswS1ZSR3hjalNo?=
 =?utf-8?B?cGxhWU51NW1nY3N2N1ZTSi9Zcy8yNFFNd0N1b2lpMzFoYXNkWEtZV3dZWlJF?=
 =?utf-8?B?eUptNXF6ZzN4TWJWWFV3RHpmcWp0UXFpdGFMakN5ODBSUHE3aU5HdkJMajlp?=
 =?utf-8?B?NHR1Qks5aXVlMTdkbjNseTNERTQ0VC85NjRjSWo2WWZoc3FiV21wV2o5VW81?=
 =?utf-8?B?Nm1Nb3RZU2p4YmFvUEtwa3F3WTRZbnRRWVAzRFZGOWJRUDYvOFNUQ2VTY3JE?=
 =?utf-8?B?R3dwNlpFOHNsZURLaWs5MnRwcTJDUzkyRDZyNlk2NUFBanpkSjhGSnJ6K2pN?=
 =?utf-8?B?dGV5aU8rOWVWSSs0VHplUWhBR2VudEdBc2c3M2lTOEVGQmM0Y2h3TVNkTHRo?=
 =?utf-8?B?UW9uaGx3Ri9GbTRUenNBTlVCamEvQmhSY2pCblN0S2IvU2pZQTMwcmYxaWxo?=
 =?utf-8?B?RW5UNXRJSk9GbEhXMmhIcTI0OVhuZHVFd2lTNUxRWDNWWGs2RkRHMWovdXN0?=
 =?utf-8?B?dWFWWTN4WHN5S3h6NW9xb3RaRHJGOFAvTkpGa1phL0VkSjlZVEVHNk02Q05h?=
 =?utf-8?B?LzcvQWxRMEpxdGM1K2JnTnZLT21BdHYvY2l0OGM5clIzU1k0Qk5lTXJMVHZL?=
 =?utf-8?B?OHg3TDQwVStrL2lRaXpoTUo2Sm9MWnR0a2hCUzk0UDk4VFVxaldVcndUNTJH?=
 =?utf-8?B?VlJkQ25BYlBTb1Rjc2haZyt5K01OVHVkKzZXaXljcHk4OXRra1JFaDBaR2o5?=
 =?utf-8?B?M21pM3BmdlBwOHRrMUJ6OVFkdFhIemNwRkFFRC92aG1DQVVZbjJJTzYyMEJH?=
 =?utf-8?B?UXdHQjdCeFBtQi9wVS9SOUJYOXhUam9YLytOWjJUazZXWURxQlZZRms3ODdv?=
 =?utf-8?B?RkZISTBncUsydkZGT1JnVGx5eFBQLy91dXR0SmxBTk4xT1UxOWw2RXZKUUdJ?=
 =?utf-8?B?Ylc3ejFrL3F0T0hQV3RqckZ3QmZFcFZuR1BZWllhSitGWnliWWRHVDJwTHZI?=
 =?utf-8?B?a1BtdURWamNOM2RYajVLZXo1K0ptVHlFL2g5anlJYm1WQk1EVlBBKzR6aWsr?=
 =?utf-8?B?MmNhMTVsMkhSLzRKOTFOVk10TmpUNzluRmZTRmxVNEpSWUM0eStUc1RUcFR0?=
 =?utf-8?B?ck10MUZCUUNBQlgzZ0NYUVhYeWZJNEo4MmtodlpQZ1Zmc2h5N0NMc0dJZ2Vw?=
 =?utf-8?B?WUJ3MUp3RHU0RkdTcytvZC9IVFhYTVp5aWxEQXRnZmJlU0p3a21TbDE4K2ZY?=
 =?utf-8?B?RXZSZDY0dDVJbmRsWDZJR2E4QkJidThucHE2d1EybGpEcmU3NUcwSVJzU0I1?=
 =?utf-8?B?cmpWb0Q4dlMzMTBSMlVwa1lUTENMUDc1V3ZIMTQ5aGRTblA5OHlpNU9XYXNq?=
 =?utf-8?B?cTdqL2xwa2U5YVNubmdtS0tvY0lDOTE0UWtSbHREREpGUDZtYTAwS3BLNTM3?=
 =?utf-8?B?T0ZNcmxJdmtqQnZabE5CbGgxaDBnZHI1Q0pVeU5xSWlaMVhXVEZOcTlSRHc1?=
 =?utf-8?Q?E=3D?=
X-Microsoft-Antispam-Message-Info: UVwZWsV60DZIkfzLfFHJz0YWw9zg+iCJ3Hi+UuyPShnenO4QQ1JIV4rTJ+cwPkDYMjwNxd1jTouW5mM2j9cy4A/1iSTro5fKBQFkPlosBy/+KJJeVL/z+36UotiRB5GKWdtjptzu8giSNojIgcBpnQ4X8hh+I/BPl0N5/NayhwrUptwg/l3QvMXhrco7uRw89jpOMi+vGmz8NP1R1ycZE19x8mWGFMpdp/vrUDR2/yp8RMqBuOP5I69lBD1mLU0x4sFf/iuh1rStUs+vvPmvO2jhU9FxF93sdNom858VlYXytmp3A9hCi9+jMRk00WVSGJRvYxfJ/nJ9vKj7/NHkG6BdmdEcgQ2wg3smr+uKfZc=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;6:BJXmk0qj6fxIswuF20MBEhbFyVAcMvlDTmLSvoUsc04+rK1EmnF9hh0OY7i+DIt7I248zzjJ+ShOyabhHU/n8aCvR3MwLVBUS22mt+LUl1C9JUjgEEA1J7gAvXVtJzBmQ4vhZgfdE+37Z6ITQ5gTaLMfVRM0UDc4o6HSM8G4j+P3rMrXoh4I91K4cXoFCavQKTnyZV3c6nKu7z6rRm7CaGQ9y/ybWZszsMzYoaYSrEW6/Pcw+8P8c2YG7VK1jHL/W8J7CCyWRCLubaTb4zi44b06ukViQtHgyM0skCzFp/FvM1BGjPWisszM50kQnRWnan0oTiYd46k0Z3aKLezvYuK5oePlHf3xS7SaoJvE5IREJZ8U0m9x2ODTCXRv5Oen8BeLM/ptHENyT3VDPOLqZxLBvwWNfQ9Gs6AS2N9HKYRIp0WV3TRV7JpKf4hjoEoQsQqJTFiG6aKv4Mu39TOJ3Q==;5:+9/6RBoS0k7NZk/F3swsS0Q7iPnMw/S3xVdbOhgSfmJr1DJfUYHMQ1YSWRSX4aJ9aUY++HEMsmcopAVadtoUXqJqjXEi/Ph1rFSQZFnE4O1J0HfezyeEuu4eSHFqj0uhQILbxiYsG5g6JQuhhVroXOIgISxxZ+7t1LLN9e7d5dw=;7:utZJ5yY4QIXyuCntvInffNyMA6SYBPbM5cf1q2t3X3t6+9QGaVTr9Y8w3OSgYE6m3OLGOJYGfBnn6SesXRndE36awuGNt2bhV+0Q+0pL5dFzGw/nna4uAgqQVGGinJIu9/DqNNQp9VWUjKPsDN12cGru20MWccTaSVs66beYm0u90d5eiLwZrGC2yQyJqg7YwfppHOwsMsDoSpkbZimR5fKBbRMKDZItDCjRnB2yb7dxwL09WsIgXsxY7g1jTWSD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;20:ZhztLwQWJZxlfvxCBTFL43KGcF/n63eoAod9Ywk2lE40857MQts+eet+QNuUWNLUyaP7qQtWUqwDlafu5am+zpSzchwYFda6//kVCYg5xAF8cjW8kAHx50HDOa/0uX9v1+rW68wUez/IJaehYHDnD33hqqT0VIA3FoKnQo9uIHM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 12:28:57.6510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c39c5e-9989-4963-6731-08d61e2b7929
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many workloads have polling mode of work. The application
checks for incomming packets from time to time, but it also
has a work to do, when there is no packets. This RFC
tries to develop an idea to queue RPS packets on idle
CPU in the the L3 domain of the consumer, so backlog
processing of the packets and the application can execute
in parallel.

We require this in case of network cards does not
have enough RX queues to cover all online CPUs (this seems
to be the most cards), and  get_rps_cpu() actually chooses
remote cpu, and SMP interrupt is sent. Here we may try
our best, and to find idle CPU nearly the consumer's CPU.
Note, that in case of consumer works in poll mode and it
does not waits for incomming packets, its CPU will be not
idle, while CPU of a sleeping consumer may be idle. So,
not polling consumers will still be able to have skb
handled on its CPU.

In case of network card has many queues, the device
interrupts will come on consumer's CPU, and this patch
won't try to find idle cpu for them.

I've tried simple netperf test for this:
netserver -p 1234
netperf -L 127.0.0.1 -p 1234 -l 100

Before:
 87380  16384  16384    100.00   60323.56
 87380  16384  16384    100.00   60388.46
 87380  16384  16384    100.00   60217.68
 87380  16384  16384    100.00   57995.41
 87380  16384  16384    100.00   60659.00

After:
 87380  16384  16384    100.00   64569.09
 87380  16384  16384    100.00   64569.25
 87380  16384  16384    100.00   64691.63
 87380  16384  16384    100.00   64930.14
 87380  16384  16384    100.00   62670.15

The difference between best runs is +7%,
the worst runs differ +8%.

What do you think about following somehow in this way?

[This also requires a pre-patch, which exports
 select_idle_sibling() and teaches it handles
 NULL task argument, but since it's not very
 interesting to see, I skip it sending].

Kirill
---
 net/core/dev.c |   34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 559a91271f82..9a867ff34622 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3738,13 +3738,12 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		       struct rps_dev_flow **rflowp)
 {
-	const struct rps_sock_flow_table *sock_flow_table;
+	struct rps_sock_flow_table *sock_flow_table;
 	struct netdev_rx_queue *rxqueue = dev->_rx;
 	struct rps_dev_flow_table *flow_table;
 	struct rps_map *map;
+	u32 tcpu, hash, val;
 	int cpu = -1;
-	u32 tcpu;
-	u32 hash;
 
 	if (skb_rx_queue_recorded(skb)) {
 		u16 index = skb_get_rx_queue(skb);
@@ -3774,6 +3773,9 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	sock_flow_table = rcu_dereference(rps_sock_flow_table);
 	if (flow_table && sock_flow_table) {
 		struct rps_dev_flow *rflow;
+		bool want_new_cpu = false;
+		unsigned long flags;
+		unsigned int qhead;
 		u32 next_cpu;
 		u32 ident;
 
@@ -3801,12 +3803,26 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		 *     This guarantees that all previous packets for the flow
 		 *     have been dequeued, thus preserving in order delivery.
 		 */
-		if (unlikely(tcpu != next_cpu) &&
-		    (tcpu >= nr_cpu_ids || !cpu_online(tcpu) ||
-		     ((int)(per_cpu(softnet_data, tcpu).input_queue_head -
-		      rflow->last_qtail)) >= 0)) {
-			tcpu = next_cpu;
-			rflow = set_rps_cpu(dev, skb, rflow, next_cpu);
+		if (tcpu != next_cpu) {
+			qhead = per_cpu(softnet_data, tcpu).input_queue_head;
+			if (tcpu >= nr_cpu_ids || !cpu_online(tcpu) ||
+			    (int)(qhead - rflow->last_qtail) >= 0)
+				want_new_cpu = true;
+		} else if (tcpu < nr_cpu_ids && cpu_online(tcpu) &&
+			   tcpu != smp_processor_id() && !available_idle_cpu(tcpu)) {
+			want_new_cpu = true;
+		}
+
+		if (want_new_cpu) {
+			local_irq_save(flags);
+			next_cpu = select_idle_sibling(NULL, next_cpu, next_cpu);
+			local_irq_restore(flags);
+			if (tcpu != next_cpu) {
+				tcpu = next_cpu;
+				rflow = set_rps_cpu(dev, skb, rflow, tcpu);
+				val = (hash & ~rps_cpu_mask) | tcpu;
+				sock_flow_table->ents[hash & sock_flow_table->mask] = val;
+			}
 		}
 
 		if (tcpu < nr_cpu_ids && cpu_online(tcpu)) {

