Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FF4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D0720652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JpGqA7SE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D0720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936119AbeFRJqv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:46:51 -0400
Received: from mail-db5eur01on0133.outbound.protection.outlook.com ([104.47.2.133]:55409
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935855AbeFRJqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsvognweBpMutufgYUi//TejtDZGvh91nRU0j8bRTGg=;
 b=JpGqA7SEad14Dilxwl0znJ6A7hy/evw/svEv4AEH+7VHCIrgPH+DtDMWzorujPbV/WsoK4YNlZxnuVeHT0ZFTBgtQa02sKXc3R180gXEjjTmqlzVMZf82AMF2D09xknTEMSnLoHjERg1KWhgnqOHnZB1SWmgzVa/09g+2hgYpRA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Mon, 18 Jun 2018 09:46:44 +0000
Subject: [PATCH v7 REBASED 11/17] list_lru: Pass lru argument to
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
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:46:41 +0300
Message-ID: <152931520118.28457.1502664234163492446.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:3:64::11) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf167ec0-a41f-482a-df9a-08d5d5006766
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:r58T/HTAbbl4jClfvU54qdy81TGuGq5i5ShuIY5VEtp0nm57lW7gnHX2mFcT+KJAHjApIbPVpRqIs2k6nAhTg0e8I0SLGBVc2tMRTPKDlc5OLfHYxbCO/N6Ew/IhFprzr0OaXmDon7sMRMRI3vVYhUxGqfuSwJvBJTrEIqdDSwakEotgi2Uod57OGSRvpuZKKNNar0iUcqTKGVsTeBiyRaRJ3blvQsekPLhVaFOBZMMkTTilgfgyy8zzo0LPF5Mq;25:bUVmuhToUp0W9ic2X+Z9L99YoZW1J68CQsYPECzwdj0A0yvDMjnoxOZU77Nu39Wri6ty0gOCX1hU2zs12VzMEUwhoTxI+Tf2LZiS2Z2FGpY5ap73NUyBdH93PaRwgPnhmm9qOkq9PUpAcOm8TGfjHbtdGch/f/oss+u7awLc+WdiDtZ64/uaudzrVJI5nAY8kjbkepWHf7BqgkvtG/e/JoAAa45Si8iSdhAl2Vd1e5g9q6DQceAWoXxbx21i1BVvWZyaKtv406zDbsWRpwhoOqfOspNiuNNnS1xSfIDh4HxwksflFksyt9GLlgjSkzeWsbwsSAW1A5gnDPcCVZrNtA==;31:nwPwrPF/rEXWjUCccNJsJeS7IDMNfjwQC4AvjJRcfK9aH6+JbEu8pazlD/5Kjrq3rCJUH41/NdDDe2fFg6m4ZprZAzaO3lj9xsD7Is2t2Fcori4lOXJ3tPPMdIcGJhY/g0EyXA55qfMVrA4xFZE+1DXcq4xchZ9CanCBGkkl+ZDZE5SxabS6DRPTijU3cStkc7iTAsW7j4FQpEfu7WSxeETY99ywylxGenLsZGybgHk=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:gvSw0FNzud4C0irh4ZC7v6Xn0mK7KZo3dbqmmBr+ekWM8tl2INc7XTyB/y4sUCOeQd1nus4MCHj1OybaL/DXcc2K4CfgwAv0lqnRNudlKFe5d3A7mxED2EolXZs52FDADQzPDs9TJYQepEO9VPSlN7sIih72uaEIoR5Rc3+l70rZ0MLq/gPdtCnEgDPdxZjyx8ktaM4N1xRvxd6QjnhwrLBLovcR3CiJLYCIFfklhgJJsyg9o4dP57kd3XtaW6VTGlm1fMoa0voAhVeTV0AblrOu2P+S0vHHcSci7qAf6md8hbsND8RcCbVMWvOeVgLcI0oAQ53OxkJ0JKx6MN0aJfoE8j7x/77/SYbcRKAzVtdutiRDDqPcKUS1Nxxb1KSh0RI7hMM+LC0C5EBtV3og0daHZbWIU5JPAs/Y9qhtCp0EFhxiQt0g7KZtPJ735+Wr/DcN8/YdKUnNVEe5Z55LQyebfjXqi9h7cPizj3z0u4aW90Cuib+TQaFIeXaVWzTn;4:0hkQ/up5Ed/Hphvh8DA/mq/oiTWTSAngLV1ftaFdJYaM8un6UKLgq5iOTUUTzf/7ro599J/CB9Tdr54795udd7IIhfcEwWbjnLVu0nfu/6bCHHDHccjZi5qgpFEJAVD6RGnR0xcxnocO/wH6XR50Av/r7+/tcM5I6Bqarm84Sm8R2eAFl0c2u1/tsTPmM5PLHOrwwFsl+7mNR7ZhkQ/0r9jQd3ye+gOLqIDTygvevsCKkCYDZVOPTqdl4SXmmHt0jGlyY91ak807EINpHmaNjUw1Ke5UbgT6POpl+eizpjnR/L6xL9PiwIgaHk1DMllgrlUrjhI0YZnFgmPFHoROpbddAXeyUoLQ5zlVz3D5L9NNAovkZrOQb7L9SMWIsboh
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13385F6BF14E9C538A96A30CCD710@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(39380400002)(346002)(396003)(376002)(366004)(189003)(199004)(39060400002)(25786009)(11346002)(476003)(9686003)(86362001)(5660300001)(50466002)(16526019)(186003)(956004)(97736004)(6116002)(446003)(486006)(3846002)(305945005)(6636002)(26005)(6666003)(106356001)(52116002)(2906002)(23676004)(230700001)(2486003)(105586002)(7696005)(58126008)(8936002)(68736007)(53936002)(8676002)(81166006)(81156014)(61506002)(386003)(6506007)(7736002)(316002)(103116003)(55236004)(59450400001)(55016002)(66066001)(478600001)(47776003)(76176011)(33896004)(7416002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6UUo0Yk03a3B4bkVKTEQ5d3pTWThYZ0Nm?=
 =?utf-8?B?WTU3ckREaExJRDlRRksrZnBWZkJRa2k2eTNJT0ZFRkhoQzZwQ3dXN1BGakhG?=
 =?utf-8?B?ZUNYWGIzZWcvUnRVOEZtVW1vdndXRnJpM2ZlQktkSVlOUEorcUhPSldKUVQ1?=
 =?utf-8?B?NWYvazhtaERzTmtJSlBaUDludDRia2MwODJ5MXR0RXNDbWowK28vNEl1cndT?=
 =?utf-8?B?em56RUV3cVFhZmF5eEhYY0ZrUGltS1hUOVBaR3hHNHdwOUVHVVlQckl2SDc0?=
 =?utf-8?B?cWNKaXlwYmpnekhpMUNGRmEyVXhseTlNclFrOHNpSmR3Znl1RGlaaTlwQU9a?=
 =?utf-8?B?bmZsTWpMNGphMEQvdHVCbGhPNlNPMFV0TjR2UWV5S21xR1VRc28waUxHSkY1?=
 =?utf-8?B?QVZZL3FPL0hkYnRRMS9uZUh4cHJ3c2tObHQ3Nk0vaUduUkJwSVFEclUrbG1z?=
 =?utf-8?B?dURuNmQrY05iRWQ1K0I5MVRlRDg3aDh5bnZDbTFNSjg4cTFsMnBPWDVnTjNm?=
 =?utf-8?B?dkF6NE4yZjVpSW1rNVhqaGE5RW54WVNCWURzZWNVS082VlhRb3hrMDZoM090?=
 =?utf-8?B?b01KRlhCdzkwYWx6anpGdzdod254WFFFRGVXZDcralpnd0VZZVRTWkE2OXpC?=
 =?utf-8?B?RFZJWjdmdllDWElmOS9rd2VqOHpnZWZuVzF3Z3VPby9VMVoxZGtNNGlXbDgz?=
 =?utf-8?B?MXJaNkFnRkhKS1dwSmk5UVh1UkRtZmF1d1lRaU5BbzJWQy9PMUJSMG1QYkpX?=
 =?utf-8?B?MDEvc1Y2WmxBcFNDVEpoaVR2ck83bGs2RXNVWWthcDhJMGVuSmR6djI1WFp5?=
 =?utf-8?B?akh3UTlFeVQ5YTJBcmhUZXQwM2lsRlE1RlNzOWhMcnVDbnpYcHNpbVBkSThR?=
 =?utf-8?B?MzR2RzVKcEdXZVpFV29CeDZCTEJqRnJ0RHR6Mm1La0tGOVBCdEdjK2JuRkhp?=
 =?utf-8?B?SmlqVlZ1M0Q1eW5SaEgzOXVrUzY3K1Q1YWdZQ3BpQlZMSFR6ajcvd05UekF2?=
 =?utf-8?B?Mm0yN3V5NU4xakpyWkZua2tzUjV2YkM2ZDJiQWhqQURtOHEzU01EMHVvbGV2?=
 =?utf-8?B?STBNWkFHaVNDOWZsNXR3dWY5MTA1YTNJdGlOZVRScXg1M3JTNFFDdDc4dkJl?=
 =?utf-8?B?K3grTkEzY3g1UzJvVkF1U0Q0S2czOWthVmdpZUFGVVdGbjFacEpPSm0zMThB?=
 =?utf-8?B?eGEreS9FM2NqTFFuVTltWTlQMVdHakZqZEdxSXlTd3hET1ZmUitFaXlrN3F2?=
 =?utf-8?B?QjRtcC9RZWI2ck1FYi83Ui96dUtUS2pWWnJUbGdnV0V5M0lVM1RLRjVZVzQw?=
 =?utf-8?B?QUh0TGJJVVZPWjZIYndNcDgyeW8yY1Rwck9xN3cvekF4ZXIwUWI4R3BXNVFO?=
 =?utf-8?B?RUNCQ1VycEVSOUpweUExa3U2Z09mZC9xL05qdEhybjZOMVNVcHZVME1lOU5L?=
 =?utf-8?B?WnJYRjVoeDlpYjM0L0VDcVVPUm5XM1Jtak1CMzRFRDA3SHUrRHdrTENtclBu?=
 =?utf-8?B?S2d5T1JDY0gyMEVqWFJqWEd2VnlkSmpmdCtBNU16dUhwS2lTbDNzbkZ3QU9p?=
 =?utf-8?B?SDVUTUN5YzM5WXN0SFhoTEc5aWZYMFkzNC9pclNzTWFwZ1lMWmt6eThFTDQ1?=
 =?utf-8?B?dlJTOEFjampRL3hOZ01waGh2dHB6RjFJZzFLZWdsYk85ZVU2cDVDWndKYkVL?=
 =?utf-8?B?V0R0SUUzMjlnckR2UGJMMW8zOXJOQ1N3VWYvcTlLQVh1dG1vMmJibHpKWWVn?=
 =?utf-8?B?ZGFyS2hocTkwRFhDOEZWRXBWUHZYbDA0aEoxTjhsN29rZ3RBaXBrcFN1T0xi?=
 =?utf-8?B?bzlobjhrWnBuQXAvSGRNZ21kSzBTWDZ3SWdzQ2hnUU95cVdiZz09?=
X-Microsoft-Antispam-Message-Info: xgzYwxWad9hodJQHpeDj6BHPoV62l/fcG0M9Cf8BmZceZU17y6Xj8HaMbJnzD1In1ll1aDBa91MTSyMN996MXGE9yPA889msBeFiKHPf5Jt71ST3h9D+QG8n4o8hWQrszw0EHcWCkjirikHB3+zD78CODqdUViY+vsltUoo5NJy2FTNDDTK1mM9WlSklQFz2
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:peKcMLZ9gGtGnDxFZnIpkMOE9T2LDj/Mw0aqbV+bCzoiAXp0VhnkuujBsC02z6dqXk5bsYB4MZqVqVc6kPEuW1YP3W+OoNrQ5va3gXWUmPHSOGmz04B4WeRjJe0zP4GZNr8alXtZ2MJao3INk34q06KPEiC4NH1aNIB540nckt8TD4IJSgr80vCnUIEr3L/PmGZr4PWU6I4FrdxhTmQomg4Snxcee8zKRfTsHgndIC/Ds1vdkAWYncvT62IUsxG7ROpzEqh9taGF4JMFyE1AMs9UkkrErbVNfqsLI9arojiYUd4EOhvyGqXhdaxell1ROp8Xr4D6PFDHuEetALIKtUrGJDu7m2figPuyRdNrT6A5YBwXZ8poADxrdtYK6d7446TjKiyVS9GlWokpZZmpVG3fS/Ys8G3QYUFhe6AdSoxOF5TLm0gkyuxxvuyM1p+91FydXoJI+wmS4edkKAJUKA==;5:x6q1U9xFYMNMxgkaNNhsCyefgzQ+zOciCAsqUM5CkfvXB3y/Ok2kGU527zer40xDz7XWEd8+b05Gk2Yy+Z6NiUNA+28OdIHe2610esLQxcbnXA29VxsO8DFzDl47FpvfpSwXz9A/nYhUfLGZ/BesYZ6ou8k/8xNGDPfmiWtvwXA=;24:m4ZP+YzWt2CDzOF+nBcdvci2Hp+CfzmPAl2Cc37ymwD7ocfx+RIPrv7elsuCj+uelcY6Ik/ocka+zy0x8NrMF71A65GWRTlZ/s7M6pcfMdw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:1LsVf2JZrOTqoE0EIHKDRAm1Kjyeb1lS3smlvcJDYE+AIuKbqbwkWbrLRGZVamb1JKmUvJQ3evs5hPVgtWibEM3gxwswySNkacjfZkzE/dS1ddtQD8HqU0RkOwGaGmyz8HjZryZbBnOyDqHM2W26uQTmb0y3ph9rsL9DlGETlQNNT5B4xBTLU+8FHCWqm6lPbrThVEalvHvrfcgWQWSd2PBJe7S3lmGk6wwuhuO2qkEZeK3fSJvj6SFSxTei8zvo;20:IKuHYZfuPojutKYZNYkqfHzJwPsxemiaA4w8bpEvLP9QQZ7IDdUGD9eIwYdsTXt6Y2eDAFTR9cgwITF6KID/SHrNZSqnCebk5HOSYh1xOhBqoj4iORsWJXqDdn8+GcsiTLYCKv3LrW4vWexXd9aGrOhnAqvm02h9tEQEr/6ENMY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:46:44.6708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf167ec0-a41f-482a-df9a-08d5d5006766
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
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
index a66d13b16046..79a22404464d 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -507,9 +507,10 @@ int memcg_update_all_list_lrus(int new_size)
 	goto out;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
+static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
@@ -538,7 +539,7 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
+		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
 }
 
 void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)

