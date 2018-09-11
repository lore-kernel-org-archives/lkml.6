Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95712C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1AF20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OQ1sbJVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1AF20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeIKQD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:03:56 -0400
Received: from mail-he1eur01on0104.outbound.protection.outlook.com ([104.47.0.104]:53472
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726569AbeIKQD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+0C6mWXdNyfwRN6MJX78KBDvPdO5H2/zwjtIM+lfR4=;
 b=OQ1sbJVRqya2yyy5hxfXAkAxXzfSikMPv+moI9q1vFAQw/wuj1SgoDyWreBElB/bCHXvTqApRd6Fdw/fiX18Q2S1ahPYLZVegNSGRKsQ/kxJAeTAuV79kiwEo0e6p3gqxX1e5uPgVTP/efSVsiNJMHS57halvHNlIpHiqp6D23g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2024.eurprd08.prod.outlook.com (2603:10a6:4:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Tue, 11 Sep 2018 11:04:16 +0000
Subject: Re: Re: [PATCHv3 2/6] tty/ldsem: Update waiter->task before waking up
 reader
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180911014821.26286-1-dima@arista.com>
 <20180911014821.26286-3-dima@arista.com> <20180911050449.GB4065@jagdpanzerIV>
 <20180911054129.GC4065@jagdpanzerIV>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <fe682c8e-494e-6afe-db95-83f77de55d8a@virtuozzo.com>
Date:   Tue, 11 Sep 2018 14:04:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180911054129.GC4065@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0602CA0003.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::13) To DB6PR0801MB2024.eurprd08.prod.outlook.com
 (2603:10a6:4:76::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91bd0d61-813f-49d1-2f42-08d617d6515d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2024;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;3:MFK/R8TIUAJpcpHUdgxAuj6dvWHshf7Izs2hVy3B+C0dKQgppEGweB/vQ2y46vj83tLPkYeQbNnjIILUD87BtQK5pZmDR6HOcjyfvNEe9gpiZGUhPyI3Yy7j30aRaAoTKmB58P9NjDmdgHxvORUOzKtOULpDwwF4nyeMGyiARWQXX9hBdmLeI6ghOjdiSJ2QQAPLRfLq3GlMITDw4HBlyg8ixE7ns/2AtzgbGTS0v1BFlJcQ9mH0HPajxyHz4MhZ;25:XslUbgqneocXdKxHQ30P+F5eP4duxZrC0Jik1s/eLkvxjiyADHBTlKR/6UJJthSmOnq1miAcUMGFAEIqEwcfW2fyTiSJAEdyHcHIrI8IofQDFRI/QLATGisuK8sByzacB99er8UX/FVx9hr93Ed2sbc0SGz5cdUU4GoCGyQgVtGz9InLJiuLrNhSAqLPl5EET8wi0MKQ2x+PnYkmBpaZqjR2bK6xhTAbBlXYQ0bMIFX5J2/DcIN2M5RLZKAXzsLJM4lkD9cAgWIiIwS1SF941+mW1i2aN9IYd+M5notCAmHcZcnkf++qs23cAgV45KK2yRyLJa7jPgHx7cBO4eA/2A==;31:5wTcdkvoItmuBuYnWqEeAMMbjGReXugZTNKSXACaFcljNZlfC4/bQRiKhAsdZyguI6df2CqedhuTdkqgk6Do37gsrinbEK90831L4zqHDpUT8RuIgyBxRPwkrRhsk/eeV11IaYKd+5jqt8xB5dx82qulkrtX99I8xCr3XfhuWIU972xng7trsmoixSyjGa5dOnspWFDlsQv2uFYFVyjmBnD58LjelAP6VDqSwhnIbEo=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2024:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:jpqc710LHSnUyrSJkE9/Ing5XCvl3vqqR61TkqL2AIKj7NAYf5/RgmuFi1wBr8zCn2wNc+vgedK//TChmjKTqVQbx2s5vXHRuf19OzWYMnCb//gSFgbDVgzWXXjFXNAu/6xv25GsBdyR+7RWBkMIZCEf/BwRNrQH32H12SctRtpy+QFcSJAVU/AnUcJ2CrHCStqkcX0uLNEOC6ZEixZQTSgJRXdLyACFAgwovv+eFWvmvVv7EpML56dBsqLH+vg14NY7nSuE2bjtN2rBzuEs+8RZRNnyBgCZOVWOYCRzjHBxpflc/SHMrA5ZNWSDGheZEVIfNISyMa/1BauX8qz6HamXdH1lz6L/dQvG5gylpww/M/5kMtTfE9Tr+7IieVvVm/3uo9xh8N6AeywEP/mN087HL8UgZVmBx7V/NqVGkLsqmZPCpxFM7pj7q8mflBev8aoplmSNJJymUIDmpkg65fIGc1px0kzBXojNPC475NEMBNtxU4UfyfK6xewyTlnM;4:K2oyfoOuFMG6tGMnlY1Weamh+JDjcH3PSmRc1Xg6xw0q2SBfZxwXPaXH2Ix42FipTdDlD008KMqeiIVd2cveHTd8uIrdhthWBtNClsa0TgkaF46Aq5fx6b6yr/Xd1lRNHh5BWst3xXnNENBMiS66pWAqwpIlfS9Vf/3Ca8q9zNIwf/5/lkUaAwmTZY7vo+7jBVDD8gxVTECFffEecm0QQsmZUoaLnlMJh4WA7n3cE5jnME87Q82psxCTHgUrTFpw7a5KbriO3oFOjdHBftiXIw==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB20249DAD275452EBD5623036CD040@DB6PR0801MB2024.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:DB6PR0801MB2024;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2024;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(39850400004)(396003)(136003)(346002)(189003)(199004)(51444003)(25786009)(64126003)(6246003)(7416002)(39060400002)(446003)(68736007)(50466002)(230700001)(4326008)(2616005)(86362001)(11346002)(476003)(956004)(31686004)(31696002)(486006)(93886005)(105586002)(106356001)(305945005)(8936002)(47776003)(110136005)(16576012)(54906003)(58126008)(52116002)(23676004)(16526019)(77096007)(52146003)(5660300001)(2486003)(65826007)(97736004)(66066001)(81166006)(81156014)(8676002)(65806001)(65956001)(316002)(6486002)(478600001)(386003)(53546011)(53936002)(229853002)(76176011)(7736002)(26005)(186003)(3846002)(6666003)(6116002)(2906002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2024;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjQ7MjM6dGVaNFlFUTNjWFNTZ3MvdlB6dE15ZVMr?=
 =?utf-8?B?VTdDbjBMNGh1aFMveDNvK1ovSjlPajI0bndpYzN2cE9mMzBORzg5bkUrNEp1?=
 =?utf-8?B?dlFRS1I5eERPcGYycjg1NmNvV0lnUGxsNm5zbGV6ZEx1WmFDZkEvM0tmSXpv?=
 =?utf-8?B?ZEFzWVF4cis4czBCaDJvM01TY0hRbkFRemNDaTY4ZEdzR3BtakhYV1VPVkRR?=
 =?utf-8?B?YzNrbXVSaTNpcEVONEVOb2VhWU1VNG4vRTFVTDFITk9hdzNtbWhXRnBoSjZ0?=
 =?utf-8?B?bGhYZXM0T2hzRjZaaDluT3VEQXFyRmZMcGlBeTRobzhtRUlRWkRnQ2Y3Y1JH?=
 =?utf-8?B?K0Z2aUtBNXUzTHY5dnpwdVlNeEpkWUl3a0ZTeXh5NXB3YVlHTkx6clhRM0xX?=
 =?utf-8?B?a3J5VXNzdzhndzhsdlo4TnpRM0k2ZG1jSVA5djFObk9SZlBMdUVuOTFIUi9U?=
 =?utf-8?B?V1B0Vm9jWEk4R0czWkFMR05tY0k1OWxISWwxdFk0OGtqQ3NUNE9iVVZWNG4r?=
 =?utf-8?B?S0lDWGNaeUNnTVdzNzBKaDZpT2NTaHBQR3FBY1ovQ25GTDhIdExmNFBUdExD?=
 =?utf-8?B?c2NiRVRsaVpnWDVzYXVud1FyanRIMGU3NzJuVUd3eXJacFlrVlFMTDFIdXlS?=
 =?utf-8?B?SklueEkvdUNPZjQ2R2hvaEZVL2R2cjVFa053bFF4YzJPMmVJQTBTQ3pUdVgv?=
 =?utf-8?B?WEk3SkkwU2hGR0NHNGR1R0dzampYa0lLNU9KUFdXWHIxTlNJcXVLem5WQ1Y0?=
 =?utf-8?B?MXhkK1ZmamxpTy80c295a3YzZ3hHUlRkSW1OZTJrYkZZQmtyN0ZzYjFJb1NW?=
 =?utf-8?B?MjM4WVN6UHNqQVdMNlZGWWk1aFkvK2JuNFJQMWxOTmpSM2ZRMjZkRUorcDJK?=
 =?utf-8?B?dnlZV2lFa3VFVTBFNTdqQW5reWJKNUtLbUt6OWZHN0RQWVA0U3B6ZW40ZDVP?=
 =?utf-8?B?Q3hCNGFVVDFzTjF5R0Iza3BKUU9NWmwxYzJ5ZHB4L0Vxa29VaWc2MFVBYWxP?=
 =?utf-8?B?K1g1Z3c4Q0hqdThlblJ6ZTFaZVJNQk5ZM1hkajBIMytqZTlFSzJqYUhOK0lN?=
 =?utf-8?B?RU5nc1NWcUFTQ29UM0dFTnBMZXdnRk9ib29vbHlFSVRvaEF5SXFidkROQUl6?=
 =?utf-8?B?elpBa25uaFBSb1EzKytYamlHV3NjbXB5a29JcmZvcGFMT1lvbkpVOGN4QW0y?=
 =?utf-8?B?MXo5cFNCVzFsaFk5OExIUEpKTVo5WXo1ejZncmsyTTlwOW9CY3B5RC9GRVRU?=
 =?utf-8?B?RHhjTzRyMGQ5MkVIWjdWR0JHeEpBczZTMDlZM3IwK2NLRHZoUTF5Q2dzcGdM?=
 =?utf-8?B?SWZKMFhoQjIwb3VmemtXb21RUmxpL3piZUVTUTNlcnkwYzhWWXVDOUpWTURE?=
 =?utf-8?B?Z3NKbTU2NHNOdlVrK2IzdkgwZjZjYjlINkFNQ0FpdmtPaVFyeG41cEd4NVBo?=
 =?utf-8?B?YzNVaERHUUpraWVZNUMvcFkwVk1CaXFkWExpcWh2Nmdua3NxTDh6c0RoaWgz?=
 =?utf-8?B?WFlWSUxvTzM5UWhOR0xMMldLcmk5Uysrb3FBbmRXODVGRW9rQVV3UzF6VlFw?=
 =?utf-8?B?aW13VWNoN0JHdHlvNGRJOGFhVnUvL0lVamVpM09QQ29MRVArSkM4NTFRZlIy?=
 =?utf-8?B?VUtRV0puV3NnM2NCOGVmdXVlZWIzaVZGbWN2WTZRZEUzRWdvOHY3T0hNaGVG?=
 =?utf-8?B?SmtkQ1pKVVNUYWJOc2JzNExBK01vYnhFZXI0R3lKcGNvSUFwMjhtcjZyWjdJ?=
 =?utf-8?B?OGlHVnUzRDVHUGZVY0Z4L05hNVVtZWk4MkZpOE92N0ttaGpMZXhjM2g5d0U3?=
 =?utf-8?B?TFRhTHNsc3BUaHJDM29NU1BqQzEzSVJkUEhCdmJmM2ViRCtVZWc5eDZkci9G?=
 =?utf-8?B?Z1UzUGdiUHZZUXpXSFpEUkVlbFRsOExKNk9rV0lBRndaTC9vZW80K3ZDWW9S?=
 =?utf-8?B?U3h2TkFIZis1bGhyOG5iRnY4bWhCcWNvc3VldXVQWlhydXQ4amRaWFoxZXFy?=
 =?utf-8?B?SSt1RUQwM2JKVWNiN2hjMXZtaUVyNytBZkxocTU3UGdVaER6cit6Um5DN3Ax?=
 =?utf-8?Q?JJ7IXc=3D?=
X-Microsoft-Antispam-Message-Info: +u06rkFtGpQX2ZOytFDqgVuvuCjcMlmlZq45DzupwoDfrAaj3xwzEZO93nlQZGH4abCYtU/zQWqHfp0W7+tM2f56mRSIH7f5of+pVjmB9jAo+7iXDmfYhByHFwzmXw6TdLgxXHe+UzHeqd9tQYWJd7uKvixSO3vADVCEkiWIL9ZpNnPimD5Sd58IP9xkaKoW0S97YiBfxfLoq2sTigA2ZJgDQtrmgQjs6h8Lfp8GfQHVgORNB0/UrvNWmbWRu5/STe9sib/9fRUBP2nqDzS+0W5qnP8QHIOt+jaNTeGp26XyM5CF0Te0oxiur7yEWoVlxHhT75VonU13epGSp1euRuPc/WHLG78A2px3SCSd6Ig=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;6:MgT9js3wD4ju7fHqpNovFQRUV015uci/NmzT/DLlMd3W9ItrKtGTfvPG3MYrpu04JzjVxEHqJtJRcjwXgbdbb5/jHbpgyBz5n0A1iMVWm1T62ZcPOTGjdbqfOqDayprtyyMtBQnd1Exf4RIoe+d4aghHL2GiQVcXh9vnRY01LaCH0a0d8ndpNZhjklEW5UwvEzynPf3Kamq9pQnN/Bieypt5pDrcVUxlGyHX5+LbNCrhAhOGB5oeBzICpk4+c3MvLnQgucVd6VFE32mHGm8YmIu4nFVS5LkBx36C46IupD38J5rcGt70UYmN8wFb0GIKsHr0do+5WYL1nGT2U6ZQjsNUspe0JhnHDfs5aYuSP9duK3diT0BZ+DR4JasfukJ8td+y1l6sTCcoCdu9ZBn/DajV/h3QyK4PkT2VLgBetCyErmsJxLTUMVw/eSKEwOyB32N8fbWYruCCe+PPLRhTeQ==;5:KwAjWvRjC/n+ibiLbMk8H1D7o3OC+LKyTemxHK2FNd20oSeRzJlicw8WNa9stheBfwXXTuVeb9fTgV8YMW5UlN/fSmOhszpXuN/vmwGPM7qq9hkbdZ1YQOi6+EGfGmHPt1VzkJLWPp0MjtU2mH9C6hDNkbF+I8tv7gDZptkYBCg=;7:uRhDqDyzExG844N62SlGL+tJwk+8v2hhWohtCz91UZ7f5briKS6f4ZgwHK296naILk8be+pA2MzEEZgEgtfquX8lrbeIQOFsCs5ms076/9UQkvCYNQz7vAG5rA3ssc8lCopSn7l4qw3zBa3qb0HEtH+1Vi2FppMSgTvodrvjJ1jZTML7e1sAOVOX4Ksoxha1R9RWHwte0D4g3uV8jpZMHwteWAAfx/I+Oal816XAMEUVvkmaNG6JqTt8kudmveBg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2024;20:Wp6QWVLNlNlTALW2MZ2bdVbvC4eTeeAXY18yXxfSpwbbatXNpu1d5Vm8u+qG95Ns0wuWBW5zGOtlIBwng4Z7zjKNZxpTO6//yxsC8dt64ViKgyL7U4wQ6JhBchwNmhHDwnMyWgpG6gvfFgdC1Gae7VmfrG4HOw6lXL7LwILvYiA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 11:04:16.2036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bd0d61-813f-49d1-2f42-08d617d6515d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 8:41 AM, Sergey Senozhatsky wrote:
> On (09/11/18 14:04), Sergey Senozhatsky wrote:
>>>  	for (;;) {
>>>  		set_current_state(TASK_UNINTERRUPTIBLE);
>>
>> I think that set_current_state() also executes memory barrier. Just
>> because it accesses task state.
>>
>>> -		if (!waiter.task)
>>> +		if (!READ_ONCE(waiter.task))
>>>  			break;
>>>  		if (!timeout)
>>>  			break;
> 
> This READ_ONCE(waiter.task) looks interesting. Maybe could be moved
> to a loop condition
> 
> 	while (!READ_ONCE(waiter.task)) {
> 		...
> 	}

We can't reorder event check and set_current_state(),
because this will lead to missing of wakeup:

	Documentation/memory-barriers.txt

Also, it looks like READ_ONCE() is not need. In case of compiler
had optimized this, then all wait_event() in kernel w/o READ_ONCE
would have not worked like expected, wouldn't they?

Kirill
