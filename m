Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79358C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1398620864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="J2TzUeww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1398620864
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932630AbeFRGRV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:17:21 -0400
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:64224
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754458AbeFRGRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xIdGgIRMRCiRIwCAwAG285CwxFWjB7SYnqH9jKlSew=;
 b=J2TzUewwqsfGd5pojOdbAyorbmG0lilD+VFw7+apoYLMB3UvWAyo19XqFk6beJ2vn59XAZkb6dzqwiGB/FzYhqCEloFDDcxA0KhdeiPuqEBPzD4cRtVgE2zXtIKt5oEE61kXGOFdxvAq3//qYWYm0p+H/ysE5t05sXBX4yJTjxo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 VI1PR0302MB3213.eurprd03.prod.outlook.com (2603:10a6:803:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Mon, 18 Jun
 2018 06:17:13 +0000
Subject: Re: [PATCH v4 5/9] xen/gntdev: Allow mappings for DMA buffers
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        konrad.wilk@oracle.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com, Sumit Semwal <sumit.semwal@linaro.org>
Cc:     daniel.vetter@intel.com
References: <20180615062753.9229-1-andr2000@gmail.com>
 <20180615062753.9229-6-andr2000@gmail.com>
 <e892748a-c268-9622-e568-4c361366bce1@epam.com>
 <b9c3f740-dea1-638b-49d9-60cf5880619d@suse.com>
 <38f10738-63b6-89ce-07a8-7791b2a7e4dc@epam.com>
 <03e078b0-62a3-5d11-987b-7472f841c44d@oracle.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <b78ab715-f117-77d3-d54e-8a078b8319e7@epam.com>
Date:   Mon, 18 Jun 2018 09:17:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <03e078b0-62a3-5d11-987b-7472f841c44d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM5PR0701CA0009.eurprd07.prod.outlook.com
 (2603:10a6:203:51::19) To VI1PR0302MB3213.eurprd03.prod.outlook.com
 (2603:10a6:803:18::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5defbc8d-7d1a-470f-8f81-08d5d4e32240
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3213;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;3:EKnDje0YN6NgcAY3gNXewq4fW7zjR1HNiqR4qXpjCs5gM5snObitJlJZxnd7D6mLlIhrokvNpm2mVQIrdf8MiazVWG/dx03DSS1RBxYaZze3MYfLHqq4nTg/F4oUi/rXSzNGxNiec2LS5P/fremyowd7xfD1ZGivIC/iEkTSchPYhSTJbVQvmhIGxXlqMQe2FcGl7PRm4QlqFByuNBkHOqyUbLZNC9HkgKyJ3o5LbqtLK3ci1j0zndnkw6YS9Krx;25:M3qAV7uCNhNfHSW3uZgjcv2mdGySk9BichTxHK7Mb3fTt8FBrMcjX6zCSNCsltvImNb6Qw66PJSOtgtQ+zDCa+RJMKNXty+wgVbevjtD3rcI2oZFBDde5MxdXqAlg37uxnDBaeCv0fpI2DVQga7wjUdcPgxaBiOMrfz2aYkB9Ob9jgLN5WsWzuEgpoWkMeXPA5oPyFeH1CICCeBklb6HtLoQcXpU3JLVELXvwUqZj1XsqRaG3HP/45vQlYhbTVvR94I+XZVFdBRFzXVvZAgzLBZ69BtgSmqmAYT+JiaaTHRdpPj6GmDuFGRpuJhJzYfhx7Oa5xM8qGvMdMWIupDHmg==;31:UAInuReujQjTu3kMcebrnbZMxYR3kLT6lcLE+pPPxA/DEk/HgHn+AgPPlpFldFwCUJ6B94vjgYxwuOe+X/I3eE6njyYLNVo1aKLvNNMZFCtYeWf8iHrGIEFk6XkhlJOHw1liidzVYi1mj/fiVZIZQkimIIltMhKo7LSS5sm5XYo/Gvo9dHQaoAE6myL2Gf3lZ+m8O2XzeYFxpqj0eGSqRJGmTbmpqKoU0UAZ5xQjX6A=
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3213:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;20:2DYvWqQKiffRtEQW5H9Vdnm3Boy4sVOyiewZJ2GhPGHfTRN9ccz2gO74F+cMhxE/LoZKObZT4whcsfeXQ07fUtXdeMqv7W7CCpDOYa6j7OMHrhVTF8DKYOzmgIp8IePOBTyAeWeRncEj1LrzKj9QEv4cw4ryt5rxkynvwfUAFUCZzAf+UeD82uhlL+LDoDW681Da6EOmobigUjr0vqw2PaNeH+ffzYLJlGK/TUcSV4Wk2wK1rOkzPEZjL3z8P2oD7rOqD3396ZX2Arx8hULghxmxgNf5Xg+n5iK5Z10+7j6MNLceKjrgKrUGY/fw2+Y4A5P8xbWO9obiJGBQn0uW68xM5L1rJ31memVaqJylxvCnzHf6pWlxfpt1f7BNF1Pe2pvEtWQ3HPzvKPaTBW7EU7BKVgKPjw3/fB2OjzG656rNU0V7E+e4izqnBo8peaB8+IlMOycbslRlaeJ+LQH5UsnlLtnoavPiHudKavLTxMpDpCyxOH/CsW1guNz8xys3;4:HsZP/kWM386j9HCwpOZD8xnEUVAvZwbvJYAL/pIjVFcwQiPlgJshTKgRLFYWbTPfrpAm9eWRbU09ewaYYsUdovGkC6LydntnK0v94v1NJd+RjVyAGswgChfjW1C2z61zCdkesFPpDJYiSLdjWUwTwFiK2AwQbTXgsbE0e5TWsJWFSlLw1P1ElDA7rIB0egqOLkMoUfktqF4CpUAwaDnWLB2yBuc/TPLZmjHYUO8SFzjZtmqveab3GNURaXrQGznOcs+zE3GoJjUzli5zvXocnA==
X-Microsoft-Antispam-PRVS: <VI1PR0302MB3213B7E39D0FD8E9BA01B6C9E7710@VI1PR0302MB3213.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0302MB3213;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3213;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(199004)(189003)(230700001)(6116002)(3846002)(478600001)(68736007)(6246003)(8676002)(36756003)(6486002)(316002)(16576012)(58126008)(72206003)(229853002)(81156014)(65806001)(47776003)(110136005)(5660300001)(65956001)(81166006)(80792005)(97736004)(93886005)(25786009)(4326008)(66066001)(6666003)(39060400002)(8936002)(53936002)(65826007)(31696002)(2906002)(26005)(31686004)(77096007)(7736002)(5890100001)(186003)(446003)(16526019)(7416002)(52146003)(2486003)(105586002)(23676004)(52116002)(50466002)(305945005)(67846002)(64126003)(386003)(476003)(486006)(55236004)(2616005)(53546011)(76176011)(106356001)(956004)(11346002)(86362001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3213;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDJNQjMyMTM7MjM6MkZhTjlhZ1o1WVRiRkdXeTdkSHA4ZTcx?=
 =?utf-8?B?d1J0T1dGcGFxTldmMnN3eFpJS1NMeVc3Zkk0Qm1vRE5IUWYySjAvbUZoYTR0?=
 =?utf-8?B?RHZRT050dlNkVDd0cU0xOUkvYmxuM004cVV6bEF3NXVYZG9Nc3d4djV4VEsz?=
 =?utf-8?B?dU5IRENQUVZkYWtML1JraTZSVnRzVk50bmo0RkpYSzBqQjVjQS9JYzlrMW9R?=
 =?utf-8?B?VXVDTlRJOTV3azZNVnFuUGpJKzZHb0U2bGFTZEpjYlBuUnNSYllVRCtSMHpI?=
 =?utf-8?B?RmlhUWFPS2FYemZJRWVqMWUwMWZUU3BOU1N6eHMzMzNLaFpTMkN3SUhWWHRu?=
 =?utf-8?B?eDJqcmNrdnpZUWNseUcwdFdOc3ZCaUxYRUhMcnpNeHRzVEFJZWhCNWZ6NmZt?=
 =?utf-8?B?NENPdnE5a2dzeVpRU3VLMFBoUVQybjJEb0xWKys0Rm1welZKL3oybU5Edjhq?=
 =?utf-8?B?eTBrc3ZMV0ROeVJaN3pkSEhtbGNWL3dLZlZRUTRXdk5zUjlTUFBkWWdEc201?=
 =?utf-8?B?bEpQbDhUczg4eDNpSzcvM1JoWnhxSzBPUmVhRy9iVVJsbk93eDV1VFZDQnE5?=
 =?utf-8?B?aTlnTHlFZ3h1TTdzRDIzZGN2K2V1bVpLVE8yWWVsWjJWaithNTdqUUFGWW1L?=
 =?utf-8?B?eGRVOTJDZkI3SW5QWlVGSEZrNk5sY0dnUUlpRFpEZXp4YTlSSkJxVy9QZWI3?=
 =?utf-8?B?em5Vc2IzRXBDNUZnL3VFeGt0V290b2ttTnIzV0hDTUd4ZURnNzQxZFp2STZP?=
 =?utf-8?B?WHJLbFpvVHlyNHlvSGRSM3hldFU0K0ZxQXdUeFNZUE83SENYemJyS1RYWXow?=
 =?utf-8?B?RGpuQ292a1k4L2U2ckZPTnhEbGZRYXhUZzJIL2JDc1VZR1d2YThFN3BpU1FL?=
 =?utf-8?B?WCtiaFpkUUJhajc3K0Vta3ROT004TUVSQWYyWVJ5OUNXKzhMN0hHNnI0WE8w?=
 =?utf-8?B?cmVhRzFxYUVTb0tsUGZ6K0ZKZ1N1NHRDdWN6dGNvWnk1eWkyRUVEWDRvRTJa?=
 =?utf-8?B?S3NPcW5vUTNKaEQwTTlyb1Q5WEdobVVpZDluMUhkUDhmUTZTL3V4U3dhQ3dj?=
 =?utf-8?B?YzJoVzExL1U0ZDJIVkc2cjl6cm84b2duT0JMYXFXTkVZNW4yMDd3aGk4blVa?=
 =?utf-8?B?bldJbUgwcjkxUXpxeHdkc0ZCS1pnZm5MSEpRU29yM0hQZWM1TVBhVmpHdjgw?=
 =?utf-8?B?ckxEaUNyeWtjVE1vVFZCd0s1NC9XRjdZNGp1azZrTHJ6cWdMNWt5cUNFUERS?=
 =?utf-8?B?N0UwMDE2bnQweFpoNVA1Yy81TGdWR2laRjI1SkxYZ0JpbkFKNmk5ZHpwRWdF?=
 =?utf-8?B?K1VGWjFZVWQ0dGU2OTdHN04zSjlPR0ZabXYyY2t1ODJ5OWlqZWFkUWpyaloz?=
 =?utf-8?B?S0JXTWxManArdmVOc3RlK2ZKbTkrd0prOXFJcU1xZlE1MFJiSVUxRmFKTGhx?=
 =?utf-8?B?NFdFNXYveUszVzc4ckpKNXFHeUM0alNJZ0pFeVcxSHF6dDN5dm9YdHpVeEpZ?=
 =?utf-8?B?V2E3V3c1Qm5qTXZYTzlabGp1WklBaU1kSGRSc2p3dFhXeDFSYkZsbXJxYlpn?=
 =?utf-8?B?WGVsWTlhKzJ5OE1iQ0NTdWhGVW5JbzhHS3A2bmJZc3hGT1BTMzB0S1U4VGFp?=
 =?utf-8?B?TENrb0tlNHhvVWdDR09Ga09XSERDTzlFay9WdExaZTk3aTBsZ3hMd3pBR3U4?=
 =?utf-8?B?YS9TeHhqWktySUoxdUJNVGgxb2F1YjBsdVM0NkMxWmM2ckV1MEMzSFhLcm1D?=
 =?utf-8?B?bExaSk1OTmhxVHVVQTVDRkwxaW5wU3JuTGV4ZGpRV2l2QlJ2VEZnOVZQK3pt?=
 =?utf-8?B?aGxKVlMxdEhnZ2dRc3BXdTZOTUxrMjhKSU5MNkRtR01jV1pnZkN0cUtyTlZz?=
 =?utf-8?B?K2xWOUtlTGV0VlFEWTJobXorZTl2NEVhU2VnNDF5Zjl1VlowUFl2VFBZcTRy?=
 =?utf-8?B?bnFBeEdUUnljSGhHQWU0VklRS1V3SWpTbVFUSGc3ZllPb1Rvd0pQNktTcEFU?=
 =?utf-8?B?cXdJNDgxL2Z2UC8zdkpVU01wQTFUTlVEd3V2Uzk1a0htL0tyWWVzOURHVlY4?=
 =?utf-8?B?TENPRkNaQlFuaTQxOEovbnRoM2ZVSjUxTytwajBoeE1OVzJxdFBmY3M4SEJC?=
 =?utf-8?B?TVRFbndTWEMyVnZYNTl3d1dRVU03Z2pYNk10YVN6RllBek00ejAvYmowTyta?=
 =?utf-8?Q?0Rbx0Pwja8bpnOr9JRbt6+JklRTLkYAA0uFpjwMVpdzo=3D?=
X-Microsoft-Antispam-Message-Info: b60UxfOQvFHDLiPBv3pTXeS6KyZYAUG0vSdFURiAo+Tlt8CHoEie1krsJgHT5F4NbuBYDWsM2VI2SFd0vtxeaJy405mIiMmtrNtfZlJEDk7WE65GafnCaiaUBXV4trmf7XDPFxG4hA+IvWOt/wDRxz/ICPUc/jlCi9QP+AMqaVYCilkbAbw5P/dYIbeS6jesHO7cv88RMX8nKzTJVq0PBHQE5epiU6+bTEQK0dHSRhfjThnVuP7YLmRUlyj5YRWu58p8jJ4xjxnrMWQUpEoG3CEyc8nxoQxLNiZ7U7Z27oJ04bzjbwBs9oKkznhVZ3uMgWCDO4VOYQpxj2JpvbLKvg==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;6:eR168n4pu4LHP/+BciUTzWteeaxmiMkykyD5EZyaPalmCYlNNz72puauQJEVW1r5YbweFV/0AeCSuWDeq8BrbewIUagecM6zwugpwXhaZ25AB5cNdznymzvJl0YGzGtDXLY/RWOeubCXADs7RmrgLoLRNnSkBwaW0A7YnFHJXEAW3lzBK4MNNP7Kkwm6i52m2fQxGtGMJi84PD+GJXJv109mLPufBmrToaPcr1OdlzWgdC+RF7bLnZOnDDdkSboo0Ga3iinbsHPkgpsIOVPj8a7o2DenxaIeV8zr7ECuL1hWWyI/ZD/ZIj+tjrthLbxTa4m7SHng3Oc3/rHOjlmL0JwuL/d19OOAqqLw9pvtenN4TSEV6NCTGHjXJV6xULXsKmKCzrrPNOaw+Qtb64dEa7mZCD7CLr1oHkkGAYVnt4ZpB2z1xkytM8G0jWazj2yAppGxFaFlINAtPbfAQWyuUw==;5:8MviFP3rpJd4y+ikW9W/pKAWksFVwh6S9ESA0z5tnBqX4OTDHP+DHqhspUzifdurW3iCAt95U2OScgoqkgKAK2N9RmBXjOttuv2QJkH92rU88r+zpLJ4O8s3le3fCCuTQqSz/d1XVpaYtP/6Hwu5S9kRMu/h2ui5lqVLAdXxr9k=;24:3qGLxNJHnbspRlFE6dXCXfKuJB3Ed8ZMorME91uFAmlJkgaROnhfNsPieAfmOBnABdcmh2DfBY6kfkfsg0h5PJrc9GDWUsXlhF3t1ZLZaPc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;7:f5SwiPgMEHgVqs85/crDcL1UxQYShI56dRuWnd4rILInEYJUFcaouTpm6u28W4SJ+LBioYdb1zTuq+6eF8rAGCQ6SP6oN1hwMiT0w5d2Uu0bKQbkGoHo4xEhgglPlDDMAliZt/Ci4nDN1erJO1qtF6UYChuxBgcbMWHlDKufrdZL2iFYUMOef2ZUKdbyOYv0tfHrAHvySfH6G6mCkjvyi9EiX1fhTvBx3wefFcRlxvNSRV+HtgaG9eJj0cjT/vbl
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 06:17:13.0797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5defbc8d-7d1a-470f-8f81-08d5d4e32240
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/2018 12:07 AM, Boris Ostrovsky wrote:
> On 06/15/2018 02:50 AM, Oleksandr Andrushchenko wrote:
>> On 06/15/2018 09:46 AM, Juergen Gross wrote:
>>> On 15/06/18 08:32, Oleksandr Andrushchenko wrote:
>>>> Please note, that this will need a change (attached) while
>>>> applying to the mainline kernel because of API changes [1].
>>>>
>>>> Unfortunately, current Xen tip kernel tree is v4.17-rc5 based,
>>>> so I cannot make the change in this patch now.
>>> I don't see any chance this series could go into 4.18, as the merge
>>> window is just closing. So please post the patch based on current
>>> Linux master of torvalds/linux.git
>> Ok, I'll wait for any comments/r-b's and then rebase to
>> torvalds/linux.git and push v5?
> As I mentioned earlier, I would very much like at least a review of the
> new interfaces by someone more knowledgeable than me.
I am adding "DMA BUFFER SHARING FRAMEWORK" maintainer to the list.
Sumit, could please help reviewing this? The whole work here
is to add dma-buf to Xen's grant device driver.

Intel could probably also say couple of words as they also
might re-use this work.
>
>> BTW, is there any plan to rebase Xen tip kernel?
>
> It is typically rebased to rc5 or r6, at which point patches for the
> next merge window are applied.
>
> -borsi

