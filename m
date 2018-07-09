Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DC3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE3F20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bPVSpLIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE3F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbeGIIka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:40:30 -0400
Received: from mail-db5eur01on0131.outbound.protection.outlook.com ([104.47.2.131]:22592
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754383AbeGIIk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2ESCccgvwPXUBWqT/nZctizvXUAPLunCLN1xW2YGpk=;
 b=bPVSpLIQJ7w4m5FnvZ7BiYAs0NH9Dt1Kw9zHrO/4H6R4D4xwb8C0ab5s8r+5KHdbei4rT/sBz1Z7pDGijel+m+zjBNCTx4w8CxPpqBIrggv35HeqYhey6ZI7XniAh18PGHKRPfSlxl4BycFIHtuzBnW4g+93qNCrkwgHk050gh8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB1337.eurprd08.prod.outlook.com (2603:10a6:3:39::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Mon, 9 Jul 2018 08:40:21 +0000
Subject: [PATCH v9 17/17] mm: Clear shrinker bit if there are no objects
 related to memcg
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Mon, 09 Jul 2018 11:40:17 +0300
Message-ID: <153112561772.4097.11011071937553113003.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR08CA0116.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::18) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fce10e8-be79-4252-4fb1-08d5e5779cfc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:gs+NfBcJfK17zUxcck6h+OQIkanhYBTdldrl7wbaZ1mhpKcqIfZ00pu6u+lZSScYDbcfpfChcS5kkIyr8Ou8hjI0K2x+0+8JCL4UHx/xg7yfN1X3BN3NHkFaqVGhtq22DNvcJC0GdGfhT+wnL8/zLz72dbJ04veyrjUlQ/2GoyNYAHMg3iL+8J52hCHhda/8WQBiqgSpSrnHLyjets2zE/w94CUPCr0G97vUE+OyZeWt/+fBf0bpRorNNErdFRKa;25:rh9bmZso4J+fcO5kxNdOhY1vTAX0W0c0jELkj8ZmAdm0Ydw5IfnSGW7ktW9LSUOcGNdgkzFFDSbgqeAufZpUrtZjsK2nVt2TFl1y960+Lhv5n/DoM84eR8xO+8CgkQXielGhXY98EThuZv8NCnXdc/LkS0ItaaLV//pwblwFpoqu6055YfOTwKXpePeQxjclvsRxfkOnV7ZfHCkQmLRwpGpXq++kxh0ZAa76mNbQgWq89fop8v3AqjxP0FusewqHmxIeYQmxyH7ypccy5rN/tzTOCISZ5pik/KYoXklKJRoQjxQE0dLoSvOKUCixRvicY140hZi2zika8gZrn8jyLg==;31:FbNRghqhg3fDj0kaXXV+dlpJScv0V+7+Leiv/5wMuHbKlWkg+bET7kjQRP1q1YIWRSbSn42eoVvzIVYkUFC232aJqju2jo7p7an8gJWdiCsqe13/g9qy/9P1t+vsJe+tKD9vvcGH6Ahm2Luoqtn6zhOHZaXTLsI93/g5bpfdjukOUtCS4MXMIaBEyT/fA2+f0Dbj61GkCrH3vgzcNl/ULD7DAHWdwCDji0PnIziU+do=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:EZ48aJCm2fAhj5QxTlHy78RYr41sHEZER5sEW7V4dEGeaaowPxrpKcy3TPx1Gtx1veTzG224YUJbhQMrssdKjywQp9XhbFY865au6Itis0L/PMrlBdkPSvfcrFl/jtxqHfuNp6+khdtPaJ6wqZOjxxL1NCzV8enGfy6H4bT3LRu3r7Cdu3Q/vaMF9owDpLWTrNjUQmx/lAZpGZDs8HiU9tEVu5iY6jSrvCdALo7ccTzy66FB4Y+pnJpjmKu98tIOvb80GwI/Y4Kw05k0haiyn201nR1q4n0wMgrO1WcgAn+zTT0btjsd+BIw/23UeBHNRlpA8zkJ+SXEmdy274BrQWkrCUITe2l+9O5Dl4C4uCHbiIzPGerSjlb5MSOjT2BOnnu9u+PrJtdgwEyQXISg3Vfp+egUE6NsnFKECriElNQholWAtjlZ2xxbuLa6mn8tnD4qGcDir85ZzzJx2rNkbbWbZ7SeaWFSwp3zMr1WWUqPrGTVwApizFradFNVGa2z;4:6iZcTdeFx+v29mQ1mRivO6cXpg9A94OC3AsQWif2tIXu/29HpuWBTbbrN6U9BGNyK+EwueD0/OfHy//ZrJy7yqVYIDSsw0YfEVlZzBDuXtLAXfNRE9yVRmgwsLcTes2fmAaEsJtznakkpw2WmSIMa1Jbi1ZqADBh3CnptuWOOahnCGj74j2SpQKK+YllBFOwGHxHEbJhS75lt57ZT/OLd7lF6y2BEoAlf1cQWcWCoRJFwri965Ed7Z6JX5CtI7Vrsg0FdB8M61PNTsgmb6tdfVPc5JAy8FAAKhayS+FXsT65Z5Z64bSOF4edzhPqWRruMQLwZzY12qjuloj7cPOhLrPkPO2O5Cf2UBdSGVpgGMO4OVoEbuRbHSsTZXr/wzmdfQl/vfknUcv0ZR25BsVRzKw4ezcKjCA/N5/n+gLYfmM=
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1337AE7964B320BC9383B581CD440@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39850400004)(136003)(376002)(366004)(346002)(199004)(189003)(9686003)(14444005)(61506002)(68736007)(230700001)(11346002)(446003)(956004)(476003)(8936002)(53936002)(55016002)(2906002)(47776003)(486006)(81166006)(81156014)(66066001)(7736002)(3846002)(305945005)(6116002)(58126008)(23676004)(2486003)(6506007)(386003)(8676002)(76176011)(316002)(52116002)(478600001)(106356001)(105586002)(50466002)(97736004)(16526019)(86362001)(25786009)(103116003)(7416002)(39060400002)(5660300001)(33896004)(7696005)(26005)(186003)(6666003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6NVdkb1hDdUkxOXA0ZkhPQXpNanN3MlA3?=
 =?utf-8?B?SjRocmsrZCtxcHU4YWhyTUVBbVV4TUErMm5Lc2lvYnJUMmV6NEJ6aExJRjg3?=
 =?utf-8?B?RHJJaXlSQkpoNXduQk5KMCs0V2U3MHFxdHk2Z0VXYWhHTjlUQXVGMThNSzFV?=
 =?utf-8?B?NHJEVCtmWFhHeTZWdURCSHppclZmbDNMMUtoSFhpVEJYNElHTzdoTGxCc2Er?=
 =?utf-8?B?VXFLVlFOTXRsMDV2WW5kS0hHMUR1WHFYcDVvVGlwTUZKazJYNkFUbjZMTjVz?=
 =?utf-8?B?Rk9CdnNHUm1ldFdrbEJ2eVpsVHJVTFd6VnJoUStKSWFDbWNwb0IxMXJCM1Na?=
 =?utf-8?B?ckFWbkdobXd1SlY0dU9OdTFyYTROV3hZU1lBV0daUTFCNlEyUEh5a3FwRkFT?=
 =?utf-8?B?N0pNUFU0cWhwRDBRRHE0SjgxRnJETnQzc0ltWkFRNFROR1BGRmJEWklRQ29t?=
 =?utf-8?B?R2lUa2xMbnFWZXc3RnYyZmtCVTYva2k5WWdKeXQranVGWUkwejZjRGYzU2ww?=
 =?utf-8?B?T3BKblkyaUE4dERsOW8ralNtQlRKWnNldTJFNnRWcmRVeE0rdkdGWkVNSml4?=
 =?utf-8?B?YkdoWDBMVlRET0lKRDBCSFdjNXBINHVnMVBlRm5BSDloSzBUbW5TdzN4UkpK?=
 =?utf-8?B?blJqNUgrU1k2RVA3bnEvaHU5S2lMYWUwWGc0dk4rZ2NKL0k5a0ptVXpQcnhY?=
 =?utf-8?B?eXo5a0NXaXZlaWU2SjRwWVVwTHVMMmdpc0FLdVh6bXNuQmIza29DR0dDeTdr?=
 =?utf-8?B?bnB5MGI1eHFiN0w2amNzdk1BUXp4TEV1MVdoT2xCQ1cvazlYZHFTSjdqNXV0?=
 =?utf-8?B?enpYSHZhbGxmSmRFZThCYWxJcXNVSlJKVC9lZFFnN29mVUhTMy9scWlySlIx?=
 =?utf-8?B?NlovTlBqU096OTJJU1VvWGh5SmpjTkd6NzVYZ3BrSXdmQ2s1TE5YVHArTTFq?=
 =?utf-8?B?eUJXaU9lZFRmSkROZnpIK1oxYmxBbyt0eGF5ZE92MnVnaG03WXlzbHJTeUVN?=
 =?utf-8?B?eVJzZWpIdW1PdVk3d0Rmc2Y5UkFST2xSRnBaMFlaR0E3THh3NCtXeWorM0x3?=
 =?utf-8?B?SUViT25pUjRmUHRjc1AzOTMrMXJSVDBkcW01amkvdGNPMUdOMnZoY1NUYm1z?=
 =?utf-8?B?VDBBdjJXdkRNbWFiYjkremRxbHUrUG8vblZqN1JVbXN2aFhKOXNUWnltMHpZ?=
 =?utf-8?B?RXk4M3VWVng5ME0zbEFrbHk5c0E2ZElibGt3V0MxeG9jN2dWYU9ab0I5WjJj?=
 =?utf-8?B?NWJxeXNUcVJseXVTZDkxeXQvaUF1WXBOZ0xoOEgvRHhkZHdvQ1ZxRC9yd0lW?=
 =?utf-8?B?NFRKOW1iRXJrOTl3bUVRM3d0eGpLcXh4VHBDU2hyU01WSjhTMVZIZFVnQUJY?=
 =?utf-8?B?VTRjUEQwbVIrR3FUVzhFK2IzMkJSQXZrUC9Vc1BZQkZLektoTWg5ZzFJNVdF?=
 =?utf-8?B?UmdvQ3hwRUZZM0J5M3VadnBJcTFhWjRtQ2NnbE1HSDlJRC9SMjhhMHdtdi9Y?=
 =?utf-8?B?anpMWHhJSkY3UkwyU1pEc05FbXFiZFl3K3lNcEIrK0p3YTFmNS8rOXo5cDFm?=
 =?utf-8?B?S3E5d29ocVlNSzFxV1oraUVzVnVwNFJIbjNvbjZxZFVqaWVCM3NzTFNHMEt3?=
 =?utf-8?B?MzAyWVFLWHJpUGpzSHhaTm5qT2p4RUtPUWdmdVhjWDhnUzBXOWRWS0dwYmJK?=
 =?utf-8?B?dWd0L2tOSi9FY0xCQWU5RXZzbFV4b0xITko4VTMzeC95eUt2Yy9HM3RnTlJL?=
 =?utf-8?B?djd2T0hqUm5iMGpVWXFIUW9nPT0=?=
X-Microsoft-Antispam-Message-Info: KkII1YjfvkZr47Spl9NITPIO1IRSX7nMZwcNZQmtYKQNcYziplWBJe3l2onza+FCOUT74HNWH4yAtkp0/muHESr0HX0kO2HPE2ZRprb+FunuxTrsSzrOw/UPRHanprjyxg3ycyjhUHq8yKIo5H598DBTgUSFdoLOorBC5QfzNcZKHPHQFxw0nRKnwPMzDjWo60vUyw2w7MntZWogqlOjtmOqdUVKVU2WYJpyvXYmgdRUYxsZBj2fu8xik9D/5txLsuxhdhWzCIX23NkDscS0q5op/dxGtLYOSRlo3fP/uUjp9UcVFqputT/qSSzm7/hntHyRqZMwt8eTNrN3ZcuL9iWSCz+261VpMsRPHyKoiXA=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:fFXYBG0ciI90tPElGUvbn2U3WXV5vMBc9ywaY8JuiH+j84RrfDvZWnv6m9KqoBfa+8nBS2J4v1EtyFBkfe0vzZgG0c7k6c3f15NPMWv4iv5KgjsMqPT9K2Oo3N7LybjAd0O1GJ5uUoBJ5vXuVlKF7VfqvTfAPtGut1wES0kd8Zm0wMmzFOyw43/aoF+TjH+ljMbhTBaXihOoVMIdrzqD+8MUG9l+lj62m3GoYBPjrAbSOJvYpODHcdVwCzleB3BOFOPa/8OIqvANZU1MKkx9kJZNbspneHJgAnC9PNgjp2IMegi0V6FYDxnXMVft2nSqK224eA4aqn4tvJnBH5bCAxWERkuVt3DG9M3xvYlL+PmeHRKqFFS/nSzBZzmRqLnC42eUrCJZl8RZTVzNHwVMzzH997thv4fl2Q4R1NxWQ6dc1n0Acn7Dttzm9/b7kzrK3TKx4Ns21UMEdV5zf/6IAQ==;5:5aiiiR1EBLk10Hs3GSPeDaxpbqdy6cwBey67KJ95SKtmDVaC41+2E6NCwGk58QEU7DR7Q4zgEnzIki9qkDDO6qMoQbvX/rYYoHdoz6L69sN7WG80spSa7t4sRHp5XlF7fBNRVvYleMEZEjul2tosC2wN7S0O2BdY0iylkJOrYBE=;24:Vx6tJJzxSWAPdnArOipjJ6AQShvelg/yJELhXJ5zv73mh24uoQjyGdwA1jIm107Qq+5zbKm4Ba1LZV47XRF/KsmtPV8r7dd8ukvnvUwKUsU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:IiqUhIpFKnaP0xgIxhtHXESGWxjG0EdRXBwJCugG3gx1xzagcSoL8R3mpRIaOHcBTdSjKCFGNaelvPd3iCvnyM+TCaFfbpsqxSc0oeOVHKusjnZyVATh0FsEhuVCVcl3ykdZMzRJb/iiy6tUdGjm8AJn0J/BrwESD3N15V3tX/L4/24LtMZ2wNEIe0QswoaWXIrNpgnNyb2yzqVvSb/DzsFUhT5WDdr+hmcacB3p1gRCyBfo1duxU30E09QdwOLN;20:lcylpBA/ShUKeIg9ogaQp8t2MpwRpA8rpZOkjINMTzCtAmybMARFTbr6fA9zkOYnJV9SKAU7cdN3S3ffMp/HEoo3aVFft+Svw6F58HrTfTVAd/nsZb3TDIzjuoWCTzJavt+zBPRoZ06KKH2TCCnlpnPtXjtL+1fATv4tGUFO1VU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:40:21.2160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fce10e8-be79-4252-4fb1-08d5e5779cfc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid further unneed calls of do_shrink_slab()
for shrinkers, which already do not have any charged
objects in a memcg, their bits have to be cleared.

This patch introduces a lockless mechanism to do that
without races without parallel list lru add. After
do_shrink_slab() returns SHRINK_EMPTY the first time,
we clear the bit and call it once again. Then we restore
the bit, if the new return value is different.

Note, that single smp_mb__after_atomic() in shrink_slab_memcg()
covers two situations:

1)list_lru_add()     shrink_slab_memcg
    list_add_tail()    for_each_set_bit() <--- read bit
                         do_shrink_slab() <--- missed list update (no barrier)
    <MB>                 <MB>
    set_bit()            do_shrink_slab() <--- seen list update

This situation, when the first do_shrink_slab() sees set bit,
but it doesn't see list update (i.e., race with the first element
queueing), is rare. So we don't add <MB> before the first call
of do_shrink_slab() instead of this to do not slow down generic
case. Also, it's need the second call as seen in below in (2).

2)list_lru_add()      shrink_slab_memcg()
    list_add_tail()     ...
    set_bit()           ...
  ...                   for_each_set_bit()
  do_shrink_slab()        do_shrink_slab()
    clear_bit()           ...
  ...                     ...
  list_lru_add()          ...
    list_add_tail()       clear_bit()
    <MB>                  <MB>
    set_bit()             do_shrink_slab()

The barriers guarantees, the second do_shrink_slab()
in the right side task sees list update if really
cleared the bit. This case is drawn in the code comment.

[Results/performance of the patchset]

After the whole patchset applied the below test shows signify
increase of performance:

$echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
$mkdir /sys/fs/cgroup/memory/ct
$echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
    $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i;
			    echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
			    mkdir -p s/$i; mount -t tmpfs $i s/$i;
			    touch s/$i/file; done

Then, 5 sequential calls of drop caches:
$time echo 3 > /proc/sys/vm/drop_caches

1)Before:
0.00user 13.78system 0:13.78elapsed 99%CPU
0.00user 5.59system 0:05.60elapsed 99%CPU
0.00user 5.48system 0:05.48elapsed 99%CPU
0.00user 8.35system 0:08.35elapsed 99%CPU
0.00user 8.34system 0:08.35elapsed 99%CPU

2)After
0.00user 1.10system 0:01.10elapsed 99%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU

The results show the performance increases at least in 548 times.

Shakeel Butt tested this patchset with fork-bomb on his configuration:

 > I created 255 memcgs, 255 ext4 mounts and made each memcg create a
 > file containing few KiBs on corresponding mount. Then in a separate
 > memcg of 200 MiB limit ran a fork-bomb.
 >
 > I ran the "perf record -ag -- sleep 60" and below are the results:
 >
 > Without the patch series:
 > Samples: 4M of event 'cycles', Event count (approx.): 3279403076005
 > +  36.40%            fb.sh  [kernel.kallsyms]    [k] shrink_slab
 > +  18.97%            fb.sh  [kernel.kallsyms]    [k] list_lru_count_one
 > +   6.75%            fb.sh  [kernel.kallsyms]    [k] super_cache_count
 > +   0.49%            fb.sh  [kernel.kallsyms]    [k] down_read_trylock
 > +   0.44%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_iter
 > +   0.27%            fb.sh  [kernel.kallsyms]    [k] up_read
 > +   0.21%            fb.sh  [kernel.kallsyms]    [k] osq_lock
 > +   0.13%            fb.sh  [kernel.kallsyms]    [k] shmem_unused_huge_count
 > +   0.08%            fb.sh  [kernel.kallsyms]    [k] shrink_node_memcg
 > +   0.08%            fb.sh  [kernel.kallsyms]    [k] shrink_node
 >
 > With the patch series:
 > Samples: 4M of event 'cycles', Event count (approx.): 2756866824946
 > +  47.49%            fb.sh  [kernel.kallsyms]    [k] down_read_trylock
 > +  30.72%            fb.sh  [kernel.kallsyms]    [k] up_read
 > +   9.51%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_iter
 > +   1.69%            fb.sh  [kernel.kallsyms]    [k] shrink_node_memcg
 > +   1.35%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_protected
 > +   1.05%            fb.sh  [kernel.kallsyms]    [k] queued_spin_lock_slowpath
 > +   0.85%            fb.sh  [kernel.kallsyms]    [k] _raw_spin_lock
 > +   0.78%            fb.sh  [kernel.kallsyms]    [k] lruvec_lru_size
 > +   0.57%            fb.sh  [kernel.kallsyms]    [k] shrink_node
 > +   0.54%            fb.sh  [kernel.kallsyms]    [k] queue_work_on
 > +   0.46%            fb.sh  [kernel.kallsyms]    [k] shrink_slab_memcg

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c |    2 ++
 mm/vmscan.c     |   26 ++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 70881f04775d..bd1e3823236f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -430,6 +430,8 @@ void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 
 		rcu_read_lock();
 		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
+		/* Pairs with smp mb in shrink_slab() */
+		smp_mb__before_atomic();
 		set_bit(shrinker_id, map->map);
 		rcu_read_unlock();
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8199e1b9a204..93fdd0375b64 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -596,8 +596,30 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
-		if (ret == SHRINK_EMPTY)
-			ret = 0;
+		if (ret == SHRINK_EMPTY) {
+			clear_bit(i, map->map);
+			/*
+			 * After the shrinker reported that it had no objects to
+			 * free, but before we cleared the corresponding bit in
+			 * the memcg shrinker map, a new object might have been
+			 * added. To make sure, we have the bit set in this
+			 * case, we invoke the shrinker one more time and reset
+			 * the bit if it reports that it is not empty anymore.
+			 * The memory barrier here pairs with the barrier in
+			 * memcg_set_shrinker_bit():
+			 *
+			 * list_lru_add()     shrink_slab_memcg()
+			 *   list_add_tail()    clear_bit()
+			 *   <MB>               <MB>
+			 *   set_bit()          do_shrink_slab()
+			 */
+			smp_mb__after_atomic();
+			ret = do_shrink_slab(&sc, shrinker, priority);
+			if (ret == SHRINK_EMPTY)
+				ret = 0;
+			else
+				memcg_set_shrinker_bit(memcg, nid, i);
+		}
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {

