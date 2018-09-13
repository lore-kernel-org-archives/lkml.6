Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E83EC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05691206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ik17CPz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05691206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeIMOAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:00:08 -0400
Received: from mail-eopbgr00094.outbound.protection.outlook.com ([40.107.0.94]:7200
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbeIMOAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzTefWiwRmJpfakNpScK2iAWezkja84wQQzeGEjiE58=;
 b=ik17CPz9z58IEUPJHbf4c70UW95masF0qJZBUmzHFOFhs3tA6M7JMsYafgNGCGAAe6n0cKY+JLOaKTpfvT3Df381ZNptNnJF7M/Nw3ovoMJ6DR8FMPj4UPl3LZZoYC4eZXrgvWrwH9uC5W+ujWMkn9HJYdOiK/LbwNj+eZHedaI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Thu, 13 Sep 2018 08:51:32 +0000
Subject: Re: KASAN: use-after-free Read in fuse_dev_do_read
To:     syzbot <syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
References: <0000000000001e09780575bc189a@google.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5882d989-8e9d-0ae1-1b2d-3ba431e97eb6@virtuozzo.com>
Date:   Thu, 13 Sep 2018 11:51:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <0000000000001e09780575bc189a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR04CA0097.eurprd04.prod.outlook.com
 (2603:10a6:803:64::32) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b264287a-ab05-4f55-7b3d-08d619561aee
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:Jtr6DXAFzPXD1ggSMvZDkjAgE38j0BgaCQ4tWeLvRMuhT6X/bpoSgmk9uryDorlHpkRa8FPzsWJNbEdxhFFsVUTKLBRjayOUGF+X1t7JE4pfzXoNFm0g5NWIgPKV+zmVarGuS8wSVfMknLQiwdanvMfMOiGhyl5iZbiBY4IJ4ex3U07VyfjEvkb8Mj3tpVKpsAEG05YBoRDkRRFtOSGNeE2TLd4fAPu3n9mRrqY97twEIBrBkbKuyqBd7268yClk;25:TJmh7l/2WudlsAe9y6zVG06FLeZLAct6JwTsajAFiGVG9O/8s9dt5g7pWa3NIbUff2mpaaKgG9IyatXa0PsyKtFlPMk2N49nYOaVWMr6dZJRxtMteChl1n6hiXbltRHcI4L1CmLzkIWhZlyW6pTxduu4SkfUQDXo2gBe01FuER8Z4ls+veyQttAFoGYCSbgduVNUKjBauTCix89+3UbU9WwOSUrWK+iFXZtJ0tVGy2kH8YaAMED1DmtCUOik8FTl1rBX74GGVYPVQzM3Zj1McFzdrzmxsWwX0ccmRKaSAePLVm8bAyzGnmdSIMkIqY8/2YG7+IClKdkhpcUPgvMpMQ==;31:YViCDlJBUZR7nmRrt4pc+ZiGf5c/cAnREjH6NBR75yWvmpwyWWmKpoaUq26/PG/1wIjV2pbInpknzGpvDw8TBfeQVoYYEnmmA+xPDAX31OAgRATwHSOyVMdc0LcmTYw+jMTjEasrgIRN4q55VCqNkIe/UlG3btfakpPQGh3u2S8lZoBm2HnQc+13C+DRFzQphvpQJRwo3ski03+FoWhxmGY7ctb7jqfks1X2H6mRDgQ=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:DKQwWhpPnlC9X9ngDhN5i2RWmORm10TvE/y+kqDiCIedjSxNIfFzqAZFC4LcV28UbMXl/nsK4erOQno2zMxhgSVhnPyfIbKQ86ucKeK+kNqcLM/93UM0Qw0tRF637EXle0S5pr5QALGybxS/gsHwkLLczas4/z2HfXJs45Fb8XQFB9cOmhluUupoJQyk5+8o0q7Z6uSDjovBETtTR/G3VbgeKjnDWTDu2ld3DTIWGPnlzFqgOR3FFmU6JAfC3QRo3LPr3dt0g4w/JOZUUy0jYK7tvcMWA39OxFtu2xj1mMsKbkzO8n89agnIrlMgvtleBkgTqaYuK/ev5x3kzOHafx63Dp5hyLMkNxAvBgxJknyRvliw3tzWK0d+5vo5FGUEwhl2nQqutq6pRVVpGypDgCQSAVJdbvmU34HN07OxItpb7vBjrxkColJflHsRfC3N+DcWa5k/tE9g/nN7+h+wmYx27Wa1uEwmipuOqMbFurG1Tw7p1KEF2VM7xeP5673x;4:pJI4c8tvjqaPortx6GyZL7Ga17cUtik44Ec/191f1NnxZJGqjVFaYo76IxzNRk3p8w6D33vgt/8eCmSXWar69jsGl/sfzZzBLLIsCOnSKQhgH6YmtjXH736adLGRUkMub9XyEqnHiW9Mh/E9zvEEi4j6pwQEbbCKZHI98ChI4wNU1qBi0DIxdbjuCYwEAbTW+Eh9A+hEQLdMqMBm8ayTiorRMoLlaoDI9Iuqa1XuT1jUChj79JOAGCcbMY19caM8TYmfZMokhW7gCSm4mAQAnB9kcVawsfWz2Ty2i18Qw9u3z0wYwXLCzvAoph5KIRRqyqTpVEVcJyE8tpXfzApuOyoQbTFlqm4Bh37Npl49Oqg=
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20262BF4BB214D3D52B35D7DCD1A0@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(148501403981450)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(136003)(39850400004)(396003)(346002)(376002)(189003)(199004)(23676004)(446003)(6246003)(97736004)(25786009)(81166006)(11346002)(3846002)(316002)(6116002)(81156014)(50466002)(8676002)(6666003)(476003)(2616005)(956004)(58126008)(8936002)(16576012)(486006)(26005)(106356001)(64126003)(2906002)(229853002)(77096007)(5660300001)(11609785009)(186003)(16526019)(14444005)(478600001)(2486003)(105586002)(52146003)(52116002)(6486002)(68736007)(966005)(53546011)(53936002)(76176011)(386003)(66066001)(65806001)(65956001)(7736002)(305945005)(36756003)(86362001)(31696002)(31686004)(6306002)(47776003)(2870700001)(65826007)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6UmE0YlZxK2ZqTkJYcStwUCtxelpuSlY0?=
 =?utf-8?B?YzRaSFRoNDJJRjk4UmNwRmNCM016S3ZVVDR4dTh0dFYvRHgvMmZnL3pWRHNT?=
 =?utf-8?B?ZEorcTF3c1ZJQzRiMUxqWm92RllQRUlhWnFXTVlZS29uaHNZNkRZNUFMUkxF?=
 =?utf-8?B?VFlXZ0xLWXRwZWdpNGh1VGlkdzlQdEY1SEhpUzN1eVArdERwMjJ0QU5ucmZx?=
 =?utf-8?B?MzVVQldlRUwrVlAvU295dVl6UnBHbXpXeUdpN1VrTnhxSlBJTWliNEc5SlZL?=
 =?utf-8?B?eko1Um1ncGZTNThMMXNNazBJakxkZ2xHeVB3Q2JiZktRZTE1WWxjazRZT0da?=
 =?utf-8?B?MmU3b2psSDBjRXJnekhjYmQyTlVTSmFYam9IdVVvWUh5SlNpK3d3N2J4cjRa?=
 =?utf-8?B?UEpZVUlISFYvQzZlUEg4eDJUeFBaYUljbWZUVmJwNUlXUU1wbWIyOFNEbUhu?=
 =?utf-8?B?WUlOd1FPZzY5V29QVnNBSWRMNzhpb2RKVXlTN1lNMit1VDhCR2tIeXgrU21t?=
 =?utf-8?B?d0Q0SjR6dWxTWUU2S0QvdlJHZ1BXbWx3TCtuZStlWnRucEtNclV0emJPZjZK?=
 =?utf-8?B?Q3Y2YmVaQ2FWSlk4ejFqVU1sRkFBOEtOYy9OUXYzSlFWMkE1SWw4YkxjTkxl?=
 =?utf-8?B?YVp0aEhxS3EvWFhnalZkN3ZUWllDMlh1TFZoL0Zob2EzZ1RnU2pKWm55L3Zz?=
 =?utf-8?B?WkdMUTc1QUJJeGFmMm9paS9VenIwNVphbE9zWmdLZTd5cHFrUUg3ME9XdDRB?=
 =?utf-8?B?bndjWDE2RE9kTStYdXRoRzZqeWJrMStMQjhzZXJCY0I2a3Nxd2M3QVZOcURx?=
 =?utf-8?B?czNGWWZ4NlpSZ2NPTDg3V3Yvd2wvcUtqYWFmVTBseEFBZW43WWVMNDliYks5?=
 =?utf-8?B?YklSbDBDSVVGOEZRendmRGIxLzVpWXpsVmJuejlITTMyclpRd3NNZUl2NWZn?=
 =?utf-8?B?azBkaE5scXNzc2NaSXB0RG9HaEIyRjdIYXpMaTZCMFFhNk1IcmFZS1pFTTZi?=
 =?utf-8?B?NXhLVEh5NHJORmhGUXRIQVRZQWMrRHJ1amNtT0YvNDY0Z1E3ZHNTejBUMGRv?=
 =?utf-8?B?aExQcVpiVVllM1lTdzIzNGkxR3U5WE51WnJtRytBalppbENVY0ZHVFB0RVNW?=
 =?utf-8?B?VlNFYk9GUmdYS3dWVW81Z2R5WU1JaWxYUjMxbHR0L3Vidmg3cEt3VWU3K1B2?=
 =?utf-8?B?SlczZFRzaFROMVZLZ3FseVJCaWdjdDJoeGFpUFk2YnlOc2ZrMGp2dExFSEdr?=
 =?utf-8?B?WjRFdjNRTUtwWTJsc2xaWUFmSGUwK3BYZThEWXdRNVhhcCtYckpGRUMwdjdx?=
 =?utf-8?B?dE1ySmxoeXZDV2NvTk82UTROYUFCc2hYTDdoZm5QT0NodjVPYVpNUC9Ya2tB?=
 =?utf-8?B?WlU1aE81TG0rTDgzVkxxcGgveDF3S2o0VFIwc3Q0cElOL1kvSUhKVm1wNDJ6?=
 =?utf-8?B?TEcwV3NNb0lCemV3WEd5cTAxaE1OQlN3bHVwWFMrRGpvQTlqeWRKUjRheGJB?=
 =?utf-8?B?Tmd6bm0wbmpLNFRPRzhJeXJGR2NtZ09ZYjQyK21lYzh0OTR4Q2NxTCs3UGhL?=
 =?utf-8?B?UFdhU3hhUG8za2QzdmZEQ1ZldGtLWWpkM2R2QWlQRUthUHc2UStBemQ1clpv?=
 =?utf-8?B?eElhR3lBMjdibzlZZXRVbkM3STliNkVSeVlha0w5QlhJajE0SUVWbk5YUSs2?=
 =?utf-8?B?QVF1eml4a1BWdURUdXZBd3g3WWl4amxrSVpjNVJ4Ym1MT0dEaUlsbm1FMHpu?=
 =?utf-8?B?bUNmVFY4NXZQUXZ4V2FEMHU2L0g4VWFyeFo0MC8zRmNRZlI2NGl2RHJJVTFB?=
 =?utf-8?B?WGNOL1VwWWtkNllvVzd0aTI2MUhlUzRNUlkrSk51dExGNXdzVzV4L0xreWhr?=
 =?utf-8?B?OWsvUE9VQjZaQmZHVUo0K0NFR0N6bnRrYU1mTWpKSzF3UFNqbDBHRDJYY2t2?=
 =?utf-8?B?b3RNNndpa1BFMitmZEM5elRhcHlRTWR1TGxJcThtcEYvTkk1YU4wbjJaWHA1?=
 =?utf-8?B?bXg1VTN4UDdnV0tGTDhoVFgycnppdVBUQmxnMnVRPT0=?=
X-Microsoft-Antispam-Message-Info: D7N2QDrXSvi32XANO1XH3vS/HTXiM+OVWP8a3UFbQbAi+TM0I+E3FpQEYPPXRcDgdLnA4TNSDJpWz5CjX6gsiwmngiZQxvCMKoFimf2EfUmUGyV1n3llqLrqVGrZNWEfRW2HkwM9+VkY/Z/tRIgIMFnkIAwtiSsMJRGtgDiQZGheILfc5K9N9QkjItX0kw1LMlaqAPRvLoFVNqkaGgrvBtJbWclODBUzuWGJSsyq3KyfI0IGpOpVSUScok35mMwY+jctoWjZuJ78RJtC9havKy6OfnD8BV0m89jtfMjVCfMGAjmwC5jeM/KNh+AcL44MhtO/oRtz7Shj0XrdvQiylG2HjAYA1DG5//xfZgQ3pi0=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:tlY/DngaMRnD4zG99JZpzyYxrMQsyWEo10OzIR2HrLcbtRiK98PqnAeKmUUE2fRIVHfCWQ00xtXiKS7Q6lNM8M7icvQDHa79SM0BXTzw15B5t9uzp5dyxAHMs1aZCeIPKX8LDbXNW7FM4bRVHsDhQKrfjv55hR1ha8y/wjR0BRC8k1iHQjtZK+SSgym2CMsRXuWLNMXYB81YhMwwAx+o9CqUuISvDtl/7mVW5AOiXhLpGSReRNF9GmBB+Vhd98YiUbxsCgFq1IgW9tv8Drbudfh0JNmDTbFvxpZskkjCB25Qf6Q1U0x3VdsGOM/asvKCUQBv1FYO94bpfMGIWnIVRKt+5qTmWKCKwk00v8UluE0ieWe1SdypXEpgooVgz+Nm+eLbJBtajpTEMBB2W98fCS7c7I7YCNHfa29M7AaqVJh7sHA3IIKvzD4ApN9Shk7dcIJCdIDrPfnXdb4+Zf+pAA==;5:67NZDNht6DzN/LxCJuEvsk58Yv2n459MaJYqGbdtlfvlHdI1SHsXEpsjiZ8ExXYEp2m1sciqAL2r+6IFpUljPkHek9NVMwjAVKKWy4xbvecqNLPrqrnFtoKaa6u/zi6Edgfq0DoMIRxkXw2NU9bxf6N7iUbatamx6SOtvkY+JqU=;7:AVLIE0DElyiruF4NjCPkYJsbNm5iMfeCq5XVO+WmeUUxd5sdsY4lr4Q2Uoy15n+zAmwyh5XoId2cx9bTuMCmOqxoYy7+t+Tx7zauTEXvaE2uZgdo6a4KNHN1Wpa79fe9UE0zvJI3s5T0Jzv5a+nimGsXgo9MVB0qQCFDz8nCMHO6k7Dya/AgsAE/Y19pRTjoW7XZQzXYMfgAPYcPHXmGge36jbYrF9zp3fNthpLHaHYrWU12vArtw0uduRdUOQss
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:oj7OnqQDck8B0K67NabhNnC45v64PBnVIItCFf/F9aPa8znLrxVthOiVWi+adOFowiDfKSD/EK7YK5PgT4ETCbNqIM/H4H/4OfEi017KX8oTbhFk8xUecPocfaXh2fLZA0VH2i4LRB6SxhTxeCKu96rtH4NSdyVYbRTNy8575qs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 08:51:32.2467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b264287a-ab05-4f55-7b3d-08d619561aee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13.09.2018 11:00, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    54eda9df17f3 Merge tag 'pci-v4.19-fixes-1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=109a3d9e400000

what are requests id written here:

   write$FUSE_INIT(r0, &(0x7f0000000100)={0x50, 0x0, 0x1}, 0x50)
   write$FUSE_STATFS(r0, &(0x7f0000000040)={0x60, 0x0, 0x2, {{0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xfffffffffffffffa}}}, 0x60)

?

In case of parallel thread called write with id, we just queued to processing
in fuse_dev_do_read(), we may bump to this stack (despite read has not finished
yet, syzbot may write just everything, any id).

fuse_dev_do_read()                                  fuse_dev_do_write()
   list_move_tail(&req->list, &fpq->processing);      ...
   spin_unlock(&fpq->lock);                           ...
   ...                                                request_end(fc, req);
   ...                                                  fuse_put_request(fc, req);
   if (test_bit(FR_INTERRUPTED, &req->flags))
         queue_interrupt(fiq, req);

We should keep req refcount in fuse_dev_do_read(), till we haven't finished to use it.
Something like this (compile tested only):

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 11ea2c4a38ab..675caed3e655 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1311,12 +1311,14 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 		goto out_end;
 	}
 	list_move_tail(&req->list, &fpq->processing);
+	__fuse_get_request(req);
 	spin_unlock(&fpq->lock);
 	set_bit(FR_SENT, &req->flags);
 	/* matches barrier in request_wait_answer() */
 	smp_mb__after_atomic();
 	if (test_bit(FR_INTERRUPTED, &req->flags))
 		queue_interrupt(fiq, req);
+	fuse_put_request(fc, req);
 
 	return reqsize;
 


> kernel config:  https://syzkaller.appspot.com/x/.config?x=b8f349d23d3c4835
> dashboard link: https://syzkaller.appspot.com/bug?extid=4e975615ca01f2277bdd
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in constant_test_bit arch/x86/include/asm/bitops.h:328 [inline]
> BUG: KASAN: use-after-free in fuse_dev_do_read.isra.27+0x1659/0x1920 fs/fuse/dev.c:1318
> Read of size 8 at addr ffff8801cbd4ea30 by task syz-executor0/28821
> 
> CPU: 1 PID: 28821 Comm: syz-executor0 Not tainted 4.19.0-rc3+ #11
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  constant_test_bit arch/x86/include/asm/bitops.h:328 [inline]
>  fuse_dev_do_read.isra.27+0x1659/0x1920 fs/fuse/dev.c:1318
>  fuse_dev_read+0x1a9/0x250 fs/fuse/dev.c:1360
>  call_read_iter include/linux/fs.h:1801 [inline]
>  new_sync_read fs/read_write.c:406 [inline]
>  __vfs_read+0x6ac/0x9b0 fs/read_write.c:418
>  vfs_read+0x17f/0x3c0 fs/read_write.c:452
>  ksys_read+0x101/0x260 fs/read_write.c:578
>  __do_sys_read fs/read_write.c:588 [inline]
>  __se_sys_read fs/read_write.c:586 [inline]
>  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4572d9
> Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007faaeefe4c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007faaeefe56d4 RCX: 00000000004572d9
> RDX: 0000000000001000 RSI: 00000000200040c0 RDI: 0000000000000003
> RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004d4508 R14: 00000000004c8d44 R15: 0000000000000000
> 
> Allocated by task 28825:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
>  __fuse_request_alloc+0x27/0xf0 fs/fuse/dev.c:58
>  fuse_request_alloc fs/fuse/dev.c:89 [inline]
>  __fuse_get_req+0x1f7/0x9e0 fs/fuse/dev.c:164
>  fuse_get_req fs/fuse/dev.c:194 [inline]
>  fuse_simple_request+0x28/0x730 fs/fuse/dev.c:549
>  fuse_statfs+0x368/0x8a0 fs/fuse/inode.c:442
>  statfs_by_dentry+0x136/0x210 fs/statfs.c:64
>  vfs_statfs+0x47/0x2e0 fs/statfs.c:74
>  user_statfs+0xbd/0x150 fs/statfs.c:89
>  __do_sys_statfs+0x7f/0xf0 fs/statfs.c:179
>  __se_sys_statfs fs/statfs.c:176 [inline]
>  __x64_sys_statfs+0x54/0x80 fs/statfs.c:176
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 28825:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kmem_cache_free+0x83/0x290 mm/slab.c:3756
>  fuse_request_free+0x8b/0xa0 fs/fuse/dev.c:104
>  fuse_put_request+0x2a6/0x350 fs/fuse/dev.c:304
>  fuse_simple_request+0x453/0x730 fs/fuse/dev.c:571
>  fuse_statfs+0x368/0x8a0 fs/fuse/inode.c:442
>  statfs_by_dentry+0x136/0x210 fs/statfs.c:64
>  vfs_statfs+0x47/0x2e0 fs/statfs.c:74
>  user_statfs+0xbd/0x150 fs/statfs.c:89
>  __do_sys_statfs+0x7f/0xf0 fs/statfs.c:179
>  __se_sys_statfs fs/statfs.c:176 [inline]
>  __x64_sys_statfs+0x54/0x80 fs/statfs.c:176
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The buggy address belongs to the object at ffff8801cbd4ea00
>  which belongs to the cache fuse_request of size 448
> The buggy address is located 48 bytes inside of
>  448-byte region [ffff8801cbd4ea00, ffff8801cbd4ebc0)
> The buggy address belongs to the page:
> page:ffffea00072f5380 count:1 mapcount:0 mapping:ffff8801d4ad4840 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea000717eb48 ffff8801d4ad5c48 ffff8801d4ad4840
> raw: 0000000000000000 ffff8801cbd4e000 0000000100000008 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801cbd4e900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801cbd4e980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff8801cbd4ea00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                      ^
>  ffff8801cbd4ea80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801cbd4eb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
