Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7A8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D460920870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KEdAoWsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D460920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeIJVJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:09:06 -0400
Received: from mail-sn1nam01on0087.outbound.protection.outlook.com ([104.47.32.87]:14011
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728126AbeIJVJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4OEcxC7IznMw38oDRsoYIsZNU33z2Pux3h2qDix33g=;
 b=KEdAoWsIWK9BP1n6TNmGM1Gwf+XUDfbYJysT5bOkKIFQYi2j2YNIxByeLEjWhzzHInGTuADTB5s34kwiPNNTRgO6BsznU+HA5g15Mz6JJEJ7DaJyAkup5lG+y661zxqmzXst3TcFWnheTYy2pWh4nG5vms3so1wFUc6CtKW2WC8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Mon, 10 Sep 2018 16:14:13 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Borislav Petkov <bp@suse.de>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
 <20180910122727.GE21815@zn.tnic>
 <026d5ca5-7b77-de6c-477e-ff39f0291ac0@amd.com>
 <20180910155329.GB20286@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <564fd92f-04b5-d28c-03a3-59d11ab4c6cd@amd.com>
Date:   Mon, 10 Sep 2018 11:14:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910155329.GB20286@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0065.namprd05.prod.outlook.com
 (2603:10b6:803:41::42) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0b55a13-b09a-4aab-eebb-08d61738734f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;3:nVqWTG3lg3vyuTnLtAs0K5UvAZHTv4ha52rPKJYoxWIK8OjgbdOb7jp7eLK+nQui2Kp+Gtgioytsl2UWRQQXNWW8D6rNlwFqqSoC/3KJLCiJRiLzpXzxjiPtuN6pO/Im1ZGfFA2pXnIlfTL4tCvM/0spRr5llyfEB7jAOMcMztAbBNsdSweTWEwRh1o5PfKKr6z3F3oprmqxmbBfVnVJTA3+Nxp/WVLMIDJALMio/1ZSEAoIhxWKIBDaWWVrNzwH;25:FIc1LxvT2WQEWOHiNccXPhqwkLpTl3En2DTkghJZggUJLBUKQnn/chaVOvF5V0NrH0RGKoJutff4WewjNgjPxYsKppaoBBKNTneLkHvkPhmcw07uDYeaEyQE22NEcIh/j2gqHT7wEH0yM5fYPEBnM8b5nzUFyQ2NeYwQ463SkalgswrMlQ2hWWmAKhBML9FuGqzxF/cKmj19ECcW4+y/Ld12A/jCWNHF+giqyJ+RA+oYL9a0sdbejHU8+HsqRjC6FnhGrcFUbJT3rTYvEm0ZLfzBaUefuN0Cnhg4mhEdtAQF3ciDX7/6xbWpNwBGpniMV8FCgk2WsJf5KAUOMHm6bw==;31:0khRoPaSAYWsY+3pyEuThxkq7a++Jm4hqcr0joPRR1hMsvCLGiZdwhjMJDrQeoZRbWfclZqxdin7xO+8tc1K7IZmrowux0ZELOTmqHxR2rgXbQvuHwhW4IIgorFQ1/nUE9QxIRFjDk4dHX8XEYFr6qvPSDCWlvwPc5uoR+a5grn8I7w+9/qWlj6K4sadyx96pkeLP1nuyXLLtyRxDp4VDubDwDPerVF5HL2Z4/B1ZHk=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:fwkES5IrolUooeXq/UsYNuzHFXXhYOR9ogg9QE5396+ERZzCQzZ2MH+IZEO+JAYIFaxYdxH4Ms1/6zN9F2twvnydZGfFsig4LFDVORboXjoCH43YluC76Ja6fpcVC1lsMsFgXhlg/SDnuvhYzrbOR4hpA43a5a9i5SdwbLKCv1e3CGgeMsmJp4REeIxPza5XJa3JQhUy/SQIqO/WJWld0ZIHX2aDpVnYA2ajmkcBOgTM36ARp/BYJjGhaXKwOecU/fpU8P4mIjBH0wW2iB71veJdTBw2WDthTmRDUME0XQKe4It6kr1PXW3PwnlVn1+3SPXhOhJbO1fXO7SXjp42+bgVprcnUvanLTlT86qhoswOO9sojsHZT/RhxOz+Xlh3wVXdqai4gtKWABf8YZUsKlL0Vgv5nwG8h7o06ThIT8T5DrWlV+/N53py1TwardLobTjmWT/vrtj0KgoAwAlYQbWJ3yZ+v6rZRcdRtH+oCISsPg44EkmmEGGXSR+0qgIL;4:AucvkVOAeDQCL+1ygE6Hl/y2C1VATl99zkck++8vS/X2Xn+oGtzrMOqdzszZlUZVS7XWWhs9PcJfwHRbS4eInd6/LrvUacG8zkmhoXZl5hgfTOsBpaKL7C1Mafr/rxpYNyE8BCm8TUzEVp0mrB4o9pWQ7i+0pUZbEer55j04/58Tw+Ld4PDiqmSiiBnjJgZqZw6fszf+OKbKtaiL9cEpgU3Qs1xT26dNWgnWzkIgxyC0w1B/3zyrs3aLretp++kXte7A6YA8P36rpCwjGiPA5g==
X-Microsoft-Antispam-PRVS: <DM6PR12MB2682094B7633CCFCFDE41D72E5050@DM6PR12MB2682.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DM6PR12MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2682;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(57704003)(25786009)(446003)(81166006)(956004)(8936002)(2616005)(81156014)(476003)(7736002)(305945005)(65956001)(16576012)(316002)(65806001)(66066001)(93886005)(36756003)(6246003)(2906002)(31696002)(478600001)(97736004)(44832011)(4326008)(11346002)(486006)(8676002)(64126003)(86362001)(50466002)(31686004)(5660300001)(53936002)(53546011)(229853002)(67846002)(52116002)(186003)(52146003)(23676004)(16526019)(58126008)(54906003)(47776003)(2486003)(76176011)(68736007)(77096007)(26005)(230700001)(386003)(6916009)(65826007)(106356001)(3846002)(6116002)(105586002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2682;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgyOzIzOjZGcExCVUl2U1BKRUpJTU4zVzJFaFZmc2VQ?=
 =?utf-8?B?ZW5renZUSHJiZkpYanJEa2VKWGtDNjZXR0RxNlBkWkRTS3JBVFhqeTJ5b0Vr?=
 =?utf-8?B?a2NmZTlqS1E3ZDUyTjB3SEtDY05wUWlsc0dMNTFyUjN3WXcraGtodExGUTRB?=
 =?utf-8?B?cjNtdkN3R1lyZ0ZJUFlyK2Q4dzdtQ092cDVmSG9KWGxnM2trc0V3amNDT3Fa?=
 =?utf-8?B?b3E5NldySXBkMHR1RlJxYm9YQlpmQlB2Q1g2d0NRTjM0OGFacDNxUzJXOGVs?=
 =?utf-8?B?OHlzREJ2Z1hLcUxzbXY3NGJRY2xNR2phYnJIYi9SVU81VDJWTDdpaXF6dTJG?=
 =?utf-8?B?Q2pmZVFxdjJwbnhjN0syYjZ4dUVBdVBDdk9RR2xydEx0SlQ3VnZ0Z004dUt2?=
 =?utf-8?B?SHV4dExxNzFiMTVJUjBpMGFHRTAwTXBkY01jWm9jZXVGb2l2UDE0N1d4UGhF?=
 =?utf-8?B?QXdwNXFXMEJ6cThKcW5PQVJ4SGF0WUpvSmMyRE53T3RaY2MyeFZjNTBBMnBK?=
 =?utf-8?B?UUpYQk1zM1VXU2xySmE0UEMzR0tzbWNjWXZGWVpKaXUvY1NXUXhWVDVKYmlp?=
 =?utf-8?B?bEhTdTE0YTFYTnlpdlo4WG9PTjZ0OUNOZUNVaTd2L1crZmhFUnQzR0JWTkF1?=
 =?utf-8?B?TldTU084Z2M0ZzZSZHJyZGtQMHpkK2xGcGV0ejRSRjBYMWJoMmkwWW1wMWVl?=
 =?utf-8?B?RWpjMlM5eGNjVmJoTG5UbE5FSzJ3UjI2RWE0c1hDbVE0TjZCRkx6ZEM5YjVN?=
 =?utf-8?B?MjlDdHFLcGpndXVRV2VYWFhoMXR5OGZGeXZDbnFOckt2clhlU2gramR3VmpP?=
 =?utf-8?B?Mm1INjh4ZnNBaExJU3QzMHRHTGx4NmJJa3RUZGJaVEhmbnBEbUJ2ejhPYXJZ?=
 =?utf-8?B?M28vQzM5SUxXUVFpK3B2VjZDZnpTcjBacTliMlR5RkNXMStURXp5ZkExTXlO?=
 =?utf-8?B?ZkQ0NXFUdDBwdnFnNm9GYWY1SFNVVlZZL1JKbkFLZnhOWGdiUmY0cHFSOGNi?=
 =?utf-8?B?QW4zb3BrZ1dQbW0yUEZZY0RmRjlqZXFZR1g0RE84NWZJYWtHS205amdXY20z?=
 =?utf-8?B?WnRqK3liTGd3TWpDZkR2eTIrU0lNZ1U1MlBsd3gvRVdSZTE0bXZlRU9nSjFm?=
 =?utf-8?B?QW9PUkFoaUEwN2Q5Sm5pRlRJc0FaVU1mcU9GSGJaMmtPRmc5RFpnV2dWbVZw?=
 =?utf-8?B?OThycEZHT0h2Ly9uWndJSXBNQUt3VDVOaElUbXdodmhYQ0MvQnpCKzZsZVZv?=
 =?utf-8?B?ekUxdzk2VWkvWGNZL2k3dGxOaHUxRWRTVVRvUWljSEFWY2VTSDNsSmZkcEhi?=
 =?utf-8?B?VnpDZlFqemFWcVdCcVVIMG9lUDJCYlE2eDhlc0NsOEZlU05IdUU1T00yMVRj?=
 =?utf-8?B?c2lBVk80WHFOSmF3RjJ5dEl6eWduVU9mQVRRKzR1dzVKVC9NUkdZRmtWQ1hI?=
 =?utf-8?B?UGs5OFJtWDl0eWtSLzBGR01Bc2hCY1g3Y1RLcmpWVWlkS0FNcXovUGpUenZI?=
 =?utf-8?B?SE1XSGVwVUE1RTk5UjJKUG13T0JlNTgrY1o4U1JIVTdMdmhVVVBvU29UeTZu?=
 =?utf-8?B?dkxTb1NMVnVPOWdXUk1qWi9NNXZlN1dTd0dkSXBZeW5aQjZwUDd5aFB6UElq?=
 =?utf-8?B?cjR6dE9yMlN0ekdTNHJpaWVoaDQ5a0ZxUkVmNzNmQUhRTmZTUVNqNGdIOTFS?=
 =?utf-8?B?citpak4waldwbUV0WnZqYmt1MFc1VmM2dDFWZVgraGZiZkN6M2lLMk83aENr?=
 =?utf-8?B?dlFvUTBqY2hKcjR6WXVnRFYyOHR6K2l5aGhsbTZ1dU9MSUp2Wko3eUtIWWNt?=
 =?utf-8?B?M0ErZWtDbDg2TFMwT0Vxb2w2eE5FN1JTSWNtcExPRFRnL3FZdzRqVGhyRlFN?=
 =?utf-8?B?Ulg2K0N4RGo1Y3JLQ1RjNWpkUU5TbUJnQndzUEtCeXhxQ29uTXNERS9nV0sw?=
 =?utf-8?B?eWR5eXFkSzNyWGJmQWpkTVNKNlNRQWtZbk54d0FEdFNZVzFONXhsdjQ5Qnpo?=
 =?utf-8?B?OTdDeTJVL3NVd0JEWkZ4WlM4NVVvYkdyWGlSZz09?=
X-Microsoft-Antispam-Message-Info: 0PZYBdz5Eu4cRyO51VCxziioC9N7mi2JHI2BYVVWzi75kZPjscshqdyLCOk7KlwGuWA/X5oXHgZrtxk5hpwyLTWp7Zg+VNEpohQM8iVCyU4pT9nISLJ2e9Bt0f3NqPWHVELecwPHja9XgwRIpw9VnafKfbc+T1pAe0f5qioDqpSYxxeD0IJ9DCJcQ/sXu3amgQzESQEJNXQUJetykyeTN2wvXt7cmWTR3vkcItXFw1sGAaFVEeMby+8zjKuULhYRwVr9WGyvbSDZxSURDwbawojNohUGfE5C4WX+7dIFHdumo7BWrDoLPC1vx1qCnOb5cTnsftwsu30kHQzPQ2o366CUHccPrMj2JM0IJUQ8VGk=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;6:bj71Qoavs6yaOfGKX2MQrhe6XJoyx5jg2MDTeTQenJsSKKwbwR8BEdOhf4pMDcl60UFqGCOYpXNpdFLvDSDxZhAv51BDMfMr52pde72bkRKX6SaBnWASEtgAo1nNro79rj0HZLpZ/sYoVNarZSBjizd4NornCsTeNfyJDOM9xcKvENeedJMOSO2JJ97WVJZwKc1W9e2h6yVg6oydSibuYkXJ9lyreQzMkqh9j2AouK5b+xhshwD2y/DYq6V6AyNIws64q55qHeEv9PrOWo+z8POAl6MsFMDPELDdT7JcHuEsUNU8cd+9r0SuU7XfTzOi3upGM3CcVpukYkEkWkjruhuLU4n0xAisB2Clbr/r9VA+t84L9JMmUewoFhkS0/a+vHnO/od9tmR6FC/+AKIRspCusRUbgSH6SLeae1ep70JJ/5yCNU/3qSJxKjYJjkv64lKGMK7z78NyQeT+/Sg0Yw==;5:hAb4OT/RokAfYce3Gm0wKGoNKcTSAc90NMgtYhNot9vbcokcGhmfHmvJNf55hUYG3NaEmDzhSu9ALZspWIb9sHQqCPC5NkKpl7Gbehd0IgTfbhCmQTh9cMUA1z5keuNuYw1aBmVkbjS6kF+JKLQqU6y76/mL/GMi/dhTE37BMgQ=;7:DgkXKrL2+DaMJYMB+uAFUV+Co188r1AhSfvy4dZD2tSW3WnmKop6aYEWpjM5k3icGVYNsKLYublD/48AgYIlgqVrw48QD2NjlhnMODWF6+IrXrsCYbzx/W+ww9Ap2H8CneFwHCv6pdCg+UhyuiHgygkzKEbP3/RdIPdSNq5q61t/njqOhlTJuOFGlxm4dPFqGcRBNmXwOeXSJlch5o0X7GADmYo36F4+O7CpVsesGTBjoenuINfQFZgMX2ctujw6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:m9HHX/s61+EDIzFXczu6EWTGKdL/sS4JTfH268wRliv2uHRvORduShDr00IzGRWziTJFJpUoDPPcbju7yYj1DeQ59rTsAza6XN2RBzzCpURM/nlNIQV/lddxdAJBW6mjxJ+pgNeIcUaH8gne0SFvMbkPJONKqcl3emuLvyu9guDqrYhogwRBGB5VwEzNVxu/G8u/nc0tep07C6hkg0+gHbXS8RKxPVJDOdEh8cZIzHyxZmA/mYU8InEkxJgy5hLp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 16:14:13.3365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b55a13-b09a-4aab-eebb-08d61738734f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2018 10:53 AM, Borislav Petkov wrote:
> On Mon, Sep 10, 2018 at 08:15:38AM -0500, Brijesh Singh wrote:
>>> Now, the real question from all this SNAFU is, why can't all those point
>>> to a single struct pvclock_vsyscall_time_info and all CPUs read a single
>>> thing? Why do they have to be per-CPU and thus waste so much memory?
> 
> You forgot to answer to the real question - why do we need those things
> to be perCPU and why can't we use a single instance to share with *all*
> CPUs?
> 
> Because if we can, then we're golden!
> 


I did not forgot to answer it. Maybe Paolo or someone more knowledgeable
in that area of code can comment why those are perCpu.

-Brijesh
