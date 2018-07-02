Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F8EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0E524CA2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="pGnRpJZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0E524CA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932309AbeGBX2a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:28:30 -0400
Received: from mail-bn3nam01on0041.outbound.protection.outlook.com ([104.47.33.41]:55353
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932098AbeGBX21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvgjb4N5bODBpESJJFSq9NYijjyZ14pNvr+LQK2hq6M=;
 b=pGnRpJZzdUskjmQrs+6RegJRaxVw2lPWfqDaY95WTA9D635uBM8Gl+I6QiKOeBPiLKh6adccCcf2LBPIXBUc3XPoVrEC0xvDcwvJWaYCmQ/MIFlH3f3Ytfdkp+gks1/o0U/r/8tueMRXC6q0x43h5gSlIhFZAEjL1ap7R3bOX9I=
Received: from promb-2s-dhcp76.eng.vmware.com (66.170.99.1) by
 SN6PR05MB3997.namprd05.prod.outlook.com (2603:10b6:805:17::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.11; Mon, 2 Jul 2018 23:28:24 +0000
Subject: Re: [PATCH v2] vmw_pvrdma: Release netdev when vmxnet3 module is
 removed
To:     Neil Horman <nhorman@tuxdriver.com>, linux-rdma@vger.kernel.org
Cc:     VMware PV-Drivers <pv-drivers@vmware.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
References: <20180628135938.19625-1-nhorman@tuxdriver.com>
 <20180629115206.18787-1-nhorman@tuxdriver.com>
From:   Adit Ranadive <aditr@vmware.com>
Message-ID: <d771bd89-dd0c-f808-f50a-544947435f6b@vmware.com>
Date:   Mon, 2 Jul 2018 16:30:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629115206.18787-1-nhorman@tuxdriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [66.170.99.1]
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SN6PR05MB3997.namprd05.prod.outlook.com
 (2603:10b6:805:17::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 524d7587-3dd5-4e51-d29f-08d5e07381f3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB3997;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB3997;3:PFStUuVElyQMaqZGD+Tk7k9h+gJeHSO1IrxrKPVh6saDzjGj/cfAHBpmcwa4VKUaR7pMfHvWjQ8HpH3NPkH6FMp05iaMDiXyDJU7Q5JB/OluC7XqW7ACiejOziMV45Uq5+ZP8qCSNGSWipJW4vnB8dyp3F4OQK/wI8nUOvhWSlV4f+lxHzYBBSu8GQoUvvd/srSwgurwroMlaQF8cJgRPxGdKdpeqoxM+ZsXBq39XMln0Nojm0yR5eZFEqE9Bvl+;25:U1fHR8VeYXwwYrIHcT6H3T2xciz+h6mIMwaWDtWz574/mPInl5xUWFSesTGjNCCNcs68JuAXHZzCAfnRh0uSHfjWlpwCQ1Uj41cHN5myBCEFOpWUq6f/dJZwcYujKP5EGkuUYYp9dirxZUEnaD5h2/I0LCynYfmtznF+4swp87nx1ecmhEYIQJq5xAeocxAsAo9sFmCzKI+XomA0rsbllrgkTopNJTyHr7gF9NRWTpvZDhshivhaxjPhadfYL7XPDNat9mxPe1vRDSflEDNB6GfyrPWB2iIwUtpkZ5KFvWJKpMY50ygzWao72bBLB87GDfvGv2arlUr8TOln+NhGfA==;31:PZGmxBljkXx4HX2H44lXvRenrH9AQAQntfD5GgBklp8bkYBQB1rJweEtlpQbWvVg2QcaElyEb/Wdj0IDK2WRJpWfTjQMvhn2dOEq+feEnekphuJZFUBZcnvYkpYy220EG6c3OyjUj+/PQG55camzyNdQ4Yyrdbn9BE8DBU6pK5xn2EkZRKv2kojL9mU2+FGy69ZO+gjjJ7hukjlVFTfK6loblKH0/8YTBbQF2LONcHA=
X-MS-TrafficTypeDiagnostic: SN6PR05MB3997:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB3997;20:zbVr+PE+KdHMnPuKwtUWM9DR1zlnFk1WkqSKSlhwbUJQYfleozqhEh8VeyJuBRDnig4xbGIJZTUuniSK+yan4FPSvAw+5dSD3E79+A9AK5ly+kNU56lU12IembDVG12TQu8NS8X8S7QJCunmZvj8R26pXCqcxWK6jFvLiJwVTAN1osFgvuJPEPmPAZ7/32U+cNkPDVHspl9XR0PIfPRhfkAVlM+F+2A0IJyjap/S3Od1LiIIKYUtlMBgDQ2jo7k8m3z2c32VgnuxFAF2nIc8+UzLIDH3C8gPON+043Nc7Yb0EyVa2HdlOhiwdDEYIetgo8jTHZMcudribJw9SE1fieHi38aZ7op7f1X73a6J2d+rNzqlZhwYqOGgpMgmRUkCu68RaJEkbKro8HAqimsnYUeLcvAIRgllJnkUiDFO2edLl/ZEYzcusQex25o+brZtZhZjCoMrZVFXhEJkiwzpDIX52hEJljAaCBns62MBv+nJwbt8VDBu+yXFeFiWUjcd;4:FawTgU8QNMrLLEypkYTozD8UREK/qj0NCQ7rHd9wDSt9ArOT3xLmTetSXadOEbjflTwl6/GF3Rh8Uc/AhPz2w9Gb8qaoi7/tpHkX7zqcZRHg+H/j/+Ih3ycQWd27kARpCv1hTnkKVUISnwGAYwLQYFY10tvbzs5iSfVwNMNKXGVbPTah+7Ms4mLtQYcSDq56BL4DVJkwIF901mRP+IF9I39NkW1X76GvLLhY8oWpOUP0X2KqVcUItWVxXd186iGfDGMaX69q0/FA0SnuNX5EKQqFejk0P8LV05FEkJUtrz0N7MX9PA1X4w+Qu+BXick+jfTYMkZwsQJJA5nEUWkWaPsGhUCugVft3+5tIdBzavc=
X-Microsoft-Antispam-PRVS: <SN6PR05MB39978BBA15EDD49F699CFEF5C5430@SN6PR05MB3997.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR05MB3997;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB3997;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(4326008)(6116002)(14444005)(476003)(956004)(446003)(2616005)(86362001)(105586002)(76176011)(478600001)(230700001)(575784001)(11346002)(3846002)(6666003)(106356001)(6246003)(229853002)(2906002)(6486002)(486006)(65826007)(31686004)(64126003)(25786009)(65806001)(47776003)(7736002)(53936002)(97736004)(68736007)(5660300001)(2486003)(8936002)(31696002)(36756003)(53546011)(386003)(26005)(52146003)(23676004)(7696005)(66066001)(52116002)(54906003)(16526019)(186003)(58126008)(316002)(8676002)(50466002)(65956001)(81156014)(81166006)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB3997;H:promb-2s-dhcp76.eng.vmware.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjA1TUIzOTk3OzIzOlM4aUxCUHA2R2dPUCtCdjkvUFZJZzF5c1I4?=
 =?utf-8?B?ZGlacHRja0R1SEY2WWZnNDgyNUMrclRMQTVZeHBZR2pzOHRPSkp4V1JtYWhq?=
 =?utf-8?B?c091cjZxYUM2a3J2KzBJNUkyNXE5OW9CV1N5VU53NTFLb01jNGZNSkltK1JM?=
 =?utf-8?B?Qmx4L3l2ZVNFZVJlNFBMWktyRmVDQ1BxT1k4VzBtdXpGUStRTmQ1U1Q0TWZ3?=
 =?utf-8?B?V0RGTys4WDhDdVJrUVAyTTBBS1VlR1ljcncyWHNQY0Q2UW84TENaa2dtVyt0?=
 =?utf-8?B?THpEbFVOQnVyaDIzK3V0emlkMzEvdnlic2hGZnBZSmdsT05HdE9xRXByT3N2?=
 =?utf-8?B?NmhRczBhMjJITU80WjFVY0V4aFZGTHREdUlvb29NWC90N0d2L01hQ2lBVjkz?=
 =?utf-8?B?MkhTUnBjdStFRnczcTF3eXQ4RzJQalVZOU1uMTRxMmxXOGcwWlAzRTdVK2VD?=
 =?utf-8?B?ZEdPZXNrVys1SnlKOURncUFRK3RQOUtZc1JLc21paFZSSUl5MmdMNlNlWmhS?=
 =?utf-8?B?d2dnazExQ0xBTG9kUjVlRWpZd2hWajVlY3VGMWRtbnl4L2tYbE02R2lKLzc5?=
 =?utf-8?B?a3lEVWpMZjZvdnpjUm93ZkgzbTU2N3cwT0xjRDBDeStSQWNSRTN0SGN1SUVR?=
 =?utf-8?B?TWhCYjR6c2I1VmZOMkloTC9yNkFYY3ZGRHJMaVJodk10RHduaDZmbzZSVzVh?=
 =?utf-8?B?OUd4VUg3ZXFUS2c5R0c3aytIeFBlV0dFVTJLUHVXK0xvUGRzMWlYQmFLK1pp?=
 =?utf-8?B?Y0NDQnBLeVJpS25vYXdHd1dFWUV1MEdtcG1yOVZiS3l4dEx0MGo2RGM1THhx?=
 =?utf-8?B?M0JKT0VxZWgrTnUvYXZDaFhSa0g1UUNKWHlMUzdVSklMUE5zOFB5V3FtKy9n?=
 =?utf-8?B?MTE2Y3lzTzNRYkltbmtyUkVTK0pNZVhCVVNKZzl1dkFydEM5YWZXNE9vNkhF?=
 =?utf-8?B?QTJVT0IwNEpkTHBTRU5ERmZIUStnTkJXNXJwT2E4MzlzSW9VTkxPK0NQUW5q?=
 =?utf-8?B?KzhkbGhGdXVqelk2dnhXa09BUWJJem9PekNBM2krMG5hbjNNNVYxRFo2ejk2?=
 =?utf-8?B?QUZBNEwvdndwTUFUOCs2SGRZOVJOSDkySVl5NmFlekU1c0ZwY0tWSDRYcUd5?=
 =?utf-8?B?Z3FiNktxQVgwUURmeG9Gd1d3Tmp1cUYvTkRSWG5ENmJ2WkRvd0dBb0djdkUx?=
 =?utf-8?B?N1VWRThqWDQ3K1RuMGpiUUUzOVhZWWszK3ZEVFl1YXdObklsbWd6OXpQaE81?=
 =?utf-8?B?Sm95eis5OHY5a1VCZ21vM3FCT2E1bVFBeVhZa0xHdlpCSTU4ejBUUWJpY3ZI?=
 =?utf-8?B?d2VxOUh3SlZJSXJHaHdoZFRRR0R4V1A3YlVJRTZvY21JZjJ0N01UZjduV1N1?=
 =?utf-8?B?eCtOeDByK2F4N3lSUElQV3NFSUNGRWFLSFVRVXRJQW5GcXJwTWZFOWkvTXRZ?=
 =?utf-8?B?aWpPYTBLbnZ6NEdRWHZLbEZjUm9LNCtmQngxaFhhZE5EbFJud25ORDFaWmpX?=
 =?utf-8?B?MDVKNXg0cUxvL0NpenJuZzR6ajJXbnUvYlI2Q1ZTREVwZzlVSTEycVdUUUdK?=
 =?utf-8?B?M2dsTkI3aXQzeGhJSmhsUWJGWXl3VEVreHQ0b3RYb2h3TWJZNzY3UGsybm42?=
 =?utf-8?B?S2ZGS3BsZWRVd3FxNUs4NDErM0VmaFJJTk9EYzZEZDN2MVEzM3FSaVdxN2g4?=
 =?utf-8?B?RnovK2N2UlZKMUZKcjFFKzFweHdhNy95akNlQkxLOC9rZzk3d0V3eG5OME1Y?=
 =?utf-8?B?dW5DN3BQaFpmZUQzMEtnSGdNZ0FOVm1acVZrMFBRYWx3dTVwa0ExODFGREZI?=
 =?utf-8?B?UmoyY3dDVHFwSmRoTGJCQnh4T3YxMzNFdmdzMHgwdm1lR0VhYS9WMnJ6NGE4?=
 =?utf-8?Q?14xGO4OmgBxq5LSjKX6cymq3Xfx7lKVw?=
X-Microsoft-Antispam-Message-Info: YtibURv6TlHY/5uj7mG7eUGpuxMBCbraXsgq8pvm8rzRo+ummreHjT9C9Aam1iZoynVpw4UmSS8EtO56DM/iIB2OiRfqsDV81/2PA6/aBPaBRQKNSqxttEfAiwuO0oNmwLCWRIIL7RjgiPIghtGyOrCguYPVcjZ6VcfjD9vN0MdHgGg5FbcZFtgblXOEuN1MM+tuisJFwQGCra+Kh7vQCgrATNgNvCAH9Jgfr3fPadk1qRG8IJgQCjus7GqswTjMe5h2ZJUmyyyWxhkE1Qq95uzGrWKm9uxWvGFB1u5yRA+6XAjF9B/deu2sU76ADrizLgpwnY8bEpvUabqaLhlI5FP5gUGfm+ZCXrUDtfjvUvo=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB3997;6:3Ccu6KGhpVc+9oJu+axnUFxdgGGdLR2hHQGB4XeYA0pmPJDCRx5Jp0ncMN0NsjD/onIVzLeJWi4rZyssPGlV9lORUTWAg4RKHYqdZbJnmRvZSIuYNytAq4AvtFmdXZtRm5FODLAC0hsx3JSEu87lj7Nn4Lv6L2zYRQCrW5OW2YtRxKVRI6ujYc7PBML9GuHqVTDewECK1WL3V1EL1UEJe4Hm46LpZ5FvYLxgxz9yFCYvbvhyJUzv6s9g5hfWdPZv52h6+L1p8jw1wDAQM5x22SIbr0fQh5Q5HauwnOxHeM0PFlEAAIg3YASeykyUzycxN1is0NN72tbTxpoF92yuB2cuX/1GNYVYiS8ThSyp7ihKz7K/d9aaqt5qeDe9+TrLY5bKWjim+cQceBayap7fTsHrrE5R2CXCNR26rlnQPsd/5ATUjEW4t2j+uKv46zvW3ST5tJkhSPTn5UyYjPfovg==;5:+yfDMVyqYu3PDTrlGKsoZrPH0oW/MCRZNSkwbyGnqZ5Cx+4/xvPmls/NXjFR63UzlH7d2SubtNqRBimuGM41HbU7A8df8E/wBsA5O0vxWruvhVbtl8QMt7of7FGJxDSoH4sN7kNm9sCkRxg1I0m7+IadwPbtB5z/BGWSRWQe7nk=;24:M1s94MsBzEc2M7VPJmdILFFoMCjURy7pL8BePmbhYTFOXMhmax9SJqqUhNXUqcR1uto1dhNo8bajFsKSzYKsN1XOY/M5AgjChfSIrlnFCo4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB3997;7:AmVXxYgWJ/L6lPcnasKStIKDsDkf0bcoN6q0mRCQ6bplrH2VaOMNsUwcQA+rvyBW8nxup2xG7FmgiApJ2cEXAjuxcapBsDnbhSbastJrCdEcMAW6+SptuIQis2ixt13CX7e4i3MSt9Ro4ihSxqI+sZweER4GdM7B+bLGoIJlD9wZmiRM0I9KLUhhBYoFYlsP98X7VOcpDbN+EESCol/sHGYDQn0f3gx8DoJKERzSf3PUnrI2wr6PBAh6Ac1gnz7p;20:VIBTSmuebKIyYklGZqshDF+x/fD/kc+hqE5C7ivf+VW5IVehgLHcMSkoK4rHF33+BgdKg7jSdlZHcZR4oN5aEF80oa6/v1KJxF/6Ffs54PiSgGj7pX+4YpN3GpJILQt+Y5r7QsdOK6eTMQ52V5XUFSwKHz0uRKqk6hKCwrxoa30=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 23:28:24.5521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 524d7587-3dd5-4e51-d29f-08d5e07381f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB3997
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/18 4:52 AM, Neil Horman wrote:
> On repeated module load/unload cycles, its possible for the pvrmda
> driver to encounter this crash:
> 
> ...
> 297.032448] RIP: 0010:[<ffffffff839e4620>]  [<ffffffff839e4620>] netdev_walk_all_upper_dev_rcu+0x50/0xb0
> [  297.034078] RSP: 0018:ffff95087780bd08  EFLAGS: 00010286
> [  297.034986] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff95087a0c0000
> [  297.036196] RDX: ffff95087a0c0000 RSI: ffffffff839e44e0 RDI: ffff950835d0c000
> [  297.037421] RBP: ffff95087780bd40 R08: ffff95087a0e0ea0 R09: abddacd03f8e0ea0
> [  297.038636] R10: abddacd03f8e0ea0 R11: ffffef5901e9dbc0 R12: ffff95087a0c0000
> [  297.039854] R13: ffffffff839e44e0 R14: ffff95087a0c0000 R15: ffff950835d0c828
> [  297.041071] FS:  0000000000000000(0000) GS:ffff95087fc00000(0000) knlGS:0000000000000000
> [  297.042443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  297.043429] CR2: ffffffffffffffe8 CR3: 000000007a652000 CR4: 00000000003607f0
> [  297.044674] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  297.045893] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  297.047109] Call Trace:
> [  297.047545]  [<ffffffff839e4698>] netdev_has_upper_dev_all_rcu+0x18/0x20
> [  297.048691]  [<ffffffffc05d31af>] is_eth_port_of_netdev+0x2f/0xa0 [ib_core]
> [  297.049886]  [<ffffffffc05d3180>] ? is_eth_active_slave_of_bonding_rcu+0x70/0x70 [ib_core]
> ...
> 
> This occurs because vmw_pvrdma on probe stores a pointer to the netdev
> that exists on function 0 of the same bus/device/slot (which represents
> the vmxnet3 ethernet driver).  However, it never removes this pointer if
> the vmxnet3 module is removed, leading to crashes resulting from use
> after free dereferencing incidents like the one above.
> 
> The fix is pretty straightforward.  vmw_pvrdma should listen for
> NETDEV_REGISTER and NETDEV_UNREGISTER events in its event listener code
> block, and update the stored netdev pointer accordingly.  This solution
> has been tested by myself and the reporter with successful results.
> This fix also allows the pvrdma driver to find its underlying ethernet
> device in the event that vmxnet3 is loaded after pvrdma, which it was
> not able to do before.
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> Reported-by: ruquin@redhat.com
> CC: Adit Ranadive <aditr@vmware.com>
> CC: VMware PV-Drivers <pv-drivers@vmware.com>
> CC: Doug Ledford <dledford@redhat.com>
> CC: Jason Gunthorpe <jgg@ziepe.ca>
> CC: linux-kernel@vger.kernel.org
> 
> ---
> Change notes
> 
> v2)
>  * Move dev_hold in pvrda_pci_probe to below null check (aditr)
>  * Add dev_puts to probe error path and pvrda_pci_remove (jgg)
>  * Cleaned up some checkpatch warnings (nhorman)
> ---
>  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    | 39 ++++++++++++++++++-
>  1 file changed, 37 insertions(+), 2 deletions(-)

Thanks Neil!

Tested-by: Adit Ranadive <aditr@vmware.com>
Acked-by: Adit Ranadive <aditr@vmware.com>
