Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 05431C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969A6208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="cHxHyK2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969A6208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754663AbeFNGjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:39:48 -0400
Received: from mail-ve1eur01on0085.outbound.protection.outlook.com ([104.47.1.85]:10304
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752761AbeFNGjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CltqYXbVhdYxvEDkmarksj2Y4e1idRl+hEOnJJax58=;
 b=cHxHyK2y9sG0pkozi1idjKTkbszE+hXTI/KTiTzjGvsTpbiF8DcpjfPz6bFI5/ZvQR8WCQpshhrqmgigxJ9ScDMl3Zv+mzvpP92EyeLBmElqlPILFlrGHI4Z+KFix/jNlttL/rowDTf+sFrxascR6YGfoZVearyDEuvsNeAb2tM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 AM0PR0302MB3203.eurprd03.prod.outlook.com (2603:10a6:208:9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Thu, 14 Jun
 2018 06:39:38 +0000
Subject: Re: [PATCH v3 9/9] xen/gntdev: Implement dma-buf import functionality
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-10-andr2000@gmail.com>
 <b08fdccf-2f1b-a902-f00b-a4cecf44a1b1@oracle.com>
 <cca7b9dd-a0c6-8052-c294-9e6c5d65e9eb@epam.com>
 <0f1d87e5-823e-8b51-4ee5-029cc94eff99@oracle.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <987f26ca-b1a7-9175-ffd7-23d247402b41@epam.com>
Date:   Thu, 14 Jun 2018 09:39:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0f1d87e5-823e-8b51-4ee5-029cc94eff99@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM5PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:206:1::18) To AM0PR0302MB3203.eurprd03.prod.outlook.com
 (2603:10a6:208:9::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bfb84e3-58ad-45e0-d042-08d5d1c19a74
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0302MB3203;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3203;3:Pe6SxqEp8sVnzf0Sg6vzea5hmYlDvfqSh5lTJMic74t+n3Mf+5b9AMR3xfBxYP9Xb7I+ihLIAbVVIQufyaYAW+3g3b+Bv5TWMTzLyFBqY7c8fEMpwzTR6k6RJHOA0SQFdziFLO/W2TMx5qkdCkL3oKUvPlInLp38x+iCf4GIPrjXLYcH/ISuZNAn/qmDez98IIWXup2D2oKy9KN+csrNTRlAUz+JFo9CBcytI77X8bvsafBzxIW5dRfHVrY0SIua;25:FzghSiZL5UATI/y/42Op8PJV6kP/J3nRny+h5B2N5XfWDo/Heyg6IJstqE+OQ32FbILec5GfZ8vWp6OcDu6RmXqW8muN4iqvfYZia/ySoLRi6nLIOXxRaJaIq7RMWXQO2otMuk6eXtXIOGLl0jR90l2cX8SXbfc9SJhIS6GkKigs9mw1YXYhx+Ak69/dDqtAoSdInyfX7ImevXm7NLk8srRvmr/7s2izeqSgQd6XTr7AnUVk0YfGPQzKRT7UYULglSi7O3Oukltakvo5PIL4SpOPbpgChUs4wHaEmiuijxbAitGgKJOB3YdPp4xaHDin9xCeY1BvqvNlTlx78VqDhQ==;31:qruYNNJprog5i90lFA4Iwa9HAFiOLNTWGvq5O2HG4VUiTrJjQvcHWAN/q6V26hVyZ4sFGS/TKWjp/3Ii/Wkh1i3Kf64wUpi2MEi60TeS8S4yNLPYYEP16e0VvkfSFwGqZdshwsMaFiwRAEZkE7in8Cw9eIQ3Ks+cf5LbIS/bKDva20RqWYN3MPrcvPvFWZCait6WpSkU/T72STlSiEUiuy4WSjVPSBHHNZPt4s+8Ofg=
X-MS-TrafficTypeDiagnostic: AM0PR0302MB3203:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3203;20:h5qSgpPF3iiVAxggTTtvsNcZWTtVUMjhjoRCi+XEEm3ZvALWDHBH+DpVthpOvQFU6S1f708UO63n+KpW00hUDkyvlXpfOCXTmCufzUxcZ9B2hL5qKbCdwgsiXeVvbAtusZXO1++g+6o1jAZ5fqTZSHL6MurcyYK9vgJsgSUpOpm+TE2ehtnYrADVNap1cQ7d+XCgUvY9t+xGBPz402U3aAcLUs2GFDB7kOhEXELrQKOYVnpUTH2TzXY2/YfHf3UQPpQB2Y0V48LfdBE79i/yaOptQxN6J3FsuyBR3ZbLwkirqV92LFUaI8JH+LOXBfLS7oB6UMDdXa6EWCXTqY7e2VDo+4FLpfEAvuN4P+9Gg/7/UIrRSOCt8I6McXfY8h9jIGqG+nR8T5o93CqWHK8IQJDb3K2ul5WL2f8+gQGO/KOK+OdrdJmS2Cw61e7Zi7TL2uJFZYI9+Bc346ss1QxbDOQPzlbHx2j+xfEMGw0NEqaRdb0+iFNJl6krMtpTvs/f;4:IAnBFEMadESkzk19MfCrMj5hIaP0wEtv8rMsJNCWymjDRuYaDsONO8MCUTGFbmDrT5ItQMbkIkUUBxeBz/AhvD+kUeWRl/O/b3+7JwSqlyRND/LKXEbxWySL3j2CjAwNLpaNaCiaBXnMxQoUCPQowakFWx5sFDZIL1Bq0UGyQtLT1ODAky0ltVxgamA77Jzr9l+s6fPpqsyKSXxECe1Bzy7TRPBA0tsIXHHuhdJC/0P/fNpZdWUEAF4kxbRBqSCnBT5fLyhnXj84vs8PFfQQyA==
X-Microsoft-Antispam-PRVS: <AM0PR0302MB3203E3F48496A50830A8F514E77D0@AM0PR0302MB3203.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR0302MB3203;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0302MB3203;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(396003)(376002)(346002)(39380400002)(199004)(189003)(65956001)(66066001)(956004)(16526019)(2616005)(186003)(476003)(2870700001)(486006)(65806001)(81166006)(31686004)(81156014)(106356001)(8936002)(446003)(16576012)(105586002)(305945005)(316002)(47776003)(67846002)(11346002)(8676002)(58126008)(7736002)(110136005)(65826007)(97736004)(23676004)(52146003)(2906002)(2486003)(53546011)(5890100001)(76176011)(6246003)(39060400002)(68736007)(64126003)(72206003)(59450400001)(478600001)(80792005)(25786009)(6486002)(6116002)(3846002)(31696002)(5660300001)(36756003)(50466002)(77096007)(386003)(229853002)(26005)(6666003)(52116002)(53936002)(93886005)(7416002)(86362001)(55236004)(4326008)(87944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0302MB3203;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzMDJNQjMyMDM7MjM6T2VtNjRpZ3l1QWRtemdMMXdPMjJ2TXZN?=
 =?utf-8?B?MVNCaTJOQ1B0M0lRYk14MlRla0hxSXlOcG95RTdPTWNPRHlUblNDWDlXSjZE?=
 =?utf-8?B?MmZNUkt6K2kvdjk0VHZJZlVDamJVOGsvOWpQRG9Gc1N5Lys1dzl0ZCtucWhE?=
 =?utf-8?B?TWxvRjE3OVc4cDcyYnRWTE02SkNkQXlRMVd5Q2VtK2FIQ2hyM2dMQzMyY0Rk?=
 =?utf-8?B?MW1HTklYR0dLdzhJb3lYZGRzciswRU91Qm4wWFhqQVdKQ043YXh6MTl4THlL?=
 =?utf-8?B?SXgxSFNhanRlWGU0Q1JYYXZnMW1EVUlkRzNJaUZ1aWpENk9sR2plM08vTzNT?=
 =?utf-8?B?WkFhMDA3dVA4RE5WQ2p2QWkxTXJraVRpT0pjTGFxYzNtYWdBcG5iL21IOW1o?=
 =?utf-8?B?WWxCeW5FYnhPRlZGZ3p5akZRSlhsdnRKemdUNUVQVStTdTN3TnhBM1FwUVJP?=
 =?utf-8?B?TjJwcG5SVzRRYWlBZHpiVGZ6VUt2clVzc015bUF6REpaWXE3VEFpUERuM3Mr?=
 =?utf-8?B?VlQ2ZDdXOVV2NFVCZmpUVEVYSVNjV2NFWTBwTkliS2s3ZUorUkNZdXN4M1JD?=
 =?utf-8?B?dEwxaE9JNmVCUTR5VHoyUTNHMExUWjRTVTF3TEY0MS9FRWtmMzYrVDlwQm4v?=
 =?utf-8?B?TkROcmg4QnZJQnpBelo4TnN0WjFQZVNKL1E4a29DQ0s5SDBNZjRMMXVQa2dr?=
 =?utf-8?B?M08zMW9PYTk0SFFUaEJTdXhFbXk5dENGaERXVS83NFJvdjRjWXkzMEZrV2tx?=
 =?utf-8?B?b2Z5MTlYS0xPVXBNOEtKa1hFZUcvLzJVNUhtWVZiSEhLbGtydDBhdHlGRWpL?=
 =?utf-8?B?TzVaLzBORDZnK1FaK0xxc1VoS3Q0T082WVp3VDUwWTJQMFlUY1JYMSsxQk1C?=
 =?utf-8?B?SmpSRzc4MUoyMW4wcmJqeVBIaVdQbFpuMllMTmIyOEJVWEQ2RVc1Z2FJbk9s?=
 =?utf-8?B?MUVxVUxaQ05nalkzWkIxclFybW45SmEvR2J5dVZHbUR2WnhWWExGUUVwM1o0?=
 =?utf-8?B?U255VDBDVUs2T1ZHenBPRnpGR3AyaW9hZ1JHUmMwOG9CTlZmbjRRaERJS2p4?=
 =?utf-8?B?bEkwS3dNdG5tdkJkazFjSmFvclFHN1JOeWIxVWlJSDFnd0ZzdllEUjlFbmxQ?=
 =?utf-8?B?UVh2QjdTVGRqZUtpUXdyTUpBYUNJUnNjckpYKzUxeGlsUGM5YUZRRW8yY2N5?=
 =?utf-8?B?dU9CMlVVaG5PeVllazBVT1FwSVkyVG1jWWRRb0l3b1JyUlRXS2tWTmJaOXpl?=
 =?utf-8?B?bktHVXZtUW9DMU0zM1ZqMGl5UlBGVnNYOVRGK1F5NHAxeTBsbkkxR0VOQ1RP?=
 =?utf-8?B?UEY1dEtaOElLM0lCWWJLNW9zblNCTFo5TTJHVnpJMlpQSE94YnRNMnBwcDlN?=
 =?utf-8?B?NFE5WnN1cURSK1NKU0pqNEV2NitGdmlSS1BHcHVsWHJBS2RBTG9OZ25lbUR1?=
 =?utf-8?B?MHdVMVF1NVRYNWdYSkY0c0ZZOVpyV3BsQXg5ZlFlQUp3ZWVXU1YvS2xJRU0r?=
 =?utf-8?B?YU1nZ05jWGlEZTBncW1NcjZCNzcxNnFOSnVQZkUxcTlLdzNuam9QTG1ES0x6?=
 =?utf-8?B?WjRQT3dJSDZSUWtiZFkyeGsyRmpEaXl1a1pRZ1dyOS9xTlJZMEovMXMxOXN6?=
 =?utf-8?B?TmlSdHZvazZOeGJ0Z1FjYUkzWmhVcHUyK1ZiV0srZGo3cmJLcWdIaDJrZ2c3?=
 =?utf-8?B?OGNqdHNrdmEzL0tGcktVMW1MbmpQTHhnWFY5U09ISStqdTljWnNBZzR3ZjhJ?=
 =?utf-8?B?cUc2aVpoL0g4VHF2TE1tQUE1clJwSkdLS253K2NLVkFqTlNUTkFYY0g2YTd3?=
 =?utf-8?B?dkRhVnNYRGxqMVFKVWQydDVsQmtjWktmQXJGYUwvU0FVTG1NdjJQaHpDZzFk?=
 =?utf-8?B?OTB3amNVSnlaeW1mRWxOMWlZZHVuZHFMcVIxV1NHM3phRUlZZXFzbHdNNUxL?=
 =?utf-8?B?NGFOWTNiNnp4UFFKTXBwYXd0QzlZc2ZBTmQ3VDB6aEEwVTIvQjBjdEFOd092?=
 =?utf-8?B?cXZWckx2OGhUM0Fjd2FNbTBXVWNCeDNpTUVnTVBra2s0ZGtNRitBWkc0bUE4?=
 =?utf-8?B?L3lqeDlDREN2SWZNdTV4N3MxenBTTGRzWGMxVUpIZGN5WnNpWVg4aklGNUJZ?=
 =?utf-8?B?T28rRmVET29tYUxjUytzV2FEdlZtandoSUFYSnF5UnZ1N0twQi9BbFJ3T3Yx?=
 =?utf-8?Q?xPC2eKSP8zczh8Ti2ihRrQ7oAYPQ4SBOV6J4rbCbdeqE=3D?=
X-Microsoft-Antispam-Message-Info: rXb94w7A15mb0fvdVFEMWFCuggLtokhSPVKNaSpjBsjQnDvXP2qYIl1yWOJoF1WA7V+0E+42efsuYAHaDoL6RtL5/5qUylhEXavubxUc2TNd22n+ZwXGHUEJ8FPfhdA+08qDYOwT76hxluAvDQ/MldbNGfMDm8Gm9b0i9k2/WfrYK+aCpfI9GVTUtEJ8YWWl
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3203;6:QhMIWqSaP58tVRxCd4HQ/AhEO22yqYs/B1GnCQpBIScg5jVHbrBUQ00bmazCwjLsmACpjMNV5jOj44jAhebd9D8qCHhexWpIivZn3enhp3TuEebMPnF53uiFQ0JLptBHuWMLJLO5bgAXSi/9ylUgHWzGI9u12BqzYVO0Ig335Eafr7DXAIHd2+akBM7dM0IdQMplhJPZkEHT7+dU8EqYZRdboiNhPa2ObXSh39jhG1K4JI3YqSuCqxvN1gkJrvcn+vkBqPGD0RdwrNW4VjXYdEdrlc/RLnNWmKFHsTs8rg0movQX/hUvbHD7g4UveKL6Ks5tem0/fK99b6JMO/o+1IGVO7QH9OqEpbqSXOzmwzi1uU23EZmZlz4TgnsRvR4Df4iBFd15NvQw46nyhiHeGlQDU3uBscWPS5uEGEvPYtom9UemLKuwT61qZeCX9Y0/FMR4FKN9B+Zq3PTvKzYsoA==;5:8urHIyCU2OpmxcpFXBA/qahjfof5mpisEQ+EwbfsIgc2igkORJs+QUscQON+LD3vWFd3ilUeLG30yP60V2TDvy7DIwxooJI5QliRgTF675ATPyIn/aPhyui+UYvyF3tXX8FeK+HUKqO1aLXsBFASV4QPZMN4LhCDypgNREsZ0TQ=;24:haxYLyxQi6+XeTre2KJXCyxlgaU6QHYEwn613N4PEzy6rtrruCbiGwzk53zhvWkAnwt6x2ZZurq6V1v+X3htgyRGMpBMHM8Xn6UPxEWuU9w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3203;7:2TpzqdD750qRfVOE0U1IGoNtgpnxYeghUww4fCqMEmiIBe8TJPpvnIvW0ZIccgiylfPS/S0o7wdDnj+UJ+akfbq83kHKsJZ4RsMVaqpHkNzt0eTrd4AY4qZa3dctJs4bG7DUC5DcOizLHbYr39g2nnA+2MLJaZ1F+kaVgzwbPu4rVRbUf3JGx8xfjV+JQQXDkKqBRXPIf9AdR2KeAZoYHMYYE4MLeBLK+3Dtdb5QsEu6AxRYf1czJlJwOprBfe4i
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 06:39:38.7564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfb84e3-58ad-45e0-d042-08d5d1c19a74
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 01:03 AM, Boris Ostrovsky wrote:
> On 06/13/2018 05:04 AM, Oleksandr Andrushchenko wrote:
>> On 06/13/2018 06:14 AM, Boris Ostrovsky wrote:
>>>
>>> On 06/12/2018 09:42 AM, Oleksandr Andrushchenko wrote:
>>>
>>>>    int gntdev_dmabuf_imp_release(struct gntdev_dmabuf_priv *priv, u32
>>>> fd)
>>>>    {
>>>> -    return -EINVAL;
>>>> +    struct gntdev_dmabuf *gntdev_dmabuf;
>>>> +    struct dma_buf_attachment *attach;
>>>> +    struct dma_buf *dma_buf;
>>>> +
>>>> +    gntdev_dmabuf = dmabuf_imp_find_unlink(priv, fd);
>>>> +    if (IS_ERR(gntdev_dmabuf))
>>>> +        return PTR_ERR(gntdev_dmabuf);
>>>> +
>>>> +    pr_debug("Releasing DMA buffer with fd %d\n", fd);
>>>> +
>>>> +    attach = gntdev_dmabuf->u.imp.attach;
>>>> +
>>>> +    if (gntdev_dmabuf->u.imp.sgt)
>>>> +        dma_buf_unmap_attachment(attach, gntdev_dmabuf->u.imp.sgt,
>>>> +                     DMA_BIDIRECTIONAL);
>>>> +    dma_buf = attach->dmabuf;
>>>> +    dma_buf_detach(attach->dmabuf, attach);
>>>> +    dma_buf_put(dma_buf);
>>>> +
>>>> +    dmabuf_imp_end_foreign_access(gntdev_dmabuf->u.imp.refs,
>>>> +                      gntdev_dmabuf->nr_pages);
>>>
>>>
>>> Should you first end foreign access, before doing anything?
>>>
>> I am rolling back in reverse order here, so I think we first need
>> to finish local activities with the buffer and then end foreign
>> access.
> Looking at gntdev_dmabuf_imp_to_refs(), the order is
>      dmabuf_imp_alloc_storage()
>      dma_buf_attach()
>      dma_buf_map_attachment()
>      dmabuf_imp_grant_foreign_access()
>
> Or was I looking at wrong place?
Agree, will move as you suggest
> -boris

