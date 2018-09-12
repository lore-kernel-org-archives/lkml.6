Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2BAC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEFC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z94avC1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEFC20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeILLzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:55:35 -0400
Received: from mail-eopbgr700041.outbound.protection.outlook.com ([40.107.70.41]:31184
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbeILLze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9xeblsTpncEBbVDlyFl37y6Jizd4p72TgHTBfD5jSM=;
 b=z94avC1sQ9jXWWv9fyFa4kgoYUCJEQNzNL68wToOzQg33v4VZS1pOKEpfymdZ/mCLQUENiD1K9+N81H7uiMKVN5Xyu1xI1+pUeonnstoZYf/yOwaL4hONFqz1PH+KXUxdCwySR4PFsVOV6ZeCXsPD4s4d2BaW6a6TGDmziBaiqo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiandi.An@amd.com; 
Received: from [10.236.18.153] (165.204.77.1) by
 MWHPR1201MB2541.namprd12.prod.outlook.com (2603:10b6:300:e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Wed, 12 Sep
 2018 06:52:24 +0000
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
To:     Dave Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        virtio-dev@lists.oasis-open.org, Dave Airlie <airlied@linux.ie>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180829122026.27012-1-kraxel@redhat.com>
 <20180829122026.27012-3-kraxel@redhat.com>
 <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
From:   Jiandi An <jiandi@amd.com>
Message-ID: <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
Date:   Wed, 12 Sep 2018 01:52:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:805:16::18) To MWHPR1201MB2541.namprd12.prod.outlook.com
 (2603:10b6:300:e0::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd361441-fd97-49e7-6bfc-08d6187c4c0d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB2541;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2541;3:7chuoq1DOiq7GedSjSWQJGkbeRIMAvW0yK2fvBrQFC9n752/GsnAKDlDHi4UOlPpJ0/0vjJQWIxundTtVtMCsI1zckr5aOip4vOC6u5QqQftTbLLOYg5J3aNAU05CUN817rowVQLHjad5Kaa6gZmu3199kKxKcgkhU/FV9fV7mLepACiu20lyB4+xA3rnN0rqBWzMhA73mTKoJUezmDbph2T560hISsEiMnpbim80xdNYiXFOcOXxnT+H1gY48i+;25:M319VgfjcXg+oU7ajYCrRGKvYWTKvlShs+rxQ+gDylwW29rpSiv/lOUI2yilEbIlG1Oy4NRV0zC4bQsvQAff4qbEA2NbC52Z83GTSDBdD4grakJvPqC0+47eBjHCERsWcilvhce1TWEFj+xFodqdCaFJVRJhpZN1Jp+fA3rOF4Wb5y5P98Su/H7VnLppM4UMHF+r6rqxN3Ua1lP1LxTiPv68yLK8DAsP4fm5UdJeEuMcv+d5kNrMCgaICln/5th67jDVeAHGixsPg7hmCp1hwnp86iDvq+apBDMZXyj197uoHqWm478Zidi68zvIyjzX2GhHN3bJamrLYIIxUundXQ==;31:pzn+k8n6ys29tqrxrGKW7bMATsNFDRjMBKaruZxysAORFa29vQKVw6zqmZizKfpp6Ht+k5L9uHPVEBEHg9HuM9xlTB7uq9KzPVw9kuhE/TMX+1NiQ0vNYjurhicvlXSH07SejQ92PuCH5tefuUO4DhiJaMJmUMxJ3bMAx4AzEdwVS0iNTVf2QkgAXBtQ5mlq3mI9ktkzgE7RArXZkM+14odePMjhmTBaEe6cGYb0kqk=
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2541:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2541;20:d76fb6zlBS85P8DFf3RxNTizC5RtwyZsMc/rCj0gyocj71/EGPxnWrjHpl8Z4IRJb46nxEWR83Hu1KFSKkO3k6V/tQwHN5m3DQRAlpvoESbaBW4IPWqeIEwz6Vv1UF+Ad1D1Z9TtSboo4OYa+mvd3poQxkHNY2xp/7CUXqEtIMjul5PfTJgDAUntEavoDsKBIDgXHVcLFumuPVvUZuCm5wjOBnPbNlkKvEFWKR0NnX0sFF0JCtOmlm4d7JSgfVfnML/RzqAdsh7mFgOUYlZtz1PFAME35hIC852BcddqoDxOCi7E6x3i2yNm3dkiDq9sybybh8j6lr07VfZs9GM6U4SN4XibNKrL6RumRTba4Gzpx/VRl4rMEd5zphaabl1r6/TPaDQTq7wxz8UB9/RJ5JE+r8V97NzJUjQuHsET/uSZAyLI0WEaki8ChlQt/tTgTqgGyWbkJhoDtE/ld4muo5ih+uX6VTmDJbjBqLN7NALlThfygGlLtE+t0k7Li5Qa;4:FgiczSyrePzwybqx0uy3LrgK5EsJVyjU1v+CE7mHP5jWP/f3ovubRjVJzaxhKYsLpZG/CHNqYLGwU3BwJnrmGLyHso70/Qf1Y7Tr+MZWlgeDfuBIzgKb4FGto5ylOqFglRnGI02KouIOqBa02GNzYI13rk619G6EAzNWM2VAtrXLh79vekV1l4RmjLsYIV80TK6FdyLJzuTckAhcqLEVUfELpXixIOTw8HR8jeZZDvEgXi7xNTZxbT+ZmfeU0TmuACkY2vjeu/DGfi+JGyTf8Rf+9XkvBBLUCMNt+aL34ys9q/NYFmZ8giHVAj7layqcb+HEVsEEX4Xz2WQqr+entw==
X-Microsoft-Antispam-PRVS: <MWHPR1201MB254113577AA9BA6A868F6C2AFD1B0@MWHPR1201MB2541.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:MWHPR1201MB2541;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2541;
X-Forefront-PRVS: 07935ACF08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(376002)(396003)(39860400002)(346002)(366004)(189003)(252514010)(199004)(478600001)(6246003)(2486003)(386003)(110136005)(52146003)(16526019)(50466002)(23676004)(8676002)(14444005)(5024004)(65826007)(68736007)(6116002)(105586002)(6666003)(31686004)(3846002)(966005)(5660300001)(58126008)(486006)(97736004)(230700001)(229853002)(66066001)(65956001)(7736002)(2616005)(476003)(956004)(8936002)(305945005)(47776003)(446003)(106356001)(25786009)(64126003)(6486002)(81156014)(4326008)(72206003)(81166006)(65806001)(53936002)(2906002)(31696002)(36756003)(39060400002)(26005)(16576012)(76176011)(54906003)(6306002)(186003)(53546011)(11346002)(77096007)(52116002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2541;H:[10.236.18.153];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyMDFNQjI1NDE7MjM6NmQ1ZFhlQndwRWFKbExOckpNY0w3UkRn?=
 =?utf-8?B?VU0vN1U0VWVQdjFJQ2F6NlBTckVBUGw2UnJ3K3RxME5BeUFncVdCWjBRL2ZK?=
 =?utf-8?B?SEhPRFlGTHQrV2RHZEpoc1Y1NGNBOU5ISnBlaGlNdnhTUGc4VzhwZGNKaGs1?=
 =?utf-8?B?L0FndjRkaktqcTlsajg2dCtTMExNKzdmWksxdWtnWmFRVmxyekQ4aDFicTZj?=
 =?utf-8?B?MW0xMVFaTzBnWFlpNUdNYWpkRlRuclhvNHduaW4rQ2gxV09EMjVyek5lNFdJ?=
 =?utf-8?B?T2daa2VVRFQ4ZEdKYVcwQjNaRlB2bmZIUVlUZ3lPVVdhUDQ1UFA1NUx5Q2NQ?=
 =?utf-8?B?bEc1UFFmVVNNUTZLaDl4UGlyY25PTFd5TFMrQlpuRGJwZytzcnBUZ1VtM0NJ?=
 =?utf-8?B?dWgvS2x6ZFQ1ejdZeEQ2enV2VEs5K3pvN0wvWFJ5a1E3WTNqa3cyNFN4UHdh?=
 =?utf-8?B?NG1IaVdDdS8xQUttVmFka2VuQzhoR3NpbjYrSzJSV1ZLUjZvei93d3VFa1NQ?=
 =?utf-8?B?aXFwdGpIcFZoSlJ5UDJVWHlwTVFFbzcyaVExWVV3V1FQZnJnN3NSdjRwTXpt?=
 =?utf-8?B?V09LZlQ0ZTdZRllqK1RnVTFUSzN6ZS9PMVAwYTFLT3cvQVoxZU5kbnJFMDlR?=
 =?utf-8?B?QkVHM0VPUGFmYXl4dmlvUmFycnNQcUNrdzMyKzdWTlRBVUZNUCt6b2tyWWpw?=
 =?utf-8?B?YXliV2kwZlA5dGJ2TDFNT2JhckhDOURGNGI1M0pyaGptWDBnWGVtQTZCNVo5?=
 =?utf-8?B?UERyaHltWmlreW9MMkZKd01ucUlyVlZNM01wamROT2FiaUh4VDl1SGdqZGFI?=
 =?utf-8?B?MkV0Z2hyWnVaY2kvdzlFdEh0clZhVm40ZEJJU2tTRjU1ekgxNnd0MXYyeWFR?=
 =?utf-8?B?ejdhQUltMTZ2R05LMTJxSXV2UUZsVElVV3ZqN0dBM0cwR0VQRzhDWjJhRXhz?=
 =?utf-8?B?TWlaeGVJSitRNnhXbi9yMThuY20vWXhCTUZYMThuWUVtVHpFYmtmc0pTQ2pQ?=
 =?utf-8?B?YlkreHovQWFCdUNLU2E5TWdIZkRBaXdoYytlVkU4aVN5WXhORnZia3JNRG5W?=
 =?utf-8?B?am00TXVvTWw2dFAxZElHbG9pQ3ZvNXAxNktXUVUxRmpFeHdhV0F1UjhsaDB2?=
 =?utf-8?B?cFoyd3d6SVMwbU9sdVVITzBLZzV5TUxjUTMydGdnMlJ6RWJ2SlBBNmtLTVdP?=
 =?utf-8?B?K05uYXBDTlJIcVEzbWJzUlhQbnNsd0VBZE05SE1Tbmk5ck42NGhxSU81cS84?=
 =?utf-8?B?T3hidzFqTmhzOFlSS0cvSEgzMUs2VTFTQ3kwK3AraVJlWUZmMG16eGNBSkc5?=
 =?utf-8?B?ZEhGNmprRHMvSTFwcEtXcUw2MGRDQmN0OGI4TURFNUxQajdaRXNSSGlrdDRi?=
 =?utf-8?B?RlBCSHdJMkJDMHRjRXBYRnVOVm1qR3FJb0pvQ3pVY29xS2dIREtoNytYQnF2?=
 =?utf-8?B?U3NOOWZuTVlyK2JZMncxdWF1Q1cwWVN3SUZYNWpNRlA4QTBIRjRNNjN4N0hl?=
 =?utf-8?B?NUxRT3ZKSUtubUgvT2djeFRBaStpaUFpcjVXcEN2Rnl3SUY2K2RWdlp5UmhP?=
 =?utf-8?B?WUxIMXJPZDQvbmoxK2NmbEFGdmRZeEFvZkFJbTR6QVRQNytBcHBmYUxRd21a?=
 =?utf-8?B?NXp2d0p3dGI2Um5GczZQaTZaQmJldzhYMGpORVVVTFVFc3BBNWNCWEZCemp0?=
 =?utf-8?B?TGQ5ZzJreVY3MEY3MW9WRmpCSGlXZGd5UERHWEltU3psSjFhbmoyaWpwY2VK?=
 =?utf-8?B?cmJnQ0xabmxuRmc3TXUzcUdhSWdXKzZ6aFNoSEdsdTVKekxOcW9xZ3B5RGlY?=
 =?utf-8?B?Q3ZyMjFPV0NnRkp5ZEIvOVBWQ1ZCWUxWUk1SRlg5ZEFySC8rdHVDclcrL0dy?=
 =?utf-8?B?djdVUktZV0pWRWVLWkpOV0pId0ZSVUZ0YmRESTJRcExRZC9PUEwyUnJqdkow?=
 =?utf-8?B?WHBnSVFMUjNiUVZIR0MxRVhFQkpaQnFmWjgwTzZJcnNFMlBDbURBZlJ0cWE2?=
 =?utf-8?B?WDBzMDJYY3A4NmdSTUdIZTVNcCtBTHZ4dDhJL2l6d3lGcGs4WXpIZFJZQzlM?=
 =?utf-8?B?WjNKWEc4aXVNSGE5TUVDYzBBaHdxK2ZYV1VFWEVWdVFYa3VrcXJuODB0VGRN?=
 =?utf-8?B?VUQwQT09?=
X-Microsoft-Antispam-Message-Info: KEkx090n78SSg84BXf/PPqDcDJd/xYLqJk279WMK0EYzlhqZy6PbjqPpwpkBPcsrF45NR5eLrKn2WRLn4Xr5QgELh+YxYlQoZ5Mkl0PCdH/e1tiUxPnTjpy8NL42CnMlvYF2SBu6OB3Xmiocd256G7kR0RPxOf2Q0Y/MRN76OJPWlwMMLDUKVibtFO5tWMJgHoxfhvoHs6uCi8pE7VZtj7R8KZp6k398sqHjknf51fvagHxN9vHBrj6FAsme2nao3mekaX5quMAzt2qVF8mfi38ewvmbY/WhY4nP4vJnTjA9F9bXap8emAr6U+ycJC+2zEZxC30urkWpCPgDlRWfKKf24ugXxsGE0akUnLefnZU=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2541;6:pKmSbBPPrShqA4w9cY2uT2K788Pum2N+Z2C575JGDCvwYYSLTyh7IBBradz7XRJ3RVlrjob6Uiccb5xmEfscfW5bMkXhJqt6HFcycRNh0Y3xwP9/wEuo41yQ3i/+SFjarZ29jhbtR6YRWB/a1u/x7PfmOlBYMdyDUT4epqYV1NhABOu5NgJ8iNZ3olA1mBMFlZ+kZi7ipeW2WhFeCTh5erLxrqn2xK4Z4b962gerXqVf6cmAvvFz1ArTFHI1jCuXZ/ZvBpp4FHJwNmM/sERvtCoWgyWsV1XOTJ/h49hoQnFBkV5hJv1w80Xf99HqpB9/hfb/9d903jk4xVJ23HoFSHmnibNKOR4rC9iYaGWQbKuDUSLJ3L89tmAbbpFqtDtrpmbg2/+ockJfh0UtGD2FDWKBdGHDKDlUu67c3osEmQeKCgjMRWaKmPFOJbEoXhXHKbofstJYH35F0yXTyh7y8w==;5:wQr+1svkuSjABRwWgtiBa/KvlUDiIsT5lFVqnX6+W5rFUM7LyDEMryZG4fgW20IwriuiKf98MpqEOu47ZjEk5+tbRzx/62/1W5NFoC6XjdGG7KnKEKGWfbD49wRpQx5I6qdoI1yaEWE0GiqqGl9+pPPyHfP6JJhP3QDSusN780U=;7:C8N6BUor/s07AbwHTHnpbqBRNysQJXJ8RphuEzuEJ5SuaQA/mzxLk6aMdv8rKtMVGgfyqTmHjxqH4+CZWlNBm2o6PCcleEq88LzEWu7QkwkK5oh5QQWvQ3dBwtxNeK8ZP2yssT+D/TDSWL5UtcEG0MT2Z0MbPO1xbQ+jHHsaF+HHPz1SeR+UJrsuWqLQ0wU0IGPs3JE6ttyfRSeELB5tz3C8mhb6G61iRjKFDLkb75gTQdVS6UrQlc4k4cLFKoGH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2541;20:AufHyzmEWgqcVrG/0EW5+pLEQYiNYCKA3SrCHgnW82GH7ez9dsrKgsZgwkajdrJvS+92y2/s8tbTfCmwkvF+sasJw4BiEdTvv93/BUoaYZGKaWbq2KLlHaT2yu1kD6Ugyz6cX/c0Pu9hSE/PsIdu32RU6ab4LXwtDMbFhvW32UHY7n9FafWVFYJRrQQtRjJLY3aHk+vJRtVuiC7AYwSv3rQ3dMU+gM4wEhjSbsxhCx7DDw0hn2xMaln22qL4Mbu6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 06:52:24.4187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd361441-fd97-49e7-6bfc-08d6187c4c0d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2541
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I tested this with Gerd's qemu side fix with in the sirius/virtio-gpu-iommu
branch https://git.kraxel.org/cgit/qemu/commit/?h=sirius/virtio-gpu-iommu&id=86f9d30e4a44ca47f007e51ab5744f87e79fb83e

While this resolves the issue where iommu_platform attribute can be specified
for virtio-gpu device in qemu and the virtqueue vring goes through dma-api
swiotlb bounce buffer which is what we want for AMD SEV since DMA bounce
buffer is set as decrypted, I still observe the issue where for AMD SEV,
the guest graphical display is all garbage.  I see that the frame buffer
ttm-pages from guest go through dma map api in this patch, but it looks like
the other path where virtio_gpufb_create() calls virtio_gpu_vmap_fb() after
virtio_gpu_alloc_object() that creates the ttm->pages.

The virtio_gpu_vmap_fb() calls down ttm_bo_kmap and eventual vmap() to get
a guest virtual address.  It is in the PTE of this vmap mapping that I need
to call set_memory_decrypted() to get the graphical working in guest without
seeing garbage on the display.

virtio_gpu_alloc_object()
    virtio_gpu_object_create()
        sturct virtio_gpu_object bo kzalloc()
            ttm_bo_init()
            ...
                ttm_tt_create()
                    bo->ttm = bdev->driver->ttm_tt_create()
                        virtio_gpu_ttm_tt_create()
                        ...
                        ttm_tt_populate()
                            ttm_pool_populate()
                                ttm_get_pages(ttm->pages, ttm->num_pages)

virtio_gpu_vmap_fb()
    virtio_gpu_object_kmap(obj, NULL)
       ttm_bo_kmap
          ttm_mem_io_reserve()
             ttm_bo_kmap_ttm()
                vmap()
             struct virtio_gpu_object bo->vmap = 
ttm_kmap_obj_virtual(&bo->kmap, &is_iomem);


There is a separate userspace path for example when displace manager 
kicks in,
virtio_gpu_alloc_object() followed by virtio_gpu_object_attach() are 
called through
the ioctl virtio_gpu_resource_create_ioctl().  The mapping of the 
pages created in this
page are handled in the do_page_fault() path in ttm_bo_vm_ops's 
ttm_bo_vm_fault() handler.

do_page_fault()
    handle_mm_fault()
       __do_page_fault()
          ttm_bo_vm_fault()
             ttm_bo_reserve()
                __ttm_bo_reserve()
             ttm_mem_io_reserve_vm()
                ttm_mem_io_reserve()
                   bdev->driver->io_mem_reserve()
                      virtio_gpu_ttm_io_mem_reserve()
                         mem->bus.is_iomem = false
                         mem->mem_type == TTM_PL_TT

The prot for the page mapping here also needs fix to mark the it as decrypted.

With these two spot fixes and with this patch and the QEMU side fix, able to
boot guest with graphical display with AMD SEV without seeing garbage on the
display.

I attempted to fix it in the ttm layer and here is the discussion
https://lore.kernel.org/lkml/b44280d7-eb13-0996-71f5-3fbdeb466801@amd.com/

The ttm maintainer Christian is suggesting to map and set ttm->pages as decrypted
right after ttm->pages are allocated.

Just checking with you guys maybe there is a better way to handle this in
the virtio gpu layer instead of the common ttm layer.  Could you guys shine some
light on this?  Thanks.

- Jiandi

On 09/03/2018 06:50 PM, Dave Airlie wrote:
> For the series,
> 
> Reviewed-by: Dave Airlie <airlied@redhat.com>
> On Wed, 29 Aug 2018 at 22:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> Use the dma mapping api and properly add iommu mappings for
>> objects, unless virtio is in iommu quirk mode.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
>>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 46 +++++++++++++++++++++++++++++-------
>>  2 files changed, 38 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
>> index cbbff01077..ec9a38f995 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>> @@ -57,6 +57,7 @@ struct virtio_gpu_object {
>>         uint32_t hw_res_handle;
>>
>>         struct sg_table *pages;
>> +       uint32_t mapped;
>>         void *vmap;
>>         bool dumb;
>>         struct ttm_place                placement_code;
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> index af24e91267..bf631d32d4 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> @@ -424,7 +424,8 @@ void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
>>  }
>>
>>  static void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgdev,
>> -                                                 uint32_t resource_id)
>> +                                                 uint32_t resource_id,
>> +                                                 struct virtio_gpu_fence **fence)
>>  {
>>         struct virtio_gpu_resource_detach_backing *cmd_p;
>>         struct virtio_gpu_vbuffer *vbuf;
>> @@ -435,7 +436,7 @@ static void virtio_gpu_cmd_resource_inval_backing(struct virtio_gpu_device *vgde
>>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING);
>>         cmd_p->resource_id = cpu_to_le32(resource_id);
>>
>> -       virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
>> +       virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, &cmd_p->hdr, fence);
>>  }
>>
>>  void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
>> @@ -848,9 +849,10 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
>>                              uint32_t resource_id,
>>                              struct virtio_gpu_fence **fence)
>>  {
>> +       bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
>>         struct virtio_gpu_mem_entry *ents;
>>         struct scatterlist *sg;
>> -       int si;
>> +       int si, nents;
>>
>>         if (!obj->pages) {
>>                 int ret;
>> @@ -860,23 +862,33 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
>>                         return ret;
>>         }
>>
>> +       if (use_dma_api) {
>> +               obj->mapped = dma_map_sg(vgdev->vdev->dev.parent,
>> +                                        obj->pages->sgl, obj->pages->nents,
>> +                                        DMA_TO_DEVICE);
>> +               nents = obj->mapped;
>> +       } else {
>> +               nents = obj->pages->nents;
>> +       }
>> +
>>         /* gets freed when the ring has consumed it */
>> -       ents = kmalloc_array(obj->pages->nents,
>> -                            sizeof(struct virtio_gpu_mem_entry),
>> +       ents = kmalloc_array(nents, sizeof(struct virtio_gpu_mem_entry),
>>                              GFP_KERNEL);
>>         if (!ents) {
>>                 DRM_ERROR("failed to allocate ent list\n");
>>                 return -ENOMEM;
>>         }
>>
>> -       for_each_sg(obj->pages->sgl, sg, obj->pages->nents, si) {
>> -               ents[si].addr = cpu_to_le64(sg_phys(sg));
>> +       for_each_sg(obj->pages->sgl, sg, nents, si) {
>> +               ents[si].addr = cpu_to_le64(use_dma_api
>> +                                           ? sg_dma_address(sg)
>> +                                           : sg_phys(sg));
>>                 ents[si].length = cpu_to_le32(sg->length);
>>                 ents[si].padding = 0;
>>         }
>>
>>         virtio_gpu_cmd_resource_attach_backing(vgdev, resource_id,
>> -                                              ents, obj->pages->nents,
>> +                                              ents, nents,
>>                                                fence);
>>         obj->hw_res_handle = resource_id;
>>         return 0;
>> @@ -885,7 +897,23 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
>>  void virtio_gpu_object_detach(struct virtio_gpu_device *vgdev,
>>                               struct virtio_gpu_object *obj)
>>  {
>> -       virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle);
>> +       bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
>> +       struct virtio_gpu_fence *fence;
>> +
>> +       if (use_dma_api && obj->mapped) {
>> +               /* detach backing and wait for the host process it ... */
>> +               virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle, &fence);
>> +               dma_fence_wait(&fence->f, true);
>> +               dma_fence_put(&fence->f);
>> +
>> +               /* ... then tear down iommu mappings */
>> +               dma_unmap_sg(vgdev->vdev->dev.parent,
>> +                            obj->pages->sgl, obj->mapped,
>> +                            DMA_TO_DEVICE);
>> +               obj->mapped = 0;
>> +       } else {
>> +               virtio_gpu_cmd_resource_inval_backing(vgdev, obj->hw_res_handle, NULL);
>> +       }
>>  }
>>
>>  void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
>> --
>> 2.9.3
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
> 
> 
> 
