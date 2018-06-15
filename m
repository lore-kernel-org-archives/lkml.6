Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7C059C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F1C208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="S3JxjSdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F1C208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965664AbeFOMHj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:07:39 -0400
Received: from mail-eopbgr700043.outbound.protection.outlook.com ([40.107.70.43]:26006
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936193AbeFOMHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NzWtVtmWRnrWvL03Wc3dYkKttbV0dFD0umi5Ki9wcE=;
 b=S3JxjSdUXtRWfsR9iRbm86+fhofAYY4OeEcbRuRSwVFeL6ANX8suO9exeeFZwzlb9eASyY4qv8E3qJ49dR6stgJbUM1XyEg2YOg5gmAV6tHYwmSxmK1B0l+HwqkTenIVLrRbBibE6TPrQLUzeFg+a7g+G1dJwwfqJa1ur8PySkY=
Received: from localhost.localdomain (155.4.205.56) by
 BN7PR05MB4577.namprd05.prod.outlook.com (2603:10b6:406:f2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.14; Fri, 15 Jun 2018 12:07:30 +0000
Subject: Re: [PATCH 1/2] locking: Implement an algorithm choice for Wound-Wait
 mutexes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20180613074745.14750-1-thellstrom@vmware.com>
 <20180613074745.14750-2-thellstrom@vmware.com>
 <20180613095012.GW12198@hirez.programming.kicks-ass.net>
 <69f3dee9-4782-bc90-3ee2-813ac6835c4a@vmware.com>
 <20180613131000.GX12198@hirez.programming.kicks-ass.net>
 <9afd482d-7082-fa17-5e34-179a652376e5@vmware.com>
 <20180614105151.GY12198@hirez.programming.kicks-ass.net>
 <dd0c5e50-ac14-912c-d31c-c2341fdd2864@vmware.com>
 <20180614144254.GB12198@hirez.programming.kicks-ass.net>
 <5a1076ad-3c26-d78a-5542-9e767d81c4a6@vmware.com>
 <20180614185139.GG12198@hirez.programming.kicks-ass.net>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <ecffbeae-a6ca-4dd4-47f9-0e8d5321695b@vmware.com>
Date:   Fri, 15 Jun 2018 14:07:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180614185139.GG12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR09CA0064.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::32) To BN7PR05MB4577.namprd05.prod.outlook.com
 (2603:10b6:406:f2::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34efca4e-aa79-4057-14f4-08d5d2b8935e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR05MB4577;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;3:sAs9LMV3POd2wVRK7Vcch69q5NqDXpuVqadUEKuoihXyiphn36OcKoFMcD1vBOwjMspMmllqeke7n7Q2D04eW2usZ5MLxBMYoeZBVe0LI6ynK56AAZPm0M6ebVRBOdP9FF9OHVp9l3GsuJGh8Vga7kTV3wKm1edOnXxr1K4Z1Yoo87UZj6zt2MHI1wzS9b32/etsOQt1Nv7DMspDq4DvdXQVrGnD1tk9fiUuOhwgfb+OxJS9tBnEVnLbmoCLg6LN;25:/b+yLFXKeGMQIIRvI/zLTHq/Zyio7sf/CO+4W+hCdS4yYMlI2VeAfQ+/xJ0Ojv/eZu2uuYmX09a3YdjCq0YFXYACOiqbdHKWBOgCpkJbKRBIPrvHDAHokXkr5zbG1MMO2+ObGMUiz9gAGRs8NAP5gI1ncJpgQPCwj/iQRRBShty/de+9qVMP9vHYgoCnbHFFjk5Gz13gUg44jVquA8nYMXJ0p00D+4oHwRmRmMhQAGCDwyGC1vIKvrAG3pGkCWmYTcTZJQRExhwF4eLGYLCaRtDY8XSlIz8f2deMAYhhmHL7f1wGi0KLlSNKiEsSFjk7DEQUfOSy1IyyjvG92edB4A==;31:9YWtVX2ihK6CEv7ioDWdJNTh3m4bT2/DgcuKRNDH483uckVsJDvqW0zO2QwjjlC0QWZnkp+cFUfpBo1ehWOFA4Fhc/YvhnOhyetgtzIFH5uC0JbkgabsgCbeij5W1rA2pcVM1WKQ45OuzhLlRp/2tKEy/gQ4jGndv2bBDxGyGo9sGjQ726G/WxszRBUQeKcYiEeG6E182T/vZOjKwvIaOOWR+9nI75iTd0lwPYz0LDQ=
X-MS-TrafficTypeDiagnostic: BN7PR05MB4577:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;20:n6O2v5yEALPpl9TQ7sR0dkdmAjInw8mmzd53y1bSe8W61b7NFbQE4fbWk7pVJvYaz1AiPOTOEB2jAUu27/bnJc7IfwMPu202IlRVysfs+EYwtLCzZJJXj92OrHA+XbqnwU4xKa8yoeEO4w8cTJ67ikyR5d9rH2OCTAw7vlg0gkfo8uBibbt06gIxiuf6WtOrr1i5DZcRhWaaABifDDd0G/xVVL48Hia896VEsR3qVllP3WwMfE1wV189JV+VC1Ytf1U2+eSSVi9GrAFIOnHf4Pcwi7z7ywLJc+IIVZzb1TFO2U/seIu4jZQ9DGsUgbcqvRB69y5nAzLcaomLi68088f3+/63D8S6qAGY+kBBylttEPC16AuxnTh27wO3zrj1117+R5ql/yUfobsfiOyCZ2gIL1LUs5ZjRRL2+LNhIsHhHpj0Upi+4JvGx84tPdxy0Lm58sssEaYXNTZ9jbq8kvRuBtMkoMky3FK/d9DEQX0QFIg7rPAqQEZmV7OVyPZd;4:gKS3YSohBn1CNlxKIw/W3n7LQo+B6WSV7rBQheK4FxcX3K/Z0bHAIHO5qR7bhJ2xH3u79dMv9LAEXpde/66IK0yJ2CU7aedf1zFj1T87w5Jy+a8q5arF+u11jCSxfgYXyEawa9NRwqGnB3cVJnAx2w2sPdazLjqaJTzL2d5D+eOnF6DDMB65Y6Fo1Qn8847GjwrDHPhVyO1A78sLDkZ4MvyHr3BkiSsxpVSmniJUbV7VnYXkTNWMNfkjs/uHenut/7FzySuyBveizt0oVim0Ys62+1xQ1ymt+AcRZLO089BAcG6uHXXIh7rCsMO2gTZ2
X-Microsoft-Antispam-PRVS: <BN7PR05MB457740C6EF4EBF77408E0235A17C0@BN7PR05MB4577.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN7PR05MB4577;BCL:0;PCL:0;RULEID:;SRVR:BN7PR05MB4577;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(396003)(346002)(39380400002)(366004)(39860400002)(189003)(199004)(67846002)(47776003)(50466002)(106356001)(229853002)(6486002)(7416002)(8936002)(5660300001)(66066001)(68736007)(65956001)(64126003)(65806001)(31686004)(305945005)(105586002)(8676002)(65826007)(956004)(230700001)(36756003)(6512007)(2616005)(58126008)(316002)(26005)(81166006)(81156014)(31696002)(76176011)(86362001)(93886005)(6116002)(476003)(3846002)(446003)(4326008)(478600001)(386003)(54906003)(2906002)(53936002)(6506007)(53546011)(11346002)(6246003)(52116002)(486006)(6666003)(7736002)(6916009)(97736004)(186003)(2486003)(23676004)(52146003)(16526019)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4577;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjA1TUI0NTc3OzIzOk5XRlY1NStRT2RQRGJlRWg0bjNRSmc3ZTdB?=
 =?utf-8?B?VjZPNlFYTkFjekx2T2FsT25iS3ZqSlVUck1CbU5kM3hkYzk0cXM5RkJXbTN0?=
 =?utf-8?B?M0MySmk3cGdvK01zcDVqcWNXa3orTU5HMzE2NnV6OVU4bm5LUUhNRXA0bjhK?=
 =?utf-8?B?ZCtEcDF2S05tajN6OVJXbU5haVIyWndzTjAySFZ0YTNCemtzbFozL1lyNDVp?=
 =?utf-8?B?VGpGcTdCbkZGY2JTRnRHL1lvV0NmUlBCRWU5THFnNU81YXVONUZOenVsSGxO?=
 =?utf-8?B?YUJBWWZHeER2RXJhcmtpcVlmSXd0RHprLzUzcXFvekU0clRrMjh2SnlacGtS?=
 =?utf-8?B?YlpwSlhqb0pQdHZZS01JakpKQ0paREtGbTZtSitoWHNzQnBNdHV3dnhleWlr?=
 =?utf-8?B?dWJXbDR4VVN0eERmanFlaEJwNkhZdTZZTHJXVS9QYjBpVjBOUVBFNzNzRXFY?=
 =?utf-8?B?UVYxK2hzYWsrcXZwbkVHVk9zbGsyT2JaVmtWWU11dEhkVGpFcmRBbEJMekdI?=
 =?utf-8?B?M3IwQVlOaGlDeFV3U1VodThoUTJ2UCs3cjBQNGt4NGlsUDdWUGJ6ODEzTEhV?=
 =?utf-8?B?RUd6aWZKNDNUMEk0L0ozZzM3ZmN4VVJVYlVUeE4rKzhuWWRsTys0M1l4S0xS?=
 =?utf-8?B?bXk0dXU5RnV0dW5UdndSaG1ZOFVHM0dUa1MrbTBKSFBkVHdaTXZFOUJ1M3pV?=
 =?utf-8?B?bTZtU2pRMlBiU0N5RlI0bmdMczE4ZldIbDFobGlnVytWUHpUTlplblpTdXNh?=
 =?utf-8?B?a2g4WVlXQXVIUEViTE5maGRmcGtCOWxrZi9aT3NoWklUOU1pQmYwMFBUNms2?=
 =?utf-8?B?anI5VDlUWUI3L0J4dktZa3pNeHRlVVFkbnl1b2JwdHR2MjVkdG1ndW9iZzFt?=
 =?utf-8?B?ZTlYN2t2bmdCeVRDZUdtSjlnZGtDSUhseWx2aFg2VWNrd3JlVTlKcnVJSjY1?=
 =?utf-8?B?SVg0NHE3VzhVRG5mN2t0SVoxZEtsTGx5R2VVTCtxWk5LdHFiWkszUUtUbWZB?=
 =?utf-8?B?c0ZSR0VEUUw4Yk1sYTNBK2JWaGRWTWkzUnhHNXhQSmVCWTAzRVVrUHRIc2Na?=
 =?utf-8?B?Rks0a1BNV2N4MWQ0cG9EcGlZcGJqV1Fsd29GSlBwemRtWU5BLzcrWmtPbElV?=
 =?utf-8?B?VWxLMThoUjNJRHorc2hBYnhCUkM5aGtEWlAyZEdzdHE5YXBTc0FyUy96aUsx?=
 =?utf-8?B?dXlFTFBiK3AwZ1pHUGZ0dHl2dkxkbWszVGg0dEJBdnFGY2lidzJQWjNXK1Z5?=
 =?utf-8?B?ai9nakJtMm1ZSXlvMFpDdmtPSHFZZmpwNngybU9KRlBtL01sZU1wY3RRVnJE?=
 =?utf-8?B?WkxXWEJiQ21lSkRnbmZEZ1BTaGRubW94QmNNcTl5c2tPZVVGVU1tRWdEWnU1?=
 =?utf-8?B?ZXQrTzFhaS9SMC9hYSttNmZCMjVyMUd0Zkw2dkE2R1FEbGVmTWxDUWp2WWRQ?=
 =?utf-8?B?Q3pNL2RueDdXZWFQZkQrd1o4MXVsdEtiWVRUcDg0WllkelZidUpoaDZraHRq?=
 =?utf-8?B?aDNWaUNkSGNEc3I0Z1hPN040bXdmK3pkZndWNTNldXZjVFdwWk9yd01NWU5r?=
 =?utf-8?B?OGw1VmplQmdhTGNxUUhUQUl2VFFGQ2JHOHhMNnhSb1phcVlnVU55ZGNMQUl1?=
 =?utf-8?B?TVRyeXhJeFZENmJtOEp5S09WOU5XQUZsdEdYL3B2UnQ1T1QxcEh4TXVKTjEz?=
 =?utf-8?B?bHJrY29JSGduQU9zS3ZrVDE2enFmYmZhbDJLUis1V2ZCOVAxMWRCaXRZUHo1?=
 =?utf-8?B?VzMxa0Y1WHlTRStDTWRVN2E1WGpOUlRXeWFueGtCbmpkbzdUbTYrbWg0Mlgv?=
 =?utf-8?B?NDVuRXp0Uld1ZkJaK2VQcGE0azk5Vmx1NW1ZUTF5d1RLdUJoaC81b0t0MXor?=
 =?utf-8?B?cys0cyt0cG1mNnl3b1VpQStMWXcrWU9Hc2Z1b2RUMEpjUko4M0NyRFlIQkpJ?=
 =?utf-8?B?cHJXcU5GZXhvNzcvMlNvcDBMQjlEdEl6bnlqNUd1T2FxN1hjVDE3ZjZYQ3Za?=
 =?utf-8?B?MXBuR3VSRkxQQWVldEZHWk5vcTJwMW45ZVM0dz09?=
X-Microsoft-Antispam-Message-Info: T3OFbaGSp/yHsnDLR/CY/hqwjz5ftziacYdRfE+RC2Sl2t5BtZc8NgmCkbMeKpn3rDJd8PE4POevbgtMErCBCQUM2O44t8c2Wi0UkAd69Q6KUa1bjgl3/GYM+6SI+oIJZklch8gU+kMCLuJUfaWsagpsnMquJqUe5GnTqf4zmitVEJB+HZpiaBaLBaICZoHh
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;6:ZuspRuf1Gw/n3STpCxmylXgE1HIsYc+odQpnMWbAuDwZ9eMx4043CCSFpOchoFM/9LRoM31hvJzOkzSra0+9WKilKvOA2Tdz3goBlysIHmDdQTN0hsDTkjkLFLe7xSrwwxhGq3OmJjgAoLjumVH8sH2IB0iAquR0cGk1ku3CnX69MzVZFXrceuwjJsUZRrzdsObMjF6/R78yP2QEhlRsTSDnLZf3mvwc3LTedZKmYJvF+t9DZ6RcQE0/O+ZD8CXJ8e6Cd4FyOeyToCNXb+jUq3oAU/oal1gr0e9kHeXgU1ZhMoqMz8JsWwUwipXGD3nxjzRtyThBwispC1jdsu5oh4CkFQ08r5UfDejm3fyQETBxs0kW0XChjLDWRBhen4gPxmMXgM6OAKOLL/IfJ1wlCZIrN2z8cTqPaeREMbqMUlZBI8iLSA3TLwSL/5BrooMyFrrcrWxDf3HyCY3Qv9paTw==;5:EN9S+Az3U0RSk6X5hUrS9cOcWdU4pFqZBcPleOdLmRg82YJaMd3Gtk6x9aRknCALL7bt6RU/8PkNPchb5cmmxUFCmEXOgtfljVrQYkxD1BNcUVQRm3NGrmjhcpMHpRJ/h7s82H2V3VLCj7Fg8EERoSQAzT8dZ0DaHXFLIFDSLFM=;24:ruRswN1euWZr4sPOzZ2LYZnmwU1Q59Tln00Bj64miTxtchYdM1BpDqk500Y9N6hKuwcAV9eNjU4zQVrSEsqNlUWFMAH85jDY0Qcs5Uo1/8A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;7:GrXqdy2EDn8sy46xQ/+gItW+jUv+Ydar53XOhFserBzpQdEKh3u3G5JkkHc0nmsh5YQdqHcRgfrx8llzQlQhgi3PAnfkD1bou8F7ElvcHK4JkkPIs+BkYBpTzrdLxNKtm7enEUNhWl4rd7vE+70XEoJYHY5as5MuXeJWK19q3RhnMOBE+XYATYDKQ/m2cBMD0j59oU7g0aljxiB/+9Y5eLSdAY9ktITMaqryDBC95sbMKzZ6UtNCFuMSp3W23sZo;20:vicPwMRRqpd0714R/o3Lk004enbYO8wi0ULUK817lHGBONgblgg2dtul0Ya5/+E26wueLxTOYmL/9+l5AAhZ7AdI1sU3pNtFw7Hx2bXcVtIanBJFUXmz3PLJ4yyrrsEAxKkCkc71N/BTMwMlk1ilnbk/Opj96452UNPRuxjm+5s=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 12:07:30.0203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34efca4e-aa79-4057-14f4-08d5d2b8935e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 08:51 PM, Peter Zijlstra wrote:
> On Thu, Jun 14, 2018 at 06:43:40PM +0200, Thomas Hellstrom wrote:
>> Overall, I think this looks fine. I'll just fix up the FLAG_WAITERS setting
>> and affected comments and do some torture testing on it.
> Thanks!
>
>> Are you OK with adding the new feature and the cleanup in the same patch?
> I suppose so, trying to untangle that will be a bit of a pain. But if
> you feel so inclined I'm not going to stop you :-)

OK, I did some untangling. Sending out the resulting two patches. There 
are very minor changes in comments and naming, mostly trying to avoid 
"wound" where we really mean "die".

The only functional change is that I've moved the waiter-wounding-owner 
path to *after* we actually set the FLAG_WAITER so that we make sure a 
valid owner pointer remains valid while we hold the spinlock. This also 
means we can replace an smp_mb() with smp_mb__after_atomic().

Sending the patches as separate emails. Please let me know if you're OK 
with them and also the author / co-author info, and if so, I'll send out 
the full series again.

Thanks,

/Thomas


