Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89E4C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE6A21884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z9jr/qGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE6A21884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390040AbeHGRxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:53:12 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com ([40.107.4.92]:32448
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388677AbeHGRxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7jHJUl1lc3BUVao1mtGPcK2ZJN1Fh8IXYergT6SrkQ=;
 b=Z9jr/qGXKvbVQDICc/oUuACt/klkRQy9bZImGLH+C/8BGn1dOW3heNsWVf+TBBg2aYmLeKc0pAWNJbvLXE7B9DbzlNDE3qUu0z5O2JjBmdBFzmHO32n+eexG7MhZWakFzKAMdagmZeqItmtBpp6PoQnelA70N3+uhjn4RRzXusw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB2031.eurprd08.prod.outlook.com (2603:10a6:800:8b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Tue, 7 Aug
 2018 15:38:03 +0000
Subject: [PATCH RFC 03/10] mm: Convert shrinker_rwsem to mutex
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, ktkhai@virtuozzo.com,
        sfr@canb.auug.org.au, vdavydov.dev@gmail.com, mhocko@suse.com,
        chris@chris-wilson.co.uk, penguin-kernel@I-love.SAKURA.ne.jp,
        aryabinin@virtuozzo.com, willy@infradead.org, ying.huang@intel.com,
        shakeelb@google.com, jbacik@fb.com, mingo@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 07 Aug 2018 18:38:00 +0300
Message-ID: <153365628066.19074.11561153370778563231.stgit@localhost.localdomain>
In-Reply-To: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR0701CA0065.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::33) To VI1PR0801MB2031.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f5a6071-f4d4-4df1-2e42-08d5fc7bc599
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2031;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2031;3:wC1Ak5LGoD5+LOhgASazwwFvf4+Winewb//x1LEdGx/zYiz6nvqQPCRC0drX16/LGeIU5hYp+igZCc3I7vuvzy2bVP/8Nb3VklJlF+KiM2wivPCM3cqM95+OvG4M9rIiA8asIwEyEqYfLWhpQf3CWgiuxBbo22yLaz0YV6ubzRf0jWJcTOQE/yTktzOf67lWjsypeyUyAbYXo7BiZM3lLPyXIiXPVXoTYK6oMwFPbDTAIk5255eA90IorkXwLaOy;25:QaAVIUD58rzXlmjEfmkP3kycIrpAwlapDyiSsYrDv1MHobrI+RpGlTH7FrqdUN9uZcKbDQx+ryl0krnkFIxC+FZc3xxOExxRTDqf8mhPYKyMbLgXJU/wYVi3ZICUWi57pE4BoIBBzw+u+WEo+6wtS/MCCFlofbZ5I3OuMKbhf3EBEq3pDcOCG7/yR+c16EyDnLIV3L191ViDi0BIWnth4z7hNlGewS/fp5ZEDrByFSnADxULG3KSZUiNlXLE18ZRrbv6VPfvvUzdiI3+Yq0QviSDOzCvFTB93B9xg+ZsxM7svF9YRmN4kN6MYTiJIXobCtuPvMoVyShzUwm/QA9lQA==;31:uA1slugcr8YqTDXexE2Ljb7D/6G8y9Emv8cxPFzOSx+pQKSbHoMUkiMO3CTmx1aRylo6SZm4/2VFCYdC8q1ISWi0eRGp0TPI5APNSSpzGE562nIjYIhydRf3q/IyL/AzhVX+qdpRLlNIvGfEeLbEEax2NrYOXsGNflkZbYkuF4AAsnJCIgPkbFRDBh8RA1fWuNHeEYh7jKV+dkO9MCMjnxbcI1lpqDcTWdcCtZWLKTg=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2031:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2031;20:i3PT1myEcXjNUnGNEX4e2EHbHKdbJt2F3ILSjK2RHw6ur1SjDrjIPiYiK3jyE1culVapkXxENf8iKePNteKzpLyhUTjOkJdzH7vs7W9ail+g3eEtYktCmcvHgnjtcpBGEKa5Ha1dpVjZ4swL6ijhHax49mscK3c5EjLNpyt791VurCxpxX3wuE2hh7ODRobxtb/p9hLUKK+lPHbHFoj41tafCeSSG4HnABm0kGaEUHewktUf7WbHQ+k5WXrzgcA7UlJoucpVittmR7HmywO8rZUmDtOajlZVV3KChBtyqFkaHBsVwU1TNjzCkik/JhIaqtuY2WAXbMiwASn3+o1VZFqM8KRY5JQfeTG2Gb4QJIt61HXIt9IQjj78eXyc1HAIahntfUk+YLDS467LUQezltUw4XEC8kzeP2tRE08WQsxRBNPHCiQaFbQttT0qcG9fhHhKdbzagu3hHhvyLkNFgTixAYLwdRl58jMzLsw4uk5Fd6hyko522X+BV5cDZxjd;4:gT20+UFzBxMZ2jmy15wsyR2TOPPztonLA0kFdcnTzT8opka9J4xpoK+yc7hmjB4Xk76etdzRSMvyfUU1goF5uBj67e3YLMC21a7srorrR1p++wrqewig8pUefp1HLcRRIygnPYpctLAG041JdWECA/1sl4Y7ALdm6FL4yGoaCkeVn14lDuWhWZWXh+fsf6UbDUyjeJVO2/xSESRHfU6wkxPmirzNGGGA/mEb/l1xmqV7HAIzLyhrCcpLXc12uJFYfgCwrYrxXeTDLqAZyYvT1Q==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2031612A58FC3C5825D7BC2FCD270@VI1PR0801MB2031.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2031;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2031;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(66066001)(14444005)(5660300001)(7416002)(8676002)(186003)(7406005)(16526019)(446003)(55016002)(26005)(81166006)(81156014)(8936002)(305945005)(39060400002)(86362001)(68736007)(9686003)(7736002)(53936002)(217873002)(25786009)(230700001)(476003)(316002)(956004)(486006)(76176011)(61506002)(6116002)(3846002)(97736004)(33896004)(478600001)(2906002)(6506007)(106356001)(50466002)(11346002)(23676004)(47776003)(103116003)(58126008)(2486003)(7696005)(52116002)(386003)(105586002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2031;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMzE7MjM6aGw2djF1T2NNeGJsRXExbXBOKzNUUFll?=
 =?utf-8?B?TVVjdTdGODRvRkxiT3FUWnQ1UWRmT3h2RldxZHVGNFZPTlgvcktDVWNrYVhj?=
 =?utf-8?B?LzhSbDViV01TbWlyU0x5VXNyblIza2dtMkFXc29lYlN0ZlNiTC8yMXRXWG9w?=
 =?utf-8?B?TGVnUWQxU0lFUXIwVWRXQmh5Z05aMUhNWm8yclZXeEZjUUs1bEdCQi9ySmp4?=
 =?utf-8?B?MjhJWFAwaE02MlNKN0t1NkVFTTAxZVdjMGJheGxMNHFhWFlCZjJoZEdXSW43?=
 =?utf-8?B?cndMWGlyUkUwWGRRY09TVjJ2YmZtZ0dLVGZTM1ZkdXJua3BVck9INUMwLy9o?=
 =?utf-8?B?cFA0aFdSRTZCY3ZZVkRUd2xIR01BRHoyYjVzN2xPS0NCc0s2aGh6MXFQeGp3?=
 =?utf-8?B?NmQrNjRwOHJWekMwanMrTEhKZUhvNS9xeTRzOWd3NWJYc2RNNWZwbUNIR2Ey?=
 =?utf-8?B?bG5wU0Yra3NFdTA4SlUycDFtNFQwdnk5T25waFJuTlVyd3dnNnZSMUFVSWlw?=
 =?utf-8?B?VTJmR3hOci9OSC9RODdJbUNNSmdHZDBWZ1BwQ0ZtZFVkTW9tUDc0a25OSTRH?=
 =?utf-8?B?YmZNRlg2Y2RXMEdnMnkxa3BQUW9kcEpsQyticFdodXFYbjVmYjFTUllaMDYv?=
 =?utf-8?B?d2l5Z2JQbGlRZUpJSjlmNjBtWndoOXd6b2FyTnlyeUR5dldLWFhhVFZLY09r?=
 =?utf-8?B?QnkrSWw1Nm9Za29CYzhVUTVsb21xWDhSOG5uOGJjMElrSzlaODBqUXhUSVRy?=
 =?utf-8?B?Z2ptcEFaM2FMZEJ3N2tmUlVwYmlLRkQrV1BPWXdyY3h0eDdxbXBXQU9NR21B?=
 =?utf-8?B?VUc4ZFh1b0NQNTdObDM0TnRvZVdPL1JDREhYTk4wVDh4T1dhaHhnUG9tNk5K?=
 =?utf-8?B?blRJUEUxOUtPU21aK2YxMEFUaVNCN3F0dnFVUmYwL01DNG4zTDFSMzhaUUVp?=
 =?utf-8?B?c2xHSlRrNDdTYmpHYXF4V1VjSFlURE42N0VsSEk3TXQyWkRmTG5Ha0g2NkZS?=
 =?utf-8?B?dGg4QlU2MlhZTmtRUGxtcmJ2ejU3Z0VZNkRtVzJKZXIydCtIRGNCRllPZGRw?=
 =?utf-8?B?bGViS2V6WWprcTVOdWE3OTF0bmFtcHlQd0dDdXcyd0I0ZnFCQmR5aUJlS1k3?=
 =?utf-8?B?ZHh5S05YVjJhMHNzZlFEUDEzWVgyK0tDMnNYaWhPK3J6ZCtHbkNBRlAwUHQz?=
 =?utf-8?B?WGNlQ1luYVlyaHdFSWpPVEhpYkM0Q05KUW14LzNxditoeHZaNktMaFFIdHVQ?=
 =?utf-8?B?ZDl3cEd3UEMvbTNvS1BTVnRwSFlXQXFRTWFWOCtOMGZVbTJHVWd5dGRYUVZa?=
 =?utf-8?B?RjBFakhvOHMwcnZkd3VjYkJ1akZiMVB0UEJQSFBzZWc0enhlQkhieWtuQVZP?=
 =?utf-8?B?bG4zbnZtODRaS1VicFdqN2ZvdVJtbHJrdENDTlg0YUJSYmxoQTJQNFBtOE9i?=
 =?utf-8?B?Rml1OWNxZDEybVhQVzFHb2xxSkJkMFVObHoxZ25tZWI0TGE1VmZqbWplRzdV?=
 =?utf-8?B?Vkp3Uk1oTVdJRTdRckZMdDlTMGszZnBwL1g5dThJQWJGaSsyeVdWbmd6L1o1?=
 =?utf-8?B?VllpcHJoc08vdldOQkJzZTV4TUVPQjB6ZU9YRThFZGR3NFJVZHhEelhRL3hR?=
 =?utf-8?B?cHhpSmQzRUpDdVd6c1pDTG15dWtydStDQVoxRCs3TWtMbXlsNUwwQURWYmhG?=
 =?utf-8?B?ZDdIdlpLVThKYTNMZjJGK09sZGVNSFMwd3hkVlVsVGZQSUY5djdxajVhZ3pi?=
 =?utf-8?Q?rFtePC2ywls8BtFvTQL9ZYWfmY0emzkgk5lqiIU=3D?=
X-Microsoft-Antispam-Message-Info: VdL7pW/i44Zi4b4g3cEDfoc43lzJGWBxTkkTRhYLst0zZCWnfmLEJpJkrvTjUnBoqd/ND+4Hp9WAyCNjANkh2NO2COUdHVojrz/aTxQKTDnJUnrxJCoDGG4/B4Nj/I/GSAzy2IAjnE0uc6fBjls6FecXQgvfqD9JAR7HX6v7TTpyLZ9syHONRsgOV6HmgGr04nulXjAsfZX/p0jZbl6FD9MK0nANrNzYArL/C5KnlG6jtMfWyZr/M/DVjIjHIzuo4vtHKXi/Bb6oIDlHFuc5hoWraBuX0GjZeGQutnZvCSMpCm6bYDRxvgiVbwYzzF0F8agBa7Mts4KIAuUk6FSfGQBWTgLM4ua38/ERsTUys4I=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2031;6:WbN6bz2mM0vOC5oNlYj69ucOeJEOQbZ0R8VdtKC/zB4f82NkDyzIOJhOe3FyhD1OuLVXzYcIkCEqR7RRuAzyeTkP6noKyJ5VYxUnbuZ7C/GAN+HvrFQnilUIGwI/qmM5FPyYGfX9lLLFhDMyg5C6lGEAYMfhAr3RzWia4UXMpPsJjgcoRN+NEbfpmJ5bFWgiHIjxVucrm9AxPmx8UFo2ti24MNpg5sZL0M6zXYQdiuwJeQElQlt4N9EaoqVZz2RwCd1kOKdsOKSGfcwI/V2AkIa3dvd4jxoHf0n5MJeLu2dRgSyVdWJKphG2EbOYaaGwECYbUau0tFFpAfJuFqz+vepJHAKulfNjhgo7ua0A3lGmZzpb/2yvCIA6XSN70Oq2WOsLkas0kAQdRkCSkiUcIL3fYRmqf23entw9vQ3vsD9wTm4iUtBWvYl1gkn1WpxtZurxJZFAj+vLGJwrdtMOEQ==;5:KOlWc8TcLOCzvhYIMM4Im00DedHyBejzS2marBh2iNQhkBRgOiPodrU91oTfrOLesqaPnTSCnEbLFSEeTJOIisbO0R0E0OOaM2k1KrRiS48YouUA/mbwhPaNz6StWk8fDB94+l4MCFElh8o0qSC4h8vWJSZ9sgDXIKHEaEgBHMY=;7:mIG7LgZnHCM0AXKA0b5+7tLHYVQIWMxgzTJiP/kJY1XsyT0jmbS8LUmjpcOVv1AufOp9wL/ke7aCOlvY84QRp2aKk/8OiJKMspbkWgNyrQke1YhUwhnXYpFwi2Y7eLdoSxaKW7FcVZpao4A19zOguUstt6tW1Eigt6bdtDhQMXbNLqUp9WnGVd7yBSyxFCI0du0JzJ73eOZdDXy54a0zw/1asxcTQvj3Z8pasasKD2q0R4xwgBBu8VNtdnTdXmsn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2031;20:34l/63cvVAts2itXDdUTOURI6qSLU8yAuguthW1mWhr+Z7wD1mAcBHfqcjgXgGEOxdyfO/rCSe38a3h+N5FjW5GxyBA73jUd2GodQYgQ1AcMbiJyf64X3WDvyT0NFzUdPgKCYGb8DnADNkLBO0ufZWkbKVVN2cA5VF7dICWDWXw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 15:38:03.6852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5a6071-f4d4-4df1-2e42-08d5fc7bc599
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no readers, so rwsem is not need anymore.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9dda903a1406..2dc274a385b9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -167,7 +167,7 @@ int vm_swappiness = 60;
 unsigned long vm_total_pages;
 
 static LIST_HEAD(shrinker_list);
-static DECLARE_RWSEM(shrinker_rwsem);
+static DEFINE_MUTEX(shrinker_mutex);
 DEFINE_STATIC_SRCU(srcu);
 
 #ifdef CONFIG_MEMCG_KMEM
@@ -192,7 +192,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -208,7 +208,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	shrinker->id = id;
 	ret = 0;
 unlock:
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 	return ret;
 }
 
@@ -218,9 +218,9 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 
 	BUG_ON(id < 0);
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	idr_remove(&shrinker_idr, id);
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 }
 #else /* CONFIG_MEMCG_KMEM */
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
@@ -405,10 +405,10 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	idr_replace(&shrinker_idr, shrinker, shrinker->id);
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 }
 
 int register_shrinker(struct shrinker *shrinker)
@@ -431,9 +431,9 @@ void unregister_shrinker(struct shrinker *shrinker)
 		return;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	list_del_rcu(&shrinker->list);
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 
 	synchronize_srcu(&srcu);
 

