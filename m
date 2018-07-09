Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C3FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6997320875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iXbHeI/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6997320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754691AbeGIIji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:39:38 -0400
Received: from mail-he1eur01on0134.outbound.protection.outlook.com ([104.47.0.134]:30913
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754011AbeGIIje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8blRo4hZLGF6t68Km8F6AP0zl8CaRfdZi6lbR/A6EU=;
 b=iXbHeI/PdR9INSXoylUVpmGlY5YiclCugHRR6VebFtYNiIlNgCzARZHWvNoEStx9WgP4bSTQBFZ3AvdVdt9JN+fPf2Y+waOHyBLVKjJ4jg/yhwXtB63n0O9piJkOnapVl0DW7zeFmxxNF0J2ABA4CuACN7Z3cmBwvX1k2vrmVFE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB1329.eurprd08.prod.outlook.com (2603:10a6:203:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Mon, 9 Jul
 2018 08:39:28 +0000
Subject: [PATCH v9 12/17] mm: Export mem_cgroup_is_root()
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
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Mon, 09 Jul 2018 11:39:25 +0300
Message-ID: <153112556556.4097.9697912712892217477.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0301CA0011.eurprd03.prod.outlook.com
 (2603:10a6:3:76::21) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad662922-14f9-464c-ef01-08d5e5777d04
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:i9B1KkiXYI6M3cPalOCLudI5D0iA2qZiNVM9S6jf+vdhsOh0e9I1yfYa5o53vid2PGjYKdw+2atAY7pv4M4VuMXWAKl80aI4ctqoO/KPqOZjKMwOM/KczX5UijufwJxvL0NU4rIY9uJ9iZhOEVYbwPjJ9xOaJW7OrWxCBBy6K1blhnSibcjKYnirxjsnyBEsOOFcGcBAbj1YKtQgsM4bXWRp5k8dIyEmTprtSpbwJ1KNVKni67FgMQwSmJF9nRw5;25:hoOUoP+DANp2EY75+rOuB+MDModONR4oskzT0OKyRwuwLI7siL0E9JPIeivM1YerRIsicXR5CG2OX3MNxZWKGh7NJ1pBYIcCv/kU9B4lD4OIN5gmwhlJW0eEkks9Mtawlwe1ygbSzrXzhiBSQavfRDkNV+/kgeKVHWM7hj7l5X00nnB0wp75JrEvKfNhU+xCNIY6rzQGyPyMBz3FZ7ygYK+wQDQmisZNVRJNHOzFIDZgh/Oqjkao2EreF/oAm2f47PMH+Q1aX0UEjn6Gr/s+VzehViTkwrRAdz0GamzVHJ20bO0pjH1mnppRhZS53N3tB9J8F11rvHU/8xJXDUpAUQ==;31:hE3Wsr8Jfq9EVcuKMBjKU/TLC1RlbdbPiI+sv0hL/bAYoVSVUbPZj4EIz6ueDdYJbysHJGg1FNvKcNo6BiXJu2vhpm2nTqoCvf1D/fn6UJCPq+8xEa+TV+LhFi53jWs1/Q5UzZSkB+/ggkRlj9y/BFbE8BnDgLEWSVc1PiEi4Q7Oil9RbADHeiaLWRSB7fcjVejGSNPnKKCifkzWy14wxxLF9NGsR736n3m1DZjvqqU=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:MOR5bgOyMeYo2bFsnaclsTd0GgKMF+S2QX0+5M1IGhDtjfZtkA7q4WDBUffz9tGy6Er2O4nWJ0NDMgU6L8lZW6rbD6LgGPoswEbpHfjjRWKvXcnQZ5vuwbdEdZmdos3rIl3vY/e2Gg08NBeb5KF62Kk+A8QhezCbOzEc9iNVVPkBaZdzqPzLsUXzuC0SPiIYsylduPSMWHmy67so74om9CBmKwAGpQQ1To+vMD70XfBj51uXIXNYygcFZlchAi4HDxmuw7HtF5DkgQhyEzhj224Gi5IwVSn1O0XpRFvDVQSrU7ho7ul+if3TvinDSIgNInDbaIvURLZ9Ty+ZjCdW8j55wzWgXtWEVB6O8WKR8SfDo2VNhlFx80C28fuYCXsQc9xJkECR9S1GFQZGLy/FNgWMhFVOSOHhhRhr4uLyB7pl3CT1XxBC1G/7ViAEpMot200KFSvLhs4uc+OfiA+EyF+zUBLhZvqR6v7CcBn403LEaUkKOWhVcCckGV6a5AkW;4:MD44SmNT2F7ZOuRVJzH4HbccGFnMWQKTBAtsFz0+T0bbVVrbastcSalvn+yN3iU95x4XsQ+nHIAXswj60x7tQE3oiGFKz2eqQ36cc1FQxasaaTv6hmN0MD/dBLyDYnmhql2RrdApW/S+CkMie5Up2G7ln5WNeK4LvJR2BlAvR9YeUxDaC9JZ9IzXNvnkgb/WdrnV+yEFLjcrAYVfMXzKE3DSwAS0RLqwGi0iA+ovVjVkWNjAvLaWeJVKwy34uJYvjeUVbnqdSx8QoaZMLqbCjvImy73lsTj+TKu7whtzUY8uIf5eZKgOCkXq0E6A1OiNGgWB6Twf1ae3cLdxcFu7tkStk6pMeS6a9zns+2UzZ2wcfLF8DbseDS8OBhzTbz3g
X-Microsoft-Antispam-PRVS: <AM5PR0801MB132984EE37801CDA3EDAB939CD440@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(476003)(305945005)(97736004)(55016002)(9686003)(486006)(956004)(86362001)(7736002)(103116003)(11346002)(53936002)(6666003)(230700001)(68736007)(2906002)(7416002)(5660300001)(6116002)(3846002)(316002)(33896004)(61506002)(7696005)(52116002)(2486003)(8676002)(81156014)(81166006)(8936002)(23676004)(50466002)(6506007)(386003)(58126008)(39060400002)(25786009)(26005)(186003)(16526019)(14444005)(105586002)(47776003)(478600001)(76176011)(106356001)(446003)(66066001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6bXl2bTBqSW5KK3crdm51K2g3VXBtZS9E?=
 =?utf-8?B?dVRhcEpDdjVkdVZMSGxRRSsrQkRCVnAvcURhWWdJNGZ5Y2UvLzRBemQ1bUdJ?=
 =?utf-8?B?K05CSElCQUtCVCs4bWx2eHJ5cmN1OXVkTkhMUW5HWkJ2L251RlE5YVRpUVhB?=
 =?utf-8?B?cTdlY0QwT2ttWHA0UitpT2VncEZ6TXBLYTRBRDRDRUJKQS9WQ2R5SUFoNEpx?=
 =?utf-8?B?RUloaTMxZmJndDV3VHFGdm95RkVrVUIvd0tqNGhCODU0T2VlMkRqVmQ3UytV?=
 =?utf-8?B?MzRXbkR4VUM3KzJDNVk2MDRYd3hDcm5hV3lXQjNKY3VTYnc1NUR3RmJGK0JL?=
 =?utf-8?B?UDFGdGxpd0pWdkNWWDlteVlrcGQ3TWdtR3ZrN016M2pMUS9HZCtFb1JOTkN0?=
 =?utf-8?B?alpPdG1XeVU1c3oyTGgrVlJMc2xVd3ZFRlNlOUVoNkJjcUV4WEkwL3pnbFFl?=
 =?utf-8?B?LzdUTG5jTFd6eDlTUUxJSjRBS3ZzSW1XYkhpK05XNnczejNxRW1sWGo0SG5Q?=
 =?utf-8?B?cDRjb0M3NXVRYlhxcnFldkd4VUNKSldUWXU3QjlaSzI0dnBtRjlqeDJwaFFk?=
 =?utf-8?B?dVhhQTlJTUpERVV0ajY5T05nUFVjbkdjdldiZ1NVWEtvcGhqQjRKc0V5VHZV?=
 =?utf-8?B?OHVRKzVzUTZqYytJNTZOZTF1SzFpdWJ1TmtMRTg4a1dIWnMzVjlEK2dFN2dE?=
 =?utf-8?B?Y2Fta0QxaG9kOG44S2xYb3o5YmtXT1VxUm83eWhEZk9MNktlYkRoTzBUT3Ja?=
 =?utf-8?B?SUpDQk80d2tuL2wxZDZVb3NmVm96aGwzQ0dSRW5hL3Zoc2I0TGY4SlM1M25l?=
 =?utf-8?B?aXI1N1F0bDFOV3Y0ZUpTazBHUzYyZHVwMEZMTm0yWlp5VHhvSmRNSGVEeFBz?=
 =?utf-8?B?VUZzdTZ0b2tDT1pHY2RaL0VMUGtUWkljWklUQnJjWWRxS3Bsci9yYzk2WERv?=
 =?utf-8?B?MHFDVmEvL3pmaGJRU3FYTEYxMlVuSmNBdElPZVR4ZWtyU1dMYXJCWkNROUc4?=
 =?utf-8?B?WktIL0p6OTAzVzIyVFZLVnBpNlh0RHRpVEVtTUFxd1N5Q0RNejQveEQ5WjRU?=
 =?utf-8?B?T0N5N1kxVUdKNzJ0Z2ZZZVNVY0h6TER4ekpvT0E2R2J2bmlxZi9Oc3ZCbUwx?=
 =?utf-8?B?VlRyazRPOHlxZHF0aGJmaVprR0tKWklPT1FSMHFkcDNENEVvTzkycnhUcVNM?=
 =?utf-8?B?ejRJcTJiWkZTZEJSTE43RklFOWw0RjhMeDVqUjlwWTFRVllYcU5La09nS3lP?=
 =?utf-8?B?cUZEZUtrcm1PLzVRQllFU0RtdlJvTVZTL2tyTlJ4Y1pzcVpvSkF1V296Nkc4?=
 =?utf-8?B?MjRvb0ZRUTdDTGYzTkZhZFIwbWgzNlhmZVAyNUl0SlZrazhjUG9aakRJK21h?=
 =?utf-8?B?MThsMXJvcEFLeTN2enZtSDAwVVhqUDJXcGx0Rk1aZDZVOE40dmdBWnArQURs?=
 =?utf-8?B?STYxQWI5MWZnZ3RKMWJjVTh1RytPRXBjalBqTmVYVCtOMHRHaUJaMmVPM0xH?=
 =?utf-8?B?ZktxR0dOMXNNSjRFQlIyLzF6Rks2a1gxcG5kSkRUcnFFZnRoZkEzTlluRUZk?=
 =?utf-8?B?K0xVd1FHc0xPbitRUms2MmNKQkRobDlleE1GcDlCWEh1clhTTFIyTm5md3Vh?=
 =?utf-8?B?TlBsZHBWMTF2QzBMVktnUTN5R1FJYkxCdVEyck9jWmllVlcxVFlIdXJwL21n?=
 =?utf-8?B?aHJlbnlSWElRM1BLMmQ3WTd1bXZlMmRoWmlzNzVRSjZhK04yOVp0MHBWSHd6?=
 =?utf-8?B?ZitkbU9OL2x2YWlnUjFUNWJnPT0=?=
X-Microsoft-Antispam-Message-Info: 3vpOTXUp7rL5Rw3fsPmCQ6dMOxvu4ULEUZgzC3vRhCVXs53YP8eFSo+KBx1Ws5y7ldLKRNRXnTHc8J/5gMBKDA64O4c9d7EFS8IRrei7Z4nSOZrKZOf625YNrjqNVbUGsd1wf9X2u3JfX55c9BVZESxdAE41nF3XfT8HbpeplgVmYlReSFlA+o4EWGngp8OTVhBIlBsf7v8WzVkFT1/ihaKtsJ1DwQaF62Q77KyQEvPIfURSzlL2wJCjeXqPfsgzmHIN9u1rEoN1pn2mCSRPSkYjV7UPxZ1Gb4owSTBKkMm+m+A8Q8fYoZxc1AyrNKYu6i1qyMdxKYxydNiiYQcdBIDnJSepNjpxbCMhcwpmZW4=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:+NzP2ZtUjupdADMOliPj5nNBx0Z+mncMUKqgDt7JhyEvP4xzsHBw29j8PzvtOGhF4O9FVUsruGLt0VfXlb42zOX0bnVAZQW2DnpJhE9ZWXBerwwHwrkqihKVZjb53c4I0dt0ltzU4tHHJQv3Nv8Him12guZoWMpDMlTa2yB4zlPwnBYEp66q9pAIz9XMMuz3kQDwCZHLcHjobzecmhfN6WiuLUmvT821MOoVTp+wMmhntAxquOqJQzZU9f0e8BEiWJo99g37P1m7YCuLPFdy0FjCkaMZKCL+kbtHDzA/V6jh5pj4yt0vvH2GzI5inm9mzE1FCd5xZb5bDJkxqgNIj0CSfZMTdoJjNIfmIhaFhcwISqsZSQbf1jPeRNUkELtVcWc31RhGIi83jJsm+B9t7sGkSJbcCipZ22nVGGgpUT9Mluz2vh56Hani0nhuVXYkjCWdHggCRqoAySJw66iZyw==;5:K3BUbIHLlS19s2nM/MVVomUUdPnSCAYh4lBHTt2GWeTGuJ2IyfdzGbbNUgvpqxImhrBJVQei+csCHHZ5d0iDE/KLoO92Y5u12kR/KyA4Mo+0cxLh1JPUQ3xHF0TOfveHLjLQ3p2RyfKB7Khwyvdz2Z+BVXMH5q4rVMF7OPCbXV0=;24:pPoj9B0ZUCoWpvzdOTKLdoafrjEpu6ddbOVQI0JmKEYoVdBzBpAIXCMbEPf6BV5MKjoPlDSLppXBElNe5+f2vC59n+1+w61sMlacxvdLxac=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:R9l1vA9yEn+qnZ/Jb7UEWj3wZa4dt6hTnzeNH3W90lnAU8TPdBlKmjWc2ODx2fXWgmBhHfBQxBkCb/gYgVcV2l+k6enGlm8tsA3W35sQkhDHfInrC62BZwlVg5+9kl5bFMTZhxgrlFxGtGxiIhnVitzX8rdu+7qunug03+NFU6a3oXI6cM1++OCeUu+Ww7jvkQoXxM3N8H1hgv4B68Pg0beihXUvlhgFB6gdGAG7JIuJTfSTTyNDrXJxpyobs7WS;20:nsLGHjZrLX1Wfbs1qbBE2EI15q8zqTqOpo6bRiQG2Ydh6IVqQlttRwBKKkR5Gs8TlZIgYW8b4RhbUPfEBosAsXxNENEuQdZAy8bw3amnvveNBpLipWqYiaWMOuLgPESDBYvCRgYW5ly6DAQJizOtv+2/tMLxC8OPkKbGIXfUgDo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:39:28.1480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad662922-14f9-464c-ef01-08d5e5777d04
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |   10 ++++++++++
 mm/memcontrol.c            |    5 -----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7a04acfecd23..e931cb4a7bb9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -318,6 +318,11 @@ struct mem_cgroup {
 
 extern struct mem_cgroup *root_mem_cgroup;
 
+static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
+{
+	return (memcg == root_mem_cgroup);
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
@@ -771,6 +776,11 @@ void mem_cgroup_split_huge_fixup(struct page *head);
 
 struct mem_cgroup;
 
+static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
+{
+	return true;
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cac30b4e9904..5a39fada3562 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,11 +261,6 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
 }
 
-static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
-{
-	return (memcg == root_mem_cgroup);
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be the memcg's index in each cache's ->memcg_params.memcg_caches.

