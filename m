Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C0AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5577020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="artyIkDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5577020864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755258AbeFRJjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:39:53 -0400
Received: from mail-eopbgr70122.outbound.protection.outlook.com ([40.107.7.122]:53312
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755176AbeFRJjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzrhUnLlfby1gTgUilKw9jqsZ/m1V4sHluMgVAMYm7Q=;
 b=artyIkDbZD/EcueJcY332ozp1cfqk+17G5GBf9hrtg7FDi6ImjEf0onIAtTmZnP/Aq+hDCQa5KBvDlLgDhwOzgp/AAepxTzqNpBojzHRQsJyoWUb03EOlr/5jD3+7kcAyc5DdSm0l6zo664buUetI8hPJ48UvGK5qALb4VzkfSA=
Received: from localhost.localdomain (195.214.232.6) by
 HE1PR0801MB1340.eurprd08.prod.outlook.com (2603:10a6:3:3a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Mon, 18 Jun 2018 09:39:43 +0000
Subject: [PATCH v7 REBASED 01/17] list_lru: Combine code under the same
 define
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
Date:   Mon, 18 Jun 2018 12:39:40 +0300
Message-ID: <152931478076.27697.6557341797521841126.stgit@localhost.localdomain>
In-Reply-To: <152931465724.27697.12828290733260370115.stgit@localhost.localdomain>
References: <152931465724.27697.12828290733260370115.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::48) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3cd3e3f-b682-40f3-df39-08d5d4ff6cef
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:WdGMYoS2tCUKwBFWVGupdlwKX9gAzTsLo/1m2825Ry+i1FRVAXbt2dP1TuzuZvomt01GtV9ZYbyBlXRpJ/LGtRKzngz/8Tqs0SZpDVANffED5wSiwYsYfHkalA1TXr63z0Be/dFe5Fkfn1KpW8V9LnDmR+xEjugXvN5laWkCT4C4bppadt0URB5ddciD7bg7r1HsQAPsQ6lZ4+yTQUdnEJWnc7LQXCKobvUQYv0EotG9vh8PapnSnHwqEiF+kWUa;25:Lw7ga+EVGBp7ELTx8aBL9fH/xLBu5G+B39eFTmYluLLGLEOaNHUKJgCVkCaYAFn1VUaM7oTBdXrgZpn9bhp9s1VjK2YnV4QXsW6z+GdKcmB9amN3j2QZRNuhw+TiVAnzmJwmyiZb+rf9BkV581FM65DSJ1S+XKH2HrlRFNprPHdt1Ko1tBcWwYWVHFrCLoP0yN6DpJWFPJ7JJoKv0zaRDUfKDHbA/ufKHu75pvQ52NoT9Y/fWiMLjHKlC/owL12+f/AJv+uAn2oed1CwgdunYfXvKx+b9SWHXSJy9eXnr7OI7Ux+eDsmWZadIcdGG1s3QC8dv2liRX7yTkbeh52M+Q==;31:pAZKJjeIArZ5zGS9vBXxv4DFCJ3azmXw5+4JfgBEobsEg8m8RJtEaDiym4VHN05jahv48Znr13kT6XS3ONKkYM5ijgS/hFgS9q/pP2A7XXcUhv1ZerXP/rqnc0yzcUMJq92Yo7GXwg1casoQD1qj974rCjNj4lRLmYc7TFQa7rwYoL74nYD+4hSeInVXK8OliNwRymN+ttieaWHYKtn2QHwGe7HeUdRHDzH1RaNLIko=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:zXgIAGdOi2/OXKLcSrzJHmyLA0fSynRhLAqZuF2CEoBX6fXTO3dqGSXhGIyyh9F5VnE9RvxzXk3JJQiYKdA5DLgUaOlk3C5vqrJAOkpyoXeVMdUBqvyOyx78pPehbfVZTwvuH4F2DTZcxMpfjkDdg/pEhyvB0mqJWM2d1TNRO9M2hmE1+809a2azs502KGxfTjgfvML7rTFE2sB8mM5jiAEYNdZiT3jLJ5B4y3hVFjKCP7iLf+hk2/l3yHROGX5jKO5iTOzIYz3EPMwMMZKMWixDtg65d6phdqZ7I6IpIPCcM7QuXuoaiGhUb8868xT+P/VN1KeQOp/tGnu3Z8SDhXFcz+NYUrv840qz6u8zmXBjUzUKHtk6jjEvFPgclFqMSHQJsdIoxYnSJ7KYH0ay4bzl3kVgAxowm8HblPtCL5hgk4a7m9oQljbMEFt0qb3C67qT9n6kvWtKVS0kYuZ3Wp3uQuSm1nFNmihVpaC1wk2zy50Gf1YZUQO4xJCKnFdD;4:Ml4CzA1f9BwIZj3BAt3vvzVLdcfiDt7mRCi0mUTrlilAPfVanuWn8FNmejSRxGwL8zFJmOswx8DjA1mp1wFfdxqZjBN5cEu+o6xOoX6QnQzpnV2yh4S7VkwvcTIdL9xfY8ndQxLmsy3k9Dhb2rR1WlqKmN1mV/tro4zbS9r6faYxX3kgh/VlvtFDJUpQqQBlBYdX1oUEKr9CaUvn9J0UIDjoNwCTdfex+ENAolru/h9JyvBc3oGL6DkzpuUrUuy1Pk0mNbmj2/fcBkg2mNo2i6mn31H+1Kj4a90PI2hGaseSEYQYGhg20QRWEhinCpYskvsObIl3f7KgDbBaOpcWrsh1nQTd8R0rdtiRH/FiFxdSOnN4sbHGHKqDdc012g+D
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13404731C78E4100AB60E608CD710@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(61506002)(103116003)(53936002)(305945005)(16526019)(186003)(86362001)(486006)(476003)(7416002)(39060400002)(25786009)(105586002)(47776003)(66066001)(316002)(11346002)(446003)(956004)(9686003)(2486003)(23676004)(2906002)(6636002)(26005)(8936002)(5660300001)(7736002)(81156014)(81166006)(33896004)(76176011)(55236004)(478600001)(230700001)(386003)(52116002)(7696005)(8676002)(68736007)(106356001)(6116002)(3846002)(55016002)(97736004)(50466002)(6506007)(58126008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6TEs4MGJGQTNvTXZzWVBURUEyYlRsdFBJ?=
 =?utf-8?B?TVpuUkllNkRqZUFzWHZHcFNkekNPVDBQaXZrL0wvMDhsMDUxRGJldUhxTjNV?=
 =?utf-8?B?aHBES216ZHpDVlhFc0QxWm9ucHNNRTBjVnRpekRPRWdPdk5zU0ZCZmZoNWs5?=
 =?utf-8?B?QmJsQWdJY1VjMkNrL0pjZEp4Mi9Kb3dMWHVsNFdMd2dZbFpSZ1dZZWx4bmY2?=
 =?utf-8?B?VEtSUmFTb1lCTXhxUjEvL3lpbXBsajViT2pKaXhuZFJENi9tVWpnSDVRbjc0?=
 =?utf-8?B?U2pyQmg0VndTa01MaEQ1alhYc3pWSEZzQzRJSVRtVGFvMGlTeHlKZVhYeGFo?=
 =?utf-8?B?UzdBU3lFNC9rK1E4ZmNwc3BjaDlyWFp6VllwRCtFaCtvOGFNdlhmRFlML1BX?=
 =?utf-8?B?NENHeG1TeVdjWiszNHZweW1yazREWFEwM1ZubnZyY3o4NE1XQ2srY3pXMUtl?=
 =?utf-8?B?RUtTaDJ0NW1uSlZueUx0Mis4bkcrTlNQQ2s1MjZ6VGQzbGpjaDVTRjhMZTRW?=
 =?utf-8?B?VmFMN1pmbXRWaDRxcWtsaVp0U09lRk1IWTJ4d1kvOFAvVjJZbTNTVDVuOXZB?=
 =?utf-8?B?aFhueXphRjRMbU96amI0WjJISGI4TWpwT3RNeEdreGVZT1hkcy82VmNWTmM5?=
 =?utf-8?B?cklvbG9laFVURE9MTkNSMlpUbG1pTi9OMWVjTHlrajVzUkVYazcvd3dkSVlD?=
 =?utf-8?B?a2wvZGZidlFoQlV1TmdyNU52NHF5YlhxbE9mOGZhWTVmODg1U283T0k5WW1j?=
 =?utf-8?B?eklhNnpQRlg5QWlDRXhBU0JzbElndkNKWFlITW03ODUyMEJPRmRTakt1ckRD?=
 =?utf-8?B?Zkl3VGNENWw4aDdCa2ZuTG9RZ1I3ZkJyQ1VPU2xBU0FDRXhveDdrMEo5Zldp?=
 =?utf-8?B?ZnpySU8yQWlDVWJLMWcxNGU5VkFjRVBsemRDMjdyUm83aW5vMXRBV2tOeUZn?=
 =?utf-8?B?bE8xZzZkQTVYWmg5VDM5VWcyNE9BN0ZDc205YnNsTENZNGVwL21seUtaaUha?=
 =?utf-8?B?K1VPUlNkMjVqdHh2Y2hYNURmR3NBZktqME5LR0JIM09vMVEvQkE0SGRyaE5i?=
 =?utf-8?B?S3lwV0Q5cE1xNkpWMFR2OFVDQ1o2aTJBWHR4MHV4cldWbEQ3dy82ZHpiUGZr?=
 =?utf-8?B?aDJvSm04MnNCcklvcHo0THJHbGsyRE5aQ0REeW04d3hJY1JNakJEdzVCRUYw?=
 =?utf-8?B?dk8zNVFpb1FGQ053ZkZqUnVMdE1Ba0lQK09oRzZ3YWc3dXBJTU1nLzdGVHlR?=
 =?utf-8?B?dkxwQ0NlbnJZTSt4OWhtNTE2M1pWOTl4MGdHaURKdU9nU1hqNlhKNk5WbjM2?=
 =?utf-8?B?b24zVHBpMkNWVVU0WDhSNTZqTy8xZVZTcEhEby91a29kcUVSK0lGM21PblhW?=
 =?utf-8?B?UG9LVHVCdmZ0NW5aQTFDaStrZjMrSTJGYTJwOGJjbWVDOEFrWlpOVUJydzdF?=
 =?utf-8?B?dUpLQUdrekhxMjVxUnY1OWtGVy9UK0lDb2lqWCtPblpaYktCbkQyb1g4dHFq?=
 =?utf-8?B?TXZMdzFIOTNTK2JmMFdLcEVtQnZCQVhncXdMdnQ3UG9SYUpmdW4xc3lXc21n?=
 =?utf-8?B?MGMvR2VJYVRhelQrQnc2YnF4YXFIME8zWGFTUXB0Unlqd1ZCdkliWjdTMGw4?=
 =?utf-8?B?OFlrREFEbjdnZjhCd2JnSXRlV1d4dkd6d2Z3SzBmUGZVZTlLaWVTdjE4dkhU?=
 =?utf-8?B?N05zdHRxZ3NNRTFlRi9kQkFHSWZUQmZjNjNWZzRmYkJBd0FXNFFwU3F6NXF2?=
 =?utf-8?Q?jZv0CoK8eSl2bRkn4LD69LdhExlaOUbJ+TxQ06E=3D?=
X-Microsoft-Antispam-Message-Info: v4EDsP23RzDvuw8E8rJIBxUu5wRQw/A95+nIGesU07aIC6hcLzPgEsYslMp4+lHdOcqgf3omURxbRxuxJueWmBU4gbY2zvds3N/ohVC0rdO66Eta7FjBPCX0JDQ7YlD6zkR4HZ0g3JPcyJby52XGXZUBXtGbN3P4UlZSQXy5yW8l2TWpFfBjZ8HUBE7SkMjxH+KG9DJO93bKkKvs+GSPz2rEKs3CVYA/0VGmcbINp4tR5ddFU/9p9OlazRpl5zgXKEMl/BrZPK3MD8dVbcLMbcV38yt2n0642umHc5WvrbZIIX/QxCPlUp51vd4TwhAFIwN08RtfEW1PWmKsY2Xomw==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:a5ZsWRuW59q+CPCwfca8BIjiyhk4ijJStmd+uwE2lIvQqcMJVw7Fizsr0lgYV9no2WjPXkTziyRapRHvPPn4g2pifYiBN+YSGwsRZL+6AWnInivw2NglSTnfSkmpxTk6L/HO7O4OyPlzzhX/nl+L2B7h07DMRVVoFoPpXnfJ7gfAmapDDILiKKsIKJbOBJMHu55kqM28QAV54KzbjtnSCBAzqDjWFs2ewQ/tgVC4UbKM9LNiAbN31ZNt9u0p+W6OIm0hMMIRm2ynyh+SRAlJaopw1cqx++HJocZP4mUbGBJhenELVL/ao+15MBOrRXP+1jt6Yh2Ogig2lGUGpe2oO+r0jw5WPZS1AD55DYWn3MF5JBqxhhFctAS2tdEg/JZIRF85paovCw5GuwH/RWI7R+BbhlGzGxTcu8oBCY48jWH7nFKkpoSAEno6kgyTE0MZ7MYHXMJTl59y6Amp7nVMZg==;5:PY3nKRSkLpsTxX/kc1PURJNRq1cyg9XONp3k7aLOBjfMBV2HIzc4AXhXWPwE+1WueR/WqZqa01nyBoxBH23VPOr90JwgPCcGEgnpmwH0VHMrBNrLTJXfTCmBulCwGf/BpRCuACWowYhUKiwxK2zNASofFPJubpGIwZg4MG3W/BE=;24:ydmXyNW6xeNr47g7m3ElafXaq2LgX6/WU6XnvTQosrPUP8GJ5uKdOP9+EPOo8t8BNOi+x9RKqBingjnMyIMjfTHykCF9bCSIb/coeW9BaYE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:29OGbEx8pk//Sdwq9sjL75PYNSBV6uG8+UR61LenH/Zgv5Oa87vP5fQzITfhQavMlPjMivWx3wSSliMGFUctvrfnYbTwuzbjaaBufpDQ0WQ/a+8BeMa51KT/GmzJNcPxcDuuWBwDw/+pIvfqj9abWr9F5Eux5v3mfYHL1Fguzns8l4VxiAh0kOD0KYIgROVZDYTmi7oiLuzpdIIp0/cxF2sdvewojGkAEfm/Ki2vY+e+jOvW62f8OobaCLMYjOb1;20:Wz6No43AVUKRa7Rodr4TAyd0tqN4mro9yxh+P8+3BpqlEz8SM05B4OPGlvrNM4rHKMHaxUU+DVMKNwG5NWdxvJExOy+q8Xi1eY3dxpJQjuYS2bd3KyMKnyUYV/aM+dQj/oQo1LKl/qCqHj4QWHpQtLjVX4cPUQMCkIC9RJhzzLQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:39:43.2035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cd3e3f-b682-40f3-df39-08d5d4ff6cef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two pairs of blocks of code are under
the same #ifdef #else #endif.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/list_lru.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index fcfb6c89ed47..1e3e2f3a2a64 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -29,17 +29,7 @@ static void list_lru_unregister(struct list_lru *lru)
 	list_del(&lru->list);
 	mutex_unlock(&list_lrus_mutex);
 }
-#else
-static void list_lru_register(struct list_lru *lru)
-{
-}
-
-static void list_lru_unregister(struct list_lru *lru)
-{
-}
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	/*
@@ -89,6 +79,14 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
 	return list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
 }
 #else
+static void list_lru_register(struct list_lru *lru)
+{
+}
+
+static void list_lru_unregister(struct list_lru *lru)
+{
+}
+
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	return false;

