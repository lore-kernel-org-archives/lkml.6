Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 96B66C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B9F208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="BnRBylvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B9F208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbeFMHXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:23:31 -0400
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:58159
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754487AbeFMHX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ3TuvJyK6+eJIaqs9cc2F4N+n6tLm9Jajs1LC5SUzM=;
 b=BnRBylvHVA2RDBMFpDsdevkpBRn64ls5gvEQ8Z77gUQAi6Jb2mXt+q8om/DogUFmqUPhk/EKpy+vv4XK36yJMlsQRycFrA2m5Zky7LCOw3bMSkFYV+buvrU+6CeB8cb2sud3wGIIU3Kl8FoFRhLMaqxvLm9XUc3AvD0/88GSjYY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 DB3PR0302MB3211.eurprd03.prod.outlook.com (2603:10a6:8:9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Wed, 13 Jun 2018 07:23:23 +0000
Subject: Re: [PATCH v3 6/9] xen/gntdev: Make private routines/structures
 accessible
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-7-andr2000@gmail.com>
 <fc339230-f1e1-303b-1b82-0bd23d7b69b3@oracle.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <ac1f47e6-9d90-ae6b-5596-00a8b3607d96@epam.com>
Date:   Wed, 13 Jun 2018 10:23:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <fc339230-f1e1-303b-1b82-0bd23d7b69b3@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM6PR0202CA0021.eurprd02.prod.outlook.com
 (2603:10a6:209:15::34) To DB3PR0302MB3211.eurprd03.prod.outlook.com
 (2603:10a6:8:9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f413918-c92f-451d-5f38-08d5d0fe8c71
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0302MB3211;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;3:kpI9Y2CTfrsYwHxCZl7W76KB8Fjqr+EVP7Qjxnw4nEE/ZUfAyiwG3LW0kHcHdCKoMPjBNVbFGV5xwH2lk6t0U5MEZH0cH1Lk+k7fK8G1SeRlZFDkeldpUBMvcmw7+R4x8wrPKdlhMaa0eSBweOqT9+gV78xQxBW84PYQ2roAnSRSi5nYrlfPpCFmZITI8K/oiskCFgHYeb4q0/eifS9IUF0J5INS4GHGSVTderTybFWk+OxshnWoM35q7Yy/n7ok;25:k8ME6b4TclQuZqgMtnlQtVMQZ1YYRArxQaxpKAuGdmUminzEEMSBpC1Qp2s5pkQFSzu3lEa+Cidu2xGmaCqVN8bk/rLZUnw9TjQmGzmjx8Ok3uABque7e+g4ShiKQahjfUj+ZUd/Bbb/HYJKnoiedCG/Ni7Q7rtq1R4BY8siTm3v81byqrRGgprJ5s7s0eEyz3XOS54TlRZ4Dzsz4Bs1dTJUE0Pj8QIK5mVjEtlDJFDuOdM5O+OdvDHxbQ8IlMTPN8/TzRzmkkA4IzomXrjreR1zBeEtBuuVKhNXA8VNOr115YVXwpyDAwO1EbW5UfKUwIU34pOmFFnxES8tX2bAjw==;31:S7xyKft1F++O4eMqTD5wCCX4dul9VophKUmZICmDpvF+rgDkAnG9rAyr/XWTqM3Z9Yp/2I21ZFj17fns5UXkiKbWYsS4p8ZdfNWpn+a7izR12z85oRGX/uAvkDPo7gCYZo930kbjFItIG95bHyhYRhAq/tkVgIGggtl5H5YyodK1jX5uv8JImYqg/IsDk4Pyf5Ps96vKgmoGbFrAGMIa90Wl6QGJT2tJV4VSXcypOXw=
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3211:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;20:PeNdl/aViW57v8SkW+SNBlhWNBS5V0h+oVof07HJBr7/RVnu16CuRNpu0JYX+dkobMAcnbZh9K8aPePA3r3dLxCTvxlQk8erXmdy9WaKWrlSc8QqPnyuQKqYLHQgRvO0qbbtrT3G957sHgh6M+Ih1UkBSo7k/LlI4rwWT87pAmPEpHaHg1ZReqJUvTIZieaXKbgxZOOYvjaH3LQLNOsmmnieQK/cnKFkuu36pC+2srqcgHj7e8/WRNEnhRC3uzltJCzBBxYQjaeW/F0IxiZ59yu4MZxjWzuvmmM+ijCEPsGlqmmQyLJpO0QBRFUJOWgLF4voogZuD+2kXf/jaOtHObIyGH/PRRrm3LdLcnh0ccm5O3yFxzV0luxPf4RVP1yumaHUerP3KH0D9KwEBEO1S/YRXHb4v84jR8bcBxemIFEKljEaqlAozj6XyQsnUl9SoGiBsDWFiFGAgjwTixeLCSe8ZTucHPDv26AfWvzEbZoo6zpKhfwbaRRFuo+3Z2K2;4:s0MSiFfXgQAXHEOh/nAEYMYewQ85cDwsOJ2iOWINWUrYRLjYxAANBgwViwgV8KtgncfMUOdld18qgE6h6/PRkECmH7MAUPXMuS6zBmhDc9CAa53FugcD7/ObffzxjhLwxOPR7ubBS0HisOV8KTxXZ4UbFHhlqHVetv7coBjceJFFVq2vrAJL8kBX9YRw21Me8QY+mW8vn7u729x2ONDd6rodFpiGg94rgq/lxldSX7xph1B+/t/O7BrEIukBuvL5cJ5Ve2wG2/LfY+uxhhfNBTaTZhAQiUxMwKtNshgWEQfP+G18C88OQkR+l/9olqXGWfBV8EzaziJdIA8EizVbUA==
X-Microsoft-Antispam-PRVS: <DB3PR0302MB32112ABD5B0743F940C88028E77E0@DB3PR0302MB3211.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB3PR0302MB3211;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0302MB3211;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(366004)(376002)(39860400002)(39380400002)(189003)(199004)(97736004)(76176011)(80792005)(4326008)(106356001)(66066001)(105586002)(59450400001)(77096007)(65806001)(31696002)(26005)(53936002)(53546011)(386003)(31686004)(478600001)(86362001)(6666003)(72206003)(65956001)(36756003)(6246003)(956004)(55236004)(39060400002)(25786009)(47776003)(229853002)(2616005)(186003)(8936002)(2906002)(16576012)(316002)(7736002)(305945005)(11346002)(8676002)(67846002)(486006)(23676004)(2870700001)(110136005)(3846002)(52116002)(7416002)(58126008)(50466002)(6116002)(68736007)(5660300001)(16526019)(81156014)(81166006)(6486002)(476003)(64126003)(2486003)(65826007)(52146003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0302MB3211;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjAzMDJNQjMyMTE7MjM6K203d3NJUmZKbDAyNVVqMEt4a0szdW1T?=
 =?utf-8?B?aW0yRTdpcmd0U2JxVjMzT0RxcnR2NG93NERtb2x6akFXOTI4RXYyeVR2Sm15?=
 =?utf-8?B?MDlwdEdqQ0pFbWZyR1AwVC9nRFlob3VOQ3JCK0xsV3o0NG5VUjRnNk51V3JJ?=
 =?utf-8?B?RG12Nlp2S1lZR2UrZDVhTHpETyt6bkxxcjZ1Q1k4SEUwOGJVNEpkekpPVkZI?=
 =?utf-8?B?Qm1WNjloSktyYUprZkZIYVpEZkI5b2szUGdOOVEzTXdYVEU0d3gwYmkxM2Z6?=
 =?utf-8?B?bktkWURXOGtqWHg1STFaRDkrSjArMEZXUVNBVHFZT2FIdDhRbGdyK0VSeTNz?=
 =?utf-8?B?MURXOGpKTm91ZDkwdzlZZmExOGFpTXZEZnRxSWpmR3lBaTRnZE96S3BjbkJK?=
 =?utf-8?B?RDNXUHNtZmlCeWRMWFlRVDNnYUxNdDNoeUV5SmlXME5ZSFNDbEVOYVNZU2x5?=
 =?utf-8?B?azRGKzBWZEdnNnhpbFBjcGlBR3N6UXIrZG9vSEVsOHVvbTlFTHp2UWFMbFBB?=
 =?utf-8?B?TWhUZ3pRQjkxSVVnSnFzWXZYYkZJd2lqdjNPdzFwb205eEIxWVd2aHFOUU9W?=
 =?utf-8?B?MUljR1Z4ajdTR0xtWSsrM2UrRXNqZzd1U3ZPM3o1V251WTdrdkVYTlpzRkQx?=
 =?utf-8?B?VlFhVXRHb0c5Z3k1K2tlZ1dOT1VtOE90V3RZV202V3ppa3NnZkVNK0pvN1d0?=
 =?utf-8?B?ZFhiNk1qZy9halpHV3Q0WXczV1NCbEhDYWkxVWlQbUdkOWFlUmt0ZmpIcXNr?=
 =?utf-8?B?WHNqOVNRTTc5RVI5ZEJHWmoxYVE4OFp2Z2tuSmVpdFhTVFEwc2ZPZW1vaDdG?=
 =?utf-8?B?UDh4ZWN2MzVQZEVzbVFOMS84R3RsTWdyRW94YWVmQWxkVzErZTYvNGZkejla?=
 =?utf-8?B?L2tUWjM4WHpRQm8yOVBmT0RFSENIWTJVWFBPOFFiK24yN3ljd1M1RG1LRDBW?=
 =?utf-8?B?UnM2RFlCMElYK3c5THJJTm9aRzdNMXZoMVBNVU1kQWlvOWJ6ZWFwemdwWHRF?=
 =?utf-8?B?TlBtaE9MQi8zNVFNNGV4YTRpckE2RjRpVkRLamV2VkdmbEw5SWRtSTVHQ0FK?=
 =?utf-8?B?TERLTU1uNldGWHlzLzRVU1BaSURobnBNWjBXS0tHVVNnNEREWFFRUEhXVUpF?=
 =?utf-8?B?ZFpNVnNyZWR3SGlKS3NZUU16UWpNUVJJNitWTnh1K3djMkM4N0p1V0hZdWpW?=
 =?utf-8?B?em02Y05tdmFoclU3K2tDWlZGSVdxaGlDazFIQ3FZRk9jMGNzalpCMlk5SE9J?=
 =?utf-8?B?WlIyZTlnWG55ZkNIN3ZZdmtMM3pOczVUQjRxcC9Wb09xcFdHL2g0Tm45SWNx?=
 =?utf-8?B?RnN4L0kxTVNyaElnaVNDV01GSVdidVRFamxMeUVXamhDWlZEckZWRTF1QnlU?=
 =?utf-8?B?RXI5VXllZ1FlSmJnT21zQy95WXpOK3hEM0R4T3BMWkZaTDMrbTFicWZWQmwr?=
 =?utf-8?B?S2IyblYwNjhUaGhTKzhIT003VjF4M2tRQUloMHdsdjV0VENLT05DYUc0S2I3?=
 =?utf-8?B?YzFZRzZzRVcwd0RnV24veUVBM2o3Wjl4dEdPeUptYXRoNWdJOExGaGkrM2M1?=
 =?utf-8?B?dE5WYTdxdTBQbnBLblN0OXp2bDU4YlNSRUFIRThMeVJaenRCN1hwc3JJcGpI?=
 =?utf-8?B?MnpqT0FoVEduV0dZZGZORkp4cFNJOEY4U3B5VlAwbGdKUjdSeHpaejJjZkNh?=
 =?utf-8?B?UTV5SkQydmJLeVNENnR0TFAycXl4dEMvaEc5NmVoMWxsditkUm03US9rNkls?=
 =?utf-8?B?MGc4Wm1OcEZ6M1ZtY0QwVGtzWGRNR0llb3ZmWTBpYk5nbUlwM2lFUHY5N2Zy?=
 =?utf-8?B?WHNPeXhMekF2WmNNdTBlQzlXNmtmNmQzblQrUm9RdU55VVN3QmFsWnZJWVB3?=
 =?utf-8?B?UUtqaDVEYlB3MjRhS0NFZ295cjBmaUlKV3BDMlBkNjFlQmg3bklmV1hnV0Ns?=
 =?utf-8?B?dkc1ZHE5RU82S1ZkT2NOMVpwd1UyQjllTHdrQ3FEVEh6UktTSzdiSWJDczdv?=
 =?utf-8?B?MWdSS2IxczN3Q2g3TVk0dFBjRW91SFFrdnZNMit4b0NUWTRLdGh5b0FTbmpI?=
 =?utf-8?B?ZHhraGc4WnUzaXE1bjN0ekpJOUtFbGVPZEVQT1RnOEQ5SmpXZ0dyUHVXZjFn?=
 =?utf-8?Q?oj2iVYsOLfEVHcI+cuLP8fOFI=3D?=
X-Microsoft-Antispam-Message-Info: J7TqHYj/uIXo8hfuvRHzKdF65bPsl90AOk004CT2GQy/nGXk2U5bS+eCLAiMZ/9+Cavl70S58oRfZtcnagriIm8MdmKQA4dUbhmGshkyCqdMJbyfVWLtUsfomQnLcbibOLUP7+gDtk02UcFiIwUNLIivAfxb9l9hWDCpJ2MTJiv0tsXk7+HslyX3GzKtNyre
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;6:3z8pp5mu2fwVThZ2zOVpSzWl1oegZo0ti6OPe+i8a9iCoohva418U/tVjyyZETcqzNSZ3t5Q1tjSRRRRYuq9F4W0/0ZgWejHpqG6buvTCtpGD7Ipry4V4ce3RrrAuCBu2+0DHxHTDVDw54M70ANeZRTqJ7AGkEpMXju/GSfLJiH7HZdeqckADLwqEEnjmF4Bbgl4BL8RvaUyzuOPOquv3wR4IJwezjgH/qhow/b3JKC+jWQ3v42t6PlOtT04ERcyxixxx+Tr6QQltQSka5cIv11malyTSZv4WNmFhqmFhdID2Bs7obBOzPxKqnum2x8tWCzbmiezOMWOHWve8JA9XbtiwcW4N1spC4UJiftSZKhc25R/cEvFaNRg1bwIhbPXAY6SjZXfm/MYsgxpbDBDGuHYn5lORJwn026dtIwdFd5x8JWGxApR8XiVWTXlJmWQuV5jVp2OHedrJDi504CDSg==;5:btPYHZn0RsXECinpC7f9IenXAhJ4Dj0gieBfma30zjXmcrn+b+HHfwkBd35qqJLVQMuHes4N1XBB3uE/pkuAdqf3JxdUwtow6ktOpZrvaQlts07axjsfQE4vi6KqewPB1NtKZcBMXF5AK+sPRzjIvXOJt0GM66La8VZZyCSYkPc=;24:hQNgToXwgnQKYyLU13B7sOqQgLzm9L80na7fTUvtxOucadaH4jtnKs5eiu3G4KhGhT5+w0CZV4FkjKz24bmrC0OUAem9zRZ+K50DJ5S/uU4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;7:0rmwy5mQHZym3b/Rz6KnqymIbChi/xAotBrkGOgwtoejDotUj6NyzHq8/uqPqnlvLt6odheszkmDYLlxV+Ma1/P6Mnvta/OM7ddOA6NCBiVsyoAzlOITCGkee90a/5+fVXkDi5Dnv5D1gWmPU3Z3hFh45c6R/nePqqkbAV2iKnA95bDcpJyqqtv3fQk68spXu02iZfQaeKYRJPY6PNrNxmPa3DJmP1/p2L7Dk8cFEN4r1I/S7pThuCIKkofzRfEr
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 07:23:23.1888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f413918-c92f-451d-5f38-08d5d0fe8c71
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 04:38 AM, Boris Ostrovsky wrote:
>
>
> On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> This is in preparation for adding support of DMA buffer
>> functionality: make map/unmap related code and structures, used
>> privately by gntdev, ready for dma-buf extension, which will re-use
>> these. Rename corresponding structures as those become non-private
>> to gntdev now.
>>
>> Signed-off-by: Oleksandr Andrushchenko 
>> <oleksandr_andrushchenko@epam.com>
>> ---
>>   drivers/xen/gntdev-common.h |  86 +++++++++++++++++++++++
>>   drivers/xen/gntdev.c        | 132 ++++++++++++------------------------
>>   2 files changed, 128 insertions(+), 90 deletions(-)
>>   create mode 100644 drivers/xen/gntdev-common.h
>>
>> diff --git a/drivers/xen/gntdev-common.h b/drivers/xen/gntdev-common.h
>> new file mode 100644
>> index 000000000000..7a9845a6bee9
>> --- /dev/null
>> +++ b/drivers/xen/gntdev-common.h
>> @@ -0,0 +1,86 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/*
>> + * Common functionality of grant device.
>> + *
>> + * Copyright (c) 2006-2007, D G Murray.
>> + *           (c) 2009 Gerd Hoffmann <kraxel@redhat.com>
>> + *           (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
>> + */
>> +
>> +#ifndef _GNTDEV_COMMON_H
>> +#define _GNTDEV_COMMON_H
>> +
>> +#include <linux/mm.h>
>> +#include <linux/mman.h>
>> +#include <linux/mmu_notifier.h>
>> +#include <linux/types.h>
>> +
>> +struct gntdev_priv {
>> +    /* maps with visible offsets in the file descriptor */
>> +    struct list_head maps;
>> +    /* maps that are not visible; will be freed on munmap.
>> +     * Only populated if populate_freeable_maps == 1 */
>
>
> Since you are touching this code please fix comment style.
>
I saw that while running checkpatch, but was not sure if I have to touch
those as they seemed to be not related to the change itself.
But I'll make sure all the comments are consistent.
>
>> +    struct list_head freeable_maps;
>> +    /* lock protects maps and freeable_maps */
>> +    struct mutex lock;
>> +    struct mm_struct *mm;
>> +    struct mmu_notifier mn;
>> +
>> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>> +    /* Device for which DMA memory is allocated. */
>> +    struct device *dma_dev;
>> +#endif
>> +};
>
>
> With that fixed,
>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>
Thank you,
Oleksandr
