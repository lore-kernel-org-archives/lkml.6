Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CEDD5C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68549208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="g/TBEuuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68549208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934669AbeFMJE7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:04:59 -0400
Received: from mail-db5eur01on0071.outbound.protection.outlook.com ([104.47.2.71]:13088
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934418AbeFMJEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce5sh3/0ip887vMFYRwCPYjDBU/7BuTaVQpX1DGMgms=;
 b=g/TBEuuN5LrkmaliayMh+f1unr3JGn7ALTbMLJR7fy+XgQkO8Xc1+44DZmOlcVEDIPS+amUivMb4XvgiuPb+zOz9ggvfbozhRkZ+ZGBdilE8g3ByeVHlKu87Tba53Bg/1+E/ePhxEfukARuUyFxrCSwWofBKzODz3iMk+K6+w2M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 DB3PR0302MB3212.eurprd03.prod.outlook.com (2603:10a6:8:9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Wed, 13 Jun 2018 09:04:53 +0000
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
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <cca7b9dd-a0c6-8052-c294-9e6c5d65e9eb@epam.com>
Date:   Wed, 13 Jun 2018 12:04:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b08fdccf-2f1b-a902-f00b-a4cecf44a1b1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM0PR0102CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::36) To DB3PR0302MB3212.eurprd03.prod.outlook.com
 (2603:10a6:8:9::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ccc83ac-55af-49fa-24a2-08d5d10cba5a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB3PR0302MB3212;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3212;3:ukijANcG+Hd/It9pVYl1YvjiZHAr1TdpJegkl/hCwChLgwKiEmAjXf+ZXBZRe4rqkTYvyzFMOSuvSBaHii3ynbayKSJ5gc7KGawYgfOfLt3xFfBpw3IHLAJUOoHCDRKAETgtBCwDjGjTjOAil/KYeYyCIhM2RsCI/p4YnlVmOcO0CBaLKPTaM509yYUotCWm4wZ6rCl1Nulw4qprL8FlpxXbWhWXVbQzMWyT+2PM8A3JPgoTXnqLqn41I5JoCYSs;25:846851kp6RMXBRJ4sXjG8GkwlvG8U7eaaJft8jBdAf0wtqAf+9mbLtKuf0puKVcIEAbrkTu9eyzwEmV0/yWwbFagkMvQdBntwOzEuhfTA8oIuXXDp+3YsP5UIkCcTKVsiIrLNA+msbZ7rKn6kJpOncekfbfQ/ctONxuAbKihv6ZL+0Vmdkfr9PWlqNK9iGNw44ViY1x4VIQGk6y2x5XoAClxvkMYxuUm+hQckfUHfZ++fQg+3grBWz8XkU3ogtnDE6sYdgY/HCEgWVCEML2/iyD3meCvcIQ6XENV7KetMSYzBJJ9wg9uUUTPgd0JjZGhbGWqmMGgZa5klhBASj3Dmg==;31:3siHyQAe84dQ+hddfzviAFMPMP55nBSNe44qFI7i0UKxAmF9nzz+rSn8U5StfuziE6V1AVykSC2IJpGJ3YAuWSRnD9w/zcmD1N4Rt1wMIsNNGWnr3Fi1TJHpi/gZx+lrs0MisvEfMYS/4kaNT8aFbvXyS+P0q8zcfutZaW5LEfBXwO5yncshYbqk6dQDe0OQkn1HfpaMbcKy2ai1e9uxwWuUd9g7IAjHCg1Oso2pL34=
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3212:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3212;20:KUGc3CeBamsxELBUcQEH2IdQR3BUawhGv94XAEgVPyiUQJeNqH7UNLS0Hivr/dSRkv2q/PMkc+Na4Duf79ExeOY+qyLnE09kVnC3VNzS5+AdY3tI/4xDEC50cPizCR2OIFWAocTiOKY7JwOs4GUMxcvEXbfErYsfqh1vIIIAKSoA41Pbv8df4n4v1ornEDLNuLYRd+0oKA/5Oaqa6C668uXEUeyZWrxCpEe2IIZTY/fkCD42gyQO7IbbdQ4lJbJpv9j/BXtBx50Y142xRGxHyYv2p/qmEh41u/5fIkXBR5DqBlpPjaGYcZdRCVoA+hDJYaIIQ3+m+l/EBuv3SIyO2pP3zipW8GTfsj+nCYke1yXk/90Q5Niz3tnbn35OQevbslupfAO/2jBkeDI4rF37Ajr/JfFINQRYYfSnOf+NIWSNPxu459AkOcUMxUpQ1RFetgkfKKbM+602qW8sjY7lUf97JvcHNnZg9LlNUHTJWxbMzAVi9UP1bZ9x0k4K1nVU;4:QQ3NanR+1rtRubyEpqtkfHhgTrc3d+LwvxCwAQgxKWnzxB1BhUEU6bRX/1ZK64KgWqKGmYrRcQD1EQe92jWdfNPHMt/YqI73plZFOCdR4Hh6OP66l+5syFNL9Is8n7fzYfBuGtHHKnN/je44YYZPuPW2uFhLO8FvnedapwxB4qWC2YUhP05BFw4LtH/sN2ecnBUEz1bTmNNq+ruES/0xijdKg8bPqQQHIe6x43duL1cAyekRAuXqK0N+AWwo330F/9NFgrGSU9ZfYPOqX+UJqA==
X-Microsoft-Antispam-PRVS: <DB3PR0302MB3212922BA0CD5B118724DF26E77E0@DB3PR0302MB3212.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB3PR0302MB3212;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0302MB3212;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(376002)(39380400002)(39860400002)(346002)(189003)(199004)(36756003)(16526019)(77096007)(11346002)(105586002)(110136005)(5660300001)(3846002)(50466002)(6116002)(6486002)(8936002)(478600001)(59450400001)(386003)(31686004)(106356001)(446003)(53546011)(76176011)(52116002)(486006)(86362001)(23676004)(476003)(31696002)(2486003)(7416002)(58126008)(81156014)(52146003)(956004)(6666003)(2616005)(6246003)(305945005)(97736004)(5890100001)(39060400002)(53936002)(65826007)(68736007)(81166006)(316002)(47776003)(80792005)(16576012)(26005)(2906002)(64126003)(25786009)(4326008)(229853002)(55236004)(186003)(8676002)(7736002)(72206003)(65956001)(67846002)(65806001)(2870700001)(66066001)(87944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0302MB3212;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjAzMDJNQjMyMTI7MjM6YXgwdVJtekl6R204allhNmZTUTZtOHk0?=
 =?utf-8?B?NDk1cHl3OTZOenltUm50V2RqSjk4amxrSzRQOWMxakU4OHZsTExqb1BwUlc2?=
 =?utf-8?B?RldoM3lDV0NWalhBS3FueDRCcGdUS0ZiV3BuaEpVUWJvSlhEK0Y2TjNONGtx?=
 =?utf-8?B?WWVvb2RtUHQvMGdocCttTVJSSEs0RjRKL1BacjlURFlDNDZyVkh6RkNJYmZ0?=
 =?utf-8?B?eGlNK1Y5cWkxcUVCMEZjUlR1ejZ3UW9ZZFMrNW5Ja2dUeC9ZUVlLUHRvc2NS?=
 =?utf-8?B?OVJLVEZEa012d2xab3B1ZDFVWmpuZ2d2UHBsTE4vVVVEUVFDNUNMVXh2TFNX?=
 =?utf-8?B?Z1BOUG5ETFlKYVhITmp3M3orM1dVSm9Kb2dwekZNQkswbHowMktpSzRBdzZR?=
 =?utf-8?B?Ym13OFh6RllJWTJML3V4Vm05NTZBZm1qSFFJYnJPdVdqbUliYUhDTS83b0or?=
 =?utf-8?B?d0xRaGFLUXNKT21BbitoTnZ0Nmg0NklKUHNUajA0aXpXdXN0eUlzYkd2Z3Vs?=
 =?utf-8?B?U3E1VzFadUJjcENSYjdwdUx6OVJCQm1zQVF2TzZjVjd5UmYza0x3dnZYRklX?=
 =?utf-8?B?ZSs2OFptS1NWSXJHUTc5SGdmRjgvNHhtSGR6YS9jS0QwSlcwb2RlVFV2WHNk?=
 =?utf-8?B?YWZic3hDc3l6ajdmdXhMdk5FM2FkUHZnWDFRZVVVUEh0N3NKTmVTWEx1QVY4?=
 =?utf-8?B?QjQrZWFRNGpObllOUEJxaTRwdGxtNlppR09IUDNxWEhuWWZYWW9pSzlzQ05I?=
 =?utf-8?B?KzBHaFZaZHpYK2Q1TUlMSExTTE9mcEVPSisvVVBIZzR2SUFEamRwTWRLVkNi?=
 =?utf-8?B?K0ZzMDJqcUU2TUJObEJqRFhXS1pVdE5USUZvazZRa1ltVFJ0R0grVXlGU0oy?=
 =?utf-8?B?amp2bDFERGVSQiswQlJPQWwvVmNQWkxOSEEyK3ZWZlluM2w0YUZGdGZVa3Z6?=
 =?utf-8?B?ZlhsV1BvaVlHOGM3eEk5WmxacHRTL0o5OEZkS0ZxcGFoTkhWcWpIY1ZoT2to?=
 =?utf-8?B?NXBoakJmYld1czZJQ1N6U1k5Ty9NdFNOeS95SCsxTDd2c0gzN05yOWMwZlpv?=
 =?utf-8?B?a3JHdDQ1QURKMGRjSFg3dmJnb01XR0FGaFlRQVRKQ2c2dTM2Zk1OYlNiNFcr?=
 =?utf-8?B?RVhSZVNmKzRjUDFSb01iOWdTR1ptVDNiMkpDMGlYejdKcmMwUVZFcnFhQnpO?=
 =?utf-8?B?RGl6L1Zoenkzbm1ibVN0NldzTVBkSmVQck1qK3ZXMHYzdEhmaWxyVWF3WVo2?=
 =?utf-8?B?NEIyK0xpVThXbG5Ld1p5T0RackJNaVEwZDVZbnh6Y3VpQjcwWWVrY1p5S1Zh?=
 =?utf-8?B?eUorb0pDSnV2a2ZQRjcrR2d1M0JoTWdCb0d3dXVVZE5UcFJmZVVoc1Y0NXA5?=
 =?utf-8?B?TXlqT2VOc2RoMFRwdnFsZklObTlTeXJGaDlhR0JxbXVuY210K0ljSmdINk9X?=
 =?utf-8?B?VWVSQXVDMVFZQW9paHNQZ3hocWlTclJWc3FYdzRlQ2ZiTitWNFhFUTY1RE1Q?=
 =?utf-8?B?b3ozdWEyb1g1NWlwSjRUWkk3WStJeHlrK1orb2I5d2VYWnJZYk43VFkzVDc2?=
 =?utf-8?B?ekV6bE9kczJ6MWpENFV6cEk0MmF1TDVGYTA2blNkaEdaTWpNQ0R6RVpXUDl5?=
 =?utf-8?B?U09rVDJhY2luTkwxN2ZFMGVYUEFPUE56TU9BRUpoOXlTcWJCU1ZNbitMWUNs?=
 =?utf-8?B?NUlQcjNUejR0ZUcxVGFPN1BlK3poSU4xZ3BsbWpabEM5VUFRR2YxL041RTBt?=
 =?utf-8?B?cERzTXBKMjdMV281cGsrN3NBR1htcktDVEFhNC8zSmhTdTAyNU5mcjFlYUtW?=
 =?utf-8?B?QjFVRktoa1lZcTBWS0xhUzcyVXdvaG5wdjFGa3U3RGJ4aUZReHNOcnZENmVD?=
 =?utf-8?B?eHZWa2VhZktlOC9tZ0s1U25zMzA4b3RzVzFYN253S0tLWGFTTXd5Nm1nL3RU?=
 =?utf-8?B?d1lEMlNScis1cExmOExKTjNJZWI2TTk0NU1vWWIrbHFLd1J6RUJDVzZIUHJS?=
 =?utf-8?B?WlB4STJNRncwRkV3R0pvT01LRU1Xd0pwWDQwYlNlYUlFTWZmQmplOVFBRERN?=
 =?utf-8?B?cTU5S3VmOURoallkTzNJODFweDBBMCttRjFVWTJuQWsra0pNbENnOWtqVTlq?=
 =?utf-8?B?WGtOdHBMQmJrdFh1TWE5emk0bmlmd1BXUEhTS3JuNUtTbXZPenZMcUlQNmgx?=
 =?utf-8?B?RDNxUVVqbCt4a2JxWE9yeE9XdWVYaHc9PQ==?=
X-Microsoft-Antispam-Message-Info: akXXQkdO5HTtzMNyuAdeelqNgFTGkSRp9wLrOWY8K2GFC5nMpb7pJPA5+Hy/OmhmqZgmmidiarZfRosuj+crboNYtgKg9bJdOAsvj8NeDr7D6IbRm2bYXX5T/o8+XXWNbV8/PEuFq8H9UfRH+g9Iglqe8vPtQbyLWKVxk/opXECQKB/ZzYHUvEYFyKiPnJmv
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3212;6:L9M6jZj8FKnae36F1ixQHMuebtdSyN7GPz9jPkDIxIZHk4I9NTtrZ6pmD6DwAc62bCa4odzH92FvIVhSPzJkv4d9Xtzi+N3Uv823V97dW54XqDnHQdufAGjJn/sYV7IjAbiM9vj3B/g179Z9yXDy887hQeGSl+c00UAFQoaQCH69LpkGzQq6s8GNIaTugMV15CDxkN2uOweiBxfSXmiWYS0LSpGzzYwZs9KwQ8J0SDBlzH+4/HGl7zOtXU8ormzlpZATjH0DWEQoxoSgTC1CX8WCGZYFO9eRAAus1GAGBq4P2cwBEOWUDB7f950sZgayCVEJucBxrKfDhEco0eMwU4nuTAABHZ5VqabSeYtUEQG9zqsahwN4V82pyoVao3FYM6tV4S8JES+iEPYUefPdiPCyVXUfeZLtEmq8NUM5S9RC5QVVTlB/sXMWwqb9aeQ4jExtgCCg14KX0YVwMOgW2A==;5:SdHeQJ9qA9z7FoFVsmPl2Fah2LKbvW0EziDfndv7Rh/y3Ndz8acyp5bC8DwcTnbx2F4J706O7G8CcFUDrtCJIYsYWWZZpoJrrl9HGeDXbUq7wK3zfPamsPWpt9edVCHq50csSelg2d31hsivlLGg8pEEtZATv1y8LlJPWo4aUvg=;24:1gqaEwwn6k0PPYxsxh3Qi7KXfFJm7pVgBqCnu4carqjDvvKlX2r1CMpnbhgrjvIyS7MYx6aLeLjeSzl5eMbsWyb2wrLE8W4ccwoINEbAgpU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3212;7:w5ZRPXOVZkHLj+tpbj/RbtkFE41JTEUbVMgfmWz1UI8w9UXcYHeHbRY/zqiE8sMHEV3RHCZn4CKGS5HcaBkApoyDf5S4Re/N01A5fyCPphHzKwFQ0Y4c2ivtJIGzEocMqkpqqs1LxMkSqELx6mLJ1FMnrUCyD9DTxxj0DndIz4Dxj76yt8WSZ7lV1zVCC6GZYccKOFzmiNe7rcCR/b4zFciLNvEyg+NVstLhq4q6GBGltbwBWHMnnWI67snIpGDi
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 09:04:53.0069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccc83ac-55af-49fa-24a2-08d5d10cba5a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 06:14 AM, Boris Ostrovsky wrote:
>
>
> On 06/12/2018 09:42 AM, Oleksandr Andrushchenko wrote:
>
>>   int gntdev_dmabuf_imp_release(struct gntdev_dmabuf_priv *priv, u32 fd)
>>   {
>> -    return -EINVAL;
>> +    struct gntdev_dmabuf *gntdev_dmabuf;
>> +    struct dma_buf_attachment *attach;
>> +    struct dma_buf *dma_buf;
>> +
>> +    gntdev_dmabuf = dmabuf_imp_find_unlink(priv, fd);
>> +    if (IS_ERR(gntdev_dmabuf))
>> +        return PTR_ERR(gntdev_dmabuf);
>> +
>> +    pr_debug("Releasing DMA buffer with fd %d\n", fd);
>> +
>> +    attach = gntdev_dmabuf->u.imp.attach;
>> +
>> +    if (gntdev_dmabuf->u.imp.sgt)
>> +        dma_buf_unmap_attachment(attach, gntdev_dmabuf->u.imp.sgt,
>> +                     DMA_BIDIRECTIONAL);
>> +    dma_buf = attach->dmabuf;
>> +    dma_buf_detach(attach->dmabuf, attach);
>> +    dma_buf_put(dma_buf);
>> +
>> +    dmabuf_imp_end_foreign_access(gntdev_dmabuf->u.imp.refs,
>> +                      gntdev_dmabuf->nr_pages);
>
>
>
> Should you first end foreign access, before doing anything?
>
I am rolling back in reverse order here, so I think we first need
to finish local activities with the buffer and then end foreign
access.
> -boris
>
>
>> + dmabuf_imp_free_storage(gntdev_dmabuf);
>> +    return 0;
>>   }

