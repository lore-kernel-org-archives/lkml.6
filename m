Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27ADC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A24E2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hru27uom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A24E2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeIEWlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:41:19 -0400
Received: from mail-cys01nam02on0082.outbound.protection.outlook.com ([104.47.37.82]:61600
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbeIEWlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vnqLZ/O2VbgQeJfYjyWqQXtzg8d7TCdxFYOo86cT/c=;
 b=Hru27uomSUCfY177O0y6kRoSYL6aDuzqE6brJrkPaHJlk5W0iIKu8eCDIRj8tMdWCvzSfPqIs3USJ056z2+Q6EHIIS0b0FL1YVK9ReeFGnCQHcdAJOuYGxE6xDoaSL7JPPNIHOhTGLpl2wzyZmWvgf8pGo8IVWF+1uKZSpQaM6o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:69::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Wed, 5 Sep 2018 18:09:49 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v4 4/4] x86/kvm: use __decrypted attribute in shared
 variables
To:     Sean Christopherson <sean.j.christopherson@intel.com>
References: <1536024582-25700-1-git-send-email-brijesh.singh@amd.com>
 <1536024582-25700-5-git-send-email-brijesh.singh@amd.com>
 <20180904223200.GA7248@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <7b004581-dfb0-1418-1252-0860e5e93cd0@amd.com>
Date:   Wed, 5 Sep 2018 13:09:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904223200.GA7248@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN2PR01CA0001.prod.exchangelabs.com (2603:10b6:804:2::11)
 To BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:69::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 600fe379-ab0c-41cb-d5fb-08d6135ac570
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2680;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;3:XraFevcwk4GiMN/1CnUQZ7ldo15pOhU1WogHFcQH3e8yc/mz1U2JgCZasAw+tgcI4H+B274bOdFJwBPpy5IEDXxEK+v+r34SS6E46ZuAqARWeZwmELBMg2lo1OYpa0BDsMSvNlZSRGa+X5eYAO5js9aqBPBRU6HEpyhdwuU4+uTu5qe2yIasrfJNZ4t9hIj3TBDiylYaHcyLMOWIipHAOv3NnwItjQQGaNaWQkZn1PWtaVDVnbyWBrcVuoeoMV8X;25:RybXMs7CcDKkUS4LUipkKO9g4S6dHEp6S3zJG9pRy+JVOt6wczVHP2T/wl9y2J3BT9y8PYUBt5BeGbGBoQwzpGXU3H3iZJZoIYRx6nSGTl1Bj00IGie/oyQ15gIJvdVxCBPX/ByG9EGW8Vpj0dlCsW0dS3u57IIInsMA5sAt+jNAy5uDgLVTYVlFI85k52InAB3dkvHty1WU75rdbSWChDqfYeVCGueD7NjoamtgCU42n8UxRV8+F8o55ieBkrVRjp5Px6ndFEXqpUozsuSXp46HtllmePJVgFQeoydUrRm2qhiAPzpM2Z3PEugVm5mfMNKlR++r9cLGWq8gdusOsA==;31:dLZ6abrDX63JI8IdZb30q0XfmyB/iKx0ion4qM1Zsz6O5lvuDhODlZXsqmUdryUaZgzMNZxOEVwN1Zu4NV81G8RgT3NoGINHCXfOiBatoVO352n1GQHEU8WJGbplW1D2tuqlghgQdG8DqxFmD22/ExCM44UuOxWeH1WRKZTKv/VPIB9dp1yDemFD2k1t+xKasSkVVTPidj++fYovltFC3JyOgnVJyeYzAXZ64E/umW0=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:1ZOgcd7cL4fqsB6PblhAJDExolmAusXpJA58EC+vlv3gbmOAtenJPcEd8FzL9k9GbPlGUXagbi6NhTtbwy+ggsYIAB2RMnbarxO6FUTqj+kCN18NyQki0dC2A2ljOu114VUuozl/dducAZbOz+B00UZ1AKesnKN0To4V5hLWLYA/4kZoa+FABK3yWcITA//oZ5o8dJRTEu1cYnI6mPb/n5lPyoIzYwysuceRpHE3oLh/IzK4Q8T34kNgkhAIK+4xMHHt00/pTWBtugIuJmpDqj5jJJLd11z6ROzc66b8Cjm9BqPieeJIHf2j4t7Y/NIT/adHtNIwO4kU2bV5BxJE3H6fYrMdxy11DbHe98OUfEYvjP42uFRwcKlKqoffcXp4q0a7r8n0/8ruXtKq6UFYIe/VP/uEHWgq4IeGNG99p1y92zmZ+BS+7XAiG6KoWiVsjPHsjNkCdB1tdtHudQvR7Lz3hkwP2/ZCO6py4nkuG5elGM65G143Qt+RSFDaxewQ;4:JY/APAmB3IsqX0RB2RdDGtaPsVL0mQ0rbWrLxxAXM0z4MSc7CtQGHrP9VBFuqOlCbH3RTgcqpVr7Kg3MOjF2yys9403c5bIZixUKHwVpDipliIVs3PpWSdYz3C1IPtdDTb/M3MlYj89JU+kYIYgUYOB0RHmSQY6n/AXJnCOSDSr3CgtvZ32VaHM+6Bi2PqvGz731BA2sPF7BCLQOOSx0iGVPmWeEkHCd6V7P5vSUSvFvcAEO67Ms0EspJz4u5KYAi3qsmStAo+FRytBiibjvSA==
X-Microsoft-Antispam-PRVS: <BYAPR12MB26808C8C7B2C640A862CA867E5020@BYAPR12MB2680.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR12MB2680;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2680;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(476003)(2616005)(956004)(305945005)(44832011)(229853002)(6666003)(11346002)(8936002)(7736002)(446003)(486006)(6486002)(77096007)(65956001)(26005)(16526019)(53546011)(65826007)(65806001)(47776003)(478600001)(66066001)(186003)(8676002)(67846002)(386003)(53936002)(31696002)(76176011)(52116002)(52146003)(2486003)(23676004)(86362001)(50466002)(64126003)(36756003)(58126008)(16576012)(54906003)(2906002)(25786009)(106356001)(105586002)(97736004)(5660300001)(68736007)(81156014)(6246003)(316002)(3846002)(230700001)(4326008)(6916009)(81166006)(31686004)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2680;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjgwOzIzOkpmYlE0NTJtYnhoc0tZTkxwUWYxS2l5bkha?=
 =?utf-8?B?ZkRFNmdVNEZmS2ltM0N4aHBPSUhBU1VUaXFiL2F1WDFMd0ZZYjVnU3B4T1VP?=
 =?utf-8?B?UXgxR0NTYUdTeUROZVVkZllsMlRZL2NZN1FualUvM3NSMWgzMGxmZnRuVWFv?=
 =?utf-8?B?TmQxL2pCbEw2OW8yS0tQOCtWbXBCeXBLU0hZMWYyWUFmUEhoU0RObEdVS2Z6?=
 =?utf-8?B?KzRxRFFMWGxCRXBhQksvdjhFUEIvVDlSYVBrZk9TR00yQnNGelpPYndYZnFw?=
 =?utf-8?B?RklCemdsTFgzRWtxcWNxZEV2YWpuSllMbGllb3dVcXpHOWJTdC8vTVdabGta?=
 =?utf-8?B?SXBJcWxIUitYdWF1Z0h0YnJXdk15RWFpb0hHNXREVHZDOFhwQjhGZVNMVnFn?=
 =?utf-8?B?dEVvL29nQk1PU292NkVLLzMyQyswVm5DQmtoTWZ3V1ZKY0Voc0RSWDZWQ1Jp?=
 =?utf-8?B?Umd0RVAydkFOWU9vNjFwV0tjRWQwZ0tiUzg2RjdGa0NmMHFsaG5BNTBPdlRh?=
 =?utf-8?B?ZDJDamp3TTBqSnJBVFJwbXlWeEJRU01aYUZ4RzJKNTJkQ3ZpbjN4SEd1ZnA5?=
 =?utf-8?B?WCtaa2JQSVNISTFyUytsV3NaUXdVNWs5aHdMSzBGRVY3RmlwNXd1OTh4d1R2?=
 =?utf-8?B?aWwrL2FhWDRkNXRXaHhobDFjcnBVYy9mOWY1V2x1ZFl2K3Uyb1FkNE0wRS9s?=
 =?utf-8?B?Ulo0QXExaUU4N0pLa09IOXB2Y3ZqM2xVajJmT2F3SWQ0T0pqeU9NMWhhMFg5?=
 =?utf-8?B?U2VqWGpvRFdYTDlodmtBMEpoenFlUTdGN3RrZGZKSHp6VzFsSzNPeGN2OHcr?=
 =?utf-8?B?ZnlUWEQ1Vi9jS2hEOTZyZWwrZjh3U1ZnZXBtUm54NG1yYkFmdS8xUDRycHNp?=
 =?utf-8?B?T1JiSHhNSGw4ZGNpVU1Nb1lndk8xRU5nZ2lTVWIzMDhvamNqcDBpSFdXNktG?=
 =?utf-8?B?aFhtVDFTMlZHT29xaDJHOHhZZDMyTXlHSFBKdW1pT3RYaXJpbWswRkhJb3hT?=
 =?utf-8?B?c1FHRXdNMWxBb0VFV2lDUHE5cDBlSGV5VSs1bGNBSlBYUGgvL29qYmVPS0Ez?=
 =?utf-8?B?TWR5RUZYb2V3bDFURlcxOWNLQXNTTmFSN3p1K0ovSkZCdFNiT1FYVk1kUTZw?=
 =?utf-8?B?UWsrOXpHd0xveVMxd2hmWlpKMzk2VUkzYzl6eVBjNjJ6WUR0S0NLaC9CV1Rk?=
 =?utf-8?B?MjVZVWtidHdRcFJtTDdCQnl2Z2xxcU5sSnQ2NCtqeklFeVEyUEtmQkExOXli?=
 =?utf-8?B?eVFHNjhJRzNVWWRJNDQ4WEtYZmVtdFR3TGdpZUp4VXhXRDNuSmNhTjVCc0x3?=
 =?utf-8?B?aldqUmlMa2p2Vk1wN0psVkJLWTlSUXo5VWJrcW4rTzF6WFBJVnJTQXFWek5P?=
 =?utf-8?B?WGRkYVlTT0lWdFZnUVpXTmtXdXAzUXpqM0RrWDh2cUdjdXU5OFJrL3FtUlgx?=
 =?utf-8?B?anU3cFJINmxsVXptd3c1c1ZwU1lNMU10Qk14dnBHMWVabVE4ZWlEWGt4eC9k?=
 =?utf-8?B?QjBBa2NHR01xekhQN0VJU2NtK1dxeG5tYVJMcHhxYVFFc3hyT1pXUktBc3h2?=
 =?utf-8?B?dXlZdVpiYXRRVGZyYThVcWg4UUEwZHExYjQvaHFDaGYvZWp6OXppM2haOE5w?=
 =?utf-8?B?RW1YQUNlckhxd0Fka1p0M0d6eXRqcTQxOTZiRG1FRWdMMDdIZWxhTFBrN0Q5?=
 =?utf-8?B?Z0twTVJYbGFtN3dnVkR6ZzY3M1cxVjYvcWNtZ2V2NkVGRXBsR0NucXI2WFkr?=
 =?utf-8?B?NzRPMVJuQnBqME1VTXJpeHBoZHB6dlowZjZuTU03akx1cHRMVkVwbXpYenZE?=
 =?utf-8?B?ZjRVTUJXR1RxK0pIQzRjNnA0OFVUdWNMckRCRDRUMnYycnM3SFFmUk5SemRu?=
 =?utf-8?B?Tk5KNjB2ODNvanArem5SdEdSZzRvMVlBVjM3cEJjMEwydk4vV2pNdStRckxY?=
 =?utf-8?B?VEJrd2pmTExxcUdOWk9LRDc4ckQxK1dmblF3WnFCYXZWaU1PUFkxODFRbWxy?=
 =?utf-8?Q?s8gmBx?=
X-Microsoft-Antispam-Message-Info: 2wyxLtsbyJ7E3sGOgzrVR/56GRp6jLSjJ5h0LS0q/x5/kMPF9EJAA9bv8odjE2DJBwFDEiGWVQXO8UGt8mZdqZuVTeoe6bcddmviQynLxgFKYNy0oGps8ERwv2cL16qTvhZeExxwh9KOhSwSRdKPFcBpKjIBW7RmAKulb2zFrBUz12zsIcpGGy3FxtDnws39Z/vSmZnsfduK4bO3FuWyvEve9cjyN5oshLSatw2hNGiXsdwSq2AAb+QfRHr9Zt1XN3dMgMszVTdBB7wjem8RmipFEejoF6QklbXf1VzCJRzlFo0W9lIHAbLF/KqSCs4gCc3M/lHV/7rU1kIf/tNyf6wxXDBJvByQhRUsk5nGSEk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;6:C2ZoUq39X3+MMgJjrBkyWx25IKBmkCH76p+qHhyCm7iW4ZrA87myAIOdmReEDkTZiZjQReo83m263ngE14OFJ1h1zig3hwA4gAVsI3UlRLGLN1q4cLcrZmXRz0oN7ctK1EBVtymbJN21VPsvAYzzwzH33KEqU+LGYolCPv+wHdzqzxSATc0fS725Sv2FbkuVZgWTWpbj72sVbn84sCKt+gU6zeEh0EEKroYRs2grJ2QK0YxGMoFItJPQpKz5DoexY4GvzLVxeG4YHzUtKs5qOl+kbBaK1pPsrh3+KQ/56aSTLtsY7cAs71s4S9DLMsNDcX7OUickv1W4gWQ2DtSKAlXHJJ61sQMpMk6wMAfU8HrNIJTySLDiKWLwsfXFG9S8eLduPlyRugqMxXsnh7mJ5lGAhH0CjrXpPgQIEFYzS6CQE84z8l+2HFSo+BQTNfwjKehBgxvsdLOXQKTz/cULFA==;5:6j+LqtlP4T4F7dEy5DZtwz8QA1+KtA3roT9wmBT3TWCI9Zz0WgWel2Tb4xcWiB2Z36iyabkqjEhK5TnvIdY+Uy3OP8IY/RtODf/WCpdtKMjH8hSHVkdt3jA+hRu5J1c39BxOq5Gp9qnVhtAlYw4oBowrp4iOsOZ44umPUuXU3WM=;7:dkh8aCkwfLY+2tlwCZtfO6AOU5VnC3fu9iqIM8wQ8amICI1xafPT9VTnCEb+2AI6mfNwpcLxPXIx35s4dco/QYb/8o0UDFtlZzW0RA54hHvBdvNw0U+nEz5frFEm2OERsoZloXYzOy4Pr/0CCnl8YDvrGHG0EDba6PsG9RvDSdqICKYtYAUem/QtvQyi3D12fUfywgMnCIaK8JyAt96rD6BaKAKkqotRngaVaBNQzHSWwLuSMn5WhAh0Q0XTakD0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:mWlOLM/Ua0NfNRHJSb2qbuHcItOl4d9K7j580czC1yUnT+iNSVolpwBk6DOpkpuxgiO3nPIvIWb2m0RXTf9A7/gnxqGfslRc4kH27SSHeB+khUPt9HmsA4/Zu4qBMj29eRFR0a9ZfwMBpfIetk+wjDsVXeVIief86V/Cb45VlHMyVvNH05KpMW1oNnBO+/d+maWa0zQswqwIyI020J/I9klagTdnAbW1Mc39RWRuULnqLaWf4/UgI+BHpGN9wxbt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 18:09:49.2159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600fe379-ab0c-41cb-d5fb-08d6135ac570
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,


On 09/04/2018 05:32 PM, Sean Christopherson wrote:

...

>>   
>>   	/* Use the static page for the first CPUs, allocate otherwise */
>> -	if (cpu < HVC_BOOT_ARRAY_SIZE)
>> +	if (cpu < HVC_BOOT_ARRAY_SIZE) {
>>   		p = &hv_clock_boot[cpu];
>> -	else
>> -		p = kzalloc(sizeof(*p), GFP_KERNEL);
>> +	} else {
>> +		int rc;
>> +		unsigned int sz = sizeof(*p);
>> +
>> +		if (sev_active())
>> +			sz = PAGE_ALIGN(sz);
> 
> Hmm, again we're wasting a fairly sizable amount of memory since each
> CPU is doing a separate 4k allocation.  What if we defined an auxilary
> array in __decrypted to be used for cpus > HVC_BOOT_ARRAY_SIZE when
> SEV is active?  struct pvclock_vsyscall_time_info is 32 bytes so we
> could handle the max of 8192 CPUs with 256kb of data (252kb if you
> subtract the pre-existing 4k page), i.e. the SEV case wouldn't need
> additional memory beyond the 2mb page that's reserved for __decrypted.
> The non-SEV case could do free_kernel_image_pages() on the unused
> array (which would need to be page sized) so it wouldn't waste memory.


Sure, we could use unused memory range from .data..decrypted section
for cpu > HVC_BOOT_ARRAY_SIZE when SEV is active. I will rework the
patch.

-Brijesh
