Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EF1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B4E20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b5CAfdkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B4E20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389646AbeHAQ3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:29:48 -0400
Received: from mail-eopbgr60119.outbound.protection.outlook.com ([40.107.6.119]:62487
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730791AbeHAQ3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlU9TZY+L6o8jCZhwxdrdoYYrLIsgg9l37Xua3FTvQk=;
 b=b5CAfdkW1MwmEM8EGf0Xhiha4biDyTVCyzslYiE9XbGzDLHpApnKh6sq09aBRp+redRtmK14rTxBrBviJc8PsxJZ6HMAVmugB8PlFRxX47LmHs9czPk3VAzNsNBmmECWFbqQyjGMm0KdkjPbAeU6PkS3DXPccJEIjBffRcVjlFE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2024.eurprd08.prod.outlook.com (2603:10a6:4:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Wed, 1 Aug 2018 14:43:38 +0000
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Commit "new primitive: discard_new_inode()" introduces a problem
Message-ID: <64a0f022-a32d-d4ee-7464-5c5ce0ebd222@virtuozzo.com>
Date:   Wed, 1 Aug 2018 17:43:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR07CA0116.eurprd07.prod.outlook.com
 (2603:10a6:207:7::26) To DB6PR0801MB2024.eurprd08.prod.outlook.com
 (2603:10a6:4:76::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e23403e-af51-4bd0-c5f2-08d5f7bd2b0b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2024;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;3:edFIfr3Ne8FQ6deNyfsp2E/4UsJLy8q6EWbjmE4aIlOLY4CVI6uvVWFChD7AKmYr9ZA81+4hU8wR9LcGDCb6RHpIbSYgulOPUgqHGR3AgbXIG6Ii58Iawawr0ThK8GHdzr7UFe/yiss3pViceF2DDp6ZdNai/v0NqGccNSCrAy7P+b2esqJnB/jzZgQIPb3o7mJraiIJHSKGGC4cx1WtXfCenpFlgIy0iuLxqVPAShT3jIyxgrrWq1fy0iRb465D;25:ejg4HOM153CNz1XN2JwXixmZRGE4bMFxeqpLYifQpoyICG/rGpNoS4SMAwP2o+CsjczVnVk/uoj/XCT9A/9B7NEvXbVIViUTTbZmn0x/pyPqdAebyvbl7eMR+IGiroTCCPSd+H7Ve7C0rmZxxPKcLaAqcKEVtxlbCd5nUGkZaYpCb2RDGJjw4kVrUaJbEYzeoR8GoHsAqK/uP1QbDFSSREcrMuw+AENvcrDaWtjk8CYSVRTpD76uuXzuEFLH/BAHcYwDCkEmr8ArAUnAJme32PvReASAQgHwa8+zgr4wSuOwRGNeCDpWxQlO9PG5cVlcwq6busxf3BbNQ9WkAWx00A==;31:2ugiIP5z5fFewelub81cz62bfs3oBVJVmeqcqCcV1zvbqKg1OJxcuIUwOizLv/BMVXnc/LpwR75NJ4gvbfkeCxVyitc1vDUoGvzNAjMKZY8MKaWoNc5O7b7t17Kgu/jsSBGQWZ9Zp8/rBuKBE4J2qKp9eFpVWomq1Qb5MGcmc6yqiOZkZ9hbev/WFqpwOBFkTf50ir+W0XIW4Fo6jSuPoMZllaGyhQiqtp66i54lbow=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2024:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:3CSN+uKptBDjnnC/Ex3LRNYKdK0pFBXJqRlBTeHCqlOqdn3lj+FKNXwt59twkY6j0mtidKFlJZXC8DYVGHu2rqE7nyo5xayByCmqgbxFRXm6jB6Ty2ML/TBjkDwJR8WLF3ayMBMZ7nVIUkdkle4B6BnhRvW+G3ZKXleKVMApJaVYhKp+ScWBVYwrbhWn/TUluZYdE/qz9RPU0+phmgHKlJPVt/RMdAmow9BUwQByZzShs8ALCLdmZZma7unoG3Fxtkk/l9icqrsF+8PDMCBIiSFHlCu0NrKzRCBDruR4naXh5+tW8/Nj727Yd1lj6ZW2bFCnJ2V7aOyDRmPB9G/J+vRVBmkMPX2zpr6783sCbzQRkq4hIVoDOtu8SdXQa7ay6E6sqP5Gdhgx6uF60gM9CVLikUWZtLvehzouY/rnt3j5BOFxKInRmk0IkjQR1OD74SNMZkohAi9Owxw0LgmIA8VcCYnu/uuhAMWp2kTZiuOC0ir8a87SKCJXsdxNEkQL;4:V/4ybtZRJSRcS9DP0HddZbGhtzWCf6/m7siTObf8egjATUq8POPr2ZDueW/yRwBdHzZ21WsVl3pFbm4p20lQR3CSgOOn0BXoNepRC86YB457IVCLdxO9kYuT/kghX6JK1c1F+Q8eLBh01qvDtaVQjvyeznAaRr3yJoNBlUSPL8RpG70Gn+ISYaDXfUxrE4BvoPdFxk83v94BZl4eu6XGRDdrFt+DmBYq3Quk/1CwNSxcn3ZYhqRmY8l5axHlZYpjnU5BZLqZhvazhsfqzxF9dQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2024C7D74E19DB542880442CCD2D0@DB6PR0801MB2024.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2024;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2024;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(39850400004)(346002)(376002)(396003)(366004)(189003)(199004)(68736007)(2906002)(106356001)(66066001)(8936002)(2501003)(65806001)(47776003)(64126003)(65956001)(6116002)(25786009)(105586002)(305945005)(3846002)(6666003)(31686004)(65826007)(6486002)(31696002)(86362001)(230700001)(7736002)(16576012)(52146003)(81166006)(2486003)(58126008)(2616005)(956004)(476003)(486006)(52116002)(23676004)(36756003)(110136005)(53936002)(8676002)(16526019)(81156014)(5660300001)(97736004)(50466002)(186003)(26005)(77096007)(478600001)(386003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2024;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjQ7MjM6bEcwa1Qrayt1WmdBTDNPeW9kTWxjS0wr?=
 =?utf-8?B?MmpCa1dTQlJiWGtsRFNhVWgraFdjaFR5N0JxSVdzNGJ1QXhGdzREUVEzV2F4?=
 =?utf-8?B?emlZRmxUK2VBSVV2aUdFa1I4ZzlEeHZ6d1NYR3Y1b0kzZU9xd2o4dlZCU2pl?=
 =?utf-8?B?TVFmNmRaMmhDZTZlUnlJYzBhRStqOWEwWHNvWHhYMENyOWxwa2k4SzhBNVR3?=
 =?utf-8?B?emErSlhaRktaTTdhWFpRUVpnV3pmS0x2cHdISDB5MUliZE5aNkdlaHBBajM1?=
 =?utf-8?B?bEc4R2pNYkF0VmxpcVZseG43b2ErVW5zaEZESERkaXM0bEhZK3hUdzAwTElp?=
 =?utf-8?B?REtpREJpeXlmUkJ0V0xCUWFNVWpCQmRqNVRCVG8zMDIwalpyTTdRN1Y2YW96?=
 =?utf-8?B?bG1nUTcxTHlGaW55WFNNcXVrS0pLZ2NHT2dMWllIMEMrNktrejVYTXVQaFAv?=
 =?utf-8?B?RUxIR0xidlFyVGVRbTRuWWs5L3hnZStGUWU0cHc0NTIvUDA2elNON2xRK3FH?=
 =?utf-8?B?TE5XOU1VR2xDdk5VM2dQdU1EL0VRVWFXQ1pGUjJzUXNrZVBKWENhOU9pZm5W?=
 =?utf-8?B?eVpyekw0K1EwV2dkN09BOXVFVG5oNlJUTERpV0lXMWRiMlR1cEZvTXZ5ZXJ0?=
 =?utf-8?B?WHZQZVR6aFNDc1Q4UDc3UDhGbUFVYWFoR1B1Q2J2cERaN3BXejdnM3lRUWJY?=
 =?utf-8?B?QjF0aW5uUm1WSmVhRWdzaXBtVjd2Sm5CbmEwTEZvZUQ5VythT2Fzd1hqUzJN?=
 =?utf-8?B?Zy93YWU2aUZDN2FaV1NQSkE4MnlxZ09OaDdyWDkzeEM4NndUU2loNFJyaXpY?=
 =?utf-8?B?blNuSEhmdStVQkoxSHRqRVFHNi9PV0ZacENRQU5SOXpyM3Y3UVJsM3NjY1FX?=
 =?utf-8?B?eUE5a1FMRmRTWXJWYXAxOXlLajZmRmNkMldjcFd2MUJOcUVjRmo1SzlOWUVN?=
 =?utf-8?B?TEtmclErZGtJSGx6SEh0Mk4xOUthdDJzbFgyQ1NScTdYNm53TklkMkE3ZE5p?=
 =?utf-8?B?bXRKTW13dUg0blB3VmZlZ1hqVkIyWUV1K1BrRytTS1BQanlWWDZEZGRUd0pu?=
 =?utf-8?B?UjdpQWtudXRCR1ZTR1kybUttSXJqdjJWVC9meW1XMzE1OGVwWXdZK21OQ1lr?=
 =?utf-8?B?WGRobVBoY3JOeHltR1V6V2NERzRrdmJGaDhvN1FTMWovMFFXa0h5bVBDTlQ2?=
 =?utf-8?B?UDJxcWg3SWp1OFMxUWJVNmxlV2FFZEZ4b3IzNnB3TVdvejh6blNPRTlDbFBt?=
 =?utf-8?B?ME1LWWFBRUd6OUtONTJHamtMeXpSdUw2R2t4cnN4eTlEY0FmQ2VSRHNuZnpx?=
 =?utf-8?B?QlptTU1vaXBmUG11c3ZTUDNaYkJ6TFVlZytkNFpZajd0SzhtWHhkVFJJMFpx?=
 =?utf-8?B?a2htVzJSVDNTODh1cExTYXI0dFV0bGRzZG5TUWFZWThZc3pORk95NFF2Mjh3?=
 =?utf-8?B?S2w0cnNXTTNINXY4QThuK3duWE1MT0tJd2U3OEpXVDgyVFpUTUVrVFFjQUFu?=
 =?utf-8?B?dUZTUDlIVG1iWi9ua0M1RE9mZDRzNWNONjg3THBqclZSK1RQR3QwS0VRbW5l?=
 =?utf-8?B?YVlUbVdFQUFLUHVSS0s3U1o1THplZUVWQU4rWlhaUEhjTFBEaHdySUhXYlE0?=
 =?utf-8?B?STl6b0pFcG1aQk5GZEFkU0NXVXlFaWo2MWVTQ3k3OEdCa0tsY3h2U1ArbGQz?=
 =?utf-8?B?QmJmTkJoR0pyQnpvdEJrRFY4SlVBRW1VN3NyazlPRnpGWmtpOXR5K1RSSGE0?=
 =?utf-8?B?VHJyNHpRZVVQcXBIT1dkTW93PT0=?=
X-Microsoft-Antispam-Message-Info: QBo2pH1UqGG569wz85hWcsiz5+vs2d0h2CzgJTjZR2a1hFBww5A0PAuQ2cpkEuW0BfDZ7mUBzWrD0FZLJuGOVhOp5m4jOiugG/YxZe356SsEcjTvYsr1pvJFv6m7eD1XqFTOOVtfTgORpiEH/U8ee2XsyjEngoWnpeb+QHZtzA7Y5RyW8uUCw6NxetiFRB0d6aJkB37Prwm1X0zVn1J36szTf0hr1wkb0tDySi8995Sjyqe+hIlqh0PByIaXy/gksdaI0pGqP3rPcAEG14i0sCodjf1RBcpZ4XsfynFZMmvsaMe9Y5kx7l4qQWwQ4BIWUHy12/CbOEfiTMarf5MeDehlQt7JiNkvvNdfl7yXNLw=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;6:kpFnViVeY6q3eKNGZa8HdCHXVpqVRvy1/cZPh56tN9I6pNlnN1b2/6I/Gx4ZPgNvWCPiWm/uwcYXJ++3clU8R5q6VjIedfFLmmd3TdZ1YpDYbKaZ/yyQbFkbHg3RC57BNHiics6U2qlsxVL1X5KJRquQdVuuAYBBaKhe8E5jvlEZu4D5yMyHMqWDpTqJFpZ26mH4sVV/BVlHd6e5Co7GERHiY68qjmMCTL4Dtaka6FmAuLyEu+evJZOlAquj+h6tT0uo3FhZ2fJYcg+nsvqKjKJv1kw8xOFcQfYhFAeROvb+viMdGlYwh3CK8qup6NSD0sNRHk1x9FVjBzJu4Wtp6UntjCa7hPHTefJaIsLKn10X1uaf3c66Dbe+TE5JbjQQI+xeVoGIf6YlD6O9cWziVmDed6Lpwp6s8wjqfVppm0Kmohlh7Dx4rzsp8aZYFz6SvCXjeAwBPrCRcBR0tyObag==;5:PoK+jc5YzZG2C+yGrAFrHQOhWwe9Y/AriKYmW1NZKmbyS1vXtu1m/DsFSUKXC5Kmwkj4AbiLCvZYneieiqQRft3d+9N1yrKCWMdzt5nwecan4jU1tpBPWlNH+TzdggsJyjYOfq7XP1fna81IS3MOuB1Z2XN3N6wkxpt511W9mz4=;7:Jh89aATSLqaBBsyiwjmCKGrkYb3y975rHBCJqQ8OhfDOMfkonP7mmVIenmrEYMHbHnxf07vxwwMImOSuo29A60kLR6exWiMwqwMFc62owjMF1tUwSxZCHlIyd6GSR9JanR7EScODfz9lNABQW+fCrUJt9Wu1+vn2o6AInxklrgUJdO5WvH1XGQAy/wLAekNo3D59xwo+RLq/PRRvZM1NGa0TBCKP8D9F3Ikffy3HQUplIkR81EdEsojDjD/AWy8z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:dhBYYEG54eQwMGXKV7n45pYtJ5pAUdGurfvp5+GWUek+tNiJOxchUsFjE/87V2zSeRzWk8shDs1ihQbtv+OUWW+2nOz3Rx1NA1dQLAjlrx69MIqAzx1Fqdgt84NwoocNim44dd5I22hiHJ9HNxCH4NgLQm4Va8h7ZfMaI2JQ9J4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 14:43:38.2531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e23403e-af51-4bd0-c5f2-08d5f7bd2b0b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Al,

commit 22dc9a1682722fda8603991595528b87e90436f6
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Jun 28 15:53:17 2018 -0400

    new primitive: discard_new_inode()

from current linux-next introduces the following problem.
It reproduces 100% in my test VM:

# cat /etc/mtab 
/dev/sda1 / ext4 rw 0 0
proc /proc proc rw 0 0
sysfs /sys sysfs rw 0 0
devpts /dev/pts devpts rw,gid=5,mode=620 0 0
tmpfs /dev/shm tmpfs rw,noexec,nosuid,nodev 0 0
# echo 3 > /proc/sys/vm/drop_caches 
# cat /etc/mtab 
cat: /etc/mtab: Cannot allocate memory

Though:
# free
             total       used       free     shared    buffers     cached
Mem:       4047432      99988    3947444          0       1340      49148
-/+ buffers/cache:      49500    3997932
Swap:            0          0          0

Kirill
