Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E16CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144B720BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="yyCDn2Jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144B720BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeGLKy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:54:27 -0400
Received: from mail-ve1eur01on0052.outbound.protection.outlook.com ([104.47.1.52]:22530
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeGLKy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rg367jN2aAynEzmCGQbsxSR0QL7isJqW98BRMFAnMk=;
 b=yyCDn2JjuUp0rqotu6KwmGHnxIIAAoM9o9JjtPPDkGYQhIgzXRzrPYD3+4yScHCMfCpYNxHN09bfghY9UdPTGTTexB8xlgEVprW7KezdNiy/xBBBT3aAOro1PG9StresWiR0qgTa/MpV1uWEII6iGyYoN882V7LxzOgWdKUdIeA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=borisp@mellanox.com; 
Received: from [172.16.139.19] (207.115.96.130) by
 AM0PR05MB4339.eurprd05.prod.outlook.com (2603:10a6:208:59::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 10:45:06 +0000
Subject: Re: KASAN: use-after-free Write in tls_push_record (2)
To:     syzbot <syzbot+6c4e6ecbf9a2797be67c@syzkaller.appspotmail.com>,
        aviadye@mellanox.com, davejwatson@fb.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000ae783b0570c2ba09@google.com>
From:   Boris Pismenny <borisp@mellanox.com>
Message-ID: <bb81a2ef-7908-844d-3161-213973342ddb@mellanox.com>
Date:   Thu, 12 Jul 2018 06:44:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <000000000000ae783b0570c2ba09@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [207.115.96.130]
X-ClientProxiedBy: YTOPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::33) To AM0PR05MB4339.eurprd05.prod.outlook.com
 (2603:10a6:208:59::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a32e9980-b464-42b4-b88f-08d5e7e4887a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4339;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4339;3:49qCPa0jkQyFk5Is0q7QDHqq+ORZKMGiJDuitIdZxraHYFGAFEetU4V45be/MDaZHWHt2X4cbExK1zNszE58Nk6Ypq57yuckQ4s2ZCr2kpQDEDg43wdUAW+DyLaRtqibtaGIjk2PiqdIrvoMYEmOsMP2oQR7VpjR7QrN6N+J2bzhPSTiAvvP8vc7o/QO6kda5i22gdIOIOogEtS/HrJw/O+kFu/pBs081eZ2DMQWdTNA72mDKIzomYUSQ00p18wH;25:+NDBOLi+d1kI6Tagp7fJhk2Uzj53ejw3QRFWjKQhb0njSCvyINraFjMOwnPIcccymPt6wkUyfj/8f+hdAit7PPDwhrNkCuA7ng9hG3fcMUQDH/ylWx32hiNbLwiOwfaqJGm/4QD+kOMPNGzgQw7rpyqJ8E8VfijzbVuYoP0rOwWc935PgRJXreGdV93S1PCSg25/8XEAS5HJQx1GGgGs87nzoH5ymRGwxaQqNcHBjB+wX0FX/Xs2itsuo/b5gKzgMLCr2VO0nHa3hmi1azzFzjZvDsLnt+kx7RsJmf9IZC7SAQGkkS+n0mNEpvVWma7cz1B3YUmxYl6PadNVypzEfw==;31:yz5ZomP8rKPx2CUO7oKDpYxAHo0W+9fXVrsWJtBj7+5SFxDxcpBssAbJk0AoSc4A7A2FxmJZIILOW3RZQz0XJscM6ZUTfBYofGkI2BLTujRidJAAlfZej1QXFVz3HD2o90MrXdeDwJFC6TkuMtPtPZjV6tDgImLuC1Oct2/MztQkJ0P2ZoQoQFyBiJ6x3po+VVfqa14KfhIXJJJZoA6uOdWk6CB+TNje8/JniwqBmHg=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4339:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4339;20:Ey43cQv6sUiIAp4J3mofQZS/huZ/AyRJhlqS60hK52Bls3sq9e03p8ybCWcte62SAFWb8M1xXhTj24obfE4ZD/+kL8q3KT7Ti9hvQBVn/99be5ZHCOhkcS5HaP10+zUK33axwc71aOBpBrPB6qV97oKar/PrA2DzGVGULg6S2Bvov3VaJ9zORZWxGj/9bafalr+r2Pn14bsx5VQ/t0WvBE4N8CMh19BtatTTA4bkC6QYICoQVq58FLQ0FTzlp0ydg7Fx/KeGp6vs2Ytvsxe4wlEojFDbuTJwiDqVFiv1o+YlkzxiVknzVBeMdmjK5bNOeUGjYdZnDKJrVGAJ5gmb4Ez4fk9WcNQ0KrORBxW4PMCh/Qd/H8fLDPEc3iDULZCtMcLtxS9vNiLSNxt6yXejh9okarrkHaIm7JVfg03ikiwwGOF87+uAJs/IqEsMcyIkx6l06wOzKikfV392Ewrh2MSF0KpSbi1qSEieNrm6czLnXA45tntcpOdUfF/3dDvR;4:xLUH6hlWGAlRlWNfnubNGBrWiVxqabeC6aLm3wegP1gk59WBfybqKze+llSod/5cFItqsJj9PnTsSqrl6C3EMbPh7KqT8blEK24qyq8kmmBgISnlFN/tAgp9QPS/mMa29n47+EWvXIf2OLKnoNk3hGOdsOB7zYTH9yxO/XNW3rz4F1PnTD5vZomxmNZr0kmDbk0EyZXDpZMmj+HwEKcKI8fNPWsaTjUMIKD7D+ufQU1MdrQKwQcICJYuX1jnRzYjQ6YNbBSvWrjU+VA1phXkahLcH/gNr9dtXx/b4n6uhyUuHkt3AzKSLMw7E1fa0+bV
X-Microsoft-Antispam-PRVS: <AM0PR05MB4339F78C46CF56741B731171B0590@AM0PR05MB4339.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(148501403981450);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4339;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4339;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(53936002)(58126008)(6306002)(186003)(47776003)(67846002)(2906002)(305945005)(7736002)(16576012)(31686004)(8676002)(81166006)(81156014)(16526019)(77096007)(66066001)(11609785009)(3260700006)(14444005)(316002)(229853002)(6486002)(64126003)(2870700001)(25786009)(86362001)(8936002)(36756003)(2616005)(31696002)(476003)(486006)(478600001)(76176011)(53546011)(23676004)(105586002)(52146003)(6116002)(52116002)(65806001)(966005)(6246003)(65956001)(50466002)(6666003)(97736004)(3846002)(2486003)(68736007)(956004)(65826007)(446003)(11346002)(26005)(386003)(5660300001)(106356001)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4339;H:[172.16.139.19];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA1TUI0MzM5OzIzOmo5Vit5SFlCcS82WllmYVJxcHBhWnp3QVh2?=
 =?utf-8?B?VmxJWTQ1Y0hjdUxaaWNib0RkbmF3WjV2eEtqWmJsYURqM2ZUVU95MmVtQ0tj?=
 =?utf-8?B?VWRja3RzeE10QlF0aVBOUXZpWTJPN2psNUh6MUo0R3VkUzBqR0FXa3Y5MzIv?=
 =?utf-8?B?bERTajRRV0lqY2R2Ky8zcGdRMEdQdGRBeWsxanJzTmUwZWlCcUZGM0RhWGps?=
 =?utf-8?B?OE5ac2ZSUGVsRk11TUE0VERYbTdVN1NOZlhFa1Z0bTkycGtRU1l0N01KVXdn?=
 =?utf-8?B?V2JuTHY5R1A4dzVIbVBqUmZ0cnFwTHMyTS9sUk5pWmdxbjJFQTZKMHZNNW1S?=
 =?utf-8?B?Njh5VVFvQW1UdHVBZVg4WVpSSlJOdTFiZ1ZnS2gxS1BHelJqNEpMdmNGVWRQ?=
 =?utf-8?B?Z1BCMUtNL0EzcEZpTXVxMDVTVWdNbkpidDF5T2FZQWFlY2ZsQkRRdzhxS0Jv?=
 =?utf-8?B?MTlEOWhnTDhpUW84bkJKSHVPcEZIU1FWclgrRE5QMDYvQVdsK2tsNUZiSEF5?=
 =?utf-8?B?QVhnTTB3WFoxaXFtbjBFanc0TDhHclhyVmlUWWdEeCtIenBmUHd6dUtmdzJ4?=
 =?utf-8?B?TzVLb2FJVnErK0RRV2d6ZkxnR0psRE1IUjllNXhkcW16YmJWU21idlVDMGJs?=
 =?utf-8?B?L3JvS3lhSS9PWkZmbUVWZzIxRm1vK0QrQUwybit5eHAxSjRobTd4cVJHY3JM?=
 =?utf-8?B?VDE4SEo0OGFGanpGMkVUS25Hc0k3aEpkSTRZSXFHNll1MDUrZEJnYnNtVXV1?=
 =?utf-8?B?aXp0blBCY0RELzc0Zzd1REw0cjRoUjJkWjFtUTJRV0l1YzkzUFAyVmtxUkVP?=
 =?utf-8?B?dTd3M1dTa3BNb1FSU24vNEx4SVNqMHNyUDMrZlVGTWExMjlRRXFNZ1hnK1By?=
 =?utf-8?B?VjRtbnZseWUrVkxoMGFobU5kNnVOK29NZU9QMUt1K2dOSjdJM1dqdDZJWUlC?=
 =?utf-8?B?ZEZ1RDFwZS9kVk9ldTJFSzVMelpGTWRhaWErdndqQngyQzRIbGVLVVU1RzA2?=
 =?utf-8?B?TitBSjA5SjR3Q05PbDFPZzJmWGdTZUJUaXlTejZTRU90NmsvUmZIS2YxeFRi?=
 =?utf-8?B?SkR1cWtNdGFiaUxKYjMybThVT0FxM3JmZFlYcy9vUm5HZlN4ZTNVMUZDK1JM?=
 =?utf-8?B?cFlQM0Q1OG4zYXRXY0tmS0Nmekp4VlhVRVlTL3BCZkJTVEZMdVo2dW9jS2F0?=
 =?utf-8?B?WWtNNi9TaEF6WWc5ekV0bVlzQjlhUHJPcHNsMnA1YXNMdDlkUGd1NGdwaEJI?=
 =?utf-8?B?N0QvOG8rWVkzeUtoak5BTzRPVDFjZTBNTE5wc0RNcWlwUlFmL2wvMGNCck8r?=
 =?utf-8?B?WWtwR2Fzei9OT2RRRFR4TFJHTVp5V3ZzMEExaDBVZ3NTcldoU0RDUXRNc2FL?=
 =?utf-8?B?ZS9sd2daaVNrYUxPaHlYWEVLM2ppaTF4K2J0K095L1N2cE1hbWxzblcxc2RK?=
 =?utf-8?B?b0M5WERTbFdMQ2ZIZDcvRjRTcVRjS2lHcUhJZk16WG4zZXg2S05MN2RWZE10?=
 =?utf-8?B?YUdCaW05MjR3TXRicXp6dnU4RElGc2dtMUkyVVczSFpPNFgrSVpjSUtVTWIy?=
 =?utf-8?B?bHhYUnhQRStWTnN4ZG9pWlV2ZDdodHBSSmJQRU1waWpnQ3p0TnB3VnRrSnhB?=
 =?utf-8?B?c0lxN1l1VlY0djlzY2E2VnRpUTFBaDEvOHp5Sm41WVpkY0M5anZvZWk0akZT?=
 =?utf-8?B?NjZBZWM2ZWVKRHNoSHhWelQva1B6TG82T3VDVko4VUNyMk1XUnNmZ3pMQkR5?=
 =?utf-8?B?OTBiaUtDb0pWQURCZ3Q4cExMMjZNelZnSC9uZFBoZ1BpSkRiNEphcE55cVJL?=
 =?utf-8?B?emVVMzRuSVFWei8rTVJTaWxLbHlEZEJMeTRWdDRPTWp0WmNmNS92WXRZRTdR?=
 =?utf-8?B?SDVZcmI2R2FvVVhiaWJ6K2hVS0NWMSt3bnRIaUFpMjVNRjlTRVJ3RHdQa0F6?=
 =?utf-8?B?ZVoveXh3eGFPaTZxNU1ONGgwSTMvVFNaWE9xTzBsZ2lGQmx0eE1lMWNJUE5N?=
 =?utf-8?B?c2ROK3hlOVAzckNpSVdEWlJoc1JBQVZpd21vdW5QZTBuNmtobkRRMXlqS3Yr?=
 =?utf-8?Q?0+NxHEqLJfw40ElDQzp4WaoAq?=
X-Microsoft-Antispam-Message-Info: x7SN33NWavCWxgap+jgH2T550pDWb37vwvc0zsX/EyuyiutuHzr/hb51ttY6JaxO30a2o+yNzsS8vJO3vqoFaWUuOm0T0eXFwBwZnrKAmhvVKDZVpixJ8TVVcfib46OO4qiVyjQ3OPvdLcNU7R7ixjKxS4h/K75J9grL3a2TojhdtmCy8qDnGTe3hLx6XA0c8QLtFuNdiAygkjMo2spkv7U5J2CK41sgtY3py6aCK5fpnMx+uJamsmKZYZ63MlcbjLp18vkfxzf+uy8bVqbsr6tmj1bLmJg0EjKfDNF9NvtzTGTKXtWWr67HvJk5Qk2ZTFPLmQOtYd8LNt92fy4cKWyA18cRVRNtxEKIto4p43A=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4339;6:Gh17ggkWTup3+T9NEPquqhWkduYwA5t/dbAj/VRzW8L2GZc+s8YlrRojP5gH1vne8MAalCvn3BdNmzrH+l4IZx5b7pnUcckzGEw3wTrKn0/irtC8MDBNT+UPbqZPqq11qZnlDZm5zrxM91+KDvS7UrEtpB4h+2AfffHKEUe8PYL3VQ1CL4xuf4pca4bbmnE5MVVqyUNKkSoEvo46FRRoWg5WzEeIPtnpeYp9G62VVQfWcYi7vop64LYdBkSQv5ErKt7C/NWOxY4NOciVNplQI/xXbMTzpmySpmfmo8UwfnYXUneCCshZmn+a5yAFrGFvH2ZX6vAORg83a5XKZ3ztAZo3Eg2H4EaWkZVvEIkXuu+uzY4zdvEzrRlOLMFgQrae+JgNtuwr4w5aZowETgWgXnPzMjXGOBtPWF6OueUTSBU7fiFzNycJ8ySXjJ2dCJDmsmogFxx5HdHDdHMOyUCLfg==;5:2WVsE0YlcTyj+MSMGwDG5HvKbt1atDO/+3woAPOPeNic7iVo41HTPdflLfBaBC7nzEr0A57lrN4MZjfZk/abT8eQl1T2CZ/+FTJbqYjo1sXacKOc8oa6tZhsaYvsBdsn9kbiBzMCn/wKlA4XmXyodfunIp8x4SbDUEstFOrI7x0=;24:4xKdAESRK/1fiCitoVqNVA9lghxOlAguqJqrGi7kZsxDIBc+yBY+csqaMDU21fglikivhxPrK/tRDqipXTLb6txqkwjpBqLrTaNKzRL14eY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4339;7:Y7i1kYP6dfMCmgCd/phBiFljWxXfLvNKqnFb3IcX+f1Oi23GezOUtueF15F3tXU0WKv3Lhjfi1iToX4DaJrbs1tnqEvqXwso+XxDvfxyxODkFjj531+Re92NJSV+ODCvBZ5hHStv4uPs+EeeASGyi2EycC0/wADm/aIPT/FNIpB2W4TL2oa+nQcQuUycKFbwSW9z3hmF7qtdBSDDGKC8bvelIaOGnW4V6NyR99U92jp6M5b2FGUiBiJ+40shLfCn
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 10:45:06.0559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a32e9980-b464-42b4-b88f-08d5e7e4887a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to me that the crash here is due to write_space being called 
after the close system call. Maybe the correct solution is to move the 
TX software state to be released in sk_destruct. As we already do for 
the device state (see tls_device.c).

Is anyone looking into this one?

On 7/11/2018 8:49 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1e09177acae3 Merge tag 'mips_fixes_4.18_3' of 
> git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=128903b2400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=6c4e6ecbf9a2797be67c
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12312678400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ef76c2400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6c4e6ecbf9a2797be67c@syzkaller.appspotmail.com
> 
> RDX: 00000000fffffdef RSI: 00000000200005c0 RDI: 0000000000000003
> RBP: 00000000006cb018 R08: 0000000020000000 R09: 000000000000001c
> R10: 0000000000000040 R11: 0000000000000212 R12: 0000000000000005
> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
> ==================================================================
> BUG: KASAN: use-after-free in tls_fill_prepend include/net/tls.h:339 
> [inline]
> BUG: KASAN: use-after-free in tls_push_record+0x1091/0x1400 
> net/tls/tls_sw.c:239
> Write of size 1 at addr ffff8801ae430000 by task syz-executor589/4567
> 
> CPU: 0 PID: 4567 Comm: syz-executor589 Not tainted 4.18.0-rc4+ #141
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS 
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>   print_address_description+0x6c/0x20b mm/kasan/report.c:256
>   kasan_report_error mm/kasan/report.c:354 [inline]
>   kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>   __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:435
>   tls_fill_prepend include/net/tls.h:339 [inline]
>   tls_push_record+0x1091/0x1400 net/tls/tls_sw.c:239
>   tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:276
>   tls_handle_open_record net/tls/tls_main.c:164 [inline]
>   tls_sk_proto_close+0x74c/0xae0 net/tls/tls_main.c:264
>   inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
>   inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
>   __sock_release+0xd7/0x260 net/socket.c:599
>   sock_close+0x19/0x20 net/socket.c:1150
>   __fput+0x355/0x8b0 fs/file_table.c:209
>   ____fput+0x15/0x20 fs/file_table.c:243
>   task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
>   exit_task_work include/linux/task_work.h:22 [inline]
>   do_exit+0x1b08/0x2750 kernel/exit.c:865
>   do_group_exit+0x177/0x440 kernel/exit.c:968
>   __do_sys_exit_group kernel/exit.c:979 [inline]
>   __se_sys_exit_group kernel/exit.c:977 [inline]
>   __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x43f358
> Code: Bad RIP value.
> RSP: 002b:00007fff51750198 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f358
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00000000004bf448 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
> 
> The buggy address belongs to the page:
> page:ffffea0006b90c00 count:0 mapcount:-128 mapping:0000000000000000 
> index:0x0
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 ffffea0006b96408 ffff88021fffac18 0000000000000000
> raw: 0000000000000000 0000000000000003 00000000ffffff7f 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff8801ae42ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8801ae42ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff8801ae430000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                     ^
>   ffff8801ae430080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>   ffff8801ae430100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with 
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
