Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A311C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA27020833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TPnydy1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA27020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeIJUEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:04:48 -0400
Received: from mail-by2nam01on0062.outbound.protection.outlook.com ([104.47.34.62]:56222
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727940AbeIJUEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFjOvsWvUSV3eK44CXtsUdpCl83nwhKYAS+BMS2Jdq0=;
 b=TPnydy1lWhQ2L9Qilw3/ntj8JLC1NpvmAsLeDat88uYxTNkzzK71E5CxrXPsdVlxvCkXsxFWdD8sMwBxPoc2uhaEqHV1qBF5R125IBtQmBVWErEl+MAO4fPzrg/azIN7KmtOnbVrfUnpG4wUDo4ZLZqePI8NqvNqauXpFt5YrRY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Mon, 10 Sep 2018 15:10:12 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
 <20180910122727.GE21815@zn.tnic>
 <026d5ca5-7b77-de6c-477e-ff39f0291ac0@amd.com>
 <1536586152.11460.40.camel@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <097eb5f5-2cd9-8b08-32c5-d90c8e0cbb6d@amd.com>
Date:   Mon, 10 Sep 2018 10:10:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536586152.11460.40.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:805:2a::27) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 057cfb55-8cd5-4785-0772-08d6172f8240
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;3:e0jKnSu2YhmPpukZs7FOpvu2WmktnhSmU/SIdFfBXiMUqLbJ2qFFqVF1oYDA0FkeBQBpvPxqlRAZzFdaIVrw39GEKdunH6/3hn+RB8KBS5T/ZdF0E11fpz8NslLMIHgVdAhPEqARvt4K9/MgXhlsc38SC0RWEBkvwZ40s9zhIIcZCcD13UtEga87HpMIo+QZEK41rTApk0z9nah/tYPpOCsZ5rc2gXmj9cnE1PG73SOYu3z85217zeEDsDzPTW4R;25:oNBYuSAdIr3sCksihIgtyUs7+BkQqPIrbyZFBd6aV3RrZ4pyQDT2X7dw+wfrU7Kjy+smDj1/3PyZC4RcP0bfh/4PAjZWA2i/sds0E+vidVX/XJzMw32MEtcxNcG3Il2fdYGoB/RTV5S7VyiTg1DTrGeno9j2BVKRUzQxxkLcqlLfJvQ8oUeMJtIDn1KcjyWQ76UCKih2LYK9oGXAQY6i8CSlNDHNBL8XXxr43NF0T/jZDAy0lk2bfHbYTuJoRyl2G9vMJyv1AHUV69+kmg+v3HhfClB6Cc9OtLd6hQXXVG2VT567hzwJTcd70MVyGLCtJ581fuhvGEKc9+UujnIZUA==;31:4KCLSm+ZI/QZQW7gVEwKdiQ1hTCP3qszXaLa2DvlJ3D71/mqW4SXWl+Ixu7I4s/8CtgVaipVRHepf8xpKWk93hN+QcNCWXDA/laj9jP6kOI8QprOIZ/6QXOeabUmRsYNdWsh8N9o4ozMuBqScg4rbaRdNxFuoE4pfoF1rw/2MJDZnntnbYbS/qSEplqZUAAL3/CgV5D21YMCU9yvAlbb0ovxleCbVX6NMd5ZCIaWJLw=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:bKQCnO2qZBPsoT0yTK7ZKdCPW42L7ynchGFallneegzxQhR1VmtNfCRK84Z1rjykLwpfPHdB6D/IWe0E5BJQzgc09f7M+74UPfLaM67b26w7CbupDkXtRR09ZVnRnPPWks7CArL5FwB9AiIAAuvCQ96wbkkkZqkhvat9+7yNOa/ZLJTgTde2TJx7PFboKc+PSvTRFtMOHJpK3j7o+ynO+M4r8u5ryaYtqj89jxMKTmjAb6nknXIA3YeO0XmnOGhNzc7tsheNY+C7kAipM/KcWCW+gptj9KG6SACixQOkxuQtkR9E/zZHM5N2GPK2MHgTh1uJXJNdaltLJ6Ki2VBq7t86/fhxFXyr5Ya+vbZa0lXOPcDHNScw6Mfx/14PQ8WNCZmmu+VBbGf3xcHY+kbmNOM0/3PJv3/b/Lj3/9kT80uAr1cSy3aql1SY0DWQ4Q5RfUGA2QyyyEw6RYLvrsCaQFE/qT31PmvX/yScLYUEFqFOPkA2sBzFDzOYCyO0jVWo;4:jmiJzPlr+u+hVXZddBrimwkFxTJ+fKfxTMSDuiaX4fJ+rDMXwV0hD4IRZgxZt5PF3Gsguto/9QZWHM7bRFkwnJJh3b2LwFVQZeIz7kDNc6sEa7CZuiRBq9xK+IE19llWktk47rIU8P67uv9A+zLuGdp2vALhisf+ARQ0RtSA4UwkqPNFnqXuJu/k3SdwgAHgTpIsDzFFAkn9z30yeszlheEWA2H0ZPC8pJJwoMgejaL0doMavrRE/7ASUHkYmz0JdsokoMQbN2E8zW51j+pxYQ==
X-Microsoft-Antispam-PRVS: <DM6PR12MB268206BAE179B5218251171BE5050@DM6PR12MB2682.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DM6PR12MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2682;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(25786009)(446003)(81156014)(81166006)(956004)(8936002)(2616005)(476003)(7736002)(305945005)(316002)(65956001)(16576012)(66066001)(65806001)(2870700001)(93886005)(36756003)(6246003)(2906002)(31696002)(478600001)(97736004)(44832011)(4326008)(11346002)(486006)(8676002)(64126003)(86362001)(50466002)(67846002)(31686004)(5660300001)(53936002)(53546011)(229853002)(52116002)(52146003)(23676004)(186003)(54906003)(58126008)(110136005)(16526019)(47776003)(2486003)(76176011)(68736007)(77096007)(26005)(386003)(6666003)(106356001)(65826007)(3846002)(6116002)(105586002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2682;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgyOzIzOnVBaXhRelIvK2dEYThvckpuajZLaGg0ZDZK?=
 =?utf-8?B?YmhIZU1Nc1I4Z1dUeGVBZGwyblNIRStkZWIwLzZad1VBanBEUmdVNSs3Um9U?=
 =?utf-8?B?OFlLUzZ1dDZIemxWdWJDRnlQTFViVnJOZWhiT1BvdTRXODIzUDJtSENPQmhH?=
 =?utf-8?B?OGZXN3VHSzJTbHJlYm9uTEwrd09QdDhWYzVaakhQMzNoMThwR1cxSUVrdjI5?=
 =?utf-8?B?dDdvbUtEQ1pObm9hZ242ZDdVcENiYnZ1a3pYTmFId3dBUmt3cWJCMk42cFE1?=
 =?utf-8?B?TmlLYnJxZlZMNS9yeHUyNWFoQWo4akdEZ1EyVlhvK3ZnK25IMGVWdFNKb1BK?=
 =?utf-8?B?c253M1BlNEgxQjM1VVVLU3hKMTk0ejREV3JNWWFTYm1GU3pSNzJsVURpQnAv?=
 =?utf-8?B?MlFSSGJhMkp0OWtIRmUwUzUwYVp3MDgwczNNN05hbFFFRUhOdHFrcEVkQ0Vp?=
 =?utf-8?B?cW80NTNFdS9aYkduLzkyVVJUL3hoOW9zbUtxSnl6bzJYb1BRR0hZM3JXbGRy?=
 =?utf-8?B?RlV2aFMxamlMT2V4SFA1NnZhZytsdlg0eEtNYk5vMHBVa0RIbUVwRjMrMWJP?=
 =?utf-8?B?V0tLdloyNnVXSytlWkdzNENBVUlWWnNja1ZUVmN4d3diNXlFRlIwampOdjZv?=
 =?utf-8?B?WXVrVXQ4UGxKWDFpc3FxaFlDa29xVFhmSDMwRm5NZUJNL2FuS2x5VXB5Z2Zi?=
 =?utf-8?B?cDFkU0VGeHJBMzRLSWV1Um5lQlpadzN6UzVsOHJwZnd6OXN5THV3ZmV0YzAy?=
 =?utf-8?B?d3dvRUtaU1VoYWp0SkFwa0VzamZabTgvek9YR004aEVqMCtRY015cnZ2d3c1?=
 =?utf-8?B?dUh0eVVGS205RzJOaFpUZFVkNnZEdlgvQWV6c1JQZXBhLzZ4eW1uME5KaHBN?=
 =?utf-8?B?eElwMXBWeHpjRVlVTXd3Wi93QlZFZDk5dzdqbjdFMlpyOFc1Mks4QkRvK29s?=
 =?utf-8?B?ZUxkeXRjQ0lubzNUY08xRWN0YmQ1d1AvZTZxZU9keHNMTCtzNXBEZkdvWWY3?=
 =?utf-8?B?REl2VWpjdEFiSDZDR29rc2QwWjkwK0hRdVRHWmhIZFU1emhRK0orSFRXWjBE?=
 =?utf-8?B?OE5DSkxsVVFua3NCVGtqVWhSR0RJVkt2bktqU2U2SXp0Z0J1WFlQZGl1UXZt?=
 =?utf-8?B?MDFhQkRWZjd1VEVmVlZJZjdhMUliOGprM2FNVnpwUm1iNE55V2tsazEyL05I?=
 =?utf-8?B?T0hDWnR6ZkdLZWduckFPMjdEczF6TXA4SVNUdHltTHFLWFBkN3JjU3c2NWhY?=
 =?utf-8?B?SnY4Tll3R1ZxMldUdjl3WjhvYm5JeWxmUThGTXE1WEVZWmR5amM4ejVQRk0z?=
 =?utf-8?B?WTMxbUVzbmlFSGlJam83V21qL0ZNazZTbUxmYThYM1MvRFVjU1M0Tlp2cTNs?=
 =?utf-8?B?M0ovdXZWd3AvYWtqRjJ3blVHMWNsVENreEZyWi9TUkVySUdtQnpHejJnQzg2?=
 =?utf-8?B?aDNzRlNQVWhCcWw4UkhNZGc4NUlCOE9JaFE0UW9UR25EWTIreDNWd05VK3RL?=
 =?utf-8?B?VkZodWZscUxTMHd6cmhQQVNaM1Rtd0hWRWVQUDE4Mk9oODVSV2tvazUrdnE3?=
 =?utf-8?B?S3lDbkp0MHhnZEw4V1hPdm9xaDVpdFprVkR4OTVuMTRRaGc2Tk50TUw1Q1A5?=
 =?utf-8?B?SVBqRlBBQm5KSzJUVkdUcWd1Nk9SV1A1WkhNeGpqaWkrMURQUm1JRFhHMUZh?=
 =?utf-8?B?Sk40TUlvSisxQnUrKzRnU3pnRjZYV1Q3QkVZUktFdlc0QUNQcW10K3hUT3c5?=
 =?utf-8?B?bWRTTkhFZ01Wa1I5U0N5aStRcEFZVXg0ME1HK0VQZHMvckFFTnlFWHRzVGpU?=
 =?utf-8?B?SWw2OGR4UWZlbjlQUEdueEUwcVBhdDdnVGZlRUpyMXJCZ1FOcVpFNTlacHUy?=
 =?utf-8?B?ZTdrdnQ1R09JMEpVU2FsUnlSUmU3aERMdVpwZGdLbmp4N0x1bVJmaDE3Uk10?=
 =?utf-8?B?S0I1Ly9keGN4NmZwREhsKzdqbE81MTBiYjAwQ29KWWVvNzJ2NDdveDF2dWFs?=
 =?utf-8?B?VWxQcXBlOUpvQktHN0VqcnR0MGY3OFBlNDdydz09?=
X-Microsoft-Antispam-Message-Info: 6sAmyzC/lpP380tpnjz/Z5PBILaM34RKf84Lk9N2nLWr4wFxbFskjBeBYOMJVt7rBsyeairP0RErB5nZF+YPrO8A2LiHiA8IWjZELRAqHvOyN11j2/Mfle6lMNFi+0Nq1TOISa0Z+XC3ta4rIkHY7pDAUSayIXT2pKNpIbvz6kwNaMqauDUbuQ/o9cWCc1rRM7euapnt7qy6nKAvh4J3xC088eMNZN+R42xEJbB4Ff38+s5Hfqf55FZEcfvhIQ+l87GZS8cyVu1a9ebCtl05CfrNQKhI4IB3CT4GM1ROgC27ae2DQFAcNx0/IfJAsNMd+NPE4Iymyr13FuPT6huvLfsr56Akyv1CmEe0yb4yAr8=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;6:I2QJmy9OP4RWlyIRL8oc4q2x7MD3MGvczv2zs2D62yPaKBXc8r1ZHzkQ00iSoTD1YZ5BHkFMs0RrDqEz9BcwSdyZMfybRjE32fBuVwuYRVT0p90kbn3+tGBLBXwk7qNpF5AJ4/kMU6VCCHDCDTQUmp/0HCgo02nfFg/ILBYn1uHvHhInwTPaoYUl8vWiDfQ3cv9XGt+US18R8jqy9HQK+xKYcQwAlXlo5tmk3r2VXAuHqc580zMX1CJoZ4HYhhg16MQ5cIb9RfJPgpDX9Y6sfov/pQd7/4SgfAmsBNmn5LS1HrPH2JgTCjE4xjCUVz3YNwQpM0xxDg9WQLycWLLg0TxkFjx3kLN8Ibzgi7yVZQYgEL7Fk1d8FsR7tOKIP8ZsxPb5Fgx87eBZ8xruHDbmfh3hg41wHLUBN6RfZD+Lg+vhmYDJXfuFVEq4WM1ZzfaM61qh797vtpGi8kNkbhd7Jw==;5:Mc4b2yCh20lQqNzDLISx896d3ZHDWQYeTaAdyUD1iCg1FRK1gPnm+sf3FG921j+RVU06VCiMFNuE2jTiuC7SC9ti/0vP2eylzw/MoKxg7/NfNb1UKPlFJWB5++ecOFYs0oTqmVDCbHoWGxP1slhHO51Au/vO0Ajyyb82dTROI1A=;7:eUFynTpzdT+VhJUC3vqdCgUVzHr2LbVVpw6w7/TDdVq9fHAAXDPlMlpVLALpmcekYQgHIjBwtINFFkY8/qy9fI1koN4triTwkCDNgsvkiGovYN5zZu87UW2iWFmA7e32HdaOeWcZRvlh0JdUC0JBPq5dEP1AfLQHTHckR0lkdE/r2OUq3/ByLY9g9G+w1Z8RcF3DhETSBUsvpZbzRIscDjz3qlvdc5RV9U5NYfLzErcQWZyMlZWooQhdo1PRjYNF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:+eNgC+YknOKtQOKe0ztm7vZreRSfGdkhKBR1mEDcoJmI+5betea1uhT+L33+iJ3jn91DDgRZ72jlOfyV5ZonXTqGbucI1f8aLyIiy8bwmUecCkTiIVT9L1NpyrivAWZ5J53Gs78qlEP/8KypdT4r3aRyV2LXxJMsazjCF6qUDcUFtwfYegdDgrgeExxVxfEAapwQfzYzZujQSFGynrscFeelbbPQFF/iMC6r+/8PIuPGkiqyn9f0qm4n955s9m/P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 15:10:12.6153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 057cfb55-8cd5-4785-0772-08d6172f8240
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2018 08:29 AM, Sean Christopherson wrote:
...

>>>> + */
>>>> +static struct pvclock_vsyscall_time_info
>>>> +			hv_clock_aux[NR_CPUS] __decrypted_aux;
>>> Hmm, so worst case that's 64 4K pages:
>>>
>>> (8192*32)/4096 = 64 4K pages.
>> We can minimize the worst case memory usage. The number of VCPUs
>> supported by KVM maybe less than NR_CPUS. e.g Currently KVM_MAX_VCPUS is
>> set to 288
> 
> KVM_MAX_VCPUS is a property of the host, whereas this code runs in the
> guest, e.g. KVM_MAX_VCPUS could be 2048 in the host for all we know.
> 


IIRC, during guest creation time qemu will check the host supported
VCPUS count. If count is greater than KVM_MAX_VCPUS then it will
fail to launch guest (or fail to hot plug vcpus). In other words, the
number of vcpus in a KVM guest will never to > KVM_MAX_VCPUS.

Am I missing something ?

