Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC319C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8167322B4B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MStHnmfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8167322B4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeGFXv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:51:28 -0400
Received: from mail-by2nam03on0048.outbound.protection.outlook.com ([104.47.42.48]:45108
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753993AbeGFXvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByCnMmjhQ5KI0sk0e8DSK9BLvt/Q+DvdQzuMOdyBpwM=;
 b=MStHnmfjm7kmgoK0BRmYPbhUF2CGtfTCxfKkZmixiTOZ6YLrSceUUNjqupyYIEj4XdNqNnb61apBJZdwOWJwq3/Joxqr2SmvH6BkE43+7FR5N+h8AqUCjOGhPOOry+GEnPW/NSTSuvbhx9FPvQ3ujJzweXMe1bnD7GIPF9tPpKU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from Brijeshs-MacBook-Pro.local (165.204.10.251) by
 DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Fri, 6 Jul 2018 23:51:20 +0000
Cc:     brijesh.singh@amd.com, Radim Krcmar <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        x86@kernel.org, kvm@vger.kernel.org,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [patch 0/7] x86/kvmclock: Remove memblock dependency and further
 cleanups
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>
References: <20180706161307.733337643@linutronix.de>
 <f4071613-e151-90ff-7298-1ebc6e94c152@redhat.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <faa8df8c-f658-7fca-886d-ae741e41f4a8@amd.com>
Date:   Fri, 6 Jul 2018 18:51:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f4071613-e151-90ff-7298-1ebc6e94c152@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.10.251]
X-ClientProxiedBy: BN4PR10CA0012.namprd10.prod.outlook.com (2603:10b6:403::22)
 To DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc214f1e-8950-486d-2087-08d5e39b60ef
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;3:vyTpIcC8QawH0DgYHb/kf1gDuuQ1HssHvaVBLjYvIcmNuoApIf9TmIUMxz2+Ho0tE4nZjWcQQM7gtEd3GC1R+S0bmMJMT0E1RyJ25zA9Fp8vjDeG1pI3KfU5gME5wojku1jPa1Ol9pkNDFxQJxNpI/Ceid7WbwMWUmrybPtGfWY/4KHOMSPOe5IaewDdUV6ITqIAyvX2tbE5libBaHnP5M/20qFNXcFKD6IfmIrLgrl6VZsUeQM6yyX+uxf3O2Qj;25:FWREYN9Xn00wjEOhjBYd6qf6huBIBFKvBJF2sO9r96+tkDr5Jw/5osQw0NxcxHRJIPZwD+OuIK/+2efzPppjLxn2J5vRbSFuUgy2igxJDNQtY3kJFoqSWb0E5hWaoLg0QnhKraqWc0/ODJTgACf9xem/OigFKn7kTKWKeDD8nXBF8rYuDg61Q33pSGbc1/5VKku8AEJWPZrmnULfL6Xp3y1LSeBO4YqG2M5IwwDya8Nzl3n1rHvAMhVpiaNRzsx2J9LDMPp44MyiPX+bLbJj0d41pYjkJB3KtC8ufpUCfFxj3zOlVnHsuaGObrQllqQN4I4pyOJnEqFSw4neAfMUOg==;31:vHXEfvqnk7vvrGu2jNOY7RbDTEa6oAT7i4a1hh3uKzSL3aMrzVWj8hJNm5Sxp4EXtOlA0Y+1PN8BFiPfPcyGgslE8UycVeHWgd83ZLF9kpz+CHz7TTEpFlbxho1Fi2kbRL9f8ADOVZ8JDCzVjM8WOpmfXhWR7eoh+FoaaQLBFUKZLPPItceDrrfvCCB4e1RbV0+wYdvU66weTFubzQydyN4RRyEgKVSJVKjipGzY374=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:Yt6egXQNBx9iX0bJSmq8SieTCE8OgfI9JBdUHn5xHZXmy+0vTZIOL0qRWfnb22W29O+sFMIkF4i1EgSQ1iFYQnmvp+0q6QpD4blRKqoVx7qA/OHOwFpEjFi7HyFjV0eouhRj5XWZ8jW18zL2AfUKvg8tXj2+yo8A/auW6QEURzZw/6nplY+Xcpi3H2SMLgEJYNLqkMaEh1Fmub8T9FCSyWIxfZ5/ZWipTqTqSBOK4nOfG2j/dtJvajMySMcRwJNk5Fy41elF4nDU2l5JVo/nMFMMwiVJguEO7v+zaVcy1IqU0o8yWDmxLsiCmWwW+XYWGjk/I5dmMP3Pml+6V1oZ/CSQIzUyhvI527QzgQbR/ncI1cKd7r8yXKxkjXP2kCbC4JT2dqvnDqhhEjJEIcaG1BanKE6QiYGCNJ0/5DvAozxZqvrOQPJxv6o7xEdL08CYjn+KgimmBf1d4rPCcRHfGQDVO0KrnvJY3B/Z9bFNrxbhNaKxIUZFHpm4xQZFBbEX;4:Gk1xRn0B0n/Ejpy7cLiOsoKQzqFuosNZJAZE+iATh2JE7gJAgxgTf87XgS1BrKIeoaJUfMI/lxwLgKZj19Mx80IMhQHHvqBI2Wuqgh3z+oLom10y7WrxPPyo9hDcYvY92J2pQeE4UGxxfmxN+E8TtPZIOUY74pMK+8e86trHXO9f+XvozUuCMp5Rm+rd3F5LxORMM+w/fHiopiqnOWY9MO35t9O7KUljCwQKUyFkKquJUVlqO7dsL4zpPSNVYlwda8HzrkWPT2eWZ1t/OOombg==
X-Microsoft-Antispam-PRVS: <DM6PR12MB26820791A0EF978E8ED76369E5470@DM6PR12MB2682.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231291)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR12MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2682;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(16526019)(31686004)(65956001)(66066001)(4326008)(305945005)(64126003)(229853002)(7736002)(6486002)(106356001)(53936002)(65806001)(97736004)(6246003)(25786009)(26005)(58126008)(486006)(316002)(476003)(2616005)(6506007)(110136005)(31696002)(6512007)(11346002)(386003)(105586002)(86362001)(446003)(53546011)(52146003)(6116002)(76176011)(956004)(54906003)(44832011)(50466002)(2486003)(52116002)(14444005)(478600001)(68736007)(47776003)(3846002)(36756003)(6666003)(65826007)(81156014)(8936002)(5660300001)(7416002)(2870700001)(2906002)(81166006)(8676002)(23676004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2682;H:Brijeshs-MacBook-Pro.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgyOzIzOmZ6STBSVjFucHJQczJnRmxvbkFRZ0ExM0hv?=
 =?utf-8?B?YU9VMklHWEdEUDU5TVM0cDI5ZzBrK3FNbHQxOUEzTlRMRmhNclFZd0ZrbC9u?=
 =?utf-8?B?NFZYUjg2WndsVXNSL0hNUS9Nc1BYVCtQME1jK3hIeVBLdkR4WUdwZXJGalQx?=
 =?utf-8?B?bzY4OEhHNm5yOFd4bTVMY1VtV0V4SUw0OUZaK2xhaDQyQ0sza3VtL0RxYjBz?=
 =?utf-8?B?VW5DMkc4QW12cDJrK3Y4anF2TXhObWNMSFFLK2pXeDFUWmJtZ1EwTCtKbzRT?=
 =?utf-8?B?Qi9DZnFNRnl2VVlTc0tHazlRU1VVYTgzQ21HUDJUcDJRRzRnSGh2elYvUGhL?=
 =?utf-8?B?TlkyUjBnY1dZVWlqdGNaMFBHd29Xb3lNNWlEYm9jRk9SYlUyQ3RJT21UVFFH?=
 =?utf-8?B?dDY2OElZcVlsc0U5VlNWVUVZVlNvV29ndlNXajA3U2pibi9pQVJnQXNPN1VW?=
 =?utf-8?B?MUpRU3pkQmlRY3gxZWZ0OExkMmtBMkR2TlBIZGVjVzZzdVh5ZmErU1p2RmZL?=
 =?utf-8?B?NnRRYzdhKzFjc1FWRjQyV085S0ZscjFHYXpSaVB1TnRld3F6eFhUYU5nRVpx?=
 =?utf-8?B?WlpuUzVGZHR2U3NIVmFhWHhaamtUVnBDRlhhcTU2MGVOWUZGVHNYbzFVd1Uy?=
 =?utf-8?B?ZHpsNC9EUld5YXgzMHZqUWx2STNUTTdDNTUwN2RuVHU2cHpyY2t2UGtVUGpN?=
 =?utf-8?B?Zi9Ia2pMTTVlWWxaMnRJSmFVNzF3RXhvRENKOVM3ZkoydlJOaTJ6L1ZwMmJZ?=
 =?utf-8?B?NldNY0J5ZGNrWVp0SE9rMXNjbnlabXRyTXBlL0JnL052ZVRqVzhkQ09VbmdC?=
 =?utf-8?B?ZVp5b0lHSGxhZ2dlYTd6a01yNnRmbnFyd2N0bjYrZmhiWmlua3lmMW9Yck9B?=
 =?utf-8?B?VFBwZEFLRmx2aGVPRnl5VzJhREFUa1ZvZURuaFIyZEZRS1V0K2lXUjl1SnRj?=
 =?utf-8?B?S2NteWtleHNzNDVsM1cyYkc3Wmtma1J4bUxCVjdSdjNaOWlrYTVqWnhqN3NE?=
 =?utf-8?B?MVVMNFBjaUt6SlU3Wm9XK3I2UGduaHN3c0dpcjAzejFqNWdJcjM1SHQ3d09J?=
 =?utf-8?B?RlpmbmlGWEYvWjFPVHFwbE1ZQ3FpZ1NpM1Z4dTZ6RUJNcm9jRWhsQ2U1dUpq?=
 =?utf-8?B?VS84bXlaQTVERXNKMnlMd0ErNGFGRm92VHVjYUVpcEMrejRUeks3ZXliTWVh?=
 =?utf-8?B?QWhOemVLOVlSZDdHZXpyYVJ5elcyYW92QUVaWC9BakNVUEhsMTNWVTNJbVMw?=
 =?utf-8?B?NjNRQ2VtOTI2alIyLzhldEVreENrN3V4UC9PY2JSWDBoOEFrSkxia0F6bTB5?=
 =?utf-8?B?OEYwREt6QVgreGw2VG42Wmk2aVh6THh6VkQrcUVKWVQ0ajR3MmpSUDM1OUxO?=
 =?utf-8?B?Z0hZRXpickc1bVo0OHRBNS83bys5YlVTUVNOdFllbFpNM0QrNVhSUlUyY2pj?=
 =?utf-8?B?dTZMR1BlZHBYNWFjZWNlMFNaSDlDNzNyVnFTcVZaTlhQeW1haWV3YjBWZWcr?=
 =?utf-8?B?VForUWp6Mm9IbHNNdk9ubFR6SFNQTW1kd0xyQ0dGYzR4cWxyak1xZ3FoN0h5?=
 =?utf-8?B?eDZJWU5vdXVjOXlNRnFDVzNDVGk5QmFicTY3SWtHM2dKWnFZa2RWN1QxOWFO?=
 =?utf-8?B?bVFrT0YzMnVlWHFMbXQ2cE9ocWVmTGlRV242L0VpempjanQyNUplelM0QUxW?=
 =?utf-8?B?NTNPdWI2RGxXNHZUc0pRaWVVc0J6MEY2Qkw1cC9OMjVjTUFzdkFBN040NzZM?=
 =?utf-8?B?cDZKenIrMmlZWEhNQ0VHVTN2NExPZitnRU13NVRwV2IrajA0cTNRS0dpUjRW?=
 =?utf-8?B?RExtV3lYMnEzSHJFdlZiTlpjc29lbUYzbVZVek8veldQZ05SalVNY3IvMlJl?=
 =?utf-8?B?Yjlab1hxOTlycFdyRWZGTjBiRHpQdVJGMURkTWdwWVRQMTMxQnJnYTZpZnVM?=
 =?utf-8?Q?DU8LMl5BXg/B3xqrY+o6PBPix88S/s=3D?=
X-Microsoft-Antispam-Message-Info: JQJvCJuy59WBQ9ilO2qVbyIo5LTvIY+OpS+Y53vF48DczpDAD+6Ahnoeq4X07B2h3rt14kprMXrErS03+M69jHZ0MyOPyvrd3pFAh4kt9QpK982Bmz/aKm/N+n0XTwVda/q7/NHjcXTBAG4dHRgHORFuhJpDLr2RwJaUjlFVwCy0ckjAp2Y71FHDiO5wh96h6RuE9qGKQXIRd/70nSOzfUGJtPS2OluamYNuwu2JyusPnaibFbVQ9g0abGaHjA4bwgVvcsvH+1rH7ylbM00Ak00HhGAuyHqViDjL1v37Tus09ay6+X/n2GHjnyKhyf8QeX4/s/zFneWw3YoXozmoRRn2sP3zmSw2Y8vrIHeEQBY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;6:h2zqJa75O2uqe7SFVM0RLP9wmqnNUea5GCzdhl6pbdogsgF6MK3JixE3hEDCfN7lF/CuUuEE4xEyzslbWyvA5yo+2s8RfX7OMrenA3u4Cx8mDfMHKKCBUKaEYFEA4rf1mHN71DKEdmqr/3FwmXz5OFiymsVAL2AlkMasUXotNjNv8Lsh8SWBHfCnYLS1OPg7tnpoG2KwFoUs5Oa/auPqgqLBFpv7IgfSgoE48M7tZZXhikbbM98gEFTsR1N+/ROj3XUB6lZcZq47iXXn/eiG8pwSktQL7pbVAz6xd6dSmqhiBGwPaVbZf+5AGHHLLcMKchuAVlvqhHUoU2F+qNfhBLkWeLa518Xdu9NEKI3fRuNALBOy9ls/DCjei9bDWoDsHyfAUQcfcY3StAjawPc9kwqMVP7JTaxIgIs5MfwwLANM6P5ZiP8kzaSkzKQ4Sg5LkINm/0OnJNgoUfYftsNrDw==;5:cQ52N6YZ1jjQq3rqgn6cxPs5sXOQXiplMlrKSyX0bTWc+LV0NPStRel1cD7P5rhU+5j2UXZ160A9By3wL8fN4N6qYsephc1uTQ0XE183lkt8yArXgxu08dbcxeqwuY8RzYegYFQey8zS+mMzoDxDQZDJYa8XdlQWqTa1blQ2mRY=;24:ZmBGp0ZNVQqTmRQLShJOafwWY2/2O2Q4dqSzYz8BYJXVS76cED5PwsJAKDonGW+Bmasatphee0qrsJzhaftQPsDKkKUFqloA/6KMKOYBklM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;7:IsEfB7DpXqAlDis5RNIIcrHeYXzqk9JyjwNg0+AQpwSYJI434EhHDwA1mxjTG+lSpxKOAnGHZj4FQ9sO9DHE4+5UkN1CfHvlvw7cQwQQ+MUDPTLTtYUqwf9dL06F27AnsbmJl5k34UnAdf4QuFojkL25ksmrty9q1TFQPKyJ7S+fCyVszCHxm6Aaa5ZCRft7lTOm6qkBBvfvJgQ/sYbQqsV5bvxuJG8qVF7dsJn3P3CFRp677Vn9zybdNwmNw0SU;20:WVxU8f2Qc+CdcppacIvpoZrQBu0wVeuuvBOTfD5ArPbsQL66TUgEJ5RBxMcIe2+si7JL/aEHp2eIPwydA8hxsga+yqcXngclKVT6y8yWXJZYSsMOWtYqu/X5/+IncJoF71+lz1s5U+L57TroVP5EU9+gZ0Ah96Cppnz+uLG+kBIoYU1mh+tBuEVA+kq+qeWhwTCSouzfnfdlkLjpyHBIMNF1qC7HxhqYSyM48Wj8ZfORejpgVfrD2gDoA6Ax4onc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 23:51:20.3775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc214f1e-8950-486d-2087-08d5e39b60ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding Tom and Boris


On 7/6/18 12:47 PM, Paolo Bonzini wrote:
> On 06/07/2018 18:13, Thomas Gleixner wrote:
>> To allow early utilization of kvmclock it is required to remove the
>> memblock dependency. memblock is currently used to allocate the per
>> cpu data for kvmclock.
>>
>> The first patch replaces the memblock with a static array sized 64bytes *
>> NR_CPUS and was posted by Pavel. That patch allocates everything statically
>> which is a waste when kvmclock is not used.
>>
>> The rest of the series cleans up the code and converts it to per cpu
>> variables but does not put the kvmclock data into the per cpu area as that
>> has an issue vs. mapping the boot cpu data into the VDSO (leaks arbitrary
>> data, unless page sized).
>>
>> The per cpu data consists of pointers to the actual data. For the boot cpu
>> a page sized array is statically allocated which can be mapped into the
>> VDSO. That array is used for initializing the first 64 CPU pointers. If
>> there are more CPUs the pvclock data is allocated during CPU bringup.
>>
>> So this still will have some overhead when kvmclock is not in use, but
>> bringing it down to zero would be a massive trainwreck and even more
>> indirections.
>>
>> Thanks,
>>
>> 	tglx
>>
>> 8<--------------
>>  a/arch/x86/include/asm/kvm_guest.h |    7 
>>  arch/x86/include/asm/kvm_para.h    |    1 
>>  arch/x86/kernel/kvm.c              |   14 -
>>  arch/x86/kernel/kvmclock.c         |  262 ++++++++++++++-----------------------
>>  arch/x86/kernel/setup.c            |    4 
>>  5 files changed, 105 insertions(+), 183 deletions(-)
>>
>>
>>
>>
> Thanks, this is really nice.  With the small changes from my review,
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Hi Paolo and Thomas,


This series breaks SEV guest support. The physical address of both
wall_clock and hv_clock is shared with hypervisor for updates. In case
of SEV the address must be mapped as 'decrypted (i.e C=0)' so that both
guest and HV can access the data correctly. The follow patch should map
the pages as decrypted.


diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 890e9e5..640c796 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -251,6 +251,20 @@ static void kvm_shutdown(void)
        native_machine_shutdown();
 }
 
+static void sev_map_clocks_decrypted(void)
+{
+       if (!sev_active())
+               return;
+
+       /*
+        * wall_clock and hv_clock addresses are shared with hypervisor.
+        * When SEV is enabled, any addresses shared with hypervisor must be
+        * mapped decrypted.
+        */
+       early_set_memory_decrypted((unsigned long) wall_clock,
WALL_CLOCK_SIZE);
+       early_set_memory_decrypted((unsigned long) hv_clock, HV_CLOCK_SIZE);
+}
+
 void __init kvmclock_init(void)
 {
        struct pvclock_vcpu_time_info *vcpu_time;
@@ -269,6 +283,8 @@ void __init kvmclock_init(void)
        wall_clock = (struct pvclock_wall_clock *)wall_clock_mem;
        hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
 
+       sev_map_clocks_decrypted();
+
        if (kvm_register_clock("primary cpu clock")) {
                hv_clock = NULL;
                wall_clock = NULL;


But this patch triggers the below kernel crash.
early_set_memory_decrypted() uses kernel_physical_mapping_init() to
split the large pages and clear the C-bit. It seems this function still
has dependency with memblock.

[    0.000000] Hypervisor detected: KVM
[    0.000000] Kernel panic - not syncing: alloc_low_pages: ran out of
memory
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc3-sev #19
[    0.000000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
0.0.0 02/06/2015
[    0.000000] Call Trace:
[    0.000000]  ? dump_stack+0x5c/0x80
[    0.000000]  ? panic+0xe7/0x247
[    0.000000]  ? alloc_low_pages+0x130/0x130
[    0.000000]  ? kernel_physical_mapping_init+0xe0/0x204
[    0.000000]  ? early_set_memory_enc_dec+0x10f/0x160
[    0.000000]  ? 0xffffffffb1000000
[    0.000000]  ? kvmclock_init+0x83/0x20a
[    0.000000]  ? setup_arch+0x42c/0xce6
[    0.000000]  ? start_kernel+0x67/0x531
[    0.000000]  ? load_ucode_bsp+0x76/0x12e
[    0.000000]  ? secondary_startup_64+0xa5/0xb0
[    0.000000] ---[ end Kernel panic - not syncing: alloc_low_pages: ran
out of memory ]---

- Brijesh

