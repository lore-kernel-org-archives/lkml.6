Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF707C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454EB20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xh+Uv16O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454EB20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeHaMLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:11:04 -0400
Received: from mail-eopbgr710055.outbound.protection.outlook.com ([40.107.71.55]:27104
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbeHaMLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8H1PN7Ve7gISWYvvIfpif+MQF1KY7GROvA/RPQafqg=;
 b=Xh+Uv16OVFWUdkw4c4/z+vwXw+ImhuD6Jin93lkCvOncZR2tvDamjvsPxrlPojfkT0ziPw045I9u79p/YSsy+maRn2Q1UmGq9+4SHPp1WjmamSy5/g9z11iAPXC6l+ymnQdyvbLgYqP5b0nCoGrZ9VAUCVNz8K1Rp1S+f0VPnKQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 BN6PR12MB1714.namprd12.prod.outlook.com (2603:10b6:404:106::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.18; Fri, 31 Aug
 2018 08:04:40 +0000
Subject: Re: [PATCH v5 01/13] PCI/P2PDMA: Support peer-to-peer memory
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-2-logang@deltatee.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2711b3a7-f582-0dda-8ac2-530be7bda1bb@amd.com>
Date:   Fri, 31 Aug 2018 10:04:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830185352.3369-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR09CA0051.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::19) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daae32ae-9841-4bf8-ed80-08d60f1869d4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:10iD4LtCkw82yiLUgR2aDaxb//V3ax+hkfZ2DwR/Ank1DHSEe4uGiX1XOJQA8GYElbFdHRlXY3T9M4cv75a/rAmtexCMFgVqovP6Ea88NrmnqzdWrQmQy0zQWooSbtIIuiKjkX572rrCdfNzQJAYgYfixnegKqYw+ZRhARWEmrUn8D2EH2kzf0n256OxIfIROnqEy1m19RuYy47zklfSyjgjjM+ahJO5t0KmFqFrH+Q64q73ilXSWGjjdi2Wdorb;25:TIORZSLFyzUm219bep/zotAvNNh8sI/6rtNQe3INCFno7eIqvnnrM73pB3igdxVS15QSBqW8PJtz4tAHF2Cq0XL1pTbcRV8zMpr5LCz4V2tLH+pNcUjNkZs6XYyGfqS/wKLfiOCLVXKyGdEuAYWITqEGtsxv53F9qsnv0fXOzjp36+i8QEPsbb9Ug0/I2pamabIM7t/BOaFWwZQZW2J9jt+nPSn89mMfy5LSrxcm3J7EPmXgP8fREb59V7iynd4AxILmrYcWmBeRfSG1F2GSjAl7fQBZnbkULNEwFcfkBlWNg3S4wSNlnUimcckC7t0zvPp40BjD53pwdRu6Lo83KA==;31:n4ppWbazuZGOtO/CK71rSWzmfgKxODyRT4TysUVPTxtclol5TP8b42y0FQMA0o19hosthORHri0cTKHVu6eZLz0foEW4ebQpefa9Zpfb9WZNkJq95K49cPENttkCq/fyJrQ06OctmpR7OgYTiIMpzSI0sAlLF7w6VdrUl+Z1b67pmOoGvOTrnTM5FMLAm1NBucr5aJJTotGfyuSQKJ6FQyNt6dvcmZUWZdY2uY3fzwo=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:1BYeALxvsxWk+XIxBNFgp020jIhNG014xMTqdDA1bm4T4PfkalQFF3w1I6PcGbdEmzuUopiwxVrPupIY6N/sZy0yHkSM6qzPyCGHwta8r+Gzxw69UxpeFaq5hi3PIaBT1A+02DTNW6tDTeP6bENKVHcQI8Guo+KyU5adaVH6v0Rj8xY3ZXeLN48Z/8SBQsTfp9xVjjBn8N3DsvuPYOr/DlyjpEjeM1O5kUC51catYKBgnp3yf4vSfoZ1apSDdnNOGEW2mb3gNvpysH9TQOKKkPn+PbaYv0ZIS4WXu1QL73KEC54igmcn6YqgTxFVHnFYQ5ScDDLK+unMSCgbLRgvwkm+sxbfMDS7RDhVPe3GLETk1UboITANxgT6MikAgsvpxQYL1aK3rLAK0uX+VzHhbJvkuHKKnTkEfx2bE5vOt0mOnbB03515HSOs+SHMorEBFDee+dhKhcamQxwZ0coMyK+VpqEwIWir8nwcJHLcKvyUKV0AyN3mAyOOVEdJef7x;4:rZhYfD1kpm5ShHLfp3F8IjzIF2/W3dkx+uz+W2HfVoYl0xwzzqc855cJMl7OYpnmwKfek/pB+u6BgPw0sm/WR9PuoPJZhd2Sum05TlGYiYAUeHt4QuAg0M9dKCGBYR4Vy2E//WIRLxQULxsVZsKwUTiUyduxhUaPVZJYZFBRl74Yt+7JAQWziMHcjCU97z89mTqauXORGwN9AuQV4XFw+VqYCqvOAvK3Ti9u16juGv57HbSAL4XXXJS0aTRnJzRKM6zlCanpnU6Iz8Onx9EzgMzJyfBuIV4UQxj1RfCqx9zo8U/EquhMo5GDoQreJDfw8Lh/VcDC4bOLFIqb6anHYVSqJ/AD+ZGeqz+P47g9xsY=
X-Microsoft-Antispam-PRVS: <BN6PR12MB1714713787458D243806FC02830F0@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(269456686620040)(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(6486002)(14444005)(386003)(229853002)(65956001)(65806001)(446003)(478600001)(11346002)(7736002)(1706002)(7416002)(52116002)(6116002)(47776003)(186003)(16526019)(72206003)(8676002)(46003)(31686004)(97736004)(31696002)(305945005)(64126003)(575784001)(2486003)(23676004)(52396003)(52146003)(86362001)(25786009)(68736007)(76176011)(5660300001)(2906002)(67846002)(551934003)(50466002)(4326008)(6666003)(2870700001)(486006)(105586002)(53946003)(106356001)(2616005)(476003)(53936002)(36756003)(81156014)(81166006)(6246003)(8936002)(58126008)(316002)(65826007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOmtKVEJwN0dDVkZ0VTBrakpDZlU4NTdWVFZx?=
 =?utf-8?B?QkN2Y3ZKbVBsZjN1V1ZBWjA2c01zcHpXditJYmgyVXN4YTV1N09DdUVFZFJ3?=
 =?utf-8?B?b2lqRERoRHZFS0hLYTB2MTJYaXpCOG1FNis5SmFLUWpyRGNaeTdaeEpPS2xC?=
 =?utf-8?B?T3BqOHRyUitJa3hOaGdhY3RDc2dFQk0wYTA4NkgwOXBkellGbDNlSnVFWEdi?=
 =?utf-8?B?a0JyWVUwUGJ5VGtRanNBU2hReWhVeWJpcEdmZnBJNm9YQmpNMmh3T2ErU08y?=
 =?utf-8?B?OGFMb2ExYVJTL3Y3SW96THJxSWNLME84c0ZKYzcvTm9wQnVxRXhSK0ZOTkt3?=
 =?utf-8?B?c0UzWTg3ZDFrMC9JV2hVWHdDZDlJUG5FNmlPWDB5QnprenhPWE1sa2luaTlO?=
 =?utf-8?B?NlE4LzFRbFVOU0ZkWHkrU0tFOVZZSHZPblFlazY1N0dsdzM4bFRHcStqWmZl?=
 =?utf-8?B?MVdwSk1zblVRdC9Ic3RPWm9OVkRQSzBXT2xhNHJPSW5ySmU2YnN2Nm50Vlgx?=
 =?utf-8?B?MmJXTzZ3VnZoMnpZV3ZOMjFWdkt4VHNYd1ZDN2VXSy9WVDM5QXJacEg2UHdE?=
 =?utf-8?B?OXc2S3pHQzZoOWRoalNidnhrUDZkQXFyWFF6UUU3eFlHL2tlYXNXbDNWYldr?=
 =?utf-8?B?SEc5d3RwVjh4QytsTk5JcjdhSGFVTHRSMGp6emV0V3Z1TkJ4YjJKUUVwZzlB?=
 =?utf-8?B?QUxBYW1jd3RvOGlhTTg3SGJJcVh2SGZWNTBlOWZqdmZSS2tCVVFnYzJ6NFk0?=
 =?utf-8?B?QU85cVY1VHJQWW5YLzFPd1FlN0ZFZ0hXQWpIQU03NVN5aFJVRm92bjBxOXAv?=
 =?utf-8?B?N3ozM2ZUOTNJZk43eTE1Mi9La2ZYWUU0R3NndHVhUWcyTDYvalZNVDRlcFFV?=
 =?utf-8?B?Wk5HUlNOUzc4QlhZOTlvREUwN0NidnVHVmwvY2lJL0hTSTRlUm0yWWNEeFZ5?=
 =?utf-8?B?WnVpbC9NRURUM2cwaVVqck5XSVAvMlViVTlKM1NPRVVTTUkweVBKSmpQdXpL?=
 =?utf-8?B?amtKUWt4RWIyRmJhOG9vbWRaeWdyUjA1bVA2QWs0UkNHeElwbVZkb3NROEJx?=
 =?utf-8?B?UTdaYU9sZ21qWkt0UHFVeHlYbjVRaHlDNm9ObE9IeVJDQmM3L2EyU0dFL3E1?=
 =?utf-8?B?bWpzeW05U21UdVhSZVBTWjg5b09yVDRrWUJNKzVWWGtISnNqSmVYOVc3SmVL?=
 =?utf-8?B?dzNiejBLNngrZXNqLzdBK1pNU0N1RjJqbE9SMU5hdG5TT1JiMyt2SWsza0di?=
 =?utf-8?B?TlFRcGh3REtnR3U3L0ZqV3FaSUJDb3JxUkV4UFoxeDdsM1FSQXk5TVVBN0dU?=
 =?utf-8?B?RTBTYVhiZCtBSVloeWVrTytUVXdZbjZaZXJLS1JKVU8xeEJmelhzb3ArQUlR?=
 =?utf-8?B?aEhkMjdvMVAza3dJaHVSNnRyczJyNncwUk9GbG55MGFxMHNaY2sxMUppb3M2?=
 =?utf-8?B?VHcrL2JHVzJKWFkzWUYvNjNDb1dpVXVQSkZ1OEZkSVpWbUJ3SkdrY2NaNjVE?=
 =?utf-8?B?dUpOSlRzb2Z5dStaZHFqSE1qL0p5ZVNhRklPSGpVSDZxWGZiMUJ4Y3h4cFF3?=
 =?utf-8?B?akxqYnlsNDhuZm1JN1JZbmVDcWhRcHhMc3dkc25TNXB0eUhaNnMyazdNM2Vu?=
 =?utf-8?B?WkR6eXZSeC9EdGUvTkJ1TWVQSm14ZGlwbVU4VENOalE4QU1sd3ZLOHo5THRE?=
 =?utf-8?B?b01HNGF3MkZFekYyS2ZBNTdvNm5qalRHeGNKSFd6QUxVY1BXcEg0eW9VRCtq?=
 =?utf-8?B?dnB4ZTJERDVmTUFmd2JhMFh3cHBCK2lxQWpIZDBPT204ZDZZVWhWSnI0UnJC?=
 =?utf-8?B?Q2tGUFJKSStVaEM3bVhVOW1INXozUXdObXE3Y3VYeHRYdlZyUTE5UzdoSmMz?=
 =?utf-8?B?TENKRTIzQ1JQK1hpNGZXbjlIWWFpdURCQTRIQUd0TzNkVG9QRVRhOVQwZUdl?=
 =?utf-8?B?WVJHNDRZOHBBRVl3ellsVnNLTFpLRVBiY0VXK09RNFRrcDUvSVUwWHFqdVJT?=
 =?utf-8?Q?3K2p3l?=
X-Microsoft-Antispam-Message-Info: XZa+SZ1q/ZqAQtJ0QZTPLoLm/Osudah66ToioUBAtFB1DdxIhSfCt5FWiVT9ZSkJlaiMuWzngV5eHxRGY6eJKYk/ey137HD478dgrPLFvTZORyFkqMbC+KwB2qT3/9VGjTNYw9V17zpN6x7Q7QwM9XFPLFXcLr3xHEzaJnfOlPa4gkwO4+GPtzsum/YZA1/KWlCWIsKHboRQbk+Bh78wADTgL+yHtYZsdiFGktgJZkLuroxcDQ1gj3I7W9EQp/ArUQDKygdEsFqsQjSsDD5N0ZDqk+yUWEOKPXkK0uRrVve2GjtFs+jqpw52TMv9RVzMtnJ4q4DNF12GcMuB/3cPLKoCP9dcjah18xqD73wYSi0=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:Mf0cbQiGEWTdXfvsV0vhZ9sof4GoQnePKn6JzpPEv/vHRDFXtb1V4PFaKSo5u23gtgQewMnYKjPsIpvryKA3T6s73rMIv0yqATXRJRhB9fEN+Y/H5nx7uYXoR1gSOf0cPB4RVYuEqJL+DTKLSBfXzTkw29bQPnd5QFxZ3nZtjjvkk8EsM6JIzjPA9+X3DJk7QWEwNlqwZOwCJdncwS5wD+4mvkuvzZdPEXqOKipLHsAEqgROEFv6h8ZGWhDAI0+WRUfQExQc7ORjCTUADh2NeJ0vc6PnLJNNO7FoZ8yHjsC131K79zrUlqzS1VHhNUm5UdgBOsV05m2Yke00S/etGT6gN4rps+B+xue2VShcmuGCGO7Rc748QS5ee1S9qCRc1cu02mR0+X1TMdbJtmiPeKkRxmXvKBPirhB+tS5uHUTR4g768n9bLbPXP1ftI4WPHwRzyVNVmRnMBgV8ahvciQ==;5:on/4Xkbe8MnrVZLHzLVLuZodglagXQYOvKobxY8l4cGD8gNx1HkDYPdbrfVjOcFCSVMNDyj8F9t51t6XDJ6tqj/7Z6VNtw8tVv3V0ZDr1U1cduanEwbK9Ug/PLP/HR+L3jyHgYY715wUTTPCpQX5ks+69885kwYBKuPxUCQchCM=;7:lWM66/pO1fRAc/3uZ7JFUQaPV7vTIXzb5zlWuD0EZdmDd0tYoa3PHyFEt/wgllF2lWRqx0suA+I/nRrnFBpgV7QaQDMxLuysaEihSevaIadjjeHsqPrNivao+3xafhZQAHSCner8JD67zMsI8XwbQoh5l+g+0HBl+ppz0X8FexuDYKRdy5By3B8f/22p+9+qaDZUXeHc+Wds1yZHwpfs8TLPwvZCiRDcfFPFbe+NGlAXT5+fS+9IaIG5lG7MMArH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:RJWnYJZuuSIAE8jRjuBsuRF60dWJwyGHdBMHuu/45ojUkOg3eip6JFlBZ11JJIcQdK07bJdkEIn/0NV/Qe0+zQELNFTkgWVoHEBIm59FGeaHTaVS85bn0KS5k2Vm3kkW5HxgyPAkRYVFyBtQkgmhUEMs8NHVBnxCK79pbiLuiyQixI3N0J/OhxZqXBaI4DxBRGK6up3el7wZ+a1L6H7lAB2Vp0OefgLzvssQNoY05+EDDkmoC+S0OvJlHIkt0zlM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 08:04:40.1822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daae32ae-9841-4bf8-ed80-08d60f1869d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.08.2018 um 20:53 schrieb Logan Gunthorpe:
> Some PCI devices may have memory mapped in a BAR space that's
> intended for use in peer-to-peer transactions. In order to enable
> such transactions the memory must be registered with ZONE_DEVICE pages
> so it can be used by DMA interfaces in existing drivers.

We want to use that feature without ZONE_DEVICE pages for DMA-buf as well.

How hard would it be to separate enabling P2P detection (e.g. distance 
between two devices) from this?

Regards,
Christian.

>
> Add an interface for other subsystems to find and allocate chunks of P2P
> memory as necessary to facilitate transfers between two PCI peers:
>
> int pci_p2pdma_add_client();
> struct pci_dev *pci_p2pmem_find();
> void *pci_alloc_p2pmem();
>
> The new interface requires a driver to collect a list of client devices
> involved in the transaction with the pci_p2pmem_add_client*() functions
> then call pci_p2pmem_find() to obtain any suitable P2P memory. Once
> this is done the list is bound to the memory and the calling driver is
> free to add and remove clients as necessary (adding incompatible clients
> will fail). With a suitable p2pmem device, memory can then be
> allocated with pci_alloc_p2pmem() for use in DMA transactions.
>
> Depending on hardware, using peer-to-peer memory may reduce the bandwidth
> of the transfer but can significantly reduce pressure on system memory.
> This may be desirable in many cases: for example a system could be designed
> with a small CPU connected to a PCIe switch by a small number of lanes
> which would maximize the number of lanes available to connect to NVMe
> devices.
>
> The code is designed to only utilize the p2pmem device if all the devices
> involved in a transfer are behind the same PCI bridge. This is because we
> have no way of knowing whether peer-to-peer routing between PCIe Root Ports
> is supported (PCIe r4.0, sec 1.3.1). Additionally, the benefits of P2P
> transfers that go through the RC is limited to only reducing DRAM usage
> and, in some cases, coding convenience. The PCI-SIG may be exploring
> adding a new capability bit to advertise whether this is possible for
> future hardware.
>
> This commit includes significant rework and feedback from Christoph
> Hellwig.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/Kconfig        |  17 +
>   drivers/pci/Makefile       |   1 +
>   drivers/pci/p2pdma.c       | 761 +++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/memremap.h   |   5 +
>   include/linux/mm.h         |  18 ++
>   include/linux/pci-p2pdma.h | 102 ++++++
>   include/linux/pci.h        |   4 +
>   7 files changed, 908 insertions(+)
>   create mode 100644 drivers/pci/p2pdma.c
>   create mode 100644 include/linux/pci-p2pdma.h
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 56ff8f6d31fc..deb68be4fdac 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -132,6 +132,23 @@ config PCI_PASID
>   
>   	  If unsure, say N.
>   
> +config PCI_P2PDMA
> +	bool "PCI peer-to-peer transfer support"
> +	depends on PCI && ZONE_DEVICE
> +	select GENERIC_ALLOCATOR
> +	help
> +	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
> +	  BARs that are exposed in other devices that are the part of
> +	  the hierarchy where peer-to-peer DMA is guaranteed by the PCI
> +	  specification to work (ie. anything below a single PCI bridge).
> +
> +	  Many PCIe root complexes do not support P2P transactions and
> +	  it's hard to tell which support it at all, so at this time,
> +	  P2P DMA transations must be between devices behind the same root
> +	  port.
> +
> +	  If unsure, say N.
> +
>   config PCI_LABEL
>   	def_bool y if (DMI || ACPI)
>   	depends on PCI
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 1b2cfe51e8d7..85f4a703b2be 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_PCI_SYSCALL)	+= syscall.o
>   obj-$(CONFIG_PCI_STUB)		+= pci-stub.o
>   obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
>   obj-$(CONFIG_PCI_ECAM)		+= ecam.o
> +obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   
>   # Endpoint library must be initialized before its users
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> new file mode 100644
> index 000000000000..88aaec5351cd
> --- /dev/null
> +++ b/drivers/pci/p2pdma.c
> @@ -0,0 +1,761 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Peer 2 Peer DMA support.
> + *
> + * Copyright (c) 2016-2018, Logan Gunthorpe
> + * Copyright (c) 2016-2017, Microsemi Corporation
> + * Copyright (c) 2017, Christoph Hellwig
> + * Copyright (c) 2018, Eideticom Inc.
> + */
> +
> +#define pr_fmt(fmt) "pci-p2pdma: " fmt
> +#include <linux/pci-p2pdma.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/genalloc.h>
> +#include <linux/memremap.h>
> +#include <linux/percpu-refcount.h>
> +#include <linux/random.h>
> +#include <linux/seq_buf.h>
> +
> +struct pci_p2pdma {
> +	struct percpu_ref devmap_ref;
> +	struct completion devmap_ref_done;
> +	struct gen_pool *pool;
> +	bool p2pmem_published;
> +};
> +
> +static void pci_p2pdma_percpu_release(struct percpu_ref *ref)
> +{
> +	struct pci_p2pdma *p2p =
> +		container_of(ref, struct pci_p2pdma, devmap_ref);
> +
> +	complete_all(&p2p->devmap_ref_done);
> +}
> +
> +static void pci_p2pdma_percpu_kill(void *data)
> +{
> +	struct percpu_ref *ref = data;
> +
> +	if (percpu_ref_is_dying(ref))
> +		return;
> +
> +	percpu_ref_kill(ref);
> +}
> +
> +static void pci_p2pdma_release(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +
> +	if (!pdev->p2pdma)
> +		return;
> +
> +	wait_for_completion(&pdev->p2pdma->devmap_ref_done);
> +	percpu_ref_exit(&pdev->p2pdma->devmap_ref);
> +
> +	gen_pool_destroy(pdev->p2pdma->pool);
> +	pdev->p2pdma = NULL;
> +}
> +
> +static int pci_p2pdma_setup(struct pci_dev *pdev)
> +{
> +	int error = -ENOMEM;
> +	struct pci_p2pdma *p2p;
> +
> +	p2p = devm_kzalloc(&pdev->dev, sizeof(*p2p), GFP_KERNEL);
> +	if (!p2p)
> +		return -ENOMEM;
> +
> +	p2p->pool = gen_pool_create(PAGE_SHIFT, dev_to_node(&pdev->dev));
> +	if (!p2p->pool)
> +		goto out;
> +
> +	init_completion(&p2p->devmap_ref_done);
> +	error = percpu_ref_init(&p2p->devmap_ref,
> +			pci_p2pdma_percpu_release, 0, GFP_KERNEL);
> +	if (error)
> +		goto out_pool_destroy;
> +
> +	percpu_ref_switch_to_atomic_sync(&p2p->devmap_ref);
> +
> +	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_release, pdev);
> +	if (error)
> +		goto out_pool_destroy;
> +
> +	pdev->p2pdma = p2p;
> +
> +	return 0;
> +
> +out_pool_destroy:
> +	gen_pool_destroy(p2p->pool);
> +out:
> +	devm_kfree(&pdev->dev, p2p);
> +	return error;
> +}
> +
> +/**
> + * pci_p2pdma_add_resource - add memory for use as p2p memory
> + * @pdev: the device to add the memory to
> + * @bar: PCI BAR to add
> + * @size: size of the memory to add, may be zero to use the whole BAR
> + * @offset: offset into the PCI BAR
> + *
> + * The memory will be given ZONE_DEVICE struct pages so that it may
> + * be used with any DMA request.
> + */
> +int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
> +			    u64 offset)
> +{
> +	struct dev_pagemap *pgmap;
> +	void *addr;
> +	int error;
> +
> +	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
> +		return -EINVAL;
> +
> +	if (offset >= pci_resource_len(pdev, bar))
> +		return -EINVAL;
> +
> +	if (!size)
> +		size = pci_resource_len(pdev, bar) - offset;
> +
> +	if (size + offset > pci_resource_len(pdev, bar))
> +		return -EINVAL;
> +
> +	if (!pdev->p2pdma) {
> +		error = pci_p2pdma_setup(pdev);
> +		if (error)
> +			return error;
> +	}
> +
> +	pgmap = devm_kzalloc(&pdev->dev, sizeof(*pgmap), GFP_KERNEL);
> +	if (!pgmap)
> +		return -ENOMEM;
> +
> +	pgmap->res.start = pci_resource_start(pdev, bar) + offset;
> +	pgmap->res.end = pgmap->res.start + size - 1;
> +	pgmap->res.flags = pci_resource_flags(pdev, bar);
> +	pgmap->ref = &pdev->p2pdma->devmap_ref;
> +	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
> +
> +	addr = devm_memremap_pages(&pdev->dev, pgmap);
> +	if (IS_ERR(addr)) {
> +		error = PTR_ERR(addr);
> +		goto pgmap_free;
> +	}
> +
> +	error = gen_pool_add_virt(pdev->p2pdma->pool, (unsigned long)addr,
> +			pci_bus_address(pdev, bar) + offset,
> +			resource_size(&pgmap->res), dev_to_node(&pdev->dev));
> +	if (error)
> +		goto pgmap_free;
> +
> +	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_percpu_kill,
> +					  &pdev->p2pdma->devmap_ref);
> +	if (error)
> +		goto pgmap_free;
> +
> +	pci_info(pdev, "added peer-to-peer DMA memory %pR\n",
> +		 &pgmap->res);
> +
> +	return 0;
> +
> +pgmap_free:
> +	devres_free(pgmap);
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
> +
> +static struct pci_dev *find_parent_pci_dev(struct device *dev)
> +{
> +	struct device *parent;
> +
> +	dev = get_device(dev);
> +
> +	while (dev) {
> +		if (dev_is_pci(dev))
> +			return to_pci_dev(dev);
> +
> +		parent = get_device(dev->parent);
> +		put_device(dev);
> +		dev = parent;
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * Check if a PCI bridge has it's ACS redirection bits set to redirect P2P
> + * TLPs upstream via ACS. Returns 1 if the packets will be redirected
> + * upstream, 0 otherwise.
> + */
> +static int pci_bridge_has_acs_redir(struct pci_dev *dev)
> +{
> +	int pos;
> +	u16 ctrl;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> +	if (!pos)
> +		return 0;
> +
> +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> +
> +	if (ctrl & (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *dev)
> +{
> +	if (!buf)
> +		return;
> +
> +	seq_buf_printf(buf, "%04x:%02x:%02x.%x;", pci_domain_nr(dev->bus),
> +		       dev->bus->number, PCI_SLOT(dev->devfn),
> +		       PCI_FUNC(dev->devfn));
> +}
> +
> +/*
> + * Find the distance through the nearest common upstream bridge between
> + * two PCI devices.
> + *
> + * If the two devices are the same device then 0 will be returned.
> + *
> + * If there are two virtual functions of the same device behind the same
> + * bridge port then 2 will be returned (one step down to the PCIe switch,
> + * then one step back to the same device).
> + *
> + * In the case where two devices are connected to the same PCIe switch, the
> + * value 4 will be returned. This corresponds to the following PCI tree:
> + *
> + *     -+  Root Port
> + *      \+ Switch Upstream Port
> + *       +-+ Switch Downstream Port
> + *       + \- Device A
> + *       \-+ Switch Downstream Port
> + *         \- Device B
> + *
> + * The distance is 4 because we traverse from Device A through the downstream
> + * port of the switch, to the common upstream port, back up to the second
> + * downstream port and then to Device B.
> + *
> + * Any two devices that don't have a common upstream bridge will return -1.
> + * In this way devices on separate PCIe root ports will be rejected, which
> + * is what we want for peer-to-peer seeing each PCIe root port defines a
> + * separate hierarchy domain and there's no way to determine whether the root
> + * complex supports forwarding between them.
> + *
> + * In the case where two devices are connected to different PCIe switches,
> + * this function will still return a positive distance as long as both
> + * switches evenutally have a common upstream bridge. Note this covers
> + * the case of using multiple PCIe switches to achieve a desired level of
> + * fan-out from a root port. The exact distance will be a function of the
> + * number of switches between Device A and Device B.
> + *
> + * If a bridge which has any ACS redirection bits set is in the path
> + * then this functions will return -2. This is so we reject any
> + * cases where the TLPs are forwarded up into the root complex.
> + * In this case, a list of all infringing bridge addresses will be
> + * populated in acs_list (assuming it's non-null) for printk purposes.
> + */
> +static int upstream_bridge_distance(struct pci_dev *a,
> +				    struct pci_dev *b,
> +				    struct seq_buf *acs_list)
> +{
> +	int dist_a = 0;
> +	int dist_b = 0;
> +	struct pci_dev *bb = NULL;
> +	int acs_cnt = 0;
> +
> +	/*
> +	 * Note, we don't need to take references to devices returned by
> +	 * pci_upstream_bridge() seeing we hold a reference to a child
> +	 * device which will already hold a reference to the upstream bridge.
> +	 */
> +
> +	while (a) {
> +		dist_b = 0;
> +
> +		if (pci_bridge_has_acs_redir(a)) {
> +			seq_buf_print_bus_devfn(acs_list, a);
> +			acs_cnt++;
> +		}
> +
> +		bb = b;
> +
> +		while (bb) {
> +			if (a == bb)
> +				goto check_b_path_acs;
> +
> +			bb = pci_upstream_bridge(bb);
> +			dist_b++;
> +		}
> +
> +		a = pci_upstream_bridge(a);
> +		dist_a++;
> +	}
> +
> +	return -1;
> +
> +check_b_path_acs:
> +	bb = b;
> +
> +	while (bb) {
> +		if (a == bb)
> +			break;
> +
> +		if (pci_bridge_has_acs_redir(bb)) {
> +			seq_buf_print_bus_devfn(acs_list, bb);
> +			acs_cnt++;
> +		}
> +
> +		bb = pci_upstream_bridge(bb);
> +	}
> +
> +	if (acs_cnt)
> +		return -2;
> +
> +	return dist_a + dist_b;
> +}
> +
> +static int upstream_bridge_distance_warn(struct pci_dev *provider,
> +					 struct pci_dev *client)
> +{
> +	struct seq_buf acs_list;
> +	int ret;
> +
> +	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> +
> +	ret = upstream_bridge_distance(provider, client, &acs_list);
> +	if (ret == -2) {
> +		pci_warn(client, "cannot be used for peer-to-peer DMA as ACS redirect is set between the client and provider\n");
> +		/* Drop final semicolon */
> +		acs_list.buffer[acs_list.len-1] = 0;
> +		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
> +			 acs_list.buffer);
> +
> +	} else if (ret < 0) {
> +		pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider do not share an upstream bridge\n");
> +	}
> +
> +	kfree(acs_list.buffer);
> +
> +	return ret;
> +}
> +
> +struct pci_p2pdma_client {
> +	struct list_head list;
> +	struct pci_dev *client;
> +	struct pci_dev *provider;
> +};
> +
> +/**
> + * pci_p2pdma_add_client - allocate a new element in a client device list
> + * @head: list head of p2pdma clients
> + * @dev: device to add to the list
> + *
> + * This adds @dev to a list of clients used by a p2pdma device.
> + * This list should be passed to pci_p2pmem_find(). Once pci_p2pmem_find() has
> + * been called successfully, the list will be bound to a specific p2pdma
> + * device and new clients can only be added to the list if they are
> + * supported by that p2pdma device.
> + *
> + * The caller is expected to have a lock which protects @head as necessary
> + * so that none of the pci_p2p functions can be called concurrently
> + * on that list.
> + *
> + * Returns 0 if the client was successfully added.
> + */
> +int pci_p2pdma_add_client(struct list_head *head, struct device *dev)
> +{
> +	struct pci_p2pdma_client *item, *new_item;
> +	struct pci_dev *provider = NULL;
> +	struct pci_dev *client;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_DMA_VIRT_OPS) && dev->dma_ops == &dma_virt_ops) {
> +		dev_warn(dev, "cannot be used for peer-to-peer DMA because the driver makes use of dma_virt_ops\n");
> +		return -ENODEV;
> +	}
> +
> +	client = find_parent_pci_dev(dev);
> +	if (!client) {
> +		dev_warn(dev, "cannot be used for peer-to-peer DMA as it is not a PCI device\n");
> +		return -ENODEV;
> +	}
> +
> +	item = list_first_entry_or_null(head, struct pci_p2pdma_client, list);
> +	if (item && item->provider) {
> +		provider = item->provider;
> +
> +		ret = upstream_bridge_distance_warn(provider, client);
> +		if (ret < 0) {
> +			ret = -EXDEV;
> +			goto put_client;
> +		}
> +	}
> +
> +	new_item = kzalloc(sizeof(*new_item), GFP_KERNEL);
> +	if (!new_item) {
> +		ret = -ENOMEM;
> +		goto put_client;
> +	}
> +
> +	new_item->client = client;
> +	new_item->provider = pci_dev_get(provider);
> +
> +	list_add_tail(&new_item->list, head);
> +
> +	return 0;
> +
> +put_client:
> +	pci_dev_put(client);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_add_client);
> +
> +static void pci_p2pdma_client_free(struct pci_p2pdma_client *item)
> +{
> +	list_del(&item->list);
> +	pci_dev_put(item->client);
> +	pci_dev_put(item->provider);
> +	kfree(item);
> +}
> +
> +/**
> + * pci_p2pdma_remove_client - remove and free a p2pdma client
> + * @head: list head of p2pdma clients
> + * @dev: device to remove from the list
> + *
> + * This removes @dev from a list of clients used by a p2pdma device.
> + * The caller is expected to have a lock which protects @head as necessary
> + * so that none of the pci_p2p functions can be called concurrently
> + * on that list.
> + */
> +void pci_p2pdma_remove_client(struct list_head *head, struct device *dev)
> +{
> +	struct pci_p2pdma_client *pos, *tmp;
> +	struct pci_dev *pdev;
> +
> +	pdev = find_parent_pci_dev(dev);
> +	if (!pdev)
> +		return;
> +
> +	list_for_each_entry_safe(pos, tmp, head, list) {
> +		if (pos->client != pdev)
> +			continue;
> +
> +		pci_p2pdma_client_free(pos);
> +	}
> +
> +	pci_dev_put(pdev);
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_remove_client);
> +
> +/**
> + * pci_p2pdma_client_list_free - free an entire list of p2pdma clients
> + * @head: list head of p2pdma clients
> + *
> + * This removes all devices in a list of clients used by a p2pdma device.
> + * The caller is expected to have a lock which protects @head as necessary
> + * so that none of the pci_p2pdma functions can be called concurrently
> + * on that list.
> + */
> +void pci_p2pdma_client_list_free(struct list_head *head)
> +{
> +	struct pci_p2pdma_client *pos, *tmp;
> +
> +	list_for_each_entry_safe(pos, tmp, head, list)
> +		pci_p2pdma_client_free(pos);
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_client_list_free);
> +
> +/**
> + * pci_p2pdma_distance - Determive the cumulative distance between
> + *	a p2pdma provider and the clients in use.
> + * @provider: p2pdma provider to check against the client list
> + * @clients: list of devices to check (NULL-terminated)
> + * @verbose: if true, print warnings for devices when we return -1
> + *
> + * Returns -1 if any of the clients are not compatible (behind the same
> + * root port as the provider), otherwise returns a positive number where
> + * the lower number is the preferrable choice. (If there's one client
> + * that's the same as the provider it will return 0, which is best choice).
> + *
> + * For now, "compatible" means the provider and the clients are all behind
> + * the same PCI root port. This cuts out cases that may work but is safest
> + * for the user. Future work can expand this to white-list root complexes that
> + * can safely forward between each ports.
> + */
> +int pci_p2pdma_distance(struct pci_dev *provider, struct list_head *clients,
> +			bool verbose)
> +{
> +	struct pci_p2pdma_client *pos;
> +	int ret;
> +	int distance = 0;
> +	bool not_supported = false;
> +
> +	if (list_empty(clients))
> +		return -1;
> +
> +	list_for_each_entry(pos, clients, list) {
> +		if (verbose)
> +			ret = upstream_bridge_distance_warn(provider,
> +							    pos->client);
> +		else
> +			ret = upstream_bridge_distance(provider, pos->client,
> +						       NULL);
> +
> +		if (ret < 0)
> +			not_supported = true;
> +
> +		if (not_supported && !verbose)
> +			break;
> +
> +		distance += ret;
> +	}
> +
> +	if (not_supported)
> +		return -1;
> +
> +	return distance;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_distance);
> +
> +/**
> + * pci_p2pdma_assign_provider - Check compatibily (as per pci_p2pdma_distance)
> + *	and assign a provider to a list of clients
> + * @provider: p2pdma provider to assign to the client list
> + * @clients: list of devices to check (NULL-terminated)
> + *
> + * Returns false if any of the clients are not compatible, true if the
> + * provider was successfully assigned to the clients.
> + */
> +bool pci_p2pdma_assign_provider(struct pci_dev *provider,
> +				struct list_head *clients)
> +{
> +	struct pci_p2pdma_client *pos;
> +
> +	if (pci_p2pdma_distance(provider, clients, true) < 0)
> +		return false;
> +
> +	list_for_each_entry(pos, clients, list)
> +		pos->provider = provider;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_assign_provider);
> +
> +/**
> + * pci_has_p2pmem - check if a given PCI device has published any p2pmem
> + * @pdev: PCI device to check
> + */
> +bool pci_has_p2pmem(struct pci_dev *pdev)
> +{
> +	return pdev->p2pdma && pdev->p2pdma->p2pmem_published;
> +}
> +EXPORT_SYMBOL_GPL(pci_has_p2pmem);
> +
> +/**
> + * pci_p2pmem_find - find a peer-to-peer DMA memory device compatible with
> + *	the specified list of clients and shortest distance (as determined
> + *	by pci_p2pmem_dma())
> + * @clients: list of devices to check (NULL-terminated)
> + *
> + * If multiple devices are behind the same switch, the one "closest" to the
> + * client devices in use will be chosen first. (So if one of the providers are
> + * the same as one of the clients, that provider will be used ahead of any
> + * other providers that are unrelated). If multiple providers are an equal
> + * distance away, one will be chosen at random.
> + *
> + * Returns a pointer to the PCI device with a reference taken (use pci_dev_put
> + * to return the reference) or NULL if no compatible device is found. The
> + * found provider will also be assigned to the client list.
> + */
> +struct pci_dev *pci_p2pmem_find(struct list_head *clients)
> +{
> +	struct pci_dev *pdev = NULL;
> +	struct pci_p2pdma_client *pos;
> +	int distance;
> +	int closest_distance = INT_MAX;
> +	struct pci_dev **closest_pdevs;
> +	int dev_cnt = 0;
> +	const int max_devs = PAGE_SIZE / sizeof(*closest_pdevs);
> +	int i;
> +
> +	closest_pdevs = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +
> +	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev))) {
> +		if (!pci_has_p2pmem(pdev))
> +			continue;
> +
> +		distance = pci_p2pdma_distance(pdev, clients, false);
> +		if (distance < 0 || distance > closest_distance)
> +			continue;
> +
> +		if (distance == closest_distance && dev_cnt >= max_devs)
> +			continue;
> +
> +		if (distance < closest_distance) {
> +			for (i = 0; i < dev_cnt; i++)
> +				pci_dev_put(closest_pdevs[i]);
> +
> +			dev_cnt = 0;
> +			closest_distance = distance;
> +		}
> +
> +		closest_pdevs[dev_cnt++] = pci_dev_get(pdev);
> +	}
> +
> +	if (dev_cnt)
> +		pdev = pci_dev_get(closest_pdevs[prandom_u32_max(dev_cnt)]);
> +
> +	for (i = 0; i < dev_cnt; i++)
> +		pci_dev_put(closest_pdevs[i]);
> +
> +	if (pdev)
> +		list_for_each_entry(pos, clients, list)
> +			pos->provider = pdev;
> +
> +	kfree(closest_pdevs);
> +	return pdev;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pmem_find);
> +
> +/**
> + * pci_alloc_p2p_mem - allocate peer-to-peer DMA memory
> + * @pdev: the device to allocate memory from
> + * @size: number of bytes to allocate
> + *
> + * Returns the allocated memory or NULL on error.
> + */
> +void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
> +{
> +	void *ret;
> +
> +	if (unlikely(!pdev->p2pdma))
> +		return NULL;
> +
> +	if (unlikely(!percpu_ref_tryget_live(&pdev->p2pdma->devmap_ref)))
> +		return NULL;
> +
> +	ret = (void *)gen_pool_alloc(pdev->p2pdma->pool, size);
> +
> +	if (unlikely(!ret))
> +		percpu_ref_put(&pdev->p2pdma->devmap_ref);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_alloc_p2pmem);
> +
> +/**
> + * pci_free_p2pmem - allocate peer-to-peer DMA memory
> + * @pdev: the device the memory was allocated from
> + * @addr: address of the memory that was allocated
> + * @size: number of bytes that was allocated
> + */
> +void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size)
> +{
> +	gen_pool_free(pdev->p2pdma->pool, (uintptr_t)addr, size);
> +	percpu_ref_put(&pdev->p2pdma->devmap_ref);
> +}
> +EXPORT_SYMBOL_GPL(pci_free_p2pmem);
> +
> +/**
> + * pci_virt_to_bus - return the PCI bus address for a given virtual
> + *	address obtained with pci_alloc_p2pmem()
> + * @pdev: the device the memory was allocated from
> + * @addr: address of the memory that was allocated
> + */
> +pci_bus_addr_t pci_p2pmem_virt_to_bus(struct pci_dev *pdev, void *addr)
> +{
> +	if (!addr)
> +		return 0;
> +	if (!pdev->p2pdma)
> +		return 0;
> +
> +	/*
> +	 * Note: when we added the memory to the pool we used the PCI
> +	 * bus address as the physical address. So gen_pool_virt_to_phys()
> +	 * actually returns the bus address despite the misleading name.
> +	 */
> +	return gen_pool_virt_to_phys(pdev->p2pdma->pool, (unsigned long)addr);
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pmem_virt_to_bus);
> +
> +/**
> + * pci_p2pmem_alloc_sgl - allocate peer-to-peer DMA memory in a scatterlist
> + * @pdev: the device to allocate memory from
> + * @sgl: the allocated scatterlist
> + * @nents: the number of SG entries in the list
> + * @length: number of bytes to allocate
> + *
> + * Returns 0 on success
> + */
> +struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
> +					 unsigned int *nents, u32 length)
> +{
> +	struct scatterlist *sg;
> +	void *addr;
> +
> +	sg = kzalloc(sizeof(*sg), GFP_KERNEL);
> +	if (!sg)
> +		return NULL;
> +
> +	sg_init_table(sg, 1);
> +
> +	addr = pci_alloc_p2pmem(pdev, length);
> +	if (!addr)
> +		goto out_free_sg;
> +
> +	sg_set_buf(sg, addr, length);
> +	*nents = 1;
> +	return sg;
> +
> +out_free_sg:
> +	kfree(sg);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pmem_alloc_sgl);
> +
> +/**
> + * pci_p2pmem_free_sgl - free a scatterlist allocated by pci_p2pmem_alloc_sgl()
> + * @pdev: the device to allocate memory from
> + * @sgl: the allocated scatterlist
> + * @nents: the number of SG entries in the list
> + */
> +void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl)
> +{
> +	struct scatterlist *sg;
> +	int count;
> +
> +	for_each_sg(sgl, sg, INT_MAX, count) {
> +		if (!sg)
> +			break;
> +
> +		pci_free_p2pmem(pdev, sg_virt(sg), sg->length);
> +	}
> +	kfree(sgl);
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pmem_free_sgl);
> +
> +/**
> + * pci_p2pmem_publish - publish the peer-to-peer DMA memory for use by
> + *	other devices with pci_p2pmem_find()
> + * @pdev: the device with peer-to-peer DMA memory to publish
> + * @publish: set to true to publish the memory, false to unpublish it
> + *
> + * Published memory can be used by other PCI device drivers for
> + * peer-2-peer DMA operations. Non-published memory is reserved for
> + * exlusive use of the device driver that registers the peer-to-peer
> + * memory.
> + */
> +void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
> +{
> +	if (publish && !pdev->p2pdma)
> +		return;
> +
> +	pdev->p2pdma->p2pmem_published = publish;
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index f91f9e763557..9553370ebdad 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -53,11 +53,16 @@ struct vmem_altmap {
>    * wakeup event whenever a page is unpinned and becomes idle. This
>    * wakeup is used to coordinate physical address space management (ex:
>    * fs truncate/hole punch) vs pinned pages (ex: device dma).
> + *
> + * MEMORY_DEVICE_PCI_P2PDMA:
> + * Device memory residing in a PCI BAR intended for use with Peer-to-Peer
> + * transactions.
>    */
>   enum memory_type {
>   	MEMORY_DEVICE_PRIVATE = 1,
>   	MEMORY_DEVICE_PUBLIC,
>   	MEMORY_DEVICE_FS_DAX,
> +	MEMORY_DEVICE_PCI_P2PDMA,
>   };
>   
>   /*
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a61ebe8ad4ca..2055df412a77 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -890,6 +890,19 @@ static inline bool is_device_public_page(const struct page *page)
>   		page->pgmap->type == MEMORY_DEVICE_PUBLIC;
>   }
>   
> +#ifdef CONFIG_PCI_P2PDMA
> +static inline bool is_pci_p2pdma_page(const struct page *page)
> +{
> +	return is_zone_device_page(page) &&
> +		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
> +}
> +#else /* CONFIG_PCI_P2PDMA */
> +static inline bool is_pci_p2pdma_page(const struct page *page)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_PCI_P2PDMA */
> +
>   #else /* CONFIG_DEV_PAGEMAP_OPS */
>   static inline void dev_pagemap_get_ops(void)
>   {
> @@ -913,6 +926,11 @@ static inline bool is_device_public_page(const struct page *page)
>   {
>   	return false;
>   }
> +
> +static inline bool is_pci_p2pdma_page(const struct page *page)
> +{
> +	return false;
> +}
>   #endif /* CONFIG_DEV_PAGEMAP_OPS */
>   
>   static inline void get_page(struct page *page)
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> new file mode 100644
> index 000000000000..7b2b0f547528
> --- /dev/null
> +++ b/include/linux/pci-p2pdma.h
> @@ -0,0 +1,102 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PCI Peer 2 Peer DMA support.
> + *
> + * Copyright (c) 2016-2018, Logan Gunthorpe
> + * Copyright (c) 2016-2017, Microsemi Corporation
> + * Copyright (c) 2017, Christoph Hellwig
> + * Copyright (c) 2018, Eideticom Inc.
> + *
> + */
> +
> +#ifndef _LINUX_PCI_P2PDMA_H
> +#define _LINUX_PCI_P2PDMA_H
> +
> +#include <linux/pci.h>
> +
> +struct block_device;
> +struct scatterlist;
> +
> +#ifdef CONFIG_PCI_P2PDMA
> +int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
> +		u64 offset);
> +int pci_p2pdma_add_client(struct list_head *head, struct device *dev);
> +void pci_p2pdma_remove_client(struct list_head *head, struct device *dev);
> +void pci_p2pdma_client_list_free(struct list_head *head);
> +int pci_p2pdma_distance(struct pci_dev *provider, struct list_head *clients,
> +			bool verbose);
> +bool pci_p2pdma_assign_provider(struct pci_dev *provider,
> +				struct list_head *clients);
> +bool pci_has_p2pmem(struct pci_dev *pdev);
> +struct pci_dev *pci_p2pmem_find(struct list_head *clients);
> +void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size);
> +void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size);
> +pci_bus_addr_t pci_p2pmem_virt_to_bus(struct pci_dev *pdev, void *addr);
> +struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
> +					 unsigned int *nents, u32 length);
> +void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
> +void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
> +#else /* CONFIG_PCI_P2PDMA */
> +static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
> +		size_t size, u64 offset)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int pci_p2pdma_add_client(struct list_head *head,
> +		struct device *dev)
> +{
> +	return 0;
> +}
> +static inline void pci_p2pdma_remove_client(struct list_head *head,
> +		struct device *dev)
> +{
> +}
> +static inline void pci_p2pdma_client_list_free(struct list_head *head)
> +{
> +}
> +static inline int pci_p2pdma_distance(struct pci_dev *provider,
> +				      struct list_head *clients,
> +				      bool verbose)
> +{
> +	return -1;
> +}
> +static inline bool pci_p2pdma_assign_provider(struct pci_dev *provider,
> +					      struct list_head *clients)
> +{
> +	return false;
> +}
> +static inline bool pci_has_p2pmem(struct pci_dev *pdev)
> +{
> +	return false;
> +}
> +static inline struct pci_dev *pci_p2pmem_find(struct list_head *clients)
> +{
> +	return NULL;
> +}
> +static inline void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
> +{
> +	return NULL;
> +}
> +static inline void pci_free_p2pmem(struct pci_dev *pdev, void *addr,
> +		size_t size)
> +{
> +}
> +static inline pci_bus_addr_t pci_p2pmem_virt_to_bus(struct pci_dev *pdev,
> +						    void *addr)
> +{
> +	return 0;
> +}
> +static inline struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
> +		unsigned int *nents, u32 length)
> +{
> +	return NULL;
> +}
> +static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
> +		struct scatterlist *sgl)
> +{
> +}
> +static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
> +{
> +}
> +#endif /* CONFIG_PCI_P2PDMA */
> +#endif /* _LINUX_PCI_P2P_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e72ca8dd6241..5d95dbf21f4a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -281,6 +281,7 @@ struct pcie_link_state;
>   struct pci_vpd;
>   struct pci_sriov;
>   struct pci_ats;
> +struct pci_p2pdma;
>   
>   /* The pci_dev structure describes PCI devices */
>   struct pci_dev {
> @@ -439,6 +440,9 @@ struct pci_dev {
>   #ifdef CONFIG_PCI_PASID
>   	u16		pasid_features;
>   #endif
> +#ifdef CONFIG_PCI_P2PDMA
> +	struct pci_p2pdma *p2pdma;
> +#endif
>   	phys_addr_t	rom;		/* Physical address if not from BAR */
>   	size_t		romlen;		/* Length if not from BAR */
>   	char		*driver_override; /* Driver name to force a match */

