Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D22C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC8F20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ArICQ6bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC8F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeGSL6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:58:08 -0400
Received: from mail-eopbgr10113.outbound.protection.outlook.com ([40.107.1.113]:3456
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726956AbeGSL6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iupAyNjZdLG/dCeva78lDrH7yEnbd9dPySD0CTvC/50=;
 b=ArICQ6bzf77OwdK0UIn2sBBAR3YhgDBCSSo69N7JWm43VJp9D9Ap3Hsoi0gpMHycAMYXR7x2GXOoqWG0f8vh4C1E1KEtbQ4Q0YufARbOX+OLI+zuQA5V3Xk1so7hHrbMc5b6ex6+KJOQ4GsNlDFcQ4mmC0QGdY3JkD/0Bi1yVJk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Thu, 19 Jul 2018 11:15:18 +0000
Subject: Re: [PATCH 1/2] mm: Keep int fields in struct shrink_control together
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, vdavydov.dev@gmail.com,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <153199724495.21131.9248876333336922199.stgit@localhost.localdomain>
 <153199747930.21131.861043607301997810.stgit@localhost.localdomain>
 <20180719111031.GX7193@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <100cdbe8-4109-053c-7a2e-231e5d572e71@virtuozzo.com>
Date:   Thu, 19 Jul 2018 14:14:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719111031.GX7193@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P193CA0014.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::24)
 To HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6465130-d735-457c-1789-08d5ed68e9e2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:9nJIvDsjn3Y0JRk8dzx2m2X/h5TehmKZgAKXSYdJQ2prJtF2IgUPIoQ038cdf6lFy/zXdVzVkXF44BNunGpw/kKIhBQh/2rsbf++CSRCE4qGfU+BNzPytZ6c/GiZWtY6BlNRwtJLB6gn1h6d1frcFjsx+ZyTKC/ozbD7wl75bcAT1i9oYTRvXmMbut6QKVMSpBBqldJacdQgdhWIxBvKzM3Cv4FAOVdo+V3KFsbCYAFbFv1JCLZ2E0TYtbVptNst;25:Dj+D2tgQHW6hvkAq8jAF7bZgP/HevI+rCdzkCHOCOfJ0qZWIhdJhj3QJkQut4NWXv8Of7nUe48XwXZ9PPyF+yYKmaRz5yYokEwhufvWnX3vtq1+CWeQRoa3SDClg7/AgWZuB/m6CgLwStLiNsCJnUA24CtuR9KrpuLAam7FPwoDyPuDFfFqr5z5jVBN7SE9xgwSEzV3WgSimwi9CoqTAAsgB+d5DM9caBmbxEQFNRmPlFhuz9g5Vuzj1vfdCmUjapiuyoKdyK3oUhKAxjFLANj1/H0xFIxc8hgDwxRUbD4g4CcKaJ72CycA8GpDN/66qGHKkukjIAPWJgQM2tvbBbg==;31:PvaKiuV0oi1uGSeKG7tjv+xUQQ4BFGZ1HG440O4Vov1QGOF8DKdewDxikWfvVCBbrmT+pYyg6Dqdf8BspyyBqP+RbEdRwAst146lJzf9db0Nudt1B9MR/7q2QT4II2LOFeG7mo3TeuDE8eDS4Zlly3zcHnSiccqMJX767djuBs909HfOZrmcaROr8p9ovGl4PQQFNDVYy/dEWz34gou/hCPBbxIll7MvYMeUf3v2/MU=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:p/fTXkK2/8cTA5Pl4T2Hjkzfv/Iw9Z/grGDzOxTddILSRJ2XKwQS/1p1tOc6zLcCKJJ7w4LUEboI5tdJrfdpd/8/+8sckcoubuXztVs2sqJuB8cf9InwSEi34K/cVMhcbb3hZGTgIfdRu2WaWCodV2yafNzOXiygdTztQUa00XZxeAt9KsTpgRA+aGkaPOTrntXABhcjpjR/wOrAmlyUdZtFDjC6Z6c3d4c8MN8GtDFGqc/VJbCym311usYPIFvTTYYIObyRuJ54mPnZfX/wUrJrkRMxZbb1iTItFgXBqWS2oFJvCm6/MDwyI7d2I+RK+v9x0Iq1kTnuldPOgTIcgNWUeYyS+uNVKF5mnEWMGffCcS8ftnPTwG6AkhvBc38XWlATGZRV9dy/cr9zmdAVI9H/RlgIRZC2psixPeuXyhOvac1Am99AcZcsakGdjBhNyHGRf/9YVe6BzFC9yCKsVj6GOCXyfwJw4RBiDHz+TCww0IrlV2xNUlLN7nA2FWTf;4:+oZQFu15MJG+6CEhsc59sYbofuDCmP02g0NLva/oxz65cQRTGs9phdpttHm6mlETgBd/57EW07oI24gzrjRVKBWmOimW7+sH780hCC8nKUkbUx0a78Pv9kOGtgz9KSiDaAPR8Q3JuSlpuZ5hDZGzRzwvBC3f365BiExaGFPbFXm0tVFhgng15MFrkGlCakOAOpIFgAkPVpNZHIvP43+McLb8m2mb/EY5uFL5I2ls0H8N5iUVzEiVQnkhTpS037hqHHns5TJizMJc7VpYwKwDLA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB202690A56516AFBF9C710A1FCD520@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(5660300001)(6486002)(229853002)(47776003)(478600001)(66066001)(31686004)(25786009)(11346002)(2486003)(65826007)(26005)(77096007)(50466002)(16526019)(186003)(52146003)(6666003)(6916009)(65956001)(97736004)(36756003)(446003)(23676004)(65806001)(76176011)(53936002)(52116002)(6116002)(476003)(81156014)(6246003)(956004)(4326008)(7736002)(486006)(16576012)(31696002)(53546011)(230700001)(2616005)(39060400002)(305945005)(386003)(106356001)(316002)(86362001)(8936002)(64126003)(2906002)(68736007)(81166006)(58126008)(105586002)(8676002)(3846002)(21314002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:3;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6WFJCcmtDaFI3cTZmR08zbyt0VkdwZXB1?=
 =?utf-8?B?VlRIalR3N3VJSnQvQUFMaTljNkE3NzZWRm5aUEhvT29Gc3cweGpYRTh1ZGd6?=
 =?utf-8?B?NUpKMU5lQTVDVzVpSGVRVlEvMTc2RlhRZnl3YVRIZlROQW03UG81ZjM1R2V3?=
 =?utf-8?B?ZWJ5aGR4YnJ4Z3NWQUMxQSs4NUpOdFovYlpWK3N1aUxUOVhydEhvT3IwYktq?=
 =?utf-8?B?RzJyZDk3WWhQUkoyUXZzTEhjWVdqMTRPWkN3M1FvV0NWYU5ESm9wbnQxWGFB?=
 =?utf-8?B?QUtqWWxHdDZIQlRldHVBRGE0REJoZjRvb2FzRGc0RkpiZkdBeFMxQVpmeHc2?=
 =?utf-8?B?ZUdlMmU3QzQrU3BzR0dpSnRkTTNiMC9nakZ5UXdwRFZsZHkyTjFLSXBISG1W?=
 =?utf-8?B?cjZxYitiWnhuNGpYd1Zndm4zRXNSdUJseGd5REFKRlk3emlDNldWQUh1RUpy?=
 =?utf-8?B?RENuMmo0R1Zkb1JjcFQxQ2NkWXlyQmdCaURvc3dyQkRZdVkrb3NNVGlBeUx2?=
 =?utf-8?B?VGM0Sy96Si9nZHdTV2padHpXa090YW9IajYrVTk1N2NsYlFDUUNFdkNITDJH?=
 =?utf-8?B?QlNsMDNaWWdSMWlIeElzbXVBNXBnQXh0OHkzdXdYVWtaMnZQNGhZeUNYVjZk?=
 =?utf-8?B?Rzl1ZE1vZlUyRC8yTnBKalZHUlYveW42bXNDYzUrWEhuTjM4L0M3M08wTjRU?=
 =?utf-8?B?cDc3NVM4Q0hDK2NzY3pkbFo5dUxnaHBNL2tCZm05SFJuaG03SDRwVHB3aTZL?=
 =?utf-8?B?VU1OU1c4UWwrT3dvMExxWXZ1ZW1IczlDNERzaEl5RnhZOGZZbHpXNUVmOGc2?=
 =?utf-8?B?SW4wZmpSZHVTUHhxa0pvdDA3d3oyeTJhM2JmSzZsMlhDTFpVcEJ4clpBbEZ5?=
 =?utf-8?B?UThRWEdjbktVOUhqZlROOFU1eXh6SkRLVFVLMG1XTzRQZGh1NytLbm5mYTRk?=
 =?utf-8?B?OVJMcUsreW1OenE2d0F5bUo1K2dyYzVya1ozWXJGZkVWWXhEbkxvaEVLSWhX?=
 =?utf-8?B?Y2xjcEphNE1JKzRmQkRYZkdlWm4rdG51c1ZEWXA3U3ZJbHJFa0k4Z0RwSjN6?=
 =?utf-8?B?OXZhQWRJNHJETE9oMWNGR0VBVEZiTytub3ZvWjl4cWJlNGljU2FDLy9obGNk?=
 =?utf-8?B?ZEh1clE0anY0WFhCd1EzaTVxMllmL0NkejVkaEphK2ttVUw5SUlEZ0ZUZDhz?=
 =?utf-8?B?WnBRQ2ttQlZkR2pmZWJhMHhYd2xtMVIwb3NieENNeHdPbFUrSm9CZFZIdjZ4?=
 =?utf-8?B?VGROeXpBUnN0YW96N2pva0toZnBBT05rZ0ZRK1lEejNIYlVtN0p0dWNJVWNT?=
 =?utf-8?B?ZEhTTUR6cTZvdGVzYkF3SjdyZnl3MmIwR2Q2dXovc3E1MGE2RUZIcHBtWEZr?=
 =?utf-8?B?UWszWHpuTENKQzVrRWtNcXNnclkwWlh1RVI4TEYyOFVoSFF3RzNMSFF6M1hX?=
 =?utf-8?B?VDhGZEFWR09aY0Z1WWdjdTFVYWsyY0R0TFozQkJwaFlJVXpHL25SdGlxcVNG?=
 =?utf-8?B?VDhPZFhNclROSjU1QWcxKzdVTzFXTy9pOHR0VVlIcENpdDZueHowbU9ibGNH?=
 =?utf-8?B?Um1LOFF3V01sZWszQ3JXUVdNNi9YanNiSkRnNUNSSXhGOGRES0R1MFNiMXYz?=
 =?utf-8?B?QUZPNXVOM2U1VEFsK2JqTFVpVEhQa1g5MlhIVnZJdkovWHRhQjk0b3NwWHRv?=
 =?utf-8?B?SVNIYk9HMjdjS0l6b3RwdXl1QXdiMFBERUhhajJZYzRzOWYzYyt0NkxxVkRw?=
 =?utf-8?B?ZkZRdVJDRjFuKzJaR1hIQ3NUSzBBc3Q5NGFQUFoyVmZjclFHTVZQUjRPcldz?=
 =?utf-8?B?dVR6ekZVNGVsZmZ1NElVMmM5NmJCeHdxOXBPdFlRNjNLc3IxOEdqcWxoQUJP?=
 =?utf-8?B?dThCMmxpMHdXYkRpb0l6R3FNTjVhbUtOY2JDODE3bU52bzliSEdabnVVUFVO?=
 =?utf-8?Q?RBiOcidHx/oRQ7FBFwppkCkWDDcAEOoA=3D?=
X-Microsoft-Antispam-Message-Info: mWvV33EcvQ1jqgN3+vQ8IjuVtpMQWtYJoZjoeHmzKyMkwWdhCnyQCtwZszmhX5OF9vyaVe3GmZciE5IWgCe7i8I0pBm7pEvWl+WAHkgY6g+f3Qf7sVhXfMcCLeYJZJKJaUIs7gzgwBJk2SGbxIWNyG8Wsk/Ev2XEdjD9a2nAQm4ZqeVLJcN+nNnL3JUfwxxVXNBbS5GuyrVJw2VCmuISvIbWm709pcfjGYJlp/PE5ATixwnKUEBZ61cdSu8J5c9GPKNMosKRm8lX2ZlLgJZSF6TMqdDij5cYw0Ee7iGF1uCYO1L+KiAdnwFmv5ajMK8jb7s3zoamZC75JTSHgVJCRw7BOnB/KVZbUcbgnEpiGp8=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:sGfijdh/Ca01x0NFF2yguJOwBkPh9aN7SmEw8rDsMx+WXTrrJ3f5+CeiFhmy8J85OlhzJBvY52cD9Up/tOvWfvO3ROyMnJRdBkcyTrU4C+I4rrJC3vDF+dhyg/qeU21hTls1zish8BqFqkIQis1Z8r2RnL8omi09V/xtEAYusyS9OPjmEWm924PZ+PWT4PT1AUY31E+OF142PZxVvzb6+k1n/0C06uskuCdRN4Dbj9vclkHUK2wv91weKJxvWOv+RiFXFOp1E048X2kxMMVI+ipRjkqqp8xVp4uXACb+18TaFE9lc3RL3miJREIXFxFLF6tL04UccAc9AactQ/Z+1fvHyIBKw7Zxz99BMTXSpGUOWJsaQIuCdTUmFJ7YD498eUncZIoXBn94HVrMfACsYPtbazhkOlUvpOZirkV+bi6+UkbDhTmNWxfdghIW3OkcObqQiCNSbDRsPq+Y4XmfOg==;5:LvsHYd3Wr6Oj08zmgjV37ftJO5yNU8xRXaQ+fTm//LjcBWR9jSbKhv37cmWaO5LmiLoApbSfA1vG5/xtzK8gSwzfKC25fm1c96j1djGAnNkIFXYE/Fy/pm1cMLw7AJ0OG6L308TiHGqQNBAKZA+dQzyegRhbTdKTNGH9ig1PmSw=;24:VGnSlZm/00P2h9Knzs4O6Hk5luTx3ntL3dNVsa0UOTajNaFbgG5bwNptyrNV2GqnGLnD3QGSYORPXkSlS6fCqkjjTuiME4AgOyRl3WaMv0c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;7:EITuS9hA8kYUCAC+TPwyI6yoBiRNt4mqFNJnBjSALNuCnXe3H83StpbtcCnbyQPkjGrASRZH6CzZW1ofmsJUW7gfmyZA4LGTn0BCecA6Zvd9XbN1wk4aztYOucWzfZ28foCG60lpcL6m5S278TWDCkiYw7OD14Dqua8qMz2ptKViHee1aImJihVqYfk/2BeusQOcPnUf34dRtueJBnJGLsxHvwO5Vh3pRVyXiZsK3GwXON5r5VCgTA8BUkcyqn9f;20:iMZaSYLzbwOUJTXcdpK2xYM1BKA1h+HOBs45Pet78VYH+gEje942AW0m2NYt2oMZUg6pvXuBzcHs5ZNQq3YAeLO8MN7sPhyq2qe+UGsZGMJ73IPGYIsSetNAc8/3VVs40gx3HeCFV9wtHUQAsMpvVrr6VPsguZIA1nfHqDlXymY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 11:15:18.9395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6465130-d735-457c-1789-08d5ed68e9e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2018 14:10, Michal Hocko wrote:
> On Thu 19-07-18 13:51:19, Kirill Tkhai wrote:
>> gfp_t is of unsigned type, so let's move nid to keep
>> them together.
>
> I guess you meant unsigned int so you can fill up a hole in
> shrink_control and as such reduce the stack consumption a bit (at least
> on 64b).

Yes, I mean unsigned as synonym of unsigned int and this is the reason :)
 
> An output from pahole is usually a great tool to visualize this.
> 
> die__process_function: tag not supported (INVALID)!
> struct shrink_control {
> 	gfp_t                      gfp_mask;             /*     0     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	long unsigned int          nr_to_scan;           /*     8     8 */
> 	long unsigned int          nr_scanned;           /*    16     8 */
> 	int                        nid;                  /*    24     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	struct mem_cgroup *        memcg;                /*    32     8 */
> 
> 	/* size: 40, cachelines: 1, members: 5 */
> 	/* sum members: 32, holes: 2, sum holes: 8 */
> 	/* last cacheline: 40 bytes */
> };
>>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
>> ---
>>  include/linux/shrinker.h |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>> index b154fd2b084c..d58aaaed34a4 100644
>> --- a/include/linux/shrinker.h
>> +++ b/include/linux/shrinker.h
>> @@ -12,6 +12,9 @@
>>  struct shrink_control {
>>  	gfp_t gfp_mask;
>>  
>> +	/* current node being shrunk (for NUMA aware shrinkers) */
>> +	int nid;
>> +
>>  	/*
>>  	 * How many objects scan_objects should scan and try to reclaim.
>>  	 * This is reset before every call, so it is safe for callees
>> @@ -26,9 +29,6 @@ struct shrink_control {
>>  	 */
>>  	unsigned long nr_scanned;
>>  
>> -	/* current node being shrunk (for NUMA aware shrinkers) */
>> -	int nid;
>> -
>>  	/* current memcg being shrunk (for memcg aware shrinkers) */
>>  	struct mem_cgroup *memcg;
>>  };
> 
