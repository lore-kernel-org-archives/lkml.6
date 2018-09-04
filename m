Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932CDC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AE020661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H+dbEH2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AE020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeIDUuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:50:18 -0400
Received: from mail-db5eur01on0121.outbound.protection.outlook.com ([104.47.2.121]:53273
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbeIDUuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im5F5DItuEsAUWE1Nxr5awJLHPpjAiJorv0YQHKM2r4=;
 b=H+dbEH2sqF28fyQSvAi5f1dlrGxpTO7Z00YeX+j4w591cZ8mmT1wtFTzeR5I73qx+OWQXG5/muqbTWwlEVyPDUNQ4TegnteRzcq4c6G/qBd4M9f0A7j3AUiTrqHtMA/RFhoZkSsGCuLqRTXzJuYqqY/cHl4z94TPjGDpX8+wxBU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM6PR08MB3254.eurprd08.prod.outlook.com (2603:10a6:209:47::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Tue, 4 Sep 2018 16:24:19 +0000
Subject: Re: [PATCH v2] arm64: kasan: add interceptors for strcmp/strncmp
 functions
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Kyeongdon Kim <kyeongdon.kim@lge.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, glider@google.com,
        dvyukov@google.com, Jason@zx2c4.com, robh@kernel.org,
        ard.biesheuvel@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
References: <1535014606-176525-1-git-send-email-kyeongdon.kim@lge.com>
 <dff9a2f3-7db5-9e60-072a-312b6cfbe0f0@virtuozzo.com>
 <ad334e64-28d1-4b91-aeba-8352934a9c46@lge.com>
 <6954711c-6441-04df-62a9-a83c867e06ad@virtuozzo.com>
Message-ID: <12d4e435-e229-b4af-4286-a53fa77cb09d@virtuozzo.com>
Date:   Tue, 4 Sep 2018 19:24:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6954711c-6441-04df-62a9-a83c867e06ad@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR08CA0069.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::40) To AM6PR08MB3254.eurprd08.prod.outlook.com
 (2603:10a6:209:47::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c58f33-89fd-4d7e-783e-08d61282de8e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3254;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;3:jZvZDqWBLcokubn4R+YuQG0Zctu4gWZQuVPCnxLI8zyLKrox0dXui9Yj2onjLR3P7XKfaH5HAVGhmX0h670+feFVYLT+58+noZAa8AudRRvvYYUKAm9TIAjA2rXbSRMk8BWo0fKgJok9TJDUiG6282MtK388aSIfbPXF3q0hzMWVNl8jG5DwFViM9B2nynB6Nc0MYtQZbFbWq3Sh3l6Cyn3ZtQMZh2cBncbOwbdmSK0tARjc6frD8+0UcRgs473D;25:HqovE0fF50C4LjD2IF+e0dFTHRg/TUNmvuwhbXGNejFUKA9R6Li/GavuXg9SgFWkIv0OKPWqPBKNvoOpsH5sVRIGFutFlN6DRecFhX9PetYLktEcs7+0iKeujqdPGrid5hf4KZ6WFa7kDVy0i5b+KXxB4bU7b4qArG5QYNsc9XsGactWz4xuix+tH6w6NrcC7BG/4EJiYVGNj0l2CNAf/63GfnCOGqPZryQ1WzDhZ7KHCfCpLrcAfJCdQTZtbAvPozPZ4cxpoAthFHU4nC3TjSvpK6/xLPjmYWLfDB3AeUTjVj7CdJtad9BU++8mWQVwhbCysIAFb+WB7hVtTTn9bA==;31:HB59fTLh711eTt5eoFDY5Pv10gmABMVQ1qHc18wPHSTPATLw2LWt4vPtGdnYXOVjVL9xFGyJQ4tN6XViwzj0ZJ9KyL2nUEDtl5naMnBe8UXsYRUFjmx6IeaZbIYZfQhGMESt2TzaSiYWkTBEvbIC8p77wLUr5dBidX2IyZyB38VfN1nNrue6symPDem3a3dq4w7pqsNZPnBhAgPVh3VVxGdN6OYrXYNx5dVZLHkwBu4=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3254:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:iKai2K8nxu1DH1aVlB9o2KV2HZksC94TSUa/5ZxMrIvkDrAS39kTlQS5Dl+gxF/ztKR9ahM2n3QIZroeVJcrGSPhq50i78jwIG5KmheL94FEufzTAbDDw9D3JFqGMvDLU04t3tLxQY1tYOPWiE2K/Q8oBsZWhUH4V+T6UjcEmP9f6TA5ksH+2v85Fqj7d1msjszdFKmk2ekU2N6198y68JYmxJIvUFuRNLfPh6sG/F8lF0FqiX5oLspThitesfftg2bMkSqik/E+tksAprBgD2YbmpqX5pyBw+z9Muv9fo8zOJ12qdl5R2doDUI2fU9QGb5MMdemz5LrbNLczKDgrOOvu4jIUC8+XTXZNyy/+OWAHJyh7d6Da9LUcySvLwm72cgLcLWQ1DEeKdNI5rq5Z5GUMJbeyG44cVW/LpSyqBEY2gdniSynevLqX5UvbwIGjVAZ0vaXP4LulSNRM10J63ymYEpsAIJyrvByqGDP6uc47whcrAnmZjK1cMinIOHh;4:nOvv3Ig+JJHAWXc8oW0OZS1+xlV3nscatB3QoYzgfNpok0hpQM7GPTL69gQnPnuE6IxyN2GaBOnKlSu1+4QWhhbW2GETJ237kkP2XHS+ZkANOnCnJRVPPxhLobmvIqdbavKVX60380e+P9XQqBtsqhOuR+Q4dHmTcsjh0yv2U3CxJopL3DIrptN9LBjY1Mbebp3Uuzge+WbVcEmHW8UANerqeZ9ua7u+pTZ/QEY13fAlTyCnyxFwwE3Y2ccwJ7PT8l9+nAWACHPI0O9XlBhqmS+Rc08R9+eYhbfGjR1AQV9X2hdOXCxo+yGzVLyMuC7x
X-Microsoft-Antispam-PRVS: <AM6PR08MB3254E89D82209C37DBA44987B0030@AM6PR08MB3254.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42068640409301);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:AM6PR08MB3254;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3254;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(346002)(376002)(366004)(39840400004)(396003)(189003)(199004)(76176011)(5660300001)(476003)(52116002)(966005)(2616005)(65826007)(25786009)(58126008)(93886005)(956004)(31686004)(36756003)(53936002)(6306002)(6486002)(7416002)(8676002)(3846002)(7736002)(229853002)(6116002)(305945005)(50466002)(186003)(6916009)(31696002)(106356001)(65806001)(86362001)(446003)(65956001)(66066001)(16526019)(6666003)(26005)(77096007)(11346002)(8936002)(97736004)(105586002)(81166006)(81156014)(2486003)(23676004)(4326008)(2870700001)(2906002)(386003)(53546011)(316002)(68736007)(64126003)(52146003)(16576012)(47776003)(478600001)(6246003)(486006)(133343001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3254;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU0OzIzOkFySElWaU5BdzdsS0ViUVNTMyt2OVZIaWtS?=
 =?utf-8?B?ZnppYnBFTmZYSUgvUEFIcEplZVgwL1RsbjhhdXgrZFM0M0hBV1Y0MVBFd20z?=
 =?utf-8?B?dlUvVmpsdnExRlZyQmo1dUl4RS9rei9PeWVoTHZJK0ltV1dMYU5FdGhZRmZ1?=
 =?utf-8?B?NGE5MkVzODhtNU9NU0N2YmhJRGpjWk5kb0Y5NFI5TDA4K3l0d1Y2TjlrTnlt?=
 =?utf-8?B?ejNRRDBxN290TzNad0JraE5hRkdBM3lHeEZ3TWRhQWVFdjhiUUZsV2c4L09y?=
 =?utf-8?B?L3NmNkZSaDVTUU4xcDNoK2JrY2xRKzFJUU1GMUpPZ29kdnRwZUhZSUx6NWJu?=
 =?utf-8?B?NGFaWlNjUEtnM25sMjdlNWhtekhrZFI1dW1LaXlaQXE4OXNFcEw3NjU3bXpV?=
 =?utf-8?B?RXJsK3B4RFMyUXRHcS9Fb21ST3dyRnRSaDcxNzRLRXJuQVNwamxBMFJuVWly?=
 =?utf-8?B?UjhqVEVlR0NTcTlDVmJEUGFzUG9LWCtZZzFId0NIckVpUnR2VFI0eHJKbzZq?=
 =?utf-8?B?TzFlcVlBdktYcmJjTVkyUjRDS3VrUFVoSEgra2UyTEEzSjhEKzhLbVdld0p4?=
 =?utf-8?B?TmdCL0tKVk9QWHRqdmdzSUVYbTFiYlNmZWcwYVhHaFgxWEozYlZHaWtwUnBN?=
 =?utf-8?B?TDVhTEtaTm5PUjhWM2FhYlBvTzZHNkc3N0l0THVaQmFUMk9CL1d6QWEzYzJ0?=
 =?utf-8?B?YStqR1dxbnEraXN3T202WERucFBqVWdiR3NXajExRS9jb0xMS2lvaE5YRm1H?=
 =?utf-8?B?Y0ExK3ZVZHRZeTZKa0Y1aWRBV1VkRlp3OGZJZ3NiaW0yT0g5cy9nVXl4MlFP?=
 =?utf-8?B?SWw3TWVJUFdDeFlNSjJVU0JZVTg5dGVRM05KNmVBdWxGeXpsWU1iV0svckdC?=
 =?utf-8?B?Vk5QMDM3Nys5Z2Z6SXBPMFplUjFiS3RHcFNwVmVjbUdvbTVqS2pwV3RJMWRU?=
 =?utf-8?B?a1F4TUZHWjBudm50azkzZkViZVpHZk5GTE9SN1NsenlOSmlKV0xVZEtwZG5E?=
 =?utf-8?B?OW0vNkV0ODl2WUMyNlNGU3VkZUFMYmxmYXRLK3dDdDRPbkhjNjI0VWpJVnNV?=
 =?utf-8?B?RU45U0xWWHlhNTNNVURXTnNBV2ZCZGlRUnVHV01zUnNtUFlWOWIySWtTNFRu?=
 =?utf-8?B?NlJiblYrWk1KamZXcFl6TmpzelM2YXJ2VmY1cnlxditGT293UmYrdnh5cmFX?=
 =?utf-8?B?aGtYZWtROTNEdk1YTHpCWlkzeTZmOVB0cldnVHpmYWcyVXFyODgvMnVPREE1?=
 =?utf-8?B?MituNzM2K1V3SkdxY242bDFYWXNnODNyOXhnaHphcDNjWTZDMlRQcDlWbUFD?=
 =?utf-8?B?SWVmaE4yQjV1NzR0aWxxMlpvcXZUUm83aEdJMytYN0lQUzZzMHp4bWFMamVI?=
 =?utf-8?B?TG83RTZYUzNyVWRZZkhBQTZ6S1UwbDZONlNXRW91NlloRGgvT29FTndBeUE3?=
 =?utf-8?B?dlhTOG1ieDBDNEtCOXJPcGFUZ1E2bjU5OElFMTd2L21TeHlOT1p6SHRna3ZS?=
 =?utf-8?B?UDg2T2gzN3IrRzRUUURub01KTTJkcjZFaXhsS2c2UXhmRE1ZQTdqb2pRSG8z?=
 =?utf-8?B?cWxLZHkvNFBaQ3BXMjF2YkhHZDZhUHROVkVtY2VaL2o0RDBYcmt1eTJ2MUQr?=
 =?utf-8?B?a3RIeXh3aW55cTdOdmFCUmF1eGRQVFlRNThEMjF4dnI3TzZJQVVkU1FzclVP?=
 =?utf-8?B?aW9TaXZsOW5kbmgxU25hTURBc05rSUNZb0RwalhhTEJVOG13ZndxdkFEaTQ3?=
 =?utf-8?B?clMyNTM4SDNKb3pFb0R6djllcHpjNWdvOWVWcTZubVJSWGpKSXA0cERXTFFa?=
 =?utf-8?B?R25wWkpQM2J3bEI4eG80dlNKclB3WmdDckNGRmVqQm9ZOTZic0FRUy9QT0ZQ?=
 =?utf-8?B?N3dHM2NndldGcDZYUHpmcFVBcWk2NHVCQ1dHcWMrcndWMHFJWm5VZzlYWWxy?=
 =?utf-8?B?R3VtdSswY0wvNGliV2dMUmcycGtmWFhOb1Ezb0NBeFdkb25iNFBjZ2d6SGFT?=
 =?utf-8?B?cVN5Smhsa2ZMYXExa1lMRHlmQjZicDloNTU0Q2dTeExYTUpPbnFhTDRKQVB4?=
 =?utf-8?Q?3OqU=3D?=
X-Microsoft-Antispam-Message-Info: xmibTP+tc+smiFms+ts90qPFbqSy0dIAgHTv8AjP4TdE9LaUCKN3mSxeE11dLUcWw+k8nkvcwsOfu1uRkDTbJNK2/ClGTtlN7YX0RYNRn13917rlXDO3RoSAHnZqe2jpMyC/pkRySF+6LuJ8Z2sAnJTTwOIVwVqBbQwZOtXRjz9NMx/m9mqiHAFLa2+cfYbAZJI1s7RHXXK6kg1va/tlHizzEOjXoDmyvY0LKpsyvE3Ok98dP6HE6Wy+YiNS2gSpLurfwpLg6SVomwzj2f+RH0MhFVPWLh+9uV6PpcQmkSxQD8PZdX3oYmUNyMT8e0PAoDSLULyhlRvtrKXXeGgONhUd8Hc0qO4Wim9y3l4DwCA=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;6:di3+QJ2P8yEekcyJUUxNIV5SHMhEm0JU510Wncpl2Nolz1zkdtDN0E//nCTy8p3AdoNXFuUC1vayT1f5q6QBgeRcfztdpE36oC1JotMH0FrTcSyMlBdmIKmYzvdeKfpN/bVdO47uUuXTlSlx6Nwk/yvZHpTUHMTw4mq9dski1U1afICGJNf4iL3+G07gWGdEv97xSIPkiIpGhaHg0doJYeJiUR/1rOueMfpsob4C06k/rYwHN0aCusYBpRyzuISDThHs37dL0RasyKUIh8uZnEMVpD6GUgP2kDDKn29ywT8W+W0n7lkgeeHnCNo8shruhZIYHh0Pki7Q8kO80HrM8W2wFe+/FuARL02Onp2DWxSEUVGbC3p6VXHXhqS/C4gemUFA87+jgTSYb+rnf075f02bWPf+jGbce6evmbLmC4IAkOQ+AbJq+MAvpXu8AqkiXPaVe6+k+X1vIBw5Vy5sKQ==;5:JDoDOq3M8xW/4HW73by179nFtBU3PyVBfPdKKbHLH7rsGXr4HnYPPmKzqcnZpAmFYoeK6WZ70mpICbWd0iIApXsCyOkcTspKPQDbr2XZJ+COBO2FfXQo/G/FA0xOnbMvF441BjWgIAk+c+r6xX0JDpZ46IQAgBomPL5iZ+lkUnM=;7:cVUT+Hu2dFL2/Oy0Ye+ibT9wAA7yEmjYAVi7i9iK4QdlP2TGWzRDYfyHepclq/zEBStk73lxGD7EE2Ihhmnc4/14MH0wBJ4lTtKuwu4I4Hk6YztMaqKCrKVKrenBvzuu9Wj7BA+nI10Lrqcu8YyL6ktP5OxAnzCIGbbcOpy1ky0loDdgPDkKTBU2wiljOYjBcqiMMW8mdcWk0DALWQca80zAj4q9xodotoIST3CzV8KCRZVlYjz+A26CvSd/ucHF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:uZ7ahxWTWO6usF7Qoa9N20uPjF+ATCUHnZqm7O79k4+M9esvhdtYw1ZL15lx2we6HeUoj4KmyZ2uxnOAZ4/RVzNwqVUdme4cq9ZTHMFJ5SgN3Ae9JT84qGGmKkhbPr5qGdDI+BAJvbu5lTSa4KkyHps6ntmTIit1ohEhECCdhNU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 16:24:19.6712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c58f33-89fd-4d7e-783e-08d61282de8e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/2018 01:10 PM, Andrey Ryabinin wrote:
> 
> 
> On 09/04/2018 09:59 AM, Kyeongdon Kim wrote:
> 
>>>> +#undef strncmp
>>>> +int strncmp(const char *cs, const char *ct, size_t len)
>>>> +{
>>>> + check_memory_region((unsigned long)cs, len, false, _RET_IP_);
>>>> + check_memory_region((unsigned long)ct, len, false, _RET_IP_);
>>>
>>> This will cause false positives. Both 'cs', and 'ct' could be less than len bytes.
>>>
>>> There is no need in these interceptors, just use the C implementations from lib/string.c
>>> like you did in your first patch.
>>> The only thing that was wrong in the first patch is that assembly implementations
>>> were compiled out instead of being declared week.
>>>
>> Well, at first I thought so..
>> I would remove diff code in /mm/kasan/kasan.c then use C implementations in lib/string.c
>> w/ assem implementations as weak :
>>
>> diff --git a/lib/string.c b/lib/string.c
>> index 2c0900a..a18b18f 100644
>> --- a/lib/string.c
>> +++ b/lib/string.c
>> @@ -312,7 +312,7 @@ size_t strlcat(char *dest, const char *src, size_t count)
>>  EXPORT_SYMBOL(strlcat);
>>  #endif
>>
>> -#ifndef __HAVE_ARCH_STRCMP
>> +#if (defined(CONFIG_ARM64) && defined(CONFIG_KASAN)) || !defined(__HAVE_ARCH_STRCMP)
> 
> No. What part of "like you did in your first patch" is unclear to you?

Just to be absolutely clear, I meant #ifdef out __HAVE_ARCH_* defines like it has been done in this patch
http://lkml.kernel.org/r/<1534233322-106271-1-git-send-email-kyeongdon.kim@lge.com>
