Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD611C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF872154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="On0ZOGG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF872154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeHTQoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:44:38 -0400
Received: from mail-eopbgr80135.outbound.protection.outlook.com ([40.107.8.135]:6075
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbeHTQoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11LOuUQ4r2QetzYgyGaD2Jb/eNdp/r7LrdHhOm6K2P4=;
 b=On0ZOGG9AhW4dIZsDr7ytjEk2A9nDDggHjiDn/vSK3TgucR/bQX1v4AxlopoGyjYzAkoTvEaItqioVMbB7G6Xwp0WQ1u+RxGHk+j+7INWXXhsu5WTT2zHG90g0LnGRPJhJahWmu+V/0MahGXqqbLgc79KpfUoo0bxI6HIAhSbQs=
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2025.eurprd08.prod.outlook.com (2603:10a6:3:50::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Mon, 20 Aug 2018 13:28:49 +0000
Subject: [PATCH] mm: Check shrinker is memcg-aware in
 register_shrinker_prepared()
To:     syzbot <syzbot+d5f648a1bfe15678786b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, aryabinin@virtuozzo.com,
        hannes@cmpxchg.org, jbacik@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, mhocko@suse.com,
        penguin-kernel@I-love.SAKURA.ne.jp, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, ying.huang@intel.com
References: <0000000000003427e80573bcde5c@google.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <8ff8a793-8211-713a-4ed9-d6e52390c2fc@virtuozzo.com>
Date:   Mon, 20 Aug 2018 16:28:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0000000000003427e80573bcde5c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: LO2P265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::14) To HE1PR0801MB2025.eurprd08.prod.outlook.com
 (2603:10a6:3:50::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba8a5604-38ef-488c-6680-08d606a0de47
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2025;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;3:50FV/PxVmJs2/AvAPZV4bQjbkDFp2P3vyR3BfZWkUerZo5bMwLT+xdE51kOznvcqzGZwwtaTcISSx9qB4q97HfyONCG20Tws7eHlHZPcEeQrS9DLdYCq+38GWyRv6EiIv+s0tcJK2cKE4Vj0GWToQ0a8Fj3hhOCTqLXFaC7d+GYMZu0gpebbZOJn72trpm361vaZvQ/StOJXwpq2coeKGIwLOlbUatLVL6U8brRMBDTAAkj8Ojww5MRuloU1BiwM;25:IJys46UYBaa7uJLSsg55QL0AVEEaE5D9jdSiX4zZTyPwFoz0PjiSc0yGbxY88jvgB0sMcnIkabnaZz/eq3NAhSkvxLkueWuLPxtZhtehm7XDvwl+fDnM+u6IUJV4Ei4Wl661B4W0s39g/OGQhJg29V/uSGJ+gMoI2kWG2M2VO0TVPQpUJFVnff7H51d74SFiyS80MMQnwKsdTLTYmjuweGIRAYoEXegxX0oMjaBgbgSNgVcsMrTDjwG+daC67+XyhsOXWqcfxmNjKTaS4jUwGbVPhX2aC+/fdDJaKY+KiPoPifYzZO/ck/sa3wW+CtBIf6UmYN32AG8SEqlm2nD6Cw==;31:Y3H9M3FDWUmWtbtx9AcClBwe5sGMaPZoIYVu7tXU4lQ5VxQnNyQBEt8/MihpBzyUa3N3yWPuXa2XgQiQL0f6bOiX51iRBN+LJXcu6GF9gTPu7v5L9ydibGYBiJuYWjt1sUsT6MtaLrrwALKM/xnZGobTWRrxygApn9hYBaJTJCZtWdmd/V6kNtufNeUJ/EHy0lRRc0fYWCLdAk3jWad0q5/8aGPFYuJ2xlpi5ofg5Lo=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2025:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;20:YTqQ8FKKjauS+1HVUfLIWCbpsNDoniP2mz+3vFxBNR3v0u/voyUCDj6f1ffmh66AJWtZ+LdC+GDKQPeS5WApsssMFOT4qHAtU7R0bCVc7LT87dnjd3hEBA0se92n/kRhkXuDIDaUYJhVBQPSLeOkJxMDi52NUn2GBrJnkphP3XUTS4YWgS3UYGaaq5lZcmMYbWD43dMSvve9EQA7gtTd1QVBvpn9+eNnrqIUqBR8TS2G+YErqvqqFHgxu5YNOaWVYNHZXbLer/OgL+0rBBQ14ln9Ucu7NrFyBjAshdaeG9jFCQs5ty+b3NIbfBKbx7e4RJcjboYLbD3OARdfQhhehlbnLOTJe3OQ1G+DV+Gw2BUSl33JJ5AoCdFEOL9ZpDIScqYmqn+a+L8P26SNOZj1aHY7tYKjRT2ANao62cfsQurOhXR5yRzugAjopGh4oSjyuIfUmTU+R0gbXLnj1OFes3Qc2bgb1HXetf1zlxbhabWr2iP1W9eq58wQsnFfenT3;4:TmS5gtEPN1RkUbLguLPZuclMIkYAY1mxIaIKOoJTHp1n2BoS/WIvxESivPZRJHSAOjL8376vf0tV2ipDBiSToty8ibbVNPzYwcU91Kf88VIQw0XdSvknNFhwza47P4oN42/TP/aMMX+tTjg7lP4bKvK97mO45pt6Fpt3v2GwSNcocpb79gtERO/y6usKXokqm8hrParNjG5ZKrhJY8OszbHkuhhoU0nMEB25Okf5rl/sUf8kDd25jlxBZ9Jf8nz5uANZTN8Wx8uF4L+UaJH6fg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20254A151555B861C1B986C3CD320@HE1PR0801MB2025.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR0801MB2025;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2025;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(39840400004)(396003)(346002)(376002)(366004)(199004)(189003)(97736004)(386003)(16576012)(1857600001)(6116002)(64126003)(3846002)(68736007)(65806001)(81166006)(50466002)(53936002)(47776003)(8936002)(5660300001)(81156014)(316002)(230700001)(6666003)(6486002)(58126008)(26005)(956004)(2616005)(476003)(486006)(31696002)(2486003)(478600001)(105586002)(11346002)(6346003)(446003)(23676004)(106356001)(2906002)(65826007)(86362001)(77096007)(31686004)(7416002)(76176011)(52116002)(7736002)(305945005)(66066001)(52146003)(8676002)(36756003)(16526019)(25786009)(65956001)(186003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2025;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjU7MjM6QXRTbzJuN2k4eFl3NWQ3RWxGOUNoVVUv?=
 =?utf-8?B?aVpHYVlWY0MxbEQ5UjRqZlNCM2FGMlpKeXBHdkVLdU1TZSs5TTlaT3ZTSkIv?=
 =?utf-8?B?M2VPd0F6UDVVRkFJRmo3TW1vNGNNREI4eUdySXduRE4xSHJHeDNxc0FOZHpx?=
 =?utf-8?B?V2U4d2pOa0FPazZ4UUJpaTZpMUxUK0ZlNUpwVnFhejJBd3duNFJHNkc0MXJm?=
 =?utf-8?B?UHp3elVWMDBtQVB0VVM2bEM5emVrTXF1OTZKcmNUUHVQcDQ0NXI3L3RJMFY5?=
 =?utf-8?B?eHNlVTdtRmJrakh5ZTlzNXZLeC9sek1uRzFxcXRSZisrWENlWDY3MDc3Tmtp?=
 =?utf-8?B?dW0vWkJtUXpLc2k4dUhDQ1NDMC9GRHNWWjhqNDBPTFJCbDhuUHhzcFQ4MUFh?=
 =?utf-8?B?TGNHNURhODRsbTNpdVZVVzBvZGZNOFNCQlExWDhFa1U3eEwzM25hZDQ0YnVq?=
 =?utf-8?B?RTdwcWd5YlV1NTV2QzVHZUltbU1wdWt3S0ZDK0h6K1F2dnMxVC9QYWlvbkdO?=
 =?utf-8?B?V25taDlTcytiSVBHclpGUnJGOER1SnpDZ1hEc3NZMVdtWERLc1ZJR0tEZWJH?=
 =?utf-8?B?aVlOT1dFRjlZQ0kzZkpLYjJQV1ptandFL010ZzljYi9xYm9VVWhkamtWTGJm?=
 =?utf-8?B?TE1LaFlkNEtFbVhjTjBrYklTRjlTQXk4RWhDb1ZwTU82YUtLRG1seXFYa0xt?=
 =?utf-8?B?SzVrcVc5STlza1NVT1JaVzF4NDJ6VXFGMXVBaE1oOGE1N3lpSGVIbXd3OGdN?=
 =?utf-8?B?Q3dmb0RKQnhkbEoxeHZHeGdFbnFDcDhJdzNjem50VkRUSzVvdHMyTDlEWHJx?=
 =?utf-8?B?aEdSdkd6d1FCY0JmWHdyYkhEQzJ1T1BXNExxYjVVSlo4blg2SytPeXc3c2Mw?=
 =?utf-8?B?cUpMaDRSTklyM3I4OElCOFhma01DWEZmMzBGMlpxSlFYcVJreEVvMWdBd0dN?=
 =?utf-8?B?aVlERkc2SDREZDNIRU1LQmcvZlVWWHJqQStrOGFZSHBhWjZUUmJGM1Z6TWJN?=
 =?utf-8?B?bG15UVBESnI2U3BGMlBpbnl6b2xheC9jRDZwaFRVRFJTZ0Y3a2N4NU54TDJ0?=
 =?utf-8?B?b0Yxb0J3YjFMNHovK0FhUVJJeVYzbTRtbnN6RUNZZytGTkVaaGM3dnJTRFJO?=
 =?utf-8?B?MXkwTmVzWVNqTllpVlh5VkNtNlpPSWYzNVI0akVkTlZ5Wk1mL2U2aExnTUMy?=
 =?utf-8?B?RTRESG9XT3pvVnNzWTM5Ni9xZEJFK00yVndxeUJBdGNDV0pFRkl3MWY3Y0hx?=
 =?utf-8?B?UFFSYVoxUkF4TkJiK1c3QSs1QitXT0phWDVURlg2WDdWMU9MVlEvUGpHTU8w?=
 =?utf-8?B?OG9BVU50ai9CTEZCM1puaHVXMnE5VXBIWndydWEyL2RISTlZUVQwN2daSWpF?=
 =?utf-8?B?TjJVd3l1VHFIdUtqNC8vcDU5ZkNheDU3QnJXclhFUUlCc01IT0xsa2tFaHJp?=
 =?utf-8?B?bURJVXRnSTFpNnF1Wllma3hiU1lLUHYvZG5ab2F4MlNZUGJ2VTlFUDFkc3cv?=
 =?utf-8?B?a3NaVkw0VEM3Y3BodkVFOUZKQlArVjdKYisyOUQ2N0txallWL1lMQTk2NDVJ?=
 =?utf-8?B?NytOTnFFUUNVbzRMV2VjNjZlMGNZcURRTkx4aGlIRXhHZGcrVjBoQ3RzM1ht?=
 =?utf-8?B?TXhhS0RjeDZXMy9IR0VKS1JQaXp5aGZyRm03empDWTh4a2c5dWlSeUlYd1Nt?=
 =?utf-8?B?Qld0MzR4Rng2MUlLL1Zaa1I1RXpyVWthMmorcWFMRXh0Qi9HVDhTdHNLMWJN?=
 =?utf-8?B?YWsxR1NkWU1LdmJZL0Q1TEVxdE5aaFpEV0RiSkpJMFBLZHVlUzFwdDM2TDlD?=
 =?utf-8?B?dFZoZU9sazVSN0NrZUNWbjhhU09RRGQvNDRoc3VXWU5XNDAzdnNaemZEK1Nh?=
 =?utf-8?Q?5bP7+URJYzMNkwvSFk63ZOXZz2bsCU2XHc?=
X-Microsoft-Antispam-Message-Info: HDrnflXUGrarbU11pa1iNIG8xjNqpnevoePd4aZw4AvZ0vWqB0NROsLb3YJw4uOKBFXrHDpM9k56oeYUh8WWlLhVDibn6++LzarlfYW1nJSQGKujaNb61OQoAKEvUBionNoshzwDtbUILa3UIoo9gHHhmTCy7GUWsEght/I4V4Po/EM9lKiCedRK1ZpOSq6g4nSZpWQF4vbY9isB0lVVdO01SGP2BmKzjbapcOCePONIAabLskMB4OLT9p+xwdX2gQfBCsGpKHqS2imAZdb7KWYFSJhumLd0OOjIP84z5ik+Jk4/vyIOdY9uhVobJ6MKIM+J7LVJblcuXRkvrcMaHjooH7QAlu6TBfCLimJn8G4=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;6:LOwm93EW6cRkG2xbyUlfWSm4uYB9xTJzi+Q/NRlocOgWIATsAWzD9dSJuRND4xnae6eBzLY9TrF/AH17HtZ8kb+2uXsWS5Go8du0Z0ttVevNNi5H2iAI0ZHKeNbMeFMo6NPGH7ehibQjxy6mIk1YH2JhQ4OmlOd1vE/QCrO/al2YjbMYKk3sMICRkZeUAdV+71JMx3VRQq0Voz+DRatiPcBB7i3wVbab6QyaZLxLp6tptif2bT0si/PKlxAa/f5989RFbq5QsCeuIyiewHsA8VI8fejRAvExkHcd+wU4Hi9l3d5otcLSLRtO+lCl/aiRwGJUInKLv+BVvAtzN+nplc/aMzaNY7E5YaSqRgBTgpL3fQoC+J2xXGoUN8Pufh5I9j3E5mWHG3qBPo+zx547tZZLzvkazQylvHfTixNBOLqcCGQb39UtC/Vq6Ea/yKqW6HSjTlmBRGNl4iywRg47MQ==;5:17su99E6xBiuiMNTrOxlokKjTSQhXXPPmNRoulCD54LsbZGOA+CWqoCM/FP+f6eJymCE2bc7p7qETIZZ7E9PEDAGOlwBCAHt/Ug/Tpb1CVPFzAOIVaww1Aw8v2Eq6cQdgRf04OkinqlEObreQ3BtqgSEgWpq88UdtVQTWwuRcVE=;7:FQCdVo0rRvqwY37eiwTnJZ2a4f+kQB1KmvwPs6Aex17bC0EnlC1PziA0IuCw7PAAAh+LuZKe/+R8s5zJHD7NEoUn8eIVtycqGc5vzyIfYFjDJODoDocgaen3fbGzXBnm09kvI0PA/huy/FPhF/UNvN7v0pyNmfFJojMYl9QaINAWu2UAndSvjo+HzckHVAyhp0mVqy7c1QCBVqcg1cx8pp3gOIRBrPoorXM01K4B78vPvmwdEmrE5/g2ydwy0I7I
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;20:nlbzw3QMGEdKE1kmxic6z59TExIFczkjsdlmEt/rpK+mvmPV9XQ+hf/N9geFIROnZJ9twXZvQZet9aKrZbIwWrWVsACFcKjbIO+FmQAvAGAOcUMEXX11dQbEG6IAzepCZliJAtwyE5hi/iQRQI77hQPi8uAUXJnsEbo4bogu66s=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 13:28:49.7634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8a5604-38ef-488c-6680-08d606a0de47
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a sad BUG introduced in patch adding SHRINKER_REGISTERING.
shrinker_idr business is only for memcg-aware shrinkers. Only
such type of shrinkers have id and they must be finaly installed
via idr_replace() in this function. For !memcg-aware shrinkers
we never initialize shrinker->id field.

But there are all types of shrinkers passed to idr_replace(),
and every !memcg-aware shrinker with random ID (most probably,
its id is 0) replaces memcg-aware shrinker pointed by the ID
in IDR.

This patch fixes the problem.
    
Reported-by: syzbot+d5f648a1bfe15678786b@syzkaller.appspotmail.com
Fixes: 7e010df53c80 "mm: use special value SHRINKER_REGISTERING instead of list_empty() check"
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4375b1e9bd56..3c6e2bfee427 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -408,7 +408,8 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
 #ifdef CONFIG_MEMCG_KMEM
-	idr_replace(&shrinker_idr, shrinker, shrinker->id);
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		idr_replace(&shrinker_idr, shrinker, shrinker->id);
 #endif
 	up_write(&shrinker_rwsem);
 }

