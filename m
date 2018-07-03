Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D50C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCAA21EFB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Edcc0V4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCAA21EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933844AbeGCPKr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:10:47 -0400
Received: from mail-eopbgr60106.outbound.protection.outlook.com ([40.107.6.106]:46787
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932668AbeGCPKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6EmwBuQQemhBSHaa0oZ6uGGmkQS1ISWIHCzJRayAwo=;
 b=Edcc0V4PQarQAGoh8fEHWOJ/kZSHuaUvOT5iIIpEgmmkPHLTh85ogTVjV13gvA2OVUVr2pszzR2Kv2VTKCQW4hCONHHLf13kW3KZKNCTp4L4qAgIBp+gvEh3tZvlVn7/HuKQ/KBLfKNe2bQY9ROwPyHY4A3Qn5HRvBjWCM/AqVY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 DB6PR0801MB1336.eurprd08.prod.outlook.com (2603:10a6:4:b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 15:10:35 +0000
Subject: [PATCH v8 11/17] list_lru: Pass lru argument to
 memcg_drain_list_lru_node()
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
Date:   Tue, 03 Jul 2018 18:10:31 +0300
Message-ID: <153063063164.1818.55009531386089350.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0701CA0058.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::26) To DB6PR0801MB1336.eurprd08.prod.outlook.com
 (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f8be903-47dc-47ca-a444-08d5e0f7225a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:psiYGilGq5fTCUHffx9/qww5se6/fLwaHfA3BxXAfAOVjZ1vMvd0zbolhObuL3OwzqVKtYYzyXOxJJEk57Vve+0CO1Z3FWvBdx4/oVHiYXjqZWrh/k+Xm5FfNHfvVLMGWX5qyh9C5zeQ4sa2Iggy+5NFEgAwCwKcT8dPLCkyasq5XxURK+ioLFSV5bXKwqGslKD6OFS4m89toIqbgzyeqRLbjSGZvZ8Ia/uMBj+iqPnhUC1gevhWBRMKhRZSJ18/;25:jQM7lSAM3vQhByd/VBXzzK9kvh+FoJ+3BB2TCbVWtQjlROt3nrH78XsuYnWlehVpp/zmfiMWsb2jcMQtH1RuGaPPAoGLNZDxirjJin0SS2s8wDE7BtAsIQkJi5SmQemJnMmJB8mY6wd4LBVK7OF58lbORBuIFiPo3DOaOHhQMcRs15yVspU+pTONhopq9HIJKOqLj+YcH/TmcT8NIkAxHKq2pPxVE8+vthi8UJaGvVLHcxTR+xrTmhbe024KcNmmPX79RxPsR8sNXWI4GgtZbzvsXNMw25k2MbosYCyqDoaaETYFcx9ejwCxDARG/Rvs+4fw0MISll+iMQmpOPxKpw==;31:8gNXznTYuSm7OY8prkx5euPvAiNsbTjRaRGz39Ted1mgjX5LU7JuVDQNp78Iey4VBcz6Nc/5FKaS9WxOf481KKjjeNMq8W4Z21LboQQTeIqHkqfIWmvptFhrPKTeCt5xSNJSWc0/2byLhknVirIWl4LvFWR/LD/L48egw6JykgdhDzCSiL/lzCYIAi+Lp5+fOpwhrLbLHFeid5Nbej9VmK1Ms/HkAUlg4SJlR7ES9V8=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:Wld3HHF3Ynjmx4/J4IY51r3scD1jMNnG9r7aYhhhBBBnjF59/HVdR2TpFckrbD435bGVV5CJAoaZjSYoLf36ULsP1NcDFTOrEjp0opEkMpmMrQvds/LyW+JFkynSvN/g9vOZdRMady53ORl3PnmWc/ALVFP1GuE22SmggDrsRSPXEEE8mADqanq/zdQuqggN5a7tbG8c8J8A4ys/HAUsD3TSb89NPGw8ZJkj/+u78F1RpI9jqajEw+TLUqc+E85raQ3l51/1VLK84LGnKs9F+Dr31oIOrEY3tn6RVtbJXb2WTs0ouqoEFaP5Uhksx/IoRfgjQ5qUqe5ujiCPfhUgwGeXyZHafncdmthtL4g24NSouHh/ANTSjm3BJHT1YO+CFymJol7aS8Ycv/Z8qtKqyuQee8x0kQtnv+r7jQCyUv8uhNU1UDX8uEWd2LtZL4oGRnbOMmGr0DbBdwXGB9sIue39VyAZkCZ6u0VPjK04m6SawwWZ6GYu2k5Xrhmoh2CA;4:qulrtM6bahwNLuum50DpEJDrYKup5Y7giT7pMlRCO0Bcc0QO4184KeZvsEELPpeMN9plSB3TV82RtZqnAMu6lQx2UZl3p9FGMJlItPMLex+quj+UiW0420X0T+qhH4eO0w6ufi87rLevKKmVw/LBWsoEd3QQLQss+tahwosLMzEPraL7sCoxCCjdxKfuSMi9dRjAnyYRsaseA1Qj/PQ6XotCTkdJkAB47IvVWQu1FCJwN4X8dk4O1N0fM/lIBYwa9pmBFe6u0MAoFQFgk3SSpmROtCzd6VOihdKLCVGu6mPySM3nPXaPuLi4hTb5xgpW01no9GQMPMKvWT8khfl9e3rbWJLPUVMDCQBlImLBfmH6m9ydDwTDPH0namCees8t
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1336755268DE852F27E49088CD420@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(366004)(39850400004)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(26005)(16526019)(2906002)(23676004)(14444005)(103116003)(39060400002)(186003)(66066001)(6666003)(47776003)(2486003)(7696005)(53936002)(55016002)(52116002)(6116002)(105586002)(25786009)(106356001)(3846002)(5660300001)(8676002)(97736004)(50466002)(68736007)(8936002)(316002)(956004)(476003)(7416002)(81166006)(446003)(11346002)(230700001)(61506002)(9686003)(76176011)(386003)(7736002)(81156014)(58126008)(305945005)(486006)(86362001)(6506007)(33896004)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6WlBySjJsdFk5aU9KV2dQeStaWjJpeGR6?=
 =?utf-8?B?MlBrNGQ5aHM3c2FtWVd5UWlGV0hWMDlTdW9hQ3NSdFpCRkhxZUtRTGc3Zmg1?=
 =?utf-8?B?cytnS0lra1hZa3lsYTA3QnBnYndHYzBrWXMxSTRrczZJNTJMalF6V3JUcXQ1?=
 =?utf-8?B?bWczdmQzd0tNUTVNdlVyR0xVc0dHcGNOcWxGQnN4U2xLZ1p2YnRhNHFNck9i?=
 =?utf-8?B?cGNSMHJhWXA2M0dpVkxya1p5a1NobFEyMm9GOG16MkxQVTdaSHEveGtmRGdU?=
 =?utf-8?B?TmZXeklBTjhuaUZUOTk5d1dmSGhvcHpKcVdUcGxUYWNEcm9rMGprbElyNGxv?=
 =?utf-8?B?c0xxMmpmSSsrb25rL0VyeDNxR3M2Nmhlc1BuTjZSbnZxellSVHIyTHNuczNy?=
 =?utf-8?B?WEppVHNNa1VZbklaMjlUalhzUXQ4dVJVSEFRUkUzZzgxd0RyQitnNTRNZHpz?=
 =?utf-8?B?OTBLT09ZVnBCYUJaWmNlSWhzSzVHT1luR1ViUmFEUE5rUVhhUmxZcU1pQ0pE?=
 =?utf-8?B?bytLYWRBYm40RGc3U01IVVg3WGZYZm9TUW0xUEFuSkRzUDBCTTl0cGZ1Ni9m?=
 =?utf-8?B?c29CTUR0OER5ZU9NeGN0MnhjWi9CLzNqSE1xV3pJRllUZWU1MExFMThWeFBR?=
 =?utf-8?B?Z3hmT2t2dFlkTllmbUpCVG5xWllNZzNHYlc3eXZGWjJtaU1teGxDa0tyWlRT?=
 =?utf-8?B?OVlQSGtMSHplY2dsd1pnclFYb1pxT24wT3ZWQWlxV05qUzl4MXZuOFFjOXFY?=
 =?utf-8?B?dDRhK0ZwQXpqVlBsRTZFdUpQTFhlajludjRYVFV2R08vNmxjR1UwRGZkSXRo?=
 =?utf-8?B?WHczejdLTlJ4b1Z1Y2dndThibkx5MHpYZFIva2oyM3pkTU9wd3FJYlI0Q1A2?=
 =?utf-8?B?VnltYWtyK2FETnRwR1FwSUlLeWRQWXgyYWtrNFVPUDRtZmxOTVdhWTNwaVI2?=
 =?utf-8?B?U2R0cG1idkRUV1hvSitoVHZzV3k1YUs3VDNwUDh1dGJPKzRIdDhtdXoyalRW?=
 =?utf-8?B?bTR4NXVlNFBiMVRSbUJWSlJ5aFVDZVVBTkN1M2VaS0hTeDRXR2lIL0xLOGVT?=
 =?utf-8?B?UlZmSG50R1BYTW9tMVExRHVxbGhkRTIzazZPaHFhZnhmZHpFdllraGZPdGF2?=
 =?utf-8?B?UFRrV3VDQW5lTmx1MzFDeUUxMXpEMjZlaVkvV1VST29xdlVjL0kzRVl3V2dh?=
 =?utf-8?B?SjV3WGZXTnllUnRDWlFJMTR2ckJGbDByWnBQOE42MFFHNCtNK0FCdTBjYWNo?=
 =?utf-8?B?d1FlSmVSWXc0UjlDelgvUzN1azgrdnFqSnUyNFAxVjNHWCtJZUo5OWltbS9u?=
 =?utf-8?B?MzdNdGdXc0pTWjhDK1F2bDFuRk1TWnhiVFNYMjA5MHJPaEQ5VU5TNW1ZT3Fh?=
 =?utf-8?B?Q0lMNngyMHl2VDd3WnFHMUVaeE1vOHN4Mk5sZHhoWXRXUWhId0taRUdUUVoy?=
 =?utf-8?B?dUdsRjJCWXpqQkVVOStJQ1VFbGJmbUxMY0ZkeWNmSlJRNWNlUlhybXVTbHZh?=
 =?utf-8?B?dTVMUk5wcnNIVkhaTU1SSGIrVmdlNG1sWDFyOSswOHczZWtwT2EydDZ0YlhP?=
 =?utf-8?B?WldFL3hVbWttYVduWjZyOHZ0bFlzTXRScmwzQ0dubXQ1S3Jvajl4TjlRN3Y2?=
 =?utf-8?B?Ui9HRlRFdTNSZ2pSTy9GQ3I1T2RrVHV1ZW9rTjN1cGlHMUR5Vkc0WUxUZ2VV?=
 =?utf-8?B?TGtydGtJTUE0cXM2YlE0aHdQZ0JNVnQwUXBIWG05a1JxbE5DQmd5QlM5aDZC?=
 =?utf-8?B?S3pSVTlDUGg5dkZmSjk5ZUZlVjVIaktmQk03N1BwakpIVWVyc0hEVThhajNu?=
 =?utf-8?B?aUxkRGdFeVN4Uzd6M2lTSWFDNDJNbDJ3NmowNnRGVTdaK253MXJ1QmZGOFlx?=
 =?utf-8?Q?Cn43RjNIkAoTGbSXlbu23arfokMLrX1SBw?=
X-Microsoft-Antispam-Message-Info: AZYDdmuvQRIxcMaphHjbBm0HdDqVUlOoNh2hNMQ7lmgu4PRH8ZOBNn8mYCnnIyEHZYpD4uMzHMku8SWT+JP4GIuPaymvSUE3H3yZvJ39MGT7hQ9DHUA5pP4zR+4OpdvFlQXPis9pze3qc/I2cSSjXQIFl3WQZvwnynDMgDwHVMDvQOyz/ZCXDfDM4pGhQJuJkL3q7L4XOFKzDYR7kkxSxQVpxi/WMYiFYm2p6GMvGp9KlCHinv4WEl6DhohEp2EvZU9RhMTxM+f60PKGihCpzTHzH7qHQ0qBnSJA7t1XbL2yyRr0rUJXMs2dXqakSC4gj1exBDFlRB8UDgrEWxlsbGEhzCM6aYXzxd9LGmR/KQs=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:u5z51yKs6E8y2QJ6xLVYSDCPpvLAuzW0uCp2eE4nMBsLunw4JiwY+FcqEz4SQf+EvmmtUe9ZCrDWN5MwJDoORp0NtDue+5UxdPbnwk1Wh//L/xBmqFMIi6XN1YbEPSQA7Cwnt6zsLfO1QWfluuQKJZb5gF36hbT4giNUbU+/mXqQR+UA/A7WpvT+MLmudTGtNOXkURC2a4f0HNHkuT3IyD+9E14N1P5rdSTOhC3HG6n5DEntxI3t33M8HbRs47kbPZitTIr4LaUosHlsne4PSGTy/38ePzo5aGEmoPm+uS75ymEG930v50yGP30FCBxtrNS+YcmyALnRn1AsJbPtORW/yCmyFUVjhGdL9jPko6J2YsHvURe1Dq3EBpNNtpJlpa51uJpmGMvnFKqDMyBqSwHqplICVTRwIwgj/RJt46u8MrqZ0xcFRmo+0VMatw8vnN1t2fs8p4TGPllqmM0SIA==;5:t+y3yKUOAq2318Lu453glIVHI+lxvl7LtNN7Us4ENrU+sYNgu76l0NueIsOwx4HDepNtaw0PI2sMWQI0cSej5/vaeXp1ZpO0vaVzKYvl40DsiYFSubXOl0mSoZfMb5H0YQA0EFm7wzvj69FZeQE8E9qHKREubLBjnl13WIdbnPI=;24:k+bgXAknLVUy32IX2AjEpukZ+fcVXGZIulEuSvmtVbagnPBv+T3Rlj9McBsAE2eF/7fB8LCmp73rPkup9eJp+AzAcqhCG43EZNy+kJIxHXo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;7:x6EeeM70xK3ZrXs3pAAxHikvoGh7oxJvR4ALVG8LQHbkkdXrQVRBR3xHYiqKGtzuV6gOD8hVivbXissTo+3+LlFWGkV4udJAoaWtu1sxs0zxkFSH40MXpjA1UneVXeV1dqgxCiHIUCtFYBlsHTGG7+kIBTPKKIEj/zMKaPF3W/eyMqXJwUjcGSvCaQmKkR8g7QKBhPF1wahbYrZcGdErVrVfuB0KS/VnDpi2m9HbXfGQPgj8v9LDDvrEmDbXmBcj;20:8geLo2NYu9d2LkzS6u6iOnCxJqOaapyoxn4ueapTkt7ileag/+MaRIKnPfitLvnqpCPMMmXgTgRufQHhCOccRmXIwDN6m817FCfGSYkrkm3Efl6CVWYQt08ccpnyT3YXzAs3+r8NihHV3URQu0sYRzxzqaR4+2VuJIcpwFbw/7s=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:10:35.4161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8be903-47dc-47ca-a444-08d5e0f7225a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just refactoring to allow next patches to have
lru pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/list_lru.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 467820201e2f..fbda35ac5c17 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -514,9 +514,10 @@ int memcg_update_all_list_lrus(int new_size)
 	goto out;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
+static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
@@ -545,7 +546,7 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
+		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
 }
 
 void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)

