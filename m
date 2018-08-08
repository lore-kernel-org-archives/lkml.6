Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023A9C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915D8208AD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aq1so40j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915D8208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeHHMhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:37:39 -0400
Received: from mail-eopbgr70125.outbound.protection.outlook.com ([40.107.7.125]:45675
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbeHHMhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWWNPOmEZgY9BHcI/FlIyc/8s1eVDo5X+HNTD5kUa00=;
 b=aq1so40jtunCqEGBl9+BIC9pD54gIWVYdeIQnHoUZBR9E3iZAyv0IfcLV4XAXYJs0T7V7L//713sCtR5/uHbFIk1Apj/OfpNM0LfYM2ESBFdHBhUDdsDu63WeelOOrS1OF7zEQbUaScUeaaVlPwW1cse6P1G1TyGWkyP84iAC3c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2027.eurprd08.prod.outlook.com (2603:10a6:3:50::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 10:18:27 +0000
Subject: Re: [PATCH RFC 00/10] Introduce lockless shrink_slab()
To:     Shakeel Butt <shakeelb@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        josh@joshtriplett.org, Steven Rostedt <rostedt@goodmis.org>,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        Hugh Dickins <hughd@google.com>, shuah@kernel.org,
        robh@kernel.org, ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>, jbacik@fb.com,
        Ingo Molnar <mingo@kernel.org>, mhiramat@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <20180808111224.52a451d9@canb.auug.org.au>
 <CALvZod4CAA50sPB1V9bZVOZ__rOT=Ys8tLv+m-S-kP3NLubSqQ@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <493967b5-cb56-4a88-c2fb-44238e2823ed@virtuozzo.com>
Date:   Wed, 8 Aug 2018 13:18:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALvZod4CAA50sPB1V9bZVOZ__rOT=Ys8tLv+m-S-kP3NLubSqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0102CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::24) To HE1PR0801MB2027.eurprd08.prod.outlook.com
 (2603:10a6:3:50::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df11cc9f-8082-4136-e141-08d5fd1849c3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2027;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;3:GU897xaxolWAoR8CpqYFlmBUe2SR0EuRtTJbbfb8buv1ggO5CS7iG6+zuRJpy2g0pc2qLNF0Fz1P1dBa0ri5iJS0M92ILy3F3q6ouoKv3jnhCsgyWVw8zbXLoqQ7QCbx1xr7rODZp2JVM4SK4biIkP802gdnCRt1+QGLVbRuW1eAObqIQxQUecSIh5H9lJu9KVbAmvr9NjsCR5qS8dmDi0xtkHOfLvgy/kE/kzbIxxTp2i9Y+4zfc0h3KTsC8AKY;25:zQ+D30/yR3rZayvabSBseEPKj4GK5xUxf87ATXJSX8j7cIZkhNCxnLzRD7O84T3ARRuSV0VZlPdq0WXd4bOteyd6Hhpr0cENQU6k4i6+CbRjN9UMIpFsh/cuR2GHwjVSkF3y3CeLnU+mJLkk364fBE/w0LcvOn1iWZMwJ/Skl3M+9FGY8tG8iGXn3B3rUWNjAk4f9CTfDcoxWrku/9lK1Tc8jZ8ZWJSuVdrrfSzZFlA34LqRTiwFn+HkYBQJBfIw9zf4bIi+eewZeoVq9XHaOrJ70x7v9/abvTGTR+D8jxQFpzVJSjOwettjYe0AEbs4F0eAgG3xp/3EkwZCPMVXGw==;31:Esg8PV/Elt3rRz44EyuUI7Y2y8Qez9kENU2zXAwhVnlpYiGba3EWKGE4SriQCb8QeLGuvMLPO4xxFWXAZJvmlLAPvu3KQy+RGNdsWYGw29OFyEqWSufBmbJDLMGWMPhdFNqMaixGnETA3RvY86vjHiRLKFASKzJNNz7ks7ElgM++uTZHZURt6F4aJrBlr9qUQOeJ6B4+ywPd7AQ6OufzxAbpivbdyguIOfanNZX8lEQ=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2027:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;20:ZTzN2gA8aF5jvrdAn5gE7APtk5NhmJWy4EaMtUM6c6bDjdR1c9LVkKeP0uv9ie5w3Atnb0Dj07sb2U2tq5qvsoXhqSs8PznStEOdgN0CTEWGjmgjHJHszqHrsFTeI3XBU8WHXyDNQXDHlPkacZr0RDZ1gSvevvIXlKYJAIXHguwofXSPcAITUFD6tx4s6qMSH2JmzLXtrZjie9s7t4OGEtWXDxz5aAKw2nmepNCkwP9ipaa5cqX1W79se1zLmkHZoc6as9+H/CzvdWKEzQiIYF0j6CWuGtRZHflguHs+UPQgzQvdPZrhRShaZxGFxrU+AiuMCo/Ma3hf/7CXW0JeDx26EU9mfNvrVfaapKPyiNgOtjgaQILj22g/jOBL7BC86bzuKBDQ+ZWyKGoyGXtaoAE4LjX+kj1M04rPd3kHMUeEC5z7c4iKRiRIwdEs20c/oHOEpK1ERHacSqCtJAPZe8WuayTimk+DSSpiXXrVVe3l+o5cRytHVyf/Tpex9fn4;4:GeThIpOqiFkXWlAb4DXWN9915Ax8flTM3u22JF5OLhGzKFbsSxTrLovgqQgOn0ghXmr9v+S/80EYrjaxqy/FNsNkjMk4QYT/9cNpdzzb39EI1q2W/EGBCRtc4btsATeInwF9JVFHuh9oVYjwV1cvYnDs8kNVaZexZgI2rwpUAwRj7frSMXnjyqQoLvxgfa/WiuE8gahF8VvYGBbf2oZBHSYT+02XnNdO5O8kyUVD3b7MEdyIwVVKVEl4cBoSLiFUv06ZijrJZsm8VnPzWMaDCw==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB202798778C51305F3D4B2891CD260@HE1PR0801MB2027.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2027;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2027;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(366004)(376002)(39850400004)(396003)(346002)(189003)(199004)(68736007)(217873002)(81166006)(81156014)(8676002)(230700001)(446003)(8936002)(6116002)(14444005)(3846002)(11346002)(316002)(50466002)(478600001)(7736002)(2906002)(305945005)(6486002)(65956001)(47776003)(65806001)(86362001)(25786009)(486006)(5660300001)(956004)(53936002)(4326008)(65826007)(6666003)(66066001)(53546011)(31696002)(476003)(386003)(7406005)(64126003)(6246003)(31686004)(52116002)(23676004)(106356001)(7416002)(105586002)(16526019)(97736004)(2486003)(186003)(77096007)(58126008)(2616005)(52146003)(36756003)(54906003)(76176011)(229853002)(26005)(110136005)(39060400002)(16576012);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2027;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjc7MjM6YTZKOGxncGRUaXZaN082ZXl0Sk51KzRq?=
 =?utf-8?B?N3did2dtT2V3U2xZRENCWVlCamtGWVlvZlArS2NlYmxIUEZ0SGZ4cCtmZnhO?=
 =?utf-8?B?cUx3UDBwUG5icm1uZ0g3VURxVlpaQjFUMjZMRUlFT3NyQlBCMzFwTUdpbVlz?=
 =?utf-8?B?MU14Sjd5Q3ZkL3VJUHo5YWFPd1pjRG8wYjY3c0NPY29jWXNQQytuaURxNUhq?=
 =?utf-8?B?ZmlKQ3hodUhkY25BREIydlphcTN5MmdvVVFaOTJ0ckMyYjZ4Y0RxdU5BWENJ?=
 =?utf-8?B?YjdwZklCWWRzR3NoQUo1WFhERnIzWTVtd0RBeXFENERZS3hTZmxsZWhoYXVQ?=
 =?utf-8?B?c1pQT0lXSGZDaE1VRmp0eThWTU9DYlU0dm4wQU9FQURGQWxTaitPL2JPOERB?=
 =?utf-8?B?cjZPMndVYW1rcDM2dmdubk9uY2E5dVJPbXBrV3RxbGNVTnNnTVM2YUZudkVk?=
 =?utf-8?B?T0M0SVlBMEpCS2h2ak0xZHY0U050Y1M4ZEMxekZFKzlRajhza2xJK0NCQ3Fs?=
 =?utf-8?B?MFRMLzhmSHlSZHN3THhsSmwwRm0wYnpjWEFKNkpjYUN4QjlHNWRpWDk0NFMw?=
 =?utf-8?B?amttV21ZQ0pSd3VYSzdDVTMzNmFKZDBnN2pEQnljOWJSV3Buc1Ixc2lIVkh5?=
 =?utf-8?B?eGw1dm5ORUpLNmhEbzI3Y3Y2SkFySTZVRHlTaGFpcW0ycVdiWk9yL1NJRHkz?=
 =?utf-8?B?cUpISEVrNnNkRlVyejZNQTZPaVFNRDBLd0xBOXNCZVhGQXVHbzZaTWxnUUlX?=
 =?utf-8?B?b0pOWnNnRHhub3VaaTdscGVLOThvVDBlOWRnemNiM29TYmdZamgvTTBTY1JM?=
 =?utf-8?B?SVpBeTd5ZFJFenp3Z1N3UGhSWXIyYm52akVaSDA1ZlpmSk1qZzcrckVXQXpz?=
 =?utf-8?B?aXNHLzZXYVlCNnFIb3E4bDlTR083Y1FxdURaV3ovLzBTNFg5UWpGTmx6QUQw?=
 =?utf-8?B?aDJqVVBYV0F5Y2FKK1FvU2MxSm5nWEF2NWZqU1Nrc2I2eTNvcVlySDcycHM5?=
 =?utf-8?B?V0YyNExQWHFDQWJXTndiSjhFVVFJOUhWTGE4dnFxcm9ycnBuUnRlNGVsREl4?=
 =?utf-8?B?RU5abnBYNkxVQjVrVVRwWDZLaitCY1dlV0lvUEp4TnhXTzVuanNHV0IxdkJ2?=
 =?utf-8?B?VmRybnE0bUNtUjE4TDJUWG1RNDIvNVlYeVRxaDhmM0hLcUowZUNhZzBpRzho?=
 =?utf-8?B?QmFYK0x4YXZubHZwNmFKYVJoWlZFVk5PY2hYSktCd2prdE1KV1NxQWN2OERC?=
 =?utf-8?B?ZnVUWEVQY0pxVTVsOG9od2hrdE93ZmIvUlgvRjBSY2tMMm4wZzZzNEwvMTVn?=
 =?utf-8?B?aG5QWWFaWWhxdVVRMWR4a2VOd2NndUNlbVNKZnZtakx4TkRJTWFTQTJPOTgx?=
 =?utf-8?B?ek5vWnMrdUVQTDBLejhOY05iY1RkWkxHVWk0Mk42VGJHT2lxdmEvZ0VrRWhx?=
 =?utf-8?B?bGlaMkZZb2J6UXd1R3NLa00wRkxFUmtsbDZuWlVlM01nZS80enB3TnFBa01x?=
 =?utf-8?B?dWtLQXZBS2c5STJGUzJ2M0xYY0VtQUxMK0p1NC9aTkJKdWJQQUVpVlpiOStT?=
 =?utf-8?B?V3hENG92TmVDMCtPcVh5bGJXZld4NEUreXRORGNjdGZLbWhmcHpaaWIzdDRJ?=
 =?utf-8?B?QlcrS21oV0d2NFo5V0xWM0FTZHY0NHpBc2g3SHhHdUwzVlB4Z2dxRlBDdkxZ?=
 =?utf-8?B?QnZ5NlZWTzNURWxiajdlb0NyWmFOWWVlamt4MjNLVUtUTTFJZjdZenNxbTRH?=
 =?utf-8?B?YmdBVFN5em5JRU8zSG9vbHlTMkpBTnhNcVNpQ1JTaVdsUW1jMFdhRHJpbjF2?=
 =?utf-8?B?V3diRFo4MFFhSDFkVGRzRjZlcEhpanJDck1iSG9rRmI3VkNHR0dKMkxmVDlO?=
 =?utf-8?B?MFRxZGp3WG4waWx3QngyUjJFTk5WSGFleVZoeHhmTWRBc1JTV3UvaVk5Tlpm?=
 =?utf-8?B?bkd4a2VGc3ZzaGJzaEhEbGxvNlhneGlieVhqSytKZDVWcUkrY2s4bWwrYWpz?=
 =?utf-8?B?Z3daMjZFb0x0R3hMZ0k2UUIxZ0Nna0d6TGRBZGlJeE5meFQ3bVdIbUNZdGNV?=
 =?utf-8?Q?0kJ8eO7UMU9gw70cUGRDcV67xa1?=
X-Microsoft-Antispam-Message-Info: aqYvF46aRkk7ocB5L7XfC5TLC21EGDfjAXK7ND+f4Pay0Kw7CPb7H19KpmpViatf991pq277LxnHyT5Xc/6/60/Z2I7VA78dJEFIXjUseyNqph3N3KGWtKZd8PeZbJPcKfO8FpVi3biKRBN8BD98T0kshMJunYg43UBAOOnL4qtREEgZrk1fx3Z7h33boVnNMsqITxPH7FYXXYIa9nAsNNPCPEuDXpvQ6CK/sMpEnGU9/dJ3DYkbSfry5Chd9aR4M1hNlP5UMlcUg8R1qzqBw5ihHmlUZBjg1OBi6M3HTZixoJsodYcpu6BMcucKAmULhmsOoerDHHR5OTQI60qt5oRQkJljYXS6utG1Ju5+rP4=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;6:6RYpPkA7rN3G0Svfy/1DphIbFToyj5VGVJ3uXZ85Uwaru3QaCRL008BAUmWk79E2UeJ++/0Je7gLRm7wVTitSeqc/NpqCUZL4X+OGFr/60moacUQtF68HlXBqLGVQa1OppZFa7bmTsroldS5s7kPD/WLNrGaKPRxzW0c3V28Dqp0npKyigGThFERR3Wfhgqr65WYZexWTyneSPqg6d3mI0Yfsva7ZYxxcMLNp4YVicUO5IPGVSnPHUAX7kMC0ye/AP8x8XKSBroQKaOptiAUJ+U8Y8ulg/7TZHyQfk5qNoaxEkwEv6842g9uElqSHgkmx/VC9jtTO35K7KugUvRukkNAKvly1zEjTDPghhM41OfaT5eS1xWhGV1LvXCEqpSRTFGy3CBjMIfnqBAtACAGdGFzNoEuRDgtAhiZDiAD9SC58+QTcoqfqURLnkji8+nF1fHi8ypoK4p7C+zPsRnG4g==;5:H+87L3JzwgQve/ss38LcMzoJjtSHZg9G2AYyOeyS9lfx0AmXxlVh4Vcl7kFPh1+NAxyOtqCsl/mfgKveU3TlUZy//Xsh7xAuiMFv/mkOqjhfji7KCRSDrppyhmEdmeu0D47n0xTtj7Bz5UMiWoaL6VyuzVvCG2HSKIIJtSKSU70=;7:feKxdictewuxVOk8rkRK3CfMvb4lKzIFkPI7qQhDTuuGNDVq6qxx17EKxmPNipvOXx27T/qQiqKXKNIsCgRcONyGq8mxne/CrbpHMwWJ/rNo9/FPWTotorZR53v22XCPXOWhT2YTFZW8lW/oNYXDR4RwnJzAZ909AZQU64g4hmogQJFKv/8QNKIWL2jzCk3XgazDKgSIzUb+UKhmlbCsbLioVQWNrbh4LravU9nuAf/9O/GCkbvA+RXvR89XInGd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;20:0CWeka4hrLaj4UiZxLHx7qQJ8KkLWc3CxoE9VB6nva38g/dv9et6FczXC7ATjigbPcby/KK5dLSPnOrLZnE3NpsGQJqFPb995s0koKCniKow75bY6zrF/pwGyP2GN2QRTNI9tHHNzjagNkNWxun4KnK1bZpaEOP3t+vGjSTvVJA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 10:18:27.4140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df11cc9f-8082-4136-e141-08d5fd1849c3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.2018 08:39, Shakeel Butt wrote:
> On Tue, Aug 7, 2018 at 6:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi Kirill,
>>
>> On Tue, 07 Aug 2018 18:37:19 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>
>>> After bitmaps of not-empty memcg shrinkers were implemented
>>> (see "[PATCH v9 00/17] Improve shrink_slab() scalability..."
>>> series, which is already in mm tree), all the evil in perf
>>> trace has moved from shrink_slab() to down_read_trylock().
>>> As reported by Shakeel Butt:
>>>
>>>      > I created 255 memcgs, 255 ext4 mounts and made each memcg create a
>>>      > file containing few KiBs on corresponding mount. Then in a separate
>>>      > memcg of 200 MiB limit ran a fork-bomb.
>>>      >
>>>      > I ran the "perf record -ag -- sleep 60" and below are the results:
>>>      > +  47.49%            fb.sh  [kernel.kallsyms]    [k] down_read_trylock
>>>      > +  30.72%            fb.sh  [kernel.kallsyms]    [k] up_read
>>>      > +   9.51%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_iter
>>>      > +   1.69%            fb.sh  [kernel.kallsyms]    [k] shrink_node_memcg
>>>      > +   1.35%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_protected
>>>      > +   1.05%            fb.sh  [kernel.kallsyms]    [k] queued_spin_lock_slowpath
>>>      > +   0.85%            fb.sh  [kernel.kallsyms]    [k] _raw_spin_lock
>>>      > +   0.78%            fb.sh  [kernel.kallsyms]    [k] lruvec_lru_size
>>>      > +   0.57%            fb.sh  [kernel.kallsyms]    [k] shrink_node
>>>      > +   0.54%            fb.sh  [kernel.kallsyms]    [k] queue_work_on
>>>      > +   0.46%            fb.sh  [kernel.kallsyms]    [k] shrink_slab_memcg
>>>
>>> The patchset continues to improve shrink_slab() scalability and makes
>>> it lockless completely. Here are several steps for that:
>>
>> So do you have any numbers for after theses changes?
>>
> 
> I will do the same experiment as before with these patches sometime
> this or next week.

Thanks, Shakeel!

> BTW Kirill, thanks for pushing this.
> 
> regards,
> Shakeel
> 
