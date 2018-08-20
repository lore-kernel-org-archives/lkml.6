Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24D8C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520902152D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N02bLtGL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZUknUpSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520902152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeHTUgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:36:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35938 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbeHTUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:36:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7KHHNOa032049;
        Mon, 20 Aug 2018 10:19:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=mCLJpbv+NAj0yQPLfmpM91REzOiU5CRCNwY/dacZQqY=;
 b=N02bLtGLEcsQWw5VAVxtuSOPLQyoYF0F2tB5oexPc3lAb96+lv9lzuRLYF5HMhHdDsUB
 zflwJEms8w6Vx8WSw3HQUZen/l/xQQr1SgidvvTx2tJWJiNW0zFr0Lq/acBuYe1JOQ1R
 rEFh5QqnZECKVfqNmPXWTzg+0NPAzELjt4A= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m01bt047s-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 20 Aug 2018 10:19:16 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.18) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 20 Aug 2018 10:19:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCLJpbv+NAj0yQPLfmpM91REzOiU5CRCNwY/dacZQqY=;
 b=ZUknUpSBF9K8UZ8bRIxayj4yaaXjgT4V9tEElZJ0AOWFvgDAjmqyewQa01pvhuHvRefMUsVg0cjwk6HYWdTUcqg7t5SNeVorhJWrAqZP/lJZBwKBIRuSZkdR3hQaz21HqJ61YzuJRBsnEU3JaeMrPZqDZ5L6oS7qhdCXPOFXHgE=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::4:6489) by
 BLUPR15MB0161.namprd15.prod.outlook.com (2a01:111:e400:5248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Mon, 20 Aug
 2018 17:19:07 +0000
Date:   Mon, 20 Aug 2018 10:19:01 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [PATCH RFC] mm: don't miss the last page because of round-off
 error
Message-ID: <20180820171855.GA3993@tower.DHCP.thefacebook.com>
References: <20180817231834.15959-1-guro@fb.com>
 <20180818012213.GA14115@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180818012213.GA14115@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::4:6489]
X-ClientProxiedBy: MWHPR12CA0054.namprd12.prod.outlook.com
 (2603:10b6:300:103::16) To BLUPR15MB0161.namprd15.prod.outlook.com
 (2a01:111:e400:5248::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b05ecf5-a2ef-45cf-4229-08d606c10a69
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0161;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;3:Swn995eu5xGcDiPsAhYxLCSLmcplXMp46RUgidgDsNZ9HBCoqsXtKJTSaXYWU4glaecBmuv3JGLwlP+zj6qR7Bcfbejke5tuCyZFFwisC70T3cq4VkunBvopVABLBlLVQnFpEIxPAag1YDrZbBMclsZsXv76McMz8AXuvySy7TKR9gwxAikcaIkoTzdeg+4kkZPUawuEsSfo3XEuIGna7UJm/cT1GDg/15EmN4hQJxXMOJd+1V8TL+/UxN29rTke;25:dP5ncRi5mxuhTamSt1gfJoVClA+2zpMEFsnOCILAl41u2kocCAwyOObKKECmEDXIAlAvDWmSriHBWKOkzJql75v+dBrNnP3NwBTHo1gEpiL7QTV+8aytIC2rLEaN/lb2ota9ECQHfhsRYCzmvKN6ikD8gaQyIrEbwWP84jJP4x/SVrSoOi+4K3+ZnEXDpdOInQPl0MpnO/u3A9F+yZyNs1uUq2v/BMCc8Pyq6h8yPYfU2nevkS4fUqZi/1mfw8wzdRL1gNcBi85AAD4hbliiQwSfvlkAACORgiox4ghOarN+r/6VHdYCYzJy8Y+LhM1wl0/n+LhW7CFi87ms0yZGww==;31:1OYDIrOqhL2OhuF7kONtOmf1YYBMi7tQXGZ0zGEgEwtGBijqsz/DOpzK4Hi2Q6sxEHEC2CFYBFhti8lRSxxyUnMS//pmALnTddc4rmqLD1gbcngesx4gYGiB9+yN2Q/zcGj8ZOKZk+sVH2l0MCHdRqZ87i9bVfiFwMQbgUnDM20Z/7so21H7rLgcsbJYjT0P1krfP2S5FJjip5KVxSKF7uRm63j6L8AqoW095l1RctI=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0161:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;20:2nmq+/RAfEyxmJX98YKzTMafx7VJw7g/FDN1py5vLJBQTH/jjrgAVzU9lmxjiETNXIQbUSOaog3vl/ZFu3qVLAlElBljRf1LQ3QifEiZhJNxw7MyxhJS0KtzAnGEMljt4d8CQHB43Ao74iEYwHYdqVcMBCZb1zXt2W9+iu94fYBqRqIemrUcObXilRb8phGszPY0F/nu/mlaBlKuMxQ6fQm4VG8MMOtotGfKa/dLhcojWKFWMV0KjsLodC0JltgI7BxAkdbqGojbeiurcOEmnCaf4/cic73+vFT9RqgGekJ/4L3e1OYfQEp42LnWuWdrUqlXnpAAnuJ5TAL0jTqS1hbHDFvziCOlkI5MTX4EIyhmlSH4cD6PQrA1LZ0uczB8+IpMhdzSpaSnvqBgtF/UEJW5zcyE7mMPMuUTafUy0UsQMJG2kW7o4sigXU8GsPnZnttJBwheOMeUR56N30JdslfmjkxyoO2wiz+ERDISZA6PLJERgaTBYRSsgvthNVvg;4:MO8gBa87dPd1cSpnu8HOA+c9M3wjNjKbHieNMChdsM0sZvV3xSvofg7VOA+ERAqrHo+SbTKD+MTLkxbmSGcSj7vG7X5wcyVvaxBF7OD+5b7lobKMXWkQqpT9FEq045KjLkn+uVjWIuMkTaXuFYZAAWPjBNdIIGUQI8wMe+7a2POmIDwdZ4N6WAEc7i1rcugu1M07vas5q4Og891AVRU9Aqh+O19bfzAcps0s1eKY9MGiQrJLbez7kKe0hzS9o2rWHreaK1mhfW7FBkeTalVOkA==
X-Microsoft-Antispam-PRVS: <BLUPR15MB0161FCAFFA43F0DBAD78A53DBE320@BLUPR15MB0161.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BLUPR15MB0161;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0161;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(366004)(376002)(396003)(136003)(346002)(199004)(189003)(76176011)(6916009)(6116002)(2906002)(186003)(16526019)(316002)(54906003)(16586007)(58126008)(229853002)(5660300001)(105586002)(106356001)(52116002)(68736007)(50466002)(52396003)(7696005)(23726003)(46003)(8936002)(6246003)(1076002)(81156014)(81166006)(47776003)(476003)(478600001)(8676002)(39060400002)(9686003)(4326008)(86362001)(53936002)(486006)(97736004)(305945005)(33656002)(11346002)(6666003)(55016002)(6506007)(446003)(386003)(25786009)(7736002)(18370500001)(32033001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0161;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0161;23:gN6Z57ptrUmdSPPY3IOUbYWNMZXyHH+CzZJ1w5nts?=
 =?us-ascii?Q?1yXkOHsZo1ASd9GHXsy1DIhaf4GkvLEtoQjluAVLd0b4oCzzevhmr7/lzLIj?=
 =?us-ascii?Q?8GpRH1xCdS/qKeSD9NtxK4hLo+ei7O4GGtS+XcUzmCkEpkJHhnGmJmszsb+s?=
 =?us-ascii?Q?HpCi0qy981XemhaCDN1WNtGFV2pdqIcDoONN79pZ58+w90QNS2fe5LrkB6Y6?=
 =?us-ascii?Q?XQdLts+PIvq5PykTy1rwThhOWOFL6ixSSKAE/EAyCUqu2yQonWs0U2QW6OTK?=
 =?us-ascii?Q?YBAE4/km4SSb+V3FoFlhzf9qfi1XG4ZYcO9jp2w5ZkDYiEWlDDXyw6UoG2KN?=
 =?us-ascii?Q?E4zyXNaiB+96Kj/a997n/Nb5QYaenz6KjzJTxYsyT+KVdw4gElyfDyo7YUpJ?=
 =?us-ascii?Q?3CrjNZ1Qw9zheCWQJ18kdKQjEyuHJqo4HKz3GAIbqgemPgT0Xv0cPbTxupjd?=
 =?us-ascii?Q?k4aJmgi8fqhEJ1V3NuqMIbqya/xYWhgpEuHvo0m8ssWRjTk68dyXDlnwT1q0?=
 =?us-ascii?Q?9miwt+X5zbIaDmXvUzZAi7VtVmdKzA2/+epDQ/MVMcQwAgqH9fFnFPMcmjrK?=
 =?us-ascii?Q?DJ2EvSpdA2WUmQxMR/o0slWk3cWclFRVyw7ouaoJcQjg1Xncp0wfy49tIrn/?=
 =?us-ascii?Q?a3rgsSV7zasizasELkXUTNvx2L0K3MTQ7BJRZNomOU605/GXkeIMS5rHY6pa?=
 =?us-ascii?Q?vui8ohzjIfx/ItaU12VHA/DL5VYd4KZf1r08RrfjM76B0IqSN/GXDZrCq2IE?=
 =?us-ascii?Q?kCVPvJS/sx4JOJCIP0j/c9v3vnyXNl268rB/MzBteMUG4MG6Ek8xsbUOQmDI?=
 =?us-ascii?Q?3/qr1kzwCXTFb854MTXf8IldTA2iLqcUQmfmSsH8EwNyKeVVea6OLb0lCNtz?=
 =?us-ascii?Q?iJeCWKEM8XrL6vkKvhuqNGnP4JEqJZa17G5L8mDW2vNse22AK1BLhuGa1urL?=
 =?us-ascii?Q?jk1gsRFKAeX/f4klBY5HwStw+KHojfzjYGYv8EXhMBzkN9AweL2YS4S6mdqu?=
 =?us-ascii?Q?J08v1HjsvsWsa3/c8ouQh7N+qHVuQwEYrIApOX20GPLgeWv86zEXt5vSy6i6?=
 =?us-ascii?Q?B6rbGcYW2xeXo5Vay2SzzaThqi5nWqvaQB9l0KJky7oKTMnIFCm6+UePWNXm?=
 =?us-ascii?Q?NOEOPd1j9oF8L9qyQ5A7rPQwG05BAFRyaZWa0P8Pv6tlulzyrXhDPFFsPTHN?=
 =?us-ascii?Q?Io5m1VVqRG4a7ehOx4Cx0mezgGTbBzUy8Weq/4sbqVkY7WADeQLJjCXzgjc6?=
 =?us-ascii?Q?9xWgHCpQgIwXIj/2sHYTBYslW2kMx1rU5ja68gQ9PntcWLG7/1AE+0NwtO6b?=
 =?us-ascii?Q?PAqwDHyzkmwgjXduadh/t/bjDUPA0KfpuhCayeuf96o8WCfcLFrk4fVbNDBd?=
 =?us-ascii?Q?MBeC0BgPIL1HN23VrMnz/wn323K3g2YJ5Fntpzmd+I2St4s?=
X-Microsoft-Antispam-Message-Info: gPU2VXvM8pIwrvprs8fDp6oOj2Z2oyDP0IlF1Vb2pHKEvyhVqJRmHF3/MwmRlh+2x5rg8ASeHUxxEFGJSoBHTIpPbBDhE2K52yLqVh8i3iS3jk+VwzfEnUpz1rU2gyjqq+2ULKFxgbrZBVe4AB6pi1q+++iCPNUDO2Q7/FCcdjcIixIDAsIlSs6Cy0klRVrBuIH+P6U9vEtGVHs+QxozEqN6xKZNaW2HUEKgrOGuDydi9uEmhhx3Q/Ifp+queTZWMd2TqLZZUSNZOwcXXJCiON6PewxG2iXkzXb5Nid+ToPJOSKwjzjte5p1o/jVCQj4i/o0F88Voq7WspICypo/yd0aPOyEUE9ThNnRPQKMra4=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;6:TwOAkziruW37fUkWB8VMLzh82C8oCz5Rfds294jRB4mX20NJfe9dl1B3na0UBjIQMQA5zsynlA4FFy2m5/FXdiozkzsODg+7DWxLu98l5wtewhE2iLcG07Js9kkNmrkwMU9xg3e5lNgvumik5aIw9QNkfTwVrvWwl4DRpVdxTQKRR6td3wo9p6Z9VAoW+kHOkkr1NNfrYUHrOI109lxCb28QveH7GMrK3ckj6YCCoKWLoo2cNG+6t1sIJ0UHTECFPwa/KDA06lQ5Fou/JJ8R0TdeFAA3GBpzjiuf0bh8tyzifQeku25x45JFy8gzokWqj0b6AHkrRgW1T5wKcL1IWXMtH4VQYI1JdcZaCtzrpc1ULLMalZFwFgOEJHUxzTkp+pO8k7aC5p/1uRQKYGIduvhf76b74ga4l1bxGTSQ+VuZgj6+0hvpb7dDhkoW5usiptqMl+adrHR1djV2y9wtYg==;5:4GDc8gd2n/oFjMQ2LchQ2LJUvXQfxn5AhutJseQvUPiF2qgdNANPhtyLj8wDQnV05hV/wYAaQQDg3Roa8CaX8tLW467wQBKQnE9RQsZf4Yi/a2ebpQ54MLOH6YebtxSrb/2rbXNlin2wSHoDMVI8bDI8DeyshyyWUU/WcePs4qg=;7:qkXGekpnTazEWshRsU5Fkau+DhVIWJ8DhgozOHtrE0zVKktqDPfSsF0aID1plklYmAY49Ur1UOcdcjsZayZ32tJ2yT49iAmrb9J7j2yNS2oieN56chWmuTZmQjlEDA02yKF9v89uFGVJj1Phq74lpSrCMOYmJrHwp2MU0zHAho7S9oZhIhmbdNlpf3vE1tJ9Tcl9RLVNURx4FXKlRReQMc9YZBRUO66VxE9DKLQUQFfWij9tDEhY0JbO42sfFB7X
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0161;20:nramqdahfWS13y9mFh2ZQbL6rCAlxVSGPXIWN/ZWSkKkU8fAuyyAzxIJlzKJfie8+0lruEl2xNdt2RBGvwN/Ifa4l/RZrE8uoP3WbTDZtGOUeFjkxAuRCZCOB6aYkJtqHe/wJuzB3SQntsldkN2IcEo6Bx3O3z/Uiqm+XYaf8Mw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 17:19:07.9707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b05ecf5-a2ef-45cf-4229-08d606c10a69
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0161
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-20_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 06:22:13PM -0700, Matthew Wilcox wrote:
> On Fri, Aug 17, 2018 at 04:18:34PM -0700, Roman Gushchin wrote:
> > -			scan = div64_u64(scan * fraction[file],
> > -					 denominator);
> > +			if (scan > 1)
> > +				scan = div64_u64(scan * fraction[file],
> > +						 denominator);
> 
> Wouldn't we be better off doing a div_round_up?  ie:
> 
> 	scan = div64_u64(scan * fraction[file] + denominator - 1, denominator);
> 
> although i'd rather hide that in a new macro in math64.h than opencode it
> here.

Good idea! Will do in v2.

Thanks!
