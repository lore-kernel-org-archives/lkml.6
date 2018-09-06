Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34995C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE0E2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C4xlpZJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE0E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeIFX1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:27:21 -0400
Received: from mail-eopbgr690047.outbound.protection.outlook.com ([40.107.69.47]:42816
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727126AbeIFX1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBjJuldipeV8JWj1lM8TO1eGez7HOiInuvV3dwkhz3E=;
 b=C4xlpZJmJ5r/aqYbnC1bnhTH1Ysv9Cu/CTjTk1Ck+7Ih5ZkocKuRumk8jdwkKHOX7PS9ENq3a7jPaUoED9dHA5D3wUwZ2yF592oy07uEfQzExf+a0hwh63g9HWC15caWHdknix/JywTAwJJ/IzOGFB3Y7fZzXJj4n5eA1fEPLEo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 BN7PR12MB2674.namprd12.prod.outlook.com (2603:10b6:408:29::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 18:50:25 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Sean Christopherson <sean.j.christopherson@intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906140738.GA370@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <9b7ba5a6-5b2d-206d-46f0-32e0dbd2af70@amd.com>
Date:   Thu, 6 Sep 2018 13:50:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906140738.GA370@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0201CA0049.namprd02.prod.outlook.com
 (2603:10b6:803:20::11) To BN7PR12MB2674.namprd12.prod.outlook.com
 (2603:10b6:408:29::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2db63e6f-f272-4edf-b365-08d614299bec
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2674;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2674;3:+Rges36IsPv7xfPrDhugf8Mk9uq/rfRUTRcYStchCDO2UEWOtLdEMtmw0gV4t/6cjBnHw8Z4MhINei6DSjzAlOlqQkkiu0Afdl4o3yEEBZECExLthI/+Jc67cqxMkG7Tqmq6ge9K3/IzPuOaL36H5uLbQqoTk8tKVSWAitmr1eyp7QTCikyMeuCO+uuUoSwpO6nunINSGkoHq7CDRJr5wGrHz7LjmisoGQZ2d9jD0sfBBeEHqhFno8bT77u9In2T;25:VMqRVCnWuG+KiPAD9Uin17bnmV5fMLVO0rymLKeImsaRkcCqXu+WU2cvMt+/rDfcaPceLFfzOvZ0gbKuwmSbacSd1MXEYP5eMgxBtIKzp5qajqs5aP4agEurUERPqssFkMEW2u47sVxyajlQtFfUS0EJeFCnbBKAvxdnlnjT2PuyWZ/s7h6ObTNRUZETLZcfUrYeCe08a8coKmO/Rres+wKSHTbW0lwp2hV2tjRU7Q07rvRsNtoQa86bK30mCjsLLWtU6BMVZ6lEOswepLn+P0kQzlkw5ZlceKoJlcqYN/0+7s1AriWFtlFPIlKAZ96ZZjcDweu1u82cjs5d9wFvQg==;31:Tz8lOu93QUch+N0siFgtJEqieV8TKLtR5oMEYLoPT3D7sESY+LBc4MQwfhQEKUnIBNY58tXhXSsz9l2g0a8uamwyERZiFpGTpaX9C9bgk99enKnbDrr672bI+VZsFc/SimGt8eF1pZdyGdivGUX09X9SnVkBo8ZQpuzN/fo2FBIFoypAjzHO80b3e4y1GVvBtbh9SrceFpmVeLAiHrjFMN5txxmz/hcbuG3lh+TjMjM=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2674:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2674;20:gFHCe5ZX5FrSKeTeJeMH69d9iGeq1tl7Dr28UV3VCTl13o+SrpNl6SOL7Ga4B6Ad/a6kWcj2yKKyaKIDy9FTBYiODrI20DBGwlGid4MHGOJysBpkolRWJy5/EG3X38M/Wc6noBQiS1OkPiKLZfD03MWNZORVHM1uIiU/mAe8lK2s6YHi0oMJxwI6fL9CYujTeF35KUVoFP1Cl2K3Et3q9u/29R5ediMRXPh+iBgb3tu/AsYAHvO8lIvEtpuPKYFGpJkPeNYq/oLcHObvwatzopWAXj5UrT85OvREeU207QfvIKAyfbPoGbrBiyjKKxNi7eEObHVHfqg42U7iXaBRnp1gfsZSWDHk65zMPO0L2j0FtnQ+0nayLHDPuLy9qTrj7f9lvk2lahn4euSFUGwKnp8TVIpOcf9E5f0OOFzbVn4bRIrUMEXtJYrQtD0qxCATA4tl2L17+MYFh6MsvrDyF50RofUJEKn201N+HQOp2X8eu2vgY6DuqPvZp9FItX+6;4:r7ClajWXScfSaClISxjQuA7N1YPzoC1OzNytrLFHMQOquL21L0+8V7c41Yjw1IwyldyhExBFQJRj+XMga8/pA5emRBW1YAFiXEPNT0aTT+/HH0phja7a2epUHHhbOfbc+yJfwTh5HH6ZrJ3O5p2WD+Yh+GIpNfZwilW0cSpVGq34H3KwGDxkG/7RbENzl0D5QDADoKpIKsvHde837kk+KBebesekCguuaPIt3k3NiMtA5lTk/mHlbXJNovkNgXPZrdkFFP4R1ev4qJStsr+VtQ==
X-Microsoft-Antispam-PRVS: <BN7PR12MB2674F2F5D5D0DD1B6C9A6DE0E5010@BN7PR12MB2674.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:BN7PR12MB2674;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2674;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(478600001)(230700001)(7736002)(8936002)(81166006)(44832011)(64126003)(3846002)(50466002)(6116002)(68736007)(36756003)(486006)(5660300001)(81156014)(8676002)(86362001)(11346002)(106356001)(105586002)(476003)(2616005)(58126008)(956004)(31696002)(65826007)(316002)(6916009)(305945005)(31686004)(97736004)(446003)(16576012)(66066001)(65806001)(6486002)(77096007)(186003)(65956001)(229853002)(53936002)(6246003)(53546011)(6666003)(54906003)(47776003)(386003)(23676004)(2486003)(52146003)(76176011)(26005)(52116002)(25786009)(67846002)(2906002)(4326008)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2674;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjc0OzIzOjNBaFcwZHV4UjFKU0RCU2RHb1B2QWhtb0M1?=
 =?utf-8?B?THVwSFRCZm0rL09meVI4RXQxWGlmK0pYUmlNMjVDVm5GY2l4dlFuOFJBNVNk?=
 =?utf-8?B?OU5XUzJjV1VySGp0eUVNaTFDekh5MHpjK3ByaFpmeVNGVjJzbEN6V3AzMzgv?=
 =?utf-8?B?azIxS1dqQWNQNXB3N1dtSHNoak1nbnpxQnVmdDFZQlFVRWQwZmhPK255YjFo?=
 =?utf-8?B?MVBRakZtR0wyTWRycVd4dDNWbWNoWUFNR1UrRGpnQ2NvZm5waDlkNXJYeDZh?=
 =?utf-8?B?QlhpZFc4emdUYWlkR092cXZFSnVrcjBsajdxb3ptWk5uUTRyaG9LUXBOYkgw?=
 =?utf-8?B?N21JdjFzOGFqMldXUTJWTW9TWEYzdDlxQ0h2bDV5Vk9SQ3NMdWZtMjJsZ1dx?=
 =?utf-8?B?Q2hVbjhrdUtuSDRWNUtscHkyTG5laVpoRW1zOEZQQnVmTnNQc1QwekprQlZK?=
 =?utf-8?B?anR3TmFBaTYrSC95NnBhZGdGKzAra2ZaYVpFVXd6MmxRZE1oTGFFS1Y5cGRm?=
 =?utf-8?B?bjFrOTg3cHdzZS9heFhVZXIvdGJhRVRaUnY0RWdzQTRSSWl3dXd4OVNzbCta?=
 =?utf-8?B?Z3dNQ1dudWFxYWwrYWZTcTZtWWZPUGtvREU4d2JlMjRweWIzZFgvblY0dm0y?=
 =?utf-8?B?Z0MvM3kwOUpwdEUvb0JJcEdjY0wxd3JrVys3eGgzN0huWjZIOUsvZzlIeWFV?=
 =?utf-8?B?TnNpZUM1N01iN0RxUEZ3eTYrSWZ4TlFCektLNXdqOEQ0Mm40MkZHK2dyVG1t?=
 =?utf-8?B?UlBwVU5xN1hWWjNQOXVsTTVBV0hrWlBQcFArYVhRU2t2OXg3aDZqRzlvNG1z?=
 =?utf-8?B?clBrVy91SE9YOEdseU02dDNXclYwRndkSGFNb3Z2WXRReEZzYzdNUEsvQzh4?=
 =?utf-8?B?TUovOGE4OTVpQjlOYVY4YUNZUHBFY05IT3BNd1dwRFRSV3QvS2dUQUV4TWNu?=
 =?utf-8?B?ek9YSEp1YWIyOFV6UUZkYmVTVHJ0R280T2hiSWIvQ3JtaXgwR3FsSytHb3p5?=
 =?utf-8?B?SlhoSjI0NkFORXAwR1RpOXZIcXlSS0RSVDdBbUNDNTJUbis0OG50SG9LcEtE?=
 =?utf-8?B?d0NYa3BpNEVWLzVxUjg1RHZqUGVJaGNWT1hyVXUwNndDWjNsTjY2dEloTmZa?=
 =?utf-8?B?bjAzNTh1ZW5wbTJNbGhGSmdUcUQzY0EwbThTdDBWbVU4ZW40V2c2MElkNW91?=
 =?utf-8?B?RjBVaGF0TGk4eU5lbTJsdnhRY1ZVVFVvVkZDdjZyd0tBRE1WT1BEWC92VGRv?=
 =?utf-8?B?Z3ZTWXQzMTRCN0J0azhEODlGTWZkbVNaWC9aWlp1cmtEOExXaXpiVTcvcnBo?=
 =?utf-8?B?dmc2aUpsLy9FTUgrUjN2c1o4U2pacmNHM0tINkFRS2ZWTHU2UEdIQk54YnB1?=
 =?utf-8?B?ZENBMHdvKzBsRkhtRjlOTFBpODhtOEFaeTFZWWZCSm5XM2hEVkowSWJlaytF?=
 =?utf-8?B?cGpZYTVvQUlMMWJjdzk0SmxkQWZsYzFhdURDNFVEMDA0QnBrSlBXOWtQajdM?=
 =?utf-8?B?QzBTSnNQT0R1blJBY0dsQktTL1lHTzF5TXk0MGNqRUNSbndOOWwwcFFRekZX?=
 =?utf-8?B?eWtYNW1lRFdmMHRoWUMwZmtNWWpndmpNZDBVSEl5M3VQQmt0Y3k3Wnp0ME9R?=
 =?utf-8?B?YU52S1UxdlZhZ2hnbk5NTkRwRjRId3lwTkh4VWtHVmFya2tEcCtscnB1dlJY?=
 =?utf-8?B?SzQzVjZhQm44K0JaaVFBdEFFT1MvRkg2dDdmWDJuTWVtS1lCWW9LL3ZQMlRh?=
 =?utf-8?B?TXcxOUQzc2hkN05QTXRDcDNFOWR1SFJuTXVJbXRqbnJ6TTRvb3llcE41NGVD?=
 =?utf-8?B?Q3BFN0Y2cEM3YUw0Q053U29rM3pHaFo0Z25CZVgxTEUzVS9TNHErR0tGWGNw?=
 =?utf-8?B?TEVrSlA2OWpyQnRkQjVXc2p5WndVUnl1alpRekxuZnVoWGg3clNUWG5rZzZl?=
 =?utf-8?B?ZGtQd01WNjRBZVFmS1RGK3FvWHBtZk1oNDVhcW40R2VCM3FFVWw2TVY1THJX?=
 =?utf-8?Q?k3rRFF?=
X-Microsoft-Antispam-Message-Info: f3qblGgHUU2ZdogrlCRRXDv62obt0cVHRqs//lgh/R6jP/pxmO/x2ZYeOo1a8i0v2TLoq+C1RnagW4ZpaQd9mvbnGhXplPJwwu9JyYenLlod5vcYRldIV68jpYnl4suqAxqbjzFLNs4S6pJ3s1njG58B5NcHIJ1smO+dCdwJKtRVtVRjmVD106xwlOItp5suEeSK8f3uImkRapmGoSNTrcX5wIxWg8OzotVR1tnvxjyzkQlfNK+acFKMT2iVnbQS7HRXGDty9DVvZ3B9rMRwPW5/7UV/H5TkWHOw0YmcamDavy9FBk4fsLMF+v/UWjn2c6S33LCEGJAq+VgEtYmm6h9mRvBEt5dZIMJsY10xoQs=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2674;6:KTy58/sQ+oeoHQ6PqwlALPUrElTxKiJMO1E38MwfstrHCRIXwxGVOmrV+P36XKUpuZLObGWLdyFqRh/z7Vu/A3TNuvPvP6CWFmqtRFyaCbX7+HpCGrKKbg/Lpu+O1gZvl1ZqX69ggjF/R61wI4tcKFO3EUD4+M5o68qd3rmwso3rEVJZI/RcrvETq1RfXEEwO9fxZpKiwzRdaOXhbf+gohCu/itNDqXhZ0UqiAPZQKAtE2KApB2ziy2WybPuGA24nuW/pxm/vUlOnW3HIKUXnAdnA8aUIdTDwRsYevqxRP/OYx+/YzdGXL+/visE/a7MTHJf9vCkIWe8ciYBPekhusFm7AG6dHZM/0d3WD1ysHkltCXTp05FbSFuiZXZw0nxUnfOoFT14HPEkmYPOeVBMmeCjCo0pF5h9FyZyRdTQa7pYsDFz0q9ZLVhA9Z3UeoerbgFJAy6MSGJZGnp6TjfoA==;5:pqhhrOJ5A8wsku/ayDvRnJTm3uM5o2vKsweThrmeBdAeV2LvHgpLtYcXSOzynkseLSrdjuQwLKZnhox5b0RP/pXmJCWUXliFZ/80ttRZ72E+N28Cpj5VcigyiEforv24yhD4mvBLTt8/3N8GcLmbvyAL49RLaKpClWenULkNvVk=;7:JzUxPM/8kxJDnOLVgyKziKGTvUB8QcOjXTz7A9Le67RkFcx9SstNiZgRp9G6DwYC24QIPwFCnwG2MmzmDLZsFijIuMIi+6A1f/iAsdTCXqppTmwn8CvAF4zW/Raw50oO62Vh+jST8rj8CWrQp7lwXUdxNo+mVHvbYjSznVhP44wgaz6nIRXkUthvjWeJ0b8R8l2UCoPytFv+dT2upZY3GIhOVHM9NG0AB4A1dPYbJWYujt5wsk+U0Q3QCYn33vZC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2674;20:FCI0NT+FU+gcpszD6Wr0OnoxIyiZt/OGsYZunQrfMCDCkV3ngoFC3I+m+Jl3NuvUtR2EQDVBlA+xz2oxP1xxvpJYc7ae06AgCasqnSDv+AvJEB9e/8fU3Pc0Y788svIAvoUGqxhSB4T37h1FImnBv9YIITFQpEr/u64Bw5JZ6Fa9Kswi60tcRIbSXXG0Buyvrbh4vWWwR58BkCUSza+D6EN15vdpZX6tGdpTVodfiWuiElVU+wPDgq6Lipg51ETE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 18:50:25.4824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db63e6f-f272-4edf-b365-08d614299bec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2018 09:07 AM, Sean Christopherson wrote:
...

>> +
>> +/* This should cover upto 512 VCPUS (first 64 are covered by hv_clock_boot[]). */
>> +#define HVC_DECRYPTED_ARRAY_SIZE \
>> +	((PAGE_SIZE * 7)  / sizeof(struct pvclock_vsyscall_time_info))
> 
> I think we can define the size relative to NR_CPUS rather than picking
> an arbitrary number of pages, maybe with a BUILD_BUG_ON to make sure
> the total size won't require a second 2mb page for __decrpyted.
> 
> #define HVC_DECRYPTED_ARRAY_SIZE  \
> 	PAGE_ALIGN((NR_CPUS - HVC_BOOT_ARRAY_SIZE) * \
> 		   sizeof(struct pvclock_vsyscall_time_info))
> 

Sure works for me.

>> +static struct pvclock_vsyscall_time_info
>> +			hv_clock_dec[HVC_DECRYPTED_ARRAY_SIZE] __decrypted_hvclock;
>> +
>>   static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
>>   {
>>   	return &this_cpu_read(hv_clock_per_cpu)->pvti;
>> @@ -267,10 +274,19 @@ static int kvmclock_setup_percpu(unsigned int cpu)
>>   		return 0;
>>   
>>   	/* Use the static page for the first CPUs, allocate otherwise */
>> -	if (cpu < HVC_BOOT_ARRAY_SIZE)
>> +	if (cpu < HVC_BOOT_ARRAY_SIZE) {
>>   		p = &hv_clock_boot[cpu];
>> -	else
>> -		p = kzalloc(sizeof(*p), GFP_KERNEL);
>> +	} else {
>> +		/*
>> +		 * When SEV is active, use the static pages from
>> +		 * .data..decrypted_hvclock section. The pages are already
>> +		 * mapped with C=0.
>> +		 */
>> +		if (sev_active())
>> +			p = &hv_clock_dec[cpu - HVC_BOOT_ARRAY_SIZE];
>> +		else
>> +			p = kzalloc(sizeof(*p), GFP_KERNEL);
>> +	}
> 
> Personal preference, but I think an if-elif-else with a single block
> comment would be easier to read.


I can do with that. thanks for your feedback.


> 
> 	/*
> 	 * Blah blah blah
> 	 */
> 	if (cpu < HVC_BOOT_ARRAY_SIZE)
> 		p = &hv_clock_boot[cpu];
> 	else if (sev_active())
> 		p = &hv_clock_dec[cpu - HVC_BOOT_ARRAY_SIZE];
> 	else
> 		p = kzalloc(sizeof(*p), GFP_KERNEL);
> 
