Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F11ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749F020989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IpKFhwLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749F020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeIXPrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:47:21 -0400
Received: from mail-eopbgr30103.outbound.protection.outlook.com ([40.107.3.103]:65344
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727497AbeIXPrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djM1e3ddDajlglH0sYY/29a1vVgNmlKYMRbcp4pJpS0=;
 b=IpKFhwLcrvmE2jO4PJnnxe8DZilKzZq6zJ9+FnyiqC0yWHZEDicrnORhRyFuwnywOfN/BE2MRrChxPE6MbSDzHZkClIeOvbGlhWHhqsYNO+/WxefqDje2RvG2oFU7jHWFFJMR8ojVAr95MEdfaE8Wkqym86aRfR+vtCa7Yo5hu0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 VI1PR08MB3263.eurprd08.prod.outlook.com (2603:10a6:803:3d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Mon, 24 Sep 2018 09:46:03 +0000
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To:     Ming Lei <ming.lei@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com>
 <20180923224206.GA13618@ming.t460p>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
Date:   Mon, 24 Sep 2018 12:46:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180923224206.GA13618@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0044.eurprd05.prod.outlook.com
 (2603:10a6:800:60::30) To VI1PR08MB3263.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 790bf0ad-6d17-4715-5a11-08d622028b96
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3263;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;3:qJhZY/sAq+Pftz8EzmsyDfcmdsVZ3FWsJdltQwpJ7yF3lDtmXH0GUkNz7a6J/6qcB5GRSZvSrzdBxmgKqsAY89ZhpdBnhB1vEMuyCmdlJWaGzc0mhSop9znB7q4KDI+ZXvcp6hV3sLnxVyTtYkqt4L2M6IEHWoKbmcdSoFmIwbagLDfpoHlG0B9RiVkdQRj4/M0JmNfqmQjvrRz0sLT/Pu85dGgDXFLkKM7cxN9RRImrLJE3qW1scgk5RK7A+I+K;25:QoKsL+uUYyjDtRu3dUktrN1t3I7dOdkyF1oQCdjnKFI+tAjpgZe4aTyQrkmPR/bm0LZJhyoFdlG5MpUdrG8NeYuP3oL9HXkLhuU7MLuPW5QZMPEe0S2QjlaWpIZ9jXmvRLe35sW7ckk2cm2sV4mWcw5YNKAYHLvjRrc7jBALKTpGaF/lXcZXD8XRXRw34lMVXMaELT2T23J17yvEuQnmalsPzP6kjM4PHgf1tqGPgZTCPWebv7BsCo5pQhS0zjCjxvx/By8eowbU8Yc2RsLbM6xJ8CxUj4yxlJvfTXrXphqAt+5ulB/FicqoBvUkoayC9xQGgRENRyWGaK8EEM4x/w==;31:gzCjaBb0VSqcKK27iJlfUhpNxNNyUWHnxV9xCzYY2/LlP/cM/Xj3NABcAaKrika1LfslbNZH6F3BbdyPRDGeFJh3ULFUvL8SQ5p23PO/O86qpFqM9Cl3F22nh4TWy0uBa4JlMhAV36S6/7L0j+NcAO0gNPKZ2ChC4J3hiQk+sCdU+cmhrayms8WkVEGngnJXGOVRP+9hbXiOklfh7G/kArHCzqHgNHRiqNRskSGfxFM=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3263:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;20:44t3u9NCOHTElJhWMd+YMgx3yoESb2s+F5vXoIbNXJ2IicLsdwI6m/M/p2b+ioDEEpwuNAZVfxvoAj5kCeCxvks+PYmHsXZPoFMAimI2CIEWBURecJadh2nBxaNVmsZ3zFnLSFmWpNSCwmiM3YO/f0JPO5DCSNItmxorJSu/KTOWKfBFkjKio1GvlQSZuJ6xK8ro0SLIJAPxYwcR9hTPcuG9VQnnsDhcAZSEQjFkNLJGW3YjJuZYuOmFGveex2FRYUwF8HfKtTyMsZsPrHZKgCcAaSZhUlXXTXgBCRt2QqS+fHOt59ZuiWcSl1rGPYTvPYpL520P3JpxwpgNbWGYTY22TwOor5KUu3nbis9kn6RjZ36Jy+aWT79xE5S9cnWbfUma12ls+KUgUFeQidgHmbcHXrkSkV5vEMAT5pRQ3UaBUujSFpG4y6zq1fdApyFryJc0+eo7vc4oH+VjRrFvX6h8ksOQmfaY7xss1ifgCzyduFmX5LwilLhHt+cmhIQL;4:FIA6EV6ofUGj1X15yJnFtwqPIRyrRdymGClLU6IIeB7UDAo6m9HEd2zMg++9mEPtO/UDeRhO+s/ZXO4u0LCuRpLETfXdnCPM2QHvxaIzHpPQQkNNqTN5D4WuQamdPi7jpZUgIxdUl8w+Abk/LJob8PykU9By2IZBcNdx4dweTXTI/9jmQkSG2I7xIiHw6UfgdhU/R55UiaLEaj77BByuytA9s7auP5JpFQ+mbas8LrDZ2wXPipejzvfsI6cYA2FbRogrK1QmYUwqPtvMTYJHiQ==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3263BABF9EC90036D5486C2BB0170@VI1PR08MB3263.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149066)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR08MB3263;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3263;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(366004)(39840400004)(396003)(346002)(376002)(199004)(189003)(186003)(77096007)(16526019)(81156014)(81166006)(50466002)(93886005)(8676002)(316002)(53546011)(386003)(8936002)(478600001)(2486003)(23676004)(52146003)(52116002)(68736007)(86362001)(26005)(36756003)(2616005)(956004)(476003)(6486002)(97736004)(486006)(16576012)(229853002)(105586002)(11346002)(54906003)(110136005)(58126008)(230700001)(106356001)(31686004)(76176011)(47776003)(65956001)(66066001)(31696002)(53936002)(4326008)(3846002)(65806001)(6116002)(6246003)(39060400002)(25786009)(2906002)(5660300001)(446003)(7736002)(6666003)(65826007)(305945005)(7416002)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3263;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjYzOzIzOkMyL2t4SzFlQTdIeHJTQXduWkFRWXF5Wm4y?=
 =?utf-8?B?aWxSOHVLOHIzV3ZiNmN1eTRDOUNmZDdZVFV5YWtmaTNJTWI3c2grOVQ4MFB4?=
 =?utf-8?B?Z1YzemZiOG8vUVVRRFpzdDh1Y0RIanNEWkNYVklLYm9LdldtcGJ4WkhxbjJH?=
 =?utf-8?B?eTJ0MkJEOU9nUEs3aGFlOGtrQm8vZW5ISXdsV3lwd3VjdGt2OENUaDJxVzJj?=
 =?utf-8?B?ejVCdUpaTk02SEdKaFdhQXU1b1Vrd241eFg0TUlKVHREZFBWM0VZSDQzUi94?=
 =?utf-8?B?NVJxeVd3Y25ZYSswekp5RzlweHJoemRkdGFDeUpWanArdmF1MHl4RjRHcjUx?=
 =?utf-8?B?OWVOUERqNHpTdVFJbytrd0pUeTZlZllCaGc5Z3BmOHhTRzRsZ0R5bGRoMjAy?=
 =?utf-8?B?OFlCZmlJUUExQmdZNFRzTzdqZ1RaVUlpbXM3YnV0UWNxVXZhMDhSNVhGT3hM?=
 =?utf-8?B?b2JFT1VZWUpJYnM4WndRVDlPODk4dGtUN2FRV1VBTUFnUzZ6NENvbGd2TU1l?=
 =?utf-8?B?eUJZUzlRL002ck5mbzUxQVVHQWh6dEhpSDNXSkpucHRpYTFSYkdFb0hDazZV?=
 =?utf-8?B?WDVGc1BtN01XSVpJd3pWb1hSZk5pYi9udU1Eb0hlUmFaOE5tNy9sUXp2MnA4?=
 =?utf-8?B?QUpjWXZ5bFBVU3U5RHIyUlNnUkNSem0xWnY5MG1KNFU3R2lCYnB5Ukp3NTlK?=
 =?utf-8?B?NU5kZ0hCSnQ5M1FDOW1nU2pBdnRQUG81VVZVYWoyamJoSGU3ZHVJa2NWZnJN?=
 =?utf-8?B?SVNyZXhQQmpJZ2ZCaEFCY250OEtBRW1KcFdRSHlvbGYwRk5RTm5oTnlvbEUy?=
 =?utf-8?B?WGZvRUR5UlZtRGp3R0JNeGx6UUFLU2k3UmlKaXJwVk1UOVNOQzgvT0VUY0NK?=
 =?utf-8?B?dXRJMElYMHFwK1ozTWdSZ0JyM3BnOU52NHVvL1V6WldUMGgzTEREM1NtZXhx?=
 =?utf-8?B?RVpXNzhSSU03MGkrWm1acHA5b2NyZHR1QjFjdDlDMkhUbVBVRndEN1lVTnRX?=
 =?utf-8?B?aS8zU2lzZFRoTHhycGJNM0Z4T2luM1dLSVhpUDNmVzJVYjQ3ZEN2dDF4ek9O?=
 =?utf-8?B?bytpTXZ3Y0R2dVIySVBrZkhRcU9aYW5WaEFGYnJydlJPcGZhUGlqaFVLaHBW?=
 =?utf-8?B?b3I3aEZWdjJSUGZHYllSMVY3NjRIZ1h0Yk9YQ1dIYW9QWGE3OGdYeHdDSFpK?=
 =?utf-8?B?bzVlRnpvTUJyOWF6bktUUXh5SmtDcUd6Vm9NbFBFQ1NHd3c4NHg5QUY1dFZJ?=
 =?utf-8?B?bmVzTUJidkcySXZDaG9CbHlQNFE4aUtqTXNvYURhSUUyVEhOZkttcGQzSXRx?=
 =?utf-8?B?c2VMaXovWDFTRXhwenF1bzkvNmZQOXQ5eHNucHFvbXNTLytHRzd2MzArMUc3?=
 =?utf-8?B?Nk5aZkoxNVpBemhteXdrVzV2U2pUTEl1cFFMMEVYNjBTaTJicTZSdnNRdnlp?=
 =?utf-8?B?WmlyVlFqL2p3dnJmdEFuV3FpK0dNbjdxVzdFdnlXb3UraGZjVFZFcHlrZ0NO?=
 =?utf-8?B?S3VDVElWZFJOYm1manYyMlhpZExEWnVQYnozd0VhM3VKV04yMUQxbUNyV1J1?=
 =?utf-8?B?elk3ZWQwbjBMbjNRSHAwOXZLWldIdEtxcGVzbldtWFl4YmNrUElHS0FicmJM?=
 =?utf-8?B?V3BydjJEbzAwMWg1eWRicGZvTWIxdnBCMjZ5Q0hnWVpVQjUvanhMblhLSnFS?=
 =?utf-8?B?bnlnRXkyNWd2ZmU2SlVJdjlhNjdPMEI0L1BTajc5ajJuUlhTeUhvWkJ4Rlh2?=
 =?utf-8?B?WHRIbzNUQmRvR1pJRkk5dTZkMXIwN1JGZTM1bU1tQjlsVTd4bVZsV05pMFlm?=
 =?utf-8?B?cmZmL2xNK0VWdllyVWg0ZDBsYTIvekJLbkgrQ1JYSzdVVjduMmlVelp4R05m?=
 =?utf-8?B?Ukh1QUZoYytvWExzc3ZKQnhWbG5yaE9lQnA2TUdXaUIwTlBkd0JPNS91eDFv?=
 =?utf-8?B?YlA2L2dtMGVxRWhIT1ZqSUtNS1N1RE0zVWJOa1pPamU4c2h4MGxCQ0xRZmt1?=
 =?utf-8?B?Nm5JNlpDUStkdjl2TUVuTGUyYmpKNTc5WGJRUT09?=
X-Microsoft-Antispam-Message-Info: mQBgfOzOTa+53Iox3vK0h5slKB53iiDstYIc+Zlq9UHeESLlIw10gBzWP6G8Z55iwptB2V9I9eJjBjyXvNIgZi/c7z3v/JvDQ6m7YTkcYrSTEXJytky8jkzkOXELlWeuxwdntAnI73ghgL08QcFi0JAJpott/oo468dAaBG/tb17x4sCZOJhukR1RULMj+qs8ZFxBA/NxWxC289FZ/NXJkZNp2D+aJK/AA1/qwTB5wK8LOEgivZ0XLQbRhd8Lvdgly+aD8hDVTr3KcwOqBx3W3OQyRyciGm2ran1TA3u/RrmrS5rHJHzs9giZojswSmZZIBn48xslDV+zxK5EpfFzzH2A38uqwzRWYBfWG8U52o=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;6:1h602Hbkg0w9t8IHLA1JsVgqJEspp2V9uvWMl1HIn9euOJmHB82XMPrvlsbdpjS/SiinnerzHbYOKbedDxxguwOGK4QjqazmZMDHU2cTWJr2lydilUB2A28NxW0qZ1zZnJTo5fsHMxFrQDG9gNL+LyqutiacRNzOIMIYiUgmCZChmi1FqvyFSxlmDQ99zmuLPhJYI3yWnlOHdqCTr+I+mwqWVLns8HSHlN+j+s9nQepy1Ki9QZPQVYJ0/ZvoI7QvIzXF1Fi1yG3ObdTiKNGiqMpKP5qSvoIs953tpTa5TzCBVd+aEX4S7UrhlbXSzgHKx5Dgx82MOkXgZ2y3roTY6i4VqScXMlHhix0hO+CJTDqA6/xHKu3LcfRs7Ey6aFwRjqFFEbjG3Btzs0B7pYljPFiw7hIyHOxwHE+ZcYoUgnaxEv6+nFATQzPGHsNIX2YVVCPzgIhNsB4zB++Uppdgsg==;5:+D3+hVZf+a1p1gfzwDVf/oKgXsT4w/7cs0M+n8k0ipMmhh9/KN3Yb1LZnDQaRKHe2EfSPmohK1Jv4palsAnO2CvWJZi1InR6LV2yKt8mFGky/z0y1lqXRm7wVvFDo5Qt+F5bW/4XxsDJI5JcPHiZY+p9r1vVPuZUUD4+PI4uDOE=;7:hVE0600fE+syYDFHganaBsromPki3j0gIx6tYzRHeQluXOdo9J2FcLO5481cL0jgpZVrCSu4FUYJMue692VcYnE2CKFOkzG5R2pV0qiuV+HQ1vhKMuBJd7OkA8EvhiQjM7xk1w5Jh6VpVJIB9YdsoqLjRYW5itvIp7szGanFZh3wy9UNCBLQLFrNj5cY8tRTKOVcy/4IKKT79WdFUIBmBzv8LO0TPu18K3PIcTYhXTBx/+j2sH21dtEvzRpvoI37
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;20:cM78hhi6T6nJVD3fX3cADlaz3iZnkpOoIeDlmOYVEmB1mj5YVhmRjN0UGBp/kTyjkoGa5eMkaDzhbN8aVPV/Gfd4Fo/Hf/XlHbRPBEOBOVLsaP9qBy/jiWP9gyeKuBuPUGFY29KVZfF/mg++0Cq4AHutAGAsJC+KigLeuDcNbi4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 09:46:03.7137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790bf0ad-6d17-4715-5a11-08d622028b96
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 01:42 AM, Ming Lei wrote:
> On Fri, Sep 21, 2018 at 03:04:18PM +0200, Vitaly Kuznetsov wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>>
>>> On Wed, Sep 19, 2018 at 05:15:43PM +0800, Ming Lei wrote:
>>>> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
>>>> yes, is it a stable rule?
>>>
>>> This is the assumption in a lot of the kernel, so I think if somethings
>>> breaks this we are in a lot of pain.

This assumption is not correct. And it's not correct at least from the beginning of the
git era, which is even before SLUB allocator appeared. With CONFIG_DEBUG_SLAB=y
the same as with CONFIG_SLUB_DEBUG_ON=y kmalloc return 'unaligned' objects.
The guaranteed arch-and-config-independent alignment of kmalloc() result is "sizeof(void*)".

If objects has higher alignment requirement, the could be allocated via specifically created kmem_cache.


> 
> Even some of buffer address is _not_ L1 cache size aligned, this way is
> totally broken wrt. DMA to/from this buffer.
> 
> So this issue has to be fixed in slab debug side.
> 

Well, this definitely would increase memory consumption. Many (probably most) of the kmalloc()
users doesn't need such alignment, why should they pay the cost? 
