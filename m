Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA13C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432AB20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="J0NeWcP5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CIFECOlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432AB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeIGXLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:11:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55994 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726356AbeIGXLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:11:37 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87ITFFd019156;
        Fri, 7 Sep 2018 11:29:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=references : from : to :
 cc : subject : message-id : in-reply-to : date : mime-version :
 content-type; s=facebook; bh=4DxIm8coElppLQW2E0iukTYeV+luz/GNCP6bg7CeWHs=;
 b=J0NeWcP5z7/llbrSi7PDOJUMruApwyQeKBQkq3W9TZMV9WeSLD5odFMctxfuRIZqv2F9
 rK7OZ8jc0JJrcWKGtu11QWeJwwx0uKy9rCOvWKL+gBpjFE2y9zP0tmB3X8ayOZuLtMv9
 Z2FzRFQGTsWkHYrfgFhp5t2EWGX0JIzHDio= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mbxj7r0mb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Sep 2018 11:29:24 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 7 Sep 2018 14:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DxIm8coElppLQW2E0iukTYeV+luz/GNCP6bg7CeWHs=;
 b=CIFECOlbDgOMY1buouxyfuVtiG3Kz3gj4z5sbDahofwprA7+aTGCol9tlLUqc7T0g3C6S2qbEU5PuUJGNAd192BupGh8OXk/rVVcv81a5tg44Q14Sn+Txja6uflSe7nJanEBFMP/S0IPrwg5Bu4A89Zfjz6wcCYu/tbshjNzVUw=
Received: from vall (2620:10d:c090:200::4:cd5) by
 BN6PR15MB1220.namprd15.prod.outlook.com (2603:10b6:404:e7::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Fri, 7 Sep 2018 18:29:20 +0000
References: <20180905010827.27743-1-jgkamat@fb.com> <20180907164924.13789-1-jgkamat@fb.com> <20180907164924.13789-2-jgkamat@fb.com> <bed84882-b194-7e45-0db6-08b02bc672d5@kernel.org>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jay Kamat <jgkamat@fb.com>
To:     Shuah Khan <shuah@kernel.org>
CC:     <jgkamat@fb.com>, <linux-kselftest@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        <jaygkamat@gmail.com>
Subject: Re: [PATCH 1/2] Fix cg_read_strcmp()
Message-ID: <86worxmabx.fsf@fb.com>
In-Reply-To: <bed84882-b194-7e45-0db6-08b02bc672d5@kernel.org>
Date:   Fri, 7 Sep 2018 11:28:59 -0700
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:cd5]
X-ClientProxiedBy: BN6PR11CA0036.namprd11.prod.outlook.com
 (2603:10b6:404:4b::22) To BN6PR15MB1220.namprd15.prod.outlook.com
 (2603:10b6:404:e7::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0462e65f-3bb9-4b68-bdee-08d614efd48d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1220;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1220;3:pLGEpVQ/S4fQ97a3TxQ2obu2CUYVI5a6FBG5Kh938r+ARbVCVf/s7blmHCvQuVei+sbwitF/5a1pYGQIVWCjaQy1GmzT8/zXxCjgv5tl+Mhf0AbE3YOGdEtIHCQJ5Iggyo2Z6X/n+tONTAZEoG25+xfLqBhZ1+RRUjtRjO/ZiS8ZpCJGu4UiUIXhzSUOvIkkXI0u6UAe4R7/zOgIbzdF0w7pUEtooaiutQWzlzOMQdI9JXyaFf/AFzCu1m61YTKV;25:IhA0x1r8exf8K6uPmx30Uw9+yaWO7haNREeyt0aXrJvbc5UBIc+nExSTW3c2FT7ETeaML4/JA4AjaHT4V0o3oQdT9ghQh08CUrwU4LHOG5G1HQQ8f9drqqt8JLnhfdM5xjDQAYlw4ILlaURlukPGJeITt6IKZ0qRom/f1lnkfFcNVge3cG6eQSaMyc45DS0P7cCFTNOeD9TUTrV0Uv8wVlSO/m6C63ChBdP23Rou8NrPgZN8MXO+WUscgpkeXSqX7X5xs8qh7cy3L0g9CIRgrfoI6AwmQ5iNS32vQO7Uy/nl17yud5+YsuAQOKJYpTYx9ZvJ0qsivoCGkM3642NsaQ==;31:zpC67tbj2WldYNwgguFfFeJEUGUFLd15iti0X4CbIpZZKGm2uWxB9WoZYjEk2pp1UdvHKTRB2c+CfhpcdUfDb/PLx3bTWmupX5bvxRSFbbv7q/54THe3woGypnAAdB6GVieUKYKkCYkFcxz6nRJH8SY8/s5G1UQ2QUr8Q7I/rWzu1KwkNmJaDdJ17pUirtnCAbgCaxDhMjDfEn4kH/QTIDWo4udHvOG1fEq5C6od/WM=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1220:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1220;20:L6cJoMDZxpHS2ZhLVblTfQoCOHnLEdnbuJh4amsWqBJjKNyiYM2HTK12z8p3Nsz7a3/5l4HJhssaGqhEyOc0CBn4n+6mFa2hpKd7uM7fONX8fMpWSNwaE09uzBxGf4w7wVBd5WtfcAya1cdGJ32dyKDxX/7j6q3IylVoTAXuuyijjLJQcVIbu2Y0zTb9OFrH2GgcYlcQpDsodfaFCzrTZiM0zh8vme4xHa3P4WQDsk7X82iCdTHCzmmvdh5mJm3vYkYYUDTnnTcCrx/j9jZqP+2EeKcg7GtE/vefHFIaMeo+KXneYKkxpYJpBs7JO2p9MISc5pKyelxx8veyKNme/8v7XxRfuRepoOARKrXt66j6vqP1K/r5lkoqp/DFMqMwt06AiQyi/reLzidTywgZpHOceulAR9H5uIGcnQgqiSD0sUQLVSrXwtQpLZime/MI4uM8Y+r+XxJTr/JP5sFPNv2o378iq+xKkjZSemGYFCCZ/19dBl5FgR30d0m4koXy;4:iuJSAzgp+2TX6xcx3lAaANLjMiqYYb0ibEjImUXxYSNnqR8wYRip1WRveD785I4CFPfV5VD/gUsxyVzpuBe1foy+MQjxzmRg80yq9K2wvdy4KrSvfv/jxuGGAEWm2aDPge9HMGljoIuM+4GOuE0JWbiDf/qzWclN9FPtG8kKJxkAPfIgrjZAvfpmct35Ia7BCZCJegH2fBsCVAhwGcT4H0BEEgMdZRawY//Bkk1W8m1j8T4/nwEMxmm1H4rLLdwBKoriUAfEFaHfLkKjDiPGTSdLgQpGLwAvx1zlhCsIrXlvAdxMW68kx7BATppfLNna
X-Microsoft-Antispam-PRVS: <BN6PR15MB12201B41E5B1C1486EE4B748CE000@BN6PR15MB1220.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:BN6PR15MB1220;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1220;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(189003)(199004)(54906003)(51416003)(305945005)(106356001)(86362001)(316002)(14444005)(16586007)(105586002)(46003)(8936002)(6116002)(81166006)(81156014)(8676002)(68736007)(229853002)(50466002)(93886005)(47776003)(2906002)(6486002)(48376002)(186003)(16526019)(476003)(97736004)(2616005)(53936002)(6246003)(6916009)(36756003)(386003)(478600001)(6666003)(52116002)(25786009)(76176011)(11346002)(446003)(4326008)(7736002)(53546011)(58126008)(5660300001)(6496006)(52396003)(39060400002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1220;H:vall;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1220;23:H6QkbU1qt+z7EWfODSsSxJhP0A+ZeEm8UXzuQKY2z?=
 =?us-ascii?Q?I5gN56QXQgqzcna2rLftqiOZ9hqeXcwHOVdszgB7OTEH8rj2P/3lccL92J5u?=
 =?us-ascii?Q?GUY+zsb8Y4NM9M1pEblrqKxb8asPm/fPnJu5YKhQPNZ/uI/nAIvLhb+blp2+?=
 =?us-ascii?Q?acp9xYUe8h5DpkP9maOA1WevP6SmNRKKooWN9LL7jlR37wU9xfbsHIl0Lge0?=
 =?us-ascii?Q?XfhlD187S1/AreXSrB/wqpapIWaTRdwCXb8/xOQgQRqcNKr8uIaa0T2I18ip?=
 =?us-ascii?Q?sc/d0jE1Y2Y7+fPmjbk1PJS2sVjbH2dxQz8IFW30xBBw8JmeNto7/TrYWqZv?=
 =?us-ascii?Q?lGT2DXTsi2fsMWBmJlkLGHxp+O3G6dtF0Ov/nwIgkaHP2G3TG13gXVANwmPG?=
 =?us-ascii?Q?Ot0aHPcy6drjcacyyDgrMJC86s5PobHHC9ig0jiUJZq0nwck717lk2JZIqXq?=
 =?us-ascii?Q?KijwN1lB/KfE9f7DaLloQ8epfUS9LOjgpO3Bfj2PCsuxiB5GBgHi/7t+AW9J?=
 =?us-ascii?Q?+Bw15SSculDSsePB9XTq7hPCkVdBjCXKD0PZ8TH+xSDC6a/VK6L79oqGYwS5?=
 =?us-ascii?Q?jT50C8KMFQAs9FPmTs3hztBwTLhrO4nLFfss5GatFmxUldkPcv/Iq8Bzd/1Z?=
 =?us-ascii?Q?iVZ9+uVWqcBkqFBV0DBlhtq5VpcUimHPR/l9KSTueXFrz5d4lZv22Ez4O+8W?=
 =?us-ascii?Q?/S+9j3NHfARUS8em4nH+SumHrYGgGMifBNKJm17YoY2LVtD6kRctLwKQhKxD?=
 =?us-ascii?Q?H6ocpmPBYOrlBg4lAzO37eOsJ+B8lVUYgfpcuiKBpW8IHDnix1hj5RgA/z25?=
 =?us-ascii?Q?r1lkC4AlcJICHM6FkT6bsnNvs3lMadES0r1pdE+hRcIGFodREUuR47cUUgaC?=
 =?us-ascii?Q?x/2hIJ7fQ3PT1OX+z1ZPlpQ7vviAdEQhEDlWsIolA54Prs6KifRCo2sXifxF?=
 =?us-ascii?Q?QgzycIzL6XIu+iw/xbopCb91YhMIe2DCkLGofmai8D6V4OUUsT9EcMMyyHvW?=
 =?us-ascii?Q?KBNhoEdc56NdQ/UH8coNZUBtq9t6Z2Eqgh3WnT/7DnZw95sIY9NrDqfIbDWM?=
 =?us-ascii?Q?cKMiCIINPQ/W8yJbt5SVSLkng9LrFPzVwXBWTReAWXR0/GZ1B93F6B5UcMyo?=
 =?us-ascii?Q?BT8isxu3YoUMg0H76xbKaAu5TpuR6cb6hlNckcAbkQP/U2hDQ5upX2K+vnSw?=
 =?us-ascii?Q?mtrQ2MebCTXk23lixUNokrt680mg/bIJYFLVmR94VTtt0wY7NXMl2yJksBpg?=
 =?us-ascii?Q?5FjHcL/xbesgM8AgHNCq9Ds6r7xBgPyC0l7BPjT?=
X-Microsoft-Antispam-Message-Info: q6KzkLdntWWtd+wPe2NWrwnFkOzhoT6SQwTsrYHwABBAJbieo9da4H53b8GPqfyCkTeNFDVCMvLwotH7BN+GySiAd2UJL56vxqGIzqp/7U84n0pxEu5o8NgDaRsihFMF6MYQ63F9UkCuiljBbpcxe8ZhdOvluzQPX1l75l68EehAc+YJqggqrLOmc8MzlKeQPcJ36n61fp0p0sVtjgdXE1bQjGEo38c+T3MbNtjYrChbMyBq96HqndqYzyS0xfCUbo7Gt5xTbemi9zfUqpmJo140HxMkn9ItEl+rSYYqGy8Qjp62pV+4rY5Wo50HsFzuwSjGqWYgaDrJS3dxX7UF4VBPjcYWt8Kp2iFF+Gu3574=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1220;6:tocnvZUPhtsUQlPYTaYrPI6Vzsi9NaeGTTqL80ACY6OHqv7LcWEVynmXumo6QIWGVyXt0373/R2amJUmbb7J5wjakvc7KPi8tj/LR2edggTGXje7FIUurUX9jHlDvlIDu7Y4Ra+HOnmJrX+A4SOR/r1qbkeagTMyTzNOXT1Ihho0L30R94QQtWODjEflSNKtWvyO2IWXWpWAL+RN/6pPLDyrDYW00GW7sOd44w/FRLHk8cxKRiL2aBaEDifSwd8Zx05pSaeoAUoNBp00wJ71UztraLEz6Fga61/Vt1ZY8p2Diqw15HXkX2ZmuVcZyclS0lNei2jiukl2ySmP5gld6qsbnFNn/VXSTej0kmegbi+mqO7apde+IBVgB7FcB30RMq0484E5qC0vqZxB62UqVay2UFtVNEYFUOxYz/UAu662DCqZenbngFWkYxsKb0NmaAs0CCgGZpekfevWmjtn4w==;5:fWo+hRppxXA+mk6MSQwcGm7GCvaXOB0qS+mJpcx51vryXRYpbxWS84ZZR2VahbZninmPB35WZ3ar2DDd50QVF26ayMJL5rTwI1IVE7C+LhLl5YCstbFWPi1sbvpSM3fOXJP7RkL+JyyzWXcj96PPXcx7FKRfNXiMwY3HvBHoKzA=;7:Kpdk2grALkfe9X8P3d8j2x6Poh/5AceOJCKibIYVbcLky6UHgVsZ4Qh1HpkGMYcUptw2wX6cQ+140b8+zSc3Z+9TuPJ0XrcyxdpiMjrgt0Ibs/NU4BikwU6ytpIUGULcvejWUEMdoA5NMRnoUf60arlDvNKZR4I+7T1cmH6whkgtvsvicKUb1Xyu0j8kP/LVTKZS+hB63OlKe448tffyaaCVJ6KClOdA9vSaK6/JAVz/AvCk1BqDtqd9UxYW5H9N
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1220;20:Kt0ETS6+stjDlPv6y7FJUVs0OQCF3wSCHIp4NTKiXvvWDZqeh5R+bB8Gdcw/uoKK/oI2vYkfM66jV5TN/i/FYAXr2I0CPEZQ7V0McLFrkmLHIq5p7u12QifVQot41cLUgNS7RE0WwcL4YbVyzgXdx9wgIq15nBZoVkfYApS5Hko=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 18:29:20.5145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0462e65f-3bb9-4b68-bdee-08d614efd48d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1220
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Shuah Khan writes:

> On 09/07/2018 10:49 AM, jgkamat@fb.com wrote:
>> From: Jay Kamat <jgkamat@fb.com>
>>
>> Fix a couple issues with cg_read_strcmp(), to improve correctness of
>> cgroup tests
>> - Fix cg_read_strcmp() always returning 0 for empty "needle" strings
>> - Fix a memory leak in cg_read_strcmp()
>>
>> Fixes: 84092dbcf901 ("selftests: cgroup: add memory controller self-tests")
>>
>> Signed-off-by: Jay Kamat <jgkamat@fb.com>
>> ---
>>  tools/testing/selftests/cgroup/cgroup_util.c | 17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
>> index 1e9e3c470561..8b644ea39725 100644
>> --- a/tools/testing/selftests/cgroup/cgroup_util.c
>> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
>> @@ -89,17 +89,28 @@ int cg_read(const char *cgroup, const char *control, char *buf, size_t len)
>>  int cg_read_strcmp(const char *cgroup, const char *control,
>>  		   const char *expected)
>>  {
>> -	size_t size = strlen(expected) + 1;
>> +	size_t size;
>>  	char *buf;
>> +	int ret;
>> +
>> +	/* Handle the case of comparing against empty string */
>> +	if (!expected)
>> +		size = 32;
>
> This doesn't look right. I would think expected shouldn't be null?
> It gets used below.
>
>> +	else
>> +		size = strlen(expected) + 1;
>>
>>  	buf = malloc(size);
>>  	if (!buf)
>>  		return -1;
>>
>> -	if (cg_read(cgroup, control, buf, size))
>> +	if (cg_read(cgroup, control, buf, size)) {
>> +		free(buf);
>>  		return -1;
>> +	}
>>
>> -	return strcmp(expected, buf);
>> +	ret = strcmp(expected, buf);
>
> If expected is null, what's the point in running the test?
> Is  empty "needle" string a valid test scenario?

There are a couple places where an empty "needle" string is used currently:

- cg_test_proc_killed (newly added in the next patch): Verify cgroup.procs is
  empty (there are no processes running)
- test_memcg_oom_events: Verify cgroup.procs is empty

Previously, when passing in an empty needle string, this function would always
return 0, as the size allocated (1) would not be enough to read any data in
'cg_read', and strcmp would compare two null strings.

>
>> +	free(buf);
>> +	return ret;
>>  }
>>
>>  int cg_read_strstr(const char *cgroup, const char *control, const char *needle)
>>
>
> thanks,
> -- Shuah

I could definitely remove the unneeded strcmp in the null 'expected' case, but
I am worried it would feel a bit too hacky or add too much duplication.

Would something like this be the best solution? If you had something else in
mind (or if I'm misunderstanding something), please let me know, and I'll
update the patchset!

	size_t size;
	char *buf;
	int ret;

	/* Handle the case of comparing against empty string */
	if (!expected)
		size = 32;
	else
		size = strlen(expected) + 1;

	buf = malloc(size);
	if (!buf)
		return -1;

	if (cg_read(cgroup, control, buf, size)) {
		free(buf);
		return -1;
	}

	if (!expected)
		ret = !buf;
	else
		ret = strcmp(expected, buf);
	free(buf);
	return ret;

Thanks,
-Jay
