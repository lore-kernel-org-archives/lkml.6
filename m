Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jJZOGfm2GluaNwAAmS7hNA
	; Fri, 08 Jun 2018 17:07:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 144F0605A2; Fri,  8 Jun 2018 17:07:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="W8bToKh+";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kUL9mn0g"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5E023601C3;
	Fri,  8 Jun 2018 17:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E023601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeFHRG7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:06:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56732 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751280AbeFHRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:06:57 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58H1WIW015393;
        Fri, 8 Jun 2018 10:06:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=R1faH9BoWhcUxibj++6g/peSwVXCYKbUySXmB/EQxFI=;
 b=W8bToKh+I7enVj9jqD7cCX309UyJ4CEPWDUpCFOHfarGVZrUIn8fHtGEA985fcdbF1cA
 iliRlsYYZKzgBDe6FvohGC3mJ5/kr981iRYD4z1vFGk8W/ZYREuK3lViFzFHQ8ErFKbx
 f30+cJA19nx/PwLRpNVqQ6Y4LEbB7kR6tpg=
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jfukegcqy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 08 Jun 2018 10:06:43 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 8 Jun 2018 13:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1faH9BoWhcUxibj++6g/peSwVXCYKbUySXmB/EQxFI=;
 b=kUL9mn0gLfNquDNK9Lb4bPLWUn8Y7cAu0PsJKns+0J7TFwgDsOBliHcu5DB57KEXMl8IxbgtIFgUfWhAsGKjbo2LT0UfEhhbac/Pb9Zf6q9DrSUYlNZD82W5IbLEhZHEerQhvTKXitZYO8dVXDNJmMRr93yANBk/q7Pa1HaTS14=
Received: from castle.tfbnw.net (2620:10d:c090:180::1:fef) by
 CO1PR15MB1077.namprd15.prod.outlook.com (2a01:111:e400:7b66::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.13; Fri, 8 Jun
 2018 17:06:36 +0000
From: Roman Gushchin <guro@fb.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
CC: <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH] mm: fix null pointer dereference in mem_cgroup_protected
Date: Fri, 8 Jun 2018 18:06:07 +0100
Message-ID: <20180608170607.29120-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:180::1:fef]
X-ClientProxiedBy: MWHPR10CA0056.namprd10.prod.outlook.com
 (2603:10b6:300:2c::18) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:HD2LMXIFxt6TvhFsVPwbWGfaCxYjAj+AUxxGSKkYhNbCaRAH3fegcFj9OYzcLmkGqk2GKHPAvurDKjonAeNTMWS2cfOu24/ExH543WVPzaVp7qNO+K+lDd2Npl4UKka5mvln8JNMDjwK2BTBYbKktJ0+QAWXFliH0oUfMkEIu2WIHgeO5w1fl7hU5LEE9DgOogboGBvfcD5wpfWW8O0K7oYB8eKwH3uUZcR2tiJvO/jC4o9lu5L8tbQSQhSdQ+Jr;25:z5dg5d2ojedg7qYXCGRnEIp+EXBHM8R/nja+l9L8XWkdGIQtRIQul9ARfdXBeCJX27VpmygXMb2l4ZSKBXd/a+mtX6tVCwPkVKkbdzwRtLV/cpuzEPDWY6YbrgEfG6OFxa1z7LYdSIODbmAUzd5xy6sldg94t3ty359utryakMZ7d4F4jHiXwx+ohYbiTAayrEnZraSXHWRMFw1+JH1LPXsE0I8/sWGrcSt7tCIiqWnuLzJM7XINgCHFqZrwB8eQ3geOjmpx9vRjX04E33+o00y3rfSny4gznAy0qspHgEYFT6RrqHcOJySOYsJgGCoXt0EBT99aFqhgFwbbAQ00Qw==;31:XriWLr0l2JUKx5/KI+CtLNPPzrbdRKM2koDxLRwaeeek1K40J1LJvNroo1NI6VdPBxc2ocvPmYzsfm+RAVdaRdHPX7W6vBoSxY5afxUGn36UxZjNqevrB3+26m3GfkU+bMhN+dfCSxPILfxbpP7f+kGhxnRUAGfK8EGi9htIxVxaGafTK1YL+oYNA0YkfONOvzFGupWaEjf1oFgmksSGLERgIMzzxZb/PmxifPdkRiU=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:xiSSBlXNexJDDnDAHzE6IcySA1ICkliOV1y3UyvzKScqKa58BvnzUMVcAiTEXt9IPdIq8YvlKHfjxzOefJfhRX6eAh8f3sLIHpJllu7peA5PFCOpgwQrbIDXF6YmeVDuhD/gQ7F8bB4LyrstssCaG4iQzDxpTgHajwyrw+lx6yUxNHje3WO53aCJw4YLElc/MzDVh++6jQaZ6O7e6xJO4jaSRfTYLnR2ZoZPefziIT8FVEklJuLZi6v1Hfvf/2KyVHDYS6T5TGML9ppgcI7vYte+EWyV/LQbhuhLSy+D1SlXIukhhsO6GrZyxshrBLFPkGx7nyZiorZ4dsBwqQ5i4jCd/voZN1+BgeWkFzEvYMm+udgLWpVRpyVu4cBSCDX7yfkQX6Z15IgSa6EJwCAXA80RAbOXHlWFJcdvQrG5Ov5/YeBGxx1BFuOBS+y2LTjBA3Ea4at+lTO6PYW5ziZHli3BROw637dBd8b5/psQJ0oHyucsCPV1dlIoMG6tKFwN;4:OX7y+xQjvO8+GvMYml4SAuFwO1EO9FDYocbQ5d5Szi5uiycAXcGrvNdBy2bvMUAyYisDnYVLpLYxjp2ktlRSHLbknZuMZjlP8aI9pFdAZCGjOnSjOMx9/2fij/jOpYC1YrehkjMxZjsPX7Ag/7tLQj4v5vNjohnnuvSzWOUr/y8STk9pWs+m0MDb3u5OCQGY3ZY5UVTWUjuPmZubtQMaSMhiyTNB44KO2SbdE6KYUcnUYE5QN+8LHBp3FmRIJKgo3ButYy0cyugJfkz1vOCLA6v3SHy/CXyxXiV758dRK2mFcK51C9Z4nzuqA7OWS2x8oBhXf2D9zbZtuqp6LHN6xW4yeqgDnIom1OqJ369TEHj/CmIGLmpPSynTVol5X0hJ
X-Microsoft-Antispam-PRVS: <CO1PR15MB10771238EE11DD8C3F703DC4BE7B0@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(39380400002)(39860400002)(189003)(199004)(6512007)(110136005)(36756003)(54906003)(2906002)(316002)(47776003)(6486002)(2616005)(16586007)(69596002)(50226002)(476003)(6116002)(5660300001)(1076002)(6666003)(8676002)(8936002)(7736002)(105586002)(106356001)(25786009)(53416004)(81156014)(81166006)(68736007)(386003)(6506007)(305945005)(51416003)(52396003)(52116002)(53936002)(16526019)(186003)(478600001)(1857600001)(97736004)(50466002)(86362001)(46003)(486006)(48376002)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.tfbnw.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:ukkVX68Ej61/tI7MFi5EUSmz2t1HlZchTKD5KlNuE?=
 =?us-ascii?Q?I1wEiBErpAKibK3R50TxhwIFV8Emvqjuks/+spqvjsM1uN37Q2NGt+y/pF93?=
 =?us-ascii?Q?t8tTtVdVl7OnYYxgHN/cqhK8hJjqTaY4aGZW1IZ7T8EuKfZKPc3JzV9U+b58?=
 =?us-ascii?Q?K3qtOijA2yhyMV6Q4Z3diDw8XpA6tvRMA2l7GF/j6tWT8w13GtTziSJxM0WF?=
 =?us-ascii?Q?gwWyRNBs3GdBxZFAxKtj6HLJnVfMAhsN5aaJGm+6QmQjZxmSex66wqhPlP/B?=
 =?us-ascii?Q?yV+oGU0j8jrJLU7E56Gya3leXBHsSgL+vapLzyZUdCFhi7mXT155DqdvzMhY?=
 =?us-ascii?Q?oFYHsIHRB+Q+X/QZfSuuOBhT4Tdu4m0doj5oRO/IBHBNz1wjiskLzhvtdLND?=
 =?us-ascii?Q?XVxXlHYFYmHkGZEBXJ0olPw6usTecdcQSD8+4A3tzW9PruMMxcYgL1oQtGT5?=
 =?us-ascii?Q?lfm3aDLfblP8zCYuH3X9XF5IsqO0uSg4WJDIpbZgxUdQmtHSEIYcuIKIGRhC?=
 =?us-ascii?Q?S3+HnHtbEqdk+bX52q3hHry+hKuQwVNCuVbNEC4sMt4vXjXFwtKx20luqoXj?=
 =?us-ascii?Q?M2pgI8lse2Rdmz8WpnqB4vZZAkY1Z1tLySGjnBZdn9SDEexEtGhftd/pVjjD?=
 =?us-ascii?Q?gc7wf8dmGztdu3vd52txZKnw1IZUWDzRHaUN3PgTO2O89G1Y0c1indPaTqHI?=
 =?us-ascii?Q?uR6Zrwwxjzy87rPnRxeUzXIL5sfMsNm6oYqacFQ49PvlF9J7RNOq1M81Eakg?=
 =?us-ascii?Q?gYuEGwgtYNEuRRApkWg0q3jSrewXfkSKZ6qCQgQmv1Xf7fA7Vryr7pi+yufB?=
 =?us-ascii?Q?Kz47Yq0iwh0gKJ3g4BzNha6o8YLsjq1zlqNsF7TxkCNJvZ4WtmYGqJ29A/z2?=
 =?us-ascii?Q?61xsA0B1AScgu9Z2wwpduC6WK/kX9b85hg717I7BEEcQt7lAEY0qZk1NXthc?=
 =?us-ascii?Q?Hqp1RhOjnaNFp5qf/rQ3Dr5EmunZnWaBznn6a4jTOBUH4Y+CeCmIVX1bbohq?=
 =?us-ascii?Q?vNeXgeOUzBcufHWYE0N0q1QuhF6ZmECzq9fc9QeaWP3z+4FYzX+Ci137Aa3L?=
 =?us-ascii?Q?JDXtST/nDLaz0D5a4ZvvzKf9YJIqR0YPwYZiKab4N0wqPiliTQa55d6Swp/R?=
 =?us-ascii?Q?7niQbdlyHvYZYws6bB3GWKpSSpTl09kB60qDBSVr94fkXMiBEyFMlQBcify8?=
 =?us-ascii?Q?kcd8HO4hgfQ0uhd7PlXNDhKsKA4XjP5EfkiMND6Svtle0+Tma+u0peRpg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: +kz6i84u/YH8RAXwy0nXbr8hGr2cRWwBRwUj2mQW8v5eh63NsLWSNydbgW0drHi2SmavRBHi8429TIOaz94e3bvatW+bLJls/qCsVMQyzSNTaWHPGl44PNWd7uh0JsJ9bMN34BLwaBAJE4s490NC7zUEgAhgWRpTV1wSOllMLgEBBmhbFkwbLZhEOFOQRkED
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:NyWS7f6hrhBqrbFEqE4EfIICJ+ky73hi7jlCZDABJdDFDUHKzX88xAMpVLDxax0QyVcHB1B/qETNGZQ27lCBM9UXTsEqNPPRAH3kl7nPXacdrICz9q6NAQma5Aduu4xq8mLnU2sOi9BfH21UrANpVNswUf+zVMhFIw49IsZl4tfMq+Ykz8zy+vWdNSkLr5XDyaO/Kj1V2KKTsik8gAdXhr9ETffKh/BSHPM+t675a8E5WssKRl3tCfwSDpCeXf8lvSPedPV3dSIbmlVFbTtG9L4/Ds2WQa0+6CBPjLJUcegpFVh2gpdhTW6rEElkvh1gRXKjod5B648qLfg1G7XXcNTXegzvB0TqPp+7Ki+XZxs71TKAIfvWc6cmCegKEZt5HH9KWLcNxo3RC1YJg9o5W8ouXC7guP2tYacShS8+lCwYMRtQqddnG/YH9bhGDqGQ6AKwZGh0DKelkNbllPm2eg==;5:mAmWXJNYEWM6fKSpNP91SoVpqpwRJvcLhLCKr3GCWYq95Z1HiADcPXyjf3B6kXbxRstjDADubDCwffZqwxvw7JBjHBCLOcWyCAw9Zq6sPbuHpppEGZVRwR+X6uOVSKvHmZfqzFfmw2Y6/+qCIWlTdbEGo3udIy6AFR3hCzF76tU=;24:D5IKqEk/U+50a2jn3dZLr0n/HcP/qmAv+AavN7I/tTWVAd1nXVwQ7dQUIe5wBC7KDrAMobs/Bq7ifKtD2LHwxaYYkGMrWU1ZFeyJ71euuKw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:9nM9egLKtUWu8eMU5NBidV2cHFx41hoRapN10e0xWHQs2jSQ+ouBabJ7OxrWZrzT1hCqLKAEvnECIgouldpszDy+SUzqvQ6dYPcTMVj978YzFwVygGPsMcwjxHplyf7tcTPbE4l030BtfRbWA+AhSE6dRM7e3m1iBm+Vc7BsrcT50Wxv5Wd7qy+LxaoVk78XqDPUaShTETt9Tgs5SjhdH1mDeVIxK26XHLRxiMquwkOWpNsAX2IOWNe63q6m5xOF;20:rW8TJ8xT9vPG/ymD9v8BUT1oTRdA4kfhOpM7FcVEV0Bi9bgrkTuIMw180DR9ZWDvI3/K7Tv1DZMZV0WxL9QmqPbpiIwkjUt/iFg9vzHOp93Y/esTdbTFYT1SafSSOnE/NvFIVcp3Dm9MPPyEARzuQ27ljYHA1tAxugdC91G/uws=
X-MS-Office365-Filtering-Correlation-Id: 0da69a55-23af-4ea7-71aa-08d5cd6231b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 17:06:36.1845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da69a55-23af-4ea7-71aa-08d5cd6231b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shakeel reported a crash in mem_cgroup_protected(), which
can be triggered by memcg reclaim if the legacy cgroup v1
use_hierarchy=0 mode is used:

[  226.060572] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000120
[  226.068310] PGD 8000001ff55da067 P4D 8000001ff55da067 PUD 1fdc7df067 PMD 0
[  226.075191] Oops: 0000 [#4] SMP PTI
[  226.078637] CPU: 0 PID: 15581 Comm: bash Tainted: G      D
 4.17.0-smp-clean #5
[  226.086635] Hardware name: ...
[  226.094546] RIP: 0010:mem_cgroup_protected+0x54/0x130
[  226.099533] Code: 4c 8b 8e 00 01 00 00 4c 8b 86 08 01 00 00 48 8d
8a 08 ff ff ff 48 85 d2 ba 00 00 00 00 48 0f 44 ca 48 39 c8 0f 84 cf
00 00 00 <48> 8b 81 20 01 00 00 4d 89 ca 4c 39 c8 4c 0f 46 d0 4d 85 d2
74 05
[  226.118194] RSP: 0000:ffffabe64dfafa58 EFLAGS: 00010286
[  226.123358] RAX: ffff9fb6ff03d000 RBX: ffff9fb6f5b1b000 RCX: 0000000000000000
[  226.130406] RDX: 0000000000000000 RSI: ffff9fb6f5b1b000 RDI: ffff9fb6f5b1b000
[  226.137454] RBP: ffffabe64dfafb08 R08: 0000000000000000 R09: 0000000000000000
[  226.144503] R10: 0000000000000000 R11: 000000000000c800 R12: ffffabe64dfafb88
[  226.151551] R13: ffff9fb6f5b1b000 R14: ffffabe64dfafb88 R15: ffff9fb77fffe000
[  226.158602] FS:  00007fed1f8ac700(0000) GS:ffff9fb6ff400000(0000)
knlGS:0000000000000000
[  226.166594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  226.172270] CR2: 0000000000000120 CR3: 0000001fdcf86003 CR4: 00000000001606f0
[  226.179317] Call Trace:
[  226.181732]  ? shrink_node+0x194/0x510
[  226.185435]  do_try_to_free_pages+0xfd/0x390
[  226.189653]  try_to_free_mem_cgroup_pages+0x123/0x210
[  226.194643]  try_charge+0x19e/0x700
[  226.198088]  mem_cgroup_try_charge+0x10b/0x1a0
[  226.202478]  wp_page_copy+0x134/0x5b0
[  226.206094]  do_wp_page+0x90/0x460
[  226.209453]  __handle_mm_fault+0x8e3/0xf30
[  226.213498]  handle_mm_fault+0xfe/0x220
[  226.217285]  __do_page_fault+0x262/0x500
[  226.221158]  do_page_fault+0x28/0xd0
[  226.224689]  ? page_fault+0x8/0x30
[  226.228048]  page_fault+0x1e/0x30
[  226.231323] RIP: 0033:0x485b72

The problem happens because parent_mem_cgroup() returns a NULL
pointer, which is dereferenced later without a check.

As cgroup v1 has no memory guarantee support, let's make
mem_cgroup_protected() immediately return MEMCG_PROT_NONE,
if the given cgroup has no parent (non-hierarchical mode is used).

Reported-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6c9fb4e47be3..6205ba512928 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5750,6 +5750,9 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	elow = memcg->memory.low;
 
 	parent = parent_mem_cgroup(memcg);
+	if (!parent)
+		return MEMCG_PROT_NONE;
+
 	if (parent == root_mem_cgroup)
 		goto exit;
 
-- 
2.14.3
