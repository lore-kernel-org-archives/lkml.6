Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AD3C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 07:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7535421477
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 07:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="g8P2TD4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7535421477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeIWNtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 09:49:03 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:55648
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbeIWNtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 09:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ggf9m+gCJWDQo7tM7egrN8ivlLwXJnxolImadGX34y4=;
 b=g8P2TD4G4vBjYjWyKWfGI+hRmi5jYEGwJJO73y23WcWrl9cKYi5eH2/fPtlZjqdGqSaovq2J0LCibAuMMxtkfuBA5iejShRhsrPo7L+sjkc1lSbdc+7R27vzPtfyN1sYKwxPV0GMjaGLycH9CsYP/8kOPX9X/gxydIF4avYpfBA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com; 
Received: from [192.168.1.110] (77.126.68.89) by
 VI1PR05MB3264.eurprd05.prod.outlook.com (2603:10a6:802:1c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Sun, 23 Sep 2018 07:52:09 +0000
Subject: Re: [PATCH] net/mlx4: Use cpumask_available for eq->affinity_mask
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180921094412.15547-1-natechancellor@gmail.com>
From:   Tariq Toukan <tariqt@mellanox.com>
Message-ID: <70856b54-cb69-d105-d14c-4b0fd7741b21@mellanox.com>
Date:   Sun, 23 Sep 2018 10:52:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921094412.15547-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [77.126.68.89]
X-ClientProxiedBy: HE1PR0301CA0021.eurprd03.prod.outlook.com
 (2603:10a6:3:76::31) To VI1PR05MB3264.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d7d87de-3443-4122-3c7c-08d621297fda
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB3264;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3264;3:cQKK3puzzKiVAVG5SGPX+QD/OBPv6sMJLFRzaseuIjZVDQ6bliDwz9LXOJ8Ca6vkZN6Q35iIAdsuiHY5uUDArYOmswLP2z8g0EkkS9VNxZApNnTMy5IiEIj6/ZhQPDm36tjmxvhdQkqjpIYV+s5nY+PM1nuLc3vCc0NpFE0BD3QQGbEn6foz3mecNhrR1hCVc7nX6cVx61wHc69LKybsnZQldO8Fk61kMBO4w4E5yV32FS5huTcHF1frUz/EWTD/;25:Sx+q1ygGySiA9pmcZLOAK9H+BlFX6Z4er9j7CGqzHqhwAn9EkR9460r4omLUCtGv5ix8BEvJ4XwRBhKm0r7BgbbKOwwbuWz46kPc+MxEbp4x+nxezX9fvgMk1oAoo7acDU9Ccgl/G5OVdMnakDMEWUjwWJn852X8uRwgxxtjbGjIcqBBmIyh5Sm2jJrJ+5XMBdbKQv0l+Jq3MAu+JBVQ3GpgixtsMXSEhxaMHwWwapJibuDZ4mtN29Kx5EvCY4nIjKBgakEu8fytTAwsK0R8uES0SvkebtSVW22pvEV34PLErT2SYmOLIhh3ij09udfCCT4clLfmLn1vLIn9NaXcOg==;31:jRv6ndVcEA4WSWOaNrztsrsvFK4JSb7Cs8LliYK0ADMeWTT8VAl8HcVJvohqq6GXoJyiWNAPEprh8wzIlU56Yo3JOKhb+5eLKe3gwAq7JUOqkNGslDiUtofjt2Gd2bxc7umbDfe6ySH3kc5jT86FzXukNaxzF+MytlllzQRkYKtLJol84otobpP1k9k3tsAbG8Ox+h235us0e7NnU96IAFfIJm0pac1kYbkO4Zp0US4=
X-MS-TrafficTypeDiagnostic: VI1PR05MB3264:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3264;20:cdz+7htPVEs9tl7n8NtZpZvZP33fuc1zdkTC43cRg4e8TPXS+QTjrpGPDFoxM6R+9bDsMUK5MIhPsbX2FpSf9r1DqSMou5XoBlFQXyq81ruEEX9o+ko2c0aAsCP3jjIrdULg4lYtWpWdvd00qfgVqktYAyGtrJwkyNJQ74RLFm9XQmAod2cxDeAnon4YutzNyGWapLw2EXDYswktCeYAAMcrm+fV7jXviX7T9Yw4oKCgb1MVZUCPZnqstph/+pxssgVTD5crbS7at+z1j3zJKJM2LJMtb5TtHD08R76KHPQkKp9URo2Wkc8ryfdqLpTyF5h1LqsVIzTERa2l3NPuudMaC83f/PdndGdS7fizwDd5L1V9LFIhcqL1suZE+/kLrwCC4ISjdrnA5SPcvbKZWJJGu7IKYZAoDLhMRCEzxLHpQez8QxGycTgm0SqyP0Zi3jXXhXCVc+N3kD6Bkn2VeDAq134we6pHlDq67dbu2UQo8lcJ2SN1Q10lBgpf1usT;4:alSSzNjVhY6MzV84jd0YG55NC9FIjF468R0rm0/s+cZ0y6wldgqOpBKf4njfOM90rK2KZJcGE+Dhz/4O8v1EZQbUQ6SrhwOzw0zoEtf6iEdJh+xzbd0F5r/8wCoLeOAXfi4Kbpbj60bdz67H2yWKmg6YfW4Mvw7NfpGgUf5/hGuX3Qpz6IETwBjtVNezXpCEWQ5PyqvAq2YOcfKwX6GRh8lCrpaaBDkioxPiSl/m/4kJbnc+bNWYhQGsDlXs7PcFrKwBDDPNMqM/FGiLICYDTHQsI969HtHxYAxatnVDB8aUga1FfhXKkYEqevFPkDTFKDBLdURp/pgZu/ZY6cf3Zs6/DhuNIFsQh9vXVr5DF4w=
X-Microsoft-Antispam-PRVS: <VI1PR05MB3264423C475ECFD445769462AE100@VI1PR05MB3264.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR05MB3264;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB3264;
X-Forefront-PRVS: 08041D247D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(136003)(366004)(39860400002)(376002)(189003)(199004)(2906002)(956004)(65956001)(486006)(6666003)(65806001)(478600001)(50466002)(446003)(86362001)(77096007)(67846002)(23676004)(2486003)(52116002)(186003)(81156014)(26005)(106356001)(7736002)(64126003)(47776003)(31686004)(16526019)(76176011)(81166006)(110136005)(316002)(52146003)(2616005)(229853002)(230700001)(36756003)(4326008)(58126008)(5660300001)(16576012)(65826007)(117156002)(6116002)(105586002)(53546011)(25786009)(305945005)(6486002)(53936002)(14444005)(966005)(68736007)(11346002)(39060400002)(476003)(386003)(3846002)(31696002)(6246003)(97736004)(6306002)(8676002)(66066001)(8936002)(131093003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3264;H:[192.168.1.110];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1TUIzMjY0OzIzOk85MXMwY2xjajdlaXM3cEp1RHd2ZkdjL3Nt?=
 =?utf-8?B?d1ZjN0RBTHYvUlRNUmtyNnZCanY3VkE5dGVLWVVjZjE4aW9xTmJyWFhIZkF4?=
 =?utf-8?B?dDN5VmVSUjZhY202M1JLUUJJRzVqRzArOUpOemRXNkgxbG9xbEJkanlZbTg4?=
 =?utf-8?B?Y05mSjBYek1ZUC9FdExkTnFDaTZBSVlHZ1RCbkJlbGFhdjArVUo5ZmtlR3Na?=
 =?utf-8?B?dTBtSXMwWFN3SFJaVnYrZm5NMDNEc1hlNFcrbzdmUytjaEdLU2dVczVYTFJR?=
 =?utf-8?B?VkhuZjEwa3R3S2szd0VXMHo3NjB4NHFhSzZuVVNuc1ZkV0xWVnpPOVg2Vklh?=
 =?utf-8?B?Qmp0cGVqTzZCZWYxMFEyWnZkNTA5U3N3dFRYcksyTW1JU0FaTCtXNXIvVGJI?=
 =?utf-8?B?b2srVjJUQnQ1dFZjakRtK3dFZ2VCaTlzdk5NMDJ0OUlESTJObzRwN2gvVTBP?=
 =?utf-8?B?eDRDeGliM3FBYW1rZDd0UGs2OWZTcEhVTjlwMDlxdGM2ZWhqdFptQUR3UmND?=
 =?utf-8?B?TXAxQ0Y2eC9jYXl3SVVlMFJnNVVpY0dtMW1UbWRFUDdmcXJPdEpWSFhXa25h?=
 =?utf-8?B?L1JVK0JjWndrallvR2V1ZHhZenRWbFVwUms5d285a1NONjZGKzZwQWE3aUNY?=
 =?utf-8?B?OHpqRUpTZ1p5cjNyT0JCTlR5bFZveElxb3AyVWsvS2t1RXMwRGlPN3U0d2Nq?=
 =?utf-8?B?dVMzOHpscnNGeDBSMFhOQ2E1dzFsRmRvNEdLYmRCV2V2ZklndEZ6M25uaW5p?=
 =?utf-8?B?aVFYVnZnak0zSlJvZDA4eGh3K2wwTnFTNDhCbTlQSXNOeE1nQWo5SWdVZ1hi?=
 =?utf-8?B?NzYwWngvYjZnSWVoVFc4dWU5djVZMkpQMW9iVWpVeThRZDlFRGlVUUxiQ3FE?=
 =?utf-8?B?bVBrTzdGWmNmOXBjY0g0TGRYNjdnaElIb2JMWS9MNmpWM2kveGNVTFNnMFA0?=
 =?utf-8?B?aFNJNUJMVUxpdnhJRzBBcGhpVkJTajVlNjAwRHFoNlFVd1V2NTJtUTQrY1FX?=
 =?utf-8?B?cFhFZ3VZd05BcFQwTlRGYjFFTHJWaldzaTNaMDBhSXZMd3U4bkRrQ3pEZldx?=
 =?utf-8?B?VXBSa210NExYa21Ud0VBa0VPdnJGRmlXSGhDcndBUklvQ3VFUUhXcDhuRWVw?=
 =?utf-8?B?UEd0ZTlkMkpuZXhuY3d1R3h0c3lWek1DL3ZoWnJ5Vlo2ZDhRTDN5cjdJWGlt?=
 =?utf-8?B?KzB2RUlLSkYxS0xSTGoxeVBoeE9FWWhIcythSEhIaG1rVmtXN2RmRUl2ZC9w?=
 =?utf-8?B?Znl3ZVl6cExBZjhYeklzcEs5eGZObmwyaDRHTDhSR0NqYldsTUkxMFAyOWth?=
 =?utf-8?B?blVVZTJDNVkzdTBBUk9CTmlheEM1bTB0M3ZMa3RnNDdudVhGbzFpTlhlU0hZ?=
 =?utf-8?B?SVlOWVhhNjhHeFVkMHhTMHdPSzNoR0ZIamxKelRDWUdidjI2b3RjV2dWczZC?=
 =?utf-8?B?clAwYUVCbGZNTUhmbG1pREpYNXB4RE5XVzRNTnRWdE0rVGFja0pMK29kd2ZH?=
 =?utf-8?B?eXMrTDFJKzg0SjV6dGhOdHc0Qk1WYlhZQ3N4elBrc0FNemRkUXhxMmRvdmx1?=
 =?utf-8?B?V1VpYVNRd2JnRGFEeCs1dS9ZVWdnZ3NqQWRTRHR3VXltbnBCbFhCMFE4eGNq?=
 =?utf-8?B?TThoS1JqU2xSSExwYStEUW05V1o4Si91bVpOMTZPckhnVnU4SzU3QUwyYk1o?=
 =?utf-8?B?RHFLU1BBdFpTd0xXSWJKbVgwdStzbDVCcC85MHliSmRERjg5Rk5iVDBnYWtM?=
 =?utf-8?B?a1dqQ2t6aXBuUVRwS1RlWk1iYzNuZUFaN0JCaXA3TktGOUwxVXRVTlJjQzdO?=
 =?utf-8?B?V3BRQ1laK1E0Ym1SbFl5L2FUNnVIbjJQTXdLKy8zd3VhMGR2YXd5ckYyWHdK?=
 =?utf-8?B?WEQzTVVobzVyRnlDZ29VZWgxcy9uZUhLY3NxVGRVMXJLNVhHVFg3MnJmQ213?=
 =?utf-8?B?QjNIYmJWZU96Wkg3RWxqY2pmS01aOURNN0kxVExDdU1oZ2pPQW5PNGlXVmhC?=
 =?utf-8?B?RDNqayt2MWo3MG9ma0ZQOW5sVEpLNGwzSGFFS1p6R2ZRUkxwRU4yMmNKQWx3?=
 =?utf-8?B?eTFYMG5JUGoydzZ0dy9tZUFlTzVmZGgxbmFQbEsrYVc2cGpteE10UDZVMVVY?=
 =?utf-8?B?VUE9PQ==?=
X-Microsoft-Antispam-Message-Info: jIyvHAZbQDTjjJE2gUrHnV/IkEtPwyLg8vb0QugKA/plAUvge6sXwbybFain/aeFqLHs5qSnw1C/V1OFt4hEZ7M6FbjR+KAwIKUqS49XKzinuGxId3iPd03nDiJJvKFrPiiqdUPpvxc95+ht/yAPmFf6ASLrV15qI2ciFE0Q/JcrjDqD8z2C78SmyIKKc2XUqUm0UFrJGJXQHPxDLgTJ/PJGFTx4zwr/bnrgcy9BHTGYFos5hArmcnTeT7rPmTl5ZMNuA6Zxd2K+NDV+PrWYYq7Z26za0cRHyIA8LXvPz9ytzIKAZRt9idxOY7Cbigaq/2Fyz+ZSmI0EcJEEYbeVtTivX12I851hbcohQ3QzCeM=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3264;6:xmG5XflIEaSQnuULV4MK9bfY2Xy4VVRF/EflJvyi+6fCtRdysdXbmDLcmuP3a/saNCbUguKPMsygJ/JmxCguu4dyI2bRRhFyQ0Jde3XCUWJXRKAYV/gRfY3837SNg4b7MiixTYBSUU3sTKQMqdKl5yPWPh7X1dPW5ooet12iAaYfAK8Hvm3WCXtUJY+H+G6ooVZdn4LR/t7BvX9DyuT+A5mjk7cLqAwKkk8JOazxWJqw3MKxrWMlfCiM10ppA0+E0GEwhiq1YtYVQWldwG0iSosQScTT/OaiQXhW1uKASJPh6pCbnhAEpPdV0IjAZfCp3OxT53zdE7EMi1vefUE0LXjtzxQFjZMtOZ3TbyK9v/x9KDh+qqgS/G8pIZUx/nkDjiGmkIPDhWGZBXMMS9cNUpAA8pvsTaHjbS1OpknWw0dz1w139YI7TMJ5HSA4MJYnA+/SsskZ0ZzFH9+HQmmmwA==;5:xhrPAdsLalIQjZmJXHJBa/zM61tU3JUGrwX12LZZuv9JGGXknfWcH/1PFvTSFKBS3nuwIAxsOFjNCIEEI5glEy6E2u+nvcUMucZ5/dLY/v9FBY+KoGsdEcMzme0lOR60WLwvaNXyx8L0t3f4VyYYQ9CjYHnnTF7zA+L4dI1jhIU=;7:GsQxyI27hGv4E9vOvhzpuz9kj3CyTZm5gB9v4Vv4/T5onHxix4Do+dqPZZenGTOUqhVa4HMxlxnPb3Nf8+yJE5kaExoyWcjgLjEe8SVpLO5jjwOiBZ1fBdZQTuU8rd1lF2uKnoKZ55ZNbgbiE3Z7kaCB3QEkoLKhKVsX58yaJnk/rwRJuAAJeohVL0omClNI4JZkLdUxwgi44uisBBP2Z97KjF2sPfuwqQC7mMrHMRFJhawL+7wYyRlGsdnVyp9q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2018 07:52:09.7980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7d87de-3443-4122-3c7c-08d621297fda
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/09/2018 12:44 PM, Nathan Chancellor wrote:
> Clang warns that the address of a pointer will always evaluated as true
> in a boolean context:
> 
> drivers/net/ethernet/mellanox/mlx4/eq.c:243:11: warning: address of
> array 'eq->affinity_mask' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>          if (!eq->affinity_mask || cpumask_empty(eq->affinity_mask))
>              ~~~~~^~~~~~~~~~~~~
> 1 warning generated.
> 
> Use cpumask_available, introduced in commit f7e30f01a9e2 ("cpumask: Add
> helper cpumask_available()"), which does the proper checking and avoids
> this warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/86
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   drivers/net/ethernet/mellanox/mlx4/eq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/eq.c b/drivers/net/ethernet/mellanox/mlx4/eq.c
> index 1f3372c1802e..2df92dbd38e1 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
> @@ -240,7 +240,8 @@ static void mlx4_set_eq_affinity_hint(struct mlx4_priv *priv, int vec)
>   	struct mlx4_dev *dev = &priv->dev;
>   	struct mlx4_eq *eq = &priv->eq_table.eq[vec];
>   
> -	if (!eq->affinity_mask || cpumask_empty(eq->affinity_mask))
> +	if (!cpumask_available(eq->affinity_mask) ||
> +	    cpumask_empty(eq->affinity_mask))
>   		return;
>   
>   	hint_err = irq_set_affinity_hint(eq->irq, eq->affinity_mask);
> 

Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Thanks.
