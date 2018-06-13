Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4F1F4C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FD2208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="CAUKS3nF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FD2208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935713AbeFMOGH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:06:07 -0400
Received: from mail-eopbgr690086.outbound.protection.outlook.com ([40.107.69.86]:47184
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935183AbeFMOGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8TAo3MiQJZlDv+rDKvv6A34BcCtwZixvTWRSNWBAHQ=;
 b=CAUKS3nFQXVu6sNoPFos4Imi2U1V9RZBkmfO6hLQOLn1BcJzjc7ISjkSYPl3ipT5DV834dY/Ik+h7rZfC6Njf6eA3Ne5U2iwvfp8+TG5PkwjTuUBeEvabevbcWoymIjEMePTWgrBd4IAX+RlzNeejLB6hMK7Q+RvJ10/bA7kXd8=
Received: from localhost.localdomain (155.4.205.56) by
 DM6PR05MB4588.namprd05.prod.outlook.com (2603:10b6:5:9f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.12; Wed, 13 Jun 2018 14:05:56 +0000
Subject: Re: [PATCH 1/2] locking: Implement an algorithm choice for Wound-Wait
 mutexes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20180613074745.14750-1-thellstrom@vmware.com>
 <20180613074745.14750-2-thellstrom@vmware.com>
 <20180613095012.GW12198@hirez.programming.kicks-ass.net>
 <69f3dee9-4782-bc90-3ee2-813ac6835c4a@vmware.com>
 <20180613131000.GX12198@hirez.programming.kicks-ass.net>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <9afd482d-7082-fa17-5e34-179a652376e5@vmware.com>
Date:   Wed, 13 Jun 2018 16:05:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180613131000.GX12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR05CA0182.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::30) To DM6PR05MB4588.namprd05.prod.outlook.com
 (2603:10b6:5:9f::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eeb0cea-77d7-46e3-2ef3-08d5d136ca76
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR05MB4588;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4588;3:Nyl03vkDY2bheofCpDnDFGk4oTDpqfuivHbRa52jG+JIxrJAUh9/FFQLVhPgyYQ+znOuxwrCw1DBWohFCTkPxIU64uv+wmzvVXimHeGyd0uRJuNgRb5SaWMVWJwRWhh/NW95Bj1XrnSKLqdcbDYZYcE6VMsUya8XpQuyBvfvT7l5UuWxPvRL14KKwqVvpny2tfL/6Y+H45zlpuuVmsLmtZTM6iAOKHZvNOCaD+wKJwM4vnqXMVLK+G3aAwIL3O8o;25:sMDQ+8NxHx9ocTQ67nlfv1rABGm4JkH+YDTSOsRfVUcjFSNk6r7sUIvQsSnOv8FvcE0RqYu5TQ67En9jWDmsem/58/Q2ZfJ9kJBciEE0RrjsgdW/KFrr4biXXLP+Lyns9/4vOKCaoo7rZIWPTbuVU/G3czSXopIxqQVTvJR7flrGKMyhgeJnhZPBl13GuSgUVm88Isv21LzTR1qPS3vNvXAB8yre940fs6V1bJRfH2uaq3zTF/gn0szb8uh1ln3zQaYGI3GJ10HdaysxHs6k28Dnyx779wCbHMbNJE28dB/rYYzewIkPFnt2XENyJ+ZWLdskfOUrkPmpYIMuDZzqlA==;31:bq2gD2eVF0np0yxbP5InfMFg+bkFhopvb4FGQwpmtHupq4QdTKZ3Muxv1gUrcN0ryIOSQLXEuK1D8jQ0hvbhWIl9KEkt8CIgTwZJj7uF/EdOW2zFZ6OutlVH7w7CMubbLScG1VcJe6nwx8Cib6G6K3wU6nbagyTxnPuD7r++NXefkIymMe5bIoACZxo8wlBe4lerykd9F/AjNL9bTifMLMQfCisN/gJ862cyfvJZ8EY=
X-MS-TrafficTypeDiagnostic: DM6PR05MB4588:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4588;20:J3J8xnyZKIoRLnHo61UkS1hJmaG3+2ZMQI1f5s8U/7gBFIBoaTz6Q33x4HU+DNSvek6uF3ypKhkZmmyIWnmldtIVxtGsUj4d2yjyzcGfP2IVuR/EfIkPMgy2e5TVnxZgKFERXH3FZFYKkqavzaY+ia9ngtqj83Bxw+AWDcG7AX44C6FitVzhQz1zI+1PYb75i1ZpV+ojMz/QDlqlk7RZngL18qYUaK+2Mj+q0JeFn2UE3IOKmn1FD+T0zInynvWmFLNP3xSOOprFR4H6q1tZBqKaL3YX6oz9ssaAyPHr2y5YH4G80mk+vGTN6YjLS35/p5ufj7dRVH/g+lbghDqHZWPqL8v9e2hqX/FLZ9r3qvADUbSilJfoDFg040UrACay7Y6MN02famPqfnEVlMw3N9Fgsj28WcXwcnrZwHEjVpr5dDBuB8JehfNyCGFrIuobneyYLQRFC+83LHd/AKsMgAnPzsqiTMgo4tv1lSyLmkxH5hsF6Qs4ayRIYIvwmm/i;4:rA1wIVZ+PBuT2I7nMA2pj1hiks4Dmww+4C0zGylIxpSCJ+kQYjrhH46f/6GEDIGO/xjOk05l1X/9C/yHwkvWlIQkEpVvx/Ny0Dl+oLz4FVH6UaZ//iiA5GtUkFiTDhp25iVoiFzbnSZeSRqs5sGOuVsS6fjmuFrpR13KblzuiMdlbe74DjnOXYna8T4edgmtKG5qF2sBrMSikvV84IrFySMeAKPXOFofWwSIZGY5jwZlax1KZyX4mKpV+NBnq/VZniM+pGTWbvDU4y+7IW855acQ3V/1+SzbSafzzpUCJuilDVMEHkFQODFIKpYDOe72
X-Microsoft-Antispam-PRVS: <DM6PR05MB458815AA1772DC209BC50DE9A17E0@DM6PR05MB4588.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR05MB4588;BCL:0;PCL:0;RULEID:;SRVR:DM6PR05MB4588;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(396003)(366004)(346002)(376002)(39380400002)(189003)(199004)(52314003)(51444003)(6486002)(65826007)(36756003)(6916009)(54906003)(6666003)(93886005)(86362001)(31696002)(316002)(64126003)(50466002)(8676002)(58126008)(478600001)(7736002)(97736004)(2906002)(31686004)(305945005)(106356001)(105586002)(551934003)(229853002)(5660300001)(7416002)(476003)(956004)(2616005)(446003)(486006)(11346002)(16526019)(186003)(26005)(386003)(53546011)(6506007)(25786009)(65806001)(59450400001)(6246003)(81166006)(230700001)(81156014)(6116002)(3846002)(68736007)(8936002)(66066001)(53936002)(23676004)(2486003)(52146003)(65956001)(67846002)(4326008)(6512007)(76176011)(47776003)(52116002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4588;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA1TUI0NTg4OzIzOjNKTnlQK2I0VUZwbmRDU1BMdXJoUTJ6UzY1?=
 =?utf-8?B?ME1rYXNrS0hGY0NDMkVWR0RTWklMWHE5SUdHMXhGQUZzWStTQzU3K3NvaXFj?=
 =?utf-8?B?SGFUTHVRVWxoeW9Wb0wvOFBqOVFNekJrUzJhRlE5TCtKQWFXeEVYR0x2NVo4?=
 =?utf-8?B?cE1rK0d1Znc2dGhLN1c2ekV0TjNibkNzQXVvK2hqNnZjQU1HRWc2Ni9hcUJO?=
 =?utf-8?B?TVNWakFiVzgrNHZhMnVPczJRMFVPZDhuRkh4U1M4WnY1S3lHcVYxY2FGdnB0?=
 =?utf-8?B?MkNlRjJPU281aHppdCs1dGQ3bmZtN20rTWVuc094cHNZOVU3a2VMZmUwb2RF?=
 =?utf-8?B?aFNuWkpvZmMvak13bGQ1QmtOa3dVK3ZYckp2aEF5eC9vczRsM0hEYVdqVHpI?=
 =?utf-8?B?QjBYa3NMejNyTkd0ejB5L0tONVg0WHVDNXlGTmZOZWZJM1hWRmY1Nm9PQUJC?=
 =?utf-8?B?K2d6dTNkQWJ3STMvZkM2U2ZZQzQva0F1emZXZ0hJekhoS3VFZVV4YXBWamdn?=
 =?utf-8?B?WU1lNGtHclAyL2NCeVJWbEhNZ0FLWnJkWEM5bzJrTlRQUnIxbytQekpQR29T?=
 =?utf-8?B?N0g1Z2M0bS9NREE5MTF1b3ZMVVVRYmlQNFFOU1FzQzg5aUhSK0xaMUJXaUha?=
 =?utf-8?B?UXkyWUJ0aFZwRHJDT3VHK3FYb2YxMkYzdWRUeFhydGVldFlsNXNyc2tBUjVv?=
 =?utf-8?B?Y1J4ZTdianJqcUVmVWxBSFkybVpIa3NvQW03Rk9TaXhjTEFINkNac3lLRTRz?=
 =?utf-8?B?SWlHaytRd3BIRVZiRHZuaGpJek9XMllOd21DdWY1N09IQkdmK0tZQkFadERz?=
 =?utf-8?B?bDFqWXM1cFl4dERvdEVJVmVFalZKdEMwTjRXOGUwV0IvdFFTTkxEcHFDYmR1?=
 =?utf-8?B?anFCblYxaXBVdHpsRnFYejdGOWVxdllmazBrbXZJUlpwUTdBbUx2NE10NFdO?=
 =?utf-8?B?emxLVnI3U3NvcWxlWGZHR3JVSDR0SW1SN1V2Rm9RL2VLT2xlSm1idU5sT20z?=
 =?utf-8?B?NzJqbTVNY0M2dTEvc0pNaVhKckk4MThiN3FkYW9jR2hrK0VIa24vNWpuU3FL?=
 =?utf-8?B?Wk5jVkJtYU5KeVFPbDF1cXlWUStycWdVb3ZnMFNacXI0NWRwSEZ6R2JCbWRT?=
 =?utf-8?B?dVk5RlFjRDAwcHdUMEg0SStNd2pXWU9nenhzQXR3eGpNSmFlcEpjRVpXZUxS?=
 =?utf-8?B?NThRcnpEZmc3Uml4UUVRTjdVZzhHRTJlMjlobS9mNmRzRFFpL1VoZnJxVERZ?=
 =?utf-8?B?NTBKMFF3MWJQeDZQRWdlSFpTSTl1MStqY1NKUEVCK214SXVPVzIyTXNhalBL?=
 =?utf-8?B?Z01HNWRVaWx3OEhOd3JkVklsUGxJSll2QkJwYlBlUGlBcDNNc3lxNk5vVFVJ?=
 =?utf-8?B?cjBxaFN5TWE5NEE3Y1lYajlaZkVVMHJMZEtWTnV5SmRXY2RoUDc2dk0zTGlo?=
 =?utf-8?B?WkVleWVPZ3A2aURPVUdSMll3aG1SekgwMnFTTnVVdTdGYkM3ZnU4MEI0Mi9W?=
 =?utf-8?B?eFY3OHNFTFJQZHQ3R2Z4YjI2MjNjZWRqQ1U0NHFoSHpTNUJncng3dlBCS0hq?=
 =?utf-8?B?d24xbWtiZ3k0Z3pFcFFydkNtMmsvL3UvV0xTV0pOZmh3Vlo5SGM4dFBKeURt?=
 =?utf-8?B?S1FhQ3JkeDZ1V3Jxa2pyNEo4TGh5aHViZ05JcTVDQm1VUDdOY1p4UWxnZ3Yz?=
 =?utf-8?B?dndteTR6WHZvbVhYWTgxRkNJNFRJcGlXbGVFS01hNGJjMW52QVE1MHd2clFX?=
 =?utf-8?B?Qlpmd21ScldoWkd2TDY5ZWdSQTNZdk9YeHhHNFc5eUhwNGJySWIvNHB3b3hK?=
 =?utf-8?B?SG1kSm45Rkl3dGxEZXJlSHd0ZGk5aXdxZG02ZVVpaUhiUWo3SGdtdEZScjRL?=
 =?utf-8?B?SkxyTDNQWmdvYWVsU2tBSHFmZXFZekpCZzI0NjBLYWN0b1d4dFBmWmJBcEhX?=
 =?utf-8?B?RHY2eVBXc003WkJsNTVUN2E2b1QrNGk2VnpIY2JZYWFKckV0WUFHc3cxcmMr?=
 =?utf-8?B?QUhacmQrclFEMDJPeldTdm9iS2xJL29ZdEJObWJxVTVhTkdBSmlRYURaS1g3?=
 =?utf-8?B?c0pjWGwzWjBQVHVFT3Y5Y0NZdjhLa21aM0UzWlI0ZFB0ZVlwcml0ZStWZGg0?=
 =?utf-8?B?Rk52eFNHY1QrK2xiT2ZwTVlubDB1eXFEVEZidFdRalgzcG9jdTBETmpjZmhM?=
 =?utf-8?B?aGZMUkVDVVdSelJUaUpBb0R2a2p3PT0=?=
X-Microsoft-Antispam-Message-Info: BMWahFdBVcQ8GAzBSa/snDglsKGzdUIqM7OuEOBLLU+sfOGUK0L+WArzupO8MwnbTjTXc8EcqXwBEKV2/k1KVjJjH/gaEhxGuu9uurO6y9MVWJZfF0gsILogWTE3k7V0Wh2W/oo7hvWo3vF3oCVr4QCfQXhrQ9ffkD3aA2TSBgWxR/4ELfhvamWI6yzuanBM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4588;6:j0sikCo1K+gknEMvfy3MCNbecW/sanatB1SElq2/0vbfy1tc27yrma/x8idFlkRN3FOGcOo5SHyJzyik6NjPPoDuVo1TLWhbXx91Z3dyP3/yhuIcERp88+Xsy2+7I5iEbeofk1yZ93U3jn1jTWSD9Y/oO5XzTfIsZ6w58Uf3+RcefOA91Tg8BABeF5SxneISwUsiaEH5ZKNBxKzSdSkXMrHFSKM7ivF/m4DIgzD/b4bdjhkwngWCEta+gWQVC+6sYMr7ciwEbZi1PPrKKwa4XFgAOFXIgP66X30Dx4fnT+ZXH68mhOtbVQF1p3sIMc6XsCzwXIsA9LZmgwkxhzpMZWMS1OiB3F3OxCdRdB1T1XC+Pl7BRwBavmpsjGLhkAazoW+ZO6/byk8rE75Sx/HOs9EVZj+vFQ6t4PkuGhBVDAXHyKtT5ADoTMYVOtlTfVac6GfTyQMySn97me7HD8TTcQ==;5:jsiDXLA95EcOSDebxqIRdCLXeZFBk3SixP5htJHXnEtCA4tfcNvZWsvne+sOBTmwYxKDwv9ea1B+xHO24OyxwqPoeg5F8rqmHSyIYsFrGlcjkkja8GBB49i3ItkQRFFfVk8KgZobybTkRE0q757N65xO+qbpPzcp0fMxGR+RujQ=;24:d1COE2XHduQZdzYq1qp2PoCcPaQEo3SIqalVUmLk+N0mi4HumBaHA6jbH2sy7mIw4LyzVwzazPv0NVvF3/0ulhtjaXYOzmHldCrrfpoXoNU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4588;7:Ynx67LcoaBYtI0rFtoDbgWQQ2JmMQrUYKnQZ01W8oMqmo1mnzN8qav/kCRe0eNtdGxCl3GYPqo3Vk7HPxp5SsEQkeJZDVf06IhpjkEkbUy22be/wc/L6+iZkKHtvL5mQqhKnAnavF9MY40ezVLJKRgy4w3THpjV74IAHKFXDXM7yyBF3gS1auN8/xmjoU+6LenxoOKWO7UX92VQ07aFc8TgUUDKJbxxLctv1nmn5bdw7YABLfgnY91nKwu+3PbQk;20:EG8QSe64fuXsc2Zx1H9RES0cUJ1cC26wDKGg805f1Q8hFeKsPF2/HUf5MpW+guuLk8XzvQj04uZCiC0sVSk4OFlxd0RpWr9y3xlUQdLRnda4gij5Q5LVMIdhi83bhuqa4VrFf53aH8CaiIICBLBXVx5DtLwXy67a9rRj6SSVLPc=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 14:05:56.3050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eeb0cea-77d7-46e3-2ef3-08d5d136ca76
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4588
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 03:10 PM, Peter Zijlstra wrote:
> On Wed, Jun 13, 2018 at 12:40:29PM +0200, Thomas Hellstrom wrote:
>> On 06/13/2018 11:50 AM, Peter Zijlstra wrote:
>>>> +
>>>> +	lockdep_assert_held(&lock->wait_lock);
>>>> +
>>>> +	if (owner && hold_ctx && __ww_ctx_stamp_after(hold_ctx, ww_ctx) &&
>>>> +	    ww_ctx->acquired > 0) {
>>>> +		WRITE_ONCE(hold_ctx->wounded, true);
>>>> +		if (owner != current) {
>>>> +			/*
>>>> +			 * wake_up_process() inserts a write memory barrier to
>>> It does no such thing. But yes, it does ensure the wakee sees all prior
>>> stores IFF the wakeup happened.
>>>
>>>> +			 * make sure owner sees it is wounded before
>>>> +			 * TASK_RUNNING in case it's sleeping on another
>>>> +			 * ww_mutex. Note that owner points to a valid
>>>> +			 * task_struct as long as we hold the wait_lock.
>>>> +			 */
>>> What exactly are you trying to say here ?
>>>
>>> I'm thinking this is the pairing barrier to the smp_mb() below, with
>>> your list_empty() thing? Might make sense to write a single coherent
>>> comment and refer to the other location.
>> So what I'm trying to say here is that wake_up_process() ensures that the
>> owner, if in !TASK_RUNNING, sees the write to hold_ctx->wounded before the
>> transition to TASK_RUNNING. This was how I interpreted "woken up" in the
>> wake up process documentation.
> There is documentation!? :-) Aaah, you mean that kerneldoc comment with
> wake_up_process() ? Yeah, that needs fixing. /me puts on endless todo
> list.
>
> Anyway, wakeup providing that ordering isn't something that needs a
> comment of that size; and I think the only comment here is that we care
> about the ordering and a reference to the site(s) that pairs with it.
>
> Maybe something like:
>
> 	/*
> 	 * __ww_mutex_lock_check_stamp() will observe our wounded store.
> 	 */

Yes.

Actually, I just found the set_current_state() kerneldoc which explains 
the built-in barrier pairing with wake_up_xxx. Perhaps I also should 
mention that as well. Looks like the use WRITE_ONCE() and READ_ONCE() 
can be dropped as well.

>>>> -	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
>>>> +	if (likely(list_empty(&lock->base.wait_list)))
>>>>    		return;
>>>>    	/*
>>>> @@ -653,6 +695,17 @@ __ww_mutex_lock_check_stamp(struct mutex *lock, struct mutex_waiter *waiter,
>>>>    	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
>>>>    	struct mutex_waiter *cur;
>>>> +	/*
>>>> +	 * If we miss a wounded == true here, we will have a pending
>>> Explain how we can miss that.
>> This is actually the pairing location of the wake_up_process() comment /
>> code discussed above. Here we should have !TASK_RUNNING, and let's say
>> ctx->wounded is set by another process immediately after we've read it (we
>> "miss" it). At that point there must be a pending wake-up-process() for us
>> and we'll pick up the set value of wounded on the next iteration after
>> returning from schedule().
> Right, so that's when the above wakeup isn't the one waking us.
>
>
>>> I can't say I'm a fan. I'm already cursing the ww_mutex stuff every time
>>> I have to look at it, and you just made it worse spagethi.
>> Well, I can't speak for the current ww implementation except I didn't think
>> it was too hard to understand for a first time reader.
>>
>> Admittedly the Wound-Wait path makes it worse since it's a preemptive
>> algorithm and we need to touch other processes a acquire contexts and worry
>> about ordering.
>>
>> So, assuming your review comments are fixed up, is that a solid NAK or do
>> you have any suggestion that would make you more comfortable with the code?
>> like splitting out ww-stuff to a separate file?
> Nah, not a NAK, but we should look at whan can be done to improve code.
> Maybe add a few more comments that explain why. Part of the problem with
> ww_mutex is always that I forget exactly how they work and mutex.c
> doesn't have much useful comments in (most of those are in ww_mutex.h
> and I always forget to look there).

Understood.

>
> Also; I'm not at all sure about the exact difference between what we
> have and what you propose. I did read the documentation part (I really
> should not have to) but it just doesn't jive.
>
> I suspect you're using preemption entirely different from what we
> usually call a preemption.

I think that perhaps requires a good understanding of the difference of 
the algorithms in question before looking at the implementation. I put a 
short explanation and some URLs to CS websites describing the two 
algorithms and their pros and cons in the patch series introductory 
message. I'll forward that.

In short, with Wait-Die (before the patch) it's the process _taking_ the 
contended lock that backs off if necessary. No preemption required. With 
Wound-Wait, it's the process _holding_ the contended lock that gets 
wounded (preempted), and it needs to back off at its own discretion but 
no later than when it's going to sleep on another ww mutex. That point 
is where we intercept the preemption request. We're preempting the 
transaction rather than the process.


>
>
> Also, __ww_ctx_stamp_after() is crap; did we want to write:
>
> 	return (signed long)(a->stamp - b->stamp) > 0;
>
> or something?
>
>
Hmm. Yes it indeed looks odd. Seems like the above code should do the trick.

/Thomas


